Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78148207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 01:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S979692AbdDYBrD (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 21:47:03 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32862 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S979634AbdDYBrC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 21:47:02 -0400
Received: by mail-pg0-f65.google.com with SMTP id 63so7815468pgh.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 18:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2tnpGf1ZEnJpkGMXFDbd59+xVTyBsmTvkktoiVNIrys=;
        b=FE3E5D20MgyfkzkrevEBxlyg5kGrLA4YBkvHF6jY+aUJrPFPH9K8g9YM5wZh5bYIv3
         gkUJsQfFK/iQ39vN+WPcLKIw0VonDMWu5X8Z5BKbw0yEYtLueyxlmQy8h01ebHbOL2NV
         6MDG8bmxvZfb2DcT+gVWQa8YK4JZJa6BxU/SNctps3a2+ALSbCQArpfjWQUUBahuC8WN
         XA3HkNEi5hbAXpNWAvoawNC+g+nQHenxkcMwRUu9uAef0dhmrQSb57HfBqr4GtRvZVQZ
         +FDqHbDqXoGDFLZWlW+nydyqASKLJP3VCJdRRxVDLPaj2LYiaOnlB5Fy7TeeR8x7dav6
         Zn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2tnpGf1ZEnJpkGMXFDbd59+xVTyBsmTvkktoiVNIrys=;
        b=KNrit9nat7Y7q5uVg4Niu7KPoDBRz64JBOXO5F6p/cbW9XL7J2eO5G4GKM8JbkoAAP
         5HrtqkDIDRSHvqNrVuUnlTplR7HNQha5X70nsiwAhCc+joASn2+bDyhUzKEblYku1A3O
         NQm5CBFlXStBMmOZUAFLjwTIZETmWZ+aQTmxfQyUzg5JllIu3W7EEzdGQsYzmWFDlBmz
         kyZKvccnDHPBYVvon0RLInBoSuf+ppCP1J2ywi3xaN1BbGm/4JgLmfKi+r7ejwelEqYb
         v6Nr3utIA+y5p2oEbWIQSjs42R8Af61Ou3StmZWjr4Vw3myLJ4aOPksR3S/QhB4/Vx7z
         2l4A==
X-Gm-Message-State: AN3rC/4hL5XzNHdoRWnrAvJ7TYNHtE9v9lbEYpEoAwyGJYbhPc/c6ROk
        tC3+f6KZ2cWsj4NJNNI=
X-Received: by 10.98.196.88 with SMTP id y85mr27012735pff.49.1493084821437;
        Mon, 24 Apr 2017 18:47:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:894:a17f:b6e3:25e8])
        by smtp.gmail.com with ESMTPSA id n15sm32835279pfj.18.2017.04.24.18.47.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 18:47:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, j6t@kdbg.org, sbeller@google.com, e@80x24.org,
        jrnieder@gmail.com
Subject: Re: [PATCH v6 12/11] run-command: don't try to execute directories
References: <20170424223752.GB105623@google.com>
        <20170424235042.26627-1-bmwill@google.com>
Date:   Mon, 24 Apr 2017 18:47:00 -0700
In-Reply-To: <20170424235042.26627-1-bmwill@google.com> (Brandon Williams's
        message of "Mon, 24 Apr 2017 16:50:42 -0700")
Message-ID: <xmqqvaptxnqj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> This is due to only checking 'access()' when locating an executable in
> PATH, which doesn't distinguish between files and directories.  Instead
> use 'stat()' and check that the path is to a regular file.  Now
> run-command won't try to execute the directory 'git-remote-blah':
>
> 	$ git ls-remote blah://blah
> 	fatal: Unable to find remote helper for 'blah'

The above is not a very interesting example.  

More important is that $PATH may have a directory with
git-remote-blah directory (your setup above) and then another
directory with the git-remote-blah executable that the user wanted
to use.  Without this change, we won't get to the real one, and that
makes this change truly valuable.

The added test demostrates the "uninteresting" behaviour.  Even
though it is correct and technically sufficient, it would make it
more relevant to do something like this:

	mkdir -p bin/blah bin2 &&
	write_script bin2/blah <<-\EOF &&
	echo We found blah in bin2
	EOF
	PATH=bin:$PATH test_must_fail ... what you have
	...
	PATH=bin:bin2:$PATH test-run-command run-command blah >actual &&
	bin2/blah >expect &&
	test_cmp expect actual

as the point of locate_in_PATH() is to successfully find one,
without getting confused by an earlier unusable one.

Thanks.

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
