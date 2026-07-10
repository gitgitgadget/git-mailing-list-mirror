Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2C540683F
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783698405; cv=none; b=q7eHzYW5fIgMdkr05cMdzz3iIJ3kjvRMaKjKbD5nQgUmDr7hFMn3GxkwDWqVi/zV2ZepKGZq6MxmKoyU/Ojh5dORWQuBBEN8tvJKA3zot5ja2dH+LMiseQff+nCThKZ+lGVJeglWpmeCk2PJ2GsAgcGMGStUxj7y42yndlGcr/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783698405; c=relaxed/simple;
	bh=WhoE6WpgPTDeMZ5e1y4zDkTKtspKuOmMx79tBCT1rXk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E8VpMuRPLy5zlegaF2gYmwZMYja3Bp+LiV5VL5APVAav3xZuVLXgTfN9h547kiZi6gM07l6nIy1VJw8+l/Cf+nNugORrbKzKt5EgCvUaPymzU288Zzs5+B9G1D9okPZDtquZBV0qjNYx75r3QfgyXGSrGWGqt675cbf9acLwcuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wzjX5Ipn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DIctrg2A; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wzjX5Ipn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DIctrg2A"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E9501400068;
	Fri, 10 Jul 2026 11:46:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 10 Jul 2026 11:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783698403; x=1783784803; bh=/4fEKmyQCV
	10zA5imHA4AL7E6X+5y1R5ZVaTzG9q948=; b=wzjX5Ipn1nYen7sYZDDDvKnwjy
	PSqTZ9KyT8zjQw/aZleuaiUJQOTqlGpQlGY7wos8O0TMw+mcdODxmaQCCKx7v5kB
	nJvDbn59DFDpToG81Kbt3202u8RGSX5veLVF7xjFw6ki+Bv3nxAemxx7YrvN09Qc
	2TwYO+ILbSX3WfhMm27tR36MbsD9uSyD169EmsxKT6ERa4kwFm/zJg5AtFgL0oww
	v//QKQVZ7zn3GrA1JRLSz5LquyfeoBOw2qUqvrVECpWZzHhIMs6rFrGFXJ3UKPtU
	RlsD35GmIx0/ssMqjaf6T7eJ/UJszby7zYEtfOSojfhAuG+KoUBV+WnjDDXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783698403; x=1783784803; bh=/4fEKmyQCV10zA5imHA4AL7E6X+5y1R5ZVa
	TzG9q948=; b=DIctrg2AizunE9Ed3U3mbZLwE9qjVAJwABOoVjU9zGzpfs8qH2J
	lZ2Mr8Cn2qIAU0hbGRabDQdYyoWYIm7745KtLL3TYm9hop4qc4uebS7WiLmAYux+
	NfOIiw+ZQsepzNFHmzXKYoQJFujH4YblumoSg5DKGDqs+DcyBkIt14NMcu6jmnFW
	/zoiiaK/NpxocwF6Ks3ELBpICzSeaeP+Rn/m1v5poPrlUbKjknLq4Dcru43Bv12P
	8ICnmtkDHRxLT68t4oFdlbNVdJmROKdgpvgw8BmCzHq/IEAPOs/A7TcfaniHPgbE
	OB9wpqN2Wep5Ay4yW4i33OiC//qDRe9tnrA==
X-ME-Sender: <xms:4xNRaqyftZe8OExebKJQSOofb5yx7yM6MNyPyJ3gMqwIizQUZp7A0Q>
    <xme:4xNRatREiIO-BqA5wdg6BVJnkUU_g4-fHbs73UsTpUw-OMx1Am5yxtU2A72iiBMqV
    sSBaH7xcRoG8hU8VlDpJrfr8FYimTX2AXb9HRjAvxIQxpaujW2wnQ>
X-ME-Received: <xmr:4xNRahXUNSjyhm4ieoWyi0R4HEuh3yEPNVHx-JzxEZbDgR9fkGmRtX95v2Uf2Q9t9KtUBpPVJ5A4JV9-rS2xZuSZt4UCY1oFypu8keM>
X-ME-Proxy-Cause: dmFkZTFGQZeIEikGlyuxTuYEUkvuqVkz4RUQ7EHVIQSvI0GUYZvJhmCy1G6xtI2IuvKwcI
    sQykLRbAohdfOv+NO3ugeJr3hmVz7AKzIJKEws9HuizoUmM25Jy6CAW3oe2jEYx3u+ptvV
    /szYbS9oRXv9JrvuUpiKNs8quYo0QYuQxpj4CTTgwr6euszrxx3EQ5vWRaSHpEmhHCZOxb
    8HD3w4+jmOdZLhoZQv/XJTREIus4DIrIazKR/YP8Q7FtfCo4q9QOJSCiNkVFrgaVECrmBs
    I385syJV2ycvl0V+7nHjNpxSbIRVH32ZOTLxzJtwN9rc94TQqARiwMY5LS66AMjoBGMgtq
    9ZONdVEKOiiDgwnCzzpvucOuOq9A1DNI1XXAm+YIRJPyLc0U49bM3iozRhZ8yKOiu+7ytp
    yxr8bPOKH+R6fzAKUBVOLeB/466tMRuJLVaWsFMeEEXcejNBJn42MSNeWIud1RgXBpTKZn
    RI5/yv/7LPKsuqPGZYxRIY4PONIxGZoxwdUHCkvAP3ep7AGQ+Qun0zWoHsKMAOKAA5RHXd
    PY3E412STN18WKhHLlj9FQtQ6pBByk2KLbWCfPEBSgDI8BdA9Ng3uJNRF2v1SABIy+40Uh
    VGXiwSOdEpoQWKkc4fGvZUv4UtJsxagwpI8pXrKBJg6FTGG/qB++LO5l8bcw
X-ME-Proxy: <xmx:4xNRavY48g15qurBMAhALB1D8U3AIlkJExkiyqWtLMhg1lPE1LFkVg>
    <xmx:4xNRan16WBO6fQo-DjJys6Xrb4ckh_yqVFgmnxbkyztsFq5meIPS-A>
    <xmx:4xNRahjDiloo7Epahmrr7o-FqPMRG1cWK3T8Gc2SwJYZ9kfTjRNUlw>
    <xmx:4xNRara0Z2r5oejL_kt60F2Xf5FIjAZUjTWbeOccxMjo51tNb5O4Zg>
    <xmx:4xNRamte6fBDGZzc7seMCScbVUS8VPCkU-OQ4HYtfalAApkDGV0hxlUl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 11:46:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 00/12] coverity: avoid dereferencing NULL
In-Reply-To: <pull.2174.v2.git.1783683577.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Fri, 10 Jul 2026 11:39:24
	+0000")
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
	<pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 08:46:41 -0700
Message-ID: <xmqqa4ryg84e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This is a continuation of the effort I started in the patch series that
> became js/coverity-fixes. This next batch adds guards to avoid dereferencing
> NULL pointers and accessing NULL file descriptors.
>
> Changes since v1:
>
>  * Calling remote_tracking() no longer returns -1 when remote is NULL, but
>    instead BUG()s out.
>  * bisect_successful() returns with BISECT_FAILED instead of the -1 that
>    only worked by happenstance.
>  * The commit "revision: avoid dereferencing NULL in add_parents_only()" now
>    comes with a regression test.
>  * The commit "bisect: ensure non-NULL head before using it" no longer
>    claims that the fixed bug can be triggered with the current code base.
>  * The missing shallow commit's OID is no longer computed twice.
>  * A follow-up commit was folded into this patch series that lets
>    write_one_shallow() avoid the rolling buffers of oid_to_hex(), as
>    suggested by Junio. It technically does not fit the goal of this patch
>    series (fixing issues pointed out by Coverity), but was asked for
>    explicitly.
> ...
> Range-diff vs v1:
> ...

I found everything including the new patch good.  Unless others find
more issues in this round in a few days, let's mark the topic for
'next'.

Thanks.
