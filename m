Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAFFC4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 13:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8D661078
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 13:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhHGNvl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 09:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbhHGNve (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 09:51:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BC5C06179F
        for <git@vger.kernel.org>; Sat,  7 Aug 2021 06:51:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso22363961pjf.4
        for <git@vger.kernel.org>; Sat, 07 Aug 2021 06:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a29aTmDl805Bf4IwEX0/OsLFz7yzLlXLikE/5q/bLyc=;
        b=S07YSl+OfWEFBQ3zg73U3/uKE0inbmF2BVpQ9pXO0aYXEu01L1wUpXIwQA+qFqaCCX
         XVLIQ4UlvhoaymYkWy2BeaoHKkZFtrA9bJ6GGE6/dT1eXL/dN74uHbknfi0iAQefILOd
         zqvDhOi6ueilI7zNK4/f+1+VwRSFPd7Pk5puYMw9w5zBvoCMhvRrZFYwG3iLkiiE2X9L
         +MQYh9vFDbujQhrmUyOGSCfwkR6s6rLRr388qZTJj4oa9Klg7JyvboR3PfqCeZj8dWXp
         kNl43bqjLlgXSupgzmB5/fIlJLQdPt4pU/bWmFPeSWO71VDnwV643jHcJluQHwplqvHd
         zgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a29aTmDl805Bf4IwEX0/OsLFz7yzLlXLikE/5q/bLyc=;
        b=geyiRegfC8qi/VLtgqtBisMnqTHlG8kwKy1NfH0YwVoVgIlxDJ0CWY8+7b4A5dIjFD
         1sjXjdSHKH5cbUhtlq/U8jKGBQ6KOFzeuUAmFP9VlFlBXaqn7Mg23X/0QJqzvvVbp8cf
         mXnAFy/WP7Qqm5NfSmy2bNiiQD/sTLVzS/1hkjUqgxCIVOg1D2fa8op/59YZhE7JgtfD
         KQyZVCbbBlZ3sKxQYRfm8gLGJmEMqg89MPpEHdwLb2ThW0JlFv8xl6AiaRRYzjOXjZ9+
         Cglpev5KqXA6iw/+roPvroTl+oO54x9RypfJxxefP46B9qzUgKEVbdYzSYQKQlLCb1bn
         W83g==
X-Gm-Message-State: AOAM532UPYtAoSp06rnWKAm0u6jxlHAd458aQld/pZiGB0nxzJBxk61K
        DsMiFsz0Ztc632QbjLxufr0=
X-Google-Smtp-Source: ABdhPJw1RRTUO3WoUW8L1p+Y6w6FupvhnqqlAJKKQIuCCXoj3dKtE5cXi10AAMquedsneqZSQd7cgg==
X-Received: by 2002:a17:902:d50c:b029:12c:9177:65b0 with SMTP id b12-20020a170902d50cb029012c917765b0mr12871204plg.1.1628344275648;
        Sat, 07 Aug 2021 06:51:15 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:7578:9c9b:8fe8:cece])
        by smtp.gmail.com with ESMTPSA id n11sm2081881pjh.23.2021.08.07.06.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 06:51:15 -0700 (PDT)
Date:   Sat, 7 Aug 2021 06:51:12 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Hudson Ayers <hudsonayers@google.com>,
        Taylor Yu <tlyu@mit.edu>, Joshua Nelson <jyn514@gmail.com>
Subject: Re: [PATCH] Revert 'diff-merges: let "-m" imply "-p"'
Message-ID: <YQ6P0OWPPksWG5Hf@google.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210520214703.27323-1-sorganov@gmail.com>
 <20210520214703.27323-11-sorganov@gmail.com>
 <YQtYEftByY8cNMml@google.com>
 <YQyUM2uZdFBX8G0r@google.com>
 <xmqqh7g2ij5q.fsf@gitster.g>
 <YQ3n9Z2nH35429mC@google.com>
 <035b4e99-e708-f31b-2f13-e255d99dea33@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <035b4e99-e708-f31b-2f13-e255d99dea33@kdbg.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

Johannes Sixt wrote:
> Am 07.08.21 um 03:55 schrieb Jonathan Nieder:

>> The motivating example (Rust) shows that there is at least one script
>> that _did_ use "-m" in this way.  Rust has mitigation, but the above
>> logic leads me to believe that they are not the only project that will
>> be affected.  And more generally, when a script author has a
>> reasonable reason to believe something will work, they write scripts
>> where it _does_ work, and then an update breaks their script, I think
>> it's reasonable for them not to be happy.
>
> As you know, we have "plumbing" commands with a stable interface and
> "porcelain" commands for which we reserve to change the behavior without
> advance notice. By your reasoning we would not need to distinguish
> between the two categories and were forced to keep all behavior stable.
> This undoing of a behavior change in a "porcelain" command with the
> argument that one script depended on the old behavior and that others
> might do so as well would set an unwanted precedent.

Hm, this is worth elucidating a bit more, since I am definitely in
favor of continuing to change porcelain commands for the better where
we can.  If we decide that "git log --format=<fmt>" is no longer part
of the stable scripting interface we provide, then that would be a
huge change for our callers (and it's probably too late), but I would
certainly be in favor of us going back in time and doing that. :)

More generally, we've been able to make changes to porcelain commands
that don't hurt our ability to act as a platform for scripts, and I
want us to continue to be able to do that.  "Do not break any script"
is certainly not the standard I think we should apply, as illustrated
by my thoughts upthread when I thought '-m' in this Rust example was a
typo.

But by now it's very clear to me that it was not a typo.

In other words:

- this isn't only about one obscure script.  The point of the "this
  was not a typo" logic is to illustrate that in addition to the
  examples that we know about it is very likely that there are
  examples that we don't know about, in teams' script collections
  beyond the reach of search engines.

- In fact, in addition to the motivating example that makes it
  possible to build Rust, we had multiple in-tree scripts that would
  also have broken by this, if they had not been adapted to work
  around that in the same series!  I should have noticed that in
  review, and I'm sorry that I didn't.

> Perhaps we need to point script authors to "plumbing" commands more clearly?

I think the existence of "plumbing" is fairly well known, but users
don't always have an easy time using it.  The "porcelain" is what ends
up getting the most attention in improvements, and so while I
encourage script authors to use 'git rev-list <revs> | git diff-tree
-s --stdin --format=<fmt>' in place of 'git log --format=<fmt>
<revs>', most do not listen, and I can't really blame them given how
much more convenient the latter is and how many more options it
supports.

I don't think that situation will change unless we

 a. Maintain a second, parallel implementation of each porcelain
    command that only uses plumbing.  This would provide an example of
    how to use plumbing and would ensure that the plumbing grows in
    capability at the same time as the corresponding porcelain.  Or

 b. Expose a library interface, so that we can expose the actual
    helpers that support the standard implementation of porcelain
    commands.

I tried a little of (a) years ago by updating contrib/examples/ to
pass tests: https://lore.kernel.org/git/20100817065147.GA18293@burratino/.
It was fun but I don't think it's really sustainable.

In the long term, I think (b) is going to be an important thing to do,
and I think it will be helpful.  Some automated callers would
appreciate the ability to pass structured input instead of having to
pretend to be shell scripts. :)  True shell scripts would also benefit
because the plumbing commands can more directly map to such a library
API.

> (BTW, I have no opinion on whether -m should or should not imply -p.)

Nevertheless, thanks for weighing in.

Jonathan
