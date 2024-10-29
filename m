Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E3F10F9
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213554; cv=none; b=b6PJnZDin5NY3K5MBFVDPAs62Z4EGxBirpA9Kl3YX2NdjW3Cnb9mA3Vf+T1I/Z/0bg/gwoUriW/LKTeOIwYajKNZZqRvkhDqQ7G80XQ49YSnKjlfcsZuCw/sZTIRxLKsozYmHBOleI5zDGNZu/KrHV9zAkfdsC2k0YVlis1sesI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213554; c=relaxed/simple;
	bh=SUIh28n+6wJJRIRp0x6A0O6B7o+mV2ssVtmZDkgl2rY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qv9sRFod2dMenq0fV3D/za6Adhyn1GCTQWeL3qyNSXsQp9YCpxIhCORvw8KBncIi3kKXnKODMwhmQrj/m2RaZ5W2qSNrZLfqzLvMC+XiBSIaRcn5gJuEv9qEo0PGZoKx/ZVonUAhVRLcFPr+ulyL+TB9kspllYyMNluwE3QqwxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjE8LH34; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjE8LH34"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d50fad249so4130244f8f.1
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 07:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730213550; x=1730818350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HgM+1dKYvmqzTe2o/56ovNl6XVc51+k7m1olOvH1VXk=;
        b=CjE8LH34kJtnYfbsRNMzv5HoCZUkNN2JYzvxb6IkYnJD+adD6r0XeyTWuDw8Q4lruT
         X+QCg304pNfm4cjlxJOM7ylWmJlK8BwuxJeF+bU4MM9nV+2+u8HW5BYP5OjgsIw5fU36
         Pj8bpVhp1bNpmXnvRnvryXO3ckYlHT/vSFdm3IIgvWdD+WmXM/P4GtLt4RNhdxImGGL9
         /hK/tCw54nHxFs+KQOrKyQyU3Mo2GinERk3HX2BX9H7+hbtzq8kungZMyGHF8/7cBbU2
         O5sGwlqss5EGdYvmSJCpoAgo0r7oXrXMLNoJk6C6dr62y/DRmS0652WissZn5WehproI
         AEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730213550; x=1730818350;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HgM+1dKYvmqzTe2o/56ovNl6XVc51+k7m1olOvH1VXk=;
        b=hIuE/bl+cIXVx/TWUcWRG2dLcEEK2cACQXRjKa9HKzeYqeUmyF7PYXVMnmtVb4p8TB
         YptI3ApVUMsbbBNkiHBKQwN164vDv5SwYJoo6tBgMexHsM166EEie1PTZAUr3etqglf0
         w+2Mb6nFM8b+IOWxBjxU2DwZhAPTOFhksa7qXYeTnqlXeR6kQgOySQtiZfppe4vfSvAg
         MEZUnZM5QgnX53cJa6tK+btg2ro/ksIARLBrrwFNnoo9clUWIylihIBF/w9Y5v6FTCCm
         Fk0UVUIyWypkYqxqG63hAWDu6vPTVzJUfWCQO8tZXNy7R+CSGRx3N1tHToz07UfW1PJV
         fhfw==
X-Forwarded-Encrypted: i=1; AJvYcCU35E2Z1ZRVT1+scFGV/KuCURco7T4nTxDZi+qIZeHF7kZ9qUkUS7kX6TTYq6qknJMg3Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfq2tWqkdp9ULA6YlSe3r865Q32s3EOTAWT9H4VIZup8JANGWg
	qWdeMA7WeMz1kZ1+J+Qds1PikEK4/oRcakgUZODU58qqUCIIMsH3Ci06uA==
X-Google-Smtp-Source: AGHT+IGsyL7PVMdMxqrbI6DZWpr1qXqHzh2lVuoEy6HHQsFfOM0PHFaeXYnDFhYOgCPaeYAUL4BLHA==
X-Received: by 2002:a5d:5cd0:0:b0:37d:4c4a:77b with SMTP id ffacd0b85a97d-3806120e398mr7546846f8f.58.1730213549931;
        Tue, 29 Oct 2024 07:52:29 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b91ff2sm12741981f8f.96.2024.10.29.07.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 07:52:29 -0700 (PDT)
Message-ID: <0bea06b8-11d0-497f-88e1-153cb61eb06d@gmail.com>
Date: Tue, 29 Oct 2024 14:52:28 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/5] worktree: add CLI/config options for relative path
 linking
To: Caleb White <cdwhite3@pm.me>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me>
 <20241028-wt_relative_options-v2-1-33a5021bd7bb@pm.me>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20241028-wt_relative_options-v2-1-33a5021bd7bb@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Caleb

Thanks for working on this.

On 28/10/2024 19:09, Caleb White wrote:
> This patch introduces the `--[no-]relative-paths` CLI option for

"This patch" is a bit redundant, I'd say "Introduce a 
`--[no-]-relative-paths ..`

> `git worktree {add, move, repair}` commands, as well as the
> `worktree.useRelativePaths` configuration setting. When enabled,
> these options allow worktrees to be linked using relative paths,
> enhancing portability across environments where absolute paths
> may differ (e.g., containerized setups, shared network drives).
> Git still creates absolute paths by default, but these options allow
> users to opt-in to relative paths if desired.

This sounds good, I'm not sure the patch actually implements anything 
other than the option parsing though. I think it would make sense to add 
these options at the end of the patch series once the implementation has 
been changed to support them. I'd start with patches 4 and 5 to add the 
new extension setting first, then refactor worktree.c to handle creating 
worktrees with relative or absolute paths and set the extension if 
appropriate, then add the --relative-path option to "git worktree"

> Using the `--relative-paths` option with `worktree {move, repair}`
> will convert absolute paths to relative ones, while `--no-relative-paths`
> does the reverse. For cases where users want consistency in path
> handling, the config option `worktree.useRelativePaths` provides
> a persistent setting.
> 
> In response to reviewer feedback from the initial patch series[1],
> this revision includes slight refactoring for improved
> maintainability and clarity in the code base.

Please don't mix cleanups with other code changes as it makes it hard to 
check that the cleanups don't change the behavior.

> [1]: https://lore.kernel.org/git/20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me
> 
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Caleb White <cdwhite3@pm.me>
> ---
>   Documentation/config/worktree.txt |  5 +++++
>   Documentation/git-worktree.txt    | 12 ++++++++++++
>   builtin/worktree.c                |  9 +++++++++
>   t/t2408-worktree-relative.sh      | 39 ---------------------------------------
>   worktree.c                        | 17 ++++++++++-------
>   worktree.h                        |  2 ++
>   6 files changed, 38 insertions(+), 46 deletions(-)
> 
> diff --git a/Documentation/config/worktree.txt b/Documentation/config/worktree.txt
> index 048e349482df6c892055720eb53cdcd6c327b6ed..44b783c2774dc5ff65e3fa232b0c25cd5254876b 100644
> --- a/Documentation/config/worktree.txt
> +++ b/Documentation/config/worktree.txt
> @@ -7,3 +7,8 @@ worktree.guessRemote::
>   	such a branch exists, it is checked out and set as "upstream"
>   	for the new branch.  If no such match can be found, it falls
>   	back to creating a new branch from the current HEAD.
> +worktree.useRelativePaths::
> +	If set to `true`, worktrees will be linked to the repository using
> +	relative paths rather than using absolute paths. This is particularly
> +	useful for setups where the repository and worktrees may be moved between
> +	different locations or environments.

I think it would be helpful to spell out the implications of this to the 
user - namely that you cannot use older versions of git on a repository 
with worktrees using relative paths and it may break third-party 
software as well.

> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 70437c815f13852bd2eb862176b8b933e6de0acf..975dc3c46d480480457ec4857988a6b8bc67b647 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -216,6 +216,18 @@ To remove a locked worktree, specify `--force` twice.
>   This can also be set up as the default behaviour by using the
>   `worktree.guessRemote` config option.
>   
> +--[no-]relative-paths::
> +	Worktrees will be linked to the repository using relative paths
> +	rather than using absolute paths. This is particularly useful for setups
> +	where the repository and worktrees may be moved between different
> +	locations or environments.

Again we should spell out the implications of using relative paths.

> +With `repair`, the linking files will be updated if there's an absolute/relative
> +mismatch, even if the links are correct.
> ++
> +This can also be set up as the default behaviour by using the
> +`worktree.useRelativePaths` config option.
> +
>   --[no-]track::
>   	When creating a new branch, if `<commit-ish>` is a branch,
>   	mark it as "upstream" from the new branch.  This is the
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index dae63dedf4cac2621f51f95a39aa456b33acd894..c1130be5890c905c0b648782a834eb8dfcd79ba5 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -134,6 +134,9 @@ static int git_worktree_config(const char *var, const char *value,
>   	if (!strcmp(var, "worktree.guessremote")) {
>   		guess_remote = git_config_bool(var, value);
>   		return 0;
> +	} else if (!strcmp(var, "worktree.userelativepaths")) {
> +		use_relative_paths = git_config_bool(var, value);

As we're trying to remove global variables from libgit.a as part of the 
libification effort I'd be much happier if "use_relative_paths" was 
declared as a "static int" in this file and then passed down to the 
functions that need it rather than declaring it as a global in "worktree.c".

> diff --git a/t/t2408-worktree-relative.sh b/t/t2408-worktree-relative.sh
> deleted file mode 100755

There's no explanation for this change in the commit message

Best Wishes

Phillip

> index a3136db7e28cb20926ff44211e246ce625a6e51a..0000000000000000000000000000000000000000
> --- a/t/t2408-worktree-relative.sh
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -#!/bin/sh
> -
> -test_description='test worktrees linked with relative paths'
> -
> -TEST_PASSES_SANITIZE_LEAK=true
> -. ./test-lib.sh
> -
> -test_expect_success 'links worktrees with relative paths' '
> -	test_when_finished rm -rf repo &&
> -	git init repo &&
> -	(
> -		cd repo &&
> -		test_commit initial &&
> -		git worktree add wt1 &&
> -		echo "../../../wt1/.git" >expected_gitdir &&
> -		cat .git/worktrees/wt1/gitdir >actual_gitdir &&
> -		echo "gitdir: ../.git/worktrees/wt1" >expected_git &&
> -		cat wt1/.git >actual_git &&
> -		test_cmp expected_gitdir actual_gitdir &&
> -		test_cmp expected_git actual_git
> -	)
> -'
> -
> -test_expect_success 'move repo without breaking relative internal links' '
> -	test_when_finished rm -rf repo moved &&
> -	git init repo &&
> -	(
> -		cd repo &&
> -		test_commit initial &&
> -		git worktree add wt1 &&
> -		cd .. &&
> -		mv repo moved &&
> -		cd moved/wt1 &&
> -		git status >out 2>err &&
> -		test_must_be_empty err
> -	)
> -'
> -
> -test_done
> diff --git a/worktree.c b/worktree.c
> index 77ff484d3ec48c547ee4e3d958dfa28a52c1eaa7..de5c5e53a5f2a758ddf470b5d6a9ad6c66247181 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -14,6 +14,8 @@
>   #include "wt-status.h"
>   #include "config.h"
>   
> +int use_relative_paths = 0;
> +
>   void free_worktree(struct worktree *worktree)
>   {
>   	if (!worktree)
> @@ -111,9 +113,9 @@ struct worktree *get_linked_worktree(const char *id,
>   	strbuf_strip_suffix(&worktree_path, "/.git");
>   
>   	if (!is_absolute_path(worktree_path.buf)) {
> -	    strbuf_strip_suffix(&path, "gitdir");
> -	    strbuf_addbuf(&path, &worktree_path);
> -	    strbuf_realpath_forgiving(&worktree_path, path.buf, 0);
> +		strbuf_strip_suffix(&path, "gitdir");
> +		strbuf_addbuf(&path, &worktree_path);
> +		strbuf_realpath_forgiving(&worktree_path, path.buf, 0);
>   	}
>   
>   	CALLOC_ARRAY(worktree, 1);
> @@ -725,12 +727,15 @@ static int is_main_worktree_path(const char *path)
>    * won't know which <repo>/worktrees/<id>/gitdir to repair. However, we may
>    * be able to infer the gitdir by manually reading /path/to/worktree/.git,
>    * extracting the <id>, and checking if <repo>/worktrees/<id> exists.
> + *
> + * Returns -1 on failure and strbuf.len on success.
>    */
>   static int infer_backlink(const char *gitfile, struct strbuf *inferred)
>   {
>   	struct strbuf actual = STRBUF_INIT;
>   	const char *id;
>   
> +	strbuf_reset(inferred);
>   	if (strbuf_read_file(&actual, gitfile, 0) < 0)
>   		goto error;
>   	if (!starts_with(actual.buf, "gitdir:"))
> @@ -741,18 +746,16 @@ static int infer_backlink(const char *gitfile, struct strbuf *inferred)
>   	id++; /* advance past '/' to point at <id> */
>   	if (!*id)
>   		goto error;
> -	strbuf_reset(inferred);
>   	strbuf_git_common_path(inferred, the_repository, "worktrees/%s", id);
>   	if (!is_directory(inferred->buf))
>   		goto error;
>   
>   	strbuf_release(&actual);
> -	return 1;
> -
> +	return inferred->len;
>   error:
>   	strbuf_release(&actual);
>   	strbuf_reset(inferred); /* clear invalid path */
> -	return 0;
> +	return -1;
>   }
>   
>   /*
> diff --git a/worktree.h b/worktree.h
> index e96118621638667d87c5d7e0452ed10bd1ddf606..37e65d508ed23d3e7a29850bb938285072a3aaa6 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -5,6 +5,8 @@
>   
>   struct strbuf;
>   
> +extern int use_relative_paths;
> +
>   struct worktree {
>   	/* The repository this worktree belongs to. */
>   	struct repository *repo;
> 

