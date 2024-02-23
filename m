Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723FAC2DA
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 03:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658308; cv=none; b=DWXSE+GHj1K1vWvaE3uroSAes1hmEmqnq/NhGHezDzLHuxHXXb3Lyhyb4gX4xaYBz7DJU9ISZ4Yn33Yw9Md3RajNkzP+AOh7Cldi+4bkX0mL+wDNqtGqX1srpoPo5D0w4fcU6AoLn9hhMdkMQ4I5GDQhfbqxHeXuUUoNjXjQG5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658308; c=relaxed/simple;
	bh=VqWu8+51dKwQIBXIjBsXG/niucPTlZeX+CPBAsiKlgM=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EH5cZxYdVGpxfAwfQvH7EEbrz+N+Pk6XMfUYII0Bl/y+b/Wo6MR3KGp1qMyft5EoLhJvpflaoXGWnOnprpWFs6zT0EFqgCEcktMijcRRVu5Ei/g5Zu/JyUlEdA9fVBwYXwa6Ojqe/kJ6ubsWEBb7IDQSQIV2RDiScQNF14MAhBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ED48idHE; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ED48idHE"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33ce8cbf465so263568f8f.3
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 19:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708658303; x=1709263103; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7n5fpgbnyc3rHK/EbL+G1I8ud2TJnkVAVkuZ0f4QVY=;
        b=ED48idHESAhAq9OP5h74s24bkQYXiapETOXgAfeNplpWWDUxk9V9+T7mQm6+HCL5qi
         9pA6JaVbkP3giNbJYVgiEJWy0PsiDiljDXiv7eMSrqFmmfrLAj0qConrV3d/65G73pUC
         n2ahUsh1OG/xPX4ebHFE+pb6JePwUW2mwhQqfmDFBXdodf9fqkjrALRkQ7Cb9KidC50x
         nnNCZ6sRmr1J7eDAIrCQ5QOks5DUIICVZEWWIb4Eb4FUV9Q9KwFQ6/iFceHK772prS6Y
         jEE/4cZYhl7uYDhswRllPLsVDaZvIijShOfOSs+tyyeguj3D2U3RQNCe08knBVZfU6zQ
         jHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708658303; x=1709263103;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7n5fpgbnyc3rHK/EbL+G1I8ud2TJnkVAVkuZ0f4QVY=;
        b=A2bSUj7zxX3YOIEH6rjLSMuo6dWhD3r4bpPZVl+vagb1HSodU1SKdJvsaTXVgprwTt
         GZjJjgk6k0x4WCmN7EYt1XMEBQJCOAdpCaeTNuLmLpyNZz0Cp9rlIjwTtIiKhK2gOpR+
         mNUMJ3+iluAC2mQ4O+V4PS/ajYa+4GGDBLkZXu2NdpdhNu7qWoRLHvZR3U4d1MGqHxu6
         4NrozRtjKGzFy8UQKx86JZ30g9FGlTqZ1ztZmZccja2WynFXsgLZCB0DIMDEXGfY5ai3
         c+ZDj/TqgI1V8VkUnAm4PAa2CGz+6mgotJFyMyJhvazyLp8Z4+29PScu+AOeeWjy4ZoC
         MiKQ==
X-Gm-Message-State: AOJu0Yzie0MdSznKxYVBrQkvUKULNn1qRtXw1yA7YIVzzCBOSOdga2BL
	EBKbEUrEWQTiCVSHLKj2sbELpBFx2AIhrzUFOvz90D6GzoFoUfuKxoFzndX+
X-Google-Smtp-Source: AGHT+IFACIoeB3IBW34FofM8ixiRuiZH7656xXySoaQNmxQUpyW/ajJEeLRu0nZZ51pwkdc1ghpV9Q==
X-Received: by 2002:adf:e281:0:b0:33d:3cc8:3713 with SMTP id v1-20020adfe281000000b0033d3cc83713mr503138wri.15.1708658302426;
        Thu, 22 Feb 2024 19:18:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a17-20020adffad1000000b0033cf60e268fsm984505wrs.116.2024.02.22.19.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 19:18:22 -0800 (PST)
Message-ID: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 03:18:04 +0000
Subject: [PATCH v2 00/16] FSMonitor edge cases on case-insensitive file systems
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff Hostetler <git@jeffhostetler.com>,
    Jeff Hostetler <jeffhostetler@github.com>

Here is version 2. I think I have addressed all of the comments on the first
version and have greatly consolidated/streamlined the "icase" code.

============== Fix FSMonitor client code to detect case-incorrect FSEvents
and map them to the canonical case expected by the index.

FSEvents are delivered to the FSMonitor daemon using the observed case which
may or may not match the expected case stored in the index for tracked files
and/or directories. This caused index_name_pos() to report a negative index
position (defined as the suggested insertion point). Since the value was
negative, the FSMonitor refresh lookup would not invalidate the
CE_FSMONITOR_VALID bit on the "expected" (case-insensitive-equivalent)
cache-entries. Therefore, git status would not report them as modified.

This was a fairly obscure problem and only happened when the case of a
sub-directory or a file was artificially changed.

This first runs the original lookup using the observed case. If that fails,
it assumes that the observed pathname refers to a file and uses the
case-insensitive name-hash hashmap to find an equivalent path (cache-entry)
in the index. If that fails, it assumes the pathname refers to a directory
and uses the case-insensitive dir-name-hash to find the equivalent directory
and then repeats the index_name_pos() lookup to find a directory or
suggested insertion point with the expected case.

Two new test cases were added to t7527 to demonstrate this.

Since this was rather obscure, I also added some additional tracing under
the GIT_TRACE_FSMONITOR key.

I also did considerable refactoring of the original code before adding the
new lookups.

Finally, I made more explicit the relationship between the FSEvents and the
(new) sparse-index directory cache-entries, since sparse-index was added
slightly after the FSMonitor feature.

Jeff Hostetler (16):
  name-hash: add index_dir_find()
  t7527: add case-insensitve test for FSMonitor
  t7527: temporarily disable case-insensitive tests
  fsmonitor: refactor refresh callback on directory events
  fsmonitor: clarify handling of directory events in callback helper
  fsmonitor: refactor refresh callback for non-directory events
  dir: create untracked_cache_invalidate_trimmed_path()
  fsmonitor: refactor untracked-cache invalidation
  fsmonitor: move untracked invalidation into helper functions
  fsmonitor: return invalidated cache-entry count on directory event
  fsmonitor: remove custom loop from non-directory path handler
  fsmonitor: return invalided cache-entry count on non-directory event
  fsmonitor: trace the new invalidated cache-entry count
  fsmonitor: support case-insensitive events
  fsmonitor: refactor bit invalidation in refresh callback
  t7527: update case-insenstive fsmonitor test

 dir.c                        |  20 +++
 dir.h                        |   7 +
 fsmonitor.c                  | 299 ++++++++++++++++++++++++++++-------
 name-hash.c                  |   9 +-
 name-hash.h                  |   7 +-
 t/t7527-builtin-fsmonitor.sh | 220 ++++++++++++++++++++++++++
 6 files changed, 506 insertions(+), 56 deletions(-)


base-commit: f41f85c9ec8d4d46de0fd5fded88db94d3ec8c11
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1662%2Fjeffhostetler%2Ffsmonitor-ignore-case-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1662/jeffhostetler/fsmonitor-ignore-case-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1662

Range-diff vs v1:

  1:  6f81e2e3060 <  -:  ----------- sparse-index: pass string length to index_file_exists()
  2:  3464545fe3f !  1:  03b07d9c25e name-hash: add index_dir_exists2()
     @@ Metadata
      Author: Jeff Hostetler <jeffhostetler@github.com>
      
       ## Commit message ##
     -    name-hash: add index_dir_exists2()
     +    name-hash: add index_dir_find()
      
     -    Create a new version of index_dir_exists() to return the canonical
     +    Replace the index_dir_exists() function with index_dir_find() and
     +    change the API to take an optional strbuf to return the canonical
          spelling of the matched directory prefix.
      
     +    Create an index_dir_exists() wrapper macro for existing callers.
     +
          The existing index_dir_exists() returns a boolean to indicate if
          there is a case-insensitive match in the directory name-hash, but
          it doesn't tell the caller the exact spelling of that match.
     @@ Commit message
          Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
      
       ## name-hash.c ##
     -@@ name-hash.c: int index_dir_exists(struct index_state *istate, const char *name, int namelen)
     - 	dir = find_dir_entry(istate, name, namelen);
     - 	return dir && dir->nr;
     +@@ name-hash.c: static int same_name(const struct cache_entry *ce, const char *name, int namelen
     + 	return slow_same_name(name, namelen, ce->name, len);
       }
     -+int index_dir_exists2(struct index_state *istate, const char *name, int namelen,
     -+		      struct strbuf *canonical_path)
     -+{
     -+	struct dir_entry *dir;
     -+
     -+	strbuf_init(canonical_path, namelen+1);
     -+
     -+	lazy_init_name_hash(istate);
     -+	expand_to_path(istate, name, namelen, 0);
     -+	dir = find_dir_entry(istate, name, namelen);
     + 
     +-int index_dir_exists(struct index_state *istate, const char *name, int namelen)
     ++int index_dir_find(struct index_state *istate, const char *name, int namelen,
     ++		   struct strbuf *canonical_path)
     + {
     + 	struct dir_entry *dir;
     + 
     + 	lazy_init_name_hash(istate);
     + 	expand_to_path(istate, name, namelen, 0);
     + 	dir = find_dir_entry(istate, name, namelen);
      +
     -+	if (dir && dir->nr)
     ++	if (canonical_path && dir && dir->nr) {
     ++		strbuf_reset(canonical_path);
      +		strbuf_add(canonical_path, dir->name, dir->namelen);
     ++	}
      +
     -+	return dir && dir->nr;
     -+}
     + 	return dir && dir->nr;
     + }
       
     - void adjust_dirname_case(struct index_state *istate, char *name)
     - {
      
       ## name-hash.h ##
     -@@ name-hash.h: struct cache_entry;
     +@@
     + struct cache_entry;
       struct index_state;
       
     - int index_dir_exists(struct index_state *istate, const char *name, int namelen);
     -+int index_dir_exists2(struct index_state *istate, const char *name, int namelen,
     -+		      struct strbuf *canonical_path);
     +-int index_dir_exists(struct index_state *istate, const char *name, int namelen);
     ++
     ++int index_dir_find(struct index_state *istate, const char *name, int namelen,
     ++		   struct strbuf *canonical_path);
     ++
     ++#define index_dir_exists(i, n, l) index_dir_find((i), (n), (l), NULL)
     ++
       void adjust_dirname_case(struct index_state *istate, char *name);
       struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
       
  3:  272d7805f47 =  2:  7778cee1c10 t7527: add case-insensitve test for FSMonitor
  -:  ----------- >  3:  dad079ade7f t7527: temporarily disable case-insensitive tests
  4:  3fb8e0d0a7c !  4:  5516670e30e fsmonitor: refactor refresh callback on directory events
     @@ Metadata
       ## Commit message ##
          fsmonitor: refactor refresh callback on directory events
      
     +    Move the code to handle directory FSEvents (containing pathnames with
     +    a trailing slash) into a helper function.
     +
          Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
      
       ## fsmonitor.c ##
     @@ fsmonitor.c: static int query_fsmonitor_hook(struct repository *r,
       	return result;
       }
       
     -+static void fsmonitor_refresh_callback_slash(
     -+	struct index_state *istate, const char *name, int len, int pos)
     ++static void handle_path_with_trailing_slash(
     ++	struct index_state *istate, const char *name, int pos)
      +{
      +	int i;
      +
     @@ fsmonitor.c: static void fsmonitor_refresh_callback(struct index_state *istate,
      -				break;
      -			istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
      -		}
     -+		fsmonitor_refresh_callback_slash(istate, name, len, pos);
     ++		handle_path_with_trailing_slash(istate, name, pos);
       
       		/*
       		 * We need to remove the traling "/" from the path
  6:  5b6f8bd1fe7 !  5:  c04fd4eae94 fsmonitor: clarify handling of directory events in callback
     @@ Metadata
      Author: Jeff Hostetler <jeffhostetler@github.com>
      
       ## Commit message ##
     -    fsmonitor: clarify handling of directory events in callback
     +    fsmonitor: clarify handling of directory events in callback helper
     +
     +    Improve documentation of the refresh callback helper function
     +    used for directory FSEvents.
      
          Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
      
       ## fsmonitor.c ##
     -@@ fsmonitor.c: static void fsmonitor_refresh_callback_unqualified(
     - 	}
     +@@ fsmonitor.c: static int query_fsmonitor_hook(struct repository *r,
     + 	return result;
       }
       
     --static void fsmonitor_refresh_callback_slash(
      +/*
      + * The daemon can decorate directory events, such as a move or rename,
      + * by adding a trailing slash to the observed name.  Use this to
     @@ fsmonitor.c: static void fsmonitor_refresh_callback_unqualified(
      + * same way and just invalidate the cache-entry and the untracked
      + * cache (and in this case, the forward cache-entry scan won't find
      + * anything and it doesn't hurt to let it run).
     -+ *
     -+ * Return the number of cache-entries that we invalidated.  We will
     -+ * use this later to determine if we need to attempt a second
     -+ * case-insensitive search.
      + */
     -+static int fsmonitor_refresh_callback_slash(
     - 	struct index_state *istate, const char *name, int len, int pos)
     + static void handle_path_with_trailing_slash(
     + 	struct index_state *istate, const char *name, int pos)
       {
       	int i;
     -+	int nr_in_cone = 0;
       
      -	/*
      -	 * The daemon can decorate directory events, such as
     @@ fsmonitor.c: static void fsmonitor_refresh_callback_unqualified(
       	if (pos < 0)
       		pos = -pos - 1;
       
     -@@ fsmonitor.c: static void fsmonitor_refresh_callback_slash(
     - 		if (!starts_with(istate->cache[i]->name, name))
     - 			break;
     - 		istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
     -+		nr_in_cone++;
     - 	}
     -+
     -+	return nr_in_cone;
     - }
     - 
     - static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
  5:  0896d4af907 !  6:  7ee6ca1aefd fsmonitor: refactor refresh callback for non-directory events
     @@ Metadata
       ## Commit message ##
          fsmonitor: refactor refresh callback for non-directory events
      
     +    Move the code handle unqualified FSEvents (without a trailing slash)
     +    into a helper function.
     +
          Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
      
       ## fsmonitor.c ##
     @@ fsmonitor.c: static int query_fsmonitor_hook(struct repository *r,
       	return result;
       }
       
     -+static void fsmonitor_refresh_callback_unqualified(
     -+	struct index_state *istate, const char *name, int len, int pos)
     ++static void handle_path_without_trailing_slash(
     ++	struct index_state *istate, const char *name, int pos)
      +{
      +	int i;
      +
     @@ fsmonitor.c: static int query_fsmonitor_hook(struct repository *r,
      +		 * between "name" and "name/", such as "name-" and
      +		 * "name.".
      +		 */
     ++		int len = strlen(name);
      +		pos = -pos - 1;
      +
      +		for (i = pos; i < istate->cache_nr; i++) {
     @@ fsmonitor.c: static int query_fsmonitor_hook(struct repository *r,
      +	}
      +}
      +
     - static void fsmonitor_refresh_callback_slash(
     - 	struct index_state *istate, const char *name, int len, int pos)
     - {
     -@@ fsmonitor.c: static void fsmonitor_refresh_callback_slash(
     + /*
     +  * The daemon can decorate directory events, such as a move or rename,
     +  * by adding a trailing slash to the observed name.  Use this to
     +@@ fsmonitor.c: static void handle_path_with_trailing_slash(
       
       static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
       {
     @@ fsmonitor.c: static void fsmonitor_refresh_callback(struct index_state *istate,
      -			if (istate->cache[i]->name[len] == '/')
      -				istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
      -		}
     -+		fsmonitor_refresh_callback_unqualified(istate, name, len, pos);
     ++		handle_path_without_trailing_slash(istate, name, pos);
       	}
       
       	/*
  -:  ----------- >  7:  99c0d3e0742 dir: create untracked_cache_invalidate_trimmed_path()
  -:  ----------- >  8:  f2d6765d84f fsmonitor: refactor untracked-cache invalidation
  7:  1df4019931c !  9:  af6f57ab3e6 fsmonitor: refactor untracked-cache invalidation
     @@ Metadata
      Author: Jeff Hostetler <jeffhostetler@github.com>
      
       ## Commit message ##
     -    fsmonitor: refactor untracked-cache invalidation
     +    fsmonitor: move untracked invalidation into helper functions
     +
     +    Move the call to invalidate the untracked cache for the FSEvent
     +    pathname into the two helper functions.
     +
     +    In a later commit in this series, we will call these helpers
     +    from other contexts and it safer to include the UC invalidation
     +    in the helper than to remember to also add it to each helper
     +    call-site.
      
          Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
      
       ## fsmonitor.c ##
     -@@ fsmonitor.c: static int query_fsmonitor_hook(struct repository *r,
     - 	return result;
     - }
     - 
     -+/*
     -+ * Invalidate the untracked cache for the given pathname.  Copy the
     -+ * buffer to a proper null-terminated string (since the untracked
     -+ * cache code does not use (buf, len) style argument).  Also strip any
     -+ * trailing slash.
     -+ */
     -+static void my_invalidate_untracked_cache(
     -+	struct index_state *istate, const char *name, int len)
     -+{
     -+	struct strbuf work_path = STRBUF_INIT;
     -+
     -+	if (!len)
     -+		return;
     -+
     -+	if (name[len-1] == '/')
     -+		len--;
     -+
     -+	strbuf_add(&work_path, name, len);
     -+	untracked_cache_invalidate_path(istate, work_path.buf, 0);
     -+	strbuf_release(&work_path);
     -+}
     -+
     - static void fsmonitor_refresh_callback_unqualified(
     - 	struct index_state *istate, const char *name, int len, int pos)
     +@@ fsmonitor.c: static void handle_path_without_trailing_slash(
       {
       	int i;
       
     -+	my_invalidate_untracked_cache(istate, name, len);
     ++	/*
     ++	 * Mark the untracked cache dirty for this path (regardless of
     ++	 * whether or not we find an exact match for it in the index).
     ++	 * Since the path is unqualified (no trailing slash hint in the
     ++	 * FSEvent), it may refer to a file or directory. So we should
     ++	 * not assume one or the other and should always let the untracked
     ++	 * cache decide what needs to invalidated.
     ++	 */
     ++	untracked_cache_invalidate_trimmed_path(istate, name, 0);
      +
       	if (pos >= 0) {
       		/*
       		 * We have an exact match for this path and can just
     -@@ fsmonitor.c: static int fsmonitor_refresh_callback_slash(
     +@@ fsmonitor.c: static void handle_path_with_trailing_slash(
     + {
       	int i;
     - 	int nr_in_cone = 0;
       
     -+	my_invalidate_untracked_cache(istate, name, len);
     ++	/*
     ++	 * Mark the untracked cache dirty for this directory path
     ++	 * (regardless of whether or not we find an exact match for it
     ++	 * in the index or find it to be proper prefix of one or more
     ++	 * files in the index), since the FSEvent is hinting that
     ++	 * there may be changes on or within the directory.
     ++	 */
     ++	untracked_cache_invalidate_trimmed_path(istate, name, 0);
      +
       	if (pos < 0)
       		pos = -pos - 1;
       
      @@ fsmonitor.c: static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
     - 
     - 	if (name[len - 1] == '/') {
     - 		fsmonitor_refresh_callback_slash(istate, name, len, pos);
     --
     --		/*
     --		 * We need to remove the traling "/" from the path
     --		 * for the untracked cache.
     --		 */
     --		name[len - 1] = '\0';
       	} else {
     - 		fsmonitor_refresh_callback_unqualified(istate, name, len, pos);
     + 		handle_path_without_trailing_slash(istate, name, pos);
       	}
      -
      -	/*
      -	 * Mark the untracked cache dirty even if it wasn't found in the index
     --	 * as it could be a new untracked file.
     +-	 * as it could be a new untracked file.  (Let the untracked cache
     +-	 * layer silently deal with any trailing slash.)
      -	 */
     --	untracked_cache_invalidate_path(istate, name, 0);
     +-	untracked_cache_invalidate_trimmed_path(istate, name, 0);
       }
       
       /*
  -:  ----------- > 10:  623c6f06e21 fsmonitor: return invalidated cache-entry count on directory event
  9:  a0cc4c8274c ! 11:  1853f77d333 fsmonitor: refactor non-directory callback
     @@ Metadata
      Author: Jeff Hostetler <jeffhostetler@github.com>
      
       ## Commit message ##
     -    fsmonitor: refactor non-directory callback
     +    fsmonitor: remove custom loop from non-directory path handler
      
     -    Refactor the fsmonitor_refresh_callback_unqualified() code
     -    to try to use the _callback_slash() code and avoid having
     -    a custom filter in the child cache-entry scanner.
     +    Refactor the code that handles refresh events for pathnames that do
     +    not contain a trailing slash.  Instead of using a custom loop to try
     +    to scan the index and detect if the FSEvent named a file or might be a
     +    directory prefix, use the recently created helper function to do that.
     +
     +    Also update the comments to describe what and why we are doing this.
      
          On platforms that DO NOT annotate FS events with a trailing
          slash, if we fail to find an exact match for the pathname
     @@ Commit message
          Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
      
       ## fsmonitor.c ##
     -@@ fsmonitor.c: static int my_callback_dir_name_hash(
     - 	return nr_in_cone;
     +@@ fsmonitor.c: static int query_fsmonitor_hook(struct repository *r,
     + 	return result;
       }
       
     --static void fsmonitor_refresh_callback_unqualified(
     ++static size_t handle_path_with_trailing_slash(
     ++	struct index_state *istate, const char *name, int pos);
     ++
      +/*
      + * The daemon sent an observed pathname without a trailing slash.
      + * (This is the normal case.)  We do not know if it is a tracked or
     @@ fsmonitor.c: static int my_callback_dir_name_hash(
      + * do not know it is case-correct or -incorrect.
      + *
      + * Assume it is case-correct and try an exact match.
     -+ *
     -+ * Return the number of cache-entries that we invalidated.
      + */
     -+static int fsmonitor_refresh_callback_unqualified(
     - 	struct index_state *istate, const char *name, int len, int pos)
     + static void handle_path_without_trailing_slash(
     + 	struct index_state *istate, const char *name, int pos)
       {
      -	int i;
      -
     - 	my_invalidate_untracked_cache(istate, name, len);
     + 	/*
     + 	 * Mark the untracked cache dirty for this path (regardless of
     + 	 * whether or not we find an exact match for it in the index).
     +@@ fsmonitor.c: static void handle_path_without_trailing_slash(
       
       	if (pos >= 0) {
       		/*
     @@ fsmonitor.c: static int my_callback_dir_name_hash(
      +		 * at that directory. (That is, assume no D/F conflicts.)
       		 */
       		istate->cache[pos]->ce_flags &= ~CE_FSMONITOR_VALID;
     -+		return 1;
       	} else {
     -+		int nr_in_cone;
      +		struct strbuf work_path = STRBUF_INIT;
      +
       		/*
     @@ fsmonitor.c: static int my_callback_dir_name_hash(
      +		 * "foo" and "foo/" like "foo-" or "foo-bar", so we
      +		 * don't want to do our own scan.
       		 */
     +-		int len = strlen(name);
      -		pos = -pos - 1;
      -
      -		for (i = pos; i < istate->cache_nr; i++) {
     @@ fsmonitor.c: static int my_callback_dir_name_hash(
      -			if (istate->cache[i]->name[len] == '/')
      -				istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
      -		}
     -+		strbuf_add(&work_path, name, len);
     ++		strbuf_add(&work_path, name, strlen(name));
      +		strbuf_addch(&work_path, '/');
      +		pos = index_name_pos(istate, work_path.buf, work_path.len);
     -+		nr_in_cone = fsmonitor_refresh_callback_slash(
     -+			istate, work_path.buf, work_path.len, pos);
     ++		handle_path_with_trailing_slash(istate, work_path.buf, pos);
      +		strbuf_release(&work_path);
     -+		return nr_in_cone;
       	}
       }
       
 10:  bf18401f56c ! 12:  f77d68c78ad fsmonitor: support case-insensitive non-directory events
     @@ Metadata
      Author: Jeff Hostetler <jeffhostetler@github.com>
      
       ## Commit message ##
     -    fsmonitor: support case-insensitive non-directory events
     +    fsmonitor: return invalided cache-entry count on non-directory event
     +
     +    Teah the refresh callback helper function for unqualified FSEvents
     +    (pathnames without a trailing slash) to return the number of
     +    cache-entries that were invalided in response to the event.
     +
     +    This will be used in a later commit to help determine if the observed
     +    pathname was (possibly) case-incorrect when (on a case-insensitive
     +    file system).
      
          Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
      
       ## fsmonitor.c ##
     -@@ fsmonitor.c: static int fsmonitor_refresh_callback_unqualified(
     - 	}
     - }
     - 
     -+/*
     -+ * On a case-insensitive FS, use the name-hash to map the case of
     -+ * the observed path to the canonical case expected by the index.
     -+ *
     -+ * The given pathname DOES NOT include the trailing slash.
     +@@ fsmonitor.c: static size_t handle_path_with_trailing_slash(
     +  * do not know it is case-correct or -incorrect.
     +  *
     +  * Assume it is case-correct and try an exact match.
      + *
      + * Return the number of cache-entries that we invalidated.
     -+ */
     -+static int fsmonitor_refresh_callback_unqualified_icase(
     -+	struct index_state *istate, const char *name, int len)
     -+{
     -+	int nr_in_cone;
     -+
     -+	/*
     -+	 * Look for a case-incorrect match for this non-directory
     -+	 * pathname.
     -+	 */
     -+	nr_in_cone = my_callback_name_hash(istate, name, len);
     -+	if (nr_in_cone)
     -+		return nr_in_cone;
     -+
     -+	/*
     -+	 * Try the directory name-hash and see if there is a
     -+	 * case-incorrect directory with this pathanme.
     -+	 * (len) because we don't have a trailing slash.
     -+	 */
     -+	nr_in_cone = my_callback_dir_name_hash(istate, name, len);
     -+	return nr_in_cone;
     -+}
     -+
     - /*
     -  * The daemon can decorate directory events, such as a move or rename,
     -  * by adding a trailing slash to the observed name.  Use this to
     -@@ fsmonitor.c: static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
     - 		if (ignore_case && !nr_in_cone)
     - 			fsmonitor_refresh_callback_slash_icase(istate, name, len);
     +  */
     +-static void handle_path_without_trailing_slash(
     ++static size_t handle_path_without_trailing_slash(
     + 	struct index_state *istate, const char *name, int pos)
     + {
     + 	/*
     +@@ fsmonitor.c: static void handle_path_without_trailing_slash(
     + 		 * at that directory. (That is, assume no D/F conflicts.)
     + 		 */
     + 		istate->cache[pos]->ce_flags &= ~CE_FSMONITOR_VALID;
     ++		return 1;
       	} else {
     --		fsmonitor_refresh_callback_unqualified(istate, name, len, pos);
     -+		nr_in_cone = fsmonitor_refresh_callback_unqualified(istate, name, len, pos);
     -+		if (ignore_case && !nr_in_cone)
     -+			fsmonitor_refresh_callback_unqualified_icase(istate, name, len);
     ++		size_t nr_in_cone;
     + 		struct strbuf work_path = STRBUF_INIT;
     + 
     + 		/*
     +@@ fsmonitor.c: static void handle_path_without_trailing_slash(
     + 		strbuf_add(&work_path, name, strlen(name));
     + 		strbuf_addch(&work_path, '/');
     + 		pos = index_name_pos(istate, work_path.buf, work_path.len);
     +-		handle_path_with_trailing_slash(istate, work_path.buf, pos);
     ++		nr_in_cone = handle_path_with_trailing_slash(
     ++			istate, work_path.buf, pos);
     + 		strbuf_release(&work_path);
     ++		return nr_in_cone;
       	}
       }
       
  -:  ----------- > 13:  58b36673e15 fsmonitor: trace the new invalidated cache-entry count
  8:  e0029a2aad6 ! 14:  288f3f4e54e fsmonitor: support case-insensitive directory events
     @@ Metadata
      Author: Jeff Hostetler <jeffhostetler@github.com>
      
       ## Commit message ##
     -    fsmonitor: support case-insensitive directory events
     +    fsmonitor: support case-insensitive events
      
          Teach fsmonitor_refresh_callback() to handle case-insensitive
          lookups if case-sensitive lookups fail on case-insensitive systems.
     @@ Commit message
          to find the associated cache-entry. This causes status to think that
          the cached CE flags are correct and skip over the file.
      
     -    Update the handling of directory-style FSEvents (ones containing a
     -    path with a trailing slash) to optionally use the name-hash if the
     -    case-correct search does not find a match.
     -
     -    (The FSMonitor daemon can send directory FSEvents if the OS provides
     -    that information.)
     +    Update event handling to optionally use the name-hash and dir-name-hash
     +    if necessary.
      
          Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
      
     @@ fsmonitor.c
       #include "strbuf.h"
       #include "trace2.h"
      @@ fsmonitor.c: static int query_fsmonitor_hook(struct repository *r,
     - 	return result;
     - }
     - 
     -+static int fsmonitor_refresh_callback_slash(
     -+	struct index_state *istate, const char *name, int len, int pos);
     -+
     - /*
     -  * Invalidate the untracked cache for the given pathname.  Copy the
     -  * buffer to a proper null-terminated string (since the untracked
     -@@ fsmonitor.c: static void my_invalidate_untracked_cache(
     - 	strbuf_release(&work_path);
     - }
     + static size_t handle_path_with_trailing_slash(
     + 	struct index_state *istate, const char *name, int pos);
       
      +/*
     -+ * Use the name-hash to lookup the pathname.
     ++ * Use the name-hash to do a case-insensitive cache-entry lookup with
     ++ * the pathname and invalidate the cache-entry.
      + *
      + * Returns the number of cache-entries that we invalidated.
      + */
     -+static int my_callback_name_hash(
     -+	struct index_state *istate, const char *name, int len)
     ++static size_t handle_using_name_hash_icase(
     ++	struct index_state *istate, const char *name)
      +{
      +	struct cache_entry *ce = NULL;
      +
     -+	ce = index_file_exists(istate, name, len, 1);
     ++	ce = index_file_exists(istate, name, strlen(name), 1);
      +	if (!ce)
      +		return 0;
      +
      +	/*
     -+	 * The index contains a case-insensitive match for the pathname.
     -+	 * This could either be a regular file or a sparse-index directory.
     ++	 * A case-insensitive search in the name-hash using the
     ++	 * observed pathname found a cache-entry, so the observed path
     ++	 * is case-incorrect.  Invalidate the cache-entry and use the
     ++	 * correct spelling from the cache-entry to invalidate the
     ++	 * untracked-cache.  Since we now have sparse-directories in
     ++	 * the index, the observed pathname may represent a regular
     ++	 * file or a sparse-index directory.
      +	 *
     -+	 * We should not have seen FSEvents for a sparse-index directory,
     -+	 * but we handle it just in case.
     ++	 * Note that we should not have seen FSEvents for a
     ++	 * sparse-index directory, but we handle it just in case.
      +	 *
      +	 * Either way, we know that there are not any cache-entries for
      +	 * children inside the cone of the directory, so we don't need to
      +	 * do the usual scan.
      +	 */
      +	trace_printf_key(&trace_fsmonitor,
     -+			 "fsmonitor_refresh_callback map '%s' '%s'",
     ++			 "fsmonitor_refresh_callback MAP: '%s' '%s'",
      +			 name, ce->name);
      +
     -+	my_invalidate_untracked_cache(istate, ce->name, ce->ce_namelen);
     ++	untracked_cache_invalidate_trimmed_path(istate, ce->name, 0);
      +
      +	ce->ce_flags &= ~CE_FSMONITOR_VALID;
      +	return 1;
      +}
      +
      +/*
     -+ * Use the directory name-hash to find the correct-case spelling
     -+ * of the directory.  Use the canonical spelling to invalidate all
     -+ * of the cache-entries within the matching cone.
     -+ *
     -+ * The pathname MUST NOT have a trailing slash.
     ++ * Use the dir-name-hash to find the correct-case spelling of the
     ++ * directory.  Use the canonical spelling to invalidate all of the
     ++ * cache-entries within the matching cone.
      + *
      + * Returns the number of cache-entries that we invalidated.
      + */
     -+static int my_callback_dir_name_hash(
     -+	struct index_state *istate, const char *name, int len)
     ++static size_t handle_using_dir_name_hash_icase(
     ++	struct index_state *istate, const char *name)
      +{
      +	struct strbuf canonical_path = STRBUF_INIT;
      +	int pos;
     -+	int nr_in_cone;
     ++	size_t len = strlen(name);
     ++	size_t nr_in_cone;
     ++
     ++	if (name[len - 1] == '/')
     ++		len--;
      +
     -+	if (!index_dir_exists2(istate, name, len, &canonical_path))
     ++	if (!index_dir_find(istate, name, len, &canonical_path))
      +		return 0; /* name is untracked */
     -+	if (!memcmp(name, canonical_path.buf, len)) {
     ++
     ++	if (!memcmp(name, canonical_path.buf, canonical_path.len)) {
      +		strbuf_release(&canonical_path);
     ++		/*
     ++		 * NEEDSWORK: Our caller already tried an exact match
     ++		 * and failed to find one.  They called us to do an
     ++		 * ICASE match, so we should never get an exact match,
     ++		 * so we could promote this to a BUG() here if we
     ++		 * wanted to.  It doesn't hurt anything to just return
     ++		 * 0 and go on becaus we should never get here.  Or we
     ++		 * could just get rid of the memcmp() and this "if"
     ++		 * clause completely.
     ++		 */
      +		return 0; /* should not happen */
      +	}
      +
      +	trace_printf_key(&trace_fsmonitor,
     -+			 "fsmonitor_refresh_callback map '%s' '%s'",
     ++			 "fsmonitor_refresh_callback MAP: '%s' '%s'",
      +			 name, canonical_path.buf);
      +
      +	/*
     -+	 * The directory name-hash only tells us the corrected
     -+	 * spelling of the prefix.  We have to use this canonical
     -+	 * path to do a lookup in the cache-entry array so that we
     -+	 * we repeat the original search using the case-corrected
     -+	 * spelling.
     ++	 * The dir-name-hash only tells us the corrected spelling of
     ++	 * the prefix.  We have to use this canonical path to do a
     ++	 * lookup in the cache-entry array so that we repeat the
     ++	 * original search using the case-corrected spelling.
      +	 */
      +	strbuf_addch(&canonical_path, '/');
      +	pos = index_name_pos(istate, canonical_path.buf,
      +			     canonical_path.len);
     -+	nr_in_cone = fsmonitor_refresh_callback_slash(
     -+		istate, canonical_path.buf, canonical_path.len, pos);
     ++	nr_in_cone = handle_path_with_trailing_slash(
     ++		istate, canonical_path.buf, pos);
      +	strbuf_release(&canonical_path);
      +	return nr_in_cone;
      +}
      +
     - static void fsmonitor_refresh_callback_unqualified(
     - 	struct index_state *istate, const char *name, int len, int pos)
     - {
     -@@ fsmonitor.c: static void fsmonitor_refresh_callback_unqualified(
     -  *
     -  * Return the number of cache-entries that we invalidated.  We will
     -  * use this later to determine if we need to attempt a second
     -- * case-insensitive search.
     -+ * case-insensitive search.  That is, if a observed-case search yields
     -+ * any results, we assume the prefix is case-correct.  If there are
     -+ * no matches, we still don't know if the observed path is simply
     -+ * untracked or case-incorrect.
     -  */
     - static int fsmonitor_refresh_callback_slash(
     - 	struct index_state *istate, const char *name, int len, int pos)
     -@@ fsmonitor.c: static int fsmonitor_refresh_callback_slash(
     - 	return nr_in_cone;
     - }
     + /*
     +  * The daemon sent an observed pathname without a trailing slash.
     +  * (This is the normal case.)  We do not know if it is a tracked or
     +@@ fsmonitor.c: static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
     + 	else
     + 		nr_in_cone = handle_path_without_trailing_slash(istate, name, pos);
       
     -+/*
     -+ * On a case-insensitive FS, use the name-hash and directory name-hash
     -+ * to map the case of the observed path to the canonical case expected
     -+ * by the index.
     -+ *
     -+ * The given pathname includes the trailing slash.
     -+ *
     -+ * Return the number of cache-entries that we invalidated.
     -+ */
     -+static int fsmonitor_refresh_callback_slash_icase(
     -+	struct index_state *istate, const char *name, int len)
     -+{
     -+	int nr_in_cone;
     -+
     -+	/*
     -+	 * Look for a case-incorrect sparse-index directory.
     -+	 */
     -+	nr_in_cone = my_callback_name_hash(istate, name, len);
     -+	if (nr_in_cone)
     -+		return nr_in_cone;
     -+
      +	/*
     -+	 * (len-1) because we do not include the trailing slash in the
     -+	 * pathname.
     ++	 * If we did not find an exact match for this pathname or any
     ++	 * cache-entries with this directory prefix and we're on a
     ++	 * case-insensitive file system, try again using the name-hash
     ++	 * and dir-name-hash.
      +	 */
     -+	nr_in_cone = my_callback_dir_name_hash(istate, name, len-1);
     -+	return nr_in_cone;
     -+}
     -+
     - static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
     - {
     - 	int len = strlen(name);
     - 	int pos = index_name_pos(istate, name, len);
     -+	int nr_in_cone;
     ++	if (!nr_in_cone && ignore_case) {
     ++		nr_in_cone = handle_using_name_hash_icase(istate, name);
     ++		if (!nr_in_cone)
     ++			nr_in_cone = handle_using_dir_name_hash_icase(
     ++				istate, name);
     ++	}
      +
     - 
     - 	trace_printf_key(&trace_fsmonitor,
     - 			 "fsmonitor_refresh_callback '%s' (pos %d)",
     - 			 name, pos);
     - 
     - 	if (name[len - 1] == '/') {
     --		fsmonitor_refresh_callback_slash(istate, name, len, pos);
     -+		nr_in_cone = fsmonitor_refresh_callback_slash(istate, name, len, pos);
     -+		if (ignore_case && !nr_in_cone)
     -+			fsmonitor_refresh_callback_slash_icase(istate, name, len);
     - 	} else {
     - 		fsmonitor_refresh_callback_unqualified(istate, name, len, pos);
     - 	}
     + 	if (nr_in_cone)
     + 		trace_printf_key(&trace_fsmonitor,
     + 				 "fsmonitor_refresh_callback CNT: %d",
 11:  7775de735f4 ! 15:  3a20065dbf8 fsmonitor: refactor bit invalidation in refresh callback
     @@ Commit message
          Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
      
       ## fsmonitor.c ##
     -@@ fsmonitor.c: static void my_invalidate_untracked_cache(
     - 	strbuf_release(&work_path);
     - }
     +@@ fsmonitor.c: static int query_fsmonitor_hook(struct repository *r,
     + static size_t handle_path_with_trailing_slash(
     + 	struct index_state *istate, const char *name, int pos);
       
      +/*
      + * Invalidate the FSM bit on this CE.  This is like mark_fsmonitor_invalid()
      + * but we've already handled the untracked-cache and I want a different
      + * trace message.
      + */
     -+static void my_invalidate_ce_fsm(struct cache_entry *ce)
     ++static void invalidate_ce_fsm(struct cache_entry *ce)
      +{
      +	if (ce->ce_flags & CE_FSMONITOR_VALID)
      +		trace_printf_key(&trace_fsmonitor,
     -+				 "fsmonitor_refresh_cb_invalidate '%s'",
     ++				 "fsmonitor_refresh_callback INV: '%s'",
      +				 ce->name);
      +	ce->ce_flags &= ~CE_FSMONITOR_VALID;
      +}
      +
       /*
     -  * Use the name-hash to lookup the pathname.
     -  *
     -@@ fsmonitor.c: static int my_callback_name_hash(
     +  * Use the name-hash to do a case-insensitive cache-entry lookup with
     +  * the pathname and invalidate the cache-entry.
     +@@ fsmonitor.c: static size_t handle_using_name_hash_icase(
       
     - 	my_invalidate_untracked_cache(istate, ce->name, ce->ce_namelen);
     + 	untracked_cache_invalidate_trimmed_path(istate, ce->name, 0);
       
      -	ce->ce_flags &= ~CE_FSMONITOR_VALID;
     -+	my_invalidate_ce_fsm(ce);
     ++	invalidate_ce_fsm(ce);
       	return 1;
       }
       
     -@@ fsmonitor.c: static int fsmonitor_refresh_callback_unqualified(
     +@@ fsmonitor.c: static size_t handle_path_without_trailing_slash(
       		 * cache-entry with the same pathname, nor for a cone
       		 * at that directory. (That is, assume no D/F conflicts.)
       		 */
      -		istate->cache[pos]->ce_flags &= ~CE_FSMONITOR_VALID;
     -+		my_invalidate_ce_fsm(istate->cache[pos]);
     ++		invalidate_ce_fsm(istate->cache[pos]);
       		return 1;
       	} else {
     - 		int nr_in_cone;
     -@@ fsmonitor.c: static int fsmonitor_refresh_callback_slash(
     + 		size_t nr_in_cone;
     +@@ fsmonitor.c: static size_t handle_path_with_trailing_slash(
       	for (i = pos; i < istate->cache_nr; i++) {
       		if (!starts_with(istate->cache[i]->name, name))
       			break;
      -		istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
     -+		my_invalidate_ce_fsm(istate->cache[i]);
     ++		invalidate_ce_fsm(istate->cache[i]);
       		nr_in_cone++;
       	}
       
 12:  63edb68303f ! 16:  467d3c1fe2c t7527: update case-insenstive fsmonitor test
     @@ Commit message
      
          Now that the FSMonitor client has been updated to better
          handle events on case-insenstive file systems, update the
     -    two tests that demonstrated the bug.
     +    two tests that demonstrated the bug and remove the temporary
     +    SKIPME prereq.
      
          Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
      
       ## t/t7527-builtin-fsmonitor.sh ##
     -@@ t/t7527-builtin-fsmonitor.sh: test_expect_success CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on disk' '
     +@@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'split-index and FSMonitor work well together' '
     + #
     + # The setup is a little contrived.
     + #
     +-test_expect_success SKIPME,CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on disk' '
     ++test_expect_success CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on disk' '
     + 	test_when_finished "stop_daemon_delete_repo subdir_case_wrong" &&
     + 
     + 	git init subdir_case_wrong &&
     +@@ t/t7527-builtin-fsmonitor.sh: test_expect_success SKIPME,CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on d
       
       	grep -q "dir1/DIR2/dir3/file3.*pos -3" "$PWD/subdir_case_wrong.log1" &&
       
      +	# Also verify that we get a mapping event to correct the case.
     -+	grep -q "map.*dir1/DIR2/dir3/file3.*dir1/dir2/dir3/file3" \
     ++	grep -q "MAP:.*dir1/DIR2/dir3/file3.*dir1/dir2/dir3/file3" \
      +		"$PWD/subdir_case_wrong.log1" &&
      +
       	# The refresh-callbacks should have caused "git status" to clear
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success CASE_INSENSITIVE_FS 'fsmonitor
      +	grep -q " M dir1/dir2/dir3/file3" "$PWD/subdir_case_wrong.out"
       '
       
     - test_expect_success CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
     -@@ t/t7527-builtin-fsmonitor.sh: test_expect_success CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
     +-test_expect_success SKIPME,CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
     ++test_expect_success CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
     + 	test_when_finished "stop_daemon_delete_repo file_case_wrong" &&
     + 
     + 	git init file_case_wrong &&
     +@@ t/t7527-builtin-fsmonitor.sh: test_expect_success SKIPME,CASE_INSENSITIVE_FS 'fsmonitor file case wrong on dis
       	grep -q "fsmonitor_refresh_callback.*FILE-3-A.*pos -3" "$PWD/file_case_wrong-try3.log" &&
       	grep -q "fsmonitor_refresh_callback.*file-4-a.*pos -9" "$PWD/file_case_wrong-try3.log" &&
       
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success CASE_INSENSITIVE_FS 'fsmonitor
      -	! grep -q " M dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-try3.out" &&
      -	! grep -q " M dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-try3.out"
      +	# Also verify that we get a mapping event to correct the case.
     -+	grep -q "fsmonitor_refresh_callback map.*dir1/dir2/dir3/FILE-3-A.*dir1/dir2/dir3/file-3-a" \
     ++	grep -q "fsmonitor_refresh_callback MAP:.*dir1/dir2/dir3/FILE-3-A.*dir1/dir2/dir3/file-3-a" \
      +		"$PWD/file_case_wrong-try3.log" &&
     -+	grep -q "fsmonitor_refresh_callback map.*dir1/dir2/dir4/file-4-a.*dir1/dir2/dir4/FILE-4-A" \
     ++	grep -q "fsmonitor_refresh_callback MAP:.*dir1/dir2/dir4/file-4-a.*dir1/dir2/dir4/FILE-4-A" \
      +		"$PWD/file_case_wrong-try3.log" &&
      +
      +	grep -q " M dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-try3.out" &&

-- 
gitgitgadget
