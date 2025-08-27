Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7017579F2
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 22:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756334306; cv=none; b=HsDjvhLB+PfMuysuQAJHKMIvbiGXzlJMwaCTK9wiqJWJR6v4uFLx5/4MSr8Su0rkX6z4rOJ5BcEWRHmSx1GCVl9H9+P99WtqzTbB+d6GhbOM1vEfGc+boaRPgivj2akrJ532sHEeDK37r5J/fiH1v2iLCY0cT41wLR7ZPjvoxAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756334306; c=relaxed/simple;
	bh=t1J3zSzROj7a1bBqZdx18V6aSQA4KnXa897EsoNlw9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFkmc1aX5cPCVSxZ+mJYiYK6hJOoaf6ZtpT1Ixk2nDK/bYxQnkyDcKY1gfw3C4FEtT2evNIFvEEXFJ2zS1Al76R0lkeslK+vNVXwUjfjp04PD6ghn/JkbVqQTMlEBrZL0MsT7JagMIYbn3CVMyXN8KxQn7FD0VjL/ptsDXvw00I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=Wvu31XT4; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="Wvu31XT4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1756334292; x=1756939092;
	i=oswald.buddenhagen@gmx.de;
	bh=t1J3zSzROj7a1bBqZdx18V6aSQA4KnXa897EsoNlw9Q=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Wvu31XT4gcPmhpAIiluAc0zorGpioPXmf+NBnx7MQp3l9QSyYs4VEIS3KaS3vlbo
	 j0R0JeBFGR4Cf9htZf6r7hQsegQFlvApXCGN8iY6bKjNqvVnGbKQuAMRDkZQWXd8u
	 QNXWdaaMGYbwR7Y3+E/Kwce2Uj5MEcOHpKG1z++fdhMZ/+VTnA9mZPJJXpGaedZe+
	 +KccL6JPofKFXcUikebvS/tUc0YV4nsaOqAPCyLpAwPwuV5YsS6t6Tc7TmjZ2cllo
	 mOi1rbn1pv5xRS62Sh/MmuD11jVWkK6X/Xs5jejPhvPAa15ib9hbmWkLkEWos+7Dn
	 5QkZOgdX4R058vSChw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.117]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5QF5-1uq1ry3DSX-002hAN; Thu, 28
 Aug 2025 00:38:11 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1urOmR-ink-00; Thu, 28 Aug 2025 00:38:11 +0200
Date: Thu, 28 Aug 2025 00:38:11 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 3/3] commit: print advice when core.commentString=auto
Message-ID: <aK-I04a0lI-R8IEv@ugly.lan>
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
 <cover.1753975294.git.phillip.wood@dunelm.org.uk>
 <0e7c08b15e5923ae03f5630a8286c7dcebdbcfb9.1753975294.git.phillip.wood@dunelm.org.uk>
 <aIzayan9nFZo4XYv@ugly>
 <af0c22b9-5034-4bbd-9cdd-f1f16d933e4d@gmail.com>
 <aK6_ivfXr7jIbBCz@ugly.lan>
 <xmqqfrdc3eiq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqfrdc3eiq.fsf@gitster.g>
X-Provags-ID: V03:K1:Nkbd8xAtvYNSz9Y3Gzn1kyEBVWd2yh4VqpmDMxBnhZYXettNO/N
 cJmIZ39f/pAAs8WhbJ0LsYBsZTkvT0CtQxTLObbHulnMdGHg0zhXX0A4QV229Udd4KmgVJ6
 FBq3+i3Vmk8iT+vtD4m/Q9EimbPxjs2ej/BHoDpuVSAFwapYB/Y0fye4CdUYMgGcMmgJ8bQ
 rXmOP/NYyuKqG/qEnhrLw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DzaXuSq4mS4=;h00aAjgX2DQs/BsrDO8AIaX7s5c
 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
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 09:39:25AM -0700, Junio C Hamano wrote:
>So your counter-proposal is just stop at saying (possibly a milder
>equivalent of) "nope, auto is no longer available. deal with it"?
>
yes.
though it should probably include "because it was found to have=20
fundamentally flawed semantics. re-check the manual for alternatives."=20
or something like that.

>Or does it go even stronger and not even special case "auto" that
>user sets (i.e. and start commented lines with "auto " prefix)?
>
no, silent failure would be counter-productive.

