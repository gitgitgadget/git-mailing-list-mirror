Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F5B51FE90
	for <e@80x24.org>; Tue, 25 Apr 2017 19:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1430727AbdDYTcy (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 15:32:54 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:32861 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S946852AbdDYTcw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 15:32:52 -0400
Received: by mail-pg0-f44.google.com with SMTP id 63so33032287pgh.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 12:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i2qoArafqGTdNuIVm8vvtNXnmrVpgrY07IQVeIjHFB4=;
        b=emjvU+YC//P5RMKDRIh0BQw9I9yDjI9WJH0TfxJjA9hrQ3s1S5cdfr1R8Sl0HHd6Tn
         rui6d9UKCQxFhkTnu69sQYCkGgX6PDVtf496DFrgGt9Ku1d3Q2iyWYd/F4i9sHwURuYM
         4Dhm/FS9D27wWif4IYj/U+ixBkBi0D7TY3SDH/AbptRVkX3hFmp6Ws+MLReFI+7XH4z+
         aWTdoAlD8fI+mMnQrS9hph9xpOoQkSfR+N+fE7U5ztFRtfKskYleEsWsvsg1pdukYuwZ
         nn9tJadI71S3/xznXuXJ1KTQjXNU0RUUsmEQGNI5+ij0GsATCJlrsut3a9SqHeyDqY9y
         DtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i2qoArafqGTdNuIVm8vvtNXnmrVpgrY07IQVeIjHFB4=;
        b=NXKtJb8FZD9dqxpDwAuWIifbyb21YcVax7tm49pzhxBcuFF2rYLQZSncja73UKoXss
         3m3bD+T+NIKirf8IUVw3rE+LXihfamB64ru2OPzbW0RPAdcpVCWGJmjs4uLfX9j28mNm
         SOR4NPewTJVNbyA4OoUBt/nv+tL1LBREBGB0RYEM8g7Z57h8M4fV4mHNdt5Xb+Qnzvc9
         5otSn6O3Hj0FNJCmM9/3OqjD9zLjxhaBwp6k9nO+3UT4qhl+Aq+oMfe58a96wKJpmKJy
         Cchd1ZNry993rssLJHbXT0RdDZLmw19Hu3ZCQVSiUsoQJyk+T2/Nftc20wk1lfIUaz+a
         FJlw==
X-Gm-Message-State: AN3rC/63yGsNSxbtaq3LQ88FF6klVwOwe+jROcwW7RsfWbQjpLkyynFS
        xfbrvNpeHxvL/tBh
X-Received: by 10.84.211.137 with SMTP id c9mr39547850pli.8.1493148772023;
        Tue, 25 Apr 2017 12:32:52 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:3165:1f91:2c02:1f0c])
        by smtp.gmail.com with ESMTPSA id e22sm38119792pgn.11.2017.04.25.12.32.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 12:32:50 -0700 (PDT)
Date:   Tue, 25 Apr 2017 12:32:49 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org,
        sbeller@google.com, e@80x24.org, peff@peff.net,
        Brian Hatfield <bhatfield@google.com>
Subject: Re: [PATCH v7 2/2] run-command: don't try to execute directories
Message-ID: <20170425193249.GD105623@google.com>
References: <20170424235042.26627-1-bmwill@google.com>
 <20170425175446.113553-1-bmwill@google.com>
 <20170425175446.113553-2-bmwill@google.com>
 <20170425185117.GK28740@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170425185117.GK28740@aiede.svl.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/25, Jonathan Nieder wrote:
> Brandon Williams wrote:
> 
> > Subject: run-command: don't try to execute directories
> 
> nit: this is also about non-executable files, now.  That would mean
> something like
> 
>  run-command: don't try to execute directories or non-executable files
> 
> or
> 
>  run-command: restrict PATH search to files we can execute
> 
> [...]
> > Reported-by: Brian Hatfield <bhatfield@google.com>
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  run-command.c          |  2 +-
> >  t/t0061-run-command.sh | 23 +++++++++++++++++++++++
> >  2 files changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/run-command.c b/run-command.c
> > index a97d7bf9f..ec08e0951 100644
> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -137,7 +137,7 @@ static char *locate_in_PATH(const char *file)
> >  		}
> >  		strbuf_addstr(&buf, file);
> >  
> > -		if (!access(buf.buf, F_OK))
> > +		if (is_executable(buf.buf))
> >  			return strbuf_detach(&buf, NULL);
> 
> It's probably worth a docstring for this function to explain
> that this is not a complete emulation of execvp on Windows, since
> it doesn't look for .com and .exe files.
> 
> 
> >  
> >  		if (!*end)
> > diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
> > index 98c09dd98..fd5e43766 100755
> > --- a/t/t0061-run-command.sh
> > +++ b/t/t0061-run-command.sh
> > @@ -37,6 +37,29 @@ test_expect_success !MINGW 'run_command can run a script without a #! line' '
> >  	test_cmp empty err
> >  '
> >  
> > +test_expect_success 'run_command should not try to execute a directory' '
> > +	test_when_finished "rm -rf bin1 bin2 bin3" &&
> > +	mkdir -p bin1/greet bin2 bin3 &&
> > +	write_script bin2/greet <<-\EOF &&
> > +	cat bin2/greet
> > +	EOF
> > +	chmod -x bin2/greet &&
> 
> This probably implies that the test needs a POSIXPERM dependency.
> Should it be a separate test_expect_success case so that the other
> part can still run on Windows?
> 
> The rest looks good.  Thanks for your patient work.
> 
> With whatever subset of the changes described makes sense,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> Thanks.
> 
> diff --git i/run-command.c w/run-command.c
> index ec08e09518..dbbaec932e 100644
> --- i/run-command.c
> +++ w/run-command.c
> @@ -117,6 +117,21 @@ static inline void close_pair(int fd[2])
>  	close(fd[1]);
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
> + * Returns NULL if the command could not be found.
> + *
> + * This should not be used on Windows, where the $PATH search rules
> + * are more complicated (e.g., a search for "foo" should find
> + * "foo.exe").
> + */
>  static char *locate_in_PATH(const char *file)
>  {
>  	const char *p = getenv("PATH");
> diff --git i/t/t0061-run-command.sh w/t/t0061-run-command.sh
> index fd5e43766a..e48a207fae 100755
> --- i/t/t0061-run-command.sh
> +++ w/t/t0061-run-command.sh
> @@ -37,26 +37,33 @@ test_expect_success !MINGW 'run_command can run a script without a #! line' '
>  	test_cmp empty err
>  '
>  
> -test_expect_success 'run_command should not try to execute a directory' '
> +test_expect_success 'run_command does not try to execute a directory' '
>  	test_when_finished "rm -rf bin1 bin2" &&
> -	mkdir -p bin1/greet bin2 bin3 &&
> +	mkdir -p bin1/greet bin2 &&
>  	write_script bin2/greet <<-\EOF &&
>  	cat bin2/greet
>  	EOF
> -	chmod -x bin2/greet &&
> -	write_script bin3/greet <<-\EOF &&
> -	cat bin3/greet
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
>  	EOF
>  
> -	# Test that run-command does not try to execute the "greet" directory in
> -	# "bin1", or the non-executable file "greet" in "bin2", but rather
> -	# correcty executes the "greet" script located in bin3.
> -	(
> -		PATH=$PWD/bin1:$PWD/bin2:$PWD/bin3:$PATH &&
> -		export PATH &&
> -		test-run-command run-command greet >actual 2>err
> -	) &&
> -	test_cmp bin3/greet actual &&
> +	PATH=$PWD/bin1:$PWD/bin2:$PATH \
> +		test-run-command run-command greet >actual 2>err &&
> +	test_cmp bin2/greet actual &&
>  	test_cmp empty err
>  '
>  

Yeah the POSIXPERM is going to be necessary.  I'll roll in some of these
changes when I do a reroll.

-- 
Brandon Williams
