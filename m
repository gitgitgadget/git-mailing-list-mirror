Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34309C433F5
	for <git@archiver.kernel.org>; Tue, 17 May 2022 16:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351182AbiEQQr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 May 2022 12:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351236AbiEQQrW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 12:47:22 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F235044F
        for <git@vger.kernel.org>; Tue, 17 May 2022 09:47:11 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id b20-20020a62a114000000b0050a6280e374so7971692pff.13
        for <git@vger.kernel.org>; Tue, 17 May 2022 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gcaXs5HU/nWgC68BQWAaObu5tcmgzBNSoxqxSWARRD8=;
        b=qzOcnxde5On3mmjistmWUiqeRMraSCyiJxECBw2aOomnnAlrrGlk5MVIVTYLti08Kf
         25SNWZc46cgrNsQSxkkK2nzdLfZfC6NKe5fZBCIridC8zZ7gUJo1iypIEjBxwKUk2UiV
         7xz5vm3dk3NUE1G/RYS5yjbt9ZGbtb4bwJZptlHDu/Qoc55ZAGvvdTOAqglB113X4gUN
         v/IL697HWgsZ1GeIejINLypxlo17lZBsMAcUFdZa0npjQBRkuQIrydSCNcM/Jqi9qbOL
         JjKypL6W2DexWr8AWiveWpa0FsoAoWzfRErdHmIQe+yAYjd8paTGpZaTdNw0w9Z6HR0D
         +vRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gcaXs5HU/nWgC68BQWAaObu5tcmgzBNSoxqxSWARRD8=;
        b=M3nECWo8MeDShmAJjwSXuuyNllJV+gPpGih6v98agVbny9uDL0rveYUn/P8GlVHu7M
         y2hk/Ak/5k24984aQDPawCfMPcWI1lFPHl8eTmn64mgpaPPLvClMg2xpJGZ5FsLkz1la
         sG7CT+UNfn0LFUKvne2NiIMf6oOi3cxYQh9vHQK/FSEm31bLuQ7JlZ9f44OPlcNipFMp
         Il8CoOIIq5UyOcy3CUDDvLyb+SLs6chQIfkVUhPjSCpP1b45U/0SAxvaoi5Yria4k4gB
         Ok1sdO+W85CE/HlRd0SzYtF4hupPSUIZy1sxuJExAOgpjEpVovEwolPjwXI1RTUTIHaq
         pKxw==
X-Gm-Message-State: AOAM530MiGDnYer+Ad9bc/Ivm9wYZu0e8CYviwvJ/utsFCMg6l9MdLF7
        wcuqzApSmhiEbuV9Dly6rrYsgi/+GVa7gA==
X-Google-Smtp-Source: ABdhPJwqacEcE2fcqaeXHjxHRdOag0lz5OsRxghfEZrVwkpoxoz7Qzg6Bq5HuXlk9vwZKO8b9c0OWFfJIC5Jrw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:2ad0:0:b0:3c1:5f7e:fd78 with SMTP id
 q199-20020a632ad0000000b003c15f7efd78mr20271927pgq.56.1652806030507; Tue, 17
 May 2022 09:47:10 -0700 (PDT)
Date:   Tue, 17 May 2022 09:47:06 -0700
In-Reply-To: <xmqqk0alyqyj.fsf_-_@gitster.g>
Message-Id: <kl6lo7zwhzsl.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <CAN8jHOgwVF5g=jM_KYT0Oh+j+Lk3qvdyA4zNRbzf8e1Xp5WAUw@mail.gmail.com>
 <xmqqczgzdc1r.fsf@gitster.g> <kl6l4k2bpv61.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq1qxfbqtq.fsf@gitster.g> <kl6lczghj7tn.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqpmkg8z58.fsf@gitster.g> <kl6l7d6ljrrg.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq4k1p2v40.fsf@gitster.g> <xmqqwnel1eqb.fsf@gitster.g> <xmqqczgd16wx.fsf_-_@gitster.g>
 <xmqqk0alyqyj.fsf_-_@gitster.g>
Subject: Re: [PATCH v2] fetch: do not run a redundant fetch from submodule
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Benedek Kozma <cyberbeni@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


This version looks good to me, thanks :)

  Reviewed-by: Glen Choo <chooglen@google.com>

Junio C Hamano <gitster@pobox.com> writes:

> t5617 is much cleanly organized than t5526, and we may want to clean
> up the latter after dust settles.

Yeah, t5526 has so many tests for the 'core' functionality that it's
hard to fit something 'tangential' like "--all". I might touch it again
soon, so I'll keep this in mind.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index e3791f09ed..8b15c40bb2 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -2261,7 +2265,17 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  		result = fetch_multiple(&list, max_children);
>  	}
>  
> -	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
> +
> +	/*
> +	 * This is only needed after fetch_one(), which does not fetch
> +	 * submodules by itself.
> +	 *
> +	 * When we fetch from multiple remotes, fetch_multiple() has
> +	 * already updated submodules to grab commits necessary for
> +	 * the fetched history from each remote, so there is no need
> +	 * to fetch submodules from here.
> +	 */
> +	if (!result && remote && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
>  		struct strvec options = STRVEC_INIT;
>  		int max_children = max_jobs;

Looks good; the comment is easier to understand than my suggestion for
sure.

> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index 43dada8544..a301b56db8 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -1125,4 +1125,31 @@ test_expect_success 'fetch --recurse-submodules updates name-conflicted, unpopul
>  	)
>  '
>  
> +test_expect_success 'fetch --all with --recurse-submodules' '
> +	test_when_finished "rm -fr src_clone" &&
> +	git clone --recurse-submodules src src_clone &&
> +	(
> +		cd src_clone &&
> +		git config submodule.recurse true &&
> +		git config fetch.parallel 0 &&
> +		git fetch --all 2>../fetch-log
> +	) &&
> +	grep "^Fetching submodule sub$" fetch-log >fetch-subs &&
> +	test_line_count = 1 fetch-subs
> +'
> +
> +test_expect_success 'fetch --all with --recurse-submodules with multiple' '
> +	test_when_finished "rm -fr src_clone" &&
> +	git clone --recurse-submodules src src_clone &&
> +	(
> +		cd src_clone &&
> +		git remote add secondary ../src &&
> +		git config submodule.recurse true &&
> +		git config fetch.parallel 0 &&
> +		git fetch --all 2>../fetch-log
> +	) &&
> +	grep "Fetching submodule sub" fetch-log >fetch-subs &&
> +	test_line_count = 2 fetch-subs
> +'
> +

Also looks good.
