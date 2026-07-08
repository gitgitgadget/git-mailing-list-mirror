Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2372DAFBD
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 20:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541766; cv=none; b=nglsDkFNm538PweeAuR52GlUqbcJOPzaQhiuCXUzr+uUfZPBamLr4bFRP7dFcEcHwwlgtmkVJBkiQH3xy6nlbheWkL0jNFaQpTqKMl3o/cudGmmUxw/S7Chh14XTIW/oh9UWrxSrttCPTn5w348Yww+wB6im+B14N6Ua/yxGdfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541766; c=relaxed/simple;
	bh=FWl4dgz+tyv8qJsnzVys/i7G7+HSvGyt6EdwvcolI30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kHcdgCHNew7D2AbEiy5CvG0BoUUtXmfs+chfq5wa2NF3NkgTAkjR0GHpYCEG76s16Ubdgn6xXPw6zv5LkTz9nSQ5ZENYnCS5o/gEgd32gV0Kp7FGiuO3roxholEuE5nPwDbhJ9H/j5XD4omOIn0/pCBSf7RPXTr3LDIaWja8ibY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KBZZ6qkf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eBLr8LZB; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KBZZ6qkf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eBLr8LZB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9899E1D00142;
	Wed,  8 Jul 2026 16:16:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 08 Jul 2026 16:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783541764; x=1783628164; bh=erdCYzqp6G
	01ahKr46TBQJWqMSA8R6zIWMawghU1i3M=; b=KBZZ6qkfS8mN6kdEnp41h9+/uR
	AH4I7WykOqeuh8AuKgB2iY96knwnXgfvKkWTmJFW1Eh8G9pf/mWfRS8aBflylE/Q
	DGWQajyXKFdGeuOwtQSUISSHTN4JwB3szlVoDIQRIQWbWIOjtXDfVSCrCROy/Ay0
	1FbM3qUBGArlh2SFN2ACmBo85DEM7uecvMLf0b9F61XknwTx58dacrAVNbCx5/Qn
	oiRRJ8ULQB53Cm4l/X92MLV3tKdzgiuaWPfW4VSW0fFK2J1yRRJq6OpZPPKBby1M
	VdUBNBJR4VzMncPgj6OgCW1wI4ONjY6nlblcDC6hINRGy1OoQ5AOpSvyyOMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783541764; x=1783628164; bh=erdCYzqp6G01ahKr46TBQJWqMSA8R6zIWMa
	wghU1i3M=; b=eBLr8LZB6PEugo41MV65ruXzSP/EA+Ikjt0HkTYT1cV9VEWNxHa
	ib42xkFm9S/h45Fd5pJFltCkiWxzrb9KZ6l8FHwiXK9C/3tHQn97Yek3a3mhiP3Z
	RAB4K514YT9J0mIEqImWoS/KJgKS+QFsB/859XbQr80ngq02CyXXVDVGIrxP057M
	2VU2LIkjRCcsnq0R9yOeXyjBdR2fcLBwUiTOxXtM5a95oBCjYW1bVPpOj5Z0a40b
	R1oHlmjBk+66K/W7LLPc/bUS2oGUiCpMtio3WGDoTexg9KHVW1IESQR2/dvl9aA4
	fDk71rx1sqXGnDhpugHZxuGlgJFVfYyOq2Q==
X-ME-Sender: <xms:BLBOansn36KnjjTlhgPxnCSQlhnXBFmyUeUUGIbLE4uPiCjliNTiXg>
    <xme:BLBOarAxlBjlf3lduIIS3pglwLdrj_pRYFN9dfufwuY7z1GzG737y-rCFQ_CUU9SS
    PM57LaKaVxGXKkC5X8WVmvCU5AcM1N9eWRLhVOHASLrIZEBHGFxqw>
X-ME-Received: <xmr:BLBOauYcG5HN-u84tYldtDB7Si_lsQt4KWK9pLCBs_OwOLIVrfGkbmifcrUBK4qjY4xlt4-H1V397Eo04Ao0VAZSqJ5QfQzY2YkuBk4>
X-ME-Proxy-Cause: dmFkZTFVnvyKCOi+6asCBnRvBghry4vfYec4WKsdVqLfXxe66TY18V8+wBcq08QMNgraOW
    ZCN1im7lfSopki5Qwih6lnii5GMXL/CSUD15/sGvyiR02XvEJrl3wq02kTtXCVhY/L7doS
    geKUbpIgg2qnT1O25wigCcruzTuqgL89C6Y1uHpsWf+/MkbjAtY9o7njrz55CH/lbR4Boe
    fiyTD8bYph4PSYriATZZx2qE9BlH5aDDu2sm+sSFWnqdheDrUqGHH3Pimv/flWEW7LsW9k
    wQqvmHzaKn8fniFChxRzBcIyLB5eRvoQo/T9S8tS7unWpoZBDAn2Q+0ceRvJPt7WQ1q4SV
    AQDOvWZ0V/AVVRUY9mM5EzVqPh4K64pipYvh2ThdOQ2Bo16/XKtiuGiSVq8pOh5lnPCuHs
    7XrUQcJNpL5e+Ouv1VO8b6MitnsRwZUS76RIXlCjli3GLrKnFDLJ2kpUp66gcxOW13enTL
    JvwZZvkukwp0TRtZAUKOYRojIBW334wy6FdYPzBApCyhbenAJVsvKFw3VNfxdRpBVzQpIx
    wWFA821JFA3Qo6dZcpWDlTeNQWXlorboHQ6jYz83aYMyenCVBZGSDTgXcn3Ss6djfpUClp
    sykTzydBDHs87O7oz0uaSXzDBnKGwiabH4ywxpjChRV5PVDg+rhtU/hyVt6g
X-ME-Proxy: <xmx:BLBOamWnFkr8TGnovJtVv6vSo6o7ADC_H7ebpUKaQibM_buxL81rYQ>
    <xmx:BLBOatMzpk5t-b717BJraMBXd8HRNYwi75jlNQ3CWBUHlGpcEhTqUQ>
    <xmx:BLBOagZZeaEc-ctOiAbtxHyeR2iAAgiNpRSelNX6GJVRgVZxuoEXyg>
    <xmx:BLBOas9HNdX88Ou9CwebbKK689sQM4ZMIjzj2xF-c47vgwZZ3dYLtw>
    <xmx:BLBOaiQnPkBiySieVLS8uvn6DrxaYSk4dSPSGEEBX-2gdi2QSxOfpC6I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 16:16:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Shardul Natu <snatu@google.com>,
  Koji Nakamaru <koji.nakamaru@gree.net>,  Patrick Steinhardt <ps@pks.im>,
  Shardul Natu <shardul.27591@gmail.com>,  Ben Knoble
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v8 0/3] Makefile: link osxkeychain helper against Rust
In-Reply-To: <pull.2288.v8.git.git.1783480879.gitgitgadget@gmail.com> (Shardul
	Natu via GitGitGadget's message of "Wed, 08 Jul 2026 03:21:16 +0000")
References: <pull.2288.v7.git.git.1783443745.gitgitgadget@gmail.com>
	<pull.2288.v8.git.git.1783480879.gitgitgadget@gmail.com>
Date: Wed, 08 Jul 2026 13:16:01 -0700
Message-ID: <xmqq4ii9teym.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v7:
>
>  * Added inclusion of ../config.mak.uname to the top of contrib/Makefile in
>    the canonical order. This guarantees that $(uname_S) is correctly defined
>    on the shell, preventing the OS_CONTRIB additions from being silently
>    ignored.

This round of patches looked good to me (even though I am not a
macOS user, so my review only goes on the surface without actual
testing).
