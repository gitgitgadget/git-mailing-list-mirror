Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2739D3033EB
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787077071; cv=none; b=ZX29iW+JYetFgLuYPjhZuJsXjD5cUSCn/t6oXLyS5O/tnQIkSro07Nc+HdPkmomOJgSfxZXNva5/ORviW1lt0wfk+g3wU8nDq1tYbBjJZOJhUE5ob8SAw5d0pSPirj9hyj9l6wXitk1XOu0yqHu7shqbAOFbdz4TQ93ZHCKMOBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787077071; c=relaxed/simple;
	bh=IQFmsDxquasM1M3mul9n2gljN7uFa0GZcwrCr5Kc1xA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IiOYIAYxsJBu0SpmdYqvDRDwQUhuVxon1rGaGQxqlLPglWi9hjeZOtfIoIgyMB3zB1aT+bovrddQ9K6tvXzpJ2GEmC8TEGof5p3IOe6/iXHL3qCIiWGuhUOSjjhVYgK03rj/qjd1GOrPOTvIa0S3uDJ+k8SvoAGezXukWxLDs58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h4X2lrMf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qzf8NR/H; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h4X2lrMf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qzf8NR/H"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 56584140016F;
	Tue, 18 Aug 2026 14:17:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 18 Aug 2026 14:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787077069; x=1787163469; bh=kZDyJfOXDo
	OMR85GkK/jKcnmo6tWuGEX/pfzjUOBiCc=; b=h4X2lrMfdXrdfmgZ4xr5GdOISs
	7DTdy2fXpAViCNFdprH/YA/FaK5ElLy/oJJmk/Pjy/7FToesvL1xNyFIajfycSkc
	WkxMFITd62Y0nRwlJ7t5QM+DC27CP4B2CSDwQjLgV5oY/TY/OT3t2ZldMyyO9l4w
	H1MWHVjbKEgJK9XO7soRUSKlQLRHgTbioWzBLcnms2lavnKew81rBS6qXQo2vm+E
	A63jkboBvjJjOznsE634dg4NBHiY2ebDV7i/HW6eUBssfpwamjx67O7aUiOPZAg1
	islRgh/Fz39q5Wqhxn+Yvm3eGO5OeQB/lhOrEiSigO0qEKJl/P2Bqe7HC7JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787077069; x=1787163469; bh=kZDyJfOXDoOMR85GkK/jKcnmo6tWuGEX/pf
	zjUOBiCc=; b=Qzf8NR/HJN4r2/MXSBRKIpooQjKq5H/AwppnudSnUZPtKMufBC1
	kcMh7esqif4AAWKQ4fcR9+e5dqDEo+0e7g/IqI8KRRiqQTPN3Lw43miC8lofiMpH
	K58vEOt1JVER3DFw/YPU3UYaVqanflLRmjY1J/rt5QAwEYNjtUiozaVGN56dzm6O
	oKHV2E3ZztPh4x5qmZVHwqHDMze+yHnrQ/c/tqukEHHdmSETtv1VGEtl95VgV7Pv
	1S1SGGV6yIQJGs0R2kSq4ewueUtvNXr8sFiSH7IleeADxR6HchQC0Jla6VW1R4M7
	bwtj2a0rKWfn6FAhf9vC2lamZdFdQHKGuTA==
X-ME-Sender: <xms:zaGEal3YMOK0yablQEmTpmqlAfKci8p6oommnmUbq74x87pnJgKhPg>
    <xme:zaGEajilvf6Aeu8nB_PCr-h8gPElUYuvbPz7hG4yEwSk4X-44UbM7cTXtgx39D8VW
    PIt4bHbO_LT0E1RUKXQ2Ljor73ekHeJj_i0vmiDE2kmfwFvSq4DxQ>
X-ME-Received: <xmr:zaGEajSxTe3PhB22k6H0zQdrglmg4jBFGjV4KesHmfxfvnmPkbQfbnnrGGVAOnAkI79hNYUaEvYfWgGMCtFV36ARdIsbnzDUwg>
X-ME-Proxy-Cause: dmFkZTE7hqk2pkKxDMknYedVqQKbQ79Fy5PTaf1K+WXiW6YhDChKtpgZslc5HnbGIavWsE
    GZqY0MLZcQat4f2dobSXHBIDsgZ4rOC1tvKLl7sTsk1PRE+1Jc+AaUqe2R++HaaXAgfoPs
    NGTfd0hHE6iXDZIdke8XH84KmzwQreElCeb/w00/xgKyxjVrQhajl5anwwHxhKphER2G8b
    N1lxALTB/H0pI2VxnGve5M0T4zc5Gn2P6O9c55+0LyH2/cHV/inUPG70A7ZTotXCGhtSa7
    3zTVjNia88K+kO8Q9ObsAUITr7Qoqi517mq3X+qvxrpuAmGnQwdibje9tf41yCb7Zk84pR
    i+iVOLAqKfjYg+S77Dab7s4Z/KpdjPWpriTx+UNzbKgbtQ323T15k+mIPRnqicix3jOgSr
    zSlhPLVRMys3oQ14Dj6qQ1/7Yt8QAUAsvbazhCl/6Vwef3w8vWv9kuLh78zB4/uvPDWNoU
    EHbEaidHAM+JI/P6WLYJBoT437LMqWYJU9QNSaJkCydErxqNRspe3zFVZ2cRMpOrMZ31BH
    OCPCEcEB4X1TqenXNUhd49tStfhXquAgIdiLD/LtIxfAfiFH/dlykQvsUZOUAMuKfuWu1k
    6JzApGodpuAZepbAHVTjinuFQ5ROxKX6dAn89NtuD4dU6pkewtGdBM4lvXog
X-ME-Proxy: <xmx:zaGEasiuAzTFMDIXNLbrVgUUeHEwDfDiuEDqxxBlkOs5eybCKfTP3Q>
    <xmx:zaGEar6WWm_N7HlMVXay8El62PHIVa48WJLWy_nG1lozQwPBxtDXiw>
    <xmx:zaGEahBkupKyq5P-QkkPRhARTWUJ6LRtj1iKmhUznxk6sFDJxVPcMA>
    <xmx:zaGEaqYE1nuUz9GeTohsC-wjpGvpBKh8Ya3NzCVBFMvyxQfbPZuCBw>
    <xmx:zaGEajoPjPfDtMeYXocoEOoQDNGwOVGx-poav0R7_FaQdxdfRo-4X0Gk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Aug 2026 14:17:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/7] odb/source-packed: flag known-bad objects as
 corrupt and not missing
In-Reply-To: <20260818-pks-odb-generic-corrupt-objects-v1-3-ec234567510f@pks.im>
	(Patrick Steinhardt's message of "Tue, 18 Aug 2026 16:19:30 +0200")
References: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
	<20260818-pks-odb-generic-corrupt-objects-v1-3-ec234567510f@pks.im>
Date: Tue, 18 Aug 2026 11:17:47 -0700
Message-ID: <xmqq5x17z41g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> When reading a packed object that doesn't verify we mark it as bad and
> indicate to the caller that we failed reading the object despite the
> fact that it supposedly exists. This matches the semantics we have now
> established in a preceding commit, where we discern failure to read a
> corrupt object from a missing object.
>
> What doesn't work yet though is when a call tries to read an object that
> has already been marked as corrupt in a previous call. In that case,
> `find_pack_entry()` will tell us that the object in question does not
> exist, and consequently we'll not flag the object as corrupt but as
> missing.

Thanks for attacking this one.  I've always felt it awkward that we
treat a corrupt/unreadable object as if we do not have it, and we
even silently recover from it if we have another copy, making fsck
practically the only thing that notices such breakages.

>  int fill_midx_entry(struct multi_pack_index *m,
>  		    const struct object_id *oid,
> -		    struct pack_entry *e)
> +		    struct pack_entry *e,
> +		    struct packed_git **bad_pack)
>  {
>  	uint32_t pos;
>  	uint32_t pack_int_id;
> @@ -618,8 +619,11 @@ int fill_midx_entry(struct multi_pack_index *m,
>  		return 0;
>  
>  	if (oidset_size(&p->bad_objects) &&
> -	    oidset_contains(&p->bad_objects, oid))
> +	    oidset_contains(&p->bad_objects, oid)) {
> +		if (bad_pack && !*bad_pack)
> +			*bad_pack = p;
>  		return 0;
> +	}

Hmph, so the idea is that if you have even one bad thing, you are
marked as bad, because who knows what other parts of you are broken?

