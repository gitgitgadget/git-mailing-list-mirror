Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D0C27B347
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759954891; cv=none; b=EDMxXcFj2A/38E9KNirH0OITcdPuJQBG1RUyDjjoxzBXT5IV/kvZpRM1Yv7O5QG09s/aGNAtcBB2AhluAyjeY8JnNOpO9Yg319EFzSO4YN91VEmA9ppL0t5FTG3BvOvRn+eK4ZlqEebpHpU5ibX9Ldcya8Y2iCeea1OnsH7q+TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759954891; c=relaxed/simple;
	bh=8kQynGdqB7v6xX8IOWsNhd6q9bfTz6fe/ifDJZpKXuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWuaZ9wziHXsoz3UpS9q9S7Gd2PCqVAH1OA3vfzOQb2yMpybyYV0lXttzmkQvRrb6MZZOKWf3ebFA54Svot1TinH1DDklMt2A2ZvcE0gMqTJ3joXdhwfFOuqBjN+yYdwCu3FDMWacYaIU8SgJdsH1+hAli3Z0GSLhiB030yztcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Buetx29I; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Buetx29I"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-92790f12293so8577239f.2
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 13:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759954888; x=1760559688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L45ggJUE+KIi4l6lPv8fQWd4M/RqF7CXNvjGE7TZyFk=;
        b=Buetx29IA++j7vQc+/FgUxb8WggqGFLuTsFo8tJJYjMb2ZI8gcTcovLEUR6xHkz4lA
         gdFEqrQX64N8vJlDlWqHufOSK7/u81hGJoNPlFuc2rVKS0N1zEjmtn1U4Y6wURX4NR8N
         Q+rqgjVpuWX2TDyQKlNl/BlyRjmeaq+DaLYkp4nR+m03eYrqRk6aXSG/HwxbOEp1eT38
         6AKq18Td9MuL9cre6ej/JWbcaOxr4H7xy+dOIx7Okncu/jMGT6O/jwAKJ9Z6WCqogoND
         Ds/xQBytnoTshBFSd5a0GCoxVCfAViW1cmkwcraOzWPSSODHKKqN5mFjclt773DDTuk9
         hZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759954888; x=1760559688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L45ggJUE+KIi4l6lPv8fQWd4M/RqF7CXNvjGE7TZyFk=;
        b=CPQFaKrpMxgEPQbkArQp9BrzaMmDgniwz5VA392GGFQSIioZyQ+yOljdrJPw/tQr3K
         ZdZTaenn5RB2f5cippIk4fP56kVpYUEtVQGVBHUlIIjYDtsiib4JwEBbgIFBlRWiS9jW
         r4T6vAUW5wOtuo8z1oOhWtreApJ4dcLf4LQRXmbtqrw6wHK+5haUBFMrBVpHGeqFHxme
         BIA8/A6FaAQ+dDzaVDH4x4W+BOr+UNfomTwnOxHcEPj77pXWvXuO6X2AErG4kN+PaSmx
         9HMK2qkYrm0yqWPJ4XgOZDg0Prr+j6/2dcbVzb13cY/uRt/+K4dusOsmYFewcQGd3Dhl
         cEbA==
X-Gm-Message-State: AOJu0Yx+N/j9XzvrMMoIHo2h/y3/IE+3Y0ufKDzKYoUAIUVSly1mSE/j
	ZGBnFJ9XeluZ0CUnmmjURljbS5H8xPkqOXdPeuKjyAZ04C9YF7rbF3KOwHcVBL4mVeDFxLxX2n+
	vnU+TaRAr7A==
X-Gm-Gg: ASbGncsZ+C38PxQ0c1YnJ9NPrfhRJnrLKzOfbE2N8TVZEINg/ZnQwGr1Cma2UAmvKsf
	GCQBK1lZkXmq5ZW7TVpx07wAx3442p7UIv7yNa12Ha6zszHuGfl1UTOplg5H9fzTfE2gxEq0ZdA
	Z/8z+W0ZUwIIVVVReOf9N7Sfqy2UO2lEK1aSfQbWd9pvyLBBzV0HryK1UyAgMRqmwgPtEHH+HYw
	L95HZeg3FYi5qHbEdyMOVFdvlEUHKvUPpd4+/22UoE1X8oFXAOVsnTifHUsJ3H2KrzatT4mZmV2
	oDMs8Il4w2gVf9umiCfOjQdSB7/5qnt1aQo5kh6Dmw1+P9/Pp3DiVXz6dnKDr1pS6GeHBncLAYq
	I94P31v+W8h2aRjbWOMVbiuoLLb9KaqDpsTNuJTS7qHJE2wUhN/HiH+87htEEC/u9TZga4whDxw
	84WPD6XCyIquiHe8ynwpol6dCjJzUhuCjH32ytf26L815wsFnWQQ==
X-Google-Smtp-Source: AGHT+IE586RojN70u5Q3kxsvznImYrEXNdVLRbzJnw9q1YUtKMt9Sx2oeX35ig3PkEeb+0VjXXRQrQ==
X-Received: by 2002:a05:6e02:16ce:b0:42d:83cf:7ec9 with SMTP id e9e14a558f8ab-42f872c8799mr40902535ab.0.1759954888064;
        Wed, 08 Oct 2025 13:21:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-57b5ec07eaasm7042557173.53.2025.10.08.13.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 13:21:27 -0700 (PDT)
Date: Wed, 8 Oct 2025 16:21:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/6] object-name: convert to use
 `packfile_store_get_all_packs()`
Message-ID: <aObHw6rxrQG22b5B@nand.local>
References: <20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im>
 <20251007-pks-packfiles-convert-get-all-v1-1-428227657a89@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251007-pks-packfiles-convert-get-all-v1-1-428227657a89@pks.im>

On Tue, Oct 07, 2025 at 02:41:07PM +0200, Patrick Steinhardt wrote:
> When searching for abbreviated or when trying to disambiguate object IDs
> we do this in two steps:
>
>   1. We search through the multi-pack index.
>
>   2. We search through all packfiles not part of any multi-pack index.
>
> The second step uses `packfile_store_get_packs()`, which knows to skip
> loading any packfiles that are indexed by an MIDX; this is exactly what
> we want.
>
> But that function is somewhat problematic, as its behaviour is stateful
> and is influenced by `packfile_store_get_all_packs()`. This function
> basically does the same as `packfile_store_get_packs()`, but in addition
> it also loads all packfiles indexed by an MIDX. The problem here is that
> both of these functions act on the same linked list of packfiles, and
> thus depending on whether or not `get_all_packs()` was called the result
> returned by `get_packs()` will be different. Consequently, all callers
> of `get_packs()` need to be prepared to see MIDX'd packs even though
> these should in theory be excluded.
>
> This interface is confusing and thus potentially dangerous, which is why
> we're converting all callers of `get_packs()` to use `get_all_packs()`
> instead.

Well explained.

> diff --git a/object-name.c b/object-name.c
> index f6902e140d..4e62bfa330 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -213,7 +213,7 @@ static void find_short_packed_object(struct disambiguate_state *ds)
>  			unique_in_midx(m, ds);
>  	}
>
> -	for (p = packfile_store_get_packs(ds->repo->objects->packfiles); p && !ds->ambiguous;
> +	for (p = packfile_store_get_all_packs(ds->repo->objects->packfiles); p && !ds->ambiguous;
>  	     p = p->next)
>  		unique_in_pack(p, ds);
>  }

Good. As you noted, this function already handles MIDX'd packs as a
separate case, and `unique_in_pack()` discards any packs that have
their `multi_pack_index` bit set. So this caller can be converted
without issue.

> @@ -805,7 +805,7 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
>  			find_abbrev_len_for_midx(m, mad);
>  	}
>
> -	for (p = packfile_store_get_packs(mad->repo->objects->packfiles); p; p = p->next)
> +	for (p = packfile_store_get_all_packs(mad->repo->objects->packfiles); p; p = p->next)
>  		find_abbrev_len_for_pack(p, mad);
>  }

And the exact same is true for this case as well. Looking good.

Thanks,
Taylor
