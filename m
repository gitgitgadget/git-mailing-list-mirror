Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AB6C25B0C
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 15:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241410AbiHEPxD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 11:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241286AbiHEPv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 11:51:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10FE2199
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 08:50:12 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so7741957pjz.1
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 08:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=/FVzx5x6QFL5FwBcdH9c6Jx48g3cmfL206XuMkA6Nc4=;
        b=KBWKMLZVZyO7IZ8J2qceU02/ko5GMl9SjaLQr97iXUf3/66i16sFv1QOmT1hxZHNJx
         LMOSFhZrEYAeRsphQI7vH3tzmWjR2rJIakRQKY12L7eODZKFX+avR8Kz2D22xueNUugz
         swQWn+aBhdFfKBkam8WY8L9XIeV2FxDXEqBfJ8vYU1HkrRre5II/KUHtnzvHIkPkx78f
         Av+JIax+oGoi1Smebo/S6zDA9gJ0b3zDdpENLta3PCM7biBXsksLA9GcbZGGmp9S7nwT
         oJUglSKfM3r7CfZZnedg33MEAQW/m2G7apb757b9MGWYVShXti3wDUt+Ct146b84BpWv
         uekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=/FVzx5x6QFL5FwBcdH9c6Jx48g3cmfL206XuMkA6Nc4=;
        b=TBo1v/JaNz95H0elAmXHECkCpBL6mA+5pmasOd2NvmS66IW+uhoBL2mud6qmgDjIQx
         D9mBS4qLu10/JJOrNcIZRnIDviUqrpFdBIJ0N7e3I9qKat9ueFnN0lvlk25OFQXi0nKp
         bEpEjsqFg4J7OrS/j/+NMG4QlIghMYQ6jkpw+NIlqCj9RLoJn0SCNzbKqfGTmFU/Ng2l
         lZkXzs4p6UwGptbpAscRJE+iJIyz5Nx3iEzQa9PltyRP7dM3iqqlYfF/QgyyFuVvz7/Z
         HoBv7InhtL+pwCdTrbJMK2LIzOpltX/j8t60oehqQWIbh5fyOFRId5pYea1Ol3xiMd/S
         I/cw==
X-Gm-Message-State: ACgBeo3+JoAWzPRc6hi8vNsMDJ6BmzSdsQS/KVGcPr8fySgdHnZXvalo
        Es4UKqu5hPM/bYpof6Tf07o=
X-Google-Smtp-Source: AA6agR6fBThN1xd7+KyDKz735jrWoWdgP9fqaa6a0z+yGDgFYWloBPLZkbi3dpirMZjd5dwMk4hTcQ==
X-Received: by 2002:a17:902:6b47:b0:16c:e5cc:f006 with SMTP id g7-20020a1709026b4700b0016ce5ccf006mr7349569plt.105.1659714612168;
        Fri, 05 Aug 2022 08:50:12 -0700 (PDT)
Received: from localhost ([113.172.46.62])
        by smtp.gmail.com with ESMTPSA id 20-20020a621414000000b0052e57ed8cdasm3152211pfu.55.2022.08.05.08.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 08:50:11 -0700 (PDT)
Date:   Fri, 5 Aug 2022 22:50:08 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ilya K <me@0upti.me>
Subject: Re: [PATCH] hook API: don't segfault on strbuf_addf() to NULL "out"
Message-ID: <Yu08MCCoGwTxeM+g@danh.dev>
References: <0015309-00f1-9b44-023c-001ee3f242e4@0upti.me>
 <patch-1.1-2450e3e65cf-20220805T141402Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-2450e3e65cf-20220805T141402Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-08-05 16:15:33+0200, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Fix a logic error in a082345372e (hook API: fix v2.36.0 regression:
> hooks should be connected to a TTY, 2022-06-07). When it started using
> the "ungroup" API added in fd3aaf53f71 (run-command: add an "ungroup"
> option to run_process_parallel(), 2022-06-07) it should have made the
> same sort of change that fd3aaf53f71 itself made in
> "t/helper/test-run-command.c".
> 
> The correct way to emit this "Couldn't start" output with "ungroup"
> would be:
> 
> 	fprintf(stderr, _("Couldn't start hook '%s'\n"), hook_path);
> 
> But we should instead remove the emitting of this output. As the added
> test shows we already emit output when we can't run the child. The
> "cannot run" output here is emitted by run-command.c's
> child_err_spew().
> 
> So the addition of the "Couldn't start hook" output here in
> 96e7225b310 (hook: add 'run' subcommand, 2021-12-22) was always
> redundant. For the pre-commit hook we'll now emit exactly the same
> output as we did before f443246b9f2 (commit: convert
> {pre-commit,prepare-commit-msg} hook to hook.h, 2021-12-22) (and
> likewise for others).
> 
> We could at this point add this to the pick_next_hook() callbacks in
> hook.c:
> 
> 	assert(!out);
> 	assert(!*pp_task_cb);
> 
> And this to notify_start_failure() and notify_hook_finished() (in the
> latter case the parameter is called "pp_task_cp"):
> 
> 	assert(!out);
> 	assert(!pp_task_cb);
> 
> But let's leave any such instrumentation for some eventual cleanup of
> the "ungroup" API.
> 
> Reported-by: Ilya K <me@0upti.me>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> As suspected I needed to bounce this off the CI once to due to the
> OS-specific messaging around failed hooks, it passes now:
> https://github.com/avar/git/actions/runs/2802782493
> 
>  hook.c          |  7 -------
>  t/t1800-hook.sh | 26 ++++++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/hook.c b/hook.c
> index d113ee7faae..a493939a4fc 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -62,9 +62,6 @@ static int pick_next_hook(struct child_process *cp,
>  	strvec_push(&cp->args, hook_path);
>  	strvec_pushv(&cp->args, hook_cb->options->args.v);
>  
> -	/* Provide context for errors if necessary */
> -	*pp_task_cb = (char *)hook_path;
> -
>  	/*
>  	 * This pick_next_hook() will be called again, we're only
>  	 * running one hook, so indicate that no more work will be
> @@ -80,13 +77,9 @@ static int notify_start_failure(struct strbuf *out,
>  				void *pp_task_cp)
>  {
>  	struct hook_cb_data *hook_cb = pp_cb;
> -	const char *hook_path = pp_task_cp;
>  
>  	hook_cb->rc |= 1;
>  
> -	strbuf_addf(out, _("Couldn't start hook '%s'\n"),
> -		    hook_path);
> -
>  	return 1;
>  }
>  
> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> index 210f4298872..64096adac7e 100755
> --- a/t/t1800-hook.sh
> +++ b/t/t1800-hook.sh
> @@ -151,4 +151,30 @@ test_expect_success TTY 'git commit: stdout and stderr are connected to a TTY' '
>  	test_hook_tty commit -m"B.new"
>  '
>  
> +test_expect_success 'git hook run a hook with a bad shebang' '
> +	test_when_finished "rm -rf bad-hooks" &&
> +	mkdir bad-hooks &&
> +	write_script bad-hooks/test-hook "/bad/path/no/spaces" </dev/null &&
> +
> +	# TODO: We should emit the same (or at least a more similar)
> +	# error on Windows and !Windows. See the OS-specific code in
> +	# start_command()
> +	if test_have_prereq !WINDOWS
> +	then
> +		cat >expect <<-\EOF
> +		fatal: cannot run bad-hooks/test-hook: ...
> +		EOF
> +	else
> +		cat >expect <<-\EOF
> +		error: cannot spawn bad-hooks/test-hook: ...
> +		EOF
> +	fi &&
> +	test_expect_code 1 git \
> +		-c core.hooksPath=bad-hooks \
> +		hook run test-hook >out 2>err &&
> +	test_must_be_empty out &&
> +	sed -e "s/test-hook: .*/test-hook: .../" <err >actual &&

If we're using "sed" here, can we also s/cannot run/cannot spawn/
in order to have the same expectation?

Otherwise, the fix looks sane to me (obviously, since I also suggest
removing the line entirely).

Reviewed-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>

> +	test_cmp expect actual
> +'
> +
>  test_done
> -- 
> 2.37.1.1283.g2c56c4202c5
> 

-- 
Danh
