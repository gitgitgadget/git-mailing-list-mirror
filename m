Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FC8C433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 20:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244810AbiEPU21 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 16:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348769AbiEPU1o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 16:27:44 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904B617A9C
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:11:09 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j24so6710296wrb.1
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=2kwCQh65OqrM/kXxdJv1yr5KhuzT57Ol3mZ5aWxRTuY=;
        b=k4Revhw3v9jJ40s6Ly0eZHjjWBHhwgNGXHXObDLt8nIOAnizG9GJirn2BP5x3TD8/i
         jNemrJ3wscQafwobaR4gVY/0nFr1K5fibXhVlCv3pCqDyuE8n+p4zfOj9i7k67VHQwqd
         D60R1i5v77UCIloduY7h1raENjaYWLhPugFORneR0C2mUVxI/Q/XumLay3kAZuzevjOF
         N4CbdqWnFxbP5Qww9RcySFxnK5UxSAANDQHIASsZbhjAFYcLx46lQ5aOcdFfRWH1aMbp
         i9zhiDEXeiflZdMwshE1hkgfwvddRbxtfddNp+cBx07Jn7lgXYyNU5oAXgs0K9cFZxR7
         AUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=2kwCQh65OqrM/kXxdJv1yr5KhuzT57Ol3mZ5aWxRTuY=;
        b=wAkazf/A1IocnrkHfJSGB7hfYnWmgMNb//PgEv62zBx+xf2zIcNzexnGbI+0/X1wnL
         r32tuNu2gr1eS35/1iVYsm+g7up4mKB3Vq1qGIw7F9X91ZTWxtFrvcZqoemm1Ahiirpv
         AAhEXeHMACUlqjfw4MpSwVY8WmQXsQpnGoJH1ZyZ18AanQYw55I97gxUe4uy77aLaFzo
         q48kLggxt7dc39+usNo1W66/ppN01fic36f+Er3RIHxLO5QtM6efaM3SV0phq/hsKgUJ
         Zd6dZGk5d0UDp2K+r20a6QMLA2Gf/i9J0JodoG1It8CF/Bf26/rrQGqaMhcY35w1+o7q
         HhUw==
X-Gm-Message-State: AOAM531HfyIrWkBxnik09ovN0xmwHSJcbXGNwG+4N7RtAFPyN7LkFDaS
        tBOW+FTwbRSbpiRzhd/fduHSwBZ2SNY=
X-Google-Smtp-Source: ABdhPJwH5L5LJwH0OVt627ZMiIK595pbbKIC2WOrBuB8pG/A5HSCZq4q6CfO7r480KD6OymdXP8Pow==
X-Received: by 2002:a5d:4806:0:b0:20a:da03:711b with SMTP id l6-20020a5d4806000000b0020ada03711bmr15055643wrq.395.1652731867240;
        Mon, 16 May 2022 13:11:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y21-20020a7bcd95000000b0039489e1bbd6sm139768wmj.47.2022.05.16.13.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 13:11:06 -0700 (PDT)
Message-Id: <pull.1233.git.1652731865.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 May 2022 20:10:57 +0000
Subject: [PATCH 0/8] Bundle URIs: Prepatory patches
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, jonathantanmy@google.com,
        jrnieder@gmail.com, albertqcui@gmail.com, robbat2@gentoo.org,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(This series is based on 2.36.0, but I don't see any conflicts with 'seen'.)

Here is a re-roll of the first eight patches from Ævar's latest RFC. As I
mentioned [1], these patches are useful refactors that help both approaches,
so they can be reviewed while we are still working on combining our
approaches to the bundle URI feature.

[1]
https://lore.kernel.org/git/dd9836e8-bfc9-9a52-199a-3ffce26101f8@github.com/

(My update: I'm still working on a combined version starting from Ævar's
latest changes, but my vacation last week set me back a bit. I'm hoping to
have something in the next two weeks, but my WIP version is based on these
patches.)

Thanks, -Stolee

Here is a range-diff from Ævar's first eight patches. The biggest change is
that his patch 2 was split into my patches 2 and 3. I also renamed
"path_matches_flags()" to "path_starts_with_dotslash_flags()", which makes
the diff there look pretty nasty when it really isn't that bad.

 1:  fcb0b50471 !  1:  bd592ebba4 connect.c: refactor sending of agent & object-format
    @@ Commit message
         object-format. So let's split this into a function.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Signed-off-by: Derrick Stolee <derrickstolee@github.com>
     
      ## connect.c ##
     @@ connect.c: void check_stateless_delimiter(int stateless_rpc,
 -:  ---------- >  2:  15ba1198b4 compat: create is_xplatform_dir_sep()
 2:  60a66c41bd !  3:  22d7ee7d4e dir API: add a generalized path_match_flags() function
    @@ Metadata
      ## Commit message ##
         dir API: add a generalized path_match_flags() function
     
    -    Add a path_match_flags() function and have the two sets of
    -    starts_with_dot_{,dot_}slash() functions added in
    -    63e95beb085 (submodule: port resolve_relative_url from shell to C,
    -    2016-04-15) and a2b26ffb1a8 (fsck: convert gitmodules url to URL
    -    passed to curl, 2020-04-18) be thin wrappers for it.
    +    Add a path_starts_with_dotslash_flags() function and have the two sets
    +    of starts_with_dot_{,dot_}slash() functions added in 63e95beb085
    +    (submodule: port resolve_relative_url from shell to C, 2016-04-15) and
    +    a2b26ffb1a8 (fsck: convert gitmodules url to URL passed to curl,
    +    2020-04-18) be thin wrappers for it.
     
         As the latter of those notes the fsck version was copied from the
         initial builtin/submodule--helper.c version.
     
    -    Since the code added in a2b26ffb1a8 was doing really doing the same as
    -    win32_is_dir_sep() added in 1cadad6f658 (git clone <url>
    -    C:\cygwin\home\USER\repo' is working (again), 2018-12-15) let's move
    -    the latter to git-compat-util.h is a is_xplatform_dir_sep(). We can
    -    then call either it or the platform-specific is_dir_sep() from this
    -    new function.
    -
    -    Let's likewise change code in various other places that was hardcoding
    -    checks for "'/' || '\\'" with the new is_xplatform_dir_sep(). As can
    -    be seen in those callers some of them still concern themselves with
    -    ':' (Mac OS classic?), but let's leave the question of whether that
    -    should be consolidated for some other time.
    -
         As we expect to make wider use of the "native" case in the future,
         define and use two starts_with_dot_{,dot_}slash_native() convenience
         wrappers. This makes the diff in builtin/submodule--helper.c much
         smaller.
     
    -    Signed-off-by: Derrick Stolee <derrickstolee@github.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Signed-off-by: Derrick Stolee <derrickstolee@github.com>
     
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static char *get_default_remote(void)
    @@ builtin/submodule--helper.c: static int chop_last_dir(char **remoteurl, int is_r
      
     +static int starts_with_dot_slash(const char *const path)
     +{
    -+	return starts_with_dot_slash_native(path);;
    ++	return starts_with_dot_slash_native(path);
     +}
     +
     +static int starts_with_dot_dot_slash(const char *const path)
    @@ builtin/submodule--helper.c: static int chop_last_dir(char **remoteurl, int is_r
       * The `url` argument is the URL that navigates to the submodule origin
       * repo. When relative, this URL is relative to the superproject origin
     
    - ## compat/mingw.c ##
    -@@ compat/mingw.c: int is_valid_win32_path(const char *path, int allow_literal_nul)
    - 			}
    - 
    - 			c = path[i];
    --			if (c && c != '.' && c != ':' && c != '/' && c != '\\')
    -+			if (c && c != '.' && c != ':' && !is_xplatform_dir_sep(c))
    - 				goto not_a_reserved_name;
    - 
    - 			/* contains reserved name */
    -
    - ## compat/win32/path-utils.h ##
    -@@ compat/win32/path-utils.h: int win32_has_dos_drive_prefix(const char *path);
    - 
    - int win32_skip_dos_drive_prefix(char **path);
    - #define skip_dos_drive_prefix win32_skip_dos_drive_prefix
    --static inline int win32_is_dir_sep(int c)
    --{
    --	return c == '/' || c == '\\';
    --}
    --#define is_dir_sep win32_is_dir_sep
    -+#define is_dir_sep is_xplatform_dir_sep
    - static inline char *win32_find_last_dir_sep(const char *path)
    - {
    - 	char *ret = NULL;
    -
      ## dir.c ##
     @@ dir.c: void relocate_gitdir(const char *path, const char *old_git_dir, const char *new_
      
          connect_work_tree_and_git_dir(path, new_git_dir, 0);
      }
     +
    -+int path_match_flags(const char *const str, const enum path_match_flags flags)
    ++int path_starts_with_dotslash_flags(const char *const str,
    ++				    const enum path_match_flags flags)
     +{
     +	const char *p = str;
     +
     +	if (flags & PATH_MATCH_NATIVE &&
     +	    flags & PATH_MATCH_XPLATFORM)
    -+		BUG("path_match_flags() must get one match kind, not multiple!");
    ++		BUG("path_starts_with_dotslash_flags() must get one match kind, not multiple!");
     +	else if (!(flags & PATH_MATCH_KINDS_MASK))
    -+		BUG("path_match_flags() must get at least one match kind!");
    ++		BUG("path_starts_with_dotslash_flags() must get at least one match kind!");
     +
     +	if (flags & PATH_MATCH_STARTS_WITH_DOT_SLASH &&
     +	    flags & PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH)
    -+		BUG("path_match_flags() must get one platform kind, not multiple!");
    ++		BUG("path_starts_with_dotslash_flags() must get one platform kind, not multiple!");
     +	else if (!(flags & PATH_MATCH_PLATFORM_MASK))
    -+		BUG("path_match_flags() must get at least one platform kind!");
    ++		BUG("path_starts_with_dotslash_flags() must get at least one platform kind!");
     +
     +	if (*p++ != '.')
     +		return 0;
    @@ dir.h: void connect_work_tree_and_git_dir(const char *work_tree,
                   const char *new_git_dir);
     +
     +/**
    -+ * The "enum path_matches_kind" determines how path_match_flags() will
    -+ * behave. The flags come in sets, and one (and only one) must be
    ++ * The "enum path_matches_kind" determines how path_starts_with_dotslash_flags()
    ++ * will behave. The flags come in sets, and one (and only one) must be
     + * provided out of each "set":
     + *
     + * PATH_MATCH_NATIVE:
    @@ dir.h: void connect_work_tree_and_git_dir(const char *work_tree,
     +#define PATH_MATCH_PLATFORM_MASK (PATH_MATCH_NATIVE | PATH_MATCH_XPLATFORM)
     +
     +/**
    -+ * path_match_flags() checks if a given "path" matches a given "enum
    -+ * path_match_flags" criteria.
    ++ * path_starts_with_dotslash_flags() checks if a given "path" matches a
    ++ * given "enum path_match_flags" criteria.
     + */
    -+int path_match_flags(const char *const path, const enum path_match_flags f);
    ++int path_starts_with_dotslash_flags(const char *const path,
    ++				    const enum path_match_flags f);
     +
     +/**
     + * starts_with_dot_slash_native(): convenience wrapper for
    -+ * path_match_flags() with PATH_MATCH_STARTS_WITH_DOT_SLASH and
    -+ * PATH_MATCH_NATIVE.
    ++ * path_starts_with_dotslash_flags() with PATH_MATCH_STARTS_WITH_DOT_SLASH
    ++ * and PATH_MATCH_NATIVE.
     + */
     +static inline int starts_with_dot_slash_native(const char *const path)
     +{
     +	const enum path_match_flags what = PATH_MATCH_STARTS_WITH_DOT_SLASH;
     +
    -+	return path_match_flags(path, what | PATH_MATCH_NATIVE);
    ++	return path_starts_with_dotslash_flags(path, what | PATH_MATCH_NATIVE);
     +}
     +
     +/**
     + * starts_with_dot_slash_native(): convenience wrapper for
    -+ * path_match_flags() with PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH and
    -+ * PATH_MATCH_NATIVE.
    ++ * path_starts_with_dotslash_flags() with
    ++ * PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH and PATH_MATCH_NATIVE.
     + */
     +static inline int starts_with_dot_dot_slash_native(const char *const path)
     +{
     +	const enum path_match_flags what = PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH;
     +
    -+	return path_match_flags(path, what | PATH_MATCH_NATIVE);
    ++	return path_starts_with_dotslash_flags(path, what | PATH_MATCH_NATIVE);
     +}
      #endif
     
    @@ fsck.c: int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
     +static int starts_with_dot_slash(const char *const path)
      {
     -	return str[0] == '.' && (str[1] == '/' || str[1] == '\\');
    -+	return path_match_flags(path, PATH_MATCH_STARTS_WITH_DOT_SLASH |
    -+				PATH_MATCH_XPLATFORM);
    ++	const int flags = PATH_MATCH_STARTS_WITH_DOT_SLASH |
    ++			  PATH_MATCH_XPLATFORM;
    ++	return path_starts_with_dotslash_flags(path, flags);
      }
      
     -/*
    @@ fsck.c: int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
     +static int starts_with_dot_dot_slash(const char *const path)
      {
     -	return str[0] == '.' && starts_with_dot_slash(str + 1);
    -+	return path_match_flags(path, PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH |
    -+				PATH_MATCH_XPLATFORM);
    ++	const int flags = PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH |
    ++			  PATH_MATCH_XPLATFORM;
    ++	return path_starts_with_dotslash_flags(path, flags);
      }
      
      static int submodule_url_is_relative(const char *url)
    -
    - ## git-compat-util.h ##
    -@@
    - #include <sys/sysctl.h>
    - #endif
    - 
    -+/* Used by compat/win32/path-utils.h, and more */
    -+static inline int is_xplatform_dir_sep(int c)
    -+{
    -+	return c == '/' || c == '\\';
    -+}
    -+
    - #if defined(__CYGWIN__)
    - #include "compat/win32/path-utils.h"
    - #endif
    -@@ git-compat-util.h: static inline int git_skip_dos_drive_prefix(char **path)
    - #define skip_dos_drive_prefix git_skip_dos_drive_prefix
    - #endif
    - 
    --#ifndef is_dir_sep
    - static inline int git_is_dir_sep(int c)
    - {
    - 	return c == '/';
    - }
    -+#ifndef is_dir_sep
    - #define is_dir_sep git_is_dir_sep
    - #endif
    - 
    -
    - ## path.c ##
    -@@ path.c: int is_ntfs_dotgit(const char *name)
    - 
    - 	for (;;) {
    - 		c = *(name++);
    --		if (!c || c == '\\' || c == '/' || c == ':')
    -+		if (!c || is_xplatform_dir_sep(c) || c == ':')
    - 			return 1;
    - 		if (c != '.' && c != ' ')
    - 			return 0;
    -
    - ## submodule-config.c ##
    -@@ submodule-config.c: int check_submodule_name(const char *name)
    - 		return -1;
    - 
    - 	/*
    --	 * Look for '..' as a path component. Check both '/' and '\\' as
    -+	 * Look for '..' as a path component. Check is_xplatform_dir_sep() as
    - 	 * separators rather than is_dir_sep(), because we want the name rules
    - 	 * to be consistent across platforms.
    - 	 */
    - 	goto in_component; /* always start inside component */
    - 	while (*name) {
    - 		char c = *name++;
    --		if (c == '/' || c == '\\') {
    -+		if (is_xplatform_dir_sep(c)) {
    - in_component:
    - 			if (name[0] == '.' && name[1] == '.' &&
    --			    (!name[2] || name[2] == '/' || name[2] == '\\'))
    -+			    (!name[2] || is_xplatform_dir_sep(name[2])))
    - 				return -1;
    - 		}
    - 	}
 -:  ---------- >  4:  01847c9570 amend! compat: create is_xplatform_dir_sep()
 3:  15fea3f4da !  5:  3acb0f9637 fetch-pack: add a deref_without_lazy_fetch_extended()
    @@ Commit message
         subsequent commit.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Signed-off-by: Derrick Stolee <derrickstolee@github.com>
     
      ## fetch-pack.c ##
     @@ fetch-pack.c: static void for_each_cached_alternate(struct fetch_negotiator *negotiator,
    @@ fetch-pack.c: static void for_each_cached_alternate(struct fetch_negotiator *neg
     +	struct object_info info = { .typep = type };
          struct commit *commit;
      
    ++	if (!info.typep)
    ++		BUG("must pass non-NULL type");
    ++
          commit = lookup_commit_in_graph(the_repository, oid);
    -@@ fetch-pack.c: static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
    + 	if (commit)
    + 		return commit;
      
          while (1) {
              if (oid_object_info_extended(the_repository, oid, &info,
    @@ fetch-pack.c: static struct commit *deref_without_lazy_fetch(const struct object
          return NULL;
      }
      
    -+
     +static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
     +					       int mark_tags_complete)
     +{
 4:  009cb42cca !  6:  04508f83c0 fetch-pack: move --keep=* option filling to a function
    @@ Commit message
         function.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Signed-off-by: Derrick Stolee <derrickstolee@github.com>
     
      ## fetch-pack.c ##
     @@ fetch-pack.c: static void parse_gitmodules_oids(int fd, struct oidset *gitmodules_oids)
 5:  55462172ed =  7:  23df88a454 http: make http_get_file() external
 6:  2783486464 !  8:  c410280d2b remote: move relative_url()
    @@ Commit message
            functionally identical "starts_with_dot_{,dot_}slash()" wrappers
            "builtin/submodule--helper.c".
     
    -    Signed-off-by: Derrick Stolee <derrickstolee@github.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Signed-off-by: Derrick Stolee <derrickstolee@github.com>
     
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static char *get_default_remote(void)
    @@ builtin/submodule--helper.c: static char *get_default_remote(void)
     -
     -static int starts_with_dot_slash(const char *const path)
     -{
    --	return starts_with_dot_slash_native(path);;
    +-	return starts_with_dot_slash_native(path);
     -}
     -
     -static int starts_with_dot_dot_slash(const char *const path)
    @@ builtin/submodule--helper.c: static int module_foreach(int argc, const char **ar
      
     +static int starts_with_dot_slash(const char *const path)
     +{
    -+	return path_match_flags(path, PATH_MATCH_STARTS_WITH_DOT_SLASH |
    -+				PATH_MATCH_XPLATFORM);
    ++	const int flags = PATH_MATCH_STARTS_WITH_DOT_SLASH |
    ++			  PATH_MATCH_XPLATFORM;
    ++	return path_starts_with_dotslash_flags(path, flags);
     +}
     +
     +static int starts_with_dot_dot_slash(const char *const path)
     +{
    -+	return path_match_flags(path, PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH |
    -+				PATH_MATCH_XPLATFORM);
    ++	const int flags = PATH_MATCH_STARTS_WITH_DOT_DOT_SLASH |
    ++			  PATH_MATCH_XPLATFORM;
    ++	return path_starts_with_dotslash_flags(path, flags);
     +}
     +
      struct init_cb {
 7:  e0a387c6a0 !  9:  5c112c1994 remote: allow relative_url() to return an absolute url
    @@ Commit message
         The documentation now discusses what happens when supplying two
         absolute URLs.
     
    -    Signed-off-by: Derrick Stolee <derrickstolee@github.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Signed-off-by: Derrick Stolee <derrickstolee@github.com>
     
      ## remote.c ##
     @@ remote.c: char *relative_url(const char *remote_url, const char *url,
 8:  a38b6f388a ! 10:  2afa9c2e73 bundle.h: make "fd" version of read_bundle_header() public
    @@ Commit message
         will be used by code that wants to pass a fd to the bundle API.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Signed-off-by: Derrick Stolee <derrickstolee@github.com>
     
      ## bundle.c ##
     @@ bundle.c: static int parse_bundle_signature(struct bundle_header *header, const char *line


Derrick Stolee (3):
  http: make http_get_file() external
  remote: move relative_url()
  remote: allow relative_url() to return an absolute url

Ævar Arnfjörð Bjarmason (5):
  connect.c: refactor sending of agent & object-format
  dir API: add a generalized path_match_flags() function
  fetch-pack: add a deref_without_lazy_fetch_extended()
  fetch-pack: move --keep=* option filling to a function
  bundle.h: make "fd" version of read_bundle_header() public

 builtin/submodule--helper.c | 141 +++---------------------------------
 bundle.c                    |   8 +-
 bundle.h                    |   2 +
 compat/mingw.c              |   2 +-
 compat/win32/path-utils.h   |   6 +-
 connect.c                   |  33 +++++----
 dir.c                       |  29 ++++++++
 dir.h                       |  63 ++++++++++++++++
 fetch-pack.c                |  45 ++++++++----
 fsck.c                      |  23 ++----
 git-compat-util.h           |   8 +-
 http.c                      |   4 +-
 http.h                      |   9 +++
 path.c                      |   2 +-
 remote.c                    |  99 +++++++++++++++++++++++++
 remote.h                    |  32 ++++++++
 submodule-config.c          |   6 +-
 17 files changed, 321 insertions(+), 191 deletions(-)


base-commit: 6cd33dceed60949e2dbc32e3f0f5e67c4c882e1e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1233%2Fderrickstolee%2Fbundle-redo%2Fprepare-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1233/derrickstolee/bundle-redo/prepare-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1233
-- 
gitgitgadget
