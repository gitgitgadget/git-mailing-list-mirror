Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 145F1207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 23:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1953674AbdDYXu1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 19:50:27 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33357 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970610AbdDYXuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 19:50:25 -0400
Received: by mail-pg0-f66.google.com with SMTP id 63so14133383pgh.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 16:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kqVslBi00n11811YJECbL+lrnwpJJwIbxj3E5yP/X+U=;
        b=N+U1nJkGpoQoTipzDqFWq0M1MMc/CYu5RNZRyvGLltO7UZceW1GA9HalNNwPN2J9PC
         MpbY42vC6XsLRCEeNUgR1SxCM2D4vN/QNMdTbnKBTtQfV4q9wMBgRwtyFocaquXodxJM
         Yv7poZ1aWM9SKlIBQmUjgsSTm/mdT275FLjxZCKLdNkt8wcUuA8gv98PQj24ERlYjGZ2
         i8uQCRYdE+ViGqTqAwtXxdJl0/RQCjQFmbnVRThbqgNsDjTWRY13mVBhj9JSXgvaqMLO
         OcgjEmADx8DH2c+LTOYb3RHeLSmjYqC8nn4j79IQIzICY31y8K0cgmWQTZCIzw6Th5eg
         5t5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kqVslBi00n11811YJECbL+lrnwpJJwIbxj3E5yP/X+U=;
        b=b1r9BOEL7NxrgxOHg4wbFk5X77fACqKF7Y50MXknS1304UtIDU+YLGPKqE9nAlhSCH
         uiiqJldhOXjcnCnMxfJNhVEFzReey/s7OINWhSUjkVl7w9AaGD4Tczxo7BVKSwsCDeFH
         fPDIm9VesU2UqTw318BDSoY441x5zkM3Y/hBB43ctMtgfJweWO7oAMpxle8IA1/VVYlv
         p3Wdpd3AfJf97bfSuE+EipzcWIyxcT19hoRR/80eKxHGeWs/maRMdUIwkocE90NMgqVi
         Pu7u9csxPK7Ro5aa1qcu+BFrpbPUp2asrSnxOGcE/2dzdRsndm4xssCK/BNQG3NudEFw
         NE6Q==
X-Gm-Message-State: AN3rC/4htqtW+j72uCEjN7aHS+dbCpbNUE4q2tBzq/NebZRinbDYOPZK
        CkDZ1QZCHHqSng==
X-Received: by 10.98.129.193 with SMTP id t184mr30166555pfd.130.1493164224851;
        Tue, 25 Apr 2017 16:50:24 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:c0ea:3a03:d3a7:cb53])
        by smtp.gmail.com with ESMTPSA id z5sm38317925pff.73.2017.04.25.16.50.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 16:50:24 -0700 (PDT)
Date:   Tue, 25 Apr 2017 16:50:22 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org,
        sbeller@google.com, e@80x24.org, peff@peff.net,
        Brian Hatfield <bhatfield@google.com>
Subject: Re: [PATCH v8 2/2] run-command: restrict PATH search to executable
 files
Message-ID: <20170425235022.GR28740@aiede.svl.corp.google.com>
References: <20170425175446.113553-1-bmwill@google.com>
 <20170425234700.194277-1-bmwill@google.com>
 <20170425234700.194277-2-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170425234700.194277-2-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> In some situations run-command will incorrectly try (and fail) to
> execute a directory instead of an executable file.  This was observed by
> having a directory called "ssh" in $PATH before the real ssh and trying
> to use ssh protoccol, reslting in the following:
>
> 	$ git ls-remote ssh://url
> 	fatal: cannot exec 'ssh': Permission denied
>
> It ends up being worse and run-command will even try to execute a
> non-executable file if it preceeds the executable version of a file on
> the PATH.  For example, if PATH=~/bin1:~/bin2:~/bin3 and there exists a
> directory 'git-hello' in 'bin1', a non-executable file 'git-hello' in
> bin2 and an executable file 'git-hello' (which prints "Hello World!") in
> bin3 the following will occur:
>
> 	$ git hello
> 	fatal: cannot exec 'git-hello': Permission denied
>
> This is due to only checking 'access()' when locating an executable in
> PATH, which doesn't distinguish between files and directories.  Instead
> use 'is_executable()' which check that the path is to a regular,
> executable file.  Now run-command won't try to execute the directory or
> non-executable file 'git-hello':
>
> 	$ git hello
> 	Hello World!
>
> Reported-by: Brian Hatfield <bhatfield@google.com>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  run-command.c          | 19 ++++++++++++++++++-
>  t/t0061-run-command.sh | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+), 1 deletion(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.  Patch left unsnipped for reference.

> diff --git a/run-command.c b/run-command.c
> index 2ffbd7e67..9e36151bf 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -159,6 +159,23 @@ int is_executable(const char *name)
>  	return st.st_mode & S_IXUSR;
>  }
>  
> +/*
> + * Search $PATH for a command.  This emulates the path search that
> + * execvp would perform, without actually executing the command so it
> + * can be used before fork() to prepare to run a command using
> + * execve() or after execvp() to diagnose why it failed.
> + *
> + * The caller should ensure that file contains no directory
> + * separators.
> + *
> + * Returns the path to the command, as found in $PATH or NULL if the
> + * command could not be found.  The caller inherits ownership of the memory
> + * used to store the resultant path.
> + *
> + * This should not be used on Windows, where the $PATH search rules
> + * are more complicated (e.g., a search for "foo" should find
> + * "foo.exe").
> + */
>  static char *locate_in_PATH(const char *file)
>  {
>  	const char *p = getenv("PATH");
> @@ -179,7 +196,7 @@ static char *locate_in_PATH(const char *file)
>  		}
>  		strbuf_addstr(&buf, file);
>  
> -		if (!access(buf.buf, F_OK))
> +		if (is_executable(buf.buf))
>  			return strbuf_detach(&buf, NULL);
>  
>  		if (!*end)
> diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
> index 98c09dd98..e4739170a 100755
> --- a/t/t0061-run-command.sh
> +++ b/t/t0061-run-command.sh
> @@ -37,6 +37,36 @@ test_expect_success !MINGW 'run_command can run a script without a #! line' '
>  	test_cmp empty err
>  '
>  
> +test_expect_success 'run_command does not try to execute a directory' '
> +	test_when_finished "rm -rf bin1 bin2" &&
> +	mkdir -p bin1/greet bin2 &&
> +	write_script bin2/greet <<-\EOF &&
> +	cat bin2/greet
> +	EOF
> +
> +	PATH=$PWD/bin1:$PWD/bin2:$PATH \
> +		test-run-command run-command greet >actual 2>err &&
> +	test_cmp bin2/greet actual &&
> +	test_cmp empty err
> +'
> +
> +test_expect_success POSIXPERM 'run_command passes over non-executable file' '
> +	test_when_finished "rm -rf bin1 bin2" &&
> +	mkdir -p bin1 bin2 &&
> +	write_script bin1/greet <<-\EOF &&
> +	cat bin1/greet
> +	EOF
> +	chmod -x bin1/greet &&
> +	write_script bin2/greet <<-\EOF &&
> +	cat bin2/greet
> +	EOF
> +
> +	PATH=$PWD/bin1:$PWD/bin2:$PATH \
> +		test-run-command run-command greet >actual 2>err &&
> +	test_cmp bin2/greet actual &&
> +	test_cmp empty err
> +'
> +
>  test_expect_success POSIXPERM 'run_command reports EACCES' '
>  	cat hello-script >hello.sh &&
>  	chmod -x hello.sh &&
