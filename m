Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA3AC7EE2E
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 21:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbjFLViF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 17:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjFLViD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 17:38:03 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D6198
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 14:38:02 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-54290091339so2205644a12.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 14:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686605881; x=1689197881;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BdSmKtW2A6Q0Q4ukYOWaLCCtPvhtfBIbSmGR/9lHMT0=;
        b=1N0aCRbjKUdWBnfW4v6k7NZE779FRzm61Ov9T/qNPz6brkfHyuuDb7za5JkoVv9kjO
         LuJiPk22uuRgo0nCL0YVdYTRRZaIJJDybIgFWgulX+WRaY7Ll2nqBwbJ1E2NbiCXkHkk
         M3RJGcker7pYooMOa6gOt6OtAqcE0D7jPAjJNHC5E8JO2wbP48+hdjWObuhFosLYgPqE
         8f7wcTmq/g8fn5hYGGJgOzLPmsHb/soRequhOCnG7PF6rwdiap1sAWTQepjB09B56jIf
         k/7iPfxZUUUiXZS5OlCx6mufxyCAaoYXsdROzQaWPF1RnRWdgRhZ0tTGKzjlvV023DGH
         n5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686605881; x=1689197881;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdSmKtW2A6Q0Q4ukYOWaLCCtPvhtfBIbSmGR/9lHMT0=;
        b=V1kJqjhs5UaoN8W0I3CD/5/SalgJvqIb0XLVHV8F/Sf1tvIWpS37E00jum2CQLYHts
         MK3sa6Ohqf32L1LDj64A7xT3AGllu6gtqJUdw83vxluvn+yWZKbJvVeZHsRks8umhqhJ
         Ii1Iqu8Bc4WehB0aFrw0l+6MSCSXLfmNvTMZ1MQHc09GPaEnxEHVE4XkgBTxH2lEKq1y
         gNgYK/cPX6lWc7oRh8MUvsM2v/OKpjEJMOqikh8bYnuHgEkQLiqzkti6z2xBWcUse9Xs
         f6sMA8rLgzXmj/UopnDH1gresEGOqZtjePNKBvyhmmWHIcesULVoPzOqabZ1EtXQucfO
         sgGw==
X-Gm-Message-State: AC+VfDxEYAus2NoPAMR573qgzyQUTANGWQDVmlmsmHfAVqO/3raIlM0s
        HGIotkiPyQyChWBOf5YwVg4oxKQvKnXslg==
X-Google-Smtp-Source: ACHHUZ5aUls6ogcO9v5xqmYclSjQvcBs5h3PtMIJsNV6IMHN5zNGzbrmYQLNE6Hyd5E5m7PaZ3yKiT9kjiq6Fg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:7295:b0:1b3:a433:67ef with SMTP
 id d21-20020a170902729500b001b3a43367efmr1247111pll.11.1686605881613; Mon, 12
 Jun 2023 14:38:01 -0700 (PDT)
Date:   Mon, 12 Jun 2023 14:37:58 -0700
In-Reply-To: <xmqqedmveqs2.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
 <pull.1536.v2.git.1685064781.gitgitgadget@gmail.com> <506a2cf8c73549bc8f9761b56532ef08ed220da4.1685064781.git.gitgitgadget@gmail.com>
 <kl6lr0qwno2q.fsf@chooglen-macbookpro.roam.corp.google.com> <xmqqedmveqs2.fsf@gitster.g>
Message-ID: <kl6lo7lkfjk9.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 3/3] repository: move 'repository_format_worktree_config'
 to repo scope
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        derrickstolee@github.com, Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> That's quite a departure from the established practice, isn't it?
> Due to recent and not so recent header shuffling (moving everything
> out of cache.h, dropping "extern", etc.), "git blame" is a bit hard
> to follow, but ever since 16ac8b8d (setup: introduce the
> discover_git_directory() function, 2017-03-13) added the function,
> we do execute the "setup" when we know we are in a repository.
>
> It would probably be worth mentioning that the "global state" Dscho
> refers to in that commit is primarily about the current directory of
> the Git process.  During the discovery, we used to go up one level
> at a time and tried to see if the current directory is either the
> top of the working tree (i.e.  has ".git/" that is a git repository)
> or the top of a GIT_DIR-looking directory.  That was changed in
> ce9b8aab (setup_git_directory_1(): avoid changing global state,
> 2017-03-13) in the same series and discusses what "global state" the
> series addresses.
>
> If a relatively recent and oddball caller calls the function when it
> does not want any of the setup donw after finding out that we could
> use the directory as a repository, a new early "pure discovery" part
> should be split out of the function, and both the function itself
> and the oddball caller should be taught to call that pure-discovery
> helper, I think.

Hm, isn't discover_git_directory() that pure-discovery helper? In the
ce9b8aab, Dscho created stateless machinery (setup_git_directory_1()),
and in 16ac8b8d, he used that stateless machinery to create a
pure-discovery helper (discover_git_directory()).

It's true that the global state is primarily the cwd, but the spirit of
the change is the same - setup_git_directory_1() should have no global
side effects and neither should discover_git_diretory() (since it's
supposed to only do discovery).
