Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C72DC433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 20:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5030C613BC
	for <git@archiver.kernel.org>; Tue,  4 May 2021 20:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbhEDUcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 16:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhEDUcm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 16:32:42 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6591BC061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 13:31:47 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id l6so108843oii.1
        for <git@vger.kernel.org>; Tue, 04 May 2021 13:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=PUBEWH3ghheRky6kZ2Z8YfKPsYpstnrwZ8NoNB1pa8E=;
        b=DqgSrAf2VfMS5j/0wzRxSPfom84lBZgA7F4T4GFRSjVlfUzS9lS7IcbYQr6JhhsbF3
         pb8T0Epb41hDe+K8GZYse1CMSK1j3BHkca/yLitWdWmAuXv7WTQb0kBU+QZDdEakGhcf
         VJ/TRqwdMUD/n8wh2qsiFR+0qGIsU+rMw+3QjRBIjSKDsNkhyTBu8Ppa87qRBpb5V4fi
         41DuoSR75ef+13fjWw1+9eMYUPAlbsvFDrw6zcwiLzeHU7VieuqlYuD1EGs+2WEIbsfr
         TkbU0M5tF3jq8R33LTPBcOAlb8tw2YNBJ3Ax+bgzHwzVXbnyo7WY4mOJIFf5pTjFJD+e
         wH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=PUBEWH3ghheRky6kZ2Z8YfKPsYpstnrwZ8NoNB1pa8E=;
        b=I+X6XhxB21iGfoDdEU6gT5cKI2B9kMKJ3wSERUsONGcWxfXsu024qyQ9FmvdBaym4v
         aF3GWYwf9AxSoRddW6hX6snG4c677ARrhT1kVnUdVnBI0YTmjQa2KUuzOI3FKlXQuhOr
         DsBIw5neW8GOuFJla3IJOerEJgzO+N133kuuPznIb3SyTupHbI2mU+v/5PSVn3cuVXL4
         hqmHyHprZvHDiWsgZL+282YX7cUi5fJL0406A3sAaTH5InQstAFGQXbY16p39zdUHSs+
         fpBRnJGYXX6wOdLmhasnPy7nYqB2zD+/2xQ7mI9Yqe/Y/dLVmQGpOzK52pgmhQYjaFsv
         ubjA==
X-Gm-Message-State: AOAM532HF3Ol4whuqXQTJOQjvn6qmSkfYovd6iQozlF8R93ANIYeFQ2N
        pliKsfoDHm8rgyOdmgJ1cSU=
X-Google-Smtp-Source: ABdhPJyy+bBcmCJriyULsE9t4cSxE15gMpnwBOMK3PD1H3f0IDgIO5PNdfc0XjMn8ATc6FpBfIkHpw==
X-Received: by 2002:a05:6808:315:: with SMTP id i21mr4341122oie.119.1620160306764;
        Tue, 04 May 2021 13:31:46 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id k7sm928829ood.36.2021.05.04.13.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 13:31:45 -0700 (PDT)
Date:   Tue, 04 May 2021 15:31:40 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Cristiana Man <man.cristiana1@gmail.com>, git@vger.kernel.org
Message-ID: <6091af2cc6dd_b34a820889@natae.notmuch>
In-Reply-To: <CAL2wJUAk50O-iSH9PEewYHwE9tV-TZZerqd1Eh9OTQfWBkmCgA@mail.gmail.com>
References: <CAL2wJUAk50O-iSH9PEewYHwE9tV-TZZerqd1Eh9OTQfWBkmCgA@mail.gmail.com>
Subject: RE: Git commit allow empty docs unclear
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cristiana Man wrote:
> The documentation for Git commit --allow-empty option
> (https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---allow-empty)
> contains the acronym SCM which is confusing to me.
> Do you mean Software Configuration Management, Source Control
> Management or Source Code Management?

The documentation is on git-SCM.com, also, there's a glossary [1]:

  SCM: Source code management (tool).

Cheers.

[1] https://git-scm.com/docs/gitglossary

-- 
Felipe Contreras
