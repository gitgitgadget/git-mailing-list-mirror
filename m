Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58119205AD9
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 05:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731390831; cv=none; b=IUjy4SoW6VmKYegHJmJBm0WN5Ncl4Gdt0owCiu07fjASS+JgQjOF7OTaN/Hlxj+n3bz9IWGCKd6jQnEz8yN/qeh/jNcku3V9hzDOr8ljNyroHUvdDJrnMNilRQjz+N9lCzOLCWHkTO7ZqWO5Oh0jVpF9tI/sEvfmVxc0QV71FhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731390831; c=relaxed/simple;
	bh=JDUjgE7I5fR7YYqxWZIYmJbeGGxhpyb8X6ilgLRpW74=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CGjAmC7LdzuqiB2vRqCxH3gockBBn2or07zDw6zruz7y5aKZ0XGz1Lm0NIf6QSXlUpCqS9uaka1SMAFlsuz/5+m/4X3sqMvh+58hXQuP/Oqax5jhIRmVbaQm63CBMscFR2OWJ7DIMy/E8V1MYYsgtBkKQbB0p5Gtz36V7SY+Nrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gcWnldkn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f8lirgXi; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gcWnldkn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f8lirgXi"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 55A011380648;
	Tue, 12 Nov 2024 00:53:48 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 12 Nov 2024 00:53:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731390828; x=1731477228; bh=Pl7/Pa3UAy
	MSCig0j4ithZnVEUUAo6zuGChHHKaUlZM=; b=gcWnldkn07LOhcyYrGTOEuUTHh
	fcf5ch836weIGW/znG23C31/YRSmsDm1I6hiH4q36Jlg4P1gDoCuk5kZQtZ2+iTx
	DqsWMqOMA5Cg0Z3evAss6pMfaJe2xY+1NuvElmkDl7330wiywyh3ND7tLAObHU0s
	XhNKy2q9jBiVZa+Yn4CEU1f+UmnMHUsfxXAIRZKcIeV+7TFHyr3nVrYFOXeaJvU5
	MtmclWLtiXvF2Pe3sa8AAkBXLqsE4ZSp/04mDKAusIncX+9IWOhuBQuX0t8DnHEw
	PYbLzAi8w4lzt8+/VA6LzaWyBVe1OaIAT0BWBpSyPZkmfJR6jzsomLbvFKcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731390828; x=1731477228; bh=Pl7/Pa3UAyMSCig0j4ithZnVEUUAo6zuGCh
	HHKaUlZM=; b=f8lirgXikPOYIwZHoihOFNDhOPibaqgdi89d4NQEuYcaogi598a
	rV9s0qfA4NFJcetayyN3t16YJTrnY/UfxII0yWZTKbzOv8XCb8uIXlirRhix2IRU
	BdWOUqlr6Z3j89x41IlQPmK4R8oxYGva1KvNqWz1F+5alNFhUNEWRXJIiM78104y
	As34woCKwHqD9S+DwSenq34anNp5NZLnliCAIAk2Iakt8P3/TCb6gE+gpbRMF2XE
	EO/3k/erDNP0bsYtk5VIRNsipDW1jgZ0zvlOBK90tmJ3RYbIS7sVjXzvmyT3aqEC
	1PrsgK3ui0AMtG0my6rewcbbXkasOhWENag==
X-ME-Sender: <xms:a-0yZ5N9KF17nP5dOKQZUXYn3Xw-T-Ma-lNyLxZtyzQXxijT-rnICQ>
    <xme:a-0yZ7-liZC22lKszt2dYWJiBz7gJRf0Lot7LSf8u64ohZdOtcFgUKZABk2GO_GqF
    GtZB5wh3k5b1e_Eew>
X-ME-Received: <xmr:a-0yZ4SE-ZrIkZ_syRsSUqJobMzsoAi1C3TaDkzgBKYAa8E8qjeHMk72ysY4vIOeaeF8npGo4sHAjjiNpagv5HN5YYGwTuxF6u-P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegv
    thhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehsuh
    hnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepjhhlthhosghl
    vghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:a-0yZ1tw3w9NxWFT3wUs8rWySf_OhF0FdYxgCDdNEBBRrQw_Wj30Zg>
    <xmx:bO0yZxddPDv981XnlXIMMDYwAObuOiVdflBLC_uN2TL2-uv69x2L3A>
    <xmx:bO0yZx3pcLi1PQ2IO5gTJZ9bn8kmW5QSu6KicVfckHdv26XHT1nAfA>
    <xmx:bO0yZ9_g3Hg1jYJlOOpTrGfXyveAFwDW5zAG2fbpk8KEdcJQcat0qA>
    <xmx:bO0yZ5RtTKqMOl3WPn6jBLSFIFNJj4enfkFhp-fZjEMq69ZRMMDwFquF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 00:53:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Edward Thomson <ethomson@edwardthomson.com>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 3/7] reftable/system: stop depending on "hash.h"
In-Reply-To: <745c1a070ddd7180f0ee89c6a1d057a256894599.1731047193.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 8 Nov 2024 09:17:14 +0100")
References: <cover.1729677003.git.ps@pks.im> <cover.1731047193.git.ps@pks.im>
	<745c1a070ddd7180f0ee89c6a1d057a256894599.1731047193.git.ps@pks.im>
Date: Tue, 12 Nov 2024 14:53:46 +0900
Message-ID: <xmqqh68d6lqt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 3c6107c7ce5..7d86d920970 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -15,6 +15,7 @@
>  #include "../object.h"
>  #include "../path.h"
>  #include "../refs.h"
> +#include "../reftable/reftable-basics.h"
>  #include "../reftable/reftable-stack.h"
>  #include "../reftable/reftable-record.h"
>  #include "../reftable/reftable-error.h"
> @@ -289,7 +290,16 @@ static struct ref_store *reftable_be_init(struct repository *repo,
>  	refs->store_flags = store_flags;
>  	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
>  
> -	refs->write_options.hash_id = repo->hash_algo->format_id;
> +	switch (repo->hash_algo->format_id) {
> +	case GIT_SHA1_FORMAT_ID:
> +		refs->write_options.hash_id = REFTABLE_HASH_SHA1;
> +		break;
> +	case GIT_SHA256_FORMAT_ID:
> +		refs->write_options.hash_id = REFTABLE_HASH_SHA256;
> +		break;
> +	default:
> +		BUG("unknown hash algorithm %d", repo->hash_algo->format_id);
> +	}
>  	refs->write_options.default_permissions = calc_shared_perm(0666 & ~mask);
>  	refs->write_options.disable_auto_compact =
>  		!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1);

OK.  With this step, together with the previous one, we let Git side
to use GIT_SHA{1,256}_FORMAT_ID to specify what algorithm is in use
in the repository, and reftable-backend.c layer is responsible for
translating them into REFTABLE_HASH_SHA{1,256}, which is internally
used in reftable library to convey the same thing.

Which makes sense.

> diff --git a/reftable/reftable-basics.h b/reftable/reftable-basics.h
> index 6e8e636b716..e0397ed5836 100644
> --- a/reftable/reftable-basics.h
> +++ b/reftable/reftable-basics.h
> @@ -11,6 +11,19 @@
>  
>  #include <stddef.h>
>  
> +/*
> + * Hash functions understood by the reftable library. Note that the values are
> + * arbitrary and somewhat random such that we can easily detect cases where the
> + * hash hasn't been properly set up.
> + */
> +enum reftable_hash {
> +	REFTABLE_HASH_SHA1   = 89,
> +	REFTABLE_HASH_SHA256 = 247,
> +};

;-).

> +#define REFTABLE_HASH_SIZE_SHA1   20
> +#define REFTABLE_HASH_SIZE_SHA256 32
> +#define REFTABLE_HASH_SIZE_MAX    REFTABLE_HASH_SIZE_SHA256
> +
>  /* Overrides the functions to use for memory management. */
>  void reftable_set_alloc(void *(*malloc)(size_t),
>  			void *(*realloc)(void *, size_t), void (*free)(void *));

OK.
