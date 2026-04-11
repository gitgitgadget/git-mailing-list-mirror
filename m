Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F1020C461
	for <git@vger.kernel.org>; Sat, 11 Apr 2026 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775916343; cv=none; b=F/uVv3YBqc6rVL39vt0i3opT2QiAj2Z6KM0GCOaCDlYRlRwcvaftaRpzOxbANwVt6COqRoSMkZKnTIgpo0guyMhYUZ2u/xHIy0YbwwIz1DB/LrconcbZ7G9cTZtD8ge6lVuJ9L5XdSDTttthl44jB1XVXHV2BIup7hPUqDiV6lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775916343; c=relaxed/simple;
	bh=6wHjvTbDUxjLxBn5CKroTdMidYe91feQE8xLudVoLUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrVVfm9JvvBK52TpKc9vTnUs6j2Iw4WMMbrMAEZ6YZYuRdpp3oatmU1p9onEKXfUF8uNn8fwv2nrvp6W+FLFjAZvOu+8xKx3msfQO73F0Jk1jFrWPw2alCAR7ROOwAZdRGH23Ql+woxUOvzuoCw29mLV89yUVdFoVu8rYqkcbFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSnehi32; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSnehi32"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so46930415e9.2
        for <git@vger.kernel.org>; Sat, 11 Apr 2026 07:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775916340; x=1776521140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ziQfPM5+loCksAGeBvDOsiwzAqpg5B0iYP4+oadSnM=;
        b=XSnehi32wadwMdQCEfr4JGd8GXPDmlVNZtKyGeRohfeZg55OneWKVbW30j4xFKnqNq
         9aoOdk0PWx8aThVMWtyGrB5leO+FfZVY1/PXdh1kpQ5MRH33JtvZWuLR2/61XxON6a2g
         q1vsVT3xf0tJtJ4n5cJIB4UTJWbWQ24BJyz+yUKV57em218xWLGbBVuUeQCREGr/Id68
         FPupLvpdTXb6TJmALgbGiiZw0mpSWYCrpvGEkTBAIoimTsFVzCx2uxaT70jYhFZCqW/9
         8ROOtp+HmP2wnRmZ3lCn5HHxahbuy4kTTOVX1GmiCemiiFFNR3+syenfKoz5T+P5cTF9
         LJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775916340; x=1776521140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ziQfPM5+loCksAGeBvDOsiwzAqpg5B0iYP4+oadSnM=;
        b=rJRLwG/qEBrXgBH80903QxYrYIPHAJW0BS4LOgYUz3A7TEchUmu5KAPYttL9n5ZV4y
         Z+vdI9NHGJIzRjTKfLBA7ZNXK16zEQoofSrx2LUgfdK4ngYq3Qqg28nUxYlEmcrJAXaN
         iWy6WUjtn9/BpJfu+Ki758RVryGArLNH6QR4JhiWmnzy5K30lNweWA+E86ig7xkzVq7o
         BqAZw4WG2Zyb3oa3GKn3Pe3WGsWvxnUb3iwPPhY2MboDjrRVWCla4GcGng0h8n+JPZ6W
         ZuDjbk7l5Uo1tiQjr4SrVqHQDNJsCG0GoVeg27e9FlVXPwLnhbEF2fyLhDXQxVge1buj
         VyxA==
X-Gm-Message-State: AOJu0YydftF32nJtclXyIyA+MLPWVH0+xooFxe1/YtCoNAFpnk4+F9W1
	5DEVDKdNDiO7mNR+UMgsJZNVHTKsJyMadJM8AQYncwv1aWVWvnhf7YGQ
X-Gm-Gg: AeBDievt66SssvLZR6WwWnyOXQ0d9AO7X1K14QR6rBp2P9oEmxMczGZG3TroRYCS7E3
	0GhXInBn25kwIn+MJFTOKljqC10aGnK8YYE1O0yGlVxJ7/amS8RMrcf0fV/EChNiNxefDaprteo
	xE5qJQszab7uud3nPbSiEwyusicj0aiXsPNzktpohWduBNNsMzg/7qhZ9nD8b0UW1go+5K7Oobh
	1BFkzuvj2nxqw1YOihvRtANz6lWd/f5oA8ny+2ioyb3y5JXXEU0uFKEHIjrev4FQfUpqiwwj8KG
	gd9lPIoWRriyaqhN4kJEBGqDdFV5C+klkaka58g9lSHmL46owvQTf4a3RUL8/9SuVGEFlX4VtJV
	UgkXcJae9dW/8crDSsuYiZtByTJHLThI2RMu50MrtUHy1ywguvBCJuGZDJgmItmkqxcrTCZy4//
	67gyEdSjUp/izQ8wi/V95E3FB3MdLGGn0p
X-Received: by 2002:a05:600c:8b30:b0:488:b14f:b8ed with SMTP id 5b1f17b1804b1-488d6657928mr95347815e9.0.1775916339942;
        Sat, 11 Apr 2026 07:05:39 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67ce3e4sm106966425e9.5.2026.04.11.07.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 07:05:39 -0700 (PDT)
Date: Sat, 11 Apr 2026 16:05:37 +0200
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Tian Yuchen <cat@malon.dev>
Subject: Re: [GSoC PATCH v4 0/5] preserve promisor files content after repack
Message-ID: <adpVMfHowCBY75I1@lorenzo-VM>
References: <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
 <xmqqse92mn5c.fsf@gitster.g>
 <xmqqjyuemeza.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjyuemeza.fsf@gitster.g>

On Fri, Apr 10, 2026 at 07:02:17PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > When merged to the tip of 'seen' (with a fixup to use st_mtime where
> > we need only whole second precision, to avoid using st_mtim on
> > platforms that do not have it), this seems to break linux-leaks and
> > linux-reftable-leaks CI jobs (t0410, t5616, and t5710).
> >
> > This topic standalone, without interaction with other things in
> > 'seen', breaks these three tests.
> >
> >   https://github.com/git/git/actions/runs/24267948258/job/70866907548
> >
> > This is one commit directly on top of your topic that reduces CI
> > jobs down to just two "leaks" job, and removes many test scripts
> > to leave only these three breaking ones.
> >
> >
> > I managed to also locally reproduce this failure.  Here is how
> >
> >     $ cd t && t5710-*.sh -i -v
> >
> > dies:
> >
> > Direct leak of 285 byte(s) in 1 object(s) allocated from:
> >     #0 0x55ce48ca1d4d in malloc (git+0x8cd4d) (BuildId: 1aa6efa30b2fc4772028a3dd31aba3ced49bf128)
> >     #1 0x55ce48fed3f2 in do_xmalloc wrapper.c:55:8
> >     #2 0x55ce48fed3b6 in xmalloc wrapper.c:76:9
> >     #3 0x55ce48eed314 in alloc_packed_git packfile.c:306:25
> >     #4 0x55ce48eed209 in parse_pack_index packfile.c:326:25
> >     #5 0x55ce48f65f03 in copy_promisor_content repack-promisor.c:67:14
> >     ...
> 
> 
> FWIW, the tip of 'seen' as of this writing has queued this topic
> (the latest round v5) plus the attached "SQUASH???" commit at its
> tip.
> 
> The first hunk (die when dest_pack is NULL) is absolutely positively
> a wrong thing to do.  As I said, I do not know if we want to call
> parse_pack_index() here or if we have a more appropriate helper
> function to use, but assuming that parse_pack_index() is the right
> thing to call, we should be prepared to see NULL returned.  BUG("")
> is reserved for detected programming errors, and it is absolutely a
> wrong thing to call.
>
> As the content copied by this function is supposed to be for
> debugging only, I think dying when we cannot copy is not what we
> want.  Rather, it probably makes more sense to fall back to the
> traditional behaviour (e.g., not copying and instead leaving an
> empty file, if that is what we did before this patch series).

Got it. I will add a `warning(_("..."))` if this happens, and then
immediately `return -1` to indicate that something went wrong and so the
".promisor" file will be left empty.

> The second hunk just line-wraps an overly long line.  There are
> other overly long lines in this deeply indented block (which is a
> sign that it might be worth to see if the block is better made into
> a small static helper function) that should be line-wrapped in a
> similar way, but I didn't bother.

There are only I believe 3 lines of code that exceed the soft cap of 80
characters per line. I will line-wrap these long lines.

> THe last hunk is a real bugfix for the leak (again, provided that
> parse_pack_index() is what we want to use).

Yeah, I also noticed the issue, and reported it in an email pretty much
at the same time that you sent this one.

> 
>  repack-promisor.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/repack-promisor.c b/repack-promisor.c
> index 26055212a3..c7025e97f2 100644
> --- a/repack-promisor.c
> +++ b/repack-promisor.c
> @@ -71,6 +71,8 @@ static void copy_promisor_content(struct repository *repo,
>  	dest_idx_name = mkpathdup("%s-%s.idx", packtmp, dest_hex);
>  	get_oid_hex_algop(dest_hex, &dest_oid, repo->hash_algo);
>  	dest_pack = parse_pack_index(repo, dest_oid.hash, dest_idx_name);
> +	if (!dest_pack)
> +		BUG("parse_pack_index() failed.");
>  
>  	/* Open the .promisor dest file, and fill dest_content with its content */
>  	dest_promisor_name = mkpathdup("%s-%s.promisor", packtmp, dest_hex);
> @@ -115,7 +117,8 @@ static void copy_promisor_content(struct repository *repo,
>  
>  			/* If <time> doesn't exist, retrieve it and add it to line */
>  			if (line_sections.nr < 3)
> -				strbuf_addf(&line, " %" PRItime, (timestamp_t)source_stat.st_mtime);
> +				strbuf_addf(&line, " %" PRItime,
> +					    (timestamp_t)source_stat.st_mtime);
>  
>  			/*
>  			 * Add the finalized line to dest_to_write and dest_content if it
> @@ -148,6 +151,7 @@ static void copy_promisor_content(struct repository *repo,
>  		die(_("Could not write '%s' promisor file"), dest_promisor_name);
>  
>  	close_pack_index(dest_pack);
> +	free(dest_pack);
>  	free(dest_idx_name);
>  	free(dest_promisor_name);
>  	strset_clear(&dest_content);
> -- 

Thanks Junio.

Regarding the "Should we use `parse_pack_index()` here?" question, I
have also found success using some like this:

```
	[...]
	struct packed_git *dest_pack, *p;
	struct odb_source_files *files;
	int err;

	dest_idx_name = mkpathdup("%s-%s.idx", packtmp, dest_hex);
	files = odb_source_files_downcast(repo->objects->sources);
	dest_pack = packfile_store_load_pack(files->packed, dest_idx_name, 0);
	[...]
```

This code passes all the tests without any leaks.

Now, in all honesty, I don't know the implications of using
`parse_pack_index()` compared to using `packfile_store_load_pack()` and
`odb_source_files_downcast()`. Unfortunately these functions are rarely
used in the code, so I don't have many examples to look at.

Let me know what is your opinion on this. In the meantime I will explore
this possibility further.

Thanks a lot,

Lorenzo
