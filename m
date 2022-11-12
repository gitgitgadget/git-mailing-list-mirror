Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2987C433FE
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 07:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiKLHNe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Nov 2022 02:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKLHNb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2022 02:13:31 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332F8218E
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 23:13:29 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id a13so10507694edj.0
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 23:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=527a8gkxJx6i6vTt80COc5KTq9/rQdRXD78hGND2ON8=;
        b=gNF3AzaqRQxxz9g2TXiWrw1OfU6RQkPss+qYMqb+sHOLkLrih9LFMZ8hoy76ReoqKV
         ZmD3/PcDaCSO17ZJJ954m9Ux15G9I74I05QK1xnJZ/QurXAHM2j44lwW3ijduVp0Ccvp
         5bbEqsVnXRItikNMI1arvA3LYPrQf3i6RtoMSGXYdg94WKLsST5ws6jISbzl+c5A/KH9
         6huwTyILkb6IKoh4m8gAlhUF0V/cvDKSCG6yWkB6qgcIcfegfYXFvduj51u7k3AIG2ZB
         R6t8TI+8v6gzQ1llbGTi42YpDyxKweEK8j/LSsZTgokYGRImg9x5DWXSDfbnS6ORVB14
         ncEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=527a8gkxJx6i6vTt80COc5KTq9/rQdRXD78hGND2ON8=;
        b=hw3MIy/ytVqLC0zktzrNGJY7PB+6wgs7jROVqqv+e+yPlrydcJ8ytJOiVc/y292tog
         sqt7Ur7U4lwhGDzo20218llDf6q+x3fsm60CR2lhx0SycB69gdU1tGLxSGr2mV8WlF3X
         rPy+oe0Lo0UEMCrI6U2+skKpK2C9G7Ye4Um5kVw6NVW07/1BjcOhgm1md+4Ihk0Rs5UW
         921MbhSagWRPkrmeikT99NUFgDIhv2T5V8GX+bllMcDhZYKGmNfpGXRfR5FJuQR87ubb
         +OzfuI5zLe9HG/nURCLFdbDDOpJ9usUVWDtuP3aqUz1chM5bKRSWXIq9yx/Ycp0YCOB4
         D04A==
X-Gm-Message-State: ANoB5pkeXktzQj8lcRfds9QC488onb0Dmw8Ytx801s8j1DbcHShraSeG
        3BtGqMv66dl8qaaimaiP0HI=
X-Google-Smtp-Source: AA0mqf6lFf3nevcIdpYRx/B2Sye5zcUpUrQRh+3fLYMBkrQJfuoW785/BrVzgQzlCjS68KZ262hUKw==
X-Received: by 2002:aa7:db14:0:b0:464:fa1:9ece with SMTP id t20-20020aa7db14000000b004640fa19ecemr4635319eds.262.1668237207684;
        Fri, 11 Nov 2022 23:13:27 -0800 (PST)
Received: from localhost (78-131-17-60.pool.digikabel.hu. [78.131.17.60])
        by smtp.gmail.com with ESMTPSA id q35-20020a05640224a300b00461e4498666sm584499eda.11.2022.11.11.23.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 23:13:27 -0800 (PST)
Date:   Sat, 12 Nov 2022 08:13:13 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Adam Lee <adam8157@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [Bug report] git log shows a wrong history
Message-ID: <20221112071313.GE1159673@szeder.dev>
References: <CABAGCCq-bFYX+9kU-GGWBstjMjOcO1nSQdi6Udugtkd2McO3Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABAGCCq-bFYX+9kU-GGWBstjMjOcO1nSQdi6Udugtkd2McO3Tg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 12, 2022 at 12:23:58PM +0800, Adam Lee wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> ```
> git clone https://github.com/greenplum-db/gpdb-postgres-merge.git
> git_log_reproducer
> 
> cd git_log_reproducer/
> 
> git co -b iteration_REL_12_12 origin/iteration_REL_12_12
> 
> git log
> ```
> 
> What did you expect to happen? (Expected behavior)
> 
> A part of the history is:
> ```
> ...
> commit 9ac9a7fd4138988d744e0b5767883c06c20ffa6f
> commit fe0a9ddbdd7eee572f7321f9680280044fd5f258
> ...
> ```
> 
> What happened instead? (Actual behavior)
> 
> That part of the history is:
> ```
> ...
> commit 9ac9a7fd4138988d744e0b5767883c06c20ffa6f
> commit f9c655d647427b45ae0d7bd9baf3551a013b8ea1
> commit fe0a9ddbdd7eee572f7321f9680280044fd5f258
> ...
> ```
> 
> What's different between what you expected and what actually happened?
> 
> commit f9c655d647427b45ae0d7bd9baf3551a013b8ea1 is at the wrong place.

'git log' shows the commis in reverse chronological order by default,
which means that if development happens on multiple parallel running
branches, then commits made on different branches might be shown
intermixed.

And indeed the commit timestamp of f9c655 is between that of the other
two:

  $ git log --format='%H %ct' |grep -A2 ^9ac9a7
  9ac9a7fd4138988d744e0b5767883c06c20ffa6f 1657232286
  f9c655d647427b45ae0d7bd9baf3551a013b8ea1 1657195677
  fe0a9ddbdd7eee572f7321f9680280044fd5f258 1657177514

(Using the seconds since epoch timestamp format here, because those
three commits were made in different time zones, making their ordering
by simply looking at them not quite that straightforward.)

Showing commits in topographical order "avoids showing commits on
multiple lines of history intermixed" (quoting the manpage), although
at the cost of slightly more processing time:

  $ git log --format='%H %ct' --topo-order |grep -A2 ^9ac9a7
  9ac9a7fd4138988d744e0b5767883c06c20ffa6f 1657232286
  fe0a9ddbdd7eee572f7321f9680280044fd5f258 1657177514
  5a9a4091ad1a187cec9d7da0faafac15b088fe60 1657172979

> `git log --graph` is fine.

'--graph' implies '--topo-order' by default.

