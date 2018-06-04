Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7434D1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 01:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeFDB60 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 21:58:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40527 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbeFDB6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 21:58:25 -0400
Received: by mail-wm0-f68.google.com with SMTP id x2-v6so11709781wmh.5
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 18:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=9bBVO30m2lONHkhRQuCNfR0E5XG7/pesSBkxzd52j6w=;
        b=FNzKof+FAg334tyPtei6IYnv/c29X/4p5Bcye79+Wi7rg7otqVNlPoPiwfta4504tW
         keuWDlY/A67zAvU/iegzuSRPigCfFnuaOJ4/X5RYOzSfZWQJCkUJIhuF6s+9R1iLZ4wE
         me/zH0Ag4LKJfbNeDymOPNkJDE2tm0G77+QMYM46Jh2C0lJQ3j0lYCmylXDMzbCETDIs
         1e3iAbqzAcov47B/VZftce1eoygnCX6SWMtPlJ8i9nXBr9hQ5XDf+wF6E+F3HKSao0UC
         KboTBmgPdCeQ86Lk5qmx/T3ltjs2cogbKd9LYFBV5yj7h4Hs5RQKIKA8fFmL2SvJVxV1
         mHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=9bBVO30m2lONHkhRQuCNfR0E5XG7/pesSBkxzd52j6w=;
        b=KO91TbPhhMPuO9L6YnNE+W6oiOYupMHW37LZ8Gm93f16Jcojjaonk25ZmKnwttWs8A
         +/lQZEhspo7n4uC8bMmLl+pQay0GmDkbncLpj3yNDW+cPmkwmDSx+0ZsBgQXyICIl532
         orkzido+7/pURtimNp/4M1OSkC5lBKhOQM41sAatsd3KGqgN1RXZeNSXUCHUosk6BY1N
         bXgTI0+p7PtSfF2J/oo78ti1oJ4hU5FbkGZaI2vCj2BFylP3JR+bhiB98ZxxeTsdLt9/
         g9AzcQNuuIwXwTuEv2V9gkDd5yguI496RlZm0IxR+/TKpwDkmxC4beDOcWQ24MX+biQE
         dCxw==
X-Gm-Message-State: ALKqPwemD57o7EP53k9uY2kkQEDfpRNFAuH8sDIXpZjgjgSPfyNAU4nm
        nc44a2TRewblBZRDzQgO0JQ=
X-Google-Smtp-Source: ADUXVKIb0RV7bGkFNRaWBfKAUgewZ0paOBNSh7S6ZIJV8fXESRXue6PG/gTxkda5/L+FEefioF6qDw==
X-Received: by 2002:a1c:dc41:: with SMTP id t62-v6mr8057566wmg.42.1528077503759;
        Sun, 03 Jun 2018 18:58:23 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 141-v6sm10613706wmf.35.2018.06.03.18.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Jun 2018 18:58:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 8/9] checkout: add advice for ambiguous "checkout <branch>"
References: <20180531195252.29173-1-avarab@gmail.com>
        <87a7sg9sjz.fsf@evledraar.gmail.com>
        <20180531195252.29173-9-avarab@gmail.com>
        <xmqqin7386tv.fsf@gitster-ct.c.googlers.com>
        <xmqqefhr850j.fsf@gitster-ct.c.googlers.com>
        <871sdqal2g.fsf@evledraar.gmail.com>
Date:   Mon, 04 Jun 2018 10:58:21 +0900
In-Reply-To: <871sdqal2g.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 01 Jun 2018 11:54:31 +0200")
Message-ID: <xmqqlgbv71oi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I.e. I was trying to avoid printing out the "error: pathspec 'master'
> did not match any file(s) known to git." error altogether. That's still
> arguably a good direction, since we *know* "master" would have otherwise
> matched a remote branch, so that's probably a more informative message
> than falling back to checking out pathspecs and failing, and complaining
> about there being no such pathspec.

That ideal behaviour makes sense.

> But it was a pain to handle the various edge cases, e.g.:
>
>     $ ./git --exec-path=$PWD checkout x y z
>     error: pathspec 'x' did not match any file(s) known to git.
>     error: pathspec 'y' did not match any file(s) known to git.
>     error: pathspec 'z' did not match any file(s) known to git.

Let's take a detour to a tangent, as this example does not have
anything to do with the remote-tracking auto-dwimming. 

Ideally what do we want to say in this case?  What's allowed for 'x'
(2 possibilities) is different from whats allowed for 'y' and 'z'
(only 1 possibility)---do we want to complain that 'x' is not a rev
noris a file (we do not say 'x' could be a misspelt rev name right
now), and then 'y' and 'z' are not files (which is what we do now)?

That might be an improvement.  I dunno.  In any case, that is a
tangent that we do not have to address with these patches.

In contrast, the command line without y and z gives three
possibilities to 'x'.  'x' is not a rev, is not a remote-tracking
branch name that only a single remote has, and is not a file.  Now,
if we are going to mention that we failed to interpret it as the
latter two, perhaps we should also mention that it was not a rev
(which could have been misspelt)?

> So I decided just to let checkout_paths() to its thing and then print
> out an error about dwim branches if applicable if it failed.

Yeah, I think I get it now.  If you want to silence the "error" from
report_path_error() and replace it with something else, you would
need to change checout_paths(), as this function is sort-of used as
the last ditch effort after all else failed, and right now it is not
aware of what exactly all these other failed efforts were.

Thanks.  I'm looking at v6 reroll for queuing.



