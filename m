Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5B4E208E9
	for <e@80x24.org>; Mon, 30 Jul 2018 03:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbeG3F2M (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 01:28:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39973 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbeG3F2L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 01:28:11 -0400
Received: by mail-wm0-f68.google.com with SMTP id y9-v6so12027465wma.5
        for <git@vger.kernel.org>; Sun, 29 Jul 2018 20:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=B/xBX2EqvBrw+tj+jqeGP3VXTEziSmY2GTlbixO/fU4=;
        b=HoFAA7d37KU/JpvsOFw+Y2D+m3oqq8aznISDvUt1TaIBA16DcI8AahI2ce+OOQVhuQ
         v3G5x2yZ15l7ukjFbXeI8l1irQSpdWfCJyYNY94rouibUoXkO7m/SQCojyAt0VPAp04Y
         y83urvwQmrP7/kdR7t/aWEScauN6kTJ44RGhElV3+BRcUadI5vvF3AFN8wAnH/gvydqv
         S3eiNM0OWigNMfb5cc8JP+9fV3A8JSabuG6RrjtdCFU8N4KOBYNEsHbHtZSyyPPbyAVj
         32VvtymgencPBsdqL+iFW7gRh+hBoSmPkb4+tIoqWNwInHY7b8/MjNSSPU4WpVWH4nwe
         Vhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=B/xBX2EqvBrw+tj+jqeGP3VXTEziSmY2GTlbixO/fU4=;
        b=ljTzdAYJS9kBi0KrdEL4y1vXpVmlo0vM7HR5m/POD/SyNs7acWghGAsfsxsNnNlE4G
         t40S3Vto8CPxVxTHqDiHmY17CXC5Azd6Pik1KGe7ks/eWG1XaCXLkAWppUBashK9mE6W
         JZ4uh823bkGazFuUyHmec6N8XrjewDsik3E01Vu5NXzVEh7mwgCUxRSbRJEINZTOGVCj
         YArE4eiFQsYuPqaToyVytxJt9RGgodImaLwrqpab51a1pMTcWSvs/kQ2zt5fb1ubecim
         r7Or/Dd35K9oxctiRm39dvhYdqUP39E8JhW8pqTJdKmgKEV4mHPVwPz6CLjsFBZmGIZr
         7O0w==
X-Gm-Message-State: AOUpUlG6+zDJZsP2e+iSwH7SsIRaDcqxNFYldv5RNz+0vntHrHxPDeah
        rJJ8YcHGyjirQiK3GJi1R8mOEC46gY1WVQVDT2I=
X-Google-Smtp-Source: AAOMgpfy2j75JQcj7QwmY5IokR2iqBLQNuXcpw4MZauNh5qYDnWzwER4wJDEq7B1vH84vW1yi3YeCHimahI1cH+GJYk=
X-Received: by 2002:a1c:6fdd:: with SMTP id c90-v6mr13296793wmi.16.1532922912784;
 Sun, 29 Jul 2018 20:55:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:545d:0:0:0:0:0 with HTTP; Sun, 29 Jul 2018 20:55:12
 -0700 (PDT)
In-Reply-To: <c5b2a072-5058-0d3e-8fb0-52b84bfcdfa9@ramsayjones.plus.com>
References: <c5b2a072-5058-0d3e-8fb0-52b84bfcdfa9@ramsayjones.plus.com>
From:   Max Kirillov <max@max630.net>
Date:   Mon, 30 Jul 2018 06:55:12 +0300
X-Google-Sender-Auth: sCbSdqhc--Ypi9FJeXspU_gF_eY
Message-ID: <CAF7_NFRNcHh2d91s5Sd1QiC-b+9dshjiHH2O-jCfS1gw7fTp+A@mail.gmail.com>
Subject: Re: [PATCH] t5562: avoid non-portable "export FOO=bar" construct
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Commit 6c213e863a ("http-backend: respect CONTENT_LENGTH for
receive-pack", 2018-07-27) adds a test which uses the non-portable
export construct. Replace it with "FOO=bar && export FOO" instead.

Thank you. Apparently the check is performed by make -C t, and I did
not run it like this since I only changed the test.
