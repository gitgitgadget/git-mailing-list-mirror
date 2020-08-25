Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F270C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 16:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65A40207BC
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 16:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="nIcl58mJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgHYQIZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgHYQIY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 12:08:24 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2ACC061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 09:08:21 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 144so11398103qkl.5
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 09:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q7OG2mp9UEW1Np4eH5dpP11YLaEJ7qufrofpIv1C+WU=;
        b=nIcl58mJhSBU6aA6sCU6C+uTBktIiuOTKr3bTGMxKax1lhJqIxDar3eyLUgOxD9gWP
         H/8tR5U80b+6xW3w04EjYNuZMJApUMjCpdbWNvDCTUlSeHmyFTFV6t5H3xXiNBIpjJjI
         SAzU/vzxKMui1CbL7EclxRIgsXyKvcgLyKgzE5w8y+XI+ttZUHwPJ2YdbYxmZj0VYCNr
         QmD7u12jtfz+Tea4ld6HMZS/WEpA3AlkndMWExit5JVqc/vkqihXN+UtfxlfsaZExV4M
         RkZh6P6eC9OdsxGHMpCLOCPYjlyNUaNoaE6vGB97XEvqDdABsEOM7lX6XmRWm9+3xjxo
         t94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q7OG2mp9UEW1Np4eH5dpP11YLaEJ7qufrofpIv1C+WU=;
        b=izoYMHGnmSEm0A+QGUvVsOBnou9+IvPAXGTwPTydglwjO3oPx+y7YsOfO+GrE83MI3
         XjPw53rdoLqkLoINe9r65XQk+1SHGayWiQ9ndnw8CXVW7+TORitZPjbqdAwL9CBkkv5F
         xb6BcVvPItZkzO4liTUEG2KeisdMdpboc4jHdUAX7iVuMGADHt6Pe4XUO2Ivnweyz2Sy
         nzmT0BUDSpqilIZyN92OkBBKwXffRatx1PPBFJ6Pr4UW3o6F1zPiD3js2Nq+NXzK1Rxs
         0ElEVTyqBEreMqvdFZjG7DZ0m+lJnlU1/4mHNOQxcsX2E6PtWFgBzy6yUd4PRwi2eLHp
         qnGg==
X-Gm-Message-State: AOAM531ohmqimp32MNl5XxGCo3ldzffwLxIw2sLnXkdIfs8d8KdUfzgI
        m3jtYUkJEG9hxNdH8Me8YI5I2Q==
X-Google-Smtp-Source: ABdhPJwh9tX5wEaYr7w9mMBFSQ0AVbUFajlu9ZfbLW36ZJsbllNzGVwg+BP1RIIH5vEaD0P57JN9MQ==
X-Received: by 2002:a37:7bc2:: with SMTP id w185mr10181655qkc.349.1598371700807;
        Tue, 25 Aug 2020 09:08:20 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1558:8dc0:5209:36ba])
        by smtp.gmail.com with ESMTPSA id t142sm1756605qka.58.2020.08.25.09.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 09:08:19 -0700 (PDT)
Date:   Tue, 25 Aug 2020 12:08:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH] builtin/repack.c: invalidate MIDX only when necessary
Message-ID: <20200825160819.GA15073@syl.lan>
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
 <20200825022614.GA1391422@coredump.intra.peff.net>
 <xmqqtuwq1zux.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtuwq1zux.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 08:58:46AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> > Does "git repack" ever remove just one pack? Obviously "git repack -ad"
> > or "git repack -Ad" is going to pack everything and delete the old
> > packs. So I think we'd want to remove a midx there.
>
> AFAIK, the pack-redundant subcommand is used by nobody in-tree, so
> nobody is doing "there are three packfiles, but all the objects in
> one of them are contained in the other two, so let's remove that
> redundant one".

Not AFAICT either.

> > And "git repack -d" I think of as deleting only loose objects that we
> > just packed. But I guess it could also remove a pack that has now been
> > made redundant? That seems like a rare case in practice, but I suppose
> > is possible.
>
> Meaning it can become reality?  Yes.  Or it already can happen?  I
> doubt it.
>
> > E.g., imagine we have a midx that points to packs A and B, and
> > git-repack deletes B. By your logic above, we need to remove the midx
> > because now it points to objects in B which aren't accessible. But by
> > deleting it, could we be deleting the only thing that mentions the
> > objects in A?
> >
> > I _think_ the answer is "no", because we never went all-in on midx and
> > allowed deleting the matching .idx files for contained packs.
>
> Yeah, it has been my assumption that that part of the design would
> never change.
>
> > I'm also a little curious how bad it is to have a midx whose pack has
> > gone away. I guess we'd answer queries for "yes, we have this object"
> > even if we don't, which is bad. Though in practice we'd only delete
> > those packs if we have their objects elsewhere.
>
> Hmph, object O used to be in pack A and pack B, midx points at the
> copy in pack B but we deleted it because the pack is redundant.
> Now, midx says O exists, but midx cannot be used to retrieve O.  We
> need to ask A.idx about O to locate it.
>
> That sounds brittle.  I am not sure our error fallback is all that
> patient.

Me either. Like I said, I think that all of this is possible at least in
theory, but in practice it may be somewhat annoying in cases like these.

>
> > And the pack code is
> > pretty good about retrying other copies of objects that can't be
> > accessed. Alternatively, I wonder if the midx-loading code ought to
> > check that all of the constituent packs are available.
> >
> > In that line of thinking, do we even need to delete midx files if one of
> > their packs goes away? The reading side probably ought to be able to
> > handle that gracefully.
>
> But at that point, is there even a point to have that midx file that
> knows about objects (so it can answer has_object()? correctly and
> quickly) but does not know the correct location of half of the objects?
> Instead of going directly to A.idx to locate O, we need to go to midx
> to learn the location of O in B (which no longer exists), and then
> fall back to it, that is a pure overhead.

Well put.

> > And the more interesting case is when you repack everything with "-ad"
> > or similar, at which point you shouldn't even need to look up what's in
> > the midx to see if you deleted its packs. The point of your operation is
> > to put it all-into-one, so you know the old midx should be discarded.
>
> Old one, yes.  Do we need to have the new one in that case?
>
> >> Teach 'git repack' to check for this by loading the MIDX, and checking
> >> whether the to-be-removed pack is known to the MIDX. This requires a
> >> slightly odd alternation to a test in t5319, which is explained with a
> >> comment.
> >
> > My above musings aside, this seems like an obvious improvement.
>
> Yes.
>
> >> diff --git a/builtin/repack.c b/builtin/repack.c
> >> index 04c5ceaf7e..98fac03946 100644
> >> --- a/builtin/repack.c
> >> +++ b/builtin/repack.c
> >> @@ -133,7 +133,11 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list,
> >>  static void remove_redundant_pack(const char *dir_name, const char *base_name)
> >>  {
> >>  	struct strbuf buf = STRBUF_INIT;
> >> -	strbuf_addf(&buf, "%s/%s.pack", dir_name, base_name);
> >> +	struct multi_pack_index *m = get_multi_pack_index(the_repository);
> >> +	strbuf_addf(&buf, "%s.pack", base_name);
> >> +	if (m && midx_contains_pack(m, buf.buf))
> >> +		clear_midx_file(the_repository);
> >> +	strbuf_insertf(&buf, 0, "%s/", dir_name);
> >
> > Makes sense. midx_contains_pack() is a binary search, so we'll spend
> > O(n log n) effort deleting the packs (I wondered if this might be
> > accidentally quadratic over the number of packs).
> >
> > And after we clear, "m" will be NULL, so we'll do it at most once. Which
> > is why you can get rid of the manual "midx_cleared" flag from the
> > preimage.
> >
> > So the patch looks good to me.
>
> Thanks.

Thanks, both. If you're ready, let's use the version in [1] for
queueing.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/87a3b7a5a2f091e2a23c163a7d86effbbbedfa3a.1598371475.git.me@ttaylorr.com/
