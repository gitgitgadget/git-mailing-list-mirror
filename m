Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE50D3ACA59
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 06:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787205680; cv=none; b=Df7Fv0DRjxyD3XnX1GXDff7W3xRvIaeVcrfUEwdmGh+NFdGGMHDVTHdFFWqpdTiVxnVEQkX7cT6Wo7lKcVxC6IniXLmSax3rPipjgVlmzAp2gHT0uefdLdMNc2XjzzAI8Z1kYImNSAiMQF5mXCqb5V6FOOez55mnXeekQaSaQ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787205680; c=relaxed/simple;
	bh=i+xIoDYbFfiC4zUGvi7Lg3sQK3kkP3fh/uEs6k/iYWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTn+3qG6hguo7S4Pf29PSoqmTO/j1qCt3gVOzNbR8EMGn6cqLmj2m1mD6nwp26ZlWdkaFdr6qtzcYbmR1FwvCNXT64VpsMGlVtEEJAXtKb1euPDYo2JgSFKs1wvwjpgnYCMM7wOqfW9URXJjgPw+yV2Mi0Ddd2VkaXDWEz3vWko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bza6aXTZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hv+auJjr; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bza6aXTZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hv+auJjr"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 0BCF1EC01F2;
	Thu, 20 Aug 2026 02:01:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 20 Aug 2026 02:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787205678; x=1787292078; bh=VnxcW4I00y
	5DYldczrJWUOKk4IfedrB/Nt74WwwKHVA=; b=Bza6aXTZC1MoYX1XglT6V+9esh
	B2s70LVsqewX0LapHPFUTqgGSjYiiP39F5hnJ+1yQdadg/yQYP0NOiv6jRmDDHHJ
	kFJiUdaQed0lmnfNJLYrgiV0uTx5ac86iRZUtnXLk0HEgmMPPJTQYrkzo62D1Q0G
	1PW/oU8o8XDGrFgk8RmFX9Mcdxb6xoAKIgwVB0ZfvVzNJg/9FY6fypz8X771fW2X
	hJUjMMEuN09BAcF8xYFgrcqcbpnsCGAIvUVEM59GbcQrGsXCabYjcAWxyeXjCN/P
	MPHqOWk9Dr1NODnv5j7M+kB0AvZaAbyk/HP5yD+nJag5pup8P4xwUDTlV3TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787205678; x=1787292078; bh=VnxcW4I00y5DYldczrJWUOKk4IfedrB/Nt7
	4WwwKHVA=; b=Hv+auJjrcq3POd7Ej8Jdf2T9CGqfslFq9PSRSZ52WQI/WeKeNFV
	S7DWPGi9Y6Yd6ZxP+7XspBYGOJj3x8fJ3ufdDqAzoNzB6CImk8FJxR8o8U9BILDC
	TxQ5CbgLmGHYOz0OVTMnr1wyO6GWWKT4QjfMhcewK0qO67f2NYjH5oIIvTOv3tKL
	jTQcTT7sUEar9P+CkQyEdS1fDYxXbrIhdXz5d+mhPoGvNqwsKOCGuc+yG8ZDZF5o
	5VahqDtsmkVjMkYVb/BZVQ/CxGssDp2QsqUzNwe110VGpcP5ITRdGmx4v1I7ODsl
	imiHGYoOgLXcDouXKSkqXPq9bGrOpXxLWHg==
X-ME-Sender: <xms:LZiGapbhobJ5cTWnVVkyva2qPUjCt7nG7-bjh4X1eLAvezDY7p55cw>
    <xme:LZiGan3IszsUlujjeb8SjPGmPkwb0aIQj9OGjXw8h5DbUkqcC0QvnPABkXe40u6cX
    Dz6s1CuBbwEw2FhhflogdgRbdBnS6UVsVfQAivRBpVbvJlDQRmltA>
X-ME-Received: <xmr:LZiGapWzZl8V_OY1mAA7BhKHc0eUrVgrAA5nszEJC5LRBqQ9kmFtOeHH75OMFDMtEdY8zqd42cV7XG_91co6eRqn8xu7Dpsof22pniIaUA>
X-ME-Proxy-Cause: dmFkZTGreCq/KXabDbt3acFATUMjMo/yGJuDp6xeB+un+m1DHtAhAPX6z5Uc08qJZCc7fD
    blKPMCQZKmd0zfzBixxAs7bqG14mZ6xcEYqyWFbjCr0edA2SAIL4wLf27phqrC324RpYTV
    LUjzlL7ny48XQXye79Sca0RUQQyip7nbNKpibN0Sv73+QH00k6n4I2bYZX3KVrkTi+YHHT
    +yGUcctdvljA+j3AmPhNk3qFghXeP56owieoTGmJcMVDoOhKfG+IBSGWSJcblbT9mYElR7
    sklX3xcMJl+zp+2NcodmPd7v26s1h8uAwIfCs8R1+NVbnWztn8UGNtuMeE0usoTtCOOQVI
    aqFnv6zBHbzCmQKckyCYZXVqvPBAtVid8VH4jsdgksxlXpGrjRtb2R/Bv+7HkmGyRAss3j
    ekwXHWtUJQWfSqgiZfXp2CemqjY35eZK3ZFx6xFWAFkzGK1GvTkWqdqGHoLDBCh9TbwP3h
    7D6FN8IsPnkJim695NGs1KOcFKE/EBDyvgaaNkN/rc+OjsQFNCRIx1Sc9SFxxNtEaIwojx
    EltBRu+6bAoxtmkK9647aO8bO1mAlGoViwH6uHhYBUHLp2PBo1pHEleWwbYJowxxpW3bdz
    RI3eopaA8bMCLFEQDez+R+bWp+0qrxzJrzidFjdb9D3fANHrrUDLkTHHFx+g
X-ME-Proxy: <xmx:LZiGahXYOJDzs88caK5MgLlqB3QaC1pMMztckr_eqfbFKFKoPzqkKw>
    <xmx:LZiGaodaFE6WuwDfaEN6l1YLQRTkZLKacatzog2Zx4lUFVAyK-ZRTQ>
    <xmx:LZiGaqVWBRmAGpQS8bAh06QoqzqCZi5SNE5hugdiuO8OXKIeXrK8jg>
    <xmx:LZiGahcsDdeJLbQFrFMXV5-iCAXRQjdFKuqpfKTROH5MJO2qtrAnhg>
    <xmx:LpiGav0QpVgbgOuyRhX8WlQGh1-ZBsxzsDhbT7CQQV_JXlrs9EX7uNIw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 02:01:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 681672e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Aug 2026 06:01:15 +0000 (UTC)
Date: Thu, 20 Aug 2026 08:01:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/6] bundle: generate packfiles via the object database
Message-ID: <aoaYKPoPRwobCLGZ@pks.im>
References: <20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im>
 <20260817-b4-pks-odb-generate-pack-v2-6-4c8a96ccfdb3@pks.im>
 <aoYkfl3Q2_8bmijh@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoYkfl3Q2_8bmijh@denethor>

On Wed, Aug 19, 2026 at 04:52:05PM -0500, Justin Tobler wrote:
> On 26/08/17 07:39AM, Patrick Steinhardt wrote:
> > git-bundle(1) spawns git-pack-objects(1) directly to generate the pack
> > data that gets appended to the bundle header. While bundles are not
> > part of the wire protocol, they are a transfer mechanism for packs all
> > the same, so convert them to use the pack generation interface of the
> > object database as well.
> 
> Just to clarify, so the intent here is that git-bundle(1) can be used
> one a repository using a different ODB backend and still generate a
> bundle correct? The bundle would still ultimately use a packfile as the
> common language format though.

Yes, exactly. The bundle format would of course remain completely unchanged.

Patrick
