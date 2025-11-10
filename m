Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B704A34405E
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802970; cv=none; b=fJO/Kfg4CCi2fKmgme4r5p1YSGFavFP+RCfWk1VMMVfCQ3C4KECjI2O0i5Kb6SFS7uxc5vMAc/+H75Nri1ALEfMTV8lu2KP8teklOnbQT43YOxwvU9KnE5ZAr2+wHqS1J04+oVsPVwW9/eYSj9lsfFZZBx96++nZmhEfFHHxnoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802970; c=relaxed/simple;
	bh=SKjEV3zOQFuh9LZmgGww6h0RWEi5figXuPIQGhtd9Ms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bau6zh2zgAahtxdhey1gCJwuXjktQQi7l1tlrN8hgdE4hKMB4zYg0OBwZCXRWu1r0q5O4CMnldlSX+yQsqcz08FZMgTV8Oy7PCozjjJ+g24n1WEHTlbrL4/66yWOptPMeheWoM/4GkjNMcZ+vs7N7m0Gvyd8vv+4kQF4c+x2GWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ksq36/X2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CzV/TBKF; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ksq36/X2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CzV/TBKF"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E9E39140020E;
	Mon, 10 Nov 2025 14:29:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 10 Nov 2025 14:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762802967; x=1762889367; bh=enC3G9UwaP
	T1SUEsbHXm8QHw7shkllSpqIKn/IRXaqg=; b=Ksq36/X2V8zajGUZiieYMejUif
	xK2t32a1L0mQTk+lhzVrnqXprwrgJ2Cu3YlKqgD9ysGpluVeA6KvntChm7+k5Esm
	oGNqpPQ/oE7z9f1W8ckMwsb8an9Tp9yeJSkQwXJPTCE6bA52fYWfpohiRTnG4x76
	MoSjtW5R9DilCHoBI3jX0djZYtS0/MF1XYE/WvuZ0423FezNRftBYBRnH2ve8DjB
	gOexd4N7r2wG3kDEu4dnBRxTDm3JysiqWx9Q3wVfYSFDYHEQBkTso6zciUuGYZsH
	mdg/HgnlqlroAj9rRetSaHkr3uVP9EQuj66wzuoMlVC5QuoiPv+/yvM4E0BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762802967; x=1762889367; bh=enC3G9UwaPT1SUEsbHXm8QHw7shkllSpqIK
	n/IRXaqg=; b=CzV/TBKF4cal9zel0eBsTk9K8vLgzRK3ZGtwpAo6KHr2qejo0Ht
	688ToqwGxl2Zg/H+2EDkzQ30RBO4liQawB12VeR0+CzpwlCnBQHmifoor2wcMKXv
	rpgHsk9QCEJvae+psSu02bAVvfrxrQlwP3Xrkfe0jYUFwPgx/xxiyknkVov7572y
	gb60+6iy0YHYti5ymro4YdCf20uJM1dN+QXJgeD2EMNjNYWo1QVx95yIMzTaZvVy
	xYeQV074od4c4s1KqBCJbc/qu9toHvF+vmUM09o4AMkxeFkMsNcmQGnG1XTVRqJ4
	zMHyFlbO5wAG2jmteveTbBDGwAe8FT+NTLw==
X-ME-Sender: <xms:Fz0SaUSukyRMqjVxg0MIdSpYetHXoGsLPbHCo6OtN7Wo5HCWx4MICg>
    <xme:Fz0SaUBP8N5aCqzxKvkmY7vt_uEHBFSnlnCUs0lehOBFDq8oT4b1l_68PVyxHufri
    LBRFCmvaxzHTOXgShYJ-JzVXydkER5O-VWoC1BXI2SnoNeEYcaP>
X-ME-Received: <xmr:Fz0SaUEayU3KxloKyEqy4e6cIOa18rYPJYCbjkPwL8fMTyBITRC3E69IKpa9R-B-whE6saxK3qCasDKAYyCLTmc8FriDmp4uq2Eo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeludehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtph
    htthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheprggulhhtvghrnhgrthhivhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Fz0SaeAB0uwSo3mtl-r6097bHhaYvlNVruAwcOjF6V9QpcPa5cNVSA>
    <xmx:Fz0SacXgTsVBA9-cLBa3jFcffXmcv3xPhea5aihs93wUakWsC3QgJg>
    <xmx:Fz0SaaoRcD5ffc4Q5K1kkAzUgJ81_pMwrNmZXA9HDssoC9GhZrWCfg>
    <xmx:Fz0SaQSdKG6PBf54y4Hnq6i0sErcGcYkR2QXdLxNKpvCFn2OQjHdsw>
    <xmx:Fz0SaeFn1YdZzggC1axOSI_11Nmkclwz6_VbRg8EpW_SCkQR1O2jJtvD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 14:29:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>,  Phillip Wood <phillip.wood123@gmail.com>,  ZheNing Hu
 <adlternative@gmail.com>
Subject: Re: [PATCH v2] commit: add --committer option
In-Reply-To: <xmqqo6p9zo8f.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	10 Nov 2025 11:22:56 -0800")
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
	<pull.1997.v2.git.1762793782815.gitgitgadget@gmail.com>
	<xmqqo6p9zo8f.fsf@gitster.g>
Date: Mon, 10 Nov 2025 11:29:25 -0800
Message-ID: <xmqqjyzxznxm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
>> Co-authored-by: Aone-Agent <aone-agent@alibaba-inc.com>
>
> What is this second author and how would its presence in the author
> list interact with your DCO obligation?
>
> How did you make sure that whatever is in this patch were not copied
> by the "agent" from somewhere that we cannot copy the code from
> before deciding to send this patch?  The "cannot copy from" may come
> in different shapes, from "their code is proprietary" to "their
> licensing terms are not compatible with GPLv2" to "they welcome us
> borrowing but we must give credit to them", any of which we should
> be careful to avoid.

Well, the last one is not something we should *avoid*.  If their
licensing terms are compatible with ours but they want to be
credited, then we comply that request and credit them.

But I think readers got the idea.

Thanks.
