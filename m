Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E827081E
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 01:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782611009; cv=none; b=iIQfq0D+JVnhoKtRNRxMcu5xwEKbyEPspmPn7XgJblrFjsqkWYYFnRbGBT3eaBayeoGRAgmCxqwCUdtEX6BihRBjkwdu/3TbynzSxgeyYs2hDbcxxD13AeMA3mNUWkOKig8ah3zoMSgg3IbaALp2BTHyq1yj+ghig/ai/fa8cww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782611009; c=relaxed/simple;
	bh=1EEmZzf5ORk26ntpbpahCB20lCMGJhN4cWlSHebPUxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RrvUyM4o0DJjEUF3BbV/bVwCgL5zjena+pNPHMl0gjDRooM3W7ycEz6MNkAGVQW/6mtXIfsdYjSqMtNZodZE5om5rpWJQsOkxh4qBofBdx50ceqKnpEHK9iXcfLLDaiH4WmilAkemuGEUk1xIELG1TSjwuO22ccTcvjTnHtzyRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QVP1UU1f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QGfVjoRM; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QVP1UU1f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QGfVjoRM"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C5E651400105;
	Sat, 27 Jun 2026 21:43:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sat, 27 Jun 2026 21:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782611007; x=1782697407; bh=1EEmZzf5OR
	k26ntpbpahCB20lCMGJhN4cWlSHebPUxI=; b=QVP1UU1fnou0yo4L1ZL400SveE
	ynZ8Bss9csjMJZiqEP8onoNolvjJyI+FCQJgsK2wl1vByTgr2ExSihlyo94ZDceX
	jmxSKyYJ+n0Bg1j68S3uIrimBPw0lPykZ1BTgIFAvzBJcFmFGugj14pvYsKyVpA+
	dait6AlOMEcSELbsnoaZsTYJssH8Gi+Uv9EHQwUsQXq62itRztgBS5IjNSs25Jtz
	XGBprNJU+DXbmrGZ33Ac+j3BKkdBx4lEdYlf+1ZRyTSEwknvIlGrA7K6d39DYu2K
	6VPeZ69k2UBR3dh7qoMmk8gxJiw6AQitiLp9icMqWDDatOY+kaZmrq3Xr5lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782611007; x=1782697407; bh=1EEmZzf5ORk26ntpbpahCB20lCMGJhN4cWl
	SHebPUxI=; b=QGfVjoRMZ0h5WLjnqkuc8XDRlwDLvAnhGcSDYLrPW3xLo4Xmluj
	cPRsiH03DfSzFO94dioMZ4uyROtB/WjFGSiBwQgOQi5+dU6CWMMbOheWEXODnw8w
	u9AUMQsHWSt2yy87M/RfJ3iMH2W5FESJdDLz9+nVS7Yr465KgSnH3lcDecluGPn8
	OjV8orjAKjOCzoOTb/ED6bRS7rBLFSacboyAvvI+5VnE+5TzYbV5smpRc+rv+roT
	IJVxynSFa+O2jXqQZYXPTRQwSk5mZQWh1KE40gzChOikLbnTlGf8WPJWwO/R+n7b
	uerY6iwNXU61xLv5PDeKxDFucWC7Vcz/t9Q==
X-ME-Sender: <xms:P3xAaqCNM00lSzW42KA_wOzMs7d2WGNTKegF_onAcKkQ-bw4A_dwOQ>
    <xme:P3xAarbz3Zq0MsTTlOKpRxRRkioj6J1YZNvtXdct-Ht_mxxHZMbFWxcgrTNHHaX3Q
    4_ISZvSDpRn3YLpFzG1wuuuashBTZohIBKTRxRvVqyhYbCWAykGDg>
X-ME-Received: <xmr:P3xAal7bUHxTcKGWzvjs0HhgBMa4eRFznKHKm6o4txGNIKWm249kIVLwfUxajBT3DWt2R6O6cYQgyE3UFFS3wHEwhPjcDe5S8N1zogo>
X-ME-Proxy-Cause: dmFkZTGye9bOxcmuCe5NDrCQATBWzLjouLFCkTy05RfV8Ctwlo9512W1pNznP7ejJiSPlr
    V0RUp6N+y8TPczjuXfQvMVuqY8Vlrl+4UjzG2uBbBcVmh6uiYScLktuDJ62FYJ9MVQiX0H
    Kbr2NVkgKFbacKm1wWC6Ri1z1IE3j5v7VlALnN0eLYvUN/MkxOIatnF2YvXKSL4q0ujjej
    qzSOyzjZcavLSmqMEOA1C50BgdhXrwLwhrqugkkKYTOEFN9lIgWOGOeomu6OShE7ndhJWM
    6D03phhULOu73OHDjEBn7FEsPIAjJESuFQ0C5gt6QzK7nnfHUAleJ1e/XFT7fN66ZgRiRc
    MCBrWyC2hCkj/PuoTXU3I3DIbXHCsFCXVrq9ZsIKVl5/Z52R4a1F6YMPdIWrMIUYyD2poU
    Q5Bo7vb1dYy5gMYPz/C03vN7IwbGvKyigiWlQmvZreIlYqNIqZDUa0Y92MhM3AivD6rwi8
    4BivLEfnvxbdDpZhHdTFEEruVIjDEqU6twSP8CqJq+vpXrNfls2wJyLffbZIB/6ODr8/Rn
    q2L4dEk0VlQ0v9yF/FToWGA6GM0gb9canU45TrCnrD4uFTsIO+JEHDfZANvC8UCipDTiVz
    rg2G8nbxDzdlRgoHsSBP1XlNuHS/IGLWA6ITi9u7lK9h19Z07TxFuUDAQxNw
X-ME-Proxy: <xmx:P3xAakYFzded8edXTULIonl9u6Ehr04bfgA-25dwTvH7-Bvc1W-f4A>
    <xmx:P3xAasjfpdodqcCQ9QFPwI-jnDVmfSQ2hs7bGT_-a53oA1IBpWcyQA>
    <xmx:P3xAat9RCuB1CeBKfdfcIrqfeKel3XLtwfTA4W3IWuqwHGFFMnamDw>
    <xmx:P3xAavp9wNtAhpyMYT-9j9LVbDdIB0qNKqZqeQMvYOBUEscgjNdfFQ>
    <xmx:P3xAairqLVF5wFwc5NBlZt4rC2U1BKuxaU58hp75Anv3Ws_GephVT_8n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Jun 2026 21:43:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  git@vger.kernel.org,
  Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH v3 0/2] Silence po catalog output under "make -s"
In-Reply-To: <40b7eee4-6b45-449f-a3a0-0ae415097041@kdbg.org> (Johannes Sixt's
	message of "Sat, 27 Jun 2026 11:34:50 +0200")
References: <pull.2339.v2.git.git.1781995570677.gitgitgadget@gmail.com>
	<pull.2339.v3.git.git.1782053803.gitgitgadget@gmail.com>
	<d38d233c-a7c9-4457-96c1-bfb75af71ffe@kdbg.org>
	<CAHwyqnX78ePVhiL+_T3FzCSA5oGaU_RPvQj6YP=s1WyULg=tdg@mail.gmail.com>
	<40b7eee4-6b45-449f-a3a0-0ae415097041@kdbg.org>
Date: Sat, 27 Jun 2026 18:43:26 -0700
Message-ID: <xmqqh5mn4eyp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Am 26.06.26 um 21:27 schrieb Harald Nordgren:
>> What should I expect here, will it be merged to master now?
>
> These patches are cooking in my respective j6t-testing branches in my
> repositories[1][2]. I'll ask for inclusion in the Git repository in the
> coming weeks (but certainly not for v2.55).
>
> -- Hannes
>
> [1] https://github.com/j6t/git-gui/commits/j6t-testing/
> [2] https://github.com/j6t/gitk/commits/j6t-testing/

Thanks.
