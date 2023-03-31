Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26979C761A6
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 17:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCaRHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 13:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCaRHB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 13:07:01 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11B6EB54
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 10:06:59 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so24031590pjz.1
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 10:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680282419;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lqmc7eU0VRf0CFKTAdEgU358gpz4vG8DdvapifnLjL0=;
        b=F01M7NgElP0Uihfw8Bt4DDWZ5r3mre55+q70HtZ0WPpBYE6IDhCyQ2GCHA3fmxiDRa
         Ee5OMPvnwqPdcSePEdlb/IYSX4VCCA1MhB+N0yf8UbUoz7zXp35nq6BrH9dg4m2B+AzT
         chNEpOHZOahDm4BmTAhlkEIfZHdQam9GDV/DF7tJXSh2nbA4mqNGpi5aqh7w0cPDUK75
         Vl+5usMpIT5+H4t/usBzsye0tmCvSNfLY1fMKLoRZ/CDSd4ovBXKqmdtXKyp20aYezDk
         ZL/quLu6BeHXt9ekAG/VvxJHzJyTdShvBxVVQVpzQkAvXOGGxNpVWzM+keyWezgseSDL
         FhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680282419;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lqmc7eU0VRf0CFKTAdEgU358gpz4vG8DdvapifnLjL0=;
        b=gv/vrwyfmlKjXNrQcuz2Fk8CnJxzjQJzgeKf7V2nQGlIjc9u9jhzgqqN4tzQEc70Jb
         BKR5ac4X564ka+OtWstUAbU55aGnHU6ivVZTk2djVdExz/g6YwLNY68FR4X1ABg3/Q2g
         Aq8lxT+no/kuYCAFyzTUZHPVuRvVZGfShseXS4HGndBcvJn+uX2jdL4bcs+WdoY1MVex
         Enmvyo9OsyPr2cd7vEIux3VMzbITT5kUy9jv08K4OBbTxSr11eTmGwEQY+fMa9i0TxEY
         xkv7EfRyhi6BRCyMi0A/YzL86xej9KSIUYFrFWusOnJYgnoSMXC92rt4bliUmaqBWett
         nXmg==
X-Gm-Message-State: AO0yUKUr2F07hkawzYghBr6my/OhN8zpZ+AFD7axQT+60cFABNgY0uaW
        Q559Kb8e3SR9K/2L4E4dnVY=
X-Google-Smtp-Source: AK7set+lh9/McmhmPywPtygg/REgM1h2vV2YmnSKaeawTAo0x5w3JndbZwXwn4P1b4+7Gzc9s2iOVw==
X-Received: by 2002:a05:6a20:24a7:b0:bf:4563:e647 with SMTP id m39-20020a056a2024a700b000bf4563e647mr23976873pzd.40.1680282418970;
        Fri, 31 Mar 2023 10:06:58 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id r13-20020a63440d000000b0050336b0b08csm1782345pga.19.2023.03.31.10.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:06:58 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] fetch: download bundles once, even with --all
References: <pull.1508.git.1680278344173.gitgitgadget@gmail.com>
Date:   Fri, 31 Mar 2023 10:06:57 -0700
In-Reply-To: <pull.1508.git.1680278344173.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Fri, 31 Mar 2023 15:59:04
        +0000")
Message-ID: <xmqqo7o8g89a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> When fetch.bundleURI is set, 'git fetch' downloads bundles from the
> given bundle URI before fetching from the specified remote. However,
> when using non-file remotes, 'git fetch --all' will launch 'git fetch'
> subprocesses which then read fetch.bundleURI and fetch the bundle list
> again. We do not expect the bundle list to have new information during
> these multiple runs, so avoid these extra calls by un-setting
> fetch.bundleURI in the subprocess arguments.

It is a good observation, if we assume that all these remotes want
to share the same expectation on what the list of bundles described
in bundleURI should be.

I expected that people use multiple remotes and do a "fetch --all"
before starting work from a cronjob or while fetching coffee first
time in the morning to fetch from repositories holding work from
different folks and manged by different groups, and these groups do
not tightly share the object management recipes at what bundles to
pre-package and list in the list served at a bundleURI.  If there is
such an arrangement between repositires to share the object
management, even if the repositories fetched with the "--all" option
are truly multiple places, it may make sense to assume that these
repositories you are fetching from want you to use the same set of
bundles that are managed the same way to be used.  But I am not sure
if that assumption holds true.

Where does fetch.bundleURI come originally?  If we set only one
globally for the local repository at "git clone" time, perhaps that
is a problem?  IOW, instead of fetch.bundleURI, we would want to
have something per remote, e.g. remote.<name>.bundleURI, instead?

Putting that design level tangent aside, everything I see in this
patch makes sense, assuming that the fetch_bundle_uri() call done
fairly early in the parent process is sufficient to tell the child
processes that deal with individual repositories to reuse the info
that was already retrieved that call.

Thanks.

