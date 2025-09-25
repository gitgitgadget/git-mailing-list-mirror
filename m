Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9F819F40B
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820062; cv=none; b=sVcZVMwMrS4UWfa3SzYcCFA/pm65rkFNM5fafkXXglAsIrUmfmmPV/PMkIHQ18MyJbvOfJpiPI3Twd3GnA7DYxNir+YLAue7fIHJcUszTyEmhJTVAWBvkdtO2zEBMmWlvfMEnzkDNTK1aNY4/0zE0rCecYaZLbd/eIwt5K+FJys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820062; c=relaxed/simple;
	bh=2/S0g7o7sTbvDn73WYZz0htkwAZURa20v4qz4F72Y/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uTKIDKNmlmqrtRv8/rtg3A1WYjHEKAXbBCqB9KsoCFaaYVrVvZkDtGHbwt3Cl/pSZmhkxh9qOMAu4+866N2EpEdXUWB9HAfyGUTxjbVXYXjQyiCzMn+RTh0qayK+NM5Ne1hZlUM0CJpgX67gXv6g3a35D83edLJXSvieFBobVQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oDNXK6NT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KUmBhxBA; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oDNXK6NT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KUmBhxBA"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 110C21D000FD;
	Thu, 25 Sep 2025 13:07:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 25 Sep 2025 13:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758820058; x=1758906458; bh=/zb8KPp1mi
	G9PYzN85XD2zaD1XfDP0z/CAb0FzPDY/M=; b=oDNXK6NT20PzWFT2oB9RuOEbnE
	Z3hj5jYotYSPKNmteM5UCga88va6Ye2R35qyPcIJ2Y2utwAlTZXL1v4AEftmOCfl
	KYWJhBuFWLabhyB0GFcQFesEvdktqB7H+xpqTZ8uDSaBmi+Csa2/NUKZ8Kj5diEq
	VOkBI049Bewq7d9nw4R+VpITy7LbZU54RpoQ5hgilkl6eaVhulmAi1Cq7i/Gbcn5
	UXPMGahpBj0oyGZ7xmKsR5e0fxB6U4j4KBJAhJRm0uKM2W6MbcSRb4S1S6/2GrIi
	aopKU60FBc9WztZQF+VbW1h5k9mfiB5I0dFV0C/vG6i/J6ZhVIdfoFVl+dug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758820058; x=1758906458; bh=/zb8KPp1miG9PYzN85XD2zaD1XfDP0z/CAb
	0FzPDY/M=; b=KUmBhxBA2YthoMXrjJyv3dOqdHnv9Cht6gsiu+b844j41rvGNyW
	cwWRY6Jqw1nxfZLMb2NWpH3Sgs4bNYLxcRivoKN5Qf26idB2W/2UWXMWAYuLz6vN
	DkrJwioZCpbRzMwASMwpMjQbzTtOgMIHt9Np0HY3IQMIMPvxocIlGe91mU9y33pk
	RpxHKRhzyO1e2XdsRFlA26uhF1UND5i/mBsmna2Y3wrrrKNX1o+Tv4XaGChy5yCL
	/s/5L9R296fL36/0ZTePrYR6Fq6siDrvTUsoyTJ45VC0pc/eKiTXfrrU+876eZ/g
	2FrQMCCNW+RMX540FLqhKjOwQ0w7C9oeTAQ==
X-ME-Sender: <xms:2nbVaItsOVp6xjojvubr8lUS5afs7lB4r6m4js3KQ-xxjtz0_vmbWg>
    <xme:2nbVaMfZSv_LAU5EYpnb1jF6PYTZ-0ZxURXOTGlbWYvrY84B6jJuPKJYYERlgX284
    wOXpNimRy08N1rndd5QcNJEhLcFkGWKVzXihTQHBuXnNGjNzecKDA>
X-ME-Received: <xmr:2nbVaIyR5bUj6L03tQuAa33ymDjdeM0PeiAJgQ7NzKV8Qj4wp-uIV2ck1yKC_rUYxvAIp3rxXzZ1d14CKB8H2GXRlXUaPwZQ8xXJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2nbVaKHOsiFp-5H040ESUvtWesApPcHS8MdV-74_SZcJxRgIoL26Zw>
    <xmx:2nbVaEzWc8bEJirAEQdM6JE-3Smtw23RNrvykZ81UjGcc3QjNt9jJA>
    <xmx:2nbVaDvUgFbjZK6-04Vc1MoO4qtc9tGmSW_W10sHpYUbjsWgYbK-sQ>
    <xmx:2nbVaJ1y1utoubTESFlrE9nqoWxfjUvSpkU2tQePjO43uldXqxIe9Q>
    <xmx:2nbVaMSejS8QjW7qXPo2WyK9dQ5NXz0HAXgUcUpF4Do5tJYtM4VIDfB3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 13:07:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2] refs/ref-cache: fix SEGFAULT when seeking in empty
 directories
In-Reply-To: <20250925-583-git-for-each-ref-start-after-v2-1-3613b5a27ff1@gmail.com>
	(Karthik Nayak's message of "Thu, 25 Sep 2025 11:15:07 +0200")
References: <20250924-583-git-for-each-ref-start-after-v1-1-c73be2b5db5a@gmail.com>
	<20250925-583-git-for-each-ref-start-after-v2-1-3613b5a27ff1@gmail.com>
Date: Thu, 25 Sep 2025 10:07:36 -0700
Message-ID: <xmqqbjmyh353.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> index c180e0aad7..e5e5df16d8 100644
> --- a/refs/ref-cache.c
> +++ b/refs/ref-cache.c
> @@ -539,7 +539,7 @@ static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
>  				 */
>  				break;
>  			}
> -		} while (slash);
> +		} while (slash && dir->nr);
>  	}

This is at the tail of a "do { ... } while (...);" loop, but inside
the loop I see this construct:

			for (idx = 0; idx < dir->nr; idx++) {
				cmp = strncmp(refname, dir->entries[idx]->name, len);
				if (cmp <= 0)
					break;
			}
			/* don't overflow the index */
			idx = idx >= dir->nr ? dir->nr - 1 : idx;

i.e., if we scan all the dir->entries[] elements in the innter loop
and did not find any hit, idx would become dir->nr and this inner
loop runs to the end.  If (dir->nr == 0), then ?: operator [*] would
become the idx = (dir->nr - 1);  And that idx is used for a while
before we get to this "while (slash && dir->nr)".

And then tha tis used like this.

			if (slash)
				slash = slash + 1;

			level->index = idx;
			if (dir->entries[idx]->flag & REF_DIR) {
				...

IOW, isn't this check a bit too late?  I wonder if we can leave at
the beginning of the outer loop, even before sort_ref_dir(dir), when
dir->nr is zero, or something?



[Side note]

 * I found the problematic ?: extremely hard to read, given its
   contrast with the terminating condnition of for loop.  If you
   apply the discipline to keep the textual order match the actual
   order, i.e.

	for (idx = 0; idx < dir->nr; idx++)
		...;

	idx = dir->nr <= idx ? dir->nr - 1 : idx;

   people would have spotted this more easily.

   But perhaps that may be just me.  Anyway...
