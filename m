Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A773FE357
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336115; cv=none; b=XeB+55DhtQzD4ih8E2Fj7isxsGZ2RIBe91OWbOZNJ9CDEG1WSk0duQTAyGyB3Vjrlsuz9PyGOxmo+V0c1pVkQEmGbDDitEHep2kQ3u8oFrBrMmPF8vQdB1LeTtCgH35/HzAEtZFOuwzH2vn8jl/K91gAaTQ+tOFmUxpdsDbJjos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336115; c=relaxed/simple;
	bh=ElVI/vxBgNWu9+GeGUvA+QDNScEPkCgHh8j3KxS5XCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYKPp9JtX2g/FsLYkp2u8wpNDtRuYWmQNaju9vxe8ZIEqKodBqxelr9S3PVKE2oREmw+NtumTlUPxsWpdOPIgogjDvEK+6n9g0guhxgPlJgpJwsppv1wci/8qO0CuJGcwG/7W1PBsNKFUqM9zbZ7c1XcfI/9/Zr3lWgAsSBy2og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=AR6b9yil; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="AR6b9yil"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783336111; x=1783940911;
	i=oswald.buddenhagen@gmx.de;
	bh=ElVI/vxBgNWu9+GeGUvA+QDNScEPkCgHh8j3KxS5XCA=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AR6b9yilDxx3Pnq0me0aK57ldHDgKfPuUcaSzSZNrNlVDJIt7IsJiue+0EPZ9CMU
	 9W/I3fOtCl+zn2x2B07CqA8N1bfySEMsliJ6yTq/xRDMozDhYyTKSZagqYWdtQwez
	 6XMRW1y2hws8wlJZ8cCkZlG5I4RboYnx8EkLzVsiqYqTKlDoWN2nzBs1Pmy6bE6Za
	 DJtPJ75OHm5g9oNwr9vbIdf4imkuRA0VHw+eKadFnVTB6fYzVFY+AGDri2Qi5QB/8
	 mz0LV0QxkMRorY82iGJ0a8Fbb9x2GfOi3/w3j2zIBHvlFJvWUhl6J8lelMqDFphRk
	 HLRYcTySAo/yEUP2uA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbzyJ-1xDowa1dKZ-00gOiQ; Mon, 06
 Jul 2026 13:08:31 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1wghBe-GGA-00; Mon, 06 Jul 2026 13:08:30 +0200
Date: Mon, 6 Jul 2026 13:08:30 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/11] sequencer: return early from pick_one_commit() on
 success
Message-ID: <akuMrp3W1bG6d43D@ugly.lan>
References: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com>
 <cover.1782833268.git.phillip.wood@dunelm.org.uk>
 <2541a4d6e3d41272c31c8fafdf4eadcbc71b63f3.1782833268.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2541a4d6e3d41272c31c8fafdf4eadcbc71b63f3.1782833268.git.phillip.wood@dunelm.org.uk>
X-Provags-ID: V03:K1:BLgdmvlVYmTmcuQvAOWlrNOXqzhoAhrodb4p/G/99lJz1pAP/j1
 lWEC68kvFdORq1rujUndhEGsdy0xti73vkUR/CSw3y5xin7ZvCpQvF7IC3ScifEs7EtzQiL
 fQnUcZecT7kMXN4xsK1lbKeI4Z0Kx/rn05TNoMZ8jAIHNGg2TIrf6ZUwl9x83SSvly76I/Z
 aF07wOz6lRMP3R/S3rPYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lvGFxh2RHGY=;kKqNoQRc5QGekTQixlh3gcSY2Yy
 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
 S+d6KwPwSfV4c5zH05ZwHUdJQRY=
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 04:28:59PM +0100, Phillip Wood wrote:
>The only block that does not return early is the one guarded by
>"!res". Move the return into that block to make it clear that after
>recording the commit as rewritten all we do is return from the function.
>
i think it would be much more logical to just squash that into the=20
parent commit.

