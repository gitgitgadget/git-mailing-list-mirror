Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F2EB1F51C
	for <e@80x24.org>; Wed, 30 May 2018 08:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936038AbeE3I7c (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 04:59:32 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:40213 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935975AbeE3I73 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 04:59:29 -0400
Received: by mail-qt0-f170.google.com with SMTP id h2-v6so22278898qtp.7
        for <git@vger.kernel.org>; Wed, 30 May 2018 01:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=24spWYTXC0bLCM4Tvmdpss5K9g4wbZB/Ny+qKf2sJ4M=;
        b=pYhtv79b9r5AU5ZJPDOqFoU6GrdP6N1F2uAg0K5yCM6Vkxjh6dBwasCjv2Ro1zEXcE
         HCgUe0r8uCrUCPdLWyk9nAltDI2isjfgtgr4OORG6PBhVnAj0ymZ+UBHbvP0em8qzZtW
         vO38jRmp3lEOgN4RV6bK9btgFK1EFsT1eo1StFBoe4IWL7s/4xXxdwZnN8T7G5Nj2Tu+
         B7EyfCO0cvWkA/uq2t7hfyj7soMeluhr9Aj9J0Oc5DbyGpAm0rNl/KDikMedW8H0G2rS
         ycDeC2UX7lDR3Ghrqab7f9l+vndvo3+xcN8UMg21FyXtP/FmbHbxDQPpFYzjbkqp08db
         NZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=24spWYTXC0bLCM4Tvmdpss5K9g4wbZB/Ny+qKf2sJ4M=;
        b=NWWXHudS33e+RoxOnrqqID0r+7cTFtNh3bM0yH2AcdV5Z5NHGaACOIOHZk0zeRYu0h
         tuH2s8mO9HwWwmdJyOhvrapZBvPPEh+bq2H8iGUos2/X7c7a5mYLwMuVBxYJiRIJMzIX
         fckEPVlTVEDwaMrKFT5uLZz8bs467f13BmxDk77HGeLKZYk10Fc7aE8Q/LPIWXhzOOXi
         tYurgb8ABj2YdcwA5vkTYDinUUvXl/B4Lm3sYAF6MwZlaNtmU9Pg/fEgCw57eKOkHo6w
         Ca7JbUHqumehtxT8WSwzpzHGcVgrXy84ULOiskHCpklsDO1cGvR9ERY/ChVELjY/vQ54
         6L7A==
X-Gm-Message-State: APt69E3oCGFFbBSXqV1+2SeZ4fzU0/HISLnArQKenbBhmm3Kx+XnKqd5
        +LagNO7g4tISBcHvn3w+FdwJiVXcBEOclQqodhI=
X-Google-Smtp-Source: ADUXVKKcFRgI/JKGFboiQ55dqJHHACAf+z3kwGPoOeKpGT7UgoGcJBsvBIG+MxjUk6bVBSDuRhKzO5bjN49PlGRAf2g=
X-Received: by 2002:a0c:f6cb:: with SMTP id d11-v6mr1614783qvo.41.1527670768315;
 Wed, 30 May 2018 01:59:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa4b:0:0:0:0:0 with HTTP; Wed, 30 May 2018 01:59:27
 -0700 (PDT)
In-Reply-To: <20180529053037.38015-3-istephens@atlassian.com>
References: <xmqqzi1iwz7l.fsf@gitster-ct.c.googlers.com> <20180529053037.38015-1-istephens@atlassian.com>
 <20180529053037.38015-3-istephens@atlassian.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 30 May 2018 04:59:27 -0400
X-Google-Sender-Auth: kzrGj_jFZgMtHXsqVpBYju9ti5Y
Message-ID: <CAPig+cQ3hRHQM4hOOU9ibOVt3LWvXjNS-VmbK8QWsFFJL=jBvw@mail.gmail.com>
Subject: Re: [PATCH] log: prevent error if line range ends past end of file
To:     Isabella Stephens <istephens@atlassian.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Bryan Turner <bturner@atlassian.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 29, 2018 at 1:30 AM,  <istephens@atlassian.com> wrote:
> If the -L option is used to specify a line range in git log, and the end
> of the range is past the end of the file, git will fail with a fatal
> error. This commit prevents such behaviour - instead we perform the log
> for existing lines within the specified range.
>
> This commit also fixes a corner case where -L ,-n:file would be treated
> as a log over the whole file. Now we treat this as -L 1,-n:file and
> blame the first line of the file instead.
>
> Signed-off-by: Isabella Stephens <istephens@atlassian.com>
> ---
> diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
> @@ -86,12 +85,7 @@ test_expect_success '-L ,Y (Y == nlines)' '
>  test_expect_success '-L ,Y (Y == nlines + 1)' '
>         n=$(expr $(wc -l <b.c) + 1) &&
> -       test_must_fail git log -L ,$n:b.c
> -'
> -
> -test_expect_success '-L ,Y (Y == nlines + 2)' '
> -       n=$(expr $(wc -l <b.c) + 2) &&
> -       test_must_fail git log -L ,$n:b.c
> +       git log -L ,$n:b.c
>  '

Not sure why you removed the 'n+2' test which was added intentionally,
along with the 'n' and 'n+1' tests, to probe the boundary handling for
correctness. By eliminating 'n+2', coverage is reduced and, even
though your change might be correct at this boundary, some future
breaking change might go undetected.
