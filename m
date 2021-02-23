Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDADC433E6
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 12:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C235E60233
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 12:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhBWM0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 07:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbhBWM0j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 07:26:39 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94330C06174A
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 04:25:59 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id a2so6100011qtw.12
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 04:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DsQc3NNkT6L3zAHqQaqCiCHjXhnTWX41y2rsyLzRjQA=;
        b=G3fQLOogbcBbE5EbpbkGp7srsMqNm4Gdm+aUtGUENsUCRTzSRCclhmJQHP8hpt70qI
         1O/tDBgapXeq7gbYyM6dBA3ok3BMwhGT5cOSIAx72W+IcaYKpNscL+lGrdMzSc+4VTy4
         A1ZuMs/+s9kpmNdWNvXKvjpMTmYEk5kk2mFPCcHjyWYE4pksyKlpoTF/9iN/ibyJDsIN
         wiiob9J90y4sBT+/XKjrUpBEYcCRtJUxC3v9b9fo8sFKLK6Y2hdPTY44rPR2jxUVpWrm
         0JKq+BpLEkjBCwVfwN4I4xYdmA6UhvI5js89byffpe+MOWDtxfdAr9TIZflX6tWKtWoi
         rC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DsQc3NNkT6L3zAHqQaqCiCHjXhnTWX41y2rsyLzRjQA=;
        b=CoD5s5tScN0fE7uQJFy8yG1gHuEFGIcEYPOlccEdHYZzNZ9PLsG9ITlqNteGOQ5fey
         23rRjP/yX4hQqdGDZr7EVu4GvCvDjnEbO4DnVlOW6T+j79Shq5bW94DhH8Jtj45VQpcc
         irU1qbXVQvsigMflGbbZAT20Z4sXA4M5K/dDuCD6cQ2FXGH6lyu93C38PvDuHSV5Q0/t
         WdzF45yPLX5bq2+KwARMB7lhGHB92m/tcastrhAweXuszeNOQ1Nv+sVY571sYUTiz3q1
         HqT5/WENuz5/u3isBst7hXQD4OMZLsHXQq2BdqBsLyJwDgfQovGcxCsEOKfbnipTe8tl
         5LdA==
X-Gm-Message-State: AOAM533IjVIVMOKenOUdwCrxkdjX0jDDVsbCFCTZ8n24EAHng432+4Gd
        86eA1ozl9gulw5fNC5QdcM0=
X-Google-Smtp-Source: ABdhPJxh5+3DOSvhgwb8fl1Ma8CXfYD99gsRSS8Abh5OZIvdPzENirRzoUCTml58rWI6xdizK4dc/w==
X-Received: by 2002:ac8:5c44:: with SMTP id j4mr24341741qtj.124.1614083158578;
        Tue, 23 Feb 2021 04:25:58 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:6088:7f39:fed7:63ad? ([2600:1700:e72:80a0:6088:7f39:fed7:63ad])
        by smtp.gmail.com with UTF8SMTPSA id c7sm13130373qtm.60.2021.02.23.04.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 04:25:58 -0800 (PST)
Message-ID: <5653230a-20c2-321f-7ea0-93ce59858532@gmail.com>
Date:   Tue, 23 Feb 2021 07:25:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH] maintenance: fix incorrect `maintenance.repo` path with
 bare repository
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Cc:     Clement Moyroud <clement.moyroud@gmail.com>
References: <20210223073107.40675-1-sunshine@sunshineco.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20210223073107.40675-1-sunshine@sunshineco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2021 2:31 AM, Eric Sunshine wrote:
> The periodic maintenance tasks configured by `git maintenance start`
> invoke `git for-each-repo` to run `git maintenance run` on each path
> specified by the multi-value global configuration variable
> `maintenance.repo`. Because `git for-each-repo` will likely be run
> outside of the repositories which require periodic maintenance, it is
> mandatory that the repository paths specified by `maintenance.repo` are
> absolute.
> 
> Unfortunately, however, `git maintenance register` does nothing to
> ensure that the paths it assigns to `maintenance.repo` are indeed
> absolute, and may in fact -- especially in the case of a bare repository
> -- assign a relative path to `maintenance.repo` instead. Fix this
> problem by converting all paths to absolute before assigning them to
> `maintenance.repo`.
> 
> While at it, also fix `git maintenance unregister` to convert paths to
> absolute, as well, in order to ensure that it can correctly remove from
> `maintenance.repo` a path assigned via `git maintenance register`.

Thanks for the report and the fix!

> +static char *get_maintpath(void)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	const char *p = the_repository->worktree ?
> +		the_repository->worktree : the_repository->gitdir;
> +
> +	strbuf_realpath(&sb, p, 1);
> +	return strbuf_detach(&sb, NULL);
> +}
> +

This looks right.

>  static int maintenance_register(void)
>  {
> +	int rc;
>  	char *config_value;
>  	struct child_process config_set = CHILD_PROCESS_INIT;
>  	struct child_process config_get = CHILD_PROCESS_INIT;
> +	char *maintpath = get_maintpath();

I'm sorry that this diff looks more complicated than seems necessary,
but your creation of the "done:" label is important for cleaning up
the string. Thanks.

> +test_expect_success 'register and unregister bare repo' '
> +	test_when_finished "git config --global --unset-all maintenance.repo || :" &&
> +	test_might_fail git config --global --unset-all maintenance.repo &&
> +	git init --bare barerepo &&
> +	(
> +		cd barerepo &&
> +		git maintenance register &&
> +		git config --get --global --fixed-value maintenance.repo "$(pwd)" &&

I'm concerned about this test passing on Windows, but if the CI build is happy,
then I'm happy.

> +		git maintenance unregister &&
> +		test_must_fail git config --global --get-all maintenance.repo
> +	)
> +'

Thanks!

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
