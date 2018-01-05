Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1912B1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbeAEUBH (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:01:07 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:33365 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751731AbeAEUBG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:01:06 -0500
Received: by mail-wr0-f171.google.com with SMTP id p6so5250001wrd.0
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BHZvjkg//yu58PWQlqONvegEhm+vjmDKVCXTxIc+/LU=;
        b=OYfJrjozupj4za88ixOgpN3PkJd5abpy8XP4B5VvJhzegjOf2imZyIpblQMRIZUI9l
         9/CJt+iZpEcD2C7vaH5xfbOBuKo03RPZMRHYOHN1tRLjTkwKmHNtDcOuc1H3s0Bxm1wN
         d0JMpjUiTyfMoLMBtPIec2BZuuPgSfwEwA5hOpCNHTTqAbA0jZCKK54GdZmoNmtUK6Kr
         eI4rGDf+tEe7WLTyJWS5BwGUWZfQVTu1lo5DusvxkAwVf/DoToaDS5uUASHpYL6WZR6a
         5qubMq9rzgRLQONi1lklFOYNuwmpwDmv+4EgfcqoFSRAip+X4eHnY+Ch87f0x1H40h4E
         afRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BHZvjkg//yu58PWQlqONvegEhm+vjmDKVCXTxIc+/LU=;
        b=oVwzPFKDojucsdEJe7V9sh5qQaQ70j9VMQeaHp4rJsqF6YEwNg/t/7vpc3VXdz6RoH
         PE/Adpxv3Z7yUqFmpEvNzqzimXzy3h2qIFoybSmoIasWZ98OH7R8Eb71SoXoXNcT8/r1
         lKvmfIn+FpB0YJeSiMH6F+BXzfEIe92i8CV0ItF440gpYml0sEFPeN/eE/CsA7wnGM/d
         w/N9RcpWNI+adfLof10bf/xZ22AQCwBUGnOen6F5OQzokYlDpUmno6XNEmFauCAs2ea6
         K3rWAEash0wJ1Jz0Bvz4SJb1DLBBfF1kqdkZ4o2bYoGrYhs84RqPDn99/bHg1DlTIrew
         T0Cg==
X-Gm-Message-State: AKGB3mKj+GejoQkHQE/ZRW44BEYNxg8kkclTcdB9BU4hhDo/X2V9BAnJ
        BNKUhtFb0dKVOkJCt3i+gE0=
X-Google-Smtp-Source: ACJfBouszijhg9DEtG+WzZ5s7rI56W3bO0i2jswtC8PLHcaKoqQEE889YB3Aat3mSNhKIybA1ID3Gw==
X-Received: by 10.223.197.11 with SMTP id q11mr3729083wrf.186.1515182464520;
        Fri, 05 Jan 2018 12:01:04 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id u194sm7237113wmd.6.2018.01.05.12.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:01:03 -0800 (PST)
Date:   Fri, 5 Jan 2018 20:03:13 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Reid Price <reid.price@gmail.com>, git@vger.kernel.org
Subject: Re: Apparent bug in 'git stash push <subdir>' loses untracked files
Message-ID: <20180105200313.GF2641@hank>
References: <CA+HNv10i7AvWXjrQjxxy1LNJTmhr7LE4TwxhHUYBiWtmJCOf_A@mail.gmail.com>
 <20171213230547.GC24597@hank>
 <xmqq4loqplou.fsf@gitster.mtv.corp.google.com>
 <20171217180511.GA2641@hank>
 <xmqqpo7byjwb.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpo7byjwb.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/18, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Ah interesting, what you have below looks good to me indeed, it
> > matches what I'd expect it to do and fixes the bug that was reported.
> > Thanks! 
> >
> > I've taken the liberty to take what you have below and turned into a
> > proper patch, giving you authorship of it, as you wrote the code for
> > the fix.  Hope that's the appropriate credit for you for this patch.
> 
> Not so fast.
> 
> I know why the updated code works like "--hard -- <pathspec>", but I
> do not quite get what the original was trying to do and how it is
> different.  Even with your proposed log message, which describes a
> symptom (i.e. "untracked files ... be deleted"), it is unclear why
> this deletion was happening in the first place.  Specifically, it is
> unclear why that "clean --force -q -d" was in there, and are we
> breaking other cases by rewriting this codepath without it?

As you hint at below, the intention was to get rid of the files that
were unstaged by 'git reset', but didn't realize that it would also
delete files that were already untracked before the 'git reset' and
thus not in the stash.

It behaves fine if the pathspec matches a filename exactly, which is
why it worked in all my tests, but is obviously broken in the case
where the pathspec matches untracked files that are around.

I completely failed to realize this, and we wouldn't break any
intended usecases with the change.  I'll update the commit message to
include this information. 

> In any case, instead of the 
> 
> 	ls-files -z -- "$@" | checkout-index -z --force --stdin
> 	diff-index -p HEAD -- "$@" | apply --index -R
> 
> sequence, a shorter variant that should work is
> 
> 	add -u -- "$@"
> 	diff-index -p --cached HEAD -- "$@" | apply --index -R
> 
> Both of these share the same idea.  
> 
>  - The first step is to match what is in the index and what is in
>    the working tree (i.e. make "diff-files" silent).  The version
>    you have does so by checking out what is in the index to the
>    working tree.  The shorter one goes the other way and updates the
>    index with what is in the working tree.
> 
>  - Once that is done, we ask diff-index what got changed since the
>    HEAD in the working tree (or in the index in the updated
>    one---after the first step that makes the two match, comparing
>    with the working tree and comparing with the index should result
>    in the same diff; I have a suspicion that "--cached" is faster,
>    but we need to benchmark to pick), and ask apply to get rid of
>    all these changes, which includes removal of added files, and
>    resurrection of removed files.

Thanks for the explanation.

> I think the original that did 'git reset -- "$@"' upfront lost new
> paths from the index (without removing it from the working tree), I
> am guessing that it is why "clean" was there to get rid of them, and
> if that is the reason, I can understand why the original code was
> behaving incorrectly---it would get rid of new files that did not
> exist in HEAD correctly, but it also would remove untracked ones,
> because after that first 'reset', the code couldn't tell between
> them.
> 
> And I think that is what we want, i.e. why the original was wrong
> and how the new one fixes it, to describe in the log message to
> justify this change.
> 
> One thing that I didn't think through and you need to verify is if
> we need to do anything extra to deal with binary files (in the old
> days, we needed --full-index and --binary options to produce and
> apply a binary patch; I do not offhand know if that is still the
> case) in the final "diff-index piped to apply -R --index" dance.
> 
> So I am asking you to fill in quite a lot of gaps that I didn't do
> with only the above two-liner ;-)  You should take the authorship
> and, if you like, credit me with helped-by: or something.

Thanks, I'll fill in the gaps, and send a new patch, hopefully over
the weekend.

> Thanks.
> 
> 
> >
> > [...]
> >
> > --- >8 ---
> > From: Junio C Hamano <gitster@pobox.com>
> > Subject: [PATCH] stash: don't delete untracked files that match pathspec
> >
> > Currently when 'git stash push -- <pathspec>' is used, untracked files
> > that match the pathspec will be deleted, even though they do not end up
> > in a stash anywhere.
> >
> > Untracked files should be left along by 'git stash push -- <pathspec>'
> > unless the --untracked or --all flags are given.  Fix that.
> >
> > Reported-by: Reid Price <reid.price@gmail.com>
> > Test-by: Thomas Gummerer <t.gummerer@gmail.com>
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  git-stash.sh     |  5 ++---
> >  t/t3903-stash.sh | 16 ++++++++++++++++
> >  2 files changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/git-stash.sh b/git-stash.sh
> > index 1114005ce2..a979bfb665 100755
> > --- a/git-stash.sh
> > +++ b/git-stash.sh
> > @@ -322,10 +322,9 @@ push_stash () {
> >  
> >  		if test $# != 0
> >  		then
> > -			git reset -q -- "$@"
> > -			git ls-files -z --modified -- "$@" |
> > +			git ls-files -z -- "$@" |
> >  			git checkout-index -z --force --stdin
> > -			git clean --force -q -d -- "$@"
> > +			git diff-index -p HEAD -- "$@" | git apply --index -R
> >  		else
> >  			git reset --hard -q
> >  		fi
> > diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> > index 39c7f2ebd7..6952a031b2 100755
> > --- a/t/t3903-stash.sh
> > +++ b/t/t3903-stash.sh
> > @@ -1064,4 +1064,20 @@ test_expect_success 'stash -k -- <pathspec> leaves unstaged files intact' '
> >  	test foo,bar = $(cat foo),$(cat bar)
> >  '
> >  
> > +test_expect_success 'stash -- <subdir> leaves untracked files in subdir intact' '
> > +	git reset &&
> > +	>subdir/untracked &&
> > +	>subdir/tracked1 &&
> > +	>subdir/tracked2 &&
> > +	git add subdir/tracked* &&
> > +	git stash -- subdir/ &&
> > +	test_path_is_missing subdir/tracked1 &&
> > +	test_path_is_missing subdir/tracked2 &&
> > +	test_path_is_file subdir/untracked &&
> > +	git stash pop &&
> > +	test_path_is_file subdir/tracked1 &&
> > +	test_path_is_file subdir/tracked2 &&
> > +	test_path_is_file subdir/untracked
> > +'
> > +
> >  test_done
