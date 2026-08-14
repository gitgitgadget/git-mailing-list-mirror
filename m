Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BE647ACE4
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718840; cv=none; b=S2hMDuamQIOrAzjL/aoEm7GMb3HkuElFSvjvt7YIGQOKuHU8a9e2pd/LJvWpPK3KyN7p06rmS56oOQBBp2rdw9C6C5EG1VgmQ14n8g4aRu6HJFWG+76hvgWFNx5OOPKOUYxlI83WlxKsvXjSvjO3Iz0Gkgd+rr3Nf6MqZN2EsBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718840; c=relaxed/simple;
	bh=83A85q5uwpZ97TbeuUxWLxkdOR+sVyzBXhGvySEyOn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ssl31k/imgW2jQtzYtmYnbYUUK7ztndZLsKO5WS/2gzsbpD6kfMpHz4zQJvYqX0k2RZM5LVCLnA4WXP23wa8YjLCUG/omUwfN7pNY4R58/00h4jATnDfvE4L6NPLyHafannMs5MBnOC5d2tUTOiC+uMkYKShq6c+jRFMNY+t0v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PeMHLL5U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ct1P1kRy; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PeMHLL5U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ct1P1kRy"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8A10814000E7;
	Fri, 14 Aug 2026 10:47:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 14 Aug 2026 10:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786718838;
	 x=1786805238; bh=dVDJRPOlDWVpw/aHUymAqxzZYwO8zwf1c8LjvSbZYUY=; b=
	PeMHLL5U9GEGXNIJL26fT+6uLWO1TDi3QuQoKHuJKH2E8l0AzAf3pIdqB0QzphyU
	h2oDt0nJnLJBZrge4cVQ3Wg57jUVC+xoqPZ/30V6LvMiAaBl5QxmGWOH2LMkzWUy
	IDNYM0mey1Ux1lzL4qncCKJadEI6vdgzCfQT1Rj5KqgjEp1uVicTGtfuvquAeL7L
	hnWe43+6X61AFrTWpdkmwMwO2o3DVfC48WLD+KLIhdqu0c0E6BHGO4xkk3J6H3Bl
	2XnyomILR9W8axE1kZsdcLzs9oHttaQyKe49/KxI/oDvdf/MRdZKue83h+DHxnox
	UVAZaKYk8MZXyRr/Y7Yl5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786718838; x=
	1786805238; bh=dVDJRPOlDWVpw/aHUymAqxzZYwO8zwf1c8LjvSbZYUY=; b=c
	t1P1kRyWQgmP+THlRoEcO2v42kvzTgUNLwUbdq1jPp21a3dpv2cwuoYGCd3sSkO2
	SCOtn563z0Gh3Hw9pXm+bo+4Vm2gM/uucR7wQmEcI91YlKBoOj8cjOm+OKRJxz6z
	Us1HMI7MUhRUBSYO3u7osLtXgyVfzJLEyl8/1klKDZhDwIqK/BKKX7z+830r++eL
	+FdkCASJ7KSVc6b2BHzAmsG62txC2InvpvhEFp8Gtpk414WrQ7iupUNXuEG36kTq
	FZQsplxdYi66pzLN6rTx7hpl2Np2g+/gJ5FjoVCTYi1Ix7T5CgVVs/+NWr+U69b0
	pqH2iqjnDRbioOICvyqcA==
X-ME-Sender: <xms:dip_avIN6MOpUVBwJKcReAnibFb6MEY1UxAMO8oA-sMkSYE6o08Jxw>
    <xme:dip_arm2MOZXG7FAWhIYrsk0q6rOuDOdZP44AAlY6hITth9nw4eu3ZspOzOD3AGN6
    -abAss6LnQkcqjNnZSm_-dZFrKkwiPFKbm2_9giYAiSUlDqQLmdjj0>
X-ME-Received: <xmr:dip_aoJyYYueKP0iCDM5d353BssIhhvyqd3--s3Ybbgm9CWkaPpohakmaJmFzntUvMDQCdKafQJl1AqdNUrR6aby0ZEY-GJQhA>
X-ME-Proxy-Cause: dmFkZTERBbDQeqkib6g08utImLE9EN8mqi17cQON6RJhxPXXIHpQ095ZPi0KrjZ5Js45ol
    /3I4eLEc1FnePdcRakXNozi5iQ4yhjhZRYV2C5Dl7N1bxi2x95CmqEsybXCuE0skEyxNcx
    d46OmwXMkxT0GH4ctlzpcLWwwmMrxYo7eyzTwKRWQqE0b+aOHuSmDdfSiT5mjoUxUlb+q+
    bcVZS3wFjY1I674L34RlWrp+S9ilW6EJVHWHYbZeIf+nADclPPiEaVRu9ShshkXMY0/flg
    /aBRXzcgiuvN0Dk8UXHGCmimiWY6nKsQRyrte8MBNSEUfzQuaX65eBxHQYglHo7BrZdGTi
    zsCLpjJIzTjybnkz6fgsR8An11c3JtPuz2eOM//ILYovH3lduO7yCKghrFd8UVxkAbfZVX
    cxWmiUrvWDjpX8icu930xGa8gBuh/4Ipj1c9LpKXActF83mU3wQDR0ycJ0enC4rOInvSR6
    jCWMTD3zkOHfS2HWFTefZkUsKlwux0bfB3KHc/6IL5fPh79tjzDx+gb0zpNfr5UIvLrB27
    fV+qOC65StGmj+JA76ZiAyBHKSQRjX6CsBIchEl2rrO4FVmkgYPVdkfSOf/FuCjZzNkd2h
    tpCEox/OkLa41BLTXlRHuJWQ/+C3E8Het0anBYWoX2sSTYGBx3423LTIwNxg
X-ME-Proxy: <xmx:dip_ao5crJfYWfP9WUUiOeVEYIM1SzzURfhGhSebXtVZqHWtIjY18Q>
    <xmx:dip_ak0bo3V4RD4GI2V31OEVLrUjQrhTO-STm2ODeu-Z51taMFfLAg>
    <xmx:dip_amdE_p8BvheGg7z9muQ_3YycTBY1_aWluV0286DPMdl-s2rqCQ>
    <xmx:dip_aieuefCLEs5JWUUlbWHtK84ISoaGcflECcF3Dgh7nVF_GGpSlQ>
    <xmx:dip_avW9MOrLBaOeqgkp4W22iN6B22M8P1eNVHkBid0S6WKDZ1SDhcTO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 10:47:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org,  "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
  "Patrick Steinhardt" <ps@pks.im>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>
Subject: Re: [PATCH v3 2/2] doc: format-rev: use [synopsis] on code block
In-Reply-To: <ef8ee6fb-ef3d-4a83-b8fc-121448d58e53@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 14 Aug 2026 09:45:49 +0200")
References: <synopsis_block.af9@msgid.xyz>
	<V3_CV_synopsis_block.b64@msgid.xyz> <V3_synopsis_block.b66@msgid.xyz>
	<xmqqfr0hqzvl.fsf@gitster.g>
	<ef8ee6fb-ef3d-4a83-b8fc-121448d58e53@app.fastmail.com>
Date: Fri, 14 Aug 2026 07:47:16 -0700
Message-ID: <xmqqtsowpxmz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> My change uses a code block:
>
>     [synopsis]
>     ----
>     ...
>     ----
>
> But the ones in `pretty-formats.adoc` use open blocks:
>
>     [synopsis]
>     --
>     ...
>     --
>
> I’ll do some better testing next.

Thanks.
