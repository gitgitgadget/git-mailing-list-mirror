Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EE5F20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 21:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbeLKV7O (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 16:59:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34263 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLKV7N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 16:59:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so9987878wmd.1
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 13:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p1LaVD+eGbT/a041KQOeLDaemmS4qzGjtkBesZcEknY=;
        b=vEeK84roHt3E8docbw44VE+HaYoCO3JAoxfEm1dMNKw1oaZF/zt4zwU/aYn+q7KOKI
         mUlfsuKESSpIiNAY/hombtnvO1DVnEc25DWaCt1FDdqot5jS/i73X4nJHB1nh9J5elZO
         051pDHMU5SCrGhBNY1vB16/x0dsMhtFklDw5CY2Fu30W7C4oofln7IjSrAtaE7soareV
         ux6+FvaOhjGePKQ1W6VBQ7QhyfsJA+e8nymKAWIZqbiVNtiUwGu3vlWSyL93ajbVZi7J
         KSgrfYCTAmmcK3n4GT/PwLgRbJUvTC9/foYgLxbXdQqULGQdu41HjS0VfKmC0lHk1okf
         qCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p1LaVD+eGbT/a041KQOeLDaemmS4qzGjtkBesZcEknY=;
        b=dzWRSCpL7g05iJlAoSgSVpTu5nnnL8B2RRCd7pQHuGgq4Mbjsx2I1TcFX7n/HOwwg1
         Ll80H6aO+T2TTU3gMJtNdYa7kmA8sC6pfXQbv+SVjZ3vHNPQXt6tho+FUUnaQNeNyrbP
         X0QE9aA5FiJ5aS1LZuB+fOgcaC+mTNsPTzDcctx0xGfipWQBaxiFFSh3nLgoOSh5frq8
         1REJvu1/8MS6nGtXfMPXJiJQKlgmV/PyNCEpZ5M97ZpSfIVKKZeP2QDyH5qQfKfcpjMq
         /Mjly5atHms1CE/OCTzcH30os7KZ+4yEWp1lymCdQYi7BI11UmsOOZ4ocQV/t3LB9SKf
         8fjQ==
X-Gm-Message-State: AA+aEWYUQrfZlHZrvjNk9jqdeSTAXlz2oBubcFywWtzF4sIYt3LmN9P+
        vlabbS93eM8lYZdKxdCtgezhykPF
X-Google-Smtp-Source: AFSGD/XgoUAbm4SU4JgcoUF2uf84sV8ZQXgBjkYPAS8Xmp9h7rzEqUOUJEGmYoiYoieFWFr/t8dTVQ==
X-Received: by 2002:a1c:7706:: with SMTP id t6mr3731986wmi.57.1544565551998;
        Tue, 11 Dec 2018 13:59:11 -0800 (PST)
Received: from localhost ([2.24.105.121])
        by smtp.gmail.com with ESMTPSA id z12sm14936532wrh.35.2018.12.11.13.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 13:59:11 -0800 (PST)
Date:   Tue, 11 Dec 2018 21:59:10 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] read-cache: add invalidate parameter to
 remove_marked_cache_entries
Message-ID: <20181211215910.GP4883@hank.intra.tgummerer.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
 <20181209200449.16342-5-t.gummerer@gmail.com>
 <CACsJy8AiQvu8W4=2HLKMdg+n2HiDrcLvKPRurKvziXaJdqefRg@mail.gmail.com>
 <CABPp-BEkeRa7jOkDcNNpZMY9J9JmNGtMKjZeNv8i_u7jUFihcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BEkeRa7jOkDcNNpZMY9J9JmNGtMKjZeNv8i_u7jUFihcw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10, Elijah Newren wrote:
> On Mon, Dec 10, 2018 at 8:09 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Sun, Dec 9, 2018 at 9:05 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > >
> > > When marking cache entries for removal, and later removing them all at
> > > once using 'remove_marked_cache_entries()', cache entries currently
> > > have to be invalidated manually in the cache tree and in the untracked
> > > cache.
> > >
> > > Add an invalidate flag to the function.  With the flag set, the
> > > function will take care of invalidating the path in the cache tree and
> > > in the untracked cache.
> > >
> > > This will be useful in a subsequent commit.
> > >
> > > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > > ---
> > >
> > > For the two current callsites, unpack-trees seems to do this
> > > invalidation itself internally.
> >
> > I'm still a bit scared of this invalidation business in unpack-trees.
> > The thing is, we handle two separate index_state there, src_index and
> > result and invalidation has to be done on the right one (because index
> > extensions are on src_index until the very end of unpack-trees;
> > invalidating on 'result' would be no-op and wrong).
> > remove_marked_cache_entries() seems to be called on 'result' while
> > invalidate_ce_path() is on src_index, hm....
> 
> Is Thomas avoiding problems here simply because merge is the only
> caller of unpack_trees with src_index != dst_index?  Or does src_index
> == dst_index for checkout not actually help?

I'm trying to avoid problems in this patch by keeping status quo, and
not changing the cache-tree invalidation in any way.  'git checkout --
<pathspec>' doesn't use unpack-trees, so I don't think I have to worry
about src_index vs. dst_index.

In what I was saying above I was merely trying to explain why we don't
need invalidate the cache-tree in the 'remove_marked_cache_entries()'
function.

> If that does help with the checkout case, then allow me to find a
> different way to muddy the waters...  I think I might want to make use
> of this function in the merge machinery at some point, so I either
> need to figure out how to convince you to verify if all this cache
> tree invalidation stuff is sane, or somehow figure out all the
> cache_tree stuff stuff myself so I can figure out what is right here.
> :-)
> 
> > > I don't quite understand why we don't
> > > need it in split-index mode though.  I assume it's because the cache
> > > tree in the main index would already have been invalidated?  I didn't
> > > have much time to dig, but couldn't produce any failures with it
> > > either, so I assume not invalidating paths is the right thing to do
> > > here.
> >
> > Yeah I think it's because cache-tree and untracked cache are already
> > properly invalidated. This merge base thingy is done when we load the
> > index files up, not when we write them down. The "front" index may
> > record that a few paths in the base index are no longer valid and need
> > to be deleted. But untracked cache and cache-tree both should have
> > recorded that same info when these paths are marked for delete at
> > index write time.

Thanks, that makes sense to me.
