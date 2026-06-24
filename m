Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7FF325707
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782325569; cv=none; b=gw7kvmVfkanaiLxSZVGFDR5anAcB8ex2w7ErgVKKMQ1CGNZNPNEl+tEBVcOzfLWpVYmj4HjfQ78eSsQxsPq7XyBOKxXqCWfa8NU8dDjeuUxmA/BIFIfdRuukhH0foIgn3BfjRFfsY4MOepQrAE3KBKgtTbLpPB0PlxqBFFGErXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782325569; c=relaxed/simple;
	bh=RjbLGli00YZrGjq+82/uRZ2E7DMYlmbKZjiim3s+mDE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uzWLNKiviOKoDVaHAWt2e+1koMcaeHS/v8LiOm3bqI8+DiLSrujej9n5+G4HgUCNbwUekv7uIyTgrC5NJEMcvv8iY8+OOHcbxnOn1vJdeumR9uOXBYs3LoMmrtpoR579/xasqXrZV/hgMwMNFPB26lYbIKSuG9ESHvEhOi0+SLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cxEQvqeF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sra1026Z; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cxEQvqeF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sra1026Z"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3FC7B1D000E3;
	Wed, 24 Jun 2026 14:26:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 24 Jun 2026 14:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782325567; x=1782411967; bh=0WZNb01a75
	LruS+fia6SzAydDRxGs/VpdAD7sE8Dmzo=; b=cxEQvqeFggXBTzNrWnyYp/6DpQ
	kSleTYx6zlwq884BL8k0t6fYauXziX1U3Faa9P5swMgANqJY+91VneBIyjS+btQ8
	H85hBVYDhHO3L66FQrPRYHn8HCKeKjBn2Z11rYviZ+V+B7+MsVOxXm3LTT2sjZLs
	shyhYdub/tumPuhzdCFU7t3he8FewNQ1s1iZtrAGLusFdgtRF5i2XVBuNhY4rCru
	B4DnOnG8LMKfoHbYtcqn2xdgF55sq9DGbOFrQGGsvpaEHJLIk5Puy053C4FVrDP6
	RzhscmCB+rAWOumU8Oa5jaxuAX7MnhvUKiQHNb1yzxxQNeD1+XECL3Tg5VLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782325567; x=1782411967; bh=0WZNb01a75LruS+fia6SzAydDRxGs/VpdAD
	7sE8Dmzo=; b=Sra1026ZJVI4OwicUS+qUAqeFaSKYnDkke4m0glr4w4lKKIr+QT
	9suLp/E8sZkSZDdNs9eFbILTZ9wSD9/UR9BqpAU+O3gcZoDTeZRcWZRiKR+fWFb/
	R3eGI39AqMg0KFDxarQIvMqt9i1CgyHeEhc81c5oRl/V8CTItjMGdXngHWYA+Tuo
	BSTxYPSaTZZVqSj+Dpwc/sBTHOX9zRCGajZKnM5ue4aF2hW1GJg5ZgPc+NQw3EyE
	btakAwJ944GH3QRFGCW77Zs5f9OSk1zWRZkxzAIqtvqwX12M9C/jNLbE+YCZQgJF
	GHAYWBR/G/q58qlf6+NdckqZrEv5974NkMQ==
X-ME-Sender: <xms:PiE8ajE5D44rkaj6iE9BusdQe2uoyQQYNSmR8yMld3wsRuBMLGQWOA>
    <xme:PiE8anUgOMQ-iXnK-sqkPYgFv31hvUadizAK_8BB0B7E5TbL5bnB_19aPnIW7apsp
    d7EluRSnfoO_td1rIoRefc-FkFYEdZwd5slgrPpoqWiEEQ3J0HDENw>
X-ME-Received: <xmr:PiE8aqL91MjuLu40qIr-a8zmit7evSl1uiuLIXqDfWmqqgNMMcgcGez9g8ssQvSdMLr8tp2iXbApJWT5TZJaUV4SvMXopwmkI1IKq-g>
X-ME-Proxy-Cause: dmFkZTGG4nhWi5I025kxgM9jZHW5cZMqNCVUnEHzuiZ0pgSajexoUK99RIHMDCSwCnHlsP
    H1rKpe0B+I0uoiCCa7dRyulaCd00Ddja0dP0t5/3RD/sSHyInjiCpO7acMjHBB7cZ+2KNM
    tZxtB/5Diz6HS8XSAV1spJUsDKv/kA5Tk3zSGVyc1rUMvoYqiktmM99AoKaDpu0nyh1vEU
    +eLt8Mb5Qs9Kb10vV4S1GJAY2VMysEfkhFiH4EmUVeUxASUlfnn5+dmc2aOluacjLCrQPk
    hwd6+ZUOr9bh5MF7NdLShYGIm7hVU6V9bgj3yDK6JV1C27NU76iq04ZtK5F2w5P3U7zhK3
    9QYRmBFneUEHGWlWZQYtaZ2VK8z1OmClhkyYDZbb6zwfhU0ivwTiKzjRzfVi3OFdXH895T
    uFki8EEL5V9xlD1h5fl52f6mSQiF9LCFS9QbwHX/5zvBav4R8WyEomdGH+mQbwzn2Zkn5O
    OuS6z/5pvff4+JMaVmqB+9Fiof9zEmO17iayzl4Q/vvcQqKKVMugKw5z34wbDSnZNi4VJe
    S8pUzchedG1dplPL4HWZfU7D2I72QPX36CF1m5libWtGS5iaZaGKztNANdNwWmn5BLGBtl
    QW62Vk5a8PL92joHTRDvBfYkIbHQPbE8USVn7ofcx2+g48Fcpcqmg0vy9nvg
X-ME-Proxy: <xmx:PiE8av-XBwXwEHSmeER4rsoeZ78q_7tNcSS7FJTvU3XCujzBS3nsPw>
    <xmx:PiE8alIHIOVsVuctJn2AKUI8Fwt2S1wbdMVw-u-AQ9nsIYPYg0EKgA>
    <xmx:PiE8askXZX93e-uuUjdFeHp2qDoI0J_nQfJ1Bmzm8PXwP34rpFfR5g>
    <xmx:PiE8ahPKoNTNKgLd1OEXUd6VSeUUtEsQ8zqY2FPtJCk_Iz0OiDLw4g>
    <xmx:PyE8aokaZv5bLm_WESYILzteUl8D6HpSMjdHH-auP0wDR5UYebq_9R97>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 14:26:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 1/6] object-file: rename files transaction prepare function
In-Reply-To: <20260624041920.2601961-2-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 23 Jun 2026 23:19:15 -0500")
References: <20260624041920.2601961-1-jltobler@gmail.com>
	<20260624041920.2601961-2-jltobler@gmail.com>
Date: Wed, 24 Jun 2026 11:26:05 -0700
Message-ID: <xmqqse6biyma.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> The "files" ODB transaction backend lazily creates a temporary object
> directory when the first loose object is written to the transaction via
> `prepare_loose_object_transaction()`. In a subsequent commit, the
> temporary directory is used to also write packfiles to.
>
> Rename the function to `odb_transaction_files_prepare()` accordingly.

Taken by itself this renaming does make sense, but there are many
other function that follow the historical naming convention, like
{fsync,flush}_loose_object_transaction().  Should we rename them for
consistency with the new naming scheme, not necessarily as part of
this series but with a todo comment to do so once the dust settles,
or something?
