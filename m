Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EA5C433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 22:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349840AbiEPW4i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 18:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349806AbiEPW4h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 18:56:37 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D87327CE3
        for <git@vger.kernel.org>; Mon, 16 May 2022 15:56:35 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id c4-20020a170902c2c400b0015f16fb4a54so8668570pla.22
        for <git@vger.kernel.org>; Mon, 16 May 2022 15:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AM2z1Q3KiFVEQWxduOAAswJQId41/4jZR91PmQ0Y0jM=;
        b=FpZVOgKev0dno6Gn6BiYq3rho4tyQw/rEUt502wXC2rAgkP83Gn8W7ti24o6SYrJPn
         EqPrwavx0CMuqJEH/NmIzcPnpDdegkfXp7qbpSDgis5EY+8NRynNgJ9JM1m0F06I6C1E
         dFl/nOMnhYr9XOX4gBiZ9Dbno1n4aDdyjKfcq2HpI4vP1ze3AvdKtsYkhbBuSCJzrO8e
         742lOxOtJvOtkfCqezMOC0s8Suoy03pDK5V5Jv4qG/OdI+7lpn3Ww6OdrZm+2heNEbYD
         8yhMczN2Ju3cxlPRr/x0NxWANROt5gx/rChqcvlX3O4zOXWn2lkDmOgNkHsA9IXJtMcL
         D0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AM2z1Q3KiFVEQWxduOAAswJQId41/4jZR91PmQ0Y0jM=;
        b=VlGHL0qqxlrjS5ejs5viuMHnW9RZOs8mw1jBsoTO1vLJDbVqcf2ynVd23qWF/Fxyse
         Mmt23PT/BzyGKyPDAFH7ttQ2xNwESoVrcoqU2/uZ82oh5VlR+vJ9moEROmgc8jLNDxtz
         75NR6vq4YuVk4y8wQ9aUl5RQT55vHtiUv4xdYgY9NjmrNcfmxkS6JT5/93e+/Np3B2wr
         HyVSCgZUkIJ8XXKOB4L2NgS8M5XPrr5BPkH53TdCgVm5irSqawWTmZfJQvIen3Nl6/UF
         y0uHBi+ev57aaSFHSyKTjxPlzFI1AUyT8EqxFlRC2AllJ3kTNpDF9lWdChLbbv/6IW3M
         cIrQ==
X-Gm-Message-State: AOAM531wEcltXmaHbEpFrk9RDGA9ihx6KUZfGmyjbHfMEwemDrgipXPe
        J+4LBySbD07SKtGKNIutqBASUrWgcj7C+g==
X-Google-Smtp-Source: ABdhPJyC9Bs6XMMgXwI5V7zXWAG5KEO9N5UVuJlFuDq+eEYDqRTZDjeIZVVsjgZzzf1v3gtFo0A4EYaCcs5XIg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:e848:b0:161:a1a0:740b with SMTP
 id t8-20020a170902e84800b00161a1a0740bmr1513782plg.60.1652741794876; Mon, 16
 May 2022 15:56:34 -0700 (PDT)
Date:   Mon, 16 May 2022 15:56:26 -0700
In-Reply-To: <xmqqczgd16wx.fsf_-_@gitster.g>
Message-Id: <kl6lr14thysl.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <CAN8jHOgwVF5g=jM_KYT0Oh+j+Lk3qvdyA4zNRbzf8e1Xp5WAUw@mail.gmail.com>
 <xmqqczgzdc1r.fsf@gitster.g> <kl6l4k2bpv61.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq1qxfbqtq.fsf@gitster.g> <kl6lczghj7tn.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqpmkg8z58.fsf@gitster.g> <kl6l7d6ljrrg.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq4k1p2v40.fsf@gitster.g> <xmqqwnel1eqb.fsf@gitster.g> <xmqqczgd16wx.fsf_-_@gitster.g>
Subject: Re: [PATCH] fetch: do not run a redundant fetch from submodule
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Benedek Kozma <cyberbeni@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index e3791f09ed..359321e731 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -2187,6 +2187,10 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  		else if (argc > 1)
>  			die(_("fetch --all does not make sense with refspecs"));
>  		(void) for_each_remote(get_one_remote_for_fetch, &list);
> +
> +		/* no point doing fetch_multiple() of one */
> +		if (list.nr == 1)
> +			remote = remote_get(list.items[0].string);
>  	} else if (argc == 0) {
>  		/* No arguments -- use default remote */
>  		remote = remote_get(NULL);
> @@ -2261,7 +2265,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  		result = fetch_multiple(&list, max_children);
>  	}
>  
> -	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
> +	if (!result && remote && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
>  		struct strvec options = STRVEC_INIT;
>  		int max_children = max_jobs;

IMO "&& remote" is non-inuitive enough to warrant a comment, e.g.

  /* do not update submodules if fetch_multiple() was called */
  if (!result && remote && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {

but I suppose that the commit message explains this well enough.

> diff --git a/t/t5617-clone-submodules-remote.sh b/t/t5617-clone-submodules-remote.sh
> index ca8f80083a..8b6b482a39 100755
> --- a/t/t5617-clone-submodules-remote.sh
> +++ b/t/t5617-clone-submodules-remote.sh
> @@ -72,6 +72,19 @@ test_expect_success 'clone with --single-branch' '
>  	)
>  '
>  
> +test_expect_success 'fetch --all with --recurse-submodules' '
> +	test_when_finished "rm -fr super_clone" &&
> +	git clone --recurse-submodules srv.bare super_clone &&
> +	(
> +		cd super_clone &&
> +		git config submodule.recurse true &&
> +		git config fetch.parallel 0 &&
> +		git fetch --all 2>../fetch-log
> +	) &&
> +	grep "Fetching sub" fetch-log >fetch-subs &&
> +	test_line_count = 1 fetch-subs
> +'
> +

The test looks good, but I think it belongs in
t/t5526-fetch-submodules.sh. I don't see anything else in
t5617-clone-submodules-remote.sh that calls "git fetch".

In addition, I think we need one more test that adds another remote. In
the above test, we only have one remote, so we hit your new optimization
and already pass the test without the need for "&& remote".

Whereas this test fails if we remove "&& remote".

  test_expect_success 'fetch --all with --recurse-submodules and more remotes' '
    test_when_finished "rm -fr super_clone" &&
    git clone --recurse-submodules srv.bare super_clone &&
    cp -r srv.bare srv.bare2 &&
    (
      cd super_clone &&
      git config submodule.recurse true &&
      git config fetch.parallel 0 &&
      git remote add other ../srv.bare2 &&
      git fetch --all 2>../fetch-log
    ) &&
    grep "Fetching sub" fetch-log >fetch-subs &&
    test_line_count = 2 fetch-subs
  '
