Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A53D23D2B1
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770158170; cv=none; b=bmZ8EkcQdywh1SHdgnIbWz+08GRzqauD3NFe6V9W6lrY0vFw7lqIGToKvKtxKqMwiJ4mcor9GCLRqhiid6aK/zlgjUwhjieCKt7drjQiZ3Eq+TxRStcSBWstFGroK8w706/kK8o/6DCTpGuH6b75kn4DHXGQvqOriOrO1BnVKOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770158170; c=relaxed/simple;
	bh=O5qMnSiYvREntqHFZBniR7dv9vTHIdOfAFgDyLXCqQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YkyMHlYwWfXseY+edn69T1GPEX01GJ6TRt/Xm58BFfCZg3/cVbrhgeMZ7xl1gvzC0UslFxB3zl25+LcfmYXpOJ03NK2+Qqk1MrfbKJJADQylhGFUAdpmZVsxPJbcNSzVGemPxmpnV1tfnp8V3mCtRuv/JBRQJ9/ZPLG1/RT4Euw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L5KBUdYL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vdhbob0o; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L5KBUdYL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vdhbob0o"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A1CE51D00127;
	Tue,  3 Feb 2026 17:36:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 03 Feb 2026 17:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770158167; x=1770244567; bh=K15UvZhPCr
	2mns5PtSItdRrdbNlK9N0F3a0Px9/a2aQ=; b=L5KBUdYLCyvcaMdqaU8ayS0O21
	Vdn7OmWRZHnbP86acJSX4vSGa1gvxk69WLcpHjWYPKlmBLPsfwoYBLix4Uu/CFCQ
	W6UBg6+kxEE2i7z0rhqN27eIAKSqXqbxq0UUgKTETDsVwAaAU/rWTHWqEdY4MJQo
	2p5bmrGjc7ayY61pSXffZYAWu0GMlmp+jwPhTTFGMlfEGE1GboNPwhLFlYJoX+2Q
	jyIKWe5gFQD+hhf6djCe+CEzd0hpgqVSf7+m1z6ffC80/RW5JgVmZw7OeDKyTtxK
	wnGPxWFuty3S+4uVwCPeNhUu+gz4YixrlOHr6TRAFMh6BovqD8/yJe/Ke/GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770158167; x=1770244567; bh=K15UvZhPCr2mns5PtSItdRrdbNlK9N0F3a0
	Px9/a2aQ=; b=Vdhbob0o8hYxoJa0sAZoMs6wkOlsA16z8rq0LTd4TfTPXw0TJSI
	t+SxNwE3zYl8Gd6cSwWVOuMeGKOzra4yCW70Or5gFMF8VuHDNDSWmhrhrcIaP1TQ
	fHT8RwwSCUXQ7EmuBmnu9rh0W+ptm9V72TXbsEwNWfSv0D+bjHY30siGLEUNmq6E
	Kh8uCWZLT/NxA3YQYIgAgkhsi2qQnqQLnz/KyzV0xh6tcnCF+N7NT+gp7AK6hwUB
	osoNzDDiO6AItOJ9ZImbFz5x5G+NSGnmfdCI2aEZKxjR+cDyGlCuy71uMQ5l3Z1B
	IbEwdBd160rC7R71M/BUD2vUr0JrvoUaAlg==
X-ME-Sender: <xms:V3iCacUduas2rBQ13NCSvrj6DhZe5X0vASnFw5f9MI527RIRytG5dw>
    <xme:V3iCaYCi_meZPKo7a8tzcBYEZVYXctIOJh6CzeLAaQWr6FfNwM4baf652FTQGxklq
    RibUyCk-blk8dHqk0fRBo6U4boaBbAb6MB9a2Vmtn9o9rMRjeKojQ>
X-ME-Received: <xmr:V3iCadw46A_5gPt5ByqtjrSvuGYNOnupussw6eHJgP_2U7eGsqv9fyIjxB7glZpvbZmVrARCHkfOP0bD_LxvvmyPsEbhM_DsaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeduvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:V3iCaVBhkIQoWIH_2quKfa4Gw_kih-AR5eQ630-LUTVnl4IGa8uNUQ>
    <xmx:V3iCaabKCKnPGRgoF1Cm42BLcJuztfp7MXgFp0T_QmRBpH2U-jPdlw>
    <xmx:V3iCadjtaK7mlEYYBYi9RwVZqamW_uHfwkX2n_kEkwPK6GPastT-hQ>
    <xmx:V3iCac5eUImNJmU-QFC7a799oPPkBHNC17-6i84eg32OsjqeQTHnoA>
    <xmx:V3iCacBsYHvKaMyLJaTNUUdh_ofIMk3uxLaoRCPKiNFyswUpSsZkCEJK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 17:36:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] builtin/repo: update stats for each object
In-Reply-To: <20260203221758.1164434-2-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 3 Feb 2026 16:17:54 -0600")
References: <20260203221758.1164434-1-jltobler@gmail.com>
	<20260203221758.1164434-2-jltobler@gmail.com>
Date: Tue, 03 Feb 2026 14:36:05 -0800
Message-ID: <xmqqzf5pqwtm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> +		switch (type) {
> +		case OBJ_TAG:
> +			stats->type_counts.tags++;
> +			stats->inflated_sizes.tags += inflated;
> +			stats->disk_sizes.tags += disk;
> +			break;
> +		case OBJ_COMMIT:
> +			stats->type_counts.commits++;
> +			stats->inflated_sizes.commits += inflated;
> +			stats->disk_sizes.commits += disk;
> +			break;
> +		case OBJ_TREE:
> +			stats->type_counts.trees++;
> +			stats->inflated_sizes.trees += inflated;
> +			stats->disk_sizes.trees += disk;
> +			break;
> +		case OBJ_BLOB:
> +			stats->type_counts.blobs++;
> +			stats->inflated_sizes.blobs += inflated;
> +			stats->disk_sizes.blobs += disk;
> +			break;
> +		default:
> +			BUG("invalid object type");
> +		}
>  	}

The repetition above makes me wonder if it might be a better
organization to have

    struct object_stat {       
        struct type_stat {
            size_t count;
            size_t inflated_size;
            size_t disk_size;
	} tag, commit, tree, blob;
	... possibly other members ...
    } *stats;

or even

    struct object_stat {       
        struct type_stat {
            size_t count;
            size_t inflated_size;
            size_t disk_size;
	} t[4];
	... possibly other members ...
    };

and have this part of the code be

	struct type_stat *t;

	if (OBJ_COMMIT <= type && type <= OBJ_TAG)
		t = stats->t[type - 1];
	else
		BUG("invalid object type");

	t->count++;
	t->inflated_size += inflated;
	t->disk_size += disk;

but that is probably only because I am looking at this part of the
code.  Other parts of the code may have good reasons to have the
structure nested the other way around like you have.

