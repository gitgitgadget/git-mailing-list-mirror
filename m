Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 426D51FE90
	for <e@80x24.org>; Tue, 25 Apr 2017 18:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1951723AbdDYSvY (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 14:51:24 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34135 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948142AbdDYSvV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 14:51:21 -0400
Received: by mail-pf0-f195.google.com with SMTP id g23so12044258pfj.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 11:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xvmHY6xtpy/48FE7obr9HsSivd60stC3Z+qQ9MgUSrw=;
        b=jMAJ4fdVBZ0iz7ijKc96zTQxSMY01FymzGDcz6mALTLv4MIyfqUh2dyl9LsUHLdyks
         25v0Zd0SPSy6OW5e/bmkLFBe3RGhOciEhfiKUzFwJjNKovMKs3XMZOV/Un7Fo7pA0+CZ
         L1sbTZxeMOayqSlvvbAQB/p+UhBBpSDmJlf19JiUYuJUBN4EVPNDbJRlMajGLnthTnOE
         qaKlp9LyAbM6s5VaG9gRjlZeawmPxVvPg1SMU0GrF14kRBv79TLgG3lzzWtfwXMAiaIt
         vs+wW7NOeGKo2nQYcG7NZUubWJ5RRA8ybeVY7NOI9Wu7JON0j1x4RNcIMoeN6Sh9UiOo
         172w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xvmHY6xtpy/48FE7obr9HsSivd60stC3Z+qQ9MgUSrw=;
        b=bzq3b4j1jTG7VnexMsL++cWcyI6iAsXiQ2Hxs9oPsaKpALc1oQL0EAlFz4sgqTvq9N
         MwvCp3DUoTzyDWvxg7HVOL40WivCYSMvMhRELZ7Y+5Oj07zfhS0K8lYqn5l/2O+gJw//
         mw5+naM8kV6ZWRQ7hCwdk5GS1fA9riWZDQXQoHdk6S4SaHWRDTs43lkDoUBb2H/ZuUvH
         MopgKe3lOp/hUI5DCBvhPXx1sliJGnbWGtSYddqUcVPlvGUVlN9zZUmw621KgY0AyYZb
         N4WT4T81ENhjEZ0xEJlwZoTFd3d4jGK9+C4DLn2ONxSi5swReEOBeEaZN2YmrrBVvXjH
         1FVw==
X-Gm-Message-State: AN3rC/6ULlXLqOhx50JiURmAF0z2TWz1fAsMPrCrZhyyvl9z1vWvJHW8
        9BXvmjePRpKevQ==
X-Received: by 10.98.112.134 with SMTP id l128mr7080714pfc.161.1493146280783;
        Tue, 25 Apr 2017 11:51:20 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:c0ea:3a03:d3a7:cb53])
        by smtp.gmail.com with ESMTPSA id d82sm37845612pfl.124.2017.04.25.11.51.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 11:51:19 -0700 (PDT)
Date:   Tue, 25 Apr 2017 11:51:17 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org,
        sbeller@google.com, e@80x24.org, peff@peff.net,
        Brian Hatfield <bhatfield@google.com>
Subject: Re: [PATCH v7 2/2] run-command: don't try to execute directories
Message-ID: <20170425185117.GK28740@aiede.svl.corp.google.com>
References: <20170424235042.26627-1-bmwill@google.com>
 <20170425175446.113553-1-bmwill@google.com>
 <20170425175446.113553-2-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170425175446.113553-2-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> Subject: run-command: don't try to execute directories

nit: this is also about non-executable files, now.  That would mean
something like

 run-command: don't try to execute directories or non-executable files

or

 run-command: restrict PATH search to files we can execute

[...]
> Reported-by: Brian Hatfield <bhatfield@google.com>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  run-command.c          |  2 +-
>  t/t0061-run-command.sh | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/run-command.c b/run-command.c
> index a97d7bf9f..ec08e0951 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -137,7 +137,7 @@ static char *locate_in_PATH(const char *file)
>  		}
>  		strbuf_addstr(&buf, file);
>  
> -		if (!access(buf.buf, F_OK))
> +		if (is_executable(buf.buf))
>  			return strbuf_detach(&buf, NULL);

It's probably worth a docstring for this function to explain
that this is not a complete emulation of execvp on Windows, since
it doesn't look for .com and .exe files.


>  
>  		if (!*end)
> diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
> index 98c09dd98..fd5e43766 100755
> --- a/t/t0061-run-command.sh
> +++ b/t/t0061-run-command.sh
> @@ -37,6 +37,29 @@ test_expect_success !MINGW 'run_command can run a script without a #! line' '
>  	test_cmp empty err
>  '
>  
> +test_expect_success 'run_command should not try to execute a directory' '
> +	test_when_finished "rm -rf bin1 bin2 bin3" &&
> +	mkdir -p bin1/greet bin2 bin3 &&
> +	write_script bin2/greet <<-\EOF &&
> +	cat bin2/greet
> +	EOF
> +	chmod -x bin2/greet &&

This probably implies that the test needs a POSIXPERM dependency.
Should it be a separate test_expect_success case so that the other
part can still run on Windows?

The rest looks good.  Thanks for your patient work.

With whatever subset of the changes described makes sense,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

diff --git i/run-command.c w/run-command.c
index ec08e09518..dbbaec932e 100644
--- i/run-command.c
+++ w/run-command.c
@@ -117,6 +117,21 @@ static inline void close_pair(int fd[2])
 	close(fd[1]);
 }
 
+/*
+ * Search $PATH for a command.  This emulates the path search that
+ * execvp would perform, without actually executing the command so it
+ * can be used before fork() to prepare to run a command using
+ * execve() or after execvp() to diagnose why it failed.
+ *
+ * The caller should ensure that file contains no directory
+ * separators.
+ *
+ * Returns NULL if the command could not be found.
+ *
+ * This should not be used on Windows, where the $PATH search rules
+ * are more complicated (e.g., a search for "foo" should find
+ * "foo.exe").
+ */
 static char *locate_in_PATH(const char *file)
 {
 	const char *p = getenv("PATH");
diff --git i/t/t0061-run-command.sh w/t/t0061-run-command.sh
index fd5e43766a..e48a207fae 100755
--- i/t/t0061-run-command.sh
+++ w/t/t0061-run-command.sh
@@ -37,26 +37,33 @@ test_expect_success !MINGW 'run_command can run a script without a #! line' '
 	test_cmp empty err
 '
 
-test_expect_success 'run_command should not try to execute a directory' '
+test_expect_success 'run_command does not try to execute a directory' '
 	test_when_finished "rm -rf bin1 bin2" &&
-	mkdir -p bin1/greet bin2 bin3 &&
+	mkdir -p bin1/greet bin2 &&
 	write_script bin2/greet <<-\EOF &&
 	cat bin2/greet
 	EOF
-	chmod -x bin2/greet &&
-	write_script bin3/greet <<-\EOF &&
-	cat bin3/greet
+
+	PATH=$PWD/bin1:$PWD/bin2:$PATH \
+		test-run-command run-command greet >actual 2>err &&
+	test_cmp bin2/greet actual &&
+	test_cmp empty err
+'
+
+test_expect_success POSIXPERM 'run_command passes over non-executable file' '
+	test_when_finished "rm -rf bin1 bin2" &&
+	mkdir -p bin1 bin2 &&
+	write_script bin1/greet <<-\EOF &&
+	cat bin1/greet
+	EOF
+	chmod -x bin1/greet &&
+	write_script bin2/greet <<-\EOF &&
+	cat bin2/greet
 	EOF
 
-	# Test that run-command does not try to execute the "greet" directory in
-	# "bin1", or the non-executable file "greet" in "bin2", but rather
-	# correcty executes the "greet" script located in bin3.
-	(
-		PATH=$PWD/bin1:$PWD/bin2:$PWD/bin3:$PATH &&
-		export PATH &&
-		test-run-command run-command greet >actual 2>err
-	) &&
-	test_cmp bin3/greet actual &&
+	PATH=$PWD/bin1:$PWD/bin2:$PATH \
+		test-run-command run-command greet >actual 2>err &&
+	test_cmp bin2/greet actual &&
 	test_cmp empty err
 '
 
