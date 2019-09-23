Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C4B41F463
	for <e@80x24.org>; Mon, 23 Sep 2019 20:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387586AbfIWUrU (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 16:47:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38196 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbfIWUrU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 16:47:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id l11so15465524wrx.5
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 13:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lHxte9u7Zh17qhwbvSPOU/cbA2NSLi04dSU+k9zvATc=;
        b=gXQGUM2mQWA6DrCl4ZBW8Ev3a9aoqC4WDC2J/1zNBi6n0cDnKt5uCOwNCthN1m9MEf
         96rnAo0NQqvR/NR2yfJ25IEDb/7xgj3n880S5lS/bf46OK4w7JBSs2mtgz45/okwZUmW
         yKoOTOmM1rZ5uX1P/U6oAx0yip3r9vg8CYHk2mx6GU1womUrD+ZVLwyW2WsRVx+C+EHF
         q6brWiGCOLJ5BZ+BjSEaJYBisgiO67T135DgmekW0JbXvwAXfjRwgR8NbPb9fL9Xi7xk
         3ACbiKx6qPsobt3FlKA381zfQiW7ERmcrGPz9epMtRScuSrnbZLqGFvY0dLndbTcRrLX
         vYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lHxte9u7Zh17qhwbvSPOU/cbA2NSLi04dSU+k9zvATc=;
        b=KhtDd4MnWsYg4l86yFZxTQbYhsihE96Aw2QepAsAtM73IpaTDCgi3RxR3F4PN0Uwql
         A+91OIyxqTLHLEAqGuEG3s5T7pv+Sf2PXZRZGShfY78pwabdjKnLh71NWcLUiPFnQaVl
         nw8rAzHSC5ob79ANv839REiz4MmYrdfMzUWQBqXPgyIST1jkCFfnJLUP+7SI9igklG0E
         8PpF6CfKZRzrxy/nCRbWG95GMnkuzN6eNkC9Wl4idnp9ORv6xcKtIsCubsYlnD+lUcW5
         c44ZP1mq/8yfLtcaK/5vt2eDoYXrG25tmNeBzqtdVtC6xOQa4JU1Thj5FLq0ExPxG91e
         BC3Q==
X-Gm-Message-State: APjAAAXvvp1q/pPN/r+0mH+k+J/n1K2Ak/7aXHDq2793KpIaLgnnYV0c
        TB5WY4WH3VQsjSasyKHCHWM=
X-Google-Smtp-Source: APXvYqxEiFt2VuuuwMhb7uIzVP2I4x3tPwE9x4LccZJvS+otzUYHXJ7wyK8EbDfWmh5AAysrRgJfqA==
X-Received: by 2002:a05:6000:50:: with SMTP id k16mr899308wrx.161.1569271637978;
        Mon, 23 Sep 2019 13:47:17 -0700 (PDT)
Received: from szeder.dev (x4db53381.dyn.telefonica.de. [77.181.51.129])
        by smtp.gmail.com with ESMTPSA id q192sm18664268wme.23.2019.09.23.13.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 13:47:16 -0700 (PDT)
Date:   Mon, 23 Sep 2019 22:47:14 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 08/15] name-rev: pull out deref handling from the
 recursion
Message-ID: <20190923204714.GC2637@szeder.dev>
References: <20190919214712.7348-9-szeder.dev@gmail.com>
 <5bf3b958-8c95-ae3d-1ae5-df3d57272d8c@web.de>
 <20190920181302.GA26402@szeder.dev>
 <20190920181407.GB26402@szeder.dev>
 <20190921095718.GA23203@szeder.dev>
 <a507bbd1-88cf-6668-908e-92978fb77930@web.de>
 <20190922190511.GB10866@szeder.dev>
 <822d19dc-5202-b67f-5c0c-e5c69a679237@web.de>
 <20190923185908.GB2637@szeder.dev>
 <0febc113-ce84-4794-890f-4703c07057dc@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0febc113-ce84-4794-890f-4703c07057dc@web.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 23, 2019 at 09:55:11PM +0200, René Scharfe wrote:
> -- >8 --
> Subject: [PATCH] name-rev: use FLEX_ARRAY for tip_name in struct rev_name
> 
> Give each rev_name its very own tip_name string.  This simplifies memory
> ownership, as callers of name_rev() only have to make sure the tip_name
> parameter exists for the duration of the call and don't have to preserve
> it for the whole run of the program.
> 
> It also saves four or eight bytes per object because this change removes
> the pointer indirection.  Memory usage is still higher for linear
> histories that previously shared the same tip_name value between
> multiple name_rev instances.

Besides looking at memory usage, have you run any performance
benchmarks?  Here it seems to make 'git name-rev --all >out' slower by
17% in the git repo and by 19.5% in the linux repo.


> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  builtin/name-rev.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index c785fe16ba..4162fb29ee 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -12,11 +12,11 @@
>  #define CUTOFF_DATE_SLOP 86400 /* one day */
> 
>  typedef struct rev_name {
> -	const char *tip_name;
>  	timestamp_t taggerdate;
>  	int generation;
>  	int distance;
>  	int from_tag;
> +	char tip_name[FLEX_ARRAY];
>  } rev_name;
> 
>  define_commit_slab(commit_rev_name, struct rev_name *);
> @@ -97,17 +97,14 @@ static void name_rev(struct commit *commit,
>  			die("generation: %d, but deref?", generation);
>  	}
> 
> -	if (name == NULL) {
> -		name = xmalloc(sizeof(rev_name));
> -		set_commit_rev_name(commit, name);
> -		goto copy_data;
> -	} else if (is_better_name(name, taggerdate, distance, from_tag)) {
> -copy_data:
> -		name->tip_name = tip_name;
> +	if (!name || is_better_name(name, taggerdate, distance, from_tag)) {
> +		free(name);
> +		FLEX_ALLOC_STR(name, tip_name, tip_name);
>  		name->taggerdate = taggerdate;
>  		name->generation = generation;
>  		name->distance = distance;
>  		name->from_tag = from_tag;
> +		set_commit_rev_name(commit, name);
>  	} else {
>  		free(to_free);
>  		return;
> @@ -131,12 +128,14 @@ static void name_rev(struct commit *commit,
>  			name_rev(parents->item, new_name, taggerdate, 0,
>  				 distance + MERGE_TRAVERSAL_WEIGHT,
>  				 from_tag, 0);
> +			free(new_name);
>  		} else {
>  			name_rev(parents->item, tip_name, taggerdate,
>  				 generation + 1, distance + 1,
>  				 from_tag, 0);
>  		}
>  	}
> +	free(to_free);
>  }
> 
>  static int subpath_matches(const char *path, const char *filter)
> @@ -270,8 +269,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
>  		if (taggerdate == TIME_MAX)
>  			taggerdate = ((struct commit *)o)->date;
>  		path = name_ref_abbrev(path, can_abbreviate_output);
> -		name_rev(commit, xstrdup(path), taggerdate, 0, 0,
> -			 from_tag, deref);
> +		name_rev(commit, path, taggerdate, 0, 0, from_tag, deref);
>  	}
>  	return 0;
>  }
> --
> 2.23.0
