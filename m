Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCFCC47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 20:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46AA56108C
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 20:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhFGUMf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 16:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbhFGUMe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 16:12:34 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723DFC061574
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 13:10:34 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so18001294otp.4
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 13:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=agSnc2AfetgdistO8FMRpq8N0pUg/ue11t7ugujI23A=;
        b=CWN8NKBbfEdjD2qxIYoqr0strzZTNY24p88Db+9BZuJQtgP3LjrnwzHP/B4xWI+mDF
         HC2Yc93X8UkzimK+gStqq+0IrJKBHRJvFdkV13dN9wEyM3DMDz2ka5ZaA8FLR7SpZQ4D
         /mOI6xji5XuhHzX/12/Lhv813bfDEhUkMWD39P9n+/j4rJYJkBrsyqtXQ3MzCkDLx64M
         EvqUTJGY7mhMQbwVqsNMCqp3GoS8sT0l63SL4Oqt4uzICTkF8XJpAsgZpkDj9zl+PKmB
         E7QpWpC+L6FJlFvOFJ4beH+wSZZ6AbPHAksL8OZNp5eQoKmLUM5YNqdDynuQdI06rWNL
         ObYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=agSnc2AfetgdistO8FMRpq8N0pUg/ue11t7ugujI23A=;
        b=EeSngrUW65X7ORDch5Vv45uLfqr+9lsrO4kzlqJ2tI3hBeK33xIciTXpjbl3ikviaa
         d8cuCKour+Pzp7k7WR+Zrdfo81Hybx6BqQtqolRWSoif+TbwjUIkrI9MREngv99Fi/BJ
         NcZH68pnM0rdeM3Qo+JzyN1wphVsMTnF8wt+WuWRkwEZRBhHqSKpsJeWTS0v/SjvUMQ+
         z7iJnMH9u6O0LFc3dES1D586B/0vpO9c8HKd9tAzWDULyfDOvcO5f6NaQ7w4GOAnok/d
         2ayWLqjsSc2/c50m3RLNUgzh/vdskZS2JoBi8NyoUbkPXfRoF6uQ3OswLE1BvZYlcFjd
         OmZA==
X-Gm-Message-State: AOAM533DfAzXQo6uPMR3P6609BfD+BMmF19LdHiySn/IL2vSXvVDXVco
        9y8n8qzVzCNt6eKzgPHLIww=
X-Google-Smtp-Source: ABdhPJwWGC7vn9jh4PczcFjln2+eCXALBWegYype+OZBN1zfgmZF8vpqnHgVSDqU5Ir5/0UPG82OCQ==
X-Received: by 2002:a9d:784:: with SMTP id 4mr1853877oto.268.1623096633342;
        Mon, 07 Jun 2021 13:10:33 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id q4sm2377897ooo.33.2021.06.07.13.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 13:10:32 -0700 (PDT)
Date:   Mon, 07 Jun 2021 15:10:31 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        Derrick Stolee <derrickstolee@github.com>
Message-ID: <60be7d3750995_db80d208d@natae.notmuch>
In-Reply-To: <pull.975.git.1623085069.gitgitgadget@gmail.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
Subject: RE: [PATCH 0/4] Use singular "they" when appropriate
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> In another topic, I claimed [1] that singular "they" was better than
> "he/she" for gender neutrality.
> 
> [1]
> https://lore.kernel.org/git/44d937a0-e876-e185-f409-a4fd61eae580@gmail.com/

And in that same thread I argued otherwise:

https://lore.kernel.org/git/60aaa09aebce4_454920811@natae.notmuch/

> The fact that singular "they" is less awkward to write and read seemed
> obvious to me, so I did not back up my statement with any references or
> reasons. The ensuing discussion did include reasons, especially brian m.
> carlson's thoughtful message [2].
> 
> [2] https://lore.kernel.org/git/YKrk4dEjEm6+48ji@camp.crustytoothpaste.net/

To which I also argued against:

https://lore.kernel.org/git/60aafecba4279_8eb820875@natae.notmuch/

> This patch series officially adopts singular "they" as a contributor
> guideline; see Patch 4 for the change to the guidelines and the reasoning
> for the change. Before modifying the guidelines, documentation and comments
> are updated to not use gendered pronouns, which provides examples of how to
> use it.

You use a descriptivist argument (language evolves naturally), to claim
that singular "they" is already used, but then use that to *prescriptive*
rules, which is the opposite. You are contradicting yourself.

Either we follow descriptivists and let the writers decide what's
appropriate, or we follow prescriptivists and establish rules
prescriptivist linguists agree on. Prescriptivists are on the side that
singular "they" should not be used (because of Latin adherence).

You can't have both.

> I would appreciate ACKs in support on patch 4.

A firm NAK from me.

-- 
Felipe Contreras
