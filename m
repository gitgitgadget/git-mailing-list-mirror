Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B76C433DB
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 19:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D04E222242
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 19:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgLaTGm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 14:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgLaTGm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 14:06:42 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1332BC061573
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 11:06:02 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id d203so22660970oia.0
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 11:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hSsRD6lFplR9p8nptekC2RmV/P5x3HzonaeFAm8SDwg=;
        b=YVEi9rCneXScD9c+OrXf4Hr6s+xVUz5w+5d15qW5NgalUieMiIPwKY69TkV7YqRy5I
         Zbb7ISnMbchB88JxjRV1agsRVU+bjfdxfI4K6bofdw4drzADGFtyMCpC3MUm3zZ9GBcK
         ZM0G7AqW94OMlKb/RUCheZHnIA3XfWbLBsPB6wk89Q3a6glXLR19rqqU+y0p8xj4y8d7
         pyrMExTzFT+JchP4hJyp9wobdLMs+Tm0tguGO/k93foc65Jq91g3jrPqRx03mpvvYkwN
         2it8yh5bYPh4c6L1pFHoyEA1YiXeW24Hm2X1qboTJ0nofVQD3igMZV9GJfNRusxBlZE3
         tr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hSsRD6lFplR9p8nptekC2RmV/P5x3HzonaeFAm8SDwg=;
        b=JSEt0JHOPwC7rtJAxgRMpJFcQnWe8wUYImU7t5DMKbtTr9tKB1feLTkqHkNMz+dFzE
         cRhPH1Db4+GnjDa5lrGU1+c1PxILCV1mJ8TOqxFgDe5kPQZLCwZ06cbCm9bB8aQPIwyt
         jCsbfRH51OU2DOfySuH1UZvyC9WosOLiMcY15DWMsnbPbb6WqADtaYUUeVFcF7bdi54X
         Na6+oNsmAxg8OW7cPBmAO1RmBLbIIBnYUJ3h4x1ceaLcHY2W0SjvjXBiLlPKGUXZL8vL
         HWdORQZzDIJImPEdFz/KqsSZaeAB1RJLc2n2cLi3b5yTrU1tNlXgriKXna3r4G2zEtZt
         drew==
X-Gm-Message-State: AOAM532m4lWxB+PBoZIpITNJDYUOkQwBmHXOuuxgwEkwQP5iPSs+TfyM
        Y5cULw/zapFqEUkEfkt9L1Ws7P8c6p3dKn5jjEqDAjHSBDwk1Q==
X-Google-Smtp-Source: ABdhPJx7i8BjU0I9CevniHwrTB9orZ+3UignoZlb8yEOl4x0Y11uKmKxMbPQV3TAqJRaUkFw6+TtV31FXkXxLbbdJik=
X-Received: by 2002:aca:5253:: with SMTP id g80mr8756289oib.98.1609441561243;
 Thu, 31 Dec 2020 11:06:01 -0800 (PST)
MIME-Version: 1.0
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Fri, 1 Jan 2021 00:35:50 +0530
Message-ID: <CAPSFM5cCKubJ37wkTO0bK0MVLcq_G2TuRTcs8hJninW_MCq4mQ@mail.gmail.com>
Subject: [Outreachy] Project blog -3
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone!

This is the next blog post regarding my updates on the project.
https://charvi-077.github.io/week3-4-progress/

Please let me know if you have any feedback or suggestions.

Thanks and Regards,
Charvi
