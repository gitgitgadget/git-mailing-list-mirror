Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40EEC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 20:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B084A60E97
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 20:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350496AbhIHUqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 16:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhIHUqo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 16:46:44 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683ADC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 13:45:36 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id z2so3893003iln.0
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 13:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=uPcqrfcE0lmyw36I+oFxFjG9wYlB4y2vXmsRNBMxuB8=;
        b=pcqOwypukjQ+oEdl6e2VNgGuhKHQqaicy5zVUqm3JMTzVs+e5NHErFr6PUm/7iSFA+
         x8TzbRJDoh2puJ/iqIG1ABRdZsVHkPs7ZIJZAq4yZwH+M8aVK98gKH8dr5yaam0lXiKc
         lSVoYAOGjxcP2AlV8kyCQx7VaXx6ztARXUCta43BNFXYbtZYzd4JZuAFfEkRcvxt9oMA
         xIqP/7zdi571C1pwcQjvfn24BRBsNvEFMkcuCFxGSmyHImq3xeIP0lCBsq3RCI5AvgBE
         hJeF2YaOKlR4ALTqsjkjDevMRnsOEYEzezOTrjx5nAFIFWVD0eWTEitwlshPSuoYuQzz
         DSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uPcqrfcE0lmyw36I+oFxFjG9wYlB4y2vXmsRNBMxuB8=;
        b=V2cMVPHtZpw41MZvN5XWh0XB/fov3SKypGXNgxSjQM5clMxvtgN08wMBXJqOTqaKn4
         9W+j4fatneg37InSoWoeaI3/Sdbt8bQ0snfNHdErRfynjjYjxPyJIcn39C49Zn3qTGVN
         PTl/UvYbtsHZULtANRas7ON10xtQGTXVwdAVx2Q0dZDponExCbcPVo8zQ6MPtRnxqZap
         SUgPqpUAUs+O26PfhvcU0JLfZM0T8uxRIcMBCks4paP/T0U6+qGdWWwUsUOgILwFdEqe
         MUWg56+GBKdGt8RGM/SPxHEjMxzC+kfhuKs2/E+Dk/GzVk0whcczU69BfvDUN0dicy69
         MO+g==
X-Gm-Message-State: AOAM531jaYS+oYKycPS/8TrUmt2Ti5Qc5WTDyPzmkxDnoYo9c/4xHfF9
        7/6EP+5yrh5/B89CYIV/rDi4gJTUKO3Rzqtoi3yOi8tEwWs=
X-Google-Smtp-Source: ABdhPJy2zbKCkBTfdHcWDdDVwsEs/sehjUoHyBk/wVplZr/SEUuruDcshDvagUz82wbuzS8g09gG6i3buITuDf6ZVFU=
X-Received: by 2002:a05:6e02:1c86:: with SMTP id w6mr145096ill.52.1631133935681;
 Wed, 08 Sep 2021 13:45:35 -0700 (PDT)
MIME-Version: 1.0
From:   Aleksey Midenkov <midenok@gmail.com>
Date:   Wed, 8 Sep 2021 23:40:20 +0300
Message-ID: <CAF8BazDKG03bpBEQyC9EsM8WxV_7WnQ386T=VT49EHNzsZ3PPw@mail.gmail.com>
Subject: git diff: print hunk numbers?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is that possible/how to print hunk numbers with git diff?

F.ex. instead of:

@@ -106,7 +110,6 @@ while ($r < $statement_count)
...

To print something like:

@@ -106,7 +110,6 @@ 4 @@ while ($r < $statement_count)
...

filterdiff uses hunk numbers intensively. Work with line-number ranges
is not so effective.
