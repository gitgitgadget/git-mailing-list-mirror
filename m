Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C59E318EC7
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425812; cv=none; b=UI1isozXUld5OiZ1ps+xZzkr0GEUWCS2dDpmiJWP13R3bRBAtgkQZKnuRV311FZq5c7tdhjclWUndo1O17wSBlooGJtCfgBiUQJOExzl1hdYEHMnNU3b47wE4eCuef427hPtuyjOxZxGUqB9tHDUjdz8YJDt5yVlC+zvzmAHL5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425812; c=relaxed/simple;
	bh=KEo5RmILK3B/zFDzFIS2g7w43LcQVEK+kufi0a21Mew=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=m6hzh+Jz/dPQX9oZWszZXlvNsvBlXyetdwDEMNKExgW0HT3HJeM4TKbwfVpyC/leYe0Gk8TomGnmxFDZMcxUL0l+N+GhvJhIryIP8ptYbmdgaV/Mr1usShh68+AuHmofgZWlIGEj212T54n5bqiMLw49NFoA59niRjDTALewGUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJMxCpKp; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJMxCpKp"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4854166e1efso10646592b6e.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 11:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780425810; x=1781030610; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvT2USz8LbJfaApo/UE+9zT9lGTD1MigqdEpn3qUEdE=;
        b=iJMxCpKpSEpn2cE5ayn6sYeGvyky4ZDIRNwnqIWDy9un3JFVkp2OQ9beWScSJVy+Cs
         LZ0q3qxv3oUBksJk8j5kvowPmnoK0IBBkBmAegetSYHOiusCqyahImc5PW0hTPY5K8D/
         kF93+IV1d4DkBkzoU2BxldK2c4vdk4slACcJvqnqhlhAj7A/xJZTm+Z1UUUuxl1VtEyw
         ALtMo23Slf8l8hnhpw1mVrhEkTvHrXUiqN6I2T5KVB2Ge/uc7G4vTKD+6oT64ASOXTxw
         3HztR8j6CVMXsob6TIOMJmVwkBgtd1CM5Z7mlzgyrGUhB3l6ejoLdOnC5xRxMiCrFcyZ
         VEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780425810; x=1781030610;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RvT2USz8LbJfaApo/UE+9zT9lGTD1MigqdEpn3qUEdE=;
        b=VGMZl5zPT9qyMJfCVXCuDPenqAC19OHzxdZ+qFI2fNvtyE4C87gicKYJTy6QvzPHMm
         J4Bsn3jtX0XQAu/yzu0go8tdv55AAMCc7ioiNdLPgWTffTIBsD689xtF6wsXdW+R/Vqg
         2suAeBxrrQ82+4/CRbOXAAubSLHORX5TzWSgoxFKAMDPNGVn1vM/SNydM56v/77gAKwB
         for3C11XJet/aoO3pQ1GPOwNRf4yHJR5yEi5GlMedqujfxs/i45RRG+dsTe6K/4mU9mo
         wX7RwEbAlvdZdn59HkSyHsSIH1A+C2558QXHBuvqhd1qeyEGBsKBHyGX7X3/lmvzfLKN
         NaYA==
X-Gm-Message-State: AOJu0YzWmHQ5VozGJSPtTPyjmP3L3nTNDx+y6XLtY/dBKBKKGb7bSicn
	6J0FAhMWPJweCGfoHMwwiQNLhyglHKEuHDD8iTQbQWPu6F3NxcNTl+Kzn5mAxw==
X-Gm-Gg: Acq92OFviezk5aZA8kr4jT2LO6l92L5692QTmeHz7eWjx+3uv7Bcpqknt6ckR8eKFlT
	asvNpfZueoJ21JKHSbFc9eGa5IqDcBePeq3DMVRPKAI1dfuDiru4gMPJiM6VX6ciTaWlJL0ydQ0
	BTVnc3Hpl9olwtTTmCFvwnycI7JdnLeBRfIkLCcEloe+A1ZBN3lH0wJRiFmbr3ShgvzFsJJls9e
	weHr1gAwcZosSwECm+FEZbVNkJrHeuNoANgmhQBHG/LZxlofS1cCH9v3F7k9P2p/s5zc78/csTd
	4+LLUkx/oUL7KlntugHjSSdHNsiBafk2HbNp98wvD4m22ikewAeG/a1we/oA0Ekpkdujhrt7iMk
	rbWlOnnMISY+aDgNoPfRKCdPbmdWhOn6mi49aSqeizfRsJf/recX75izidHjRQGN3/lqW2EVazI
	RCVeH95HMAdGNY07vWtNp2O++R6HOiJ9g9iLb/
X-Received: by 2002:a05:6808:198b:b0:479:ca1e:ad80 with SMTP id 5614622812f47-4865a99ff04mr13462b6e.5.1780425809987;
        Tue, 02 Jun 2026 11:43:29 -0700 (PDT)
Received: from [127.0.0.1] ([20.80.108.168])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e7468fa7sm117388a34.1.2026.06.02.11.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 11:43:29 -0700 (PDT)
Message-Id: <pull.2302.v6.git.git.1780425808.gitgitgadget@gmail.com>
In-Reply-To: <pull.2302.v5.git.git.1780407557.gitgitgadget@gmail.com>
References: <pull.2302.v5.git.git.1780407557.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 02 Jun 2026 18:43:26 +0000
Subject: [PATCH v6 0/2] config: suggest the correct form when key contains "="
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

 * The quiet parameter now lives on a static do_parse_config_key() instead
   of git_config_parse_key() itself. git_config_parse_key() is back to its
   three-argument signature; existing callers don't change.
 * New public git_config_key_is_valid() for callers that only need a yes/no
   check.

Harald Nordgren (2):
  config: add git_config_key_is_valid() for quiet validation
  config: improve diagnostic for "set" with missing value

 builtin/config.c  | 32 ++++++++++++++++++++++++++-
 config.c          | 38 ++++++++++++++++++++++++--------
 config.h          |  2 ++
 t/t1300-config.sh | 56 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 118 insertions(+), 10 deletions(-)


base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2302%2FHaraldNordgren%2Fconfig-hint-equals-key-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2302/HaraldNordgren/config-hint-equals-key-v6
Pull-Request: https://github.com/git/git/pull/2302

Range-diff vs v5:

 1:  d938ebf95a ! 1:  7400ca41bb config: let git_config_parse_key() validate quietly
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    config: let git_config_parse_key() validate quietly
     +    config: add git_config_key_is_valid() for quiet validation
      
     -    Add a "quiet" parameter that suppresses the error() calls, and let
     -    store_key be NULL to skip the canonical-copy allocation.  Existing
     -    callers pass 0 for quiet.
     +    Move the body of git_config_parse_key() into a static helper
     +    do_parse_config_key() that takes a "quiet" flag and treats
     +    store_key as optional.  git_config_parse_key() becomes a thin
     +    wrapper.
      
     -    Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
     +    Add git_config_key_is_valid() for callers that only need to
     +    know whether a key is well-formed.
      
     - ## builtin/config.c ##
     -@@ builtin/config.c: static int get_value(const struct config_location_options *opts,
     - 			goto free_strings;
     - 		}
     - 	} else {
     --		if (git_config_parse_key(key_, &key, NULL)) {
     -+		if (git_config_parse_key(key_, &key, NULL, 0)) {
     - 			ret = CONFIG_INVALID_KEY;
     - 			goto free_strings;
     - 		}
     +    Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## config.c ##
      @@ config.c: static inline int iskeychar(int c)
     @@ config.c: static inline int iskeychar(int c)
      + * quiet - when non-zero, suppress error() reports on rejection
        */
      -int git_config_parse_key(const char *key, char **store_key, size_t *baselen_)
     -+int git_config_parse_key(const char *key, char **store_key, size_t *baselen_,
     -+			 int quiet)
     ++static int do_parse_config_key(const char *key, char **store_key,
     ++			       size_t *baselen_, int quiet)
       {
       	size_t i, baselen;
       	int dot;
     @@ config.c: int git_config_parse_key(const char *key, char **store_key, size_t *ba
       	return -CONFIG_INVALID_KEY;
       }
       
     -@@ config.c: static int config_parse_pair(const char *key, const char *value,
     - 
     - 	if (!strlen(key))
     - 		return error(_("empty config key"));
     --	if (git_config_parse_key(key, &canonical_name, NULL))
     -+	if (git_config_parse_key(key, &canonical_name, NULL, 0))
     - 		return -1;
     - 
     - 	ret = (fn(canonical_name, value, &ctx, data) < 0) ? -1 : 0;
     -@@ config.c: static int configset_find_element(struct config_set *set, const char *key,
     - 	 * `key` may come from the user, so normalize it before using it
     - 	 * for querying entries from the hashmap.
     - 	 */
     --	ret = git_config_parse_key(key, &normalized_key, NULL);
     -+	ret = git_config_parse_key(key, &normalized_key, NULL, 0);
     - 	if (ret)
     - 		return ret;
     - 
     -@@ config.c: int repo_config_set_multivar_in_file_gently(struct repository *r,
     - 	validate_comment_string(comment);
     - 
     - 	/* parse-key returns negative; flip the sign to feed exit(3) */
     --	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen);
     -+	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen, 0);
     - 	if (ret)
     - 		goto out_free;
     - 
     ++int git_config_parse_key(const char *key, char **store_key, size_t *baselen_)
     ++{
     ++	return do_parse_config_key(key, store_key, baselen_, 0);
     ++}
     ++
     ++int git_config_key_is_valid(const char *key)
     ++{
     ++	return !do_parse_config_key(key, NULL, NULL, 1);
     ++}
     ++
     + static int config_parse_pair(const char *key, const char *value,
     + 			     struct key_value_info *kvi,
     + 			     config_fn_t fn, void *data)
      
       ## config.h ##
     -@@ config.h: int repo_config_set_worktree_gently(struct repository *, const char *, const cha
     -  */
     - void repo_config_set(struct repository *, const char *, const char *);
     +@@ config.h: void repo_config_set(struct repository *, const char *, const char *);
       
     --int git_config_parse_key(const char *, char **, size_t *);
     -+int git_config_parse_key(const char *, char **, size_t *, int quiet);
     + int git_config_parse_key(const char *, char **, size_t *);
       
     ++int git_config_key_is_valid(const char *);
     ++
       /*
        * The following macros specify flag bits that alter the behavior
     -
     - ## submodule-config.c ##
     -@@ submodule-config.c: int print_config_from_gitmodules(struct repository *repo, const char *key)
     - 	int ret;
     - 	char *store_key;
     - 
     --	ret = git_config_parse_key(key, &store_key, NULL);
     -+	ret = git_config_parse_key(key, &store_key, NULL, 0);
     - 	if (ret < 0)
     - 		return CONFIG_INVALID_KEY;
     - 
     +  * of the repo_config_set_multivar*() methods.
 2:  e5a2070ee1 ! 2:  a7f8a084c7 config: improve diagnostic for "set" with missing value
     @@ builtin/config.c: static void check_argc(int argc, int min, int max)
      +	const char *eq = last_dot ? strchr(last_dot + 1, '=') : NULL;
      +	char *prefix = eq ? xstrndup(arg, eq - arg) : NULL;
      +
     -+	if (prefix && !git_config_parse_key(prefix, NULL, NULL, 1)) {
     ++	if (prefix && git_config_key_is_valid(prefix)) {
      +		error(_("missing value to set to the variable '%s'"), arg);
      +		advise(_("did you mean \"git config set %s %s\"?"),
      +		       prefix, eq + 1);
     -+	} else if (!git_config_parse_key(arg, NULL, NULL, 1)) {
     ++	} else if (git_config_key_is_valid(arg)) {
      +		error(_("missing value to set to the variable '%s'"), arg);
      +	} else {
      +		error(_("missing value to set to a variable with an invalid name '%s'"),
     @@ t/t1300-config.sh: test_expect_success 'invalid key' '
      +
      +test_expect_success 'set with 2 args including "=" in invalid key does not suggest' '
      +	test_must_fail git config set pull.rebase=false true 2>err &&
     ++	test_grep "invalid key: pull\\.rebase=false" err &&
      +	test_grep ! "did you mean" err
      +'
      +

-- 
gitgitgadget
