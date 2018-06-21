Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A9A41F516
	for <e@80x24.org>; Thu, 21 Jun 2018 11:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933299AbeFULxq (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 07:53:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51744 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933130AbeFULxo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 07:53:44 -0400
Received: by mail-wm0-f68.google.com with SMTP id r15-v6so4701493wmc.1
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 04:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p6wiBsIvLf34R4+ZPhONqMmH/DE4g8EBZYGA8h0z+ps=;
        b=vO3YvK2A6/VcqsA40uLhy/moy1nOQBG9ol1eVNuD1tNEIdRdON0iKFx4NNIac/ksYX
         eIAlOIgXgy2Fh7V+klISJdXS2jvg2xmd3ay/JtIMd+HqfoZlg9rYZB1MJsVziBuZyoQz
         F5y4QLwoNlpn3vgEqrRJYJluRhBBPaMgIx1i9lVfsb5bzk/gfzFm4H+94sa8uU3/aPdZ
         gmJrsFlymhP9r3fz9iRW+p/hbYTqmVQiBpYMYsMZBEqpswGoYE3+I1y6wL6QsdMXv/0Z
         yGEhEyFevHYI+mp+ohla0C5Dafv9EduHNUkz7IyGxK6nvW1z4ZHt7PVrq3EWxuMetGxy
         VCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p6wiBsIvLf34R4+ZPhONqMmH/DE4g8EBZYGA8h0z+ps=;
        b=K1KaC5FbbAYNJdskDAgJlQMNaA+ulZuhe2C8PE2b+JUQSW6RisGPIepkmJuWCkWcLa
         dKKGBP+iOcoi4VqGtON6Txf7THIVaNh6hGYuunoHGOQJOKAef0f2gML8eEiIVrXdt75g
         tDXeHWzSGlBhxKOCVTPe15TpkTA7i8DnVRZ9Acn8KnjCiST3OdXZtzvm3YTwoWGwvPof
         L72cqcCDqM9cwN1mzevUYibIcMUzguCtqWsjUYc5M3RA7RK/LsVw5dXF6KoxfE+jpMGF
         yk7ZRdpzGBsOc/9Nzwu8NhiVcRJtnj/j+HGqpVkQbQMrezJLHjG8OcnuZyqEhVFTp3Ej
         qGiw==
X-Gm-Message-State: APt69E07ypilWQp+A3ACZVIMNKGS5AcmtDUPbbNlCL9hhS+nMpC/3okX
        zPEfq3VoGhOOPyzNGFyaqWQ=
X-Google-Smtp-Source: ADUXVKLc1CPSR5NH+FcpO9KGXCJwxcnlGGDQIrbuPETUmk1D+qgrWgRdYabAezVbZlmJ/BtETyopgw==
X-Received: by 2002:a1c:17d4:: with SMTP id 203-v6mr4706329wmx.75.1529582023660;
        Thu, 21 Jun 2018 04:53:43 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-38-233.w86-221.abo.wanadoo.fr. [86.221.117.233])
        by smtp.gmail.com with ESMTPSA id s191-v6sm9804774wmd.27.2018.06.21.04.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 04:53:42 -0700 (PDT)
Subject: Re: [GSoC][PATCH v2 1/3] sequencer: add a new function to silence a
 command, except if it fails.
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>
References: <20180618131844.13408-1-alban.gruin@gmail.com>
 <20180619154421.14999-1-alban.gruin@gmail.com>
 <20180619154421.14999-2-alban.gruin@gmail.com>
 <nycvar.QRO.7.76.6.1806211040430.11870@tvgsbejvaqbjf.bet>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <2dddfef3-843d-5444-c90c-45ac38919882@gmail.com>
Date:   Thu, 21 Jun 2018 13:53:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1806211040430.11870@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Le 21/06/2018 à 11:37, Johannes Schindelin a écrit :
> Hi Alban,
> 
> On Tue, 19 Jun 2018, Alban Gruin wrote:
> 
>> diff --git a/sequencer.c b/sequencer.c
>> index 7cc76332e..9aa7ddb33 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -766,6 +766,29 @@ N_("you have staged changes in your working tree\n"
>>  #define VERIFY_MSG  (1<<4)
>>  #define CREATE_ROOT_COMMIT (1<<5)
>>  
>> +static int run_command_silent_on_success(struct child_process *cmd,
>> +					 unsigned verbose)
>> +{
>> +	struct strbuf buf = STRBUF_INIT;
>> +	int rc;
>> +
>> +	if (verbose)
>> +		return run_command(cmd);
>> +
>> +	/* hide stderr on success */
>> +	cmd->stdout_to_stderr = 1;
> 
> This comment is a bit misleading: that line does not hide stderr on
> success, it redirects stdout to stderr instead.
> 
>> +	rc = pipe_command(cmd,
>> +			  NULL, 0,
>> +			  /* stdout is already redirected */
>> +			  NULL, 0,
>> +			  &buf, 0);
>> +
>> +	if (rc)
>> +		fputs(buf.buf, stderr);
>> +	strbuf_release(&buf);
>> +	return rc;
>> +}
>> +
>>  /*
>>   * If we are cherry-pick, and if the merge did not result in
>>   * hand-editing, we will hit this commit and inherit the original
>> @@ -820,18 +843,11 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>>  
>>  	cmd.git_cmd = 1;
>>  
>> -	if (is_rebase_i(opts)) {
>> -		if (!(flags & EDIT_MSG)) {
>> -			cmd.stdout_to_stderr = 1;
>> -			cmd.err = -1;
>> -		}
> 
> This code made sure that we *only* do this redirection, and stderr
> buffering, if `git commit` is called non-interactively. When it is called
> interactively, redirecting stdout and stderr is absolutely not what we
> want.
> 
>> +	if (is_rebase_i(opts) && read_env_script(&cmd.env_array)) {
>> +		const char *gpg_opt = gpg_sign_opt_quoted(opts);
>>  
>> -		if (read_env_script(&cmd.env_array)) {
>> -			const char *gpg_opt = gpg_sign_opt_quoted(opts);
>> -
>> -			return error(_(staged_changes_advice),
>> -				     gpg_opt, gpg_opt);
>> -		}
>> +		return error(_(staged_changes_advice),
>> +			     gpg_opt, gpg_opt);
>>  	}
>>  
>>  	argv_array_push(&cmd.args, "commit");
>> @@ -861,21 +877,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>>  	if (opts->allow_empty_message)
>>  		argv_array_push(&cmd.args, "--allow-empty-message");
>>  
>> -	if (cmd.err == -1) {
>> -		/* hide stderr on success */
>> -		struct strbuf buf = STRBUF_INIT;
>> -		int rc = pipe_command(&cmd,
>> -				      NULL, 0,
>> -				      /* stdout is already redirected */
>> -				      NULL, 0,
>> -				      &buf, 0);
>> -		if (rc)
>> -			fputs(buf.buf, stderr);
>> -		strbuf_release(&buf);
>> -		return rc;
>> -	}
>> -
>> -	return run_command(&cmd);
>> +	return run_command_silent_on_success(&cmd,
>> +					     !(is_rebase_i(opts) && !(flags & EDIT_MSG)));
> 
> It would probably make more sense to change the signature of
> `run_command_silent_on_success()` to not even take the `int verbose`
> parameter: why call it "silent on success" when we can ask it *not* to be
> silent on success?
> 
> And then you can avoid this overly-long line (as well as the quite
> convoluted Boolean logic that took me a couple of seconds to verify) very
> elegantly by this code:
> 
> 	if (is_rebase_i(opts) && !(flags & EDIT_MSG))
> 		return run_command_silent_on_success(&cmd);
> 	return run_command(&cmd);
> 
> I vaguely recall that I wanted to make this an option in the `struct
> child_process` when I originally introduced this code, but I think it was
> Peff who suggested that doing it "by hand" was the more appropriate way
> here because I use it only once.
> 
> My recollection might fail me, but if it is correct, maybe that would be a
> good way forward, to make this an `int silent_on_success:1;` field?
> 

I think I found it:

https://public-inbox.org/git/1e82aeabb906a35175362418b2b4957fae50c3b0.1481642927.git.johannes.schindelin@gmx.de/

Apparently, you wanted to introduce a new RUN_ flag for
run_command_v_opt_cd_env(), but the change was qualified as a “bolted-on
feature” by Johannes Sixt.

So, I will remove the “verbose” argument in the reroll.

Cheers,
Alban

