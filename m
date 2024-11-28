Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F1B14A08E
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732805097; cv=none; b=PwdcBd4acUv1Nr4jsu0C5F/L55Cn3orDGUthWmpUgPTbW1ZKefjbdm/2eCbXLnwFnDCQjOLoxUCw1yKqw0Ic17dmPobUcsnFAMnbUmDvXFnzmAQqrQkbBcztRKm2xGTv2xwMl9ALdsN+qBX22WSPab8hwfNXJWk/kWqNt4ABmwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732805097; c=relaxed/simple;
	bh=mDgyYjPQZqQpsakcfpEq7U+9nBmMPxJGobgg4ob5kcg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=H18Z3UwFj7OFiBu1GtdaM75ZqKiudLbkjDVONcghIzwc8FBp/oI42iVBKfMtervf4XVIh1/DNte4i3A1tTChsypXP/M7IcxUXSocSi+LuRPWBGYLSAtxJec37kwAew89VG+3Xl9Z6LylWQpxFSLh+VGqM0L3CZirJNvzGJNmwo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDMdtOzI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDMdtOzI"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4349e1467fbso7805425e9.1
        for <git@vger.kernel.org>; Thu, 28 Nov 2024 06:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732805093; x=1733409893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U/L0Ty7N7w70UQiMte/v06axuZ+d7B8kIvamsrvTi+M=;
        b=RDMdtOzIq8SH581qbutL8gbobkXSAV45SEt7/8NNgjMk4NNZB/Yc3XDcYzowp5aM8A
         E1gyV2IHz1rpXMImwnQ92h7YcSchFpYfwf+i4gY7EyQ49F5bC8DZRBAIwv4jMOZ7EkQ5
         b/6ZNrR4bycn2OLe/7OkibjtDP/hRVWn9xh5VxKSJY/A6fwtWI7nW4J62ky+nEXQI+19
         PTh0TVet/b32A28gI3tHi6gDFFekKsPaOYpVS8g2p/wrxaw9Gpu8aaggZX4wfoGrNXRE
         eqgTWBFGyhaHPpaT0obkYv+eDl1//CqjKhKX4Pb+5SDbtf1ATv8DVy4VYkE/FotYDAVb
         Q8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732805093; x=1733409893;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/L0Ty7N7w70UQiMte/v06axuZ+d7B8kIvamsrvTi+M=;
        b=Vr9K+B1sA9qCmxLnkX6F6hHCXM6Ls4Ah7skj2Va76WNDV80ewFZFbkPjaEdcs37yjJ
         HcRYeXjLSgBMkFm/uMSSUzQTG5d0UR0FvlVv3rNKlLnLJYsi89c0EY2Wus5B5WOfDEtl
         lgFz4qZitUXag19aawF/naRaHUZg0Cc9CImTMv1c9QtXC7TqGHu98yVANcQu3pOuHcER
         Ni2CRg6Ta0Aim51FvNMhpkAU2H6rjpGiBGIn7ztxKucAsV2pWWq3DeCXwjqQCcei/1aw
         eNI6H+TpNU7Tz6+DOwUoXJ8x0VvYKV2cgmL23UZAdowS8nvy+Yw95m2wbhDeLZySv344
         2MDg==
X-Forwarded-Encrypted: i=1; AJvYcCUakr0nkGZqSP7+VX0iy0Is4xbEYgRX2+Feyv9A3GYSEVbT/Un7sYkkg7qWhVBtyKIReJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr+MZ5OFxLaOz4gjOb4s1mPQZ2m/uoJMc2O2SO1XQMzJJj8ufA
	7MfN5a//TNTJyOJs8h+lvi9vp8D0S2hM1zS7jZ+ysOvRNdX+2Gh2
X-Gm-Gg: ASbGnct7wxe36r1pTYVwENnwIWOc4VY4pL0G2652ua9fqoCTX7n3Byq3HtOrMrapxuq
	pzVrVJry5mWEnOV9uXeS6TR3bW4lgaaOJoMceiPZZ/HgFj4b161ytBltJ6KmGQsI6BRpTT0EMiS
	aFB0MlWb9mdh0y60F5ZEmiql1G/UGwemhDf8p4RPUawlCJ4f28gJ/Y1oVZnJ3w1mNRRsSQK/nzS
	kt3GM+S8BnL+8pTtIbAHFvsuZ3Dz3trvjbeRsJ4eND6BHyvQfr/KA9Mo/d/YTVeOYqJJ4SXhaii
	HVchhlGfE/TG8hztj+dLi03K3QOr
X-Google-Smtp-Source: AGHT+IH1bOT5duj7DAdj5kpuNelQRUglnpRSp2lkbiO/auaw1OT79htyKXw9h4IGVnmWS3opKzgA0Q==
X-Received: by 2002:a05:600c:3585:b0:432:d82d:6a6c with SMTP id 5b1f17b1804b1-434a9dfc448mr73073135e9.30.1732805092956;
        Thu, 28 Nov 2024 06:44:52 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6f7:6401:d76b:efc0:c762:b74b? ([2a0a:ef40:6f7:6401:d76b:efc0:c762:b74b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74edb1sm57120805e9.3.2024.11.28.06.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 06:44:52 -0800 (PST)
Message-ID: <054b70c2-accd-4d85-a576-66910d35a26d@gmail.com>
Date: Thu, 28 Nov 2024 14:44:51 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/8] Allow relative worktree linking to be configured
 by the user
To: Caleb White <cdwhite3@pm.me>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
 <20241125-wt_relative_options-v5-0-356d122ff3db@pm.me>
Content-Language: en-US
In-Reply-To: <20241125-wt_relative_options-v5-0-356d122ff3db@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Caleb

On 26/11/2024 01:51, Caleb White wrote:
> Changes in v5:
> - Added docs to `--relative-paths` option.
> - Added test coverage for `repair_worktrees()` and relative paths.
> - Move `strbuf_reset` call in `infer_backlink()`.
> - Cleaned up tests.
> - Slight stylistic changes.
> - Tweaked commit messages.
> - Updated base to 090d24e9af.

Thanks for re-rolling, these changes sound good. Below is the
range-diff of what is in seen today compared to last week. I've left
it untrimmed so other people can check what's changed and I've added a
couple of comments. The only thing I'm worried about is the deletion
of a check for setting extensions.relativeWorktrees in patch 5 the
rest of the changes look good, thank you for the extra test checks and
log messages.

Best Wishes

Phillip

1:  67a622c7f2 ! 1:  0986f98022 setup: correctly reinitialize repository version
     @@ Commit message
          config to ensure that the repository version is set correctly.
      
          Signed-off-by: Caleb White <cdwhite3@pm.me>
     -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## setup.c ##
      @@ setup.c: void initialize_repository_version(int hash_algo,
2:  85964909b0 ! 2:  c36e1a59fa worktree: add `relativeWorktrees` extension
     @@ Commit message
      
          Suggested-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Caleb White <cdwhite3@pm.me>
     -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## Documentation/config/extensions.txt ##
      @@ Documentation/config/extensions.txt: Note that this setting should only be set by linkgit:git-init[1] or
3:  a614c39333 ! 3:  5b19b63040 worktree: refactor infer_backlink return
     @@ Commit message
          [1]: https://lore.kernel.org/git/20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me
      
          Signed-off-by: Caleb White <cdwhite3@pm.me>
     -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## worktree.c ##
      @@ worktree.c: struct worktree *get_linked_worktree(const char *id,
     @@ worktree.c: static int is_main_worktree_path(const char *path)
       {
       	struct strbuf actual = STRBUF_INIT;
       	const char *id;
     -
     -+	strbuf_reset(inferred);
     - 	if (strbuf_read_file(&actual, gitfile, 0) < 0)
     - 		goto error;
     - 	if (!starts_with(actual.buf, "gitdir:"))
      @@ worktree.c: static int infer_backlink(const char *gitfile, struct strbuf *inferred)
     - 	id++; /* advance past '/' to point at <id> */
     - 	if (!*id)
     - 		goto error;
     --	strbuf_reset(inferred);
     - 	strbuf_git_common_path(inferred, the_repository, "worktrees/%s", id);
     - 	if (!is_directory(inferred->buf))
       		goto error;
       
       	strbuf_release(&actual);
4:  83ea6d7ba0 ! 4:  ec143ae00e worktree: add `write_worktree_linking_files()` function
     @@ Commit message
          is linked with relative paths.
      
          Signed-off-by: Caleb White <cdwhite3@pm.me>
     -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## worktree.c ##
      @@ worktree.c: int init_worktree_config(struct repository *r)
       	free(main_worktree_file);
       	return res;
       }
      +
     -+void write_worktree_linking_files(struct strbuf dotgit,
     -+				  struct strbuf gitdir,
     ++void write_worktree_linking_files(struct strbuf dotgit, struct strbuf gitdir,
      +				  int use_relative_paths)
      +{
      +	struct strbuf path = STRBUF_INIT;
     @@ worktree.h: void strbuf_worktree_ref(const struct worktree *wt,
      + *  dotgit: "/path/to/foo/.git"
      + *  gitdir: "/path/to/repo/worktrees/foo/gitdir"
      + */
     -+void write_worktree_linking_files(struct strbuf dotgit,
     -+				  struct strbuf gitdir,
     ++void write_worktree_linking_files(struct strbuf dotgit, struct strbuf gitdir,
      +				  int use_relative_paths);
      +
       #endif
5:  36d01dca84 ! 5:  237206b08f worktree: add relative cli/config options to `add` command
     @@ Commit message
          written for the various worktree operations in their own files.
      
          Signed-off-by: Caleb White <cdwhite3@pm.me>
     -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## Documentation/config/worktree.txt ##
      @@ Documentation/config/worktree.txt: worktree.guessRemote::
     @@ Documentation/git-worktree.txt: To remove a locked worktree, specify `--force` t
       `worktree.guessRemote` config option.
       
      +--[no-]relative-paths::
     ++	Link worktrees using relative paths or absolute paths (default).
      +	Overrides the `worktree.useRelativePaths` config option, see
      +	linkgit:git-config[1].
      +
     @@ t/t2400-worktree-add.sh: test_expect_success '"add" with initialized submodule,
       
      +test_expect_success 'can create worktrees with relative paths' '
      +	test_when_finished "git worktree remove relative" &&
     -+	git config worktree.useRelativePaths false &&
     ++	test_config worktree.useRelativePaths false &&
      +	git worktree add --relative-paths ./relative &&
     -+	cat relative/.git >actual &&
      +	echo "gitdir: ../.git/worktrees/relative" >expect &&
     -+	test_cmp expect actual &&
     -+	cat .git/worktrees/relative/gitdir >actual &&
     ++	test_cmp expect relative/.git &&
      +	echo "../../../relative/.git" >expect &&
     -+	test_cmp expect actual
     -+
     ++	test_cmp expect .git/worktrees/relative/gitdir
      +'
      +
      +test_expect_success 'can create worktrees with absolute paths' '
     -+	git config worktree.useRelativePaths true &&
     ++	test_config worktree.useRelativePaths true &&
      +	git worktree add ./relative &&
     -+	cat relative/.git >actual &&
      +	echo "gitdir: ../.git/worktrees/relative" >expect &&
     -+	test_cmp expect actual &&
     ++	test_cmp expect relative/.git &&
      +	git worktree add --no-relative-paths ./absolute &&
     -+	cat absolute/.git >actual &&
      +	echo "gitdir: $(pwd)/.git/worktrees/absolute" >expect &&
     -+	test_cmp expect actual
     ++	test_cmp expect absolute/.git &&
     ++	echo "$(pwd)/absolute/.git" >expect &&
     ++	test_cmp expect .git/worktrees/absolute/gitdir
      +'
      +
      +test_expect_success 'move repo without breaking relative internal links' '
      +	test_when_finished rm -rf repo moved &&
      +	git init repo &&
      +	(
      +		cd repo &&
     -+		git config worktree.useRelativePaths true &&
      +		test_commit initial &&
     -+		git worktree add wt1 &&
     ++		git worktree add --relative-paths wt1 &&
      +		cd .. &&
      +		mv repo moved &&
      +		cd moved/wt1 &&
     -+		git status >out 2>err &&
     ++		git worktree list >out 2>err &&
      +		test_must_be_empty err
      +	)
      +'
     @@ t/t2400-worktree-add.sh: test_expect_success '"add" with initialized submodule,
      +	git init repo &&
      +	git -C repo commit --allow-empty -m base &&
      +	git -C repo worktree add --relative-paths ./foo &&
     -+	git -C repo config get core.repositoryformatversion >actual &&
     -+	echo 1 >expected &&
     -+	test_cmp expected actual &&
     -+	git -C repo config get extensions.relativeworktrees >actual &&
     -+	echo true >expected &&
     -+	test_cmp expected actual
     ++	test_cmp_config -C repo 1 core.repositoryformatversion
      +'

We have lost the check for extensions.relativeworktrees
here. Although we don't set worktree.useRelativePaths anymore we
should still set the extension as we pase --relative-paths to "git
worktree add"

+
       test_done
6:  34401d680c ! 6:  8e4307f520 worktree: add relative cli/config options to `move` command
     @@ Commit message
          the new path will be relative (and visa-versa).
      
          Signed-off-by: Caleb White <cdwhite3@pm.me>
     -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## builtin/worktree.c ##
      @@ builtin/worktree.c: static int move_worktree(int ac, const char **av, const char *prefix)
     @@ t/t2403-worktree-move.sh: test_expect_success 'not remove a repo with initialize
       '
       
      +test_expect_success 'move worktree with absolute path to relative path' '
     -+	git config worktree.useRelativePaths false &&
     ++	test_config worktree.useRelativePaths false &&
      +	git worktree add ./absolute &&
      +	git worktree move --relative-paths absolute relative &&
     -+	cat relative/.git >actual &&
      +	echo "gitdir: ../.git/worktrees/absolute" >expect &&
     -+	test_cmp expect actual &&
     -+	git config worktree.useRelativePaths true &&
     ++	test_cmp expect relative/.git &&
     ++	echo "../../../relative/.git" >expect &&
     ++	test_cmp expect .git/worktrees/absolute/gitdir &&
     ++	test_config worktree.useRelativePaths true &&
      +	git worktree move relative relative2 &&
     -+	cat relative2/.git >actual &&
      +	echo "gitdir: ../.git/worktrees/absolute" >expect &&
     -+	test_cmp expect actual
     ++	test_cmp expect relative2/.git &&
     ++	echo "../../../relative2/.git" >expect &&
     ++	test_cmp expect .git/worktrees/absolute/gitdir
      +'
      +
      +test_expect_success 'move worktree with relative path to absolute path' '
     -+	git config worktree.useRelativePaths true &&
     ++	test_config worktree.useRelativePaths true &&
      +	git worktree move --no-relative-paths relative2 absolute &&
     -+	cat absolute/.git >actual &&
      +	echo "gitdir: $(pwd)/.git/worktrees/absolute" >expect &&
     -+	test_cmp expect actual
     ++	test_cmp expect absolute/.git &&
     ++	echo "$(pwd)/absolute/.git" >expect &&
     ++	test_cmp expect .git/worktrees/absolute/gitdir
      +'
      +
       test_done
     @@ worktree.c: int validate_worktree(const struct worktree *wt, struct strbuf *errm
       }
       
      -void update_worktree_location(struct worktree *wt, const char *path_)
     -+void update_worktree_location(struct worktree *wt,
     -+			      const char *path_,
     ++void update_worktree_location(struct worktree *wt, const char *path_,
      +			      int use_relative_paths)
       {
       	struct strbuf path = STRBUF_INIT;
     @@ worktree.c: int validate_worktree(const struct worktree *wt, struct strbuf *errm
      
       ## worktree.h ##
      @@ worktree.h: int validate_worktree(const struct worktree *wt,
     + /*
        * Update worktrees/xxx/gitdir with the new path.
        */
     - void update_worktree_location(struct worktree *wt,
     +-void update_worktree_location(struct worktree *wt,
      -			      const char *path_);
     -+			      const char *path_,
     ++void update_worktree_location(struct worktree *wt, const char *path_,
      +			      int use_relative_paths);
       
       typedef void (* worktree_repair_fn)(int iserr, const char *path,
7:  30e9e41061 ! 7:  4f951f4088 worktree: add relative cli/config options to `repair` command
     @@ Commit message
          even if the original path was correct. This allows a user to covert
          existing worktrees between absolute/relative as desired.
      
     +    To simplify things, both linking files are written when one of the files
     +    needs to be repaired. In some cases, this fixes the other file before it
     +    is checked, in other cases this results in a correct file being written
     +    with the same contents.
     +

Thanks for adding this, I think it will be really helpful for anyone
trying to understand this change in the future.

          Signed-off-by: Caleb White <cdwhite3@pm.me>
     -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## Documentation/git-worktree.txt ##
      @@ Documentation/git-worktree.txt: This can also be set up as the default behaviour by using the
     - --[no-]relative-paths::
     + 	Link worktrees using relative paths or absolute paths (default).
       	Overrides the `worktree.useRelativePaths` config option, see
       	linkgit:git-config[1].
      ++
     @@ t/t2406-worktree-repair.sh: test_expect_success 'repair copied main and linked w
       	test_cmp dup/linked.expect dup/linked/.git
       '
       
     ++test_expect_success 'repair worktree with relative path with missing gitfile' '
     ++	test_when_finished "rm -rf main wt" &&
     ++	test_create_repo main &&
     ++	git -C main config worktree.useRelativePaths true &&
     ++	test_commit -C main init &&
     ++	git -C main worktree add --detach ../wt &&
     ++	rm wt/.git &&
     ++	test_path_is_missing wt/.git &&
     ++	git -C main worktree repair &&
     ++	echo "gitdir: ../main/.git/worktrees/wt" >expect &&
     ++	test_cmp expect wt/.git
     ++'
     ++
      +test_expect_success 'repair absolute worktree to use relative paths' '
      +	test_when_finished "rm -rf main side sidemoved" &&
      +	test_create_repo main &&
     @@ worktree.c: int other_head_refs(each_ref_fn fn, void *cb_data)
        */
       static void repair_gitfile(struct worktree *wt,
      -			   worktree_repair_fn fn, void *cb_data)
     -+			   worktree_repair_fn fn,
     -+			   void *cb_data,
     ++			   worktree_repair_fn fn, void *cb_data,
      +			   int use_relative_paths)
       {
       	struct strbuf dotgit = STRBUF_INIT;
     @@ worktree.c: static ssize_t infer_backlink(const char *gitfile, struct strbuf *in
        */
       void repair_worktree_at_path(const char *path,
      -			     worktree_repair_fn fn, void *cb_data)
     -+			     worktree_repair_fn fn,
     -+			     void *cb_data,
     ++			     worktree_repair_fn fn, void *cb_data,
      +			     int use_relative_paths)
       {
       	struct strbuf dotgit = STRBUF_INIT;
8:  298327f538 ! 8:  28eb7f66b2 worktree: refactor `repair_worktree_after_gitdir_move()`
     @@ Commit message
          `write_worktree_linking_files` function. It also preserves the
          relativity of the linking files; e.g., if an existing worktree used
          absolute paths then the repaired paths will be absolute (and visa-versa).
     +    `repair_worktree_after_gitdir_move()` is used to repair both sets of
     +    worktree linking files if the `.git` directory is moved during a
     +    re-initialization using `git init`.

Thanks for the extra explanation

          This also adds a test case for reinitializing a repository that has
          relative worktrees.
      
          Signed-off-by: Caleb White <cdwhite3@pm.me>
     -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## t/t0001-init.sh ##
      @@ t/t0001-init.sh: test_expect_success SYMLINKS 're-init to move gitdir symlink' '
     @@ t/t0001-init.sh: test_expect_success SYMLINKS 're-init to move gitdir symlink' '
       	git init mainwt &&
      +	if test "relative" = $2
      +	then
     -+		git -C mainwt config worktree.useRelativePaths true
     ++		test_config -C mainwt worktree.useRelativePaths true
      +	else
     -+		git -C mainwt config worktree.useRelativePaths false
     ++		test_config -C mainwt worktree.useRelativePaths false
      +	fi
       	test_commit -C mainwt gumby &&
       	git -C mainwt worktree add --detach ../linkwt &&

> - Link to v4: https://lore.kernel.org/r/20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me
> Changes in v4:
> - Fixed failing test in ci
> - Link to v3: https://lore.kernel.org/r/20241031-wt_relative_options-v3-0-3e44ccdf64e6@pm.me
> Changes in v3:
> - Split patches into smaller edits.
> - Moved tests into the patches with the relevant code changes.
> - Removed global `use_relative_paths` and instead pass parameter to functions.
> - Changed `infer_backlink` return type from `int` to `ssize_t`.
> - Updated `worktree.useRelativePaths` and `--relative-paths` descriptions.
> - Reordered patches
> - Link to v2: https://lore.kernel.org/r/20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me
> Changes in v2:
> - Fixed a bug where repositories with valid extensions would be downgraded
>    to v0 during reinitialization, causing future operations to fail.
> - Split patch [1/2] into three separate patches.
> - Updated cover letter and commit messages.
> - Updated documentation wording.
> - Link to v1: https://lore.kernel.org/r/20241025-wt_relative_options-v1-0-c3005df76bf9@pm.me
> 
> ---
> Caleb White (8):
>        setup: correctly reinitialize repository version
>        worktree: add `relativeWorktrees` extension
>        worktree: refactor infer_backlink return
>        worktree: add `write_worktree_linking_files()` function
>        worktree: add relative cli/config options to `add` command
>        worktree: add relative cli/config options to `move` command
>        worktree: add relative cli/config options to `repair` command
>        worktree: refactor `repair_worktree_after_gitdir_move()`
> 
>   Documentation/config/extensions.txt |   6 ++
>   Documentation/config/worktree.txt   |  10 +++
>   Documentation/git-worktree.txt      |   8 ++
>   builtin/worktree.c                  |  29 ++++---
>   repository.c                        |   1 +
>   repository.h                        |   1 +
>   setup.c                             |  39 ++++++---
>   setup.h                             |   1 +
>   t/t0001-init.sh                     |  22 ++++-
>   t/t2400-worktree-add.sh             |  45 +++++++++++
>   t/t2401-worktree-prune.sh           |   3 +-
>   t/t2402-worktree-list.sh            |  22 +++++
>   t/t2403-worktree-move.sh            |  25 ++++++
>   t/t2406-worktree-repair.sh          |  39 +++++++++
>   t/t2408-worktree-relative.sh        |  39 ---------
>   t/t5504-fetch-receive-strict.sh     |   6 +-
>   worktree.c                          | 157 ++++++++++++++++++++----------------
>   worktree.h                          |  22 ++++-
>   18 files changed, 333 insertions(+), 142 deletions(-)
> ---
> base-commit: 090d24e9af6e9f59c3f7bee97c42bb1ae3c7f559
> change-id: 20241025-wt_relative_options-afa41987bc32
> 
> Best regards,

