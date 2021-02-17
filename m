Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8DCC433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 18:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BE9461481
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 18:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbhBQSgf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 13:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhBQSgd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 13:36:33 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3232C061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 10:35:52 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id c3so13122024qkj.11
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 10:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5Ma52dklGdtXQarDvZRD6NJVuz7telGamC9uJ7Z/HZ4=;
        b=rGrGNiFV6Fwd3dlwsbDvHShx7tY5pF0aQmcQqYQimTRPKpDz7W7CS8Hg01f89uZbM0
         INGCQuOVQOZXRh0dRoCbRVW062dPSbjKFygXTmpeky6jIJFtONj6jnBIIvdRqZH1xjtn
         R/r65/e8BneDqMpFWnHuFVRsJ5Cvlz78Oqb4+H8GtpY75NhL+j/r/8mgUa8M2rMwLdna
         Rkd/AJRjipF7nQFjDoz2zuFlDyqAox9aOs0PRjYxOG/B0NcsHKk8ptc6b1UZD+s5i+4z
         OzbvWSMO4XJbkwcddseNGblO2XjevN5pUHyxdxhhmzewMj9W/vzTaWc5goO3sE63LAvZ
         B3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Ma52dklGdtXQarDvZRD6NJVuz7telGamC9uJ7Z/HZ4=;
        b=HnEJuOSNV3+/0udfGLPOZLyD5QbCi4W+QK7I+xuMSsFpLcQxEfCR0VF8Xrfktq72ot
         YA3rxOm4HuKx9uah+7m9mzMA155qB3IngVWT5i63adw/1hU+W0+VEY+dZjte5MNF2/vY
         Yi8iyBBt/uVzg02MoGnyj0F+B4Wpz8XHdFfsaK0CQfAK7ivh1F7r8uLqojFqW+CLFgTd
         QJ1ETRtjRuZzTJhHC7ySOj7o8y+/F3lfPbLz87mq2/hIHODFiKNn0h3OgCHSQUF5f8oV
         2rc2+rJYoTycRjGiWLE3ini5ynJfZ1UeOz7P3IjjQP4evkGvPQutBS2NheeJbbEFU3b4
         ufYA==
X-Gm-Message-State: AOAM531cMuyApaCk2zmjLPkxbWSQ2XZDmago9qNtr4L73/zuFu1+m6yc
        MKl5O2bwy5vq5okaoXYOSQU+iA==
X-Google-Smtp-Source: ABdhPJy4saIQ96FSwVMNpSY2DjxqX1XPH7ZHd+IMzcVTVLxE3BvlnUU0Lr92tTgCzp8IFlz7UUTOpQ==
X-Received: by 2002:a37:a485:: with SMTP id n127mr557483qke.286.1613586951944;
        Wed, 17 Feb 2021 10:35:51 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:aeda:db8b:7233:8f54])
        by smtp.gmail.com with ESMTPSA id l26sm1687296qtp.49.2021.02.17.10.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 10:35:51 -0800 (PST)
Date:   Wed, 17 Feb 2021 13:35:48 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v2 2/8] revision: learn '--no-kept-objects'
Message-ID: <YC1iBEFyQnv2URSV@nand.local>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
 <ddc2896caa13b9f1cdccb2f0a5892143fa98237c.1612411123.git.me@ttaylorr.com>
 <YCxSlNK4Ug2exDbv@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCxSlNK4Ug2exDbv@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 06:17:40PM -0500, Jeff King wrote:
> On Wed, Feb 03, 2021 at 10:58:57PM -0500, Taylor Blau wrote:
>
> > @@ -3797,6 +3807,11 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
> >  		return commit_ignore;
> >  	if (revs->unpacked && has_object_pack(&commit->object.oid))
> >  		return commit_ignore;
> > +	if (revs->no_kept_objects) {
> > +		if (has_object_kept_pack(&commit->object.oid,
> > +					 revs->keep_pack_cache_flags))
> > +			return commit_ignore;
> > +	}
>
> OK, so this has the same "problems" as --unpacked, which is that we can
> miss some objects (i.e., things that are reachable but not-kept may not
> be reported). But it should be OK in this version of the series, because
> we will not be relying on it for selection of objects, but only to fill
> in ordering / namehash fields.
>
> Should we warn people about that, either as a comment or in the commit
> message?

Yeah, let's warn about it in the commit message. We could put it in the
documentation, but...

> > +--no-kept-objects[=<kind>]::
> > +	Halts the traversal as soon as an object in a kept pack is
> > +	found. If `<kind>` is `on-disk`, only packs with a corresponding
> > +	`*.keep` file are ignored. If `<kind>` is `in-core`, only packs
> > +	with their in-core kept state set are ignored. Otherwise, both
> > +	kinds of kept packs are ignored.
>
> Likewise, I wonder whether we need to expose this mode to users.
> Normally I'm a fan of doing so, because it allows scripted callers
> access to more of the internals, but:
>
>   - the semantics are kind of weird about where we draw the line between
>     performance and absolute correctness
>
>   - the "in-core" thing is a bit weird for callers of rev-list; how do I
>     as a caller mark a pack as kept-in-core? I think it's only an
>     internal pack-objects thing.
>
> Once we support this in rev-list, we'll have to do it forever (or deal
> with deprecation, etc). If we just need it internally, maybe it's wise
> to leave it as a something you ask for by manipulating rev_info
> directly. Or perhaps leave it as an undocumented interface we use for
> testing, and not something we promise to keep working.

I think that you raise a good point about not advertising this option,
since doing so paints us into a corner that we have to keep it working
and behaving consistently forever.

I'm not opposed to the idea that we may eventually want to do so, but I
think that this is too early for that. As you note, we *could* just
expose it in rev_info flags, but that makes it much more difficult to
test some of the tricky cases that are added in t6114, so I think a
middle ground of having an undocumented option satisfies both of our
wants.

> > --- a/list-objects.c
> > +++ b/list-objects.c
> > @@ -338,6 +338,13 @@ static void traverse_trees_and_blobs(struct traversal_context *ctx,
> >  			ctx->show_object(obj, name, ctx->show_data);
> >  			continue;
> >  		}
> > +		if (ctx->revs->no_kept_objects) {
> > +			struct pack_entry e;
> > +			if (find_kept_pack_entry(ctx->revs->repo, &obj->oid,
> > +						 ctx->revs->keep_pack_cache_flags,
> > +						 &e))
> > +				continue;
> > +		}
>
> This hunk is interesting.
>
> There is no similar check for revs->unpacked in list-objects.c to cut
> off the traversal. And indeed, running "rev-list --unpacked" will
> generally look at the _whole_ tree for a commit that is unpacked, even
> if all of the tree entries are packed. That's something we might
> consider changing in the name of performance (though it does increase
> the number of cases where --unpacked will fail to find an unpacked but
> reachable object).
>
> But this is a funny place to put it. If I understand it correctly, it is
> cutting off the traversal at the very top of the tree. I.e., if we had a
> commit that is not-kept, we'd queue it's root tree. And then we might
> find that the root tree is kept, and avoid traversing it. But if we _do_
> traverse it, we would look at every subtree it contains, even if they
> are kept! That's because we recurse the tree via the recursive
> process_tree(), not by queueing more objects in the pending array here.
>
> So this check seems to exist in a funny middle ground. I think it's
> unlikely to catch anything useful (usually commits have a unique root
> tree; it's all of the untouched parts of the subtrees that will be in
> the kept packs). IMHO we should either drop it (and act like
> "--unpacked", accepting that we may traverse some extra tree objects),
> or we should go all-in on performance and cut it off in the top of
> process_tree().

Agreed. Let's drop it.

> -Peff

Thanks,
Taylor
