Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 978982095D
	for <e@80x24.org>; Wed, 22 Mar 2017 21:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751792AbdCVVqU (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 17:46:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34885 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbdCVVqT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 17:46:19 -0400
Received: by mail-wm0-f68.google.com with SMTP id z133so13186156wmb.2
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 14:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=krT3l4+gbpGqeBUpAiYEYLNJ1EhgmiYw28vv+OBJSSY=;
        b=ZYDcZpcfHnY0tpEK/bTEIISLXTL6IEi4gAaB+f7yiAx+2Ubj2lKLeSv3yItmWEPBqX
         B2Cp0zEAU35AMaHXbKjHVsurdgiDK3+4FK3AkiXmRIsf8wqY1jrBb3x0wbpOQKLog9sM
         CnAqOVedwZeKd1cbWWR4PBJyJRaeu//A4GzFhvtH4rr7gJVkUAWfLmOlwmiV+7OQ7tXs
         TNrz0DvYmWDWJ0SNRebwkDwu1Du2QdZUC6Jgi1F9xZ8CdGj9TC0yq1Qar6Ov2+GFdZEK
         aWn0Cj14uVgei6kCUSTq46ZUmHofuXV3AZTdui41jzudHW+yahxPbT+7FZwk9tbGzMCv
         LetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=krT3l4+gbpGqeBUpAiYEYLNJ1EhgmiYw28vv+OBJSSY=;
        b=LQpkCRhNuvFlCyo/ac9TRMmP3wgHWKaFtfZyh4AXPhrn6dPX7mZbly/ivaXl4MDplv
         iMILK/njJ2M2rzrq0Tw5Z2VuxzG8ZecHgPArU4Wr6UCfgKLO6agIjPAPkRqrY5ck7SHv
         EymNKOAhG3mBD7FOvSoJv7jtB3RKXlPYxmH6TYwJtzR4sGgREffBAc2LDtZWUFst8Db6
         cHkLHKjpsQRiniP9tarWRldhN3ObCgp8BRwVYMQw0EuVVZ6eg7vNfFY4b8nwPKqYuPn8
         uFq3ltTMtfueLhMsUwt12P7hbOofOU0U2nNRXWGQJSdYZnBPKJJyg4H9EcvXu3DprKsc
         sBtA==
X-Gm-Message-State: AFeK/H2MJVsCZscJjnkAB2yqFEnrEuzvj/GoIPbnsEd5EMcGNzIW9vxl5Y5lE+7ZgoaF+g==
X-Received: by 10.28.88.129 with SMTP id m123mr10428709wmb.28.1490219176916;
        Wed, 22 Mar 2017 14:46:16 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id 36sm3299154wrk.15.2017.03.22.14.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Mar 2017 14:46:16 -0700 (PDT)
Date:   Wed, 22 Mar 2017 21:46:34 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] stash: keep untracked files intact in stash -k
Message-ID: <20170322214634.GG27158@hank>
References: <20170319202351.8825-1-t.gummerer@gmail.com>
 <20170321221219.28041-1-t.gummerer@gmail.com>
 <20170321221219.28041-4-t.gummerer@gmail.com>
 <20170321223809.c7wik5lfjylno6wn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170321223809.c7wik5lfjylno6wn@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/21, Jeff King wrote:
> On Tue, Mar 21, 2017 at 10:12:19PM +0000, Thomas Gummerer wrote:
> 
> > Currently when there are untracked changes in a file "one" and in a file
> > "two" in the repository and the user uses:
> > 
> >     git stash push -k one
> > 
> > all changes in "two" are wiped out completely.  That is clearly not the
> > intended result.  Make sure that only the files given in the pathspec
> > are changed when git stash push -k <pathspec> is used.
> 
> Good description.

I basically just tweaked your report here :)  thanks for that!

> > diff --git a/git-stash.sh b/git-stash.sh
> > index 13711764a9..2fb651b2b8 100755
> > --- a/git-stash.sh
> > +++ b/git-stash.sh
> > @@ -314,7 +314,9 @@ push_stash () {
> >  
> >  		if test "$keep_index" = "t" && test -n "$i_tree"
> >  		then
> > -			git read-tree --reset -u $i_tree
> > +			git read-tree --reset $i_tree
> > +			git ls-files -z --modified -- "$@" |
> > +			git checkout-index -z --force --stdin
> >  		fi
> 
> I briefly wondered if this needed "-q" to match the earlier commit, but
> "checkout-index" isn't really chatty, so I don't think so (and the
> earlier checkout-index doesn't have it either).

Yep, I had the same thoughts here.

> I also wondered if this could be done in a single command as:
> 
>   git reset -q --hard $i_tree -- "$@"
> 
> But "git reset" can't handle pathspecs with "--hard" (which is why the
> similar case a few lines above uses the same commands).

Yeah unfortunately, that would have made the previous patch series
quite a bit easier :)  But here it wouldn't help anyway, as git reset
without pathspecs can't handle a tree-ish either, right?  And we also
want to handle the case where no pathspecs are given to git stash.

> 
> So this looks good to me.
> 
> > +test_expect_success 'stash -k -- <pathspec> leaves unstaged files intact' '
> > +	git reset &&
> > +	>foo &&
> > +	>bar &&
> > +	git add foo bar &&
> > +	git commit -m "test" &&
> > +	echo "foo" >foo &&
> > +	echo "bar" >bar &&
> > +	git stash -k -- foo &&
> > +	test "",bar = $(cat foo),$(cat bar) &&
> > +	git stash pop &&
> > +	test foo,bar = $(cat foo),$(cat bar)
> > +'
> 
> I always get nervous when I see test arguments without quotes, but I
> think this is fine (and I couldn't see a shorter way of doing it with
> test_cmp).

Hmm yeah I basically copied this from a different test and tweaked it
a bit to fit here.

> -Peff
