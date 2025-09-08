Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB56208A7
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341476; cv=none; b=u+nP4pdZRtGCFm3qk12v+o2jWgPu3W107O0EBzRlSSU7Fy8FB1I6b2PImsdIQzJMPtkMWv4VgCQUVEMPyhKaMTZ/P2MwQmLyz6StlWX8onRjcmyfxbYPKFFciNAb7n9kI6UWTmHXvAAqmqko71TDUatKWyGLkfTWPenMqJe7ebI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341476; c=relaxed/simple;
	bh=WkVdfVaY/3hrFsSV/hXEkNHM7C3OhVZmtBhKiOO/4gE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=id2pvCFysGdOteTF0O/Ubs4esB2dfgXgUcdJJyOTputC2udh50taJHCr3SUsAmKqf3aOJHk/YSyknGjCDgJs5julYRUBMbFr366P1nJBGyp9UbgtBnEnUFTv0qmE32fDlA0eNeZT+wKzbiFPSm8CPhUSzlLtjqKL7DGIiVkzGBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CN2drPfh; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CN2drPfh"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so2953522f8f.3
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 07:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757341470; x=1757946270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dOY48ACP8CFAkWTHH6/jZpnHtB4V8fo7e2cEbIq/V0s=;
        b=CN2drPfhnASfpNMKqpxFz1IQmGD7IG3nJWUnt+4emf37rxgMsoK8UtyDNphggYF3p9
         P6ch6nIWnswVD2M/JmzfSn0a7DMjYbG8Z+1GZJqGluS7wt3GMi4wuGsi5yvLTzhMFEB2
         0D6yCAwFLi/3Uix8vUpeJ1O/mClg7yaSauvxpKDuU4n7hD1R/YUpxOGAeBATusbNThoc
         RWvzeXufq52FaXYk1I6r1/MUuPFJylC9RhSbJ03oXX48RDsxgX/S9rCVtHtcf56MRJCZ
         0kVKuTPnEP/d8EWS/OPeCnsRe7OapOIRqcAQanDKk6fjU09zv9Az9xisKxDJWJ85k4Dl
         eNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757341470; x=1757946270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOY48ACP8CFAkWTHH6/jZpnHtB4V8fo7e2cEbIq/V0s=;
        b=M2oLYmEfEhQIB+Ifeaynyjso6VESPbmmW9/UnxxrYMTuYeM1i7BG/jAfPL+JiA1qim
         UHNp0xL80KH1e03GbCK9E/8LF1TCCGBu0vJ0Vf4+31cde2JyR8sBpKtipC71uDUlC32h
         Rhb2ys6L5dPG473Bf5541u1J9fluNK4T1xKSH5U9MBt8QPD+aX+82MyZAAMTsQpoJH4I
         ujAZNuG3kt9OQQsgtiABnvVkVj78iUw6F4lE595ILNF9ACkpD6Woqj3pUtXBygN2Vggj
         Lfy8wrNwMWGseeNfLu1yTUp6aCVnTmvQ2IGhPLvViJYBQz6vlwUIwDCqrba/bxUgKdNc
         8VMA==
X-Forwarded-Encrypted: i=1; AJvYcCVZKCM1GDCzzg+I45bSnL9ttIXcAzN3Bup9OZi/uHSY4laCejSlsHB46pzBMUYQq8SFhWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuj69LTL7pMDTqj+uc6zxyoDNkwNFX1aVSC77a5+4tLtOQ4Z6r
	ywAZ/NxMHQotJLwVfWZXUWUD/Gy5s9XSAFS4LlSGuHDHm8J6TjR0T37R
X-Gm-Gg: ASbGnctbTVyZdcpCbpi1otDMtuseuMVUDPpmSywqd5dd4iyk09QRr8ek4llqhFtkRTw
	onCf6XrZRDrhrc1JZ+Wb34iWaMCnW6lMzQPtjsoNBMb6EMpWh5179guWd5V/yehIF/f8NZhXjOU
	dghdi/Cm1YgLW0jQHro660xs2Lin+1nu/nrCTkv1TOZNtD6wL1DQAtSHsyeORg4DOMxJFoxF7oM
	gijmgsnvb4W7F/hJsXN8K73a1ps7OmDpo9NUQSIQw8YmuXh8jWW8iFkxS79gS+aPoffNiLnt9xW
	eXhMH91lplavDD+Nn/jLdCkFQyBbrBed6nTPfOrFzzFt4zuuzeLT8+0llFiWVgXx5nvHDS7l/nC
	ACK5mWzuzLUimp2skfbx0QYbl3Bu8PdoIt89BlBa5QllyaQjZ6tVBFl7s9k9Cfuh9zJ7a5dmRGq
	qJagfi
X-Google-Smtp-Source: AGHT+IGpDcyoZRHcC1eCGjnhXJVgizxdRh4IV0TmJxehePT7FNMIPdypbu7ftCABoqTAxyITaxFwQg==
X-Received: by 2002:a05:6000:2209:b0:3e5:31d3:e330 with SMTP id ffacd0b85a97d-3e641a62252mr7224608f8f.25.1757341469544;
        Mon, 08 Sep 2025 07:24:29 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc? ([2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d0f85c287fsm39843008f8f.52.2025.09.08.07.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 07:24:29 -0700 (PDT)
Message-ID: <fc69ee66-815f-48ec-a5fb-99cac5f4d58c@gmail.com>
Date: Mon, 8 Sep 2025 15:24:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/9] submodule: create new gitdirs under submodules path
To: Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
 Rodrigo Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>,
 Junio C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>,
 Jonathan Nieder <jrnieder@gmail.com>, Stefan Beller <sbeller@google.com>,
 Patrick Steinhardt <ps@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250816213642.3517822-3-adrian.ratiu@collabora.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250816213642.3517822-3-adrian.ratiu@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adrian

On 16/08/2025 22:36, Adrian Ratiu wrote:
> This is in preparation for encoding the submodule names to avoid conflicts
> like submodules named foo and foo/bar together with case-insensitive file-
> system handling and other corner cases like reserved filenames on Windows.
> 
> Backward compatibility is kept with plain-name modules already existing at
> paths like .git/modules/<name>, however a clear separation between legacy
> (plain) and new (encoded) namespaces is desirable, to avoid situations like
> an existing plain-name module containing the encoding escape character/
> 
> Thus we split the new-style (encoded) gitdir name paths to .git/submodules,
> while legacy-style paths remain under .git/modules.
> 
> This is just a default directory change with the accompanying test updates,
> in preparation for the actual encoding additions in future commits.

Does this need an extentions.submoduleEncoding (name suggestions 
welcome) config key to stop older versions of git trying to read the 
repository as they wont be able to locate the gitdir of any submodules 
added under .git/submodules?

Thanks

Phillip

> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>   Documentation/fetch-options.adoc           |  2 +-
>   Documentation/git-fetch.adoc               |  2 +-
>   Documentation/git-submodule.adoc           |  2 +-
>   Documentation/gitsubmodules.adoc           |  8 ++--
>   setup.c                                    |  2 +-
>   submodule.c                                | 28 +++++++++---
>   t/lib-submodule-update.sh                  | 50 +++++++++++-----------
>   t/t0035-safe-bare-repository.sh            |  4 +-
>   t/t1600-index.sh                           |  4 +-
>   t/t2405-worktree-submodule.sh              |  8 ++--
>   t/t2501-cwd-empty.sh                       |  2 +-
>   t/t3600-rm.sh                              |  8 ++--
>   t/t5526-fetch-submodules.sh                |  2 +-
>   t/t5619-clone-local-ambiguous-transport.sh |  4 +-
>   t/t6120-describe.sh                        |  4 +-
>   t/t7001-mv.sh                              |  4 +-
>   t/t7400-submodule-basic.sh                 | 18 ++++----
>   t/t7406-submodule-update.sh                | 10 ++---
>   t/t7407-submodule-foreach.sh               |  6 +--
>   t/t7408-submodule-reference.sh             | 22 +++++-----
>   t/t7412-submodule-absorbgitdirs.sh         | 22 +++++-----
>   t/t7423-submodule-symlinks.sh              |  8 ++--
>   t/t7450-bad-git-dotfiles.sh                | 32 +++++++-------
>   t/t7527-builtin-fsmonitor.sh               |  4 +-
>   24 files changed, 136 insertions(+), 120 deletions(-)
> 
> diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
> index b01372e4b3..f8d3f65009 100644
> --- a/Documentation/fetch-options.adoc
> +++ b/Documentation/fetch-options.adoc
> @@ -210,7 +210,7 @@ ifndef::git-pull[]
>   	submodule that has commits that are referenced by a newly fetched
>   	superproject commit but are missing in the local submodule clone. A
>   	changed submodule can be fetched as long as it is present locally e.g.
> -	in `$GIT_DIR/modules/` (see linkgit:gitsubmodules[7]); if the upstream
> +	in `$GIT_DIR/submodules/` (see linkgit:gitsubmodules[7]); if the upstream
>   	adds a new submodule, that submodule cannot be fetched until it is
>   	cloned e.g. by `git submodule update`.
>   +
> diff --git a/Documentation/git-fetch.adoc b/Documentation/git-fetch.adoc
> index 16f5d9d69a..2923a29bef 100644
> --- a/Documentation/git-fetch.adoc
> +++ b/Documentation/git-fetch.adoc
> @@ -304,7 +304,7 @@ include::config/fetch.adoc[]
>   BUGS
>   ----
>   Using --recurse-submodules can only fetch new commits in submodules that are
> -present locally e.g. in `$GIT_DIR/modules/`. If the upstream adds a new
> +present locally e.g. in `$GIT_DIR/submodules/`. If the upstream adds a new
>   submodule, that submodule cannot be fetched until it is cloned e.g. by `git
>   submodule update`. This is expected to be fixed in a future Git version.
>   
> diff --git a/Documentation/git-submodule.adoc b/Documentation/git-submodule.adoc
> index 503c84a200..9389862208 100644
> --- a/Documentation/git-submodule.adoc
> +++ b/Documentation/git-submodule.adoc
> @@ -266,7 +266,7 @@ registered submodules, and sync any nested submodules within.
>   absorbgitdirs::
>   	If a git directory of a submodule is inside the submodule,
>   	move the git directory of the submodule into its superproject's
> -	`$GIT_DIR/modules` path and then connect the git directory and
> +	`$GIT_DIR/submodules` path and then connect the git directory and
>   	its working directory by setting the `core.worktree` and adding
>   	a .git file pointing to the git directory embedded in the
>   	superprojects git directory.
> diff --git a/Documentation/gitsubmodules.adoc b/Documentation/gitsubmodules.adoc
> index f7b5a25a0c..061e24f316 100644
> --- a/Documentation/gitsubmodules.adoc
> +++ b/Documentation/gitsubmodules.adoc
> @@ -21,12 +21,12 @@ The submodule has its own history; the repository it is embedded
>   in is called a superproject.
>   
>   On the filesystem, a submodule usually (but not always - see FORMS below)
> -consists of (i) a Git directory located under the `$GIT_DIR/modules/`
> +consists of (i) a Git directory located under the `$GIT_DIR/submodules/`
>   directory of its superproject, (ii) a working directory inside the
>   superproject's working directory, and a `.git` file at the root of
>   the submodule's working directory pointing to (i).
>   
> -Assuming the submodule has a Git directory at `$GIT_DIR/modules/foo/`
> +Assuming the submodule has a Git directory at `$GIT_DIR/submodules/foo/`
>   and a working directory at `path/to/bar/`, the superproject tracks the
>   submodule via a `gitlink` entry in the tree at `path/to/bar` and an entry
>   in its `.gitmodules` file (see linkgit:gitmodules[5]) of the form
> @@ -137,7 +137,7 @@ using older versions of Git.
>   It is possible to construct these old form repositories manually.
>   +
>   When deinitialized or deleted (see below), the submodule's Git
> -directory is automatically moved to `$GIT_DIR/modules/<name>/`
> +directory is automatically moved to `$GIT_DIR/submodules/<name>/`
>   of the superproject.
>   
>    * Deinitialized submodule: A `gitlink`, and a `.gitmodules` entry,
> @@ -162,7 +162,7 @@ possible to checkout past commits without requiring fetching
>   from another repository.
>   +
>   To completely remove a submodule, manually delete
> -`$GIT_DIR/modules/<name>/`.
> +`$GIT_DIR/submodules/<name>/`.
>   
>   ACTIVE SUBMODULES
>   -----------------
> diff --git a/setup.c b/setup.c
> index 98ddbf377f..d054dafa6a 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1416,7 +1416,7 @@ static int is_implicit_bare_repo(const char *path)
>   	 * we are inside $GIT_DIR of a worktree of a non-embedded
>   	 * submodule, whose superproject is not a bare repository.
>   	 */
> -	if (strstr(path, "/.git/modules/"))
> +	if (strstr(path, "/.git/modules/") || strstr(path, "/.git/submodules/"))
>   		return 1;
>   
>   	return 0;
> diff --git a/submodule.c b/submodule.c
> index fff3c75570..dbf2244e60 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1278,22 +1278,29 @@ void check_for_new_submodule_commits(struct object_id *oid)
>   
>   /*
>    * Returns 1 if there is at least one submodule gitdir in
> - * $GIT_DIR/modules and 0 otherwise. This follows
> + * $GIT_DIR/(sub)modules and 0 otherwise. This follows
>    * submodule_name_to_gitdir(), which looks for submodules in
> - * $GIT_DIR/modules, not $GIT_COMMON_DIR.
> + * $GIT_DIR/(sub)modules, not $GIT_COMMON_DIR.
>    *
> - * A submodule can be moved to $GIT_DIR/modules manually by running "git
> - * submodule absorbgitdirs", or it may be initialized there by "git
> - * submodule update".
> + * A submodule can be moved to $GIT_DIR/(sub)modules manually by running
> + * "git submodule absorbgitdirs", or it may be initialized there by
> + * "git submodule update".
>    */
>   static int repo_has_absorbed_submodules(struct repository *r)
>   {
>   	int ret;
>   	struct strbuf buf = STRBUF_INIT;
>   
> +	/* check legacy path */
>   	repo_git_path_append(r, &buf, "modules/");
>   	ret = file_exists(buf.buf) && !is_empty_dir(buf.buf);
> +	strbuf_reset(&buf);
> +
> +	/* new (encoded name) path */
> +	repo_git_path_append(r, &buf, "submodules/");
> +	ret |= file_exists(buf.buf) && !is_empty_dir(buf.buf);
>   	strbuf_release(&buf);
> +
>   	return ret;
>   }
>   
> @@ -2273,7 +2280,7 @@ int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
>   	 *
>   	 * Example: having a submodule named `hippo` and another one named
>   	 * `hippo/hooks` would result in the git directories
> -	 * `.git/modules/hippo/` and `.git/modules/hippo/hooks/`, respectively,
> +	 * `.git/submodules/hippo/` and `.git/submodules/hippo/hooks/`, respectively,
>   	 * but the latter directory is already designated to contain the hooks
>   	 * of the former.
>   	 */
> @@ -2604,6 +2611,15 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
>   	 * administrators can explicitly set. Nothing has been decided,
>   	 * so for now, just append the name at the end of the path.
>   	 */
> +
> +	/* Legacy behavior: allow existing paths under modules/<name>. */
>   	repo_git_path_append(r, buf, "modules/");
>   	strbuf_addstr(buf, submodule_name);
> +	if (!access(buf->buf, F_OK))
> +		return;
> +
> +	/* New style (encoded) paths go under submodules/<encoded>. */
> +	strbuf_reset(buf);
> +	repo_git_path_append(r, buf, "submodules/");
> +	strbuf_addstr(buf, submodule_name);
>   }
> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> index 36f767cb74..b6b2be1df5 100644
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -161,7 +161,7 @@ replace_gitfile_with_git_dir () {
>   }
>   
>   # Test that the .git directory in the submodule is unchanged (except for the
> -# core.worktree setting, which appears only in $GIT_DIR/modules/$1/config).
> +# core.worktree setting, which appears only in $GIT_DIR/submodules/$1/config).
>   # Call this function before test_submodule_content as the latter might
>   # write the index file leading to false positive index differences.
>   #
> @@ -170,23 +170,23 @@ replace_gitfile_with_git_dir () {
>   test_git_directory_is_unchanged () {
>   	# does core.worktree point at the right place?
>   	echo "../../../$1" >expect &&
> -	git -C ".git/modules/$1" config core.worktree >actual &&
> +	git -C ".git/submodules/$1" config core.worktree >actual &&
>   	test_cmp expect actual &&
>   	# remove it temporarily before comparing, as
>   	# "$1/.git/config" lacks it...
> -	git -C ".git/modules/$1" config --unset core.worktree &&
> -	diff -r ".git/modules/$1" "$1/.git" &&
> +	git -C ".git/submodules/$1" config --unset core.worktree &&
> +	diff -r ".git/submodules/$1" "$1/.git" &&
>   	# ... and then restore.
> -	git -C ".git/modules/$1" config core.worktree "../../../$1"
> +	git -C ".git/submodules/$1" config core.worktree "../../../$1"
>   }
>   
>   test_git_directory_exists () {
> -	test -e ".git/modules/$1" &&
> +	test -e ".git/submodules/$1" &&
>   	if test -f sub1/.git
>   	then
>   		# does core.worktree point at the right place?
>   		echo "../../../$1" >expect &&
> -		git -C ".git/modules/$1" config core.worktree >actual &&
> +		git -C ".git/submodules/$1" config core.worktree >actual &&
>   		test_cmp expect actual
>   	fi
>   }
> @@ -225,22 +225,22 @@ reset_work_tree_to () {
>   reset_work_tree_to_interested () {
>   	reset_work_tree_to $1 &&
>   	# make the submodule git dirs available
> -	if ! test -d submodule_update/.git/modules/sub1
> +	if ! test -d submodule_update/.git/submodules/sub1
>   	then
> -		mkdir -p submodule_update/.git/modules &&
> -		cp -r submodule_update_repo/.git/modules/sub1 submodule_update/.git/modules/sub1
> -		GIT_WORK_TREE=. git -C submodule_update/.git/modules/sub1 config --unset core.worktree
> +		mkdir -p submodule_update/.git/submodules &&
> +		cp -r submodule_update_repo/.git/submodules/sub1 submodule_update/.git/submodules/sub1
> +		GIT_WORK_TREE=. git -C submodule_update/.git/submodules/sub1 config --unset core.worktree
>   	fi &&
> -	if ! test -d submodule_update/.git/modules/sub1/modules/sub2
> +	if ! test -d submodule_update/.git/submodules/sub1/submodules/sub2
>   	then
> -		mkdir -p submodule_update/.git/modules/sub1/modules &&
> -		cp -r submodule_update_repo/.git/modules/sub1/modules/sub2 submodule_update/.git/modules/sub1/modules/sub2
> +		mkdir -p submodule_update/.git/submodules/sub1/submodules &&
> +		cp -r submodule_update_repo/.git/submodules/sub1/submodules/sub2 submodule_update/.git/submodules/sub1/submodules/sub2
>   		# core.worktree is unset for sub2 as it is not checked out
>   	fi &&
>   	# indicate we are interested in the submodule:
>   	git -C submodule_update config submodule.sub1.url "bogus" &&
>   	# sub1 might not be checked out, so use the git dir
> -	git -C submodule_update/.git/modules/sub1 config submodule.sub2.url "bogus"
> +	git -C submodule_update/.git/submodules/sub1 config submodule.sub2.url "bogus"
>   }
>   
>   # Test that the superproject contains the content according to commit "$1"
> @@ -742,7 +742,7 @@ test_submodule_recursing_with_args_common () {
>   			$command remove_sub1 &&
>   			test_superproject_content origin/remove_sub1 &&
>   			! test -e sub1 &&
> -			test_must_fail git config -f .git/modules/sub1/config core.worktree
> +			test_must_fail git config -f .git/submodules/sub1/config core.worktree
>   		)
>   	'
>   	# ... absorbing a .git directory along the way.
> @@ -753,7 +753,7 @@ test_submodule_recursing_with_args_common () {
>   			cd submodule_update &&
>   			git branch -t remove_sub1 origin/remove_sub1 &&
>   			replace_gitfile_with_git_dir sub1 &&
> -			rm -rf .git/modules &&
> +			rm -rf .git/submodules &&
>   			$command remove_sub1 &&
>   			test_superproject_content origin/remove_sub1 &&
>   			! test -e sub1 &&
> @@ -803,8 +803,8 @@ test_submodule_recursing_with_args_common () {
>   			$command no_submodule &&
>   			test_superproject_content origin/no_submodule &&
>   			test_path_is_missing sub1 &&
> -			test_must_fail git config -f .git/modules/sub1/config core.worktree &&
> -			test_must_fail git config -f .git/modules/sub1/modules/sub2/config core.worktree
> +			test_must_fail git config -f .git/submodules/sub1/config core.worktree &&
> +			test_must_fail git config -f .git/submodules/sub1/submodules/sub2/config core.worktree
>   		)
>   	'
>   
> @@ -937,7 +937,7 @@ test_submodule_switch_recursing_with_args () {
>   			cd submodule_update &&
>   			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
>   			replace_gitfile_with_git_dir sub1 &&
> -			rm -rf .git/modules &&
> +			rm -rf .git/submodules &&
>   			$command replace_sub1_with_directory &&
>   			test_superproject_content origin/replace_sub1_with_directory &&
>   			test_git_directory_exists sub1
> @@ -946,15 +946,15 @@ test_submodule_switch_recursing_with_args () {
>   
>   	# ... and ignored files are ignored
>   	test_expect_success "$command: replace submodule with a file works ignores ignored files in submodule" '
> -		test_when_finished "rm submodule_update/.git/modules/sub1/info/exclude" &&
> +		test_when_finished "rm submodule_update/.git/submodules/sub1/info/exclude" &&
>   		prolog &&
>   		reset_work_tree_to_interested add_sub1 &&
>   		(
>   			cd submodule_update &&
> -			rm -rf .git/modules/sub1/info &&
> +			rm -rf .git/submodules/sub1/info &&
>   			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
> -			mkdir .git/modules/sub1/info &&
> -			echo ignored >.git/modules/sub1/info/exclude &&
> +			mkdir .git/submodules/sub1/info &&
> +			echo ignored >.git/submodules/sub1/info/exclude &&
>   			: >sub1/ignored &&
>   			$command replace_sub1_with_file &&
>   			test_superproject_content origin/replace_sub1_with_file &&
> @@ -1034,7 +1034,7 @@ test_submodule_forced_switch_recursing_with_args () {
>   			cd submodule_update &&
>   			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
>   			replace_gitfile_with_git_dir sub1 &&
> -			rm -rf .git/modules/sub1 &&
> +			rm -rf .git/submodules/sub1 &&
>   			$command replace_sub1_with_directory &&
>   			test_superproject_content origin/replace_sub1_with_directory &&
>   			test_git_directory_exists sub1
> diff --git a/t/t0035-safe-bare-repository.sh b/t/t0035-safe-bare-repository.sh
> index ae7ef092ab..a480ddf8d6 100755
> --- a/t/t0035-safe-bare-repository.sh
> +++ b/t/t0035-safe-bare-repository.sh
> @@ -41,7 +41,7 @@ test_expect_success 'setup an embedded bare repo, secondary worktree and submodu
>   			submodule add --name subn -- ./bare-repo subd
>   	) &&
>   	test_path_is_dir outer-repo/.git/worktrees/outer-secondary &&
> -	test_path_is_dir outer-repo/.git/modules/subn
> +	test_path_is_dir outer-repo/.git/submodules/subn
>   '
>   
>   test_expect_success 'safe.bareRepository unset' '
> @@ -100,7 +100,7 @@ test_expect_success 'no trace in $GIT_DIR of secondary worktree' '
>   '
>   
>   test_expect_success 'no trace in $GIT_DIR of a submodule' '
> -	expect_accepted_implicit -C outer-repo/.git/modules/subn
> +	expect_accepted_implicit -C outer-repo/.git/submodules/subn
>   '
>   
>   test_done
> diff --git a/t/t1600-index.sh b/t/t1600-index.sh
> index 03239e9faa..0e5e8efb20 100755
> --- a/t/t1600-index.sh
> +++ b/t/t1600-index.sh
> @@ -87,10 +87,10 @@ test_expect_success 'index.skipHash config option' '
>   	git -c protocol.file.allow=always submodule add ./ sub &&
>   	git config index.skipHash false &&
>   	git -C sub config index.skipHash true &&
> -	rm -f .git/modules/sub/index &&
> +	rm -f .git/submodules/sub/index &&
>   	>sub/file &&
>   	git -C sub add a &&
> -	test_trailing_hash .git/modules/sub/index >hash &&
> +	test_trailing_hash .git/submodules/sub/index >hash &&
>   	test_cmp expect hash &&
>   	git -C sub fsck
>   '
> diff --git a/t/t2405-worktree-submodule.sh b/t/t2405-worktree-submodule.sh
> index 11018f37c7..c18c2efca5 100755
> --- a/t/t2405-worktree-submodule.sh
> +++ b/t/t2405-worktree-submodule.sh
> @@ -62,7 +62,7 @@ test_expect_success 'submodule is checked out after manually adding submodule wo
>   test_expect_success 'checkout --recurse-submodules uses $GIT_DIR for submodules in a linked worktree' '
>   	git -C main worktree add "$base_path/checkout-recurse" --detach  &&
>   	git -C checkout-recurse submodule update --init &&
> -	echo "gitdir: ../../main/.git/worktrees/checkout-recurse/modules/sub" >expect-gitfile &&
> +	echo "gitdir: ../../main/.git/worktrees/checkout-recurse/submodules/sub" >expect-gitfile &&
>   	cat checkout-recurse/sub/.git >actual-gitfile &&
>   	test_cmp expect-gitfile actual-gitfile &&
>   	git -C main/sub rev-parse HEAD >expect-head-main &&
> @@ -73,7 +73,7 @@ test_expect_success 'checkout --recurse-submodules uses $GIT_DIR for submodules
>   	test_cmp expect-head-main actual-head-main
>   '
>   
> -test_expect_success 'core.worktree is removed in $GIT_DIR/modules/<name>/config, not in $GIT_COMMON_DIR/modules/<name>/config' '
> +test_expect_success 'core.worktree is removed in $GIT_DIR/submodules/<name>/config, not in $GIT_COMMON_DIR/submodules/<name>/config' '
>   	echo "../../../sub" >expect-main &&
>   	git -C main/sub config --get core.worktree >actual-main &&
>   	test_cmp expect-main actual-main &&
> @@ -81,14 +81,14 @@ test_expect_success 'core.worktree is removed in $GIT_DIR/modules/<name>/config,
>   	git -C checkout-recurse/sub config --get core.worktree >actual-linked &&
>   	test_cmp expect-linked actual-linked &&
>   	git -C checkout-recurse checkout --recurse-submodules first &&
> -	test_expect_code 1 git -C main/.git/worktrees/checkout-recurse/modules/sub config --get core.worktree >linked-config &&
> +	test_expect_code 1 git -C main/.git/worktrees/checkout-recurse/submodules/sub config --get core.worktree >linked-config &&
>   	test_must_be_empty linked-config &&
>   	git -C main/sub config --get core.worktree >actual-main &&
>   	test_cmp expect-main actual-main
>   '
>   
>   test_expect_success 'unsetting core.worktree does not prevent running commands directly against the submodule repository' '
> -	git -C main/.git/worktrees/checkout-recurse/modules/sub log
> +	git -C main/.git/worktrees/checkout-recurse/submodules/sub log
>   '
>   
>   test_done
> diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
> index be9140bbaa..bb8751433f 100755
> --- a/t/t2501-cwd-empty.sh
> +++ b/t/t2501-cwd-empty.sh
> @@ -239,7 +239,7 @@ test_submodule_removal () {
>   	test "$path_status" = dir && test_status=test_must_fail
>   
>   	test_when_finished "git reset --hard HEAD~1" &&
> -	test_when_finished "rm -rf .git/modules/my_submodule" &&
> +	test_when_finished "rm -rf .git/submodules/my_submodule" &&
>   
>   	git checkout foo/bar/baz &&
>   
> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> index 1f16e6b522..5b8ed57538 100755
> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -582,7 +582,7 @@ test_expect_success 'rm of a conflicted populated submodule with a .git director
>   	(
>   		cd submod &&
>   		rm .git &&
> -		cp -R ../.git/modules/sub .git &&
> +		cp -R ../.git/submodules/sub .git &&
>   		GIT_WORK_TREE=. git config --unset core.worktree
>   	) &&
>   	test_must_fail git merge conflict2 &&
> @@ -617,9 +617,9 @@ test_expect_success 'rm of a populated submodule with a .git directory migrates
>   	(
>   		cd submod &&
>   		rm .git &&
> -		cp -R ../.git/modules/sub .git &&
> +		cp -R ../.git/submodules/sub .git &&
>   		GIT_WORK_TREE=. git config --unset core.worktree &&
> -		rm -r ../.git/modules/sub
> +		rm -r ../.git/submodules/sub
>   	) &&
>   	git rm submod 2>output.err &&
>   	test_path_is_missing submod &&
> @@ -709,7 +709,7 @@ test_expect_success "rm absorbs submodule's nested .git directory" '
>   	(
>   		cd submod/subsubmod &&
>   		rm .git &&
> -		mv ../../.git/modules/sub/modules/sub .git &&
> +		mv ../../.git/submodules/sub/submodules/sub .git &&
>   		GIT_WORK_TREE=. git config --unset core.worktree
>   	) &&
>   	git rm submod 2>output.err &&
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index 5e566205ba..b7385bc088 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -1143,7 +1143,7 @@ test_expect_success 'fetch --recurse-submodules updates name-conflicted, unpopul
>   	head1=$(git -C same-name-1/submodule rev-parse HEAD) &&
>   	head2=$(git -C same-name-2/submodule rev-parse HEAD) &&
>   	(
> -		cd same-name-downstream/.git/modules/submodule &&
> +		cd same-name-downstream/.git/submodules/submodule &&
>   		# The submodule has core.worktree pointing to the "git
>   		# rm"-ed directory, overwrite the invalid value. See
>   		# comment in get_fetch_task_from_changed() for more
> diff --git a/t/t5619-clone-local-ambiguous-transport.sh b/t/t5619-clone-local-ambiguous-transport.sh
> index cce62bf78d..cf2d5e7bfb 100755
> --- a/t/t5619-clone-local-ambiguous-transport.sh
> +++ b/t/t5619-clone-local-ambiguous-transport.sh
> @@ -38,7 +38,7 @@ test_expect_success 'setup' '
>   		ln -s "$(cd .. && pwd)/sensitive" repo/objects &&
>   
>   		mkdir -p "$HTTPD_URL/dumb" &&
> -		ln -s "../../../.git/modules/sub/../../../repo/" "$URI" &&
> +		ln -s "../../../.git/submodules/sub/../../../repo/" "$URI" &&
>   
>   		git add . &&
>   		git commit -m "initial commit"
> @@ -57,7 +57,7 @@ test_expect_success 'ambiguous transport does not lead to arbitrary file-inclusi
>   	git clone malicious clone &&
>   	test_must_fail git -C clone submodule update --init 2>err &&
>   
> -	test_path_is_missing clone/.git/modules/sub/objects/secret &&
> +	test_path_is_missing clone/.git/submodules/sub/objects/secret &&
>   	# We would actually expect "transport .file. not allowed" here,
>   	# but due to quirks of the URL detection in Git, we mis-parse
>   	# the absolute path as a bogus URL and die before that step.
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index 256ccaefb7..56460ae8b5 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -357,7 +357,7 @@ test_expect_success 'setup and absorb a submodule' '
>   '
>   
>   test_expect_success 'describe chokes on severely broken submodules' '
> -	mv .git/modules/sub1/ .git/modules/sub_moved &&
> +	mv .git/submodules/sub1/ .git/submodules/sub_moved &&
>   	test_must_fail git describe --dirty
>   '
>   
> @@ -371,7 +371,7 @@ test_expect_success 'describe with --work-tree ignoring a broken submodule' '
>   		cd "$TEST_DIRECTORY" &&
>   		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --broken >"$TRASH_DIRECTORY/out"
>   	) &&
> -	test_when_finished "mv .git/modules/sub_moved .git/modules/sub1" &&
> +	test_when_finished "mv .git/submodules/sub_moved .git/submodules/sub1" &&
>   	grep broken out
>   '
>   
> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> index 920479e925..89b06ae3c1 100755
> --- a/t/t7001-mv.sh
> +++ b/t/t7001-mv.sh
> @@ -360,7 +360,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and no .gitm
>   	(
>   		cd sub &&
>   		rm -f .git &&
> -		cp -R -P -p ../.git/modules/sub .git &&
> +		cp -R -P -p ../.git/submodules/sub .git &&
>   		GIT_WORK_TREE=. git config --unset core.worktree
>   	) &&
>   	mkdir mod &&
> @@ -380,7 +380,7 @@ test_expect_success 'git mv moves a submodule with a .git directory and .gitmodu
>   	(
>   		cd sub &&
>   		rm -f .git &&
> -		cp -R -P -p ../.git/modules/sub .git &&
> +		cp -R -P -p ../.git/submodules/sub .git &&
>   		GIT_WORK_TREE=. git config --unset core.worktree
>   	) &&
>   	mkdir mod &&
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index fd3e7e355e..178c386212 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -163,7 +163,7 @@ test_expect_success 'submodule add' '
>   		cd addtest &&
>   		git submodule add -q "$submodurl" submod >actual &&
>   		test_must_be_empty actual &&
> -		echo "gitdir: ../.git/modules/submod" >expect &&
> +		echo "gitdir: ../.git/submodules/submod" >expect &&
>   		test_cmp expect submod/.git &&
>   		(
>   			cd submod &&
> @@ -976,21 +976,21 @@ test_expect_success 'submodule add --name allows to replace a submodule with ano
>   			echo "$submodurl/repo" >expect &&
>   			git config remote.origin.url >actual &&
>   			test_cmp expect actual &&
> -			echo "gitdir: ../.git/modules/repo" >expect &&
> +			echo "gitdir: ../.git/submodules/repo" >expect &&
>   			test_cmp expect .git
>   		) &&
>   		rm -rf repo &&
>   		git rm repo &&
>   		git submodule add -q --name repo_new "$submodurl/bare.git" repo >actual &&
>   		test_must_be_empty actual &&
> -		echo "gitdir: ../.git/modules/submod" >expect &&
> +		echo "gitdir: ../.git/submodules/submod" >expect &&
>   		test_cmp expect submod/.git &&
>   		(
>   			cd repo &&
>   			echo "$submodurl/bare.git" >expect &&
>   			git config remote.origin.url >actual &&
>   			test_cmp expect actual &&
> -			echo "gitdir: ../.git/modules/repo_new" >expect &&
> +			echo "gitdir: ../.git/submodules/repo_new" >expect &&
>   			test_cmp expect .git
>   		) &&
>   		echo "repo" >expect &&
> @@ -1045,8 +1045,8 @@ test_expect_success 'recursive relative submodules stay relative' '
>   	(
>   		cd clone2 &&
>   		git submodule update --init --recursive &&
> -		echo "gitdir: ../.git/modules/sub3" >./sub3/.git_expect &&
> -		echo "gitdir: ../../../.git/modules/sub3/modules/dirdir/subsub" >./sub3/dirdir/subsub/.git_expect
> +		echo "gitdir: ../.git/submodules/sub3" >./sub3/.git_expect &&
> +		echo "gitdir: ../../../.git/submodules/sub3/submodules/dirdir/subsub" >./sub3/dirdir/subsub/.git_expect
>   	) &&
>   	test_cmp clone2/sub3/.git_expect clone2/sub3/.git &&
>   	test_cmp clone2/sub3/dirdir/subsub/.git_expect clone2/sub3/dirdir/subsub/.git
> @@ -1108,8 +1108,8 @@ test_expect_success 'submodule deinit should remove the whole submodule section
>   '
>   
>   test_expect_success 'submodule deinit should unset core.worktree' '
> -	test_path_is_file .git/modules/example/config &&
> -	test_must_fail git config -f .git/modules/example/config core.worktree
> +	test_path_is_file .git/submodules/example/config &&
> +	test_must_fail git config -f .git/submodules/example/config core.worktree
>   '
>   
>   test_expect_success 'submodule deinit from subdirectory' '
> @@ -1231,7 +1231,7 @@ test_expect_success 'submodule deinit absorbs .git directory if .git is a direct
>   	(
>   		cd init &&
>   		rm .git &&
> -		mv ../.git/modules/example .git &&
> +		mv ../.git/submodules/example .git &&
>   		GIT_WORK_TREE=. git config --unset core.worktree
>   	) &&
>   	git submodule deinit init &&
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 3adab12091..f0c4da1ffa 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -864,7 +864,7 @@ test_expect_success 'submodule add places git-dir in superprojects git-dir' '
>   	 (cd deeper/submodule &&
>   	  git log > ../../expected
>   	 ) &&
> -	 (cd .git/modules/deeper/submodule &&
> +	 (cd .git/submodules/deeper/submodule &&
>   	  git log > ../../../../actual
>   	 ) &&
>   	 test_cmp expected actual
> @@ -882,7 +882,7 @@ test_expect_success 'submodule update places git-dir in superprojects git-dir' '
>   	 (cd deeper/submodule &&
>   	  git log > ../../expected
>   	 ) &&
> -	 (cd .git/modules/deeper/submodule &&
> +	 (cd .git/submodules/deeper/submodule &&
>   	  git log > ../../../../actual
>   	 ) &&
>   	 test_cmp expected actual
> @@ -899,7 +899,7 @@ test_expect_success 'submodule add places git-dir in superprojects git-dir recur
>   	  git commit -m "added subsubmodule" &&
>   	  git push origin :
>   	 ) &&
> -	 (cd .git/modules/deeper/submodule/modules/subsubmodule &&
> +	 (cd .git/submodules/deeper/submodule/submodules/subsubmodule &&
>   	  git log > ../../../../../actual
>   	 ) &&
>   	 git add deeper/submodule &&
> @@ -949,7 +949,7 @@ test_expect_success 'submodule update places git-dir in superprojects git-dir re
>   	 (cd submodule/subsubmodule &&
>   	  git log > ../../expected
>   	 ) &&
> -	 (cd .git/modules/submodule/modules/subsubmodule &&
> +	 (cd .git/submodules/submodule/submodules/subsubmodule &&
>   	  git log > ../../../../../actual
>   	 ) &&
>   	 test_cmp expected actual
> @@ -1298,7 +1298,7 @@ test_expect_success CASE_INSENSITIVE_FS,SYMLINKS \
>   	git init captain &&
>   	(
>   		cd captain &&
> -		git submodule add --name x/y "$hook_repo_path" A/modules/x &&
> +		git submodule add --name x/y "$hook_repo_path" A/submodules/x &&
>   		test_tick &&
>   		git commit -m add-submodule &&
>   
> diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
> index 77b6d0040e..75ba826968 100755
> --- a/t/t7407-submodule-foreach.sh
> +++ b/t/t7407-submodule-foreach.sh
> @@ -368,9 +368,9 @@ test_expect_success 'test "update --recursive" with a flag with spaces' '
>   		git rev-parse --resolve-git-dir nested1/.git &&
>   		git rev-parse --resolve-git-dir nested1/nested2/.git &&
>   		git rev-parse --resolve-git-dir nested1/nested2/nested3/.git &&
> -		test -f .git/modules/nested1/objects/info/alternates &&
> -		test -f .git/modules/nested1/modules/nested2/objects/info/alternates &&
> -		test -f .git/modules/nested1/modules/nested2/modules/nested3/objects/info/alternates
> +		test -f .git/submodules/nested1/objects/info/alternates &&
> +		test -f .git/submodules/nested1/submodules/nested2/objects/info/alternates &&
> +		test -f .git/submodules/nested1/submodules/nested2/submodules/nested3/objects/info/alternates
>   	)
>   '
>   
> diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
> index f860e7bbf4..25f4aec57e 100755
> --- a/t/t7408-submodule-reference.sh
> +++ b/t/t7408-submodule-reference.sh
> @@ -61,7 +61,7 @@ test_expect_success 'submodule add --reference uses alternates' '
>   		git commit -m B-super-added &&
>   		git repack -ad
>   	) &&
> -	test_alternate_is_used super/.git/modules/sub/objects/info/alternates super/sub
> +	test_alternate_is_used super/.git/submodules/sub/objects/info/alternates super/sub
>   '
>   
>   test_expect_success 'submodule add --reference with --dissociate does not use alternates' '
> @@ -71,7 +71,7 @@ test_expect_success 'submodule add --reference with --dissociate does not use al
>   		git commit -m B-super-added &&
>   		git repack -ad
>   	) &&
> -	test_path_is_missing super/.git/modules/sub-dissociate/objects/info/alternates
> +	test_path_is_missing super/.git/submodules/sub-dissociate/objects/info/alternates
>   '
>   
>   test_expect_success 'that reference gets used with add' '
> @@ -94,14 +94,14 @@ test_expect_success 'updating superproject keeps alternates' '
>   	test_when_finished "rm -rf super-clone" &&
>   	git clone super super-clone &&
>   	git -C super-clone submodule update --init --reference ../B &&
> -	test_alternate_is_used super-clone/.git/modules/sub/objects/info/alternates super-clone/sub
> +	test_alternate_is_used super-clone/.git/submodules/sub/objects/info/alternates super-clone/sub
>   '
>   
>   test_expect_success 'updating superproject with --dissociate does not keep alternates' '
>   	test_when_finished "rm -rf super-clone" &&
>   	git clone super super-clone &&
>   	git -C super-clone submodule update --init --reference ../B --dissociate &&
> -	test_path_is_missing super-clone/.git/modules/sub/objects/info/alternates
> +	test_path_is_missing super-clone/.git/submodules/sub/objects/info/alternates
>   '
>   
>   test_expect_success 'submodules use alternates when cloning a superproject' '
> @@ -112,7 +112,7 @@ test_expect_success 'submodules use alternates when cloning a superproject' '
>   		# test superproject has alternates setup correctly
>   		test_alternate_is_used .git/objects/info/alternates . &&
>   		# test submodule has correct setup
> -		test_alternate_is_used .git/modules/sub/objects/info/alternates sub
> +		test_alternate_is_used .git/submodules/sub/objects/info/alternates sub
>   	)
>   '
>   
> @@ -127,7 +127,7 @@ test_expect_success 'missing submodule alternate fails clone and submodule updat
>   		# update of the submodule succeeds
>   		test_must_fail git submodule update --init &&
>   		# and we have no alternates:
> -		test_path_is_missing .git/modules/sub/objects/info/alternates &&
> +		test_path_is_missing .git/submodules/sub/objects/info/alternates &&
>   		test_path_is_missing sub/file1
>   	)
>   '
> @@ -142,7 +142,7 @@ test_expect_success 'ignoring missing submodule alternates passes clone and subm
>   		# update of the submodule succeeds
>   		git submodule update --init &&
>   		# and we have no alternates:
> -		test_path_is_missing .git/modules/sub/objects/info/alternates &&
> +		test_path_is_missing .git/submodules/sub/objects/info/alternates &&
>   		test_path_is_file sub/file1
>   	)
>   '
> @@ -176,18 +176,18 @@ test_expect_success 'nested submodule alternate in works and is actually used' '
>   		# test superproject has alternates setup correctly
>   		test_alternate_is_used .git/objects/info/alternates . &&
>   		# immediate submodule has alternate:
> -		test_alternate_is_used .git/modules/subwithsub/objects/info/alternates subwithsub &&
> +		test_alternate_is_used .git/submodules/subwithsub/objects/info/alternates subwithsub &&
>   		# nested submodule also has alternate:
> -		test_alternate_is_used .git/modules/subwithsub/modules/sub/objects/info/alternates subwithsub/sub
> +		test_alternate_is_used .git/submodules/subwithsub/submodules/sub/objects/info/alternates subwithsub/sub
>   	)
>   '
>   
>   check_that_two_of_three_alternates_are_used() {
>   	test_alternate_is_used .git/objects/info/alternates . &&
>   	# immediate submodule has alternate:
> -	test_alternate_is_used .git/modules/subwithsub/objects/info/alternates subwithsub &&
> +	test_alternate_is_used .git/submodules/subwithsub/objects/info/alternates subwithsub &&
>   	# but nested submodule has no alternate:
> -	test_path_is_missing .git/modules/subwithsub/modules/sub/objects/info/alternates
> +	test_path_is_missing .git/submodules/subwithsub/submodules/sub/objects/info/alternates
>   }
>   
>   
> diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
> index 0490499573..dbaca9c69f 100755
> --- a/t/t7412-submodule-absorbgitdirs.sh
> +++ b/t/t7412-submodule-absorbgitdirs.sh
> @@ -29,13 +29,13 @@ test_expect_success 'absorb the git dir' '
>   	cat >expect <<-EOF &&
>   	Migrating git directory of '\''sub1'\'' from
>   	'\''$cwd/sub1/.git'\'' to
> -	'\''$cwd/.git/modules/sub1'\''
> +	'\''$cwd/.git/submodules/sub1'\''
>   	EOF
>   	git submodule absorbgitdirs 2>actual &&
>   	test_cmp expect actual &&
>   	git fsck &&
>   	test -f sub1/.git &&
> -	test -d .git/modules/sub1 &&
> +	test -d .git/submodules/sub1 &&
>   	git status >actual.1 &&
>   	git -C sub1 rev-parse HEAD >actual.2 &&
>   	test_cmp expect.1 actual.1 &&
> @@ -47,7 +47,7 @@ test_expect_success 'absorbing does not fail for deinitialized submodules' '
>   	git submodule deinit --all &&
>   	git submodule absorbgitdirs 2>err &&
>   	test_must_be_empty err &&
> -	test -d .git/modules/sub1 &&
> +	test -d .git/submodules/sub1 &&
>   	test -d sub1 &&
>   	! test -e sub1/.git
>   '
> @@ -68,12 +68,12 @@ test_expect_success 'absorb the git dir in a nested submodule' '
>   	cat >expect <<-EOF &&
>   	Migrating git directory of '\''sub1/nested'\'' from
>   	'\''$cwd/sub1/nested/.git'\'' to
> -	'\''$cwd/.git/modules/sub1/modules/nested'\''
> +	'\''$cwd/.git/submodules/sub1/submodules/nested'\''
>   	EOF
>   	git submodule absorbgitdirs 2>actual &&
>   	test_cmp expect actual &&
>   	test -f sub1/nested/.git &&
> -	test -d .git/modules/sub1/modules/nested &&
> +	test -d .git/submodules/sub1/submodules/nested &&
>   	git status >actual.1 &&
>   	git -C sub1/nested rev-parse HEAD >actual.2 &&
>   	test_cmp expect.1 actual.1 &&
> @@ -84,11 +84,11 @@ test_expect_success 're-setup nested submodule' '
>   	# un-absorb the direct submodule, to test if the nested submodule
>   	# is still correct (needs a rewrite of the gitfile only)
>   	rm -rf sub1/.git &&
> -	mv .git/modules/sub1 sub1/.git &&
> +	mv .git/submodules/sub1 sub1/.git &&
>   	GIT_WORK_TREE=. git -C sub1 config --unset core.worktree &&
>   	# fixup the nested submodule
> -	echo "gitdir: ../.git/modules/nested" >sub1/nested/.git &&
> -	GIT_WORK_TREE=../../../nested git -C sub1/.git/modules/nested config \
> +	echo "gitdir: ../.git/submodules/nested" >sub1/nested/.git &&
> +	GIT_WORK_TREE=../../../nested git -C sub1/.git/submodules/nested config \
>   		core.worktree "../../../nested" &&
>   	# make sure this re-setup is correct
>   	git status --ignore-submodules=none &&
> @@ -105,13 +105,13 @@ test_expect_success 'absorb the git dir in a nested submodule' '
>   	cat >expect <<-EOF &&
>   	Migrating git directory of '\''sub1'\'' from
>   	'\''$cwd/sub1/.git'\'' to
> -	'\''$cwd/.git/modules/sub1'\''
> +	'\''$cwd/.git/submodules/sub1'\''
>   	EOF
>   	git submodule absorbgitdirs 2>actual &&
>   	test_cmp expect actual &&
>   	test -f sub1/.git &&
>   	test -f sub1/nested/.git &&
> -	test -d .git/modules/sub1/modules/nested &&
> +	test -d .git/submodules/sub1/submodules/nested &&
>   	git status >actual.1 &&
>   	git -C sub1/nested rev-parse HEAD >actual.2 &&
>   	test_cmp expect.1 actual.1 &&
> @@ -133,7 +133,7 @@ test_expect_success 'absorb the git dir outside of primary worktree' '
>   	cat >expect <<-EOF &&
>   	Migrating git directory of '\''sub2'\'' from
>   	'\''$cwd/repo-wt/sub2/.git'\'' to
> -	'\''$cwd/repo-bare.git/worktrees/repo-wt/modules/sub2'\''
> +	'\''$cwd/repo-bare.git/worktrees/repo-wt/submodules/sub2'\''
>   	EOF
>   	git -C repo-wt submodule absorbgitdirs 2>actual &&
>   	test_cmp expect actual
> diff --git a/t/t7423-submodule-symlinks.sh b/t/t7423-submodule-symlinks.sh
> index 3d3c7af3ce..a51235136d 100755
> --- a/t/t7423-submodule-symlinks.sh
> +++ b/t/t7423-submodule-symlinks.sh
> @@ -49,19 +49,19 @@ test_expect_success SYMLINKS 'git restore --recurse-submodules must not be confu
>   
>   test_expect_success SYMLINKS 'git restore --recurse-submodules must not migrate git dir of symlinked repo' '
>   	prepare_symlink_to_repo &&
> -	rm -rf .git/modules &&
> +	rm -rf .git/submodules &&
>   	test_must_fail git restore --recurse-submodules a/sm &&
>   	test_path_is_dir a/target/.git &&
> -	test_path_is_missing .git/modules/a/sm &&
> +	test_path_is_missing .git/submodules/a/sm &&
>   	test_path_is_missing a/target/submodule_file
>   '
>   
>   test_expect_success SYMLINKS 'git checkout -f --recurse-submodules must not migrate git dir of symlinked repo when removing submodule' '
>   	prepare_symlink_to_repo &&
> -	rm -rf .git/modules &&
> +	rm -rf .git/submodules &&
>   	test_must_fail git checkout -f --recurse-submodules initial &&
>   	test_path_is_dir a/target/.git &&
> -	test_path_is_missing .git/modules/a/sm
> +	test_path_is_missing .git/submodules/a/sm
>   '
>   
>   test_done
> diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
> index f512eed278..4e2ced3636 100755
> --- a/t/t7450-bad-git-dotfiles.sh
> +++ b/t/t7450-bad-git-dotfiles.sh
> @@ -77,28 +77,28 @@ test_expect_success 'create innocent subrepo' '
>   
>   test_expect_success 'submodule add refuses invalid names' '
>   	test_must_fail \
> -		git submodule add --name ../../modules/evil "$PWD/innocent" evil
> +		git submodule add --name ../../submodules/evil "$PWD/innocent" evil
>   '
>   
>   test_expect_success 'add evil submodule' '
>   	git submodule add "$PWD/innocent" evil &&
>   
> -	mkdir modules &&
> -	cp -r .git/modules/evil modules &&
> -	write_script modules/evil/hooks/post-checkout <<-\EOF &&
> +	mkdir submodules &&
> +	cp -r .git/submodules/evil submodules &&
> +	write_script submodules/evil/hooks/post-checkout <<-\EOF &&
>   	echo >&2 "RUNNING POST CHECKOUT"
>   	EOF
>   
>   	git config -f .gitmodules submodule.evil.update checkout &&
>   	git config -f .gitmodules --rename-section \
> -		submodule.evil submodule.../../modules/evil &&
> -	git add modules &&
> +		submodule.evil submodule.../../submodules/evil &&
> +	git add submodules &&
>   	git commit -am evil
>   '
>   
>   # This step seems like it shouldn't be necessary, since the payload is
>   # contained entirely in the evil submodule. But due to the vagaries of the
> -# submodule code, checking out the evil module will fail unless ".git/modules"
> +# submodule code, checking out the evil module will fail unless ".git/submodules"
>   # exists. Adding another submodule (with a name that sorts before "evil") is an
>   # easy way to make sure this is the case in the victim clone.
>   test_expect_success 'add other submodule' '
> @@ -350,8 +350,8 @@ test_expect_success 'submodule git dir nesting detection must work with parallel
>   	cat err &&
>   	grep -E "(already exists|is inside git dir|not a git repository)" err &&
>   	{
> -		test_path_is_missing .git/modules/hippo/HEAD ||
> -		test_path_is_missing .git/modules/hippo/hooks/HEAD
> +		test_path_is_missing .git/submodules/hippo/HEAD ||
> +		test_path_is_missing .git/submodules/hippo/hooks/HEAD
>   	}
>   '
>   
> @@ -361,10 +361,10 @@ test_expect_success 'checkout -f --recurse-submodules must not use a nested gitd
>   		cd nested_checkout &&
>   		git submodule init &&
>   		git submodule update thing1 &&
> -		mkdir -p .git/modules/hippo/hooks/refs &&
> -		mkdir -p .git/modules/hippo/hooks/objects/info &&
> -		echo "../../../../objects" >.git/modules/hippo/hooks/objects/info/alternates &&
> -		echo "ref: refs/heads/master" >.git/modules/hippo/hooks/HEAD
> +		mkdir -p .git/submodules/hippo/hooks/refs &&
> +		mkdir -p .git/submodules/hippo/hooks/objects/info &&
> +		echo "../../../../objects" >.git/submodules/hippo/hooks/objects/info/alternates &&
> +		echo "ref: refs/heads/master" >.git/submodules/hippo/hooks/HEAD
>   	) &&
>   	test_must_fail git -C nested_checkout checkout -f --recurse-submodules HEAD 2>err &&
>   	cat err &&
> @@ -390,13 +390,13 @@ test_expect_success SYMLINKS,!WINDOWS,!MINGW 'submodule must not checkout into d
>   	git config unset -f repo/.gitmodules submodule.sub.path &&
>   	printf "\tpath = \"sub\r\"\n" >>repo/.gitmodules &&
>   
> -	git config unset -f repo/.git/modules/sub/config core.worktree &&
> +	git config unset -f repo/.git/submodules/sub/config core.worktree &&
>   	{
>   		printf "[core]\n" &&
>   		printf "\tworktree = \"../../../sub\r\"\n"
> -	} >>repo/.git/modules/sub/config &&
> +	} >>repo/.git/submodules/sub/config &&
>   
> -	ln -s .git/modules/sub/hooks repo/sub &&
> +	ln -s .git/submodules/sub/hooks repo/sub &&
>   	git -C repo add -A &&
>   	git -C repo commit -m submodule &&
>   
> diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
> index 409cd0cd12..ded482fdf2 100755
> --- a/t/t7527-builtin-fsmonitor.sh
> +++ b/t/t7527-builtin-fsmonitor.sh
> @@ -866,7 +866,7 @@ test_expect_success 'submodule always visited' '
>   '
>   
>   # If a submodule has a `sub/.git/` directory (rather than a file
> -# pointing to the super's `.git/modules/sub`) and `core.fsmonitor`
> +# pointing to the super's `.git/submodules/sub`) and `core.fsmonitor`
>   # turned on in the submodule and the daemon is not yet started in
>   # the submodule, and someone does a `git submodule absorbgitdirs`
>   # in the super, Git will recursively invoke `git submodule--helper`
> @@ -895,7 +895,7 @@ test_expect_success "submodule absorbgitdirs implicitly starts daemon" '
>   	cat >expect <<-EOF &&
>   	Migrating git directory of '\''dir_1/dir_2/sub'\'' from
>   	'\''$cwd/dir_1/dir_2/sub/.git'\'' to
> -	'\''$cwd/.git/modules/dir_1/dir_2/sub'\''
> +	'\''$cwd/.git/submodules/dir_1/dir_2/sub'\''
>   	EOF
>   	GIT_TRACE2_EVENT="$PWD/super-sub.trace" \
>   		git -C super submodule absorbgitdirs >out 2>actual &&

