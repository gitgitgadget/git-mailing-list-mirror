Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080CE322B7B
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783722899; cv=none; b=JurjvlddjV2QwyhS6r9qaVzT/ZAMyCwjxUXfE8rnR8Kq33rVXWoX5hb2/1/7oNQ+RTm+VX+vgXhPHcbRwruy74mk2MfDnwXGEPV8lhd4l5ISpE0xCN6JbadLTN1G0p2eTbE0gBYYcINBJuT4rB6SZv2zbNPLqd8seC/+jPZORpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783722899; c=relaxed/simple;
	bh=2ujNC79JB+5sfbpzrG+uout/V51nhzNa1cm7z0b+fZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMdSlofl1gLBnSTXIzEDmgbe3Xppon5ZpsdvjwvndTpms8GZg8aIZrXu8//WW+c0Y7UxqfMDRIvvKL+XNHwAJzXmmBuDI4ADyeQ2x2ncn/NkCE27r35C2V8Qa6SmLdkEeAVo5aI+VLnebFGY4GoXqyGHd3GpgI7/HI4HQ0o8Jpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=YqAaAgjt; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="YqAaAgjt"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c2a818fc4so9100691cf.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 15:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783722897; x=1784327697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o5D6lLqM+NDPJbt+vbZaVchTMwfGNUi9lkyBUiQcvFY=;
        b=YqAaAgjthD5KaSnX/r3tcWroCBJYLjF2BK3Hh78i/gB5aWBaUx5+uBYl9xYQ1Jb7Tu
         a0I80yETmgs2GeTBLFmj+JnOYNHqUmLcrCGZh94FrfFC3meiWqe1x6qa3VmSjRThAGIV
         QV8M6Uzef++DJ/CmP1Ghymob7uX7HQmwWPGkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783722897; x=1784327697;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o5D6lLqM+NDPJbt+vbZaVchTMwfGNUi9lkyBUiQcvFY=;
        b=U43XfC93DTeBiy5/5BdfFuo1aVoJkjP+n2YxXbhMM+WZ3huDRWWYA+1OXY3vAWhJU/
         3CUWyFq6DrPViLD+0HSamg80OkgdRnISl3i0lMbEy6ufRKprfserY2gh9BjgxBkvPrZ3
         pBwH2bhLZQy8mbZvbCAhJLM6TgMvFFN0bTiq7LEf5S157LkVIXXxJzNuJNAHGq4jN6Yr
         QV0oc3wAkzd3mC9rIintGd/GElx25Awlw36JN5vL6eRFl19I2WtQ4MGLIxf/FbvjbUsH
         hh8/puXvgWH0i+xKrdwIDq27utZcx2IDcfyjb1U0yXKeiXQi++Oaq8j7lHreteW3+7nu
         CaWQ==
X-Gm-Message-State: AOJu0YxGjl1GqXXPmVTYAdhm++mYUSpauD/3HcvaPhyFkMKCZLLemxq5
	LKIBcT87mDwozqDemH5E57AKDFc/aDeNg4hG8UVXXc/GhvtWEonUCp0KipwTV8J9waI=
X-Gm-Gg: AfdE7cnezeqln0G857o3aGZfdT6O/qJ6/o0EnX0E7WcbL9KsS6B/zS1+abcg7YqJ34H
	wZKUew9+vpMJnjw/vBEK9W/QVbAj/i5oxpxQabIEG8M+QydraQSPh/63i2usgEcmnxbj2pkVAH8
	kh40HtUf2izdSm6E3dJeLUx3hglZkDDZQ1/QOFXJs/EsyRJsCeryNrw/hnxD3s+6sh78+ByFN7h
	vxQ68J7kwqHp7KA2tiJuJaTzTDmGLKY6t4nueGQWAXDGJkAmtpqKMLau3KzmUUcCC3IKMYUGZYH
	+DNNxV9Dcsto3A1oYYbulAKLRfLXvN2hu0Tf/QGLw0PMHrAF93AC6pWVQCuegT79l4bQBcQuvho
	XGhCRGIKCd1KW4X6jjtlsAtgPAjgGUIuclQkRTLslF7koyCEbOC8Owy09VuWnELL5rR92Phj1lf
	JKHgbUeaBniNQr17cM/wLmE1kE
X-Received: by 2002:ac8:7e8b:0:b0:51c:7b12:5ffd with SMTP id d75a77b69052e-51cbf28857bmr8281751cf.73.1783722896796;
        Fri, 10 Jul 2026 15:34:56 -0700 (PDT)
Received: from com-79390 ([209.249.37.133])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caae2068asm24797621cf.17.2026.07.10.15.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 15:34:56 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:34:53 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] pack-bitmap: allow aborting iteration of
 bitmapped objects
Message-ID: <alFzja98avOoKjQE@com-79390>
References: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
 <20260710-pks-odb-for-each-object-filter-v2-3-3710a9cc165a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260710-pks-odb-for-each-object-filter-v2-3-3710a9cc165a@pks.im>

On Fri, Jul 10, 2026 at 10:48:55AM +0200, Patrick Steinhardt wrote:
> In a subsequent commit we'll lift iteration of bitmapped objects into
> the "packed" backend and make it accessible via `odb_for_each_object()`.
> The calling convention for that function is that the callback may return
> a non-zero exit code, and if so we'll abort iteration. This is currently
> impossible to realize though, as `for_each_bitmapped_object()` will
> ignore any return value and just churn through all objects completely.
>
> This doesn't matter to the callers of `for_each_bitmapped_object()`, as
> there's only one of them in git-cat-file(1), and the callbacks we pass
> always return zero. But once we move the logic into the generic
> infrastructure it becomes a latent bug waiting to happen.

Makes sense.

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index ea5eab4cf8..8ff92c5272 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1909,7 +1909,7 @@ static int add_object_entry_from_bitmap(const struct object_id *oid,
>  		return 0;
>
>  	create_object_entry(oid, type, name_hash, 0, 0, pack, offset);
> -	return 1;
> +	return 0;
>  }

I was initially rather surprised to read this diff. I suspected that
this was a "we used to return non-zero to indicate success but now
return zero to match the project conventions", but was stumped by the
unchanged "return 0" in the context above.

But I suppose that is demonstrating the thing that you're trying to fix
here, which is that the caller doesn't actually care what is returned
from the callback, so the change here (and analogous ones below) make
sense to me.

> -static void show_objects_for_type(
> +static int show_objects_for_type(
>  	struct bitmap_index *bitmap_git,
>  	struct bitmap *objects,
>  	enum object_type object_type,
> @@ -1704,6 +1704,7 @@ static void show_objects_for_type(
>  {
>  	size_t i = 0;
>  	uint32_t offset;
> +	int ret;

This has a broader scope than is strictly necessary, but I think that is
OK.

>  static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
> @@ -2062,6 +2069,12 @@ int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
>  			      show_reachable_fn show_reach,
>  			      void *payload)
>  {
> +	const enum object_type types[] = {
> +		OBJ_COMMIT,
> +		OBJ_TREE,
> +		OBJ_BLOB,
> +		OBJ_TAG,
> +	};
>  	struct bitmap *filtered_bitmap = NULL;
>  	uint32_t objects_nr;
>  	size_t full_word_count;
> @@ -2086,14 +2099,12 @@ int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
>  		goto out;
>  	}
>
> -	show_objects_for_type(bitmap_git, filtered_bitmap,
> -			      OBJ_COMMIT, show_reach, payload);
> -	show_objects_for_type(bitmap_git, filtered_bitmap,
> -			      OBJ_TREE, show_reach, payload);
> -	show_objects_for_type(bitmap_git, filtered_bitmap,
> -			      OBJ_BLOB, show_reach, payload);
> -	show_objects_for_type(bitmap_git, filtered_bitmap,
> -			      OBJ_TAG, show_reach, payload);
> +	for (size_t i = 0; i < ARRAY_SIZE(types); i++) {
> +		ret = show_objects_for_type(bitmap_git, filtered_bitmap,
> +					    types[i], show_reach, payload);
> +		if (ret)
> +			goto out;
> +	}

OK. So now we call this function in a loop instead of the unrolled
version, presumably because we want to propagate a failure from any one
of these before falling through to the remaining object types.

That makes sense, and I think the clean-up is well justified here.

However, the remaining `show_objects_for_type()` callers from within
`traverse_bitmap_commit_list()` do *not* bother to inspect the return
value, despite taking in an arbitrary 'show_reachable_fn', which itself
may return a non-zero value.

I guess this must be effectively OK in practice with respect to the
existing code for the same reason you indicate in the commit message
above, but we should change this function to *also* propagate non-zero
return values to eliminate the foot-gun completely.

Thanks,
Taylor
