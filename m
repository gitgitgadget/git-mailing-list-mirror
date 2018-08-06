Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7E4F208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 15:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732935AbeHFRmq (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 13:42:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33332 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732930AbeHFRmq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 13:42:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so7058433pfn.0
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 08:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3jr+S6m3ZUjaIm20iszt8CzAKyOgQNmSC2rB3KzI1vw=;
        b=cRDWbNuCFCjGOYgoYOtX8GHhei3xbhMuDbyMdchLGcsBOYi0hAwbV50TzDy+odHaQo
         CfgtlwmZJmj3LDAfjHIn0zlLAU6U1YcMtp7arMxn9drUJ1D9xO/++pea8OAw3AkBuXkh
         PehyFgkUumQMAYxtfe7ptQeiPk/s0fS9ZCSnhcSe4N6LdnCkHFFJVjAc84Ly8KMbGZ11
         FpBgixCXaSKMdchyZG0uDVp2BuMAOgkmnV+oftvhlE3bdM9uvoaetEStePxMQWBAYoRF
         XHB6x7v+bU96XOgtPJO96u5AmHW5oUlEgcx/ouj+GT0pZiDtffIp+97hm5AytSyegQu5
         kT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3jr+S6m3ZUjaIm20iszt8CzAKyOgQNmSC2rB3KzI1vw=;
        b=tjtwbKHc7v+MeTUOTOSMtxwrbGJLcILBm8BACGyb8u6SjRZXdlWlqUo2oYmlbRh7i3
         +ICnr6R43poPlb1ubcoJNmyswOTjquy+I11miAasngV1QNeQGH+mqSAPsktYCELqVnKq
         bCW85xLkr/WB3uX48LDhiWyHB+AA+CyvFs6U9tliSxNXoPTkl2hSz43ACwlmyiuKpjzW
         DmdLzSPwVQyz6+GgpWvszDqq5Crd6z361n3hLyFpa2yd60TiXDTXq5RstbMNsyjUw6f1
         fmJSlYYQtks0GO2Pf35JpvfkZ4AvZ98/Ax0S/8aP5EJkxP+26izqTMTRTVb7y/HGJcUm
         ocJw==
X-Gm-Message-State: AOUpUlEyuKcuncxlYlOID+G5w1z3zPLEBWB2L5lvLr6tx5kqLxWtwJPd
        xaPj25p4m2+DjpNANl9Kiag=
X-Google-Smtp-Source: AAOMgpcyrM3dQVYwd5SGJ8BCEYJTGxRpOqWRTTMj05XKXwPbuwotmqrCz0tvEEMQtpwUhZVGVJm5nA==
X-Received: by 2002:a65:560a:: with SMTP id l10-v6mr15263880pgs.130.1533569587546;
        Mon, 06 Aug 2018 08:33:07 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id t19-v6sm25667272pfk.182.2018.08.06.08.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 08:33:06 -0700 (PDT)
Date:   Mon, 6 Aug 2018 08:33:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] line-log: demonstrate a bug with nearly-overlapping
 ranges
Message-ID: <20180806153305.GA105466@aiede.svl.corp.google.com>
References: <pull.15.git.gitgitgadget@gmail.com>
 <cab7bb36eb85dbe38ad95ee02b083f11f0820e24.1533421100.git.gitgitgadget@gmail.com>
 <20180805015908.GE258270@aiede.svl.corp.google.com>
 <nycvar.QRO.7.76.6.1808061216060.71@tvgsbejvaqbjf.bet>
 <20180806144726.GB97564@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806144726.GB97564@aiede.svl.corp.google.com>
User-Agent: Mutt/+ (31e72e18) (2018-08-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:
> Johannes Schindelin wrote:

>> It is really, really important to realize how valuable it is to have the
>> regression test as an individual patch that can be used to verify that
>> there is a bug, to pinpoint where it was introduced, to test alternative
>> fixes, to keep records separate, and I could go on and on and on. Please
>> do not ignore these very good reasons, and please refrain from
>> recommending such conflation in the future.
>
> If you want to propose changing the project's style to always separate
> tests from the patch that fixes a bug, that's a discussion we can have,
> in a separate thread.

By the way, don't get me wrong: I am sympathetic to the motivation for
such a change.

I have worked on projects where tests were in a separate repository
from the application.  There are costs and benefits.  To support the
kind of use cases you're describing, the tests would include
conditionals to allow running on old versions of the application (the
test expectations were based on the latest version, but setup code
sometimes had to accomodate differences between versions).  It worked
okay and was probably worth it for that project, despite the added
friction.  It's not clear it would be worth it for Git.

Jonathan
