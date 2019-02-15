Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE8AC1F453
	for <e@80x24.org>; Fri, 15 Feb 2019 18:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403918AbfBOS7g (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 13:59:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35628 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390758AbfBOS7g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 13:59:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id t18so11461647wrx.2
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 10:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=H3phb8IakjilYa3UPvlOGsmvvYzSUw+8aHQT4EFm2PM=;
        b=kJP3tH6cJflQ31g6XC5RhQFa9KLpUWwJV14KGM7A86h+HcXV0jqbHAF56csv+1vRj0
         tHog2qW3jy73f8BUtoYE4cKWaY+2rHM5SOXQ4fI314PvxmIuhQHIbSbx/TQNCKw46vRh
         HocJhFHyy0mLJ38OHVuSOSfawfVmsIIIZ7Lv6ZxwM89q2/9mRW6p79zIj5Z8W3yunSRY
         M+Sp70A6MpBU7+s7MeEBBKQDLuq1LadU1uMry+9pWJ9jvyzrWift0Wi8YXLJGriH6SvV
         yDZAId2nEZyIjxt/wfM4tat4IVeWmnzfcjBOHoh5nUExFo4pgBb9DKozbod+28plcmwu
         hgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=H3phb8IakjilYa3UPvlOGsmvvYzSUw+8aHQT4EFm2PM=;
        b=CxaQ9MAC35DFIMkhhMidBBLrl0nnvDKvSPKsxVVOR9ac4KlqAHD5/u9+21CYuir5wA
         S2ZC87Cz2MxOHUmhJZOjsaxi82wGh4tJ4/wYPGEbx/3poIoyW2UgmasmI5oW5ComLv0E
         nmrm84BzUzZxsTEWeesWQJ0JrB6sTqLWPD2wCL1bQJhKJdkYouSp5KRVBI5tK4CWhFFE
         Hjt/BdaGmbH9sXP7TQsLFkJxMjSSboJ/iikjPhi6mucdh1Gskv/3AkfE9NLgaH0WkCk2
         cvxRiyVej3I2EtJz0KljDIAS57txqxVkM3ak+9hoiM06LmaOa+RmR/9OXAJ3LdQb3Yc0
         iRpQ==
X-Gm-Message-State: AHQUAuazMnyQSJ3SIOrI2En0CZzj/G5v0nIt4XKwrne2aNtq2XCxmlX0
        7piwLKKAa1yiZQ1mtfBaPblINcFf
X-Google-Smtp-Source: AHgI3IYODPIfCgf3vUGieCN4W01y0F2/0iIzm2Yd8S18vbbBKdWLKuqEXQjG0w+j/jf8gOyqE602Vg==
X-Received: by 2002:adf:b68a:: with SMTP id j10mr8262819wre.224.1550257174021;
        Fri, 15 Feb 2019 10:59:34 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o12sm3547910wrp.70.2019.02.15.10.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 10:59:33 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] worktree: fix worktree add race.
References: <429046b2c9f02c5e4f0af88db51f6c0c099f08a9.1550254374.git.msuchanek@suse.de>
Date:   Fri, 15 Feb 2019 10:59:33 -0800
In-Reply-To: <429046b2c9f02c5e4f0af88db51f6c0c099f08a9.1550254374.git.msuchanek@suse.de>
        (Michal Suchanek's message of "Fri, 15 Feb 2019 19:16:11 +0100")
Message-ID: <xmqq8syg6foq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Suchanek <msuchanek@suse.de> writes:

> Git runs a stat loop to find a worktree name that's available and then does
> mkdir on the found name. Turn it to mkdir loop to avoid another invocation of
> worktree add finding the same free name and creating the directory first.

Yeah, relying on the atomicity of mkdir(2) is much saner approach
than "check -- ah we can use the name -- try to create" that is race
prone.

Thanks for working on this.

> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  builtin/worktree.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 3f9907fcc994..e1a2a56c03c5 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -268,10 +268,9 @@ static int add_worktree(const char *path, const char *refname,
>  	struct strbuf sb_git = STRBUF_INIT, sb_repo = STRBUF_INIT;
>  	struct strbuf sb = STRBUF_INIT;
>  	const char *name;
> -	struct stat st;
>  	struct child_process cp = CHILD_PROCESS_INIT;
>  	struct argv_array child_env = ARGV_ARRAY_INIT;
> -	int counter = 0, len, ret;
> +	int counter = 1, len, ret;
>  	struct strbuf symref = STRBUF_INIT;
>  	struct commit *commit = NULL;
>  	int is_branch = 0;
> @@ -295,19 +294,21 @@ static int add_worktree(const char *path, const char *refname,
>  	if (safe_create_leading_directories_const(sb_repo.buf))
>  		die_errno(_("could not create leading directories of '%s'"),
>  			  sb_repo.buf);
> -	while (!stat(sb_repo.buf, &st)) {
> +
> +	while (mkdir(sb_repo.buf, 0777)) {
>  		counter++;
> +		if(!counter) break; /* don't loop forever */
>  		strbuf_setlen(&sb_repo, len);
>  		strbuf_addf(&sb_repo, "%d", counter);

Style:

		if (!counter)
			break; /* don't loop forever */

More importantly, how long would it take to loop thru all possible
integers (can be simulated by making the parent directory
unwritable)?  Don't we want to cut off with more conservative upper
limit, say 1000 rounds or even 100 rounds or so?

Also, is the behaviour for a signed integer wrapping around due to
getting incremented too many times well defined?  I'd feel safer,
especially if you are willing to spin for 4 billion times like this
patch does, if you changed the counter to "unsigned int".

I see you changed "counter" to start from 1, but that would mean
that these fallback names would start with suffix 2, not 1.  Which
would look funny.

I would have expected ".1", ".2", etc.  as suffix, but the original
used "1", "2", etc. so I won't complain on the format, but I do find
it questionable to start counting from 2.

>  	}
> +	if (!counter)
> +		die_errno(_("could not create directory of '%s'"), sb_repo.buf);

It would have saved reviewer's time if this die() were inside the
loop where you punted with "break".

>  	name = strrchr(sb_repo.buf, '/') + 1;
>  
>  	junk_pid = getpid();
>  	atexit(remove_junk);
>  	sigchain_push_common(remove_junk_on_signal);
>  
> -	if (mkdir(sb_repo.buf, 0777))
> -		die_errno(_("could not create directory of '%s'"), sb_repo.buf);
>  	junk_git_dir = xstrdup(sb_repo.buf);
>  	is_junk = 1;
