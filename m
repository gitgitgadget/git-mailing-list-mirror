Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685D72D46B3
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 18:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781117824; cv=none; b=B6Q3JSL35DFFD9+k6HqDpqoZh2VIWf0CcAj0SWeQ2j2OQmg0Vfkq6eS55wv+nYyT76hik5RVFpcl1PBYBFpuvCXsrsXv4wiZiLR+2Vf3DJMoWuxvPWBykT8wfsqRUNkXVk9qMB7q23DxB01yTQeXamax3SMaabvwcjg20FVoEVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781117824; c=relaxed/simple;
	bh=IVO5yXuifL9WZ3JEQXJduwIuBIwCU5yQkPFvvZl/RVU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FkDZWNSYIYOiJx5wXJzQVee2Ox3jHkz97/BnRGVtv8KE4E2PWei7GhTGlH5/dgannWRwxJyhbclT3IVOX1e8sv1tgKvVdM5+TZxe/LOYxG0QFMRFz/S1OvZx1AxVtVafZau3D1EWY9uNBwCccmodRCNViGC60ETHgXaTTnXVn+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nc97vWEs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S/eA865m; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nc97vWEs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S/eA865m"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A78BD14000A4;
	Wed, 10 Jun 2026 14:57:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 10 Jun 2026 14:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781117821; x=1781204221; bh=Ucs/IZ2xFa
	5A9W8tsHWYzw2v6cgra+p9YQDFLBS2oEs=; b=nc97vWEsx7PGiYQ9KFSXieZaNE
	hLzCOgY/toAZXfXBkxmkyUfQKoXcNm1FKb8+eelSacxLO7UtkT+iCwLj0RiH50NJ
	is280UiOiMZxM1/wvj4f064v5NTik2qcspKKd2ieyze8wIakqJ8mq3zA/QPL5SR9
	JqsjFJAV40uoxosR0n+BVVE95FiXcB+DFIBeZ/ZgRXSU8ZFJmf4ZU1/aCPg54mlH
	POv7RyQeERnB7GrEOZw8Pn59FhPeg2J+P4bY+D5jglD7MHu+XzEOlLkVD8silvIw
	zm9NMrESRgJsdhCD6MeuP9cjDzjiUYo/Nb28fqK2mlHU3Q8qb8/vYsTs/lPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781117821; x=1781204221; bh=Ucs/IZ2xFa5A9W8tsHWYzw2v6cgra+p9YQD
	FLBS2oEs=; b=S/eA865mupbTU0gECjAywR0cG0MdAGxxL+18xlkMtHqjWwgDDvE
	vIClavrtbMEeqcYI9s3sEAdZV9LMidtnGBMFiTBq3vI6T3UJeYbER+g/rVxZETKL
	4r9cYxSiAAY7NAA3Jzx2ziC9f5wNe2oJ9WOb5ylWWxP/ow89RigZIFJ0UFKS3bwv
	HD8k+ZgfnGzg7Zy+wCPyAUbpYT8rcrAQdPh1G9Eva2DcOJLkV33jbzoKadhp9kD7
	iITXDd+Qtx8l4unMEBQs4HmnzinBeaYoCR2pJXgpDSAKMnO9rMTol5JDTOMQP4Xi
	KovjvEeeiTLLSyNXHxYqfxfNBgjx498ES1Q==
X-ME-Sender: <xms:fbMpaneaiRFX9v92ZHM2Pse5jGfLWj5eYSJEVkwSYG75EYf_EofIog>
    <xme:fbMpakNvQBOAi1E8f7ECO2Hjf_rZmyV48L4s1jw_Q8SfR4Cy6eMRxGI8Mz0nyAu3v
    rODrjhv1tZupnOWyuY579787nIHpqpAkw7uD7VrqpzhrAx1-TELBA>
X-ME-Received: <xmr:fbMpalifEzA1MEbM5Y2U3rYO883nQEZpVroxbEyoobMLaEa19alFDs-SXDKjje0wEev_V6H1ZIxOLYlK8004iUTSagNmFYPsT9Tj>
X-ME-Proxy-Cause: dmFkZTF8Wt2D+bft+P0xBshC6GXnIvz+/cAH6akA8I+Vu7Fn2Wf0DxRlnOCM8a8NU3vvLk
    FTBfS5TwGiYbirv47y9DJpm8Il2/S8OmkcYQiBdCxWhUHlVgRzolq30dXifdd/K3KTxyOo
    mt49dM79Li5BYIFBocOdGcxfUjkMNHmcqp4CjtbkRLEadgxemaFaodQFz7I2FdFEtNUiTm
    iN9kl+P/ymjU9nANK7wzvFR0Pt+lyMKF+0dSzY8hWQr1yKsRVUpWxc3R/JOBN3Rj+7vHQG
    pwPMB6eQEKMxaWBJTtHa0QNTCI/bc6CLFIWZB+osIQp7H/aJrazxjWf1A2KHR2W8ANuSrA
    5ZWafjp1i+pp0JbHyQqHHa+zR2Sh5CnwHMQSp/9hjXCMXlC3yqJwHYotJsIcgnr6LYv7Cj
    4hbRjn3HdFcsqUuflcg2/868cFwWKqfEJDMdGi0PmD7fiaRc6CYXiarpCW9h6VfzMHjyxM
    E+lOfegdz4WSm2kdIG8AnWvdN/Y9eWY67wGHbsGTnZ7kXddig0Xe/umHOYwLXMfnIwr9FV
    rNK3E1zhM6beoFIjQlz5NiUnAUCFZcXkYiYGmnVCcZKm/RNpBsMY7/8Z3ryB3vguW8TiCu
    C4GVPbfVYwIUzjTZg+yoiMrlE1Ff4YgyxFFGqA2pp1+0/ak7R+MNi+/7uSJQ
X-ME-Proxy: <xmx:fbMpan32wydN0FxaE4fjil3uTxaqd6c0rwGvvAkbtGM5M2eqFhBn4w>
    <xmx:fbMpavh2YUyaeCUzbWd3-FgCYDltwBCEL_nZHzQIvF0-HgefafJ6lw>
    <xmx:fbMpanfFmCHG5x1xGHhRkscS8f7I7Dst3HQk6upKgeFGrt1LdAdDMw>
    <xmx:fbMpaikRFFOPeHGU-ItPZYI-pm-KqKwwHmooGUarzBCn0Pf-_q8IsQ>
    <xmx:fbMpapBjXiWOcLumTBaM8MmazFV22Z4f4VUM4cNV5d3hUZ6w5RrgbJwL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 14:57:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Zakariyah Ali via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Zakariyah Ali <zakariyahali100@gmail.com>
Subject: Re: [PATCH v2] completion: hide dotfiles for selected path completion
In-Reply-To: <pull.2311.v2.git.git.1779808987825.gitgitgadget@gmail.com>
	(Zakariyah Ali via GitGitGadget's message of "Tue, 26 May 2026
	15:23:07 +0000")
References: <pull.2311.git.git.1779590184752.gitgitgadget@gmail.com>
	<pull.2311.v2.git.git.1779808987825.gitgitgadget@gmail.com>
Date: Wed, 10 Jun 2026 11:56:59 -0700
Message-ID: <xmqqik7qusuc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Zakariyah Ali via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -# __git_index_files accepts 1 or 2 arguments:
> +# __git_index_files accepts 1 to 4 arguments:
>  # 1: Options to pass to ls-files (required).
>  # 2: A directory path (optional).
>  #    If provided, only files within the specified directory are listed.
>  #    Sub directories are never recursed.  Path must have a trailing
>  #    slash.
>  # 3: List only paths matching this path component (optional).
> +# 4: Hide paths whose first component starts with a dot if this is
> +#    "hide-dotfiles" and the third argument is empty (optional).
>  __git_index_files ()
>  {
> -	local root="$2" match="$3"
> +	local root="$2" match="$3" hide_dotfiles="${4-}"
> +	local hide_dotfiles_awk=0
> +	if [ "$hide_dotfiles" = "hide-dotfiles" ] && [ -z "$match" ]; then
> +		hide_dotfiles_awk=1
> +	fi
>  
>  	__git_ls_files_helper "$root" "$1" "${match:-?}" |
> -	awk -F / -v pfx="${2//\\/\\\\}" '{
> +	awk -F / -v pfx="${2//\\/\\\\}" -v hide_dotfiles="$hide_dotfiles_awk" '{
>  		paths[$1] = 1
>  	}
>  	END {
>  		for (p in paths) {
>  			if (substr(p, 1, 1) != "\"") {
>  				# No special characters, easy!
> +				if (hide_dotfiles == 1 && substr(p, 1, 1) == ".")
> +					continue
>  				print pfx p
>  				continue
>  			}
> @@ -675,8 +683,10 @@ __git_index_files ()
>  				# We have seen the same directory unquoted,
>  				# skip it.
>  				continue
> -			else
> -				print pfx p
> +
> +			if (hide_dotfiles == 1 && substr(p, 1, 1) == ".")
> +				continue
> +			print pfx p
>  		}
>  	}

Having to repeat the same thing twice here is a bit unsatisfying,
but that is not a fault of this addition.  I suspect that it would
have been simpler to patch if the original were first simplified
into something like:

	for (p in paths) {
		if (substr(p, 1, 1) == "\"") {
			p = dequote(p);
			if ((p == "") || (p in paths))
				continue
		}
                print pfx p
	}

Then the new "ah, that thing begins with a dot" logic can be added
only once and at an obvious place.

> @@ -2164,7 +2176,7 @@ _git_ls_files ()
>  
>  	# XXX ignore options like --modified and always suggest all cached
>  	# files.
> -	__git_complete_index_file "--cached"
> +	__git_complete_index_file "--cached" hide-dotfiles
>  }

In this patch, it is hard to tell from the patch what _other_ calls
to the __git_complete_index_file helper lack hide-dotfiles flag
(i.e., they are to show everything including the path that begins
with a dot).  I will not try to be exhaustive, but for example
_git_add does not get hide-dotfiles but it is unclear why.  The same
for _clean, _commit.  But _mv does hide them.  The choice seems
arbitrary and incoherent.

A few ideas (some of them may be mutually incompatible)

 * Instead of "empty vs hide-dotfiles", perhaps make the 2nd option
   mandatory for __git_complete_index_file, e.g., "hide-" vs
   "include-" dotfiles, to make it easier to see in the patch which
   ones exclude and which ones include dotfiles.

 * Extend comments like we saw in the above hunk to say why we treat
   files that begin with dot specially.

 * Make __git_complete_index_file unconditionally hide the dotfiles
   when there is no match pattern for consistency (getting rid of
   the need to explay why).

