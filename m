Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3EB01F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 22:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932562AbeGFWnO (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 18:43:14 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52450 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932439AbeGFWnO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 18:43:14 -0400
Received: by mail-wm0-f66.google.com with SMTP id w16-v6so16043372wmc.2
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 15:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=r37KGSHMFfJ6efwWh3CqDYT0jlssqlFWlWR/tUdvMQo=;
        b=AVy7GS8XhkiEC9wfd/JwR2OyYJi3txgaIW8rLsUuObBKHA3ohElcPRcCRpA0LCHyMA
         BUdydAo8FnLIMxLatRkHAbxFb/CbA1mjtBKVuXi+kjIo9h9yeRggmfZvqOwkUrf6df9F
         rs7wQXE8G1jZe5/Q/6g3kKuUOjwA4IrAmKlsqLeDN8FmcCm+qrGlgWmr0g4o53l8hAV+
         ACmad9JXCpCASMD4Ap3lCnVXjWBjG6BFPzwzlqrAmuh/KOltNz4fhfI6SESPmDbEV50G
         u+XZmLfHbrWqEjIZj0c3qwg32G7wUUFgUv27JfonL34yfmpxutOtHJNe5mR1g6cT+7za
         GN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=r37KGSHMFfJ6efwWh3CqDYT0jlssqlFWlWR/tUdvMQo=;
        b=KQ6Oxc72ekwINSmIeb3AVnrxgzZa1VP7kDvvCrO9JJqgNtKiApplF/1J9+LJ+rS8bq
         vN6V9mVxebtX4LL9MWbmFFyXoO/olkIGqoO63BDsjoGaBwlgzSGdluYgm5AhDG96G+Yt
         ud+sJRmXYRZ/29qiVO6Xujc2Jj0EWE1euyqzhiqexe/Ax2lUyaiiJ7fy/gDTtCkfdBA8
         VxrqAwDIQUOOmsyveH1GGBKRsz+wg6xpQb8llEFq2NJX6LjWmR8SafIq6RqEgvJ6La+l
         X+UCNv4WXIJrsTVs7KH0nKygnodMJEo8FuO5hY9sLg1vz4JJs5xN85jdjj00EfM2S2Zy
         Vx6A==
X-Gm-Message-State: APt69E19nesDLsBta+qm5ls4cbgThfFju91UE3MA7X0B6v3QuRok39bq
        s2JnQo437KzSRJTsTf2Hh+k=
X-Google-Smtp-Source: AAOMgpd17CQcSUi7Mo2nAdHyhNA/2CLaRfvFWMtCdGRaCsikaqWPF0mlzD8JbpONc77tyozd71rW2w==
X-Received: by 2002:a1c:9bd0:: with SMTP id d199-v6mr7392884wme.16.1530916992820;
        Fri, 06 Jul 2018 15:43:12 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u6-v6sm8550767wmu.5.2018.07.06.15.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 15:43:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 01/20] linear-assignment: a function to solve least-cost assignment problems
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
        <39272eefcfe66de3ca1aa2ee43d6626ce558caae.1530617166.git.gitgitgadget@gmail.com>
Date:   Fri, 06 Jul 2018 15:43:11 -0700
In-Reply-To: <39272eefcfe66de3ca1aa2ee43d6626ce558caae.1530617166.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 30 Apr 2018
        23:54:13 +0200")
Message-ID: <xmqqtvpcgf40.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The problem solved by the code introduced in this commit goes like this:
> given two sets of items, and a cost matrix which says how much it
> "costs" to assign any given item of the first set to any given item of
> the second, assign all items (except when the sets have different size)
> in the cheapest way.
>
> We use the Jonker-Volgenant algorithm to solve the assignment problem to
> answer questions such as: given two different versions of a topic branch
> (or iterations of a patch series), what is the best pairing of
> commits/patches between the different versions?
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Does the "gitgitgadget" thing lie on the Date: e-mail header?

Postdating the patch with in-body header is fine, but mailbox tools
often use and trust the Date: timestamp when sorting and finding
messages etc. so sending a new patch to add linear-assignment.c that
is different from what was added 9 weeks ago with "Date: Mon, 30 Apr
2018" header can easily cause me to miss that message when I look
for things that happened within the past few weeks, for example.

