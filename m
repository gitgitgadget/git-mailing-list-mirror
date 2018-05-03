Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BED1B200B9
	for <e@80x24.org>; Thu,  3 May 2018 23:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751036AbeECXpN (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 19:45:13 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36744 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeECXpM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 19:45:12 -0400
Received: by mail-pf0-f195.google.com with SMTP id w129so10546113pfd.3
        for <git@vger.kernel.org>; Thu, 03 May 2018 16:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L8rARXhivffWgzhkq2Qf42gKdTb91KdhXRbpdSQSOFc=;
        b=hDuMklyetspblMD2rl+yng6t2lG5dqgI3NB8szRE/wQ3OwLq16Rbl78RPHqJNzYZpQ
         lS954Z0rUsrc8BSJukU2QMTApwhIwoZTZs/biRPyQysB9TBaCzSy4clT+IoV8Xo2SjGx
         AGzYf+IOsMnpzFRfSJJcvn1gaylcRyZzdi0U2h1GeYp4gootX00QkPgkQkVq9qru7KOl
         l6K4toRWIU5mHbinnlCJSm3qVO/TkVPC38DjEQ1ujBvlXiBp7oOg2YRCiPw9xVJxTT01
         Cp12PnG4IHvNryE2Dbq+9Sb+gE3i6RjBH+h+ccjzbGURYjwPCXJ83c1uhQ/AonpXW8nE
         v2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L8rARXhivffWgzhkq2Qf42gKdTb91KdhXRbpdSQSOFc=;
        b=nzsBWKhQp9VNDR4pg3Uu7T6JiDksn9jFm+d84wibP6zmgr584aKvRX+C7QO6Bdy/1J
         U0j87tyiY85n9Y6PnF6+amQPuWP7Y4zFtJ1C+kRMG6IT3I3fYnevAX30ulah964xlzXF
         3GlIT7AkUhNRQNIFOoHDLS1CBJNj5evczRQV7zDzHs1lAIVSiTHIL/0FaX5CO+cSXUBl
         97W2uVo2umIlsMxQ1TEWzwuf0RcdAIKkaJFeiudDPrsPnC5y4lua89fMF+CWCFKc57I/
         QuEFEGlYtr8ShqFVbLtjx5UeFFTMzcWOOSJx2y9PhngioHvQ6ABiEuriVHqsocrhjjt2
         +qfw==
X-Gm-Message-State: ALQs6tBQu8gU1gDs33xKbLfd1yHxq5qWvVYLk+fnzQQde75P90us9O2b
        wBrFI93+W6P/8k8sq9kvEZaccA==
X-Google-Smtp-Source: AB8JxZrWrwQX2osq7P/zM5spYtUYsOHnj5dtn0n6+AdP7m3W20zJoh9Ik/zh2+BtJ7/ylWz7rKJxPg==
X-Received: by 2002:a17:902:bc84:: with SMTP id bb4-v6mr14569680plb.84.1525391111892;
        Thu, 03 May 2018 16:45:11 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id 4sm29109512pfn.38.2018.05.03.16.45.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 May 2018 16:45:10 -0700 (PDT)
Date:   Thu, 3 May 2018 16:45:09 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 2/3] upload-pack: read config when serving protocol
 v2
Message-Id: <20180503164509.83dd9c113ddb849584863c08@google.com>
In-Reply-To: <CAGZ79kb4gHO=5aYMbT=AhZrOexkmkRakJRPRZd_GMrQJTF3WwQ@mail.gmail.com>
References: <cover.1525213052.git.jonathantanmy@google.com>
        <cover.1525220786.git.jonathantanmy@google.com>
        <6e85aaa555f6789156626330327085207b2d2dff.1525220786.git.jonathantanmy@google.com>
        <CAGZ79kb4gHO=5aYMbT=AhZrOexkmkRakJRPRZd_GMrQJTF3WwQ@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 3 May 2018 12:08:16 -0700
Stefan Beller <sbeller@google.com> wrote:

> test_path_is_missing ?

Thanks for the pointer. Done.

> > +       GIT_TRACE=/tmp/y git -c protocol.version=2 clone "file://$(pwd)/server" client &&
> 
> Why do we redirect GIT_TRACE outside the test suite? do we read that
> back or want to read it out of the hook?
> 
> Is it possible to redirect to  /$(pwd)/trace or such?

Good catch - that was a leftover from debugging. I've just removed it.

> > +       test -f server/.git/hookout
> 
> test_path_is_file ?

Done.
