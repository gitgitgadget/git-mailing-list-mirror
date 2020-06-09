Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11DAC433E0
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 11:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BE8E207ED
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 11:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tdNc2jPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgFILGT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 07:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgFILGR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 07:06:17 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A489C05BD1E
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 04:06:17 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gl26so21865158ejb.11
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 04:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=kpu2GxsxdDokuTYcszQzzIbm7vQ5a4x2TxtFRXwPcDg=;
        b=tdNc2jPDXnv9BbyEEmpNkK3QGSUfUgGS91rjZw9dxxECWVUf1OAsf3L68MFf4tUejb
         8fnkYnbF2p9GRP3QsbZ34byK+aO4R2JmhQ/dLjHZPze1/HzutTCiPPxjKtfRnWqoVzbV
         b8d77en8A7e3quhaKk8SiOY3SznVFW/CHobyAekMOxlKwammpMT6rt0WBwWztrb8d0jr
         JcPzNmy0QPUHDpa2trIp1ATy3UGUm/ZXowaIbUBO90B9OPmSiL96JYj2/DlSu/e+TXM2
         u4CLCPBnYvGCHLMFnLfxKfbHNUrn5lDNYSCfRcgDqLI1Q1a9bhSavqLZvVTInO0VGfvO
         xEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=kpu2GxsxdDokuTYcszQzzIbm7vQ5a4x2TxtFRXwPcDg=;
        b=b5RdLADteLq9/BnX4YGC6QGRrTc7f9wgNU76KNuGBfDMW+rnCfWzGi1WmZuj1bplfg
         OMrHujzkJzmE52f7CP9nC/JffCfipvf+8teQmhKYx01SK32UW8cq8Do+/54GKapjaBeu
         CRbJc+6w9Mp6ItRmCZ6taWOUcvo3j3sdM9SRz0L9y8zmi6mMk3XE8ME3raZIyub2jYWB
         eLKpZQkUFqFzOuoq73iDp/k6r70ZdHVz67W26D//7xRs607vfQmxaxniQfzsFPF8rbdN
         y0gcVm87PLbUVJyBNj+T4ud6eJEgIGyKlMoS17cgnKgbuLWO5mvapPSxORGxjBYimuyB
         O2cg==
X-Gm-Message-State: AOAM531ypTMi6rfZyMf08gHAGUFWo33FP/sMmqmPBvWI4mW+w3WYR8N5
        un+v6o+lv9H35ayzpSN/q5NNpgMVywg=
X-Google-Smtp-Source: ABdhPJxz2LVv2o5QMbQeFPm/iu+MAHxCJotoEfXUq6VgMfnqQWpxeW2lI7A9C1n8WNydr65V8IQYrg==
X-Received: by 2002:a17:906:ac3:: with SMTP id z3mr23907269ejf.311.1591700775305;
        Tue, 09 Jun 2020 04:06:15 -0700 (PDT)
Received: from evledraar (h65073.upc-h.chello.nl. [62.194.65.73])
        by smtp.gmail.com with ESMTPSA id k23sm779165ejk.114.2020.06.09.04.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 04:06:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Lin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Lin <johnlinp@gmail.com>,
        Jeff King <peff@peff.net>, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] gc: recommend `git gc --prune=now` instead of `git prune`
References: <pull.652.git.1591581739031.gitgitgadget@gmail.com> <pull.652.v2.git.1591662224566.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.1.0
In-reply-to: <pull.652.v2.git.1591662224566.gitgitgadget@gmail.com>
Date:   Tue, 09 Jun 2020 13:06:13 +0200
Message-ID: <87bllsa47u.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 09 2020, John Lin via GitGitGadget wrote:

> From: John Lin <johnlinp@gmail.com>
>
> `git prune` is a plumbing command and should not be run directly by
> users. The corresponding porcelain command is `git gc`, which is
> mentioned in the man page of `git prune`.

This change feels incomplete without a change to git-prune's
documentation, see 8d308b3540 ("Documentation: point git-prune users to
git-gc", 2008-04-29).

I.e. it still talks about "in most cases you shouldn't run this", but
here we are removing a case where it would otherwise make sense because
the user shouldn't use it directly.

I think instead the small change that makes the most sense here is to
just add "prune" to completions, i.e. I disagree with Denton Liu in
https://github.com/gitgitgadget/git/issues/642#issuecomment-640202110

The "right" change is much harder, there's numerous odd edge cases that
"gc" can get into with these loose objects (for the curious [1] and [2]
are a nice entry to that rabbit hole).

Fixing that is non-trivial, but in the meantime I don't think it's good
to:

 a) Recommend an option to "gc" which implies "repack -a", which as
    noted in gc's docs can produce corruption in a live repository.

    I.e. I don't think "let's not recommend this plumbing" should lead
    us to "let's recommend this thing that could corrupt the repository
    instead".

 b) Even if you don't get the corruption with "a" above "gc --prune=now"
    will produce a very differently packed repository. This might have
    unexpected performance etc. trade-offs the user wasn't expecting
    from a "run this for a quick fix" command.

 c) In the cases where "prune" here would help, e.g. on some large repo
    where something else added a lot of loose unreachable objects during
    the "gc" for some reason recommending a full "gc" might take a lot
    more time than just the "prune".

1. https://public-inbox.org/git/87eflvmovg.fsf@evledraar.gmail.com/
2. https://public-inbox.org/git/8736lnxlig.fsf@evledraar.gmail.com/

> Signed-off-by: John Lin <johnlinp@gmail.com>
> ---
>     Recommend "git gc --prune=now" instead of "git prune"
>
>     Signed-off-by: John Lin johnlinp@gmail.com [johnlinp@gmail.com]
>
>     Fix according to #642.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-652%2Fjohnlinp%2Ffix-git-gc-warning-message-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-652/johnlinp/fix-git-gc-warning-message-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/652
>
> Range-diff vs v1:
>
>  1:  83b7137abfd ! 1:  42aa6380067 Recommend "git gc --prune=now" instead of "git prune"
>      @@ Metadata
>       Author: John Lin <johnlinp@gmail.com>
>
>        ## Commit message ##
>      -    Recommend "git gc --prune=now" instead of "git prune"
>      +    gc: recommend `git gc --prune=now` instead of `git prune`
>      +
>      +    `git prune` is a plumbing command and should not be run directly by
>      +    users. The corresponding porcelain command is `git gc`, which is
>      +    mentioned in the man page of `git prune`.
>
>           Signed-off-by: John Lin <johnlinp@gmail.com>
>
>
>
>  builtin/gc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 8e0b9cf41b3..74185eac917 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -692,7 +692,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>
>  	if (auto_gc && too_many_loose_objects())
>  		warning(_("There are too many unreachable loose objects; "
> -			"run 'git prune' to remove them."));
> +			"run 'git gc --prune=now' to remove them."));
>
>  	if (!daemonized)
>  		unlink(git_path("gc.log"));
>
> base-commit: 20514004ddf1a3528de8933bc32f284e175e1012
