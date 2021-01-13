Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E6AC4332D
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 19:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44856235FF
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 19:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbhAMTBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 14:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbhAMTBx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 14:01:53 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5C4C061575
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 11:01:12 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id h19so1836853qtq.13
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 11:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kyx+jaiNpE16quotq5tpU6uWu47m6fDmPH6GWF2R1d0=;
        b=oBYG5J15xgTK83ULz4+omOfeKxCIHqLv9bdVP1nmuciMxjecKDbbQCisQNxxhEbU8R
         59J5+LJUwJVTOd8SRenytubOEM4WCaR3AIchdc0iRlMCK5rzMgc8oEPFKanEN8XrJazU
         R7xIFTz12m1Rpn7/SsVFcBYYw+XkIjhDV6qcnMSyQnB69yO6VSpFQ+ovR//DWSK+q5nt
         yOv6xitWCDUxTeL5pRdTbQHCVcz7II8sfqH451CB6g6LPS8g0AlNrLaszZkSl3dxgSSg
         8aXUfmxaRL2hgYF258wsvS6bucCgOUm2BvAZQjnnw9ogfRub0vdPtziupbhU2Qt0ScBV
         PjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kyx+jaiNpE16quotq5tpU6uWu47m6fDmPH6GWF2R1d0=;
        b=mDbOu3seUrRdsJcIaP9BME1OX0XVWZJMAiJLcBHYwDQTCHCSAf57au/fcyYg99YVca
         VpR5ZRlEdrrM4lY3l0HmToiuJvixtufoRJgUCVC26E62V+MUy+J8kDq5F8JcDTVCLlPt
         blOe3sAqACZ1vNOrkT367OzqHH2DUe0T0M+LzZoVW5lRRFe7dtKl7kpWA2cjsTqMZdwx
         2aoomX911R4yT1wRbLKctYkhuJz1o/eSyxVyKRVaJJXcH3jZgRItBQBk/+PGlwR2NqSM
         Pe2y72kxbrVdScMB8h2uAZKJ63OXV8J0w6dUjxN8j6sOarZ4mPNtOlrtKNRpsMlTheYV
         4uYw==
X-Gm-Message-State: AOAM531j+S3mrx7T5iq48MWn//LLYKH2xrDtG/djeFLh26uxQ/ys8Lmn
        Fy24uRiUPqrCr5VS0n4IoeceyA==
X-Google-Smtp-Source: ABdhPJzvMjsjFMxWj9alfIquNGqvW9fSOZ8sBdt9w5vgZ4w0zAsF3A46oXZtJUtRakQTNu6hMkCytw==
X-Received: by 2002:ac8:1c1c:: with SMTP id a28mr3749061qtk.121.1610564472085;
        Wed, 13 Jan 2021 11:01:12 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id d123sm1543650qke.95.2021.01.13.11.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 11:01:11 -0800 (PST)
Date:   Wed, 13 Jan 2021 14:01:08 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        phillip.wood@dunelm.org.uk, Johannes.Schindelin@gmx.de
Subject: Re: [RFC PATCH 3/9] rebase -i: comment out squash!/fixup! subjects
 from squash message
Message-ID: <X/9DdGnYo7RQz5CE@nand.local>
References: <20210108092345.2178-1-charvi077@gmail.com>
 <20210108092345.2178-4-charvi077@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210108092345.2178-4-charvi077@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 08, 2021 at 02:53:41PM +0530, Charvi Mendiratta wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When squashing commit messages the squash!/fixup! subjects are not of
> interest so comment them out to stop them becoming part of the final
> message.
>
> This change breaks a bunch of --autosquash tests which rely on the
> "squash! <subject>" line appearing in the final commit message. This is
> addressed by adding a second line to the commit message of the "squash!
> ..." commits and testing for that.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> ---
>  sequencer.c                  | 25 ++++++++++++++++++++++++-
>  t/t3415-rebase-autosquash.sh | 27 +++++++++++++--------------
>  t/t3900-i18n-commit.sh       |  4 ----
>  3 files changed, 37 insertions(+), 19 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 5062976d10..b050a9a212 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1718,15 +1718,38 @@ static int is_pick_or_similar(enum todo_command command)
>  	}
>  }
>
> +static size_t subject_length(const char *body)
> +{
> +	size_t i, len = 0;
> +	char c;
> +	int blank_line = 1;
> +	for (i = 0, c = body[i]; c; c = body[++i]) {
> +		if (c == '\n') {
> +			if (blank_line)
> +				return len;
> +			len = i + 1;
> +			blank_line = 1;
> +		} else if (!isspace(c)) {
> +			blank_line = 0;
> +		}
> +	}
> +	return blank_line ? len : i;
> +}
> +

OK, so this gets the length of the subject in "body", which is defined
as the run of characters before a newline and then a space character. So
"foo bar\n\nbaz" would return 7, but "foo bar\nbaz" would return 11.

Makes sense. (Apologies for stating the obvious here, I just had to read
this function to myself a couple of times to make sure that I understood
what it was doing.)

>  static void append_squash_message(struct strbuf *buf, const char *body,
>  				  struct replay_opts *opts)
>  {
> +	size_t commented_len = 0;
> +
>  	unlink(rebase_path_fixup_msg());
> +	if (starts_with(body, "squash!") || starts_with(body, "fixup!"))
> +		commented_len = subject_length(body);
>  	strbuf_addf(buf, "\n%c ", comment_line_char);
>  	strbuf_addf(buf, _("This is the commit message #%d:"),
>  		    ++opts->current_fixup_count + 1);
>  	strbuf_addstr(buf, "\n\n");
> -	strbuf_addstr(buf, body);
> +	strbuf_add_commented_lines(buf, body, commented_len);
> +	strbuf_addstr(buf, body + commented_len);

Very nice; the subject gets commented when it starts with "squash!" or
"fixup!", but the body remains uncommented. Makes sense to me.

> @@ -224,7 +223,7 @@ test_expect_success 'auto squash that matches longer sha1' '
>  	git cat-file blob HEAD^:file1 >actual &&
>  	test_cmp expect actual &&
>  	git cat-file commit HEAD^ >commit &&
> -	grep squash commit >actual &&
> +	grep "extra para" commit >actual &&
>  	test_line_count = 1 actual
>  '

Worth checking that "squash" doesn't appear in an uncommented part of
actual? Or better yet, checking that "# squash ..." _does_ appear.

I.e., that we would leave this as:

    -	grep squash commit >actual &&
    +	grep "^# squash" commit >actual &&
    +	grep "extra para" commit >actual &&

> @@ -342,8 +341,8 @@ test_expect_success C_LOCALE_OUTPUT 'autosquash with custom inst format' '
>  	git cat-file blob HEAD^:file1 >actual &&
>  	test_cmp expect actual &&
>  	git cat-file commit HEAD^ >commit &&
> -	grep squash commit >actual &&
> -	test_line_count = 2 actual
> +	grep first commit >actual &&
> +	test_line_count = 3 actual
>  '

Ditto.

Thanks,
Taylor
