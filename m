Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BA971F403
	for <e@80x24.org>; Mon,  4 Jun 2018 17:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751233AbeFDRdm (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 13:33:42 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38001 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbeFDRdl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 13:33:41 -0400
Received: by mail-pl0-f68.google.com with SMTP id b14-v6so2978141pls.5
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 10:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vGTZFRlH9/JOf2Yy7fTCNp6LyPMCkduqjcsfy5pWxlE=;
        b=DpPRGddojZBdFiGULV1fX/dmRJeTvahsVCRO/ulnRnZ08XkjdhaPi7mNB+EQs2hp5c
         501mH9Rdmiy6zyfZVWTIZXEFK+if6pVHtjyvD2teR943LoaDxDmikAhwIMvX9iX45NwB
         MdVdBPhAcvi42bs7OGDz5H8Om3DGmEkav8O5LFGMGjrWN5qpQQ5Wvb//P/O4uuy34ATR
         mmPQsQ99bxYhKcYO9zQeoSasvuGLycAUF7cgy10kQG7v+ld4gmkD0u82sx8Sold7Ae7M
         rG5p3UDJXSP/cNIChOc44PuqXM7xs9EAipcdN8RiOq+AL3ndWgFJrvmSQQ960onjmhkF
         qRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vGTZFRlH9/JOf2Yy7fTCNp6LyPMCkduqjcsfy5pWxlE=;
        b=oLHMimgBWJct306VRDNbK+Sw20ew9MfE7WJMeY/5Jh6zQN60yK71WS3PweGEXFL2eF
         ikgE9zFoEIJDYtLre6DyF8pwEcX/WdY2PwSYAjD4evTqTw/HoL+LwgfezVfyUwofZaN2
         gkTskPbFby7nKSXfnNJg2AigjbgzIiMl3YhEyQpnKCa63nK927nJrtQCXWcOTUu+OFZ8
         UBp5COzyEu4qAIDR0XARznv/zSTtXkxmvpvUfbtWyktY+fHUY1y15TJbSOy8S9kWlPQX
         iQa9hr+ke7diUmKx/qjyhMdt8eY833VSMxvuoKXWuuGR0qhrTsmGnvGft72TtjsoeG2c
         +14w==
X-Gm-Message-State: ALKqPweWBblKV6GWe02sBwPXWDgUObFkaT+jSZxhMS/yG6n18K3+nbt9
        I1nwBQsFtO9c2DJW98NbZfu9Bw==
X-Google-Smtp-Source: ADUXVKLl0F8J4wYyQl7TBOeZdk78KD5AjRpnS4FAroXYHh2hhDEe2xCbM9QzMcpjgTd0kmKrCqcoxw==
X-Received: by 2002:a17:902:7b95:: with SMTP id w21-v6mr19235347pll.255.1528133620279;
        Mon, 04 Jun 2018 10:33:40 -0700 (PDT)
Received: from google.com ([2620:0:100e:3010:3914:d0ce:3649:b074])
        by smtp.gmail.com with ESMTPSA id p12-v6sm64238864pgn.26.2018.06.04.10.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jun 2018 10:33:39 -0700 (PDT)
Date:   Mon, 4 Jun 2018 10:33:38 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC/BUG] unpack-trees.c: do not use "the_index"
Message-ID: <20180604173338.GA91449@google.com>
References: <20180601161153.15192-1-pclouds@gmail.com>
 <CABPp-BFaFR-ZTg2Wj4gcBPLyb4sejw+guNhWRFXfRRR0UZq4nw@mail.gmail.com>
 <CACsJy8Ai5befewi9OxKzUxTOOOON9wgWpqcNy3AuK1YBk7MbxQ@mail.gmail.com>
 <CABPp-BEMUUrYd_=a1sPYV941rMCdWh_x-4j5uUiCEUFA0Fwoww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BEMUUrYd_=a1sPYV941rMCdWh_x-4j5uUiCEUFA0Fwoww@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/02, Elijah Newren wrote:
> On Fri, Jun 1, 2018 at 10:03 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Fri, Jun 1, 2018 at 8:34 PM, Elijah Newren <newren@gmail.com> wrote:
> >> On Fri, Jun 1, 2018 at 9:11 AM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> >>> This is more of a bug report than an actual fix because I'm not sure
> >>> if "o->src_index" is always the correct answer instead of "the_index"
> >>> here. But this is very similar to 7db118303a (unpack_trees: fix
> >>> breakage when o->src_index != o->dst_index - 2018-04-23) and could
> >>> potentially break things again...
> 
> I'm pretty sure your patch is correct.  Adding Brandon Williams to the
> cc for comment since his patches came up in the analysis below...
> 
> >> Actually, I don't think the patch will break anything in the current
> >> code.  Currently, all callers of unpack_trees() (even merge recursive
> >> which uses different src_index and dst_index now) set src_index =
> >> &the_index.  So, these changes should continue to work as before (with
> >> a minor possible exception of merge-recursive calling into other
> >> functions from unpack-trees.c after unpack_trees() has finished..).
> >> That's not to say that your patch is bug free, just that I think any
> >> bugs shouldn't be triggerable from the current codebase.
> >
> > Ah.. I thought merge-recursive would do fancier things and used some
> > temporary index. Good to know.
> 
> Well, it does does use a temporary index, but for dst_index rather
> than src_index.  It then does some fancier things, but not until the
> call to unpack_trees() is over.  In particular, at that point, it
> swaps the_index and tmp_index, reversing their roles so that now
> tmp_index is the original index and the_index becomes the result after
> unpack_trees() is run.  That's done because I later want to use the
> original index for calling verify_uptodate().  verify_uptodate() is
> then used for was_tracked_and_matches() and was_tracked().
> 
> Anyway, the whole upshot of this is:
>   * merge-recursive uses src_index == &the_index for the unpack_trees() call.
>   * merge-recursive uses src_index == o->orig_index for subsequent
> calls to verify_uptodate(), but verify_uptodate() doesn't call into
> any of the sites you have modified.
> 
> Further:
>   * Every other existing caller of unpack-trees in the code sets
> src_index == &the_index, so this won't break any of them.
>   * There are only two callers in the codebase that set dst_index to
> something other than &the_index -- diff-lib.c (which sets it to NULL)
> and merge-recursive (which does the stuff described above).
> 
> So, having done that analysis, I am now pretty convinced your patch
> won't break anything.  That's one half...
> 
> >> Also, if any of the changes you made are wrong, what was there before
> >> was also clearly wrong.  So I think we're at least no worse off.
> >>
> >> But, I agree, it's not easy to verify what the correct thing should be
> >> in all cases.  I'll try to take a closer look in the next couple days.
> >
> > Thanks. I will also stare at this code some more in the next couple
> > days trying to remember what these functions do.
> 
> Your patch has two divisible parts:
> 
> 1) Your modifications to
>   * clear_ce_flags_1()
>   * clear_ce_flags_dir()
>   * clear_ce_flags()
>   * mark_new_skip_worktree()
> The clear_ce_flags*() functions are only called by each other and by
> mark_new_skip_worktree(), which in turn is only called from
> unpack_trees().  Also, in all of these, your change ends up only
> modifying what index_state is passed to is_excluded_from_list().
> 
> 2) Your modifications to
>   * verify_clean_subdirectory()
>   * check_ok_to_remove()
> In this case, the former is only called by the latter, and the latter
> ends up only being called (via verify_absent_1()) from verify_absent()
> and verify_absent_sparse().
> 
> I'll address each, in reverse order.
> 
> 2) The stuff that affects verify_absent()
> 
> While verify_absent() is not called from merge-recursive right now, it
> was something I wanted to use in the future for very similar reasons
> that verify_uptodate() started being called directly from
> merge-recursive.  In particular, if the rewrite of merge-recursive[A]
> I want to do sets index_only when calling unpack_trees(), then does
> the whole merge without touching the worktree, then at the end goes to
> update the working tree, it will need to do extra checks.
> verify_absent() will come in handy as one of those extra checks.  For
> that case, using the_index (the new index just created with lots of
> changes) would be wrong in all the same ways that using the_index
> caused massive problems for was_tracked() in merge-recursive (e.g. the
> blow up of when Junio merged the original directory rename detection
> series into master and subsequently reverted it); we'd instead want
> src_index (which was the index that existed when merge was called)
> instead.  So, with this patch you've fixed some important bugs that I
> would have hit later.
> 
> [A] sidenote: see
> https://public-inbox.org/git/xmqqk1ydkbx0.fsf@gitster.mtv.corp.google.com/
> for more details
> 
> 1) mark_new_skip_worktree() ... is_excluded_from_list().
> 
> Sadly, I'm not very familiar with the skip_worktree and sparse
> checkout stuff.  However, the fact that mark_new_skip_worktree()
> explicitly takes an index_state (and a different one is passed to it
> the two different times it is called), and that it is the only caller
> of the clear_ce_flags*() family of functions, and that those function
> use the cache entries from the index passed to them in all cases other
> than the calls to is_excluded_from_list() makes those two look like
> oversights.  In fact, a little more digging turns up commit
>    fba92be8f7 ("dir: convert is_excluded_from_list to take an index",
> 2017-05-05)
> and before then, those functions didn't use the_index directly.  But
> they did use it indirectly, because they called a function in dir.c
> that had it hardcoded.  So it looks like Brandon fixed part of the bug
> for us, but moved the incorrect hardcoding from dir.c to
> unpack-trees.c.  Your patch is just fixing it up.  In fact, a little
> more digging turns up:
> 
> 2c1eb10454 ("dir: convert read_directory to take an index", 2017-05-05)
> a0bba65b10 ("dir: convert is_excluded to take an index", 2017-05-05)
> 
> which appear to be the culprits behind the other two uses of the_index
> called from verify_absent().  It looks like before these commits that
> unpack_trees() was carefully using the appropriate index, except that
> functions in dir.c had use of the_index hardcoded.  Brandon fix the
> functions in dir.c for us, but ended up still hardcoding the_index in
> unpack-trees.c.  Basically, he did most of the necessary lifting, and
> your patch just finally changes them over to use the correct index.
> 
> Brandon: Does anything look off in my analysis above?

Nope your analysis is correct with regards to the changes I made to dir.
Back when I was converting ls-files and grep to recursively work on
submodules I needed to make it so that some of the dir functions
explicitly accepted an index parameter instead of implicitly relying on
the_index.  So I bubbled up the hardcoded the_index to the places I
wasn't passing in a specific index (which would be when the_index
appeared in unpack-trees.c) and allowed for arbitrary index's to be
passed in like in ls-files.

This is one of the larger issues with working in our codebase,
implicitly relying on global state.  It makes it very difficult to
reason if a section of code is correct or not, as is in this case.  Is
it a bug that we use o->src_index in some places and the_index in
others?  Well maybe not, but that's because they usually are the same
thing in the few cases that it matters (at least now its a bit more
explicit to see this, whereas before it was very implicit).  Of course I
know stefan has done work with making unpack-trees recursive so maybe
it can be a bug in the recursive case.

-- 
Brandon Williams
