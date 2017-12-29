Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54E331F428
	for <e@80x24.org>; Fri, 29 Dec 2017 10:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755342AbdL2KFx (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 05:05:53 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:46478 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbdL2KFv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 05:05:51 -0500
Received: by mail-qk0-f182.google.com with SMTP id b132so22357473qkc.13
        for <git@vger.kernel.org>; Fri, 29 Dec 2017 02:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9TWFUUbukU/L9O+obbECdKgyrpF4Epnzi2z5tWbuT9c=;
        b=LlBrXQMdICCiqAKh7dTpE7/kftg3+XQdP1S6DffWN5vcTJd2Xp8wpsIrm4jR9mMEts
         oByABGgNB6if9N++wOdB5sHDlZkaUxqeibWon4xg+6Xw1JznfuOC+Hay89eb7DExw95f
         Rb/c9TgCtzdEQEyoskp0XN1INr2vKCIUZI3K+jxRasaWfvRcVUaSASXFWvcx3mjZF8C7
         Acdtz+avJWSCVvsLumGg5Cs60FjQ9Y9+APjKyHzqe6yUd41ZV8xQFDmuE+JC93ubnggK
         EbRxLYfkZ2A1DQgLJzKm6iE69ZLG2zqQHqN1GAj3fV4LTGwaFxNckrzdUV2AgxdjZNaL
         z/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9TWFUUbukU/L9O+obbECdKgyrpF4Epnzi2z5tWbuT9c=;
        b=bPnYNK3XK3y1FsctAFGWeeeENpQtdGGEhrKgqc4X7k+HYBTc1mkvBTQ5fRjYEWdp1h
         AelskWzaqz0V9yNlvQpo34bjDlqpysuI4kWv2YbXynwg4Keu7l/PJEfIxVEC6p0MOK15
         c6E/jYl+9Aw8c2O6pCbFo2LT7NECjkY5t213Zk3Gi82oRdhl1040WlHZ8Nz03/yhozM5
         SUswOfkabQPRhVyb6T5UJyzvXc5qjDe4Jiim+YYFXXIENax+KrlUxvwn7emMo8u/Iquj
         K9rFZd6bBNeoUX4nxZbFnZC6rWJsShM7iA90QyGjlqLbUW4Ol4Nj+6MNUVCE33EtrPrA
         AK4w==
X-Gm-Message-State: AKGB3mLmwgKylM+0qui8G+6jf6B6bkeOTt3MUS3sg5zQv5M+TPylcNc0
        bp4cVPIG+0u7p5MVsTortvnyAK7RXcjUW0aS4G6G6Fca
X-Google-Smtp-Source: ACJfBospobHHEyljy8kbcvqZrfKb88Z+01zb01N8re+RfzYLr+sb7M0//16mu5yhDqopLZOGezMNVr9zVKVn0GYxciQ=
X-Received: by 10.55.38.81 with SMTP id y78mr28347778qkg.132.1514541950996;
 Fri, 29 Dec 2017 02:05:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.16.154 with HTTP; Fri, 29 Dec 2017 02:05:50 -0800 (PST)
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Fri, 29 Dec 2017 13:05:50 +0300
Message-ID: <CAL21BmnycG4=Wm_e1S85QVPfs3vV_Q=TAjTAG-sv+f2mK6wbBQ@mail.gmail.com>
Subject: Rewrite cat-file.c : need help to find a bug
To:     git <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,
I am trying to reuse formatting logic from ref-filter in cat-file
command. Now cat-file uses its own formatting code.
I am trying to achieve that step-by-step, now I want to invoke
populate_value function, and I have a bug somewhere.
My code is here.
https://github.com/telezhnaya/git/commits/catfile
All commits that starts from "cat-file: " are successfully passing all tests.
So for now my last commit fails, and I am tired of searching for the
error. Actually, I just copied some values to another variable and
move some code to other place. All "intelligent" work will go further,
but now I need to fix current situation.

You could write here or leave comments in github if you have any ideas.

Thank you in advance for your help!
Olga
