Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FA8C433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 15:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82EE6613C9
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 15:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbhD0Pqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 11:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbhD0Pqj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 11:46:39 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD4FC061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 08:45:55 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id i3-20020a4ad3830000b02901ef20f8cae8so5850889oos.11
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MzdMjsAXiUF12LwGlKIimMGnjs2JhZmty6ePzzNwK80=;
        b=QEwFlMsowbX1HeDqJtiSsVCuPkZQU7bCgYPvhdzuZ0PVai7zOHNR/Gu6pcIEuxHQ0j
         PEKUi82yWcUqN4R6Y3bR3KTGfK2RIYx9qQpZxlENxqomhB0n86N2AysEtOr0qjJ6Mpt3
         mSJGocp3g53250/fgnRzwLtWWIUhEcM4FzmrmqD+CjwawR8kj5flmsxG5lU5ni+ncWfP
         4z4OX4IOnyrc7YMk0Jg3NvyTnHTuu1qVtlZ/XXgcGYsapaoRJ7NeXPwpGFPC1dRRh1T4
         Mymx65BrgcmZN2CEbf6mlxDGOzlY8MXzOtUg1DtLH2br47gT+/922OFclasYnMHYlP/E
         c0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MzdMjsAXiUF12LwGlKIimMGnjs2JhZmty6ePzzNwK80=;
        b=WeKPogkxmrY/U499k6RNaJG+1qwPJU+PGiU6mEx1PLpQC4qc0UYUnEw1B69i744jWf
         IbVN8lJqe5hLNfnHJkNfU7jYFHHtcB12zy8H/wTsimH3hh3GKUDgAFI2n8tAViDoj6yE
         s3Ps/XKreKlY7Gr/BtbCmeyJjfIE4v0bER3E0u7C9dVvNNXh5Q9L6UOZtXoKKiPDPLHb
         6lJktIzaDSXD4SWH7cHSJycLBMtfo7r25cqRt8Y4MjFdSlGCCNWvEQkra64/3LAPMV3L
         Vqk71GTQeeqUD7AcK8LS5e5n/uoAKK4XzIvR5MO/nO07IXkpwIcJLKkzch3dHUIZ/mwU
         HmhA==
X-Gm-Message-State: AOAM5302YHSrhj0z4m5LH031UWUkXuJGDGY6hCsJvoqZ36RF6O/0Wted
        WisZ0QXlaMwUPmM1LnCNfsE=
X-Google-Smtp-Source: ABdhPJwXO/j3DsvbtpIoHe8z8RQw6x2q96ya06G6jKsC6ERQKUOkzdprAYuokdb5vIZ6Fvp2+mpaMw==
X-Received: by 2002:a4a:4551:: with SMTP id y78mr18340700ooa.33.1619538354372;
        Tue, 27 Apr 2021 08:45:54 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3839:9ece:547d:49e5? ([2600:1700:e72:80a0:3839:9ece:547d:49e5])
        by smtp.gmail.com with ESMTPSA id y11sm55277oiv.19.2021.04.27.08.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 08:45:54 -0700 (PDT)
Subject: Re: [PATCH 22/23] p7519: add fsmonitor--daemon
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <da5094e52032e28337cfcecd421dedb560952869.1617291666.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e44ea355-5e58-bbf4-12a3-7653278da2d6@gmail.com>
Date:   Tue, 27 Apr 2021 11:45:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <da5094e52032e28337cfcecd421dedb560952869.1617291666.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2021 11:41 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Repeat all of the fsmonitor perf tests using `git fsmonitor--daemon` and
> the "Simple IPC" interface.

It would be nice to see some numbers for how this test performs
on some standard Git repositories across Windows and macOS.

> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  t/perf/p7519-fsmonitor.sh | 37 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
> index 5eb5044a103c..2d018bc7d589 100755
> --- a/t/perf/p7519-fsmonitor.sh
> +++ b/t/perf/p7519-fsmonitor.sh
> @@ -24,7 +24,8 @@ test_description="Test core.fsmonitor"
>  # GIT_PERF_7519_SPLIT_INDEX: used to configure core.splitIndex
>  # GIT_PERF_7519_FSMONITOR: used to configure core.fsMonitor. May be an
>  #   absolute path to an integration. May be a space delimited list of
> -#   absolute paths to integrations.
> +#   absolute paths to integrations.  (This hook or list of hooks does not
> +#   include the built-in fsmonitor--daemon.)
>  #
>  # The big win for using fsmonitor is the elimination of the need to scan the
>  # working directory looking for changed and untracked files. If the file
> @@ -135,10 +136,16 @@ test_expect_success "one time repo setup" '
>  
>  setup_for_fsmonitor() {
>  	# set INTEGRATION_SCRIPT depending on the environment
> -	if test -n "$INTEGRATION_PATH"
> +	if test -n "$USE_FSMONITOR_DAEMON"
>  	then
> +		git config core.useBuiltinFSMonitor true &&
> +		INTEGRATION_SCRIPT=false
> +	elif test -n "$INTEGRATION_PATH"
> +	then
> +		git config core.useBuiltinFSMonitor false &&
>  		INTEGRATION_SCRIPT="$INTEGRATION_PATH"
>  	else
> +		git config core.useBuiltinFSMonitor false &&
>  		#
>  		# Choose integration script based on existence of Watchman.
>  		# Fall back to an empty integration script.
> @@ -285,4 +292,30 @@ test_expect_success "setup without fsmonitor" '
>  test_fsmonitor_suite
>  trace_stop
>  
> +#
> +# Run a full set of perf tests using the built-in fsmonitor--daemon.
> +# It does not use the Hook API, so it has a different setup.
> +# Explicitly start the daemon here and before we start client commands
> +# so that we can later add custom tracing.
> +#
> +
> +test_lazy_prereq HAVE_FSMONITOR_DAEMON '
> +	git version --build-options | grep "feature:" | grep "fsmonitor--daemon"
> +'

Here you do create the prereq. Let's put this into t/test-lib.sh
or t/test-lib-functions.sh, whichever is more appropriate.

> +
> +if test_have_prereq HAVE_FSMONITOR_DAEMON
> +then
> +	USE_FSMONITOR_DAEMON=t
> +
> +	trace_start fsmonitor--daemon--server
> +	git fsmonitor--daemon --start
> +
> +	trace_start fsmonitor--daemon--client
> +	test_expect_success "setup for fsmonitor--daemon" 'setup_for_fsmonitor'

Maybe this is copied from the rest of the file, but we should probably
use the standard layout for tests here:

	test_expect_success 'setup for fsmonitor--daemon' '
		setup_for_fsmonitor
	'

> +	test_fsmonitor_suite
> +
> +	git fsmonitor--daemon --stop
> +	trace_stop
> +fi
> +

Thanks,
-Stolee
