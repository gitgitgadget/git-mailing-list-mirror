Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16480C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 21:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E238E61245
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 21:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhFUV3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhFUV3e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 17:29:34 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAC4C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 14:27:19 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id v11-20020a9d340b0000b0290455f7b8b1dcso6263715otb.7
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 14:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hzmP+MtnPCgRSJhjIEynL+TYwMRdJcS7aBe9sxUq2vo=;
        b=ow++/LenScpdMXsNoACD+lj3xyKLyc2v3ReUeeFZuRkT6ijkdJ31/7lOv+A+Y8Ugn8
         692EI7IGW8cojVYE/OrSThwIfRN+46qfIObst/4uUIHpXGQ5pmtfqObYcOABbcY3j2Tp
         ebgCGI3DzzcLvzuOoZBSs7UoHq9VuddbR7ZT0uvnkxv5fw5gvD1hJm2k00g0M4A2afvQ
         Hx6iGfuWkXUOgySxeSqNluK9o5bRheJ6VpPLz+Bda9tleLsP+TVNeolf+s1d1C8LH6qh
         EeY0n7cA9kmixTelGCeppLviUQTTGUp9k03v2rvbgtC3PcKGhTQRemTrJrKeT5gWZQm4
         IFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hzmP+MtnPCgRSJhjIEynL+TYwMRdJcS7aBe9sxUq2vo=;
        b=TupJB7otF4TilN4QZaL0n+YPCNqsTKE5sXflqNIZBa6dgstBOScjEvXd7LKp1Uy5+M
         QHLGFvwvhEiBJgg587xfjJnH1mod+ujHDeE8KtJcC0A3YcK83TMGqn1XGPlrjAmbhGGB
         FSpesGKYjUDoY+9dRWmKXv4cah+gckn2WD/HJgzyDltr8ck585z3dRtyH+ZiZbgROw7O
         926RhSpUXLGr8/BTTJJDIKLA0+SR82EGVRtVCL2A5EdRgAcOceeoUk+0mRo6vGO4Kbmx
         EMU3yrex0m+4R/FiO/jqZyshiXHJmRSWLaQYeFzeSZyVfqU8BhkIsA4MkCNWHrj22oi9
         SNPw==
X-Gm-Message-State: AOAM5303YyHqP+bz/YumdxgPVXK+c3jBQ2dk39LqtAQOe4Kpik7rzQUM
        Uc7CKJSDTiirVEQPPpLXAFAmxDQ1wNhlwRMyrGw=
X-Google-Smtp-Source: ABdhPJyNg2h+LkcDHcwuFfyN1qM/Kvrvnbz+H4TO6FJsRZmA68emdUV7v483w8n2BOZ92IDDrlPvfZDyryLrsi4Pol8=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr77273otn.345.1624310839275;
 Mon, 21 Jun 2021 14:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210620151204.19260-1-andrzej@ahunt.org> <20210620151204.19260-11-andrzej@ahunt.org>
In-Reply-To: <20210620151204.19260-11-andrzej@ahunt.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Jun 2021 14:27:07 -0700
Message-ID: <CABPp-BHkgJKUMHBGLQ_1z8w09wY28i55h37YKchJo46nqw=LXQ@mail.gmail.com>
Subject: Re: [PATCH 10/12] builtin/merge: free found_ref when done
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 20, 2021 at 8:15 AM <andrzej@ahunt.org> wrote:
>
> From: Andrzej Hunt <ajrhunt@google.com>
>
> merge_name() calls dwim_ref(), which allocates a new string into
> found_ref. Therefore add a free() to avoid leaking found_ref.
>
> LSAN output from t0021:
>
> Direct leak of 16 byte(s) in 1 object(s) allocated from:
>     #0 0x486804 in strdup ../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
>     #1 0xa8beb8 in xstrdup wrapper.c:29:14
>     #2 0x954054 in expand_ref refs.c:671:12
>     #3 0x953cb6 in repo_dwim_ref refs.c:644:22
>     #4 0x5d3759 in dwim_ref refs.h:162:9
>     #5 0x5d3759 in merge_name builtin/merge.c:517:6
>     #6 0x5d3759 in collect_parents builtin/merge.c:1214:5
>     #7 0x5cf60d in cmd_merge builtin/merge.c:1458:16
>     #8 0x4ce83e in run_builtin git.c:475:11
>     #9 0x4ccafe in handle_builtin git.c:729:3
>     #10 0x4cb01c in run_argv git.c:818:4
>     #11 0x4cb01c in cmd_main git.c:949:19
>     #12 0x6bdbfd in main common-main.c:52:11
>     #13 0x7f0430502349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>
> SUMMARY: AddressSanitizer: 16 byte(s) leaked in 1 allocation(s).
>
> Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
> ---
>  builtin/merge.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index a8a843b1f5..7ad85c044a 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -503,7 +503,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
>         struct strbuf bname = STRBUF_INIT;
>         struct merge_remote_desc *desc;
>         const char *ptr;
> -       char *found_ref;
> +       char *found_ref = NULL;
>         int len, early;
>
>         strbuf_branchname(&bname, remote, 0);
> @@ -586,6 +586,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
>         strbuf_addf(msg, "%s\t\tcommit '%s'\n",
>                 oid_to_hex(&remote_head->object.oid), remote);
>  cleanup:
> +       free(found_ref);
>         strbuf_release(&buf);
>         strbuf_release(&bname);
>  }
> --
> 2.26.2

Makes sense, and a quick grep through the code doesn't suggest any
other obvious leaks from using dwim_ref().
