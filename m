Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6991420380
	for <e@80x24.org>; Thu, 23 May 2019 10:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfEWKJa (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 06:09:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51708 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfEWKJa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 06:09:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id c77so5174084wmd.1
        for <git@vger.kernel.org>; Thu, 23 May 2019 03:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=36aC+lteTZxrE2zu4rbcR91Cky8bAV1Dy6m8O2IR420=;
        b=NSJ/ShY1jy/jNTm70+Rv9/ZJCIM8TB8vYla+RtY+e2tIEl7Odmy9OK8WDCYg4hhSaO
         mWrRuFvcADDp+AYNFfPRxUNnBuq4HmurZkYCjDEe+vBo1BKngwKzPvV5o5m1S4mND1nx
         VnzliW/PaR9f/RaaezafZJYNsIKwgFcm11cRxv44J4LeolFCmnurFZa3I955nNH8cmGI
         7d87IQkCxCmRG5gIcJta6iG0Jm2YeMJahpjia26KWYmH5l46Fo5RJHZJgheJE5EpQj4Y
         stI6cWGqpIu4vu2CxLcLeMwAzTN5WMLXX51DEfceNKSdD1WVajEiIWdgclmBBiHdYFIT
         HOgA==
X-Gm-Message-State: APjAAAXl7tm+7yLagO2KpevKdwwiC0JIIJY+t0V0I/KZAbJRhAriIyqu
        2KLDusjdAscmra9UBCQnVK8zriIKs57Acf25bks=
X-Google-Smtp-Source: APXvYqzUYIiqMcHrYXSNy7iV0S26XA1Xam5Lc+glJyT0XFnCenAWohhNDshSVnZUwZQKvdGMbocyybCvEm98eVg7Q9Q=
X-Received: by 2002:a1c:7e8d:: with SMTP id z135mr11057552wmc.72.1558606168391;
 Thu, 23 May 2019 03:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190521010036.70378-1-emilyshaffer@google.com> <20190523005533.260611-1-emilyshaffer@google.com>
In-Reply-To: <20190523005533.260611-1-emilyshaffer@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 23 May 2019 06:09:17 -0400
Message-ID: <CAPig+cQSp2pY9_fYhDPO+YwEmVXiqB+wjhL9NTcA+Mc_TQbWHg@mail.gmail.com>
Subject: Re: [PATCH v3] doc: hint about GIT_DEBUGGER in CodingGuidelines
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 22, 2019 at 8:56 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> We check for a handy environment variable GIT_DEBUGGER when running via
> bin-wrappers/, but this feature is undocumented. Add a hint to how to
> use it into the CodingGuidelines (which is where other useful
> environment settings like DEVELOPER are documented).
>
> You can use GIT_DEBUGGER to pick gdb by default, or you can hand it your
> own debugger if you like to use something else (or if you want custom
> flags for gdb). This commit documents that intent within
> CodingGuidelines.

This last sentence is repeating what is already stated in the first
paragraph, thus doesn't seem to add value. In fact, the remainder of
the second paragraph seems to be repeating what is in the patch
proper, thus could likely be dropped.

> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> @@ -412,6 +412,12 @@ For C programs:
> + - You can launch gdb around your program using the shorthand GIT_DEBUGGER.
> +   Run `GIT_DEBUGGER=1 ./bin-wrappers/git foo` to simply use gdb as is, or
> +   run `GIT_DEBUGGER=my-debugger-binary my-args ./bin-wrappers/git foo` to

Don't you need to bind my-debugger-binary and my-args together with
shell quotes? Also, placeholders like these are often ensconced in
angle brackets, so perhaps:

    ... `GIT_DEBUGGER="<debugger> <debugger-args>" ./bin-wrappers/git ...

> +   use your own debugger and arguments. Example: `GIT_DEBUGGER="ddd --gdb"
> +   ./bin-wrappers/git log` (See `wrap-for-bin.sh`.)
