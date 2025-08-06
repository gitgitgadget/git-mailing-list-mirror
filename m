Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EC87261C
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754483664; cv=none; b=t6VKQkwZSPMhR4rZML6wYBNlbPh3TOFxYBxvEUk23flqOWKxiD6KF1CebB/AsQPyTMeSEGzmYYH2aWLng+ayEhG7h06JgZTh9KiMZbPsx2NlwzLTq6WzQpQMx3fvvaqu6jtCWooZJeXEx0Ki8fcLdW3BHhKqCCuh8vCmqY+ONVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754483664; c=relaxed/simple;
	bh=wnENuF5SbXTpd2tlEGUoTKIFf/p9jNAxPdf0rsnmSYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvNXTNO0WJg/qfwMLuKjK2QPxeTah2PAQewAMH8veoJJ/KSqlLG1Mb/1wljfnV7Ixpy9z9kDmmpNytz0SSptRKCAKrr4G8zCYEmhL25WGSqixD2PZF5pi3hTcelM5cVFPzwUo5MJ17icO8GOaTz0JEC5zRjv0z1Kbb3bjm8cfTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=ZFV++I+T; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="ZFV++I+T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1754483654; x=1755088454;
	i=oswald.buddenhagen@gmx.de;
	bh=pcProLvJUR5kSGbxF325zfqkzegEZ9ZsXnyxSwQ8FuY=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZFV++I+TRRpoN5mtGcSmMqkg/jQ+THR6Nly6GTPx23PnfUk6WZ9xTKJW2JImJZ6a
	 1Cx0ZAxcSkFylqOIn1VbEB+nYNDMjsTku73ujKjldpPbk4Z99Z0IRIjtm3leksnkx
	 7u7nhNr7egVE7TKY5XoLVSoAVTV+rOUI2+0zO1DPV+CDcODH388btkproZOq8RLVz
	 3N4hRETCVkTw9MH30CXl7fog47ujLfKE37TPQ26feymKK/kDYCWG8n/k996eqimty
	 OAQX2RkDnu1ILi44sIp8r5tae8MgDHUOaoLKVPkD2NTMdgrqajMPIyLQWY9zGOGof
	 M6OLhWMgZm5+6RpIEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.122]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmGP-1v34wR1hVZ-00VKGo; Wed, 06
 Aug 2025 14:34:14 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1ujdLR-rAp-00; Wed, 06 Aug 2025 14:34:13 +0200
Date: Wed, 6 Aug 2025 14:34:13 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/10] commit-graph: fix type for some write options
Message-ID: <aJNLxfL5ElFAzNz9@ugly>
References: <20250806-b4-pks-commit-graph-wo-the-repository-v2-0-911bae638e61@pks.im>
 <20250806-b4-pks-commit-graph-wo-the-repository-v2-3-911bae638e61@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250806-b4-pks-commit-graph-wo-the-repository-v2-3-911bae638e61@pks.im>
X-Provags-ID: V03:K1:spqjUOY3QNPYS9sy0reT1Z8rP7JXMU4F4Uc4qZV/1h8jA/7jJHv
 8zI4bGp/EvximJ1eZAIvprXrv5YEcKpw9xx55bbqTKUrL2n4ZZY864Iby/cM/A80fX6rSbW
 spdmZ2jcHWpTTXFRE9uCYPr59CXU09I6zjXUChIgWxRuSPBvQXSUwpPts1t7i1Ukxxxo1u0
 /6Ska79ewyMP3S65DI1Hg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3RmeBaxlaSw=;488cgGfnQWvHzehwKdMjFfmwIYf
 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
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2025 at 02:00:08PM +0200, Patrick Steinhardt wrote:
>+		OPT_UNSIGNED(0, "max-commits", &write_opts.max_commits,
>
>+	size_t max_commits;
>=20
dunno, this really seems to be crying for OPT_SIZE_T being split off.

