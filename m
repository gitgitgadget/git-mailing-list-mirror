Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF5FC433E0
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 03:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 277D7206B5
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 03:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgHIDMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 23:12:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33058 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgHIDMP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 23:12:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id f18so11197132wmc.0
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 20:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wkYuzPs+L7s/yxzYfv8S8ThOnSGcJQwksdB295BaV6c=;
        b=kT6GDlAosQToXCogR9NiwXmkVJMbr98Vl5/IViQRXgzh97ZQaLQ1KbIpb47MoPOO3W
         1SlvXrmPFR7X2jp6C0Ru2fGURPJNz13H7R4NHdb0FNPDmzJcfy1g6PvpwMvhj+G4qyVv
         PzFctsD8pqCeWCkfuxZq2g3QLDAswqdXqBAAa1H91EGqL6bV5aCm28v/FKXT75YvF0ft
         /iYqCY4C7NH2UsvcV5T2iYs2mvN/j9rYjoBbiWftImeSgillwiJRAVvzn1VZyfetYyEx
         Xas2r+DhoIhch0c+kP+axYAO0IMKJBDOJDz7qPOUbcJinGR1n4F1BYldga0N75UrWrP7
         e9bw==
X-Gm-Message-State: AOAM530ITYRgkZuNDUm1rU0afbG0R6DyASoFOfG7hwhQ+Sncq7q955Gc
        8QIaeZs3MXbCiTLSbgtS0gW3uQP6e/iB9Kjzy/g=
X-Google-Smtp-Source: ABdhPJy8EHOeSiEvkAdrhw3qXK6g3ClrcynzJNuO5jxMGE1b+mutvpmJhIBnldC1psGJCbOkwjYJaaTqfQZUKJ4djaw=
X-Received: by 2002:a1c:39d4:: with SMTP id g203mr19801576wma.107.1596942733685;
 Sat, 08 Aug 2020 20:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.827.git.git.1596644952296.gitgitgadget@gmail.com>
 <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com> <9ce80f2f943278fcb8ef46fd1a9507d832657246.1596906081.git.gitgitgadget@gmail.com>
In-Reply-To: <9ce80f2f943278fcb8ef46fd1a9507d832657246.1596906081.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 8 Aug 2020 23:12:02 -0400
Message-ID: <CAPig+cTgYv+UJauyL_o5AeYeCS=aKi_PS4VZ0Q6yH7bZk+Vg=w@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] t6416, t6422: fix incorrect untracked file count
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 8, 2020 at 1:01 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Apparently I don't know how to count untracked files, and since the tests
> in question were marked as test_expect_failure, no one every noticed it
> until know.  Correct the count, as these tests clearly creates three
> untracked files ('out', 'err', and 'file_count').

s/every/ever/
s/know/now/
s/creates/create/

> (I believe this problem arose because earlier incarnations counted lines
> via a pipe to 'wc -l'.  Reviewers asked that it be replaced by writing
> the output to a file and using test_line_count, but when the temporary
> output was added to a separate file, the count of untracked files should
> have increased.)
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
