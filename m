Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D9F200110
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694898; cv=none; b=lr098RRkEoq+jWXKl9XpAWOqOgaaxP+ViF+pKCISC6tvOZjGV1fLzaQpDbYBa+LQqALYbt47jj0f5Xz6KIDmVPhpmWsiEID5cQ+wD73teD1MU8c904ruL/b9lKb+SO0vK581zloqAKq7ofQXotSEpMj0MXmVcHqjSP4YbmG2Ee0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694898; c=relaxed/simple;
	bh=uz7Dp/VDLQoqJ785MUjci5T+A8QXcp4eeAGs/c5MLVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uns5gnDQX2ZTbTNMXGCXDlZCI76PYVtB7eOoC+M2MMpLfw6C4LD0qBRnfpCNHGQWxuTzz5/aiE7TxE3TpRmJG5/46qqKSpgwsLSE339sI5IiRTILBbxlwWT81ivOsmWRcXJQnCGZmgoU1Kt3eJ96TzrHf5vu/SDG0b1darxsvoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IFe6H7e7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c904YjSg; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IFe6H7e7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c904YjSg"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A8767EC010E;
	Fri, 10 Jul 2026 10:48:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 10 Jul 2026 10:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783694895; x=1783781295; bh=hPTV0EBSCF
	BiyrSQJtun0ETQ0vSJr69Z/ttyMkGqlDc=; b=IFe6H7e7xIpIyO9GaDV3NUKefc
	wfpGTHITsyMPcbcv0U8SD89/sVYXyf7iyh7kLILpbKdbUJPZW5ArcHECn3SBPHwv
	ISZ2+gXIY1tVyxw/Y66ZGWvQVyhP+u+W0Lz+NR32Gs3WQegdRkEMeOopgYL+++2N
	I/cO62s67dTy2bFGXNhA6GDRZTwQhokxRvh44BGzLpu94/cjk/GBtbSY3SJgbStm
	c5LHVp5DhX1+rsFBosYKI6+5Ps4JePoyeYyFGjw4DxJhVjTFElX5xUz2WzWESP+B
	u1N9rVqU/fUQw4TTgokWX/m3or41kPyg0ocdri/q2XTczOvfhlkSYeZyp6FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783694895; x=1783781295; bh=hPTV0EBSCFBiyrSQJtun0ETQ0vSJr69Z/tt
	yMkGqlDc=; b=c904YjSgzRNR5hgYklGg/rkdR+fL5uttr7qHIT69Nb7uVIVUIPU
	J+5ed3iVshOHMulOMCYX5CPG/2OFN9yMX0LX/Q+2frR1syGsUvIxWqWm8oXLidqH
	4NynHDAv5HwEWjYX2t/MLeE3Cn782E0NJNxppSCxWcIsEz+V8AL1XLdeVmk5mZzS
	p9KlCkdUO6pH340fLgsQpfKpf/1YCGIfd8QLGpoBwTWBgOiNkyxpg54to9djX9VW
	+5IsSPscIPrzx3K/cpkiljLNegBM1w8GmbMh0hoaw4SAAlwOrVOFYTB9D7WF5hT6
	8RPP9cfJEGlnmEK9DwzKVM+CmZk7075zrwA==
X-ME-Sender: <xms:LwZRap9QfXxCHNI1vF6iYLbWc5Us-HHT_h4L1p8ScRAosYhFxR65wQ>
    <xme:LwZRalIlMH5hwhq72vlhMViXeAkWZYpSSG_LlwrLBAPlnl2EoC-bYr_gdXLs0JixO
    L6tgTcF57VPJeit943FQb9gf4_O9rW8Bopn67ywfjZ_CNeALrFeOaU>
X-ME-Received: <xmr:LwZRakaYHbQyH_D2T6wxVrBP10oehZvjGLP6g8OuegtrE0JhSItoMSSIgsJ-uPjnSdTP8Hn1geXoUBNHbEGEe1odooWuRNf7ABJ35Kk>
X-ME-Proxy-Cause: dmFkZTFFHJM8Wr8jhiMRMcryRd39xYvl1dWrHfI+0v7fkOrgvEAHNLwtbIOG8jp5n4nI+2
    zGDa5T30yMQ+sZ5fhuzMEbGJyd6TiLOhhXfFfQnxgXQIwj0VB1KF492uIrkxHeVKE67iqX
    x0j2Xfg3lDkte8IG/n8Vz8Sq71XvlJy1PHRjtO4nVBfDmEMVWvGLrTFPZ5Zm4AOQ9nKms/
    8tbTSR/M/3FlG8/0Ixh3NqbZCBg8OOfrAH8X3Doa7Jxq0HnCUNRz7JkRlQNOWo2GYxpLkb
    lRJ5p+ZgeTYuA9iC82xnmbwxyV/CyS+9GmYwU40AbbfZtyKV1g+6bzag+mjg0Shr9kCcOt
    o3+qceWxSF7FgMqPjk1R+u9HcHpmDDhtZo4w8N6Tf0wz7Lq+MeZAW/UesuSEMYy4qTttBT
    /Gd/4RZYzNd0d6KPWhUAOEoA55q/4wTxmsCM6ZzqJoxmMQhkyG302aZ2tWoQZojdP19P0G
    u6Yh1VxI4B5eghUWsBgua5ptsY69Cy3EQjX4nb8/vwKJDSenk22u4mJMP+GFSnvLSdROfq
    u+JY7hQ7Chgluf1i7Q4AAO9lL2H4qawu9XUQzwmGPVh4eqJtFcG9F3Uy82nobATsFDUl0k
    m7M4nAQhWkRts0GbU7n78djeJ2eAPhksTR0d/fkQH/kWKEz31zlZFuxkmYgA
X-ME-Proxy: <xmx:LwZRanI9u0QM_Z01cTVrxmVwU5gmLHMRhU_L4bltJk5ejvLr_IsZZQ>
    <xmx:LwZRaiARZ2hrhpdAiMrx1ctQ0aBilMQEhipy6xJAUW_stDU2hcXWzQ>
    <xmx:LwZRasqLVqEMdIqm3mC37IvjLQ1ytLCaeob9rgmLXwAWre9zn8sVTg>
    <xmx:LwZRatgKfOseZBI_IXYdC6bNLm8sa_lwovAPktXGsqS2WhUK-5R5vg>
    <xmx:LwZRalSkUj68MJu9QeD-6aPg4uXAvMo64rujuOmOz0bQ6VGXV0G9CV7U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 10:48:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/7] refs: remove use of `the_repository`
In-Reply-To: <alCJgLcjXKEgNwFF@pks.im> (Patrick Steinhardt's message of "Fri,
	10 Jul 2026 07:56:16 +0200")
References: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
	<xmqq5x2nlwyg.fsf@gitster.g> <alCJgLcjXKEgNwFF@pks.im>
Date: Fri, 10 Jul 2026 07:48:13 -0700
Message-ID: <xmqqik6mgatu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Jul 09, 2026 at 01:39:03PM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > The series is built on top of f85a7e6620 (Start Git 2.56 cycle,
>> > 2026-07-06) with ps/refs-writing-subcommands at 002fe677ca
>> > (builtin/refs: add "rename" subcommand, 2026-07-06) merged into it.
>> > Despite that, there's a small set of conflicts with "seen" that can be
>> > merged like this:
>> 
>> Thanks for a heads-up.
>> 
>> This seems to break so many tests when merged to either 'jch' or
>> 'seen', even though all of them pass standalone.  I did not have
>> time to figure out what interactions with which other topic are
>> causing the breakages.
>
> Oh, interesting. I'll investigate what other topic this has interactions
> with. Thanks!

Thanks.
