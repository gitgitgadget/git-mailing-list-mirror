Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71A9C433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 15:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B75E02336D
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 15:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbhATPjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 10:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730741AbhATOuR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 09:50:17 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40994C061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 06:49:24 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id v3so14090424qtw.4
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 06:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lwxo+eMjdq9xAN1KXvXlKSCZ1biMyWpBHPHkKTNbZ2g=;
        b=XkINdj4DBce20awwWs3WyAx8bYnyH3jc3Q5QBEBUBCXW9Eg5E/CfHrwMfajb0tsIfN
         xMk/wam4vSaM5BdlHR806P01Oe562FgHc2Ck34Z3S6V5fBTxZAAAWRLBCq6CWWZHM/qW
         A5pT/WqJIitt8dHNau6/toPsYwartFkjQkowb07DkfwlWqCtODXl58BnFjS5OElhjqvi
         SU0jfToy95nIGAgZdCQ30BH0FbkkXFdsiPeZV+T7kw+0ru669KEfQFNr67jvUjcSKgFk
         Pe8kkB5bBRyof1WBFGTAc16//85KPkf7oSlE1aQmaaZv384nhWMS2gQALiSImcXzU5KA
         5bDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lwxo+eMjdq9xAN1KXvXlKSCZ1biMyWpBHPHkKTNbZ2g=;
        b=r620WE9k5Q0Lb92nhYBZpgwjGhuqDiLjWDmd8jDKEsXBPAKZG+mEhXteTnyVUEaPV0
         KQMOH8qb5nG8L/PlknBqIps87Zd52tzNuz+bbr5sBhnks/fYUwPBpQTJLu9b+AH0HaVy
         8qE/gBRCn/deikfJenLcif3jClayeUriRA/epb9mWSjra1EEXFHk2EawrDGeGnyvFKHL
         KXpY+INAW1fDhoR8K/5lkejGAke0lW+rFTFQjzu/2QX7+PYW9/Uouwmj+B7B1YUhb4nr
         +OBaH1Q4kgb5/zyMfXHMMZg/yZv4lqDXr+yLAJQvoSRFPtzvjnNNDaXfWNJPMwMo76mH
         Ch3g==
X-Gm-Message-State: AOAM531o888hYKqdOI+ic0hQ8UVeEskgiu3wuykmKfrwLthnpAHz3caW
        wo2f2IzWI6echMvV+7+SCTMkTQ==
X-Google-Smtp-Source: ABdhPJymEZpg+Z5PTzabahm0ZnjZO6YjwWr0ITe/I0Gnb9nNBJXuqkhns3ApD7lJd+Ehgg5mFW9MxQ==
X-Received: by 2002:ac8:7217:: with SMTP id a23mr9054297qtp.175.1611154163490;
        Wed, 20 Jan 2021 06:49:23 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id d3sm1497907qka.36.2021.01.20.06.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 06:49:22 -0800 (PST)
Date:   Wed, 20 Jan 2021 09:49:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        me@ttaylorr.com
Subject: Re: [PATCH v2 1/1] builtin/pack-objects.c: avoid iterating all refs
Message-ID: <YAhC8Gsp4H17e28n@nand.local>
References: <20210120124514.49737-1-jacob@gitlab.com>
 <20210120124514.49737-2-jacob@gitlab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210120124514.49737-2-jacob@gitlab.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jacob,

On Wed, Jan 20, 2021 at 01:45:14PM +0100, Jacob Vosmaer wrote:
> In git-pack-objects, we iterate over all the tags if the --include-tag
> option is passed on the command line. For some reason this uses
> for_each_ref which is expensive if the repo has many refs. We should
> use for_each_tag_ref instead.

I don't think it's worth sending another version, but I would have liked
to see: "... because we can save time by only iterating over some of the
refs" at the end of this paragraph.

> Because the add_ref_tag callback will now only visit tags we
> simplified it a bit.
>
> The motivation for this change is that we observed performance issues
> with a repository on gitlab.com that has 500,000 refs but only 2,000
> tags. The fetch traffic on that repo is dominated by CI, and when we
> changed CI to fetch with 'git fetch --no-tags' we saw a dramatic
> change in the CPU profile of git-pack-objects. This lead us to this
> particular ref walk. More details in:
> https://gitlab.com/gitlab-com/gl-infra/scalability/-/issues/746#note_483546598
>
> Signed-off-by: Jacob Vosmaer <jacob@gitlab.com>
> ---
>  builtin/pack-objects.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 2a00358f34..ad52c91bdb 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -2803,13 +2803,11 @@ static void add_tag_chain(const struct object_id *oid)
>  	}
>  }
>
> -static int add_ref_tag(const char *path, const struct object_id *oid, int flag, void *cb_data)
> +static int add_ref_tag(const char *tag, const struct object_id *oid, int flag, void *cb_data)
>  {
>  	struct object_id peeled;
>
> -	if (starts_with(path, "refs/tags/") && /* is a tag? */
> -	    !peel_ref(path, &peeled)    && /* peelable? */
> -	    obj_is_packed(&peeled)) /* object packed? */
> +	if (!peel_ref(tag, &peeled) && obj_is_packed(&peeled))
>  		add_tag_chain(oid);
>  	return 0;
>  }
> @@ -3740,7 +3738,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  	}
>  	cleanup_preferred_base();
>  	if (include_tag && nr_result)
> -		for_each_ref(add_ref_tag, NULL);
> +		for_each_tag_ref(add_ref_tag, NULL);

OK. Seeing another caller (builtin/pack-objects.c:compute_write_order())
that passes a callback to for_each_tag_ref() makes me feel more
comfortable about using it here.

Thanks for investigating and resolving this in a way which cleans up the
surrounding code.

>  	stop_progress(&progress_state);
>  	trace2_region_leave("pack-objects", "enumerate-objects",
>  			    the_repository);
> --
> 2.30.0

This version looks good to me, thanks for digging!

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
