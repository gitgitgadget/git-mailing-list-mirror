Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4D40207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 00:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S979453AbdDYARa (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 20:17:30 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32830 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S979157AbdDYAR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 20:17:28 -0400
Received: by mail-pf0-f194.google.com with SMTP id c198so6865379pfc.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 17:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HMOHiA9ect8mDsZO71HphpRtKCV3hv9vR9AbCiz9heM=;
        b=HCugb502FGGZQ9aFQwZSa5phRjc1hzp5iXPkQNTyOC4C9kJ2ZKFX85lgK3iXFS4tU/
         CsPf+x7FxFPb7DFgjjTDugYt8366+0DeEycKPu4hoy2XCMxa0OaxKRIp773TovpUPslV
         DJItpP3IaPUjsHer8BFbSQ7IntY0njc2XrWHc80Mgd8ylAfiUfI6nKCMr6fcwPqOmBvN
         FJuM8Hj3OuJTLwmO8tCzbvkzIXZofGDlB/SlZJJnC3Cx6k/k4Ny0WslDmNJ1reAZwNGE
         LL63Mdt92B0+3MtPAgC/fMWzAV3elEE//lbsE4V2m16RlAJKI5pA5ajnrZZ1Xg7fdNr5
         Jwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HMOHiA9ect8mDsZO71HphpRtKCV3hv9vR9AbCiz9heM=;
        b=ol6TuYbeWpSytDqGqWA0JDfkzO3xKJ8/8QFj4H5uv8rxG10VoyBzkxqM8djqjl/Njk
         5JhwqBfLz3U6pf+ni1t+8s787xhsDuGDR+Peqnyhrl6+0BhFj7vjVfHK9i3zGecX2gYG
         2XF00XJPuExh0KjSJAeTpWC7fZcNhlbDf5gap6IcHyHRh53K6LeBUJMXsrhQNsB6ah6e
         EI1Z1lgnaFnkdXLV2g3q2+t74So16NP+5rgBfjBgupBh59GQn2h+LybtWzr7hd4btFuz
         vN2HKvPAFQjHS44wiU0tVhMUTZSQLIBKunneQOFLjA0pOebBEBzFBBO0IW8DsALRKS+U
         CG6g==
X-Gm-Message-State: AN3rC/6IfPOMvoT+TQO6/SOBzdLd7szTkf6qTBVjUry8cEmJUXhMxOeY
        gFrYEBm86unuzw==
X-Received: by 10.99.178.80 with SMTP id t16mr26450247pgo.136.1493079447587;
        Mon, 24 Apr 2017 17:17:27 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:85c7:fa47:7aaf:2307])
        by smtp.gmail.com with ESMTPSA id w5sm20781896pfd.23.2017.04.24.17.17.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 17:17:26 -0700 (PDT)
Date:   Mon, 24 Apr 2017 17:17:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org,
        sbeller@google.com, e@80x24.org, peff@peff.net
Subject: Re: [PATCH v6 12/11] run-command: don't try to execute directories
Message-ID: <20170425001724.GG28740@aiede.svl.corp.google.com>
References: <20170424223752.GB105623@google.com>
 <20170424235042.26627-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170424235042.26627-1-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> In some situations run-command will incorrectly try (and fail) to
> execute a directory instead of an executable.  For example:
>
> Lets suppose a user has PATH=~/bin (where 'bin' is a directory) and they
> happen to have another directory inside 'bin' named 'git-remote-blah'.
> Then git tries to execute the directory:
>
> 	$ git ls-remote blah://blah
> 	fatal: cannot exec 'git-remote-blah': Permission denied
>
> This is due to only checking 'access()' when locating an executable in
> PATH, which doesn't distinguish between files and directories.  Instead
> use 'stat()' and check that the path is to a regular file.  Now
> run-command won't try to execute the directory 'git-remote-blah':
>
> 	$ git ls-remote blah://blah
> 	fatal: Unable to find remote helper for 'blah'
>
> Signed-off-by: Brandon Williams <bmwill@google.com>

For the interested, the context in which this was reported was trying
to execute a directory named 'ssh'.  Thanks for a quick fix.

Technically this bug has existed since

	commit 38f865c27d1f2560afb48efd2b7b105c1278c4b5
	Author: Jeff King <peff@peff.net>
	Date:   Fri Mar 30 03:52:18 2012 -0400

	   run-command: treat inaccessible directories as ENOENT

Until we switched from using execvp to execve, the symptom was very
subtle: it only affected the error message when a program could not be
found, instead of affecting functionality more substantially.

[...]
> --- a/run-command.c
> +++ b/run-command.c
> @@ -127,6 +127,7 @@ static char *locate_in_PATH(const char *file)
>  
>  	while (1) {
>  		const char *end = strchrnul(p, ':');
> +		struct stat st;
>  
>  		strbuf_reset(&buf);
>  
> @@ -137,7 +138,7 @@ static char *locate_in_PATH(const char *file)
>  		}
>  		strbuf_addstr(&buf, file);
>  
> -		if (!access(buf.buf, F_OK))
> +		if (!stat(buf.buf, &st) && S_ISREG(st.st_mode))
>  			return strbuf_detach(&buf, NULL);

Should this share code with help.c's is_executable()?

I suppose not, since that would have trouble finding scripts without
the executable bit set.

I was momentarily nervous about what happens if this gets run on
Windows. This is just looking for a file's existence, not
executability, so it should be fine.

> --- a/t/t0061-run-command.sh
> +++ b/t/t0061-run-command.sh
> @@ -37,6 +37,13 @@ test_expect_success !MINGW 'run_command can run a script without a #! line' '
>  	test_cmp empty err
>  '
>  
> +test_expect_success 'run_command should not try to execute a directory' '
> +	test_when_finished "rm -rf bin/blah" &&
> +	mkdir -p bin/blah &&
> +	PATH=bin:$PATH test_must_fail test-run-command run-command blah 2>err &&

Two nits:

- this environment variable setting leaks past the test_must_fail
  invocation in some shells.  When running external comments, they
  update the environment after forking, but when running shell
  functions, they update the environment first and never set it back.

  A search with "git grep -e '=.* test_must_fail'" finds no other
  instances of this pattern, so apparently we've done a good job of
  being careful about that. *surprised*  t/check-non-portable-shell.pl
  doesn't check for this.  Perhaps it should.

  Standard workarounds:

  	(
		PATH=... &&
		export PATH &&
		test_must_fail ...
	)

  or

	test_must_fail env PATH=... ...

- using a relative path (other than '.') in $PATH feels unusual.  We
  can mimic a typical user setup more closely by using "$PWD/bin". 

> +	test_i18ngrep "No such file or directory" err

This string comes from libc.  Is there some other way to test for
what this patch does?

E.g. how about something like the following?

Thanks,
Jonathan

diff --git i/t/t0061-run-command.sh w/t/t0061-run-command.sh
index 30c4ad75ff..68cd0a8072 100755
--- i/t/t0061-run-command.sh
+++ w/t/t0061-run-command.sh
@@ -38,10 +38,16 @@ test_expect_success !MINGW 'run_command can run a script without a #! line' '
 '
 
 test_expect_success 'run_command should not try to execute a directory' '
-	test_when_finished "rm -rf bin/blah" &&
-	mkdir -p bin/blah &&
-	PATH=bin:$PATH test_must_fail test-run-command run-command blah 2>err &&
-	test_i18ngrep "No such file or directory" err
+	test_when_finished "rm -rf bin1 bin2" &&
+	mkdir -p bin1/blah &&
+	mkdir bin2 &&
+	cat hello-script >bin2/blah &&
+	chmod +x bin2/blah &&
+	PATH=$PWD/bin1:$PWD/bin2:$PATH \
+	test-run-command run-command blah >actual 2>err &&
+
+	test_cmp hello-script actual &&
+	test_cmp empty err
 '
 
 test_expect_success POSIXPERM 'run_command reports EACCES' '
