Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4D8C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 23:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C2F960EAF
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 23:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhH0Xpr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 19:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbhH0Xpq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 19:45:46 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14A3C0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 16:44:56 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id c12so14259113ljr.5
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 16:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qzDzRWimi/58yvXUr/WA98EieANPASkxEZbROdKCTJQ=;
        b=Mrz0dPcEZ5+C46w7jFd4SKSCAG/lUO5lt+g2WICVHqpd/ZWAMiY7t+6wUaoF5tJc4C
         kmUnfU9VnXVtVIsXT0f/eEQOr6Vzcemhix9ohkOhSTxInEThPby9zCsvAvS3XyyjjgkJ
         Y64X42CvSBmHUj1KbAEoNb4qxMunnnb3K9UQbpTflWhk4+xzuTNYDXUKR6J4L3rd2lhx
         RiLSBCZaZlkN875PtY+WuGMobIigrXE7GLt+cf69vyqnVyqmSZB2Hqw1Acy9uzz6y6ai
         C1jExfs29af64BKSu1npLElXVGXgrPoDm0qPGOm+L+OkaaJr7zMWn3CfhsSVXJL6wKeD
         cjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qzDzRWimi/58yvXUr/WA98EieANPASkxEZbROdKCTJQ=;
        b=FgCXKgdi0T1OWJav94/IQuj0N3RC1w3TobE7yt+82tuaBVVEzM+AK+RuPCxmoQQwir
         mz3PgtWTErN3Iw4h0E1CrYg94bMwKAEnFXFI9FuOYOwAE2+i36YAFLPObkobZX2D2zJD
         64OEnaen4HnNZ+7E/JYfzBJcDLjZGRh/veUUrP3OsfGQlIwEEwg5AWYG7s8hStcyt3SC
         UQ6MPujxiNC02AI6Yj/IbH/8f7ck5eD+YG1nf6Ll5yXt+NBMwZOafnKxKDy+sZHSD0rJ
         ggSft0GZ5pmtR3Q6gXmmvYkElQ86SLwZlOsaBpxV6n/yypbpqQTRjtFR/Rdfy64NaJOg
         oVnQ==
X-Gm-Message-State: AOAM5319P+ZF4i98r+1B3pnIqnv64zPtpDFKx9YsQvBrY7KhmM6pUptX
        TEHKNRgLnLAyYlI5c++bNbDorsJdRN0EGAb0H35a/Q==
X-Google-Smtp-Source: ABdhPJxGEFa7Q1FqLiK+8i8Gyy1UQxZLkk1ThWt2TjJR8wm5Kz6ZS+eaGMCfTNqueFd5IoEhlVMkwnx7sbSAfbZWKTM=
X-Received: by 2002:a2e:a591:: with SMTP id m17mr9585213ljp.113.1630107895133;
 Fri, 27 Aug 2021 16:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
 <d31c641180645ee4059aab9230841ad90f9244fe.1629842085.git.gitgitgadget@gmail.com>
 <CAHd-oW5-f2Kb5DR-UTfu1qB1fm63oHf62WYsbGd5ajZueOWHtA@mail.gmail.com>
In-Reply-To: <CAHd-oW5-f2Kb5DR-UTfu1qB1fm63oHf62WYsbGd5ajZueOWHtA@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 27 Aug 2021 20:44:44 -0300
Message-ID: <CAHd-oW55fWkjf5494OJPsJGtRh59SDJFbfhw=nt2q=To1DQJqA@mail.gmail.com>
Subject: Re: [PATCH 11/13] mv: refuse to move sparse paths
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 27, 2021 at 6:20 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Tue, Aug 24, 2021 at 6:54 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > diff --git a/builtin/mv.c b/builtin/mv.c
> > index c2f96c8e895..b58fd4ce5ba 100644
> > --- a/builtin/mv.c
> > +++ b/builtin/mv.c
> > @@ -176,10 +177,22 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
> >                 const char *src = source[i], *dst = destination[i];
> >                 int length, src_is_dir;
> >                 const char *bad = NULL;
> > +               int skip_sparse = 0;
> >
> >                 if (show_only)
> >                         printf(_("Checking rename of '%s' to '%s'\n"), src, dst);
> >
> > +               if (!path_in_sparse_checkout(src, &the_index)) {
>
> `git mv` can only move/rename tracked paths, but since we check
> whether `src` is sparse before checking if it is in the index, the
> user will get the sparse error message instead. This is OK, but the
> advice might be misleading, as it says they can use `--sparse` if they
> really want to move the file, but repeating the command with
> `--sparse` will now fail for another reason. I wonder if we should
> check whether `src` is tracked before checking if it is sparse, or if
> that is not really an issue we should bother with.

Another problem is that the displayed message will say that the
pathspecs "match index entries outside sparse checkout" even when the
path given to mv doesn't really exist:

git sparse-checkout set some/dir/
git mv nonexistent-file foo

The following pathspecs didn't match any eligible path, but they do match index
entries outside the current sparse checkout:
nonexistent-file
hint: Disable or modify the sparsity rules if you intend to update such entries.
hint: Disable this message with "git config advice.updateSparsePath false"
