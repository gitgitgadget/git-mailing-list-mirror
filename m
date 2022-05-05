Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7185C433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 09:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354003AbiEEJoq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 05:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345776AbiEEJoi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 05:44:38 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6A14D60F
        for <git@vger.kernel.org>; Thu,  5 May 2022 02:40:59 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id bg25so2284352wmb.4
        for <git@vger.kernel.org>; Thu, 05 May 2022 02:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MUQIZ9BBLEkGNIanflVGWjFGRWM56zLaDvA9Tyo+C4M=;
        b=haDOf9nshL+aTCv8dfiyK8yiXr4tM+nsIG7WbnOlq00YHhmSKF9Xp3fMx951tOksyx
         /cKsYsJSTLFHsnu+m+Yqj0y0tsartBOPBgYG7mhBCxVA/zKTcaf+r7UH4flqKq1RE59l
         pXNCmVXKWPIegW8YqgrVabDRXfZIPe5c2Q9uhuDHax3K8RRtyuedf6QolUHwvJwBP47a
         89gNxk+3q87QIDrBOlOdeoIvvG1gH9C5JgU0DzPaTuf8VN6cSr2JOAxqV+tsweOocEUk
         MTm4xGq2uUFNnP1Nxi9RVAduA2as5SbgskWEIDRpBm4GiuCcC1jpw7xnbB5E8ScvQxKk
         2ulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MUQIZ9BBLEkGNIanflVGWjFGRWM56zLaDvA9Tyo+C4M=;
        b=37fCuI1QhNCUgjZYHdL2Y8CTOdOu9r3A8g2/w6z6KT+PCc1W5qgC1l9JB1RjMtJErh
         Sv0Tuxjg8SSVO3E15bxNS3mR9cJvqrlT70/vKFGAGx4pWDsv1ZpWA6HT6x3r4EedOxEW
         gzXb9xakarS+6p+amYvVuLLsSROa9FXIeo2K2nBX7A7yamWMIOjABHEXZNnwOQSUEQNw
         QX5vgRxRo5e1/n88mP6b24WaatXkMGf+3nb707DsMsY5wwAvGIK2DqMGlQHG2RFJzC14
         gwpMVxOa/Q6xdwYV5ChFjbu4rySwe6X4EKFY4XqpDS99C550hdb5GVSGoCVPCid+AsFm
         X1XQ==
X-Gm-Message-State: AOAM5304u2Toha2jjn/6/Gv3AclUPod/y8F5/Rky5hbX3wN8fCPqI2we
        lyBP/o1nklICeMj+ntWHodw=
X-Google-Smtp-Source: ABdhPJxKQzd7RRFpQHQE0vxm80W8YPKA0D5JWZo65MyjXZdiZdWexn8IKRzbPANeQUi8TSet0c+9dQ==
X-Received: by 2002:a05:600c:2e08:b0:394:24c:2da4 with SMTP id o8-20020a05600c2e0800b00394024c2da4mr3721303wmf.134.1651743657531;
        Thu, 05 May 2022 02:40:57 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c510700b003942a244f3csm5690692wms.21.2022.05.05.02.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 02:40:56 -0700 (PDT)
Message-ID: <41ec8c09-f31f-46ce-d6ec-4b6fdd78228a@gmail.com>
Date:   Thu, 5 May 2022 10:40:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] setup: tighten ownership checks post CVE-2022-24765
Content-Language: en-GB-large
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, junio@pobox.com
References: <20220504184401.17438-1-carenas@gmail.com>
 <20220505005009.27789-1-carenas@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220505005009.27789-1-carenas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo

On 05/05/2022 01:50, Carlo Marcelo Arenas Belón wrote:
> 8959555cee7 (setup_git_directory(): add an owner check for the top-level
> directory, 2022-03-02), adds a function to check for ownership of
> repositories using a directory that is representative of it (its workdir)
> and ways to add it to an exception list if needed, but that check breaks
> when the ownership of the workdir is not the same than the ownership of
> directory where the configuration and other relevant files reside.
> 
> An attacker could create a git repository in a directory that he has write
> access to but is owned by the victim, and therefore workaround the fix that
> was introduced with CVE-2022-24765 to attack them, like in the following
> scenario which could result in privilege escalation if root then runs a git
> command in that directory or any of its sub directories:
> 
>    $ git -C /tmp init
> 
> To avoid that, extend the ensure_valid_ownership function to be able to
> check for ownership of both the worktree and the gitdir, and use that for
> non bare repositories.

Looking at the code below it now only ever checks the ownership of the 
gitdir, it no longer checks the ownership of the worktree. I haven't 
really thought through what happens if I cd into a worktree added by an 
attacker to a repository that I own which has extentions.worktreeConfig 
set. My initial thought is that if they can add a worktree then they can 
probably edit the repository config anyway but I wonder if an attacker 
can set GIT_COMMON_DIR to a directory where they have write permission 
to add a worktree to a repository where they don't have write permission.

> [...]
> diff --git a/setup.c b/setup.c
> index aad9ace0af9..0fae2d71a3c 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1054,14 +1054,21 @@ static int safe_directory_cb(const char *key, const char *value, void *d)
>   	return 0;
>   }
>   
> -static int ensure_valid_ownership(const char *path)
> +static int ensure_valid_ownership(const char *worktree, const char *gitdir)
>   {
> -	struct safe_directory_data data = { .path = path };
> +	struct safe_directory_data data = { .path = worktree };

We keep checking the worktree path against safe.directory - good.

> +	const char *check_path;
> +
> +	if (gitdir)
> +		check_path = gitdir;
> +	else
> +		check_path = worktree;

We check either the gitdir or worktree but always call this function 
with a non-NULL gitdir so in fact always check that. This code could be 
removed.

>   	if (!git_env_bool("GIT_TEST_ASSUME_DIFFERENT_OWNER", 0) &&
> -	    is_path_owned_by_current_user(path))
> +	    is_path_owned_by_current_user(check_path))

Previously we checked the ownership of the worktree but now we check the 
ownership of the gitdir instead to handle the "git -C /tmp init" case.

>   		return 1;
>   
> +	data.is_safe = 0; /* ensure we are initialized and secure by default */
>   	read_very_early_config(safe_directory_cb, &data);
>   
>   	return data.is_safe;
> @@ -1166,14 +1173,25 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
>   		}
>   		strbuf_setlen(dir, offset);
>   		if (gitdirenv) {
> -			if (!ensure_valid_ownership(dir->buf))
> +			const char *gitdir_to_check = gitdirenv;
> +			struct strbuf gdbuf = STRBUF_INIT;
> +			int ret;
> +
> +			if (!is_absolute_path(gitdirenv)) {
> +				strbuf_addf(&gdbuf, "%s/%s", dir->buf,
> +						gitdirenv);
> +				gitdir_to_check = gdbuf.buf;
> +			}
> +			ret = ensure_valid_ownership(dir->buf, gitdir_to_check);
> +			strbuf_release(&gdbuf);
> +			if (!ret)
>   				return GIT_DIR_INVALID_OWNERSHIP;
>   			strbuf_addstr(gitdir, gitdirenv);
>   			return GIT_DIR_DISCOVERED;
>   		}
>   
>   		if (is_git_directory(dir->buf)) {
> -			if (!ensure_valid_ownership(dir->buf))
> +			if (!ensure_valid_ownership(NULL, dir->buf))

Previously we checked bare repositories against safe.directory now we no 
longer do that as worktree is NULL. If this is intentional it should be 
flagged up in the commit message.

Best Wishes

Phillip

>   				return GIT_DIR_INVALID_OWNERSHIP;
>   			strbuf_addstr(gitdir, ".");
>   			return GIT_DIR_BARE;
> diff --git a/t/t0034-root-safe-directory.sh b/t/t0034-root-safe-directory.sh
> index a68e1d7602b..a3ddebb009a 100755
> --- a/t/t0034-root-safe-directory.sh
> +++ b/t/t0034-root-safe-directory.sh
> @@ -47,6 +47,35 @@ test_expect_success SUDO 'sudo git status as original owner' '
>   	)
>   '
>   
> +test_expect_success SUDO 'unsecure worktree with non bare repository' '
> +	sudo rm -rf root &&
> +	sudo mkdir -p root/t &&
> +	sudo chmod 1777 root/t &&
> +	(
> +		cd root/t &&
> +		git init &&
> +		git status &&
> +		sudo git status &&
> +		run_with_sudo <<-END
> +			unset SUDO_UID &&
> +			! git status
> +		END
> +	)
> +'
> +
> +test_expect_success SUDO 'non bare repository using a gitfile' '
> +	sudo rm -rf root &&
> +	mkdir -p root/w &&
> +	mkdir -p root/e &&
> +	(
> +		cd root/w &&
> +		git init --separate-git-dir ../e &&
> +		git status &&
> +		sudo chown -R root ../e &&
> +		test_must_fail git status
> +	)
> +'
> +
>   # this destroys the test environment used above
>   test_expect_success SUDO 'cleanup regression' '
>   	sudo rm -rf root

