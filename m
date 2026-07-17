Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACF62F5313
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784308146; cv=none; b=AUQt1+Wlh1L0wr6mTo9jvkkuu+cnwlNxqWBbGRkL/oOifBDJAhFI2BsIO2llbSYSDY+OFCQj+3ZjmAhFidWsggYNK7TKzjTuPbpkGBjKnnBjG7ZBj2eZ8nCKCKUF4Nlf+a3ySSTXpY2duXSOEE0IG0pI1cT7ddIi0e7cwUL/vmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784308146; c=relaxed/simple;
	bh=NVOIk/K03eOAeXG0ExcX3rGP+O6MTuTqBhL2rtNOTuA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W2VDDjDOkSI0/Jc+fuTbyhXPBNgWmSGJOT55YkNzXOrNNFGcpkjsyGs8y4qJVl7kzkk2DjGArnx7BGzxomoqfutjVqVo9oYSMeXbaoGwRWIjVoUyvVndjcjuYTDFaVytK+toRUbPT/+dx2sZQKF3/fHo0TV8es7UJaLSYrSjtYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HiIu07Rh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N1KNfbjD; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HiIu07Rh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N1KNfbjD"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0096114000AD;
	Fri, 17 Jul 2026 13:09:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 17 Jul 2026 13:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784308143; x=1784394543; bh=KUDob/xkg4
	cvyh1DUhKFmeLpU4L8DnQFvEtG5GnGqoo=; b=HiIu07RhXhY1yqnMOm+4uikF/6
	svhz1JulFDgIFb9dF+Tv652MslfrVWz+gmZ95TBZy/QWBgak+9szf3SkEBmbLgCP
	Ck+FybdHQ27bwf3/CMaCrAxZATVRB91ryd9fdqLVRe4VV+a2KC7loB1phloiGLyb
	GDXo2D6cUMkL1B9aLzcy+ryDtWJ5jgtnOVtL4z9QEgb54muRyjL8P0IK41IWRGfg
	HeKIzcr08IV3KqmEthmd3ET7qSY3/7kRJjqgn4cCLWhUUOSRQ7TMHXyPszUmvAnN
	lxivj2q4RicIb3M1V5NO4x0LxY9HTvnBSnaLKHN4J508zu2m79QFh49xPoQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784308143; x=1784394543; bh=KUDob/xkg4cvyh1DUhKFmeLpU4L8DnQFvEt
	G5GnGqoo=; b=N1KNfbjDAxWZ1UYFIAKLJsfmD7QzwdLNSD6SIGsryC3Qhhj9pgC
	d3rfYnt+fsO2NYzlVuACH3xyNpjtT8kfBzKleEEthtb6XKW086fdjw4EMEADOdnx
	uTCrUnu35cy+tbrAYhuemmk0JwyjCJdzQTKIm/ZRsZ8eTbh16xaBgqaqMu2Aclrf
	jXq5jlhKK6SBNd3A3xHmEQ46kH6ifJxXxCQA85SxcGZZ/LYaDzkp3dDxifU9fibV
	2TrH0zeRiWavcxa6d7+TXavGtnDJ/ZYWXBESvloVi0t7nRY34Wr3w0FRgYwgHPhS
	6zWEQ5ghAu1GWEKXX80g6hKdVzMbq8G3new==
X-ME-Sender: <xms:r2Faarhocuz2t5lCOEAJVBUWRKCQhJ3jq3LZnR3EERUV83Lr59nBdQ>
    <xme:r2FaapgQDRYs2MhHDse4alKFsvTn3k-P4phqIUEU35hHjFGL0KRFx1HS4Pn3ouM-U
    gY-_9pwAs-4xKUg9BVueOvzZ9uZFoX3ARrAtokoAE42xbtqE64I>
X-ME-Received: <xmr:r2FaarJdrnE-iayvmNRmeDlqAauHFzDimV7mOSuBTDZFqK8n3FTeXKA59tBCzrrzHQZA6dEnJHoWxnwYgYyYM8viyyYYOgzgwAp4TaM>
X-ME-Proxy-Cause: dmFkZTEbS83k+jNHwPFucSphpllJUvDS6keu3wTOu9sv+YNEFaJpyTgi2ONuxpTk0iJddj
    83WBMQWgR62zJPxq52vVDU0hs7fav6out05z9vfrp1W7wD0evNPZ24g5eF9P/FqOIMh5jW
    8kQYAxMy7pV7+Z4pAx8DwAkj32gGhehVNBlCeFkWnQ5Wci+PiAMZByijXEHXX2nL7Pruyy
    wK+mzY3WJi1UkndjhpBNOkpUMCIV6kAMSsMt35xUgmKTUaNatUGb3lMyGP/uEZLnNH8bjY
    ppdfdCaP+Hc7fvFTITB3tjeGbrhTaxsvTiL4uqY3fHRtif2Bw2FcO9F17c1xHX64UEyGP1
    Kj3bfZhedjk79UTqZkxZ91V8KjuQv94hWEdWMC0MR1C37yQLuu1J4JvOsy1FxHn8Bf2IXt
    +Z+qFUXg2aPIKAzRrULZocogbGGjJ1r2nGhA9xMUla825s5yxSCerYdYL/0FdGUTXgUzTF
    +J3G71XXki/HLR0SawrCKrks6M+sRixaVnjBl8iULGmLuqKwsRvx2D2HNwSUl/QbL/WSgm
    3X3Fwhf2Ars4pcCQsng40Ik9wGR+HKZm3NWJXCigLTIU3aKp2OwgvrmiYuf6mzFh1C90Qx
    EbGhm/UQBWq1YVDnCBlt3a7uAC8CK4Nx/xodqXQFn0WWqoNC4fvHkJgOneFQ
X-ME-Proxy: <xmx:r2FaaoEqgM8YDEP0kfhhcmMJ1vm6UQayS-96qMCKVb3E63jLoPDHig>
    <xmx:r2FaavRG5-JUT6fzynkrn65bmAxVpl2mWnejYpby6eESnryGF1H_TA>
    <xmx:r2FaakevmV5yPknolIkyGQI9bbEqv1gJmBhK6qVv7ubhl4VW9JYvrw>
    <xmx:r2FaaurFIMukvajCt2f07AecK6HhM6Vd6rnDvnSH2nZCfyvh4Vt7lA>
    <xmx:r2FaajViQdmzGE3kGcEpVxNOSXywguZknmiKa_eEwhfw3COgM-OyhW9C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 13:09:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] copy: drop dependency on `the_repository`
In-Reply-To: <b0df688a-3b26-48f6-8b1c-98530483885e@gmail.com> (Phillip Wood's
	message of "Fri, 17 Jul 2026 16:00:15 +0100")
References: <20260716-pks-copy-wo-the-repository-v1-1-8f1e078bb82f@pks.im>
	<20260716-pks-copy-wo-the-repository-v2-1-8f5e32942929@pks.im>
	<b0df688a-3b26-48f6-8b1c-98530483885e@gmail.com>
Date: Fri, 17 Jul 2026 10:09:01 -0700
Message-ID: <xmqqo6g54k7m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Patrick
>
> This version looks good to me
>
> Thanks
>
> Phillip

The changes to 'copy.c' are fairly straightforward and
trivially correct.  The resulting updates to the callers
are also minor, as requiring them to pass 'the_repository'
introduces no change in behavior by definition.

Thanks.  Let's mark the topic for 'next'.

