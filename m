Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92E0C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 06:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A9CD206B9
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 06:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVrOjZln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgD1GWi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 02:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726042AbgD1GWi (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 02:22:38 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1786FC03C1A9
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 23:22:38 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id j26so30749134ots.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 23:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fg/DMFwT0Xu4UNyAs9WT1QHYr7nehZ/cr2qE7WOT1CU=;
        b=PVrOjZlnhiSI7HHnH3MYSFT3ac61/LT+1oouqSeepkjnB2DoFUD/onSaBaQ036mXZh
         E1Bu1EGK9fU1oqg/daE12uoogKwINZebCi81pOQ5ORynKsAbpGLF/O56MpTuQVJaVMU4
         SZfPr6pG+nI7fHcnRrmT5+en2RBzz9t2Nj98RknvFynT0coYEaAQuUzwqZMdnRTTXMhT
         NVeQz23/i5atpsP9P5RkubPqLSMxvKbpx+qJ/z3I2ZqJEj2P2YuFtgIvnaA0cP24lNsE
         RCM4K4DmM97TUcFN+dayvQ3fj/RRUlk4hP/LjGKSnYspYxGPjZRGxiV4dS2GnIk5pSAj
         PKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fg/DMFwT0Xu4UNyAs9WT1QHYr7nehZ/cr2qE7WOT1CU=;
        b=c7QGrkV7alLDXUyzkPKF+OAT9eZYI9bOxOeH11S+mihUuI50dGa2yr2eeWTyhqbJOX
         pc7A/ibjV/eFN4s0PV5HPVY4Ag1SEVidvJWikVDLMbdxXr0BX6/iOZ3UrQvcqJuPvnN7
         r8ZJ59B1CQQCdqaybdeku3vqes0EvIV1Fdp/10cJk1VfsaGI9EimbZf6Uu77VPqXNf2d
         0kcfeQW9BMN7lsjLsiZKoJM7skZKu3j91pAH5csshGVU8bTNqFCG8ucbnDnTdoQOleRs
         EQZy73lf2bEg+6Redz5Gj3NUiuBvoAt7hasKxK+v2JWbwixSG1du/fM1ihE7yzd06Br7
         HB8w==
X-Gm-Message-State: AGi0PuZ9v5m12ACRWRm7RVn5siDpOMRnABqjwX7CPHTQSZFocJA/ii6H
        AFvJxSPd1ptoXdNgFcdFf9znGODGKZTej3fqBBU=
X-Google-Smtp-Source: APiQypIPEM7MzVU8+m5eZUGaVBWkHQZm5DE3IB+1anM4i1FWdwfQtPCaj4GyhyYOTum5ejP8f6JlPLK5Gf8v0G/lpT4=
X-Received: by 2002:a9d:2aa9:: with SMTP id e38mr7676819otb.162.1588054957218;
 Mon, 27 Apr 2020 23:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200428055514.GB201501@google.com>
In-Reply-To: <20200428055514.GB201501@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Apr 2020 23:22:24 -0700
Message-ID: <CABPp-BE+mFCWVkuhs_80qtQwWTtMKo6OfdmG3cmJ98FS7Csxww@mail.gmail.com>
Subject: Re: Preparing for a Git 2.26.3 release
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 10:55 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> Last week and the week before Git released 2.26.1 and 2.26.2 in quick
> succession, to address some security issues (CVE-2020-5260 and
> CVE-2020-11008).
>
> Since then we've heard about a few related (non-security) regressions.
> I'd like to avoid giving people an excuse not to upgrade, so this
> morning[1] I promised a discussion of what I'd like to see in a 2.26.3
> release to help with that.
>
> credential_from_url fallout
> ---------------------------
> The credential_from_url hardening affected http.c in the way we'd
> like, but it also affected credential-store[2].  We may want to relax
> that.
>
> (only affects 2.25.y and earlier) The credential_from_url hardening
> also affected credential.<urlpattern>.* parsing[3].  Depending on what
> semantics we decide on for those earlier releases, we are likely to
> want 2.26.y to behave the same way[4].
>
> 2.25.y -> 2.26.0 regressions?
> -----------------------------
> The main major changes from 2.25.y to 2.26.y were the change of
> default rebase backend and protocol.version defaulting to 2.
>
> I don't believe there are any major outstanding issues with the
> change in rebase backend, but I'm cc-ing Elijah Newren to get a chance
> to be corrected :).

I'm not aware of any outstanding (by which I think you mean
"unsolved") issues, but there are four short topics fixing regressions
in master since v2.26.x (namely:
ag/rebase-merge-allow-ff-under-abbrev-command,
en/pull-do-not-rebase-after-fast-forwarding,
en/sequencer-reflog-action, and en/rebase-no-keep-empty).  Some or all
of those topics might make sense to include in a stable release if
you're considering fixes other than security updates.

> The protocol version change was painful for users that fetch in the
> same repo from linux-next and other linux remotes[5].  The problem has
> been isolated and fixed, so we could either apply the revert or apply
> the fixes[6].
>
> credential helper hardening
> ---------------------------
> Lastly, after seeing a v2.26.1 security release and v2.26.2 security
> release in quick succession, I'm looking at what it would take to make
> Git more robust so we don't end up need .3, .4, .5 security releases
> soon after.  Perhaps we can make the credential system a bit more
> robust to prevent future similar accidents.  For example:
>
> - teach in-tree credential helpers to reject repeated fields in their
>   input (Just In Case some variant of newline injection that uses \r
>   or something pops up)
>
> - teach in-tree credential helpers to require the host and protocol
>   fields to be set (e.g., [7])
>
> - update git-credential(1) to document the newly tightened protocol
>
> That might go against the goal of getting rid of excuses not to
> upgrade, though.  Where we see regression potential, we can be patient
> and wait for 2.27, but if we have some examples with particularly low
> regression potential then they might be okay 2.26.3 fodder as well.
>
> Thoughts?
>
> Thanks,
> Jonathan
>
> [1] https://colabti.org/irclogger/irclogger_log/git-devel?date=2020-04-27#l65
> [2] https://lore.kernel.org/git/20200426234750.40418-1-carenas@gmail.com/
> [3] https://lore.kernel.org/git/pull.615.git.1587588665.gitgitgadget@gmail.com/
> [4] https://lore.kernel.org/git/pull.620.git.1587767749.gitgitgadget@gmail.com/#t
> [5] https://lore.kernel.org/git/20200422155047.GB91734@google.com/
> [6] https://lore.kernel.org/git/cover.1588031728.git.jonathantanmy@google.com/
> [7] https://lore.kernel.org/git/20200420224310.9989-1-carenas@gmail.com/
