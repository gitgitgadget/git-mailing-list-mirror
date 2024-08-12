Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A314B1802AB
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723496749; cv=none; b=Ao5JxkStB/QqzTGV5Pg+Vx51MzVZ7/xqMmwhP2HLkc4vhBhgmSvJdaWFtxsT8Pb2ELANiDvVnjqQB/iFJBk0HHNRnamoJFz33rd0czu0Apz2T8LqqCys/1nmKIsbVt1O3AaxW7C8P2xtDpHpHXXZDetqoSy/8hWpYWmcKTBCNcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723496749; c=relaxed/simple;
	bh=r+HBnVeIlgiEcqv5/kzEX71alfiFwW0QNCyMlkKpnfo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EB3lYIU13zybv4Y+m4aH6wyCcz1B8c7pbI6EfihDBT6GCWQTznafXuLJ6FBnsgDyRAj4vWyb/VFSi1ApzlhvEiAJxKHBcAhSkoxi6jQa0XnNyf2o23ZWfoGbFm7glX2R2LLkcwDS+Rk9Eo0kDIHuMRyp8Yn+9lvHl6MkgEvu5Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QJkBpoGk; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QJkBpoGk"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2B2F63EB8D;
	Mon, 12 Aug 2024 17:05:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=r+HBnVeIlgiEcqv5/kzEX71alfiFwW0QNCyMlk
	Kpnfo=; b=QJkBpoGkmCHGW6l5vl44oiKuYg83vXIKB9D6usQ6vB379+ADACiT55
	Ped7rv+/IbCAUUdvaJyh+sYukbjYd10WhrIJ4b7jOqU7WLknW5PGZUa18UihND23
	3psU5CAySZbQYo8bSrv6pe3El8T5wOrGljI1hVJ97BQEp3NERewFQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 24FCC3EB8C;
	Mon, 12 Aug 2024 17:05:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 00C6B3EB8B;
	Mon, 12 Aug 2024 17:05:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  vdye@github.com,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 2/3] for-each-ref: add 'is-base' token
In-Reply-To: <13341e7e51241e077a85ea83eb76d4e48d04be7b.1723397687.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Sun, 11 Aug 2024
	17:34:46 +0000")
References: <pull.1768.git.1722550226.gitgitgadget@gmail.com>
	<pull.1768.v2.git.1723397687.gitgitgadget@gmail.com>
	<13341e7e51241e077a85ea83eb76d4e48d04be7b.1723397687.git.gitgitgadget@gmail.com>
Date: Mon, 12 Aug 2024 14:05:40 -0700
Message-ID: <xmqqsev9zc2j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A2E56E4E-58EE-11EF-982F-E92ED1CD468F-77302942!pb-smtp21.pobox.com

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +is-base:<committish>::
> +	In at most one row, `(<committish>)` will appear to indicate the ref
> +	that is most likely the ref used as a starting point for the branch
> +	that produced `<committish>`. This choice is made using a heuristic:
> +	choose the ref that minimizes the number of commits in the
> +	first-parent history of `<committish>` and not in the first-parent
> +	history of the ref.

Very nicely described.  

Giving the end-user oriented "purpose/meaning" first makes it easier
to understand for readers when they want to use it, and giving the
heuristics to compute the result (and the example) next allows them
to verify that the feature matches what they are looking for.


> @@ -2475,6 +2495,16 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
>  				v->s = xstrdup("");
>  			}
>  			continue;
> +		} else if (atom_type == ATOM_ISBASE) {
> +			if (ref->is_base && ref->is_base[is_base_atoms]) {
> +				v->s = xstrfmt("(%s)", ref->is_base[is_base_atoms]);
> +				free(ref->is_base[is_base_atoms]);
> +			} else {
> +				/* Not a commit. */

This is unexpected.  I thought that most of the branches except at
most one that gets annotated with "Yeah, this is forked from branch
B" would take the "else" side.  They are still commits, no?

> +				v->s = xstrdup("");
> +			}
> +			is_base_atoms++;
> +			continue;
>  		} else
>  			continue;
>  
> @@ -2876,6 +2906,7 @@ static void free_array_item(struct ref_array_item *item)
>  		free(item->value);
>  	}
>  	free(item->counts);
> +	free(item->is_base);
>  	free(item);
>  }
>  
> @@ -3040,6 +3071,49 @@ void filter_ahead_behind(struct repository *r,
>  	free(commits);
>  }
>  
> +void filter_is_base(struct repository *r,
> +		    struct ref_format *format,
> +		    struct ref_array *array)
> +{
> +	struct commit **bases;
> +	size_t bases_nr = 0;
> +	struct ref_array_item **back_index;
> +
> +	if (!format->is_base_tips.nr || !array->nr)
> +		return;
> +
> +	CALLOC_ARRAY(back_index, array->nr);
> +	CALLOC_ARRAY(bases, array->nr);
> +
> +	for (size_t i = 0; i < array->nr; i++) {
> +		const char *name = array->items[i]->refname;
> +		struct commit *c = lookup_commit_reference_by_name(name);
> +
> +		CALLOC_ARRAY(array->items[i]->is_base, format->is_base_tips.nr);
> +
> +		if (!c)
> +			continue;

Hmph, wouldn't we want to leave array->items[i]->is_base NULL if
"name" looked up to "c" happens to be non-commit (i.e. NULL)?

> +		back_index[bases_nr] = array->items[i];
> +		bases[bases_nr] = c;
> +		bases_nr++;
> +	}


Thanks.
