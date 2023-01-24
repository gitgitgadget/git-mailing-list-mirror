Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4347C54E94
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 17:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjAXRwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 12:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjAXRwX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 12:52:23 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137E449439
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 09:52:22 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id m11so3955896pji.0
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 09:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2u+iTOASIgA5/1rEuy7cxU/WvtAOFNXir4JIyQs0RQ=;
        b=d4PkqbkLXKG5B+5ADzTOUzdDc8jVMHS+85EZuTnJ7AJoqE5+FYLP12y4RVImkkvs8p
         FfzSVn+BQ2TGC2+5N/FqNJAz581pQlwOqjYYRAG6vWZTaWRLYIMzjrU0IIJeYDtWdPq6
         7MsLmd+oN8hK6HIwxl/BsN35w16nZjDWam6VmEQjEy1xbETZVahPPFRN+U62JzF3Gle2
         8hoCmRBdf069K8mDrPRTZVvEH5SWhyq8SujQaHMzzVJW2ezTkvYtXuET+/yzyywWK+SV
         CJuHYNNpM4QX+pcMFp7ixze6v8sTPQ6R7QqwTCiaYkyTDZD8zrkjijC/mH/xsjjbJTHb
         nIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B2u+iTOASIgA5/1rEuy7cxU/WvtAOFNXir4JIyQs0RQ=;
        b=vqnqOaqmpyufW1q5H/n7BUlj22pICP3TmlGwDgQKqMa9NX/bmbe+XCOsC4KDXCcBXR
         Wmqku5+Xq9HqjJLyc20vwlbSz/NWWKOY62vTx9TNGk4Koylr4fxjeYW+8Mrh6wYIPH9A
         aAOc5FlP31TqW51AEew4Appsv2nj2odMwMiS2YHQaK3CnTrBiSQH80Y9VXxmLS/VftxB
         JrTMahai4c5sxEWZ/nFUwwCSpM/gtOBztnFBIJFHMYsi1Nvo0buMdbw0/mrjTaZQ+mXR
         9zDMbKxS/DoWNBQt2AuYJEgLwApOW9+Oca6NNvouFiPwVF1zvOAL29jKo0yk/YYLn3Dt
         GVOA==
X-Gm-Message-State: AFqh2kqpesTaayzUAlrbFNf30ZKotspWOUThfBpueD/uqgrnkO7skhV4
        D0G2ibh0k0EQ5FSQYfztLcg=
X-Google-Smtp-Source: AMrXdXuOmkst8bKwb3R0cp2qHQ1VBQyi2qRoKJzbItyJkf0wZ6+WOqzyPfR3979pauMIE1FCXvXy+w==
X-Received: by 2002:a17:902:b48f:b0:189:b4d0:aee with SMTP id y15-20020a170902b48f00b00189b4d00aeemr26808921plr.67.1674582741448;
        Tue, 24 Jan 2023 09:52:21 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902bd8900b0019339f3368asm1986355pls.3.2023.01.24.09.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 09:52:21 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Adam Szkoda via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Adam Szkoda <adaszko@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH v2] ssh signing: better error message when key not in agent
References: <pull.1270.git.git.1674029874363.gitgitgadget@gmail.com>
        <pull.1270.v2.git.git.1674573972087.gitgitgadget@gmail.com>
Date:   Tue, 24 Jan 2023 09:52:20 -0800
In-Reply-To: <pull.1270.v2.git.git.1674573972087.gitgitgadget@gmail.com> (Adam
        Szkoda via GitGitGadget's message of "Tue, 24 Jan 2023 15:26:11
        +0000")
Message-ID: <xmqq1qnjhlbf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Adam Szkoda via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Adam Szkoda <adaszko@gmail.com>
>
> When signing a commit with a SSH key, with the private key missing from
> ssh-agent, a confusing error message is produced:
>
>     error: Load key
>     "/var/folders/t5/cscwwl_n3n1_8_5j_00x_3t40000gn/T//.git_signing_key_tmpkArSj7":
>     invalid format? fatal: failed to write commit object
>
> The temporary file .git_signing_key_tmpkArSj7 created by git contains a
> valid *public* key.  The error message comes from `ssh-keygen -Y sign' and
> is caused by a fallback mechanism in ssh-keygen whereby it tries to
> interpret .git_signing_key_tmpkArSj7 as a *private* key if it can't find in
> the agent [1].  A fix is scheduled to be released in OpenSSH 9.1. All that
> needs to be done is to pass an additional backward-compatible option -U to
> 'ssh-keygen -Y sign' call.  With '-U', ssh-keygen always interprets the file
> as public key and expects to find the private key in the agent.
>
> As a result, when the private key is missing from the agent, a more accurate
> error message gets produced:
>
>     error: Couldn't find key in agent
>
> [1] https://bugzilla.mindrot.org/show_bug.cgi?id=3429
>
> Signed-off-by: Adam Szkoda <adaszko@gmail.com>
> ---

Well explained.

> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1270/radicle-dev/maint-v2
> Pull-Request: https://github.com/git/git/pull/1270
>
> Range-diff vs v1:
>
>  1:  0ce06076242 < -:  ----------- ssh signing: better error message when key not in agent
>  -:  ----------- > 1:  03dfca79387 ssh signing: better error message when key not in agent

This is a fairly useless range-diff.

Even when a range-diff shows the differences in the patches,
mechanically generated range-diff can only show _what_ changed.  It
is helpful to explain the changes in your own words to highlight
_why_ such changes are done, and this place after the "---" line
and the diffstat we see below is the place to do so.

Does GitGitGadget allow its users to describe the differences since
the previous iteration yourself?

>  gpg-interface.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index f877a1ea564..33899a450eb 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -998,6 +998,7 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
>  	char *ssh_signing_key_file = NULL;
>  	struct strbuf ssh_signature_filename = STRBUF_INIT;
>  	const char *literal_key = NULL;
> +	int literal_ssh_key = 0;
>  
>  	if (!signing_key || signing_key[0] == '\0')
>  		return error(
> @@ -1005,6 +1006,7 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
>  
>  	if (is_literal_ssh_key(signing_key, &literal_key)) {
>  		/* A literal ssh key */
> +		literal_ssh_key = 1;
>  		key_file = mks_tempfile_t(".git_signing_key_tmpXXXXXX");
>  		if (!key_file)
>  			return error_errno(
> @@ -1036,11 +1038,14 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
>  	}
>  
>  	strvec_pushl(&signer.args, use_format->program,
> -		     "-Y", "sign",
> -		     "-n", "git",
> -		     "-f", ssh_signing_key_file,
> -		     buffer_file->filename.buf,
> -		     NULL);
> +			"-Y", "sign",
> +			"-n", "git",
> +			"-f", ssh_signing_key_file,
> +			NULL);

Please avoid making a pointless indentation change like this.  We do
not pass filename yet with this pushl(), because ...

> +	if (literal_ssh_key) {
> +		strvec_push(&signer.args, "-U");
> +	}

... when we give a literal key, we want to insert "-U" in front, and then

> +	strvec_push(&signer.args, buffer_file->filename.buf);

... the filename.  Which makes sense.

The insertion of "-U" is a single statement as the body of a if()
statement.  We do not want {} around it, by the way.

Other than that, nicely done.  Thanks.

>  	sigchain_push(SIGPIPE, SIG_IGN);
>  	ret = pipe_command(&signer, NULL, 0, NULL, 0, &signer_stderr, 0);
>
> base-commit: 844ede312b4e988881b6e27e352f469d8ab80b2a
