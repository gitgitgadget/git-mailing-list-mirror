Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 802FF2018D
	for <e@80x24.org>; Tue,  9 May 2017 06:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbdEIGbu (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 02:31:50 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36378 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbdEIGbt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 02:31:49 -0400
Received: by mail-pg0-f65.google.com with SMTP id 64so6205737pgb.3
        for <git@vger.kernel.org>; Mon, 08 May 2017 23:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0W5LAp7oDLE0ogMNBLaOc3INNKOoh49ybRjJ7bPCRAA=;
        b=CM3UUh7+oX/qb+W5ye4FtChRtYBKpioAe0L0h+K8qbGyXGVl6HmxOAUSUYNgxgVdMo
         /0oW7W9x20QmXfLRzHGZLyIg7K9z8txzXoa7Gm6Sf5zN5RqwNeY6LPq1DrfRDWh/Z6Wz
         PdXeL6kR14rCuGZXGQUugmR5oeQE+8UkCwWQW7FUGRZ9nV6xzBdab+cyDLkJfhFnC9Ia
         mKw20D+qt1VKgEdOf1uiSBZhv9l0CKxUZuqDfR+hIr0e1dQZ3Il9CBYEqgrg7TSw36LO
         EXafsemO7LTOvsnEMb4orhdeJFkNruMg0hG26itvkM6lxSrK4wP6wFWzy/LCUOrmUK9E
         D5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0W5LAp7oDLE0ogMNBLaOc3INNKOoh49ybRjJ7bPCRAA=;
        b=uBJgqvpr4iuoivgqBQLOQDn9QDcARktSJnfgeg4iiEoO09P/cBgbx9MWiwXiRbnbrA
         kc0d7lOT+w4D9eK/tUk0j0HyVAQdosELxNf1U4BzRbWQ3cZfvdC4wkXNcp7FJ02Xz3eI
         edzOjjmlfhvY2q1TCgEdcBWEtA3tnCkf0y+/NTYF4vIPE8zpYwqup2i2k/8+RyzcGKSW
         wH1mKKgb2UH9b+95UVme89wGtNbE8SvMxoR0r6ZEto0Pm7yzCcc4IBqW1t/Ro2h7eugJ
         ewN6VDbdfNn+YoTFxmNJO+AkyFO9Q6EtCqscwUClUQ5BDejpPXkji9vGUVKNbngChzCR
         wx5Q==
X-Gm-Message-State: AN3rC/5xfsK/piHbY6WcGN9SMAxqxnrKQOm/bfSIGOqVTphYRWFbJbKT
        evZk0OPjlb2Crw==
X-Received: by 10.99.104.6 with SMTP id d6mr23302840pgc.185.1494311509267;
        Mon, 08 May 2017 23:31:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9133:cf19:b689:27d6])
        by smtp.gmail.com with ESMTPSA id b90sm10354912pfj.19.2017.05.08.23.31.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 23:31:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2] travis-ci: retry if Git for Windows CI returns HTTP error 502 or 503
References: <20170503215015.17949-1-larsxschneider@gmail.com>
Date:   Tue, 09 May 2017 15:31:47 +0900
In-Reply-To: <20170503215015.17949-1-larsxschneider@gmail.com> (Lars
        Schneider's message of "Wed, 3 May 2017 23:50:15 +0200")
Message-ID: <xmqqpofi35ik.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> The Git for Windows CI web app sometimes returns HTTP errors of
> "502 bad gateway" or "503 service unavailable" [1]. We also need to
> check the HTTP content because the GfW web app seems to pass through
> (error) results from other Azure calls with HTTP code 200.
> Wait a little and retry the request if this happens.
>
> [1] https://docs.microsoft.com/en-in/azure/app-service-web/app-service-web-troubleshoot-http-502-http-503
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>
> Hi Junio,
>
> I can't really test this as my TravisCI account does not have the
> extended timeout and I am unable to reproduce the error.
>
> It would be great if we could test this is a little bit in pu.

This has been in 'pu' for a while.  

As the patch simply discards 502 (and others), it is unclear if the
failing test on 'next' is now gone, or the attempt to run 'pu'
happened to be lucky not to get one, from the output we can see in
https://travis-ci.org/git/git/jobs/229867212

Are you comfortable enough to move this forward?  It's not like a
possible breakage in this patch will harm anything (the relaying to
the Windows CI is flaky if the build server cannot deal with the
load anyway), so I would rather have this early in 'next', while we
deal with a few other topics that Windows build is not happy with
that are on 'pu'.


