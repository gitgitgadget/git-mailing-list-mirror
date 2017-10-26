Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31748202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 15:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932317AbdJZPb3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 11:31:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50764 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932291AbdJZPb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 11:31:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id s66so3667985wmf.5
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 08:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=Jgg4a72NTDyLZmbDRm/JEOuyuRoPUrSiatAH8w75kig=;
        b=bSGeSi6GC9qrLEoFjNOzQYtNTJ9qnqWhoN/5ylaIgS8X6StIXcdyzAAQsPD2wd+JZi
         HDdVZO/+ArxvqMwo2FHAa16ykaHm50XEztsb9KPwhp1gwbTfyZb2OBdbCEqoclonY0+2
         mVPmKw9fsMfQdzXPAyzf6aVHxY2HUVxSWaQFTUIxwR5BqRpfUxRssKl1VC62ixQlUwAK
         5TW3qmeg5Ns+Ogi8EdP6GEpCRjmPXhZiwi7NGtFr//Uz1uQcfa37dOVRnsYAh841FhMo
         sBHeYoYBkn7Ri1imW2J6akylW7PHI3a7p3ZwizJ0ahqJyoixpCC0o2RSrtonv4DEKMKM
         V/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=Jgg4a72NTDyLZmbDRm/JEOuyuRoPUrSiatAH8w75kig=;
        b=iPe/x8/fipnQLbjkGupiSEbtZRhLKTK8SR+kC1lSaefj8qWZol98xDE3Ck0G2yb2Ik
         sShBZNsoI09JcUlfTDpeh9CA2azhFneqHLS6Xs++1S4B8ehPUqwjrLRHQy/CihNcxYre
         NpN3jbgxnJ0NUSHIkxsTRLnwQ6L4qUD67MuVZQ6IdIDT4dONk2H8nzKq9jrD7gIVWpyj
         RajeMvLpKxTDB+HOWnMnMq0a9QO59eTUBIJ9jhg7o5SQwdZ9e6jmJ0b3OCCO7ISXqGHt
         Pwogc2WnlEvJI1R8ofqH0yvD5YHppzUHpGGsL0CoVtAQdCpFcynunPgXdlEOFUaKefkR
         62Ig==
X-Gm-Message-State: AMCzsaWu6gSngseRexWxcygDKE3eMPTZ821mGtl1BUryRAINcQS9KtNN
        nCetP7Z4O/UwRtKoWX83sls=
X-Google-Smtp-Source: ABhQp+Q+fJ9wYZaeZj2zWfnxODMKJ77aHz/vFLlrZbFSDpD0x5zVl1725i8V+c6GsDatHuPMApEcBw==
X-Received: by 10.28.59.134 with SMTP id i128mr2107371wma.114.1509031886984;
        Thu, 26 Oct 2017 08:31:26 -0700 (PDT)
Received: from localhost.localdomain (x4db15b4c.dyn.telefonica.de. [77.177.91.76])
        by smtp.gmail.com with ESMTPSA id p20sm1355959wma.0.2017.10.26.08.31.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Oct 2017 08:31:26 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Isabella Stephens <istephens@atlassian.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        gitster@pobox.com, git@vger.kernel.org, sunshine@sunshineco.com,
        peff@peff.net, bturner@atlassian.com
Subject: Re: [PATCH v2] blame: prevent error if range ends past end of file
Date:   Thu, 26 Oct 2017 17:31:11 +0200
Message-Id: <20171026153111.21813-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.0.rc2.117.g35d527b84
In-Reply-To: <20171026070108.4185-1-istephens@atlassian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> If the -L option is used to specify a line range in git blame, and the
> end of the range is past the end of the file, at present git will fail
> with a fatal error. This commit prevents such behaviour - instead the
> blame is display for any existing lines within the specified range.

s/is display/is displayed/ ?

'git log' has a very similar -L option, which errors out, too, if the
end of the line range is past the end of the file.  IMHO the
interpretation of the line range -L<start>,<end> should be kept
consistent in the two commands, and 'git log' shouldn't error out,
either.

> Signed-off-by: Isabella Stephens <istephens@atlassian.com>
> ---
>  builtin/blame.c               | 4 ++--
>  t/t8003-blame-corner-cases.sh | 5 +++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 67adaef4d..b5b9db147 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -878,13 +878,13 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  				    nth_line_cb, &sb, lno, anchor,
>  				    &bottom, &top, sb.path))
>  			usage(blame_usage);
> -		if (lno < top || ((lno || bottom) && lno < bottom))
> +		if ((lno || bottom) && lno < bottom)
>  			die(Q_("file %s has only %lu line",
>  			       "file %s has only %lu lines",
>  			       lno), path, lno);
>  		if (bottom < 1)
>  			bottom = 1;
> -		if (top < 1)
> +		if (top < 1 || lno < top)
>  			top = lno;
>  		bottom--;
>  		range_set_append_unsafe(&ranges, bottom, top);
> diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
> index 661f9d430..32b3788fe 100755
> --- a/t/t8003-blame-corner-cases.sh
> +++ b/t/t8003-blame-corner-cases.sh
> @@ -216,8 +216,9 @@ test_expect_success 'blame -L with invalid start' '
>  '
>  
>  test_expect_success 'blame -L with invalid end' '
> -	test_must_fail git blame -L1,5 tres 2>errors &&
> -	test_i18ngrep "has only 2 lines" errors
> +	git blame -L1,5 tres >out &&
> +	cat out &&
> +	test $(wc -l < out) -eq 2

Please use the test_line_count helper instead, as it will output a
helpful error message on failure, making the 'cat out' above
unnecessary.

>  '
>  
>  test_expect_success 'blame parses <end> part of -L' '
> -- 
> 2.14.1
> 
> 
