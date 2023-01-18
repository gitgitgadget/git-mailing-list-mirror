Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF4BC38147
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 11:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjARL4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 06:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjARLxj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 06:53:39 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EB76B9B1
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 03:10:10 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id mp20so35746265ejc.7
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 03:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/wTqrtEMmKcp2a4K/hTx8OwOer9Gw5oohNyZ+bM7QLM=;
        b=Wz3f7P/2VXIMJQhbXfGWLktN9firikBf0YxNKtGAG551x9APRi2M8b7fRmqAI8PD8d
         X+owt++UXI69oQJAGZhGJ9MLc/juuoCPcABYbPQ0/bRP3EgY0BJ+cJ5O8VLDtG2Du5zH
         fZ/Q3lZifP1rhCvEJfV3aTPBF+cU/dP8MSOdd0debvrxOo4rIy33dUs57jgKwzoUmJZV
         nLaLSfvsmlEQluM/g2xNAN94R6HAlqbQEyBnL1rTbV3meoJ31tw/nmMz+7l6zektUHEO
         MhwPQ8P5kfsjbOuistJ1SPY5DAABZoktazG8SCcGyuzfZt57ItpJKWWjFd6aK5Fr9nUA
         o4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wTqrtEMmKcp2a4K/hTx8OwOer9Gw5oohNyZ+bM7QLM=;
        b=IZO9yYcfpPIIZhEr7n1qQKVbC3Pr9x4cYinOtThT8iqtG7tskZiyIL9oQrY3nfibSm
         3YYdJElxWNs5fRyNmUvWDS+XQYgf9fJNfW7bFNkPvyODr7iICOmAV/VtuDkM8aJlj56O
         8TxLwoOwaJOC4OFMYyoQqMBulnr49rNmuDPDeoVo2U9pllQOH8QPiOS4C+m7dNUYQC/L
         M/5h4RqOhcABiYqK1ZuBpRa06SDPy4mHmbdUUcfOluq2LZ+vDnl4rgo0a1PYO5Ly2zDo
         umsCiXY23/i+3r4yz5ELZ2Gss2jXTL2Euz60/N78Nib02k21Pd5+X9mmys/WJ5W9YWoV
         9ueg==
X-Gm-Message-State: AFqh2kr4RvxtCfYsMWMxyU/zNcuf/0Ti/3bAatyl2aWj9LEvQ5AxznOP
        sdOI6/Q02WSrcTXOIoxF2W9SzsPJyY8=
X-Google-Smtp-Source: AMrXdXvkrw4gyqJpEWOyYs7P1s46l4MLCZ0mwfTTA9CFAnEDYPZUXM8wWr+iOvoo52qu65YnYofTdw==
X-Received: by 2002:a17:906:80d:b0:870:d15a:c2e0 with SMTP id e13-20020a170906080d00b00870d15ac2e0mr6162258ejd.51.1674040209317;
        Wed, 18 Jan 2023 03:10:09 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id 20-20020a170906101400b0085ff05d5dbdsm9013498ejm.173.2023.01.18.03.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 03:10:08 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <abec912c-065d-2098-962e-41f9646dd046@dunelm.org.uk>
Date:   Wed, 18 Jan 2023 11:10:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] ssh signing: better error message when key not in agent
Content-Language: en-US
To:     Adam Szkoda via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Adam Szkoda <adaszko@gmail.com>
References: <pull.1270.git.git.1674029874363.gitgitgadget@gmail.com>
In-Reply-To: <pull.1270.git.git.1674029874363.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Adam

On 18/01/2023 08:17, Adam Szkoda via GitGitGadget wrote:
> From: Adam Szkoda <adaszko@gmail.com>
> 
> When signing a commit with a SSH key, with the private key missing from
> ssh-agent, a confusing error message is produced:
> 
>      error: Load key
>      "/var/folders/t5/cscwwl_n3n1_8_5j_00x_3t40000gn/T//.git_signing_key_tmpkArSj7":
>      invalid format? fatal: failed to write commit object
> 
> The temporary file .git_signing_key_tmpkArSj7 created by git contains a
> valid *public* key.  The error message comes from `ssh-keygen -Y sign' and
> is caused by a fallback mechanism in ssh-keygen whereby it tries to
> interpret .git_signing_key_tmpkArSj7 as a *private* key if it can't find in
> the agent [1].  A fix is scheduled to be released in OpenSSH 9.1. All that
> needs to be done is to pass an additional backward-compatible option -U to
> 'ssh-keygen -Y sign' call.  With '-U', ssh-keygen always interprets the file
> as public key and expects to find the private key in the agent.

The documentation for user.signingKey says

  If gpg.format is set to ssh this can contain the path to either your 
private ssh key or the public key when ssh-agent is used.

If I've understood correctly passing -U will prevent users from setting 
this to a private key.

Best Wishes

Phillip

> As a result, when the private key is missing from the agent, a more accurate
> error message gets produced:
> 
>      error: Couldn't find key in agent
> 
> [1] https://bugzilla.mindrot.org/show_bug.cgi?id=3429
> 
> Signed-off-by: Adam Szkoda <adaszko@gmail.com>
> ---
>      ssh signing: better error message when key not in agent
>      
>      When signing a commit with a SSH key, with the private key missing from
>      ssh-agent, a confusing error message is produced:
>      
>      error: Load key "/var/folders/t5/cscwwl_n3n1_8_5j_00x_3t40000gn/T//.git_signing_key_tmpkArSj7": invalid format?
>      fatal: failed to write commit object
>      
>      
>      The temporary file .git_signing_key_tmpkArSj7 created by git contains a
>      valid public key. The error message comes from `ssh-keygen -Y sign' and
>      is caused by a fallback mechanism in ssh-keygen whereby it tries to
>      interpret .git_signing_key_tmpkArSj7 as a private key if it can't find
>      in the agent [1]. A fix is scheduled to be released in OpenSSH 9.1. All
>      that needs to be done is to pass an additional backward-compatible
>      option -U to 'ssh-keygen -Y sign' call. With '-U', ssh-keygen always
>      interprets the file as public key and expects to find the private key in
>      the agent.
>      
>      As a result, when the private key is missing from the agent, a more
>      accurate error message gets produced:
>      
>      error: Couldn't find key in agent
>      
>      
>      [1] https://bugzilla.mindrot.org/show_bug.cgi?id=3429
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1270%2Fradicle-dev%2Fmaint-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1270/radicle-dev/maint-v1
> Pull-Request: https://github.com/git/git/pull/1270
> 
>   gpg-interface.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 280f1fa1a58..4a5913ae942 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -1022,6 +1022,7 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
>   	strvec_pushl(&signer.args, use_format->program,
>   		     "-Y", "sign",
>   		     "-n", "git",
> +		     "-U",
>   		     "-f", ssh_signing_key_file,
>   		     buffer_file->filename.buf,
>   		     NULL);
> 
> base-commit: e54793a95afeea1e10de1e5ad7eab914e7416250
