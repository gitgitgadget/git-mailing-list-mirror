Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A46D1F424
	for <e@80x24.org>; Wed,  9 May 2018 15:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964915AbeEIPZY (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 11:25:24 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:44541 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935365AbeEIPZX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 11:25:23 -0400
Received: by mail-vk0-f65.google.com with SMTP id x66-v6so17521492vka.11
        for <git@vger.kernel.org>; Wed, 09 May 2018 08:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bj8ny0o9kebPIt3FS8Xo3NcoNO9+SmpEemq42NLJfiA=;
        b=rrvLjT8Dc1vYQqLaMqB6mmNUWcJPy6JfHZX+YQrl4in8OmPiZVw1qkCgumcvf5JcAD
         n5OvjRpkYIByI3NN7IJA8D+Z31zc2unwQ8IvGXCaXZzAGg5lAHHObwNhvvecdLd9+85t
         R+Uvz4vCNvSFZiAoq/Y8HrZmcM8all/3/E9DczKBluR2JEtThmnhJDtsAgJWlTOlzztc
         GZCr0XSb/DP3opwGibF4d/w2LvTCXpu822j7gKNNrPMxrdWMHZpKaD8R7hccRz8i7VxH
         nRIHKj2ocIwx/Kr46ZFk4sePtsn/2Xjo5bRSVPd8m8K9fscMH4akb063LAfdopgCwNz6
         lI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bj8ny0o9kebPIt3FS8Xo3NcoNO9+SmpEemq42NLJfiA=;
        b=HRmFeN2VAbid40chrdCH6b0uMEYBBHVAUKjbrWnkIa6nAhRIG9am38NIityZ6IRgVS
         QobA0QoRmVpssEJOCteMSploYX1ZPLuXAyCtKWhEDAI+wPM0ZwXjiC4Atfl3BNGKFUY9
         KPqmgC4DE9zDr3fot2H7KrtFtdVi6KvJ1NkGUfYKVYAN/1bG6XMD5I4OP8adzrSHquhJ
         wuR8m9vK9w/u/BPksDNoh2Xn/Rm9EI9GuZP5tczjTqfCLzjfxaQq2U3zK2P7mkGPH0wu
         kJTGqSRFAL+40riMJ0WZSWcqGX5eYhJCSlbTZnuSClaWKJycEK7UpI6HThdCThvIxpL4
         gRew==
X-Gm-Message-State: ALQs6tDN6xG/Ja66PCeV6X8xITl3+ZUW4mEUqR2R9YCm3lGSQsmG7lHj
        8aPqeTfZmIA1MPxqwsyT60JGF3612ukNYzS/Z/c=
X-Google-Smtp-Source: AB8JxZrlJip5yg0IpSHTgMjRMiwy4CK8tvTnygh1OS5cSUTGfadzd430KYzmq57hTo5jRBUoRwItoby3wJnUlzZmwDQ=
X-Received: by 2002:a1f:c155:: with SMTP id r82-v6mr37357261vkf.76.1525879522238;
 Wed, 09 May 2018 08:25:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Wed, 9 May 2018 08:25:21 -0700 (PDT)
In-Reply-To: <20180509132858.21936-1-ao2@ao2.it>
References: <20180509132858.21936-1-ao2@ao2.it>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 9 May 2018 08:25:21 -0700
Message-ID: <CABPp-BEvNOBkq0-v_Uq0CHkvRixCKmUhYPMeH-MHHZGb0x9NkA@mail.gmail.com>
Subject: Re: [PATCH] wrap-for-bin.sh: facilitate running Git executables under valgrind
To:     Antonio Ospite <ao2@ao2.it>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Antonio,

On Wed, May 9, 2018 at 6:28 AM, Antonio Ospite <ao2@ao2.it> wrote:
> Testing locally built git executables under valgrind is not immediate.
>
> Something like the following does not work:
>
>   $ valgrind ./bin-wrappers/git
>
> because the wrapper script forks and execs the command and valgrind does
> not track children processes by default.
>
> Something like the following may work:
>
>   $ valgrind --trace-children=yes ./bin-wrappers/git
>
> However it's counterintuitive and not ideal anyways because valgrind is
> supposed to be called on the actual executable, not on wrapper scripts.
>
> So, following the idea from commit 6a94088cc ("test: facilitate
> debugging Git executables in tests with gdb", 2015-10-30) provide
> a mechanism in the wrapper script to call valgrind directly on the
> actual executable.
>
> This mechanism could even be used by the test infrastructure in the
> future, but it is already useful by its own on the command line:
>
>   $ GIT_TEST_VALGRIND=1 \
>     GIT_VALGRIND_OPTIONS="--leak-check=full" \
>     ./bin-wrappers/git
>

Wow, timing; nice to see someone else finds this kind of thing useful.

I submitted something very similar recently; see commit 842436466aa5
("Make running git under other debugger-like programs easy",
2018-04-24) from next, or the discussion at
https://public-inbox.org/git/20180424234645.8735-1-newren@gmail.com/.
That other patch has the advantage of enabling the user to run git
under other debugger-like programs besides just gdb and valgrind.

Hope that helps,
Elijah
