Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B00A620A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 18:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeLJSJk (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 13:09:40 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35247 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeLJSJk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 13:09:40 -0500
Received: by mail-vs1-f68.google.com with SMTP id e7so7231641vsc.2
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 10:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r0w6V+UCUGLPlvBKhHW7L/2OawAFgWdsg5qUAqq+bAw=;
        b=hjzVreMupuejND28rHii5QYcIIFNEpAd2RxrR0U3hENrXsp3UJcexIQ9XaOz0j3eqL
         Ys+ww6H14KcbX74BOzEHZSovr8SolCfpdNor6xHm6dDmzEZ/C1NiQhDHF0Hv9477tFvq
         T+aGXqfd2NJ6qb5VOE1+8+PhzVhhiz8VV4u1xOQTKcretfu14q2pe4RtXi5zxewVvOT6
         LQ2qDw1LBvObvWX7ZZ4iOicQAZyukSTjee5L6i+VCXeifpL+tie/A+zsB5GDJFlGaF5j
         WwptWDMB9qoysHu9NC2QuZs9NKw0Q2eyBno88aWAylymyzwZr47JZni/7P/vtMoX9tBH
         55ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r0w6V+UCUGLPlvBKhHW7L/2OawAFgWdsg5qUAqq+bAw=;
        b=RetTIZV59ar3/MVeob2nK6ecpB1L57oZtyWcJk3bi9XmmCnhe5d1VBI/IkODtqQXUB
         rBkn2N6qo5Tld9YMQN+is61grw8BFulfuL9PbLhZt1PNAHijAUvwSgnf4oBnjbr3MFbz
         hfwg93lDIC2VfohFROg9CBHEffFW3wlFNga50RUMkw1OV7VgixiLlP7qOktOWmOWQ9UN
         rZRe4Q3OOGDcGS6o7uUIuZyNiy35ZS/hTzuKa3BWTTadiHdHuy08SH5z6KKfJP3s4FEl
         hp+15edPS+acwBn7Ldbg0ty60Yb/hzrHAdqxmywRas5W/8k5C58f/P7bGRek1URMrsGG
         fhtA==
X-Gm-Message-State: AA+aEWatajHqk0g1k7+F9yvGfJQ5fPY6xWpd0sk0dLYlejNj9jjMIvpJ
        s09YP0ea2T1PdLeXxFuXp18DrsoH9EOFjtpod5I=
X-Google-Smtp-Source: AFSGD/VZhEmnMGZI7LAj6Z7/KQMobUM6cGgPUkXC0SxpqFrGI4xg/lZiXEX9SAP+Abb2mDpk34ZGs/ZwFTybIjO3lYM=
X-Received: by 2002:a67:3edc:: with SMTP id a89mr5783447vsi.136.1544465377945;
 Mon, 10 Dec 2018 10:09:37 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-5-t.gummerer@gmail.com>
 <CACsJy8AiQvu8W4=2HLKMdg+n2HiDrcLvKPRurKvziXaJdqefRg@mail.gmail.com>
In-Reply-To: <CACsJy8AiQvu8W4=2HLKMdg+n2HiDrcLvKPRurKvziXaJdqefRg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 10 Dec 2018 10:09:26 -0800
Message-ID: <CABPp-BEkeRa7jOkDcNNpZMY9J9JmNGtMKjZeNv8i_u7jUFihcw@mail.gmail.com>
Subject: Re: [PATCH 4/8] read-cache: add invalidate parameter to remove_marked_cache_entries
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 8:09 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Sun, Dec 9, 2018 at 9:05 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > When marking cache entries for removal, and later removing them all at
> > once using 'remove_marked_cache_entries()', cache entries currently
> > have to be invalidated manually in the cache tree and in the untracked
> > cache.
> >
> > Add an invalidate flag to the function.  With the flag set, the
> > function will take care of invalidating the path in the cache tree and
> > in the untracked cache.
> >
> > This will be useful in a subsequent commit.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >
> > For the two current callsites, unpack-trees seems to do this
> > invalidation itself internally.
>
> I'm still a bit scared of this invalidation business in unpack-trees.
> The thing is, we handle two separate index_state there, src_index and
> result and invalidation has to be done on the right one (because index
> extensions are on src_index until the very end of unpack-trees;
> invalidating on 'result' would be no-op and wrong).
> remove_marked_cache_entries() seems to be called on 'result' while
> invalidate_ce_path() is on src_index, hm....

Is Thomas avoiding problems here simply because merge is the only
caller of unpack_trees with src_index != dst_index?  Or does src_index
== dst_index for checkout not actually help?

If that does help with the checkout case, then allow me to find a
different way to muddy the waters...  I think I might want to make use
of this function in the merge machinery at some point, so I either
need to figure out how to convince you to verify if all this cache
tree invalidation stuff is sane, or somehow figure out all the
cache_tree stuff stuff myself so I can figure out what is right here.
:-)

> > I don't quite understand why we don't
> > need it in split-index mode though.  I assume it's because the cache
> > tree in the main index would already have been invalidated?  I didn't
> > have much time to dig, but couldn't produce any failures with it
> > either, so I assume not invalidating paths is the right thing to do
> > here.
>
> Yeah I think it's because cache-tree and untracked cache are already
> properly invalidated. This merge base thingy is done when we load the
> index files up, not when we write them down. The "front" index may
> record that a few paths in the base index are no longer valid and need
> to be deleted. But untracked cache and cache-tree both should have
> recorded that same info when these paths are marked for delete at
> index write time.
