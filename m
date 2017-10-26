Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60E531FAED
	for <e@80x24.org>; Thu, 26 Oct 2017 08:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751661AbdJZIsh (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 04:48:37 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:57169 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbdJZIse (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 04:48:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id z3so6629491wme.5
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 01:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+ADMuypZPWRe/zSTd1fFAtnL8/A7n5cMqW0O90GkI0g=;
        b=NUe7cLfUHJPOGh+VYVAg9m69b6jT7j0vnKVyboNXifd+tzf4/hjXYlfixGbDILqsih
         x+2Kb1AB5LxWIrqMvo+rbcmxqtAEC+HoAZVG3TPFXSRocSQ3DB0gPQCx4qQA9T5qqWkN
         DUjpVTRn0R6adqFoBFBBKgf90tNfPLBPY/ZOJtuwMebXtLukhVrwNKTuis4q/3+CUrPy
         B8cWAMHrafEBChQPUv/+aw1vqYQcYjSDaOvOV3UBTONw9y/XQZFOtzCefozrf0cU7iC4
         8GrHWp9mBKjQ0Z4Juo6L430VB7xQwbEBadAeSmZv1ykVdAvN/EICfh3P3HFsXzH+lXj5
         h8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+ADMuypZPWRe/zSTd1fFAtnL8/A7n5cMqW0O90GkI0g=;
        b=VaBGYpHssuKbwwS1/K81u+4IQ5W9bWoT8tC5cYtHUT7zW6buItq7bk3o56y22EgYeG
         HdI3z/9L6Ul7W74FP2/EHVDO5zoNUmscwHVzzD6Ohji2mmBUEshgwfAnUqrGaGMPZH6y
         tZm803H99N8qe620jmK6CfzjAeMb4547Y2jlSZ9aDix1oUI4l8orDjvKHqUozZd5VvDw
         NRKvEY6sjDK8e4YMX6q3IcYL8FH14J8HXLRR+YTZbicSqwOPRcwQ5RwLam+KlWczri/P
         6vlcC8kQuFyvi+OSbLse9Fa9EmYjnXpmchhWBlHH6DlvudI9fm74guAhhqUOZgmLuzZH
         kDZw==
X-Gm-Message-State: AMCzsaXgVSb4qKVuWkSy8lYluAwflkoovWgGSmNGZt2lRJncPUXfItqW
        DbhUtRj1DEl/4aVjKftr2dNraMY2ahNrhORkyHg=
X-Google-Smtp-Source: ABhQp+QeUtMz1hTHaWYQ0v7h0Va0oYJtrN/1Qfln8gFuNGRUNzswwnGSu4+XE2BssMOaUU8d7oeBBFErfFP7Amp4nJ8=
X-Received: by 10.80.173.210 with SMTP id b18mr27784553edd.148.1509007713462;
 Thu, 26 Oct 2017 01:48:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.213.80 with HTTP; Thu, 26 Oct 2017 01:48:12 -0700 (PDT)
In-Reply-To: <20171026070108.4185-1-istephens@atlassian.com>
References: <xmqqtvyme8pg.fsf@gitster.mtv.corp.google.com> <20171026070108.4185-1-istephens@atlassian.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 26 Oct 2017 01:48:12 -0700
Message-ID: <CA+P7+xpk+9R9kMGNky4vTRpASf_nXM1xt0KHFjqwn8aB1NzDAQ@mail.gmail.com>
Subject: Re: [PATCH v2] blame: prevent error if range ends past end of file
To:     Isabella Stephens <istephens@atlassian.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>, bturner@atlassian.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 26, 2017 at 12:01 AM, Isabella Stephens
<istephens@atlassian.com> wrote:
> If the -L option is used to specify a line range in git blame, and the
> end of the range is past the end of the file, at present git will fail
> with a fatal error. This commit prevents such behaviour - instead the
> blame is display for any existing lines within the specified range.
>
> Signed-off-by: Isabella Stephens <istephens@atlassian.com>
> ---

I like this change. We might want to document L to indicate that an L
that is outside the range of lines will show all lines that do match.

Maybe we also want it to only succeed if at least some lines are
blamed? Could we make it so that it fails if no lines are within the
range? (ie: the start point is too far in? or does it already do
such?)

Thanks,
Jake

>  builtin/blame.c               | 4 ++--
>  t/t8003-blame-corner-cases.sh | 5 +++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 67adaef4d..b5b9db147 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -878,13 +878,13 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>                                     nth_line_cb, &sb, lno, anchor,
>                                     &bottom, &top, sb.path))
>                         usage(blame_usage);
> -               if (lno < top || ((lno || bottom) && lno < bottom))
> +               if ((lno || bottom) && lno < bottom)
>                         die(Q_("file %s has only %lu line",
>                                "file %s has only %lu lines",
>                                lno), path, lno);
>                 if (bottom < 1)
>                         bottom = 1;
> -               if (top < 1)
> +               if (top < 1 || lno < top)
>                         top = lno;
>                 bottom--;
>                 range_set_append_unsafe(&ranges, bottom, top);
> diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
> index 661f9d430..32b3788fe 100755
> --- a/t/t8003-blame-corner-cases.sh
> +++ b/t/t8003-blame-corner-cases.sh
> @@ -216,8 +216,9 @@ test_expect_success 'blame -L with invalid start' '
>  '
>
>  test_expect_success 'blame -L with invalid end' '
> -       test_must_fail git blame -L1,5 tres 2>errors &&
> -       test_i18ngrep "has only 2 lines" errors
> +       git blame -L1,5 tres >out &&
> +       cat out &&
> +       test $(wc -l < out) -eq 2
>  '
>
>  test_expect_success 'blame parses <end> part of -L' '
> --
> 2.14.1
>
