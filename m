Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787FD492E28
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 23:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788909142; cv=none; b=BTRJRsB/2SXG+AuqoB0nw+ecTmQKOXTKY/QV12hqk2paK0xwdNWwMI+08/LQVXqdOt6otCNBCrEfPQJPzcnv9VAisI7SG4b/6rFFWtLDU8FNqOsQLXnKK6NqIKNc3WiATYfx4xWI/Bo1Jg44vAI5G6ztG578m9EcQSIwMjn90p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788909142; c=relaxed/simple;
	bh=n/g5l1hiMgZugWUvYlzzkBuyHZIb56E1bLjo2oS521A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MY64S7q4T/XqQ7NfanZQtV9UY3WXqjok/gemI2XluN3d1Ajx1+E+Knd6GgkEWHZN72D3KpPiD5UH9VrGgdZUXGx91EaCSSYHl22Q77RG/27IR2F4CwWMB2Hymgq/TpbR5ASV20SZ/ONU32/rWpDfZTPcpg/Fwc+ki46jNUcyVw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ir3yqNFG; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ir3yqNFG"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-47861ea0ce5so1492611fac.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 16:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788909139; x=1789513939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y07Qk7K4wygIUbRVsyaUxQzdyIM9u1a+5JdJ0TbBfR4=;
        b=Ir3yqNFGZxUvQFjyutOWR6WzKchMFCnLovbKbszj1Oejb5u/CdNccapoJ7PDosSDdV
         HlHlfub1wvzeH19MQAAkse6+voS1+EXrydmKmYp5/t2CsOul5W/rEccY6vAF+ZfTZL0K
         LEfSECmrgTZvJWOtwLVsBkFSL1BZyS7Gg1MzBvS0hMeegtyEHqh7w5t/kBzBnEfjf7OI
         FJT9v0+jKC9QBEky+VgdFUwdFEmxp579wePjcZq8gqw3/5yiAQjSal47F9t+QW/QiNxr
         h24WgbcgzPo+D/TPTIcUAZLS6q1oXN0eLOLFQaBHrpFT1Zw3MW3HWf1XF7oLl8iRFUZ3
         JIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788909139; x=1789513939;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y07Qk7K4wygIUbRVsyaUxQzdyIM9u1a+5JdJ0TbBfR4=;
        b=VhFl5xejVkIrg7lBYvRWmru0785Lidx2uAH+cBQ4lu89q1Qdw/ug3apQ4yq4KapJTt
         O9cdSbwxRtWFzgmyPNNDbLeUIdKVVOktBP83art43FjJ9EVBeIU3SUBkkr93HTwWQbbn
         kjmnN2U3E+A1nwiPvjzH8YE6Dg1rkc++RYcIyjniYFwqORC+okFsC99VY00WfN80fZVF
         mWvLrTXof1v9kM3WMzBVTaXXs7GEcTWhAABOUAn8rKA0Fypt4fWx3xikVeeU8zwEHuiT
         yHCdKMtlYapXUESnYQuDz91xdW6n4G5e6U0/hFfTkXc6s3Mnz+93M7mTSKxw+W4xECM/
         1JfQ==
X-Gm-Message-State: AFuF++ln0uQ9mD4SaYrjEnIRVmLMR/fY3nysKxS3WdiGpzaJfNzvMR2U
	Gu/hNake4RvU8SeVqD6gNMHs8MfnRQ+2cFqPLpT5RSyKBFugCNuNytduADkGsw==
X-Gm-Gg: AYBFou2crnhWmFRbSAye8+ba6mKhAnXD8Urk7V5nfulAgiQcNvGvaKNvQWtfVHkCNtU
	Kl0ye8qgmx+53LQ1vq2KOim5hIr9J/yoPAD93CMzFuz6nSYbvoNxPAlHWakwWGpsiBRJ7jy/tY+
	CaLWlV8O57grp48ZCTQln7tWz9+3qaLStFHDLp2ZGVO0WYXwY7qvEfVkGsoss2plkkRhlJ0FRwO
	X4UAkxjiYJmMhm6RLJeL59TPfLatlbbzJ7oncrgC4s+QyPky4O8e5cJ77q2yvOpaH7pp4Wt+9aL
	wqvipVtm57hGB/hadyeP9xzgQeQ5PpruHb/pXtIyYyDslC9ePKYYWov1lzzFrPSM5BnNOXO834F
	w2ig3BLNx6wehd+bMkbgf273/XO89TtakpvvnNGRNgdKzIPDR8PGgjjmMEsxcSgMprnQVWzEmL3
	tUaWedqc9ew0ttsnloRUEgtk18tgFbP8MYjsZuawQh6HaYg1B3JlztlLOneznJ/+Dnw7FsRus8u
	VW3y5aMOAtdFw==
X-Received: by 2002:a05:6870:e8b:b0:46a:e87f:a7f3 with SMTP id 586e51a60fabf-4754f9e1359mr19178629fac.2.1788909138996;
        Tue, 08 Sep 2026 16:12:18 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-475523da013sm14264568fac.1.2026.09.08.16.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 16:12:18 -0700 (PDT)
Date: Tue, 8 Sep 2026 18:12:17 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/13] builtin/multi-pack-index: refuse unknown
 sources with "--object-dir="
Message-ID: <aqCU7e0c84ZgZNab@denethor>
References: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
 <20260902-pks-odb-registering-in-memory-sources-v2-10-c6ca12fdea4d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902-pks-odb-registering-in-memory-sources-v2-10-c6ca12fdea4d@pks.im>

On 26/09/02 03:34PM, Patrick Steinhardt wrote:
> Users can tell git-multi-pack-index(1) to access multi-pack indices that
> are stored in a different object directory via the "--object-dir="
> option. This allows them to for example write or verify a multi-pack
> index other than the one located in the main object directory in case a
> repository has alternates with multiple multi-pack indices.
> 
> But while the documentation explicitly points out that the specified
> object directory must be an alternate of the current repository, we
> never verify that property. Instead, starting with 017db7bb14 (midx:
> load multi-pack indices via their source, 2025-08-11), we now construct
> an ad-hoc source and link it to the main object directory.
> 
> Besides contradicting the documentation, it's dubious that this really
> ought to work in the first place: creating a multi-pack index (and
> potentially a bitmap) for a completely foreign object directory is of
> questionable value, as bitmap commit selection operates on the invoking
> repository's refs. Furthermore, this is the only remaining caller
> outside of our test helpers that constructs an ad-hoc source and links
> it to the database, and we want to get rid of this mechanism as part of
> this series.

I was curious if there was any intentional reason that 017db7bb14
started added these as an alternate source. I assume though the reason
was just to address the tests when we started loading multi-pack indexes
via sources. So aligning with the prexisting documentation makes sense
to me.

> Stop constructing the ad-hoc source and instead refuse the operation.
> While this results in a change in behaviour, this restriction has been
> documented as such ever since f57a739691 (midx: avoid opening multiple
> MIDXs when writing, 2021-09-01).
> 
> Note that this change requires us to adapt one test chain in t5319, as
> it creates an object directory that is not connected to any repository
> and then uses it via "--object-dir=". The setup itself already documents
> this and does the necessary gymnastics to link the object directory to a
> temporary repository, but subsequent tests don't. Adapt those tests to
> retain and reuse the temporary repository.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/multi-pack-index.c  | 3 ++-
>  t/t5319-multi-pack-index.sh | 9 ++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index 6e73c85cde..753bd53a70 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -90,7 +90,8 @@ static struct odb_source_files *handle_object_dir_option(struct repository *repo
>  {
>  	struct odb_source *source = odb_find_source(repo->objects, opts.object_dir);
>  	if (!source)
> -		source = odb_add_to_alternates_memory(repo->objects, opts.object_dir);
> +		die(_("object directory is not an alternate of the current repository: '%s'"),
> +		    opts.object_dir);

Now we no longer add these as in-memory alternates sources. Looks good.

>  	return odb_source_files_downcast(source);
>  }
>  
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index 68143cb5b7..00e90f163f 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -698,10 +698,9 @@ test_expect_success 'force some 64-bit offsets with pack-objects' '
>  	corrupt_data $idx64 $(test_oid idxoff) "\02" &&
>  	# objects64 is not a real repository, but can serve as an alternate
>  	# anyway so we can write a MIDX into it
> -	git init repo &&
> -	test_when_finished "rm -fr repo" &&

Ok, now we just reuse the properly set up repo. Make sense.

> +	git init repo64 &&
>  	(
> -		cd repo &&
> +		cd repo64 &&
>  		( cd ../objects64 && pwd ) >.git/objects/info/alternates &&
>  		midx64=$(git multi-pack-index --object-dir=../objects64 write)
>  	) &&
> @@ -709,7 +708,7 @@ test_expect_success 'force some 64-bit offsets with pack-objects' '
>  '
>  
>  test_expect_success 'verify multi-pack-index with 64-bit offsets' '
> -	git multi-pack-index verify --object-dir=objects64
> +	git -C repo64 multi-pack-index verify --object-dir=../objects64
>  '
>  
>  NUM_OBJECTS=63
> @@ -721,7 +720,7 @@ MIDX_BYTE_LARGE_OFFSET=$(($MIDX_OFFSET_LARGE_OFFSETS + 3))
>  
>  test_expect_success 'verify incorrect 64-bit offset' '
>  	corrupt_midx_and_verify $MIDX_BYTE_LARGE_OFFSET "\07" objects64 \
> -		"incorrect object offset"
> +		"incorrect object offset" "git -C repo64 multi-pack-index verify --object-dir=../objects64"
>  '
>  
>  test_expect_success 'setup expire tests' '
> 
> -- 
> 2.55.0.979.g7e5102b832.dirty
> 
> 
