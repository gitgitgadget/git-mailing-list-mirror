Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A35D2207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 02:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S980127AbdDYC5n (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 22:57:43 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35630 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S980113AbdDYC5k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 22:57:40 -0400
Received: by mail-it0-f65.google.com with SMTP id 70so1329961ita.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 19:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YZR7HLsy/oDnIrSKXUIlknz/wxk6xw4RqTGkXLlNVtU=;
        b=PmMfFnxaW17fl3Tna3cnpz7fyoI9VoBDK826qLyD9+Mv/IPHRdHab9EBUqiCSxeR7P
         DNiPuhbufeQXyLHRx9SoioXlSChQ62/IC84eyeCeGrMtNrmt2PchyOkhlDJcEISRXesB
         FPct6d9Wszdg/pEBkYM0bRffFroNAHHKmUouq3ytXdaEP/aoVt6Vg/J+5fdNfv6X55xF
         6KYWRe2bzsSU3vx0mvr0OZ22bt8upMYC5eXUr44oSbKs2vp6I25ei9iFXzvd5H59XmdT
         xBQD5qCpx/7C1pdPMLHUI7Sg2Y/W9ySpmV9baL4GgY7x6IV55ywMAjEiBnc1BHcEZOnn
         B5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YZR7HLsy/oDnIrSKXUIlknz/wxk6xw4RqTGkXLlNVtU=;
        b=JQKcoDvtUkBOF2/VD7L+6IAU6nGDD0g9Ytzen1fBSAvdoaNPi+4c3foJ31KodwQLqg
         wtnBY8E5idS7+SAw1acnPvdb2Hr/lZd5MTj+CkMqMkdxhctbaw+HXQALzL3rK54CjX+f
         I51XD/CKD54HwS0yE7OlvistwxYD4039rbVclwrrO9HljyGpm1IqWw/vE7LzwYEzVIMr
         Kr3sH5r0rlFKuDG316e6lvENppwDJ53AWCBhr9cNIr6G8GS8cGNlZgSPMfmSwbYtRnZs
         p32aQV4VR1IlLtni1I1rOUkTnpUDVuWMjGygKz28e60Ai4caEP8NPcOnbZ/AOF6KOnsp
         9g9A==
X-Gm-Message-State: AN3rC/71zGSlh7ITC3x/09KbvqAKhbA9fFrYXJThsf08FU8eGnBvhq75
        bO0hOtR8XlsBOw==
X-Received: by 10.36.118.75 with SMTP id z72mr18483736itb.33.1493089059281;
        Mon, 24 Apr 2017 19:57:39 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:85c7:fa47:7aaf:2307])
        by smtp.gmail.com with ESMTPSA id 123sm8957834iow.28.2017.04.24.19.57.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 19:57:38 -0700 (PDT)
Date:   Mon, 24 Apr 2017 19:57:36 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org,
        sbeller@google.com, e@80x24.org,
        Brian Hatfield <bhatfield@google.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 12/11] run-command: don't try to execute directories
Message-ID: <20170425025735.GI28740@aiede.svl.corp.google.com>
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

(cc-ing the reporter)
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

Reported-by: Brian Hatfield <bhatfield@google.com>

This was observed by having a directory called "ssh" in $PATH before
the real ssh and trying to use ssh protoccol.  Thanks for catching it.

> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  run-command.c          | 3 ++-
>  t/t0061-run-command.sh | 7 +++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/run-command.c b/run-command.c
> index a97d7bf9f..ece0bf342 100644
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
>  
>  		if (!*end)
> diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
> index 98c09dd98..30c4ad75f 100755
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
> +	test_i18ngrep "No such file or directory" err
> +'
> +
>  test_expect_success POSIXPERM 'run_command reports EACCES' '
>  	cat hello-script >hello.sh &&
>  	chmod -x hello.sh &&
