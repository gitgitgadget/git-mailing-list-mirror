Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9360EC433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 22:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DC6E610E6
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 22:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhJSWqB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 18:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhJSWqA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 18:46:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E98C06161C
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 15:43:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z130-20020a256588000000b005b6b4594129so27489831ybb.15
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 15:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tj0mjRlem7Sbiqf12C7UfdFQxO5xsdvN9fiKffBAYg0=;
        b=gbfhh6UnSWbdmWYOQuwmdjDKZlbclJ50Gl+G5JlyfbZmZepUs+clH5+dw6ISF8RJzY
         0OecmBaBfvCO97ID03wSCj7l20osq3x35PGgNPva/xlDOwwVKlK28Xeb99IgyhcFBWj1
         AeYn8m5JMebhb1t7xAProxkjkR6b+SOVyrFhU3/p6e2uvU1xycTnFqKxyMZ5hTNDSITs
         k25WN19tQlDcCR0Ri8H4Stl8u602qGsxD9OF66x/crGZBfaR6qDQ9qc5xISG5iyheqOi
         y+Wx59C/nNxVveIXby2wvpJS7U0Us5imZbgSjXbjiaqwXO90NQK0VtmadfapvBN1Ve7O
         yg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tj0mjRlem7Sbiqf12C7UfdFQxO5xsdvN9fiKffBAYg0=;
        b=R1VLvKey9eMpT5Ob+TfQaDHmgDRr4iFAg84gAihUtUgeEE4do5/cXtrxvNLh6DSPXm
         lV54S9leVKgNrBzRYdQ93TtspHqZoVwVPJPivQ1sfMSDGq9BIF9Fn+9hCX1SDenMVAc6
         TWO4zyVhGJQtevG4rIw19JmjZ6Hj89K1DtwFfZGHj3GZUhKqnyKYkkSAit3aJegYYvSB
         Ask5rREXWTFsL/gnkCztwr9hQkSmuTkyIkVTU7uHhvfkUsjZBx4phkOAlaUOw0JJLAu4
         xfLJEmru1MN1J0XEciljwWdE6MOOa1KkAkc2IMttts70ttXhNBSTzS+wAyx421MW4pFr
         OawA==
X-Gm-Message-State: AOAM532ibAlMXBNtJa5DqLK3V6z95uu8zCqJ9ahnWE9I43O5aZi2j4EB
        rhpcn7cinqAmd9UT6gLLdt/jTDsNctETzO575bvWhcmnAS2rPlOBc8CYTpfvp2/Jy2/SDavhbSP
        2t46aOahunKlwrIPNEK58HSSeLd7U8+TQWtAHh9yNIeXpMEaK91TYeFxaEEmy74s=
X-Google-Smtp-Source: ABdhPJxOcXHdrfs8tivUrcLVMkezfNBn6019cLxhKX1nRLsd/tqoZiW8mCR4OiDgkFLNDsn0/USczxp99LhkTA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:ac68:: with SMTP id
 r40mr38426776ybd.128.1634683425959; Tue, 19 Oct 2021 15:43:45 -0700 (PDT)
Date:   Tue, 19 Oct 2021 15:43:35 -0700
In-Reply-To: <20211013193127.76537-1-chooglen@google.com>
Message-Id: <20211019224339.61881-1-chooglen@google.com>
Mime-Version: 1.0
References: <20211013193127.76537-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v3 0/4] remote: replace static variables with struct remote_state
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series aims to make the remotes subsystem work with non-the_repository,
which will allow submodule remotes to be accessed in-process, rather than
through child processes. This is accomplished by creating a struct remote_state
and adding it to struct repository.

One motivation for this is that it allows future submodule commands to run
in-process. An example is an RFC series of mine [1], where I tried to implement
"git branch --recurse-submodules" in-process but couldn't figure out how to read
the remotes of a submodule.

v3 tightens up the interface issues discussed previously ([2] and other v2
discussion) by adding a "struct remote_state" backpointer to "struct branch" and
"struct remote". The most notable improvement is that we no longer accept
"struct {remote_state,repository}" and "struct {branch,remote}" parameters at
the same time, thus it is impossible to pass the wrong (container, contained)
object pair. This is especially useful for branch_get_push_1(), where we
take a "struct branch" and need to get a related "struct remote".

The intention is that this backpointer is only meant to be used by the remotes
subsystem; it is meant to be an opaque implementation detail that no other
callers should touch.

I attempted the initial suggestion to include a backpointer from branch->repo
instead of branch->remote_state and uploaded it to a branch in my own fork [3].
However, this seems to be the wrong abstraction to me. I am not convinced that
the contained structs (branch, remote) need to (nor will ever need to) interact
with parts of the repository outside of remote_state. A symptom of this is that
internal code ends up using "struct repository" parameters instead of "struct
remote_state" only to use repo->remote_state repeatedly, violating some of the
nice layering that we have set up.

There is also a small YAGNI benefit of using a backpointer to the remote_state
instead of repository. If we eventually decide that branches should
point to their repository, we can make the change with
s/remote_state/repo->remote_state, even if external callers start to rely on
branch->remote_state (even though I don't think they shouldn't rely on it!).
This property does not hold for branch->repo because external callers might be
using members other than repository->remote_state.

[1] https://lore.kernel.org/git/20210921232529.81811-1-chooglen@google.com/
[2] https://lore.kernel.org/git/xmqq4k9so15i.fsf@gitster.g/
[3] https://github.com/git/git/commit/9527d9106ff5a41530e7bfa50a316af296144c99

Changes since v2:
* Add .remote_state to struct branch and struct remote, changing the
  implementation appropriately.
* In patch 2, properly consider the initialized state of remote_state.
  In v2, I forgot to convert a static inside read_config() into a
  private member of struct remote_state. Fix this.
* In a new patch 3, add helper methods that get a remote via
  remote_state and the remote name.
* Move read_config(repo) calls to the external facing-functions. This keeps
  "struct repository" away from the remote.c internals.

Changes since v1:

* In v1, we moved static variables into the_repository->remote_state in
  two steps: static variables > static remote_state >
  the_repository->remote_state. In v2, make this change in one step:
  static variables > the_repository->remote_state.
* Add more instances of repo_* that were missed.

Glen Choo (4):
  remote: move static variables into per-repository struct
  remote: use remote_state parameter internally
  remote: remove the_repository->remote_state from static methods
  remote: add struct repository parameter to external functions

 remote.c     | 303 +++++++++++++++++++++++++++++++--------------------
 remote.h     |  72 +++++++++++-
 repository.c |   8 ++
 repository.h |   4 +
 4 files changed, 262 insertions(+), 125 deletions(-)

Range-diff against v2:
1:  6972ba4dcb ! 1:  1f712c22b4 remote: move static variables into per-repository struct
    @@ remote.h: enum {
     +	int instead_of_nr;
     +	int instead_of_alloc;
     +};
    ++
     +struct rewrites {
     +	struct rewrite **rewrite;
     +	int rewrite_alloc;
    @@ remote.h: enum {
     +};
     +
     +struct remote_state {
    -+	int config_loaded;
    -+
     +	struct remote **remotes;
     +	int remotes_alloc;
     +	int remotes_nr;
    @@ remote.h: enum {
     +	struct rewrites rewrites;
     +	struct rewrites rewrites_push;
     +};
    ++
     +void remote_state_clear(struct remote_state *remote_state);
     +struct remote_state *remote_state_new(void);
     +
2:  71b1da4389 ! 2:  467247fa9c remote: use remote_state parameter internally
    @@ Metadata
      ## Commit message ##
         remote: use remote_state parameter internally
     
    -    In internal-facing functions, replace the_repository->remote_state with
    -    a struct remote_state parameter, but do not change external-facing
    -    functions.
    +    Introduce a struct remote_state member to structs that need to
    +    'remember' their remote_state. Without changing external-facing
    +    functions, replace the_repository->remote_state internally by using the
    +    remote_state member where it is applicable i.e. when a function accepts
    +    a struct that depends on the remote_state. If it is not applicable, add
    +    a struct remote_state parameter instead.
     
    -    As a result, most static functions no longer reference
    +    As a result, external-facing functions are still tied to the_repository,
    +    but most static functions no longer reference
         the_repository->remote_state. The exceptions are those that are used in
         a way that depends on external-facing functions e.g. the callbacks to
         remote_get_1().
    @@ Commit message
     
      ## remote.c ##
     @@ remote.c: static void add_pushurl(struct remote *remote, const char *pushurl)
    - 	remote->pushurl[remote->pushurl_nr++] = pushurl;
    - }
    - 
    --static void add_pushurl_alias(struct remote *remote, const char *url)
    -+static void add_pushurl_alias(struct remote_state *remote_state,
    -+			      struct remote *remote, const char *url)
    + static void add_pushurl_alias(struct remote *remote, const char *url)
      {
    --	const char *pushurl =
    + 	const char *pushurl =
     -		alias_url(url, &the_repository->remote_state->rewrites_push);
    -+	const char *pushurl = alias_url(url, &remote_state->rewrites_push);
    ++		alias_url(url, &remote->remote_state->rewrites_push);
      	if (pushurl != url)
      		add_pushurl(remote, pushurl);
      }
      
    --static void add_url_alias(struct remote *remote, const char *url)
    -+static void add_url_alias(struct remote_state *remote_state,
    -+			  struct remote *remote, const char *url)
    + static void add_url_alias(struct remote *remote, const char *url)
      {
     -	add_url(remote,
     -		alias_url(url, &the_repository->remote_state->rewrites));
    --	add_pushurl_alias(remote, url);
    -+	add_url(remote, alias_url(url, &remote_state->rewrites));
    -+	add_pushurl_alias(remote_state, remote, url);
    ++	add_url(remote, alias_url(url, &remote->remote_state->rewrites));
    + 	add_pushurl_alias(remote, url);
      }
      
    - struct remotes_hash_key {
     @@ remote.c: static int remotes_hash_cmp(const void *unused_cmp_data,
      		return strcmp(a->name, b->name);
      }
    @@ remote.c: static struct remote *make_remote(const char *name, int len)
      		return container_of(e, struct remote, ent);
      
     @@ remote.c: static struct remote *make_remote(const char *name, int len)
    + 	ret->prune = -1;  /* unspecified */
    + 	ret->prune_tags = -1;  /* unspecified */
    + 	ret->name = xstrndup(name, len);
    ++	ret->remote_state = remote_state;
      	refspec_init(&ret->push, REFSPEC_PUSH);
      	refspec_init(&ret->fetch, REFSPEC_FETCH);
      
    @@ remote.c: static void add_merge(struct branch *branch, const char *name)
     +	remote_state->branches[remote_state->branches_nr++] = ret;
      	ret->name = xstrndup(name, len);
      	ret->refname = xstrfmt("refs/heads/%s", ret->name);
    ++	ret->remote_state = remote_state;
      
    -@@ remote.c: static const char *skip_spaces(const char *s)
    - 	return s;
    - }
    - 
    --static void read_remotes_file(struct remote *remote)
    -+static void read_remotes_file(struct remote_state *remote_state,
    -+			      struct remote *remote)
    - {
    - 	struct strbuf buf = STRBUF_INIT;
    - 	FILE *f = fopen_or_warn(git_path("remotes/%s", remote->name), "r");
    -@@ remote.c: static void read_remotes_file(struct remote *remote)
    - 		strbuf_rtrim(&buf);
    - 
    - 		if (skip_prefix(buf.buf, "URL:", &v))
    --			add_url_alias(remote, xstrdup(skip_spaces(v)));
    -+			add_url_alias(remote_state, remote,
    -+				      xstrdup(skip_spaces(v)));
    - 		else if (skip_prefix(buf.buf, "Push:", &v))
    - 			refspec_append(&remote->push, skip_spaces(v));
    - 		else if (skip_prefix(buf.buf, "Pull:", &v))
    -@@ remote.c: static void read_remotes_file(struct remote *remote)
    - 	fclose(f);
    + 	return ret;
      }
    - 
    --static void read_branches_file(struct remote *remote)
    -+static void read_branches_file(struct remote_state *remote_state,
    -+			       struct remote *remote)
    - {
    - 	char *frag;
    - 	struct strbuf buf = STRBUF_INIT;
    -@@ remote.c: static void read_branches_file(struct remote *remote)
    - 	else
    - 		frag = (char *)git_default_branch_name(0);
    - 
    --	add_url_alias(remote, strbuf_detach(&buf, NULL));
    -+	add_url_alias(remote_state, remote, strbuf_detach(&buf, NULL));
    - 	refspec_appendf(&remote->fetch, "refs/heads/%s:refs/heads/%s",
    - 			frag, remote->name);
    - 
     @@ remote.c: static int handle_config(const char *key, const char *value, void *cb)
      	const char *subkey;
      	struct remote *remote;
    @@ remote.c: static int handle_config(const char *key, const char *value, void *cb)
     -				->url[j] = alias_url(
     -				the_repository->remote_state->remotes[i]->url[j],
     -				&the_repository->remote_state->rewrites);
    -+					remote_state, remote_state->remotes[i],
    ++					remote_state->remotes[i],
     +					remote_state->remotes[i]->url[j]);
     +			remote_state->remotes[i]->url[j] =
     +				alias_url(remote_state->remotes[i]->url[j],
    @@ remote.c: static int handle_config(const char *key, const char *value, void *cb)
      }
      
     -static void read_config(void)
    -+static void read_config(struct remote_state *remote_state)
    ++static void read_config(struct repository *repo)
      {
    - 	static int loaded;
    +-	static int loaded;
      	int flag;
    -@@ remote.c: static void read_config(void)
    + 
    +-	if (loaded)
    ++	if (repo->remote_state->initialized)
      		return;
    - 	loaded = 1;
    +-	loaded = 1;
    ++	repo->remote_state->initialized = 1;
      
     -	the_repository->remote_state->current_branch = NULL;
    -+	remote_state->current_branch = NULL;
    ++	repo->remote_state->current_branch = NULL;
      	if (startup_info->have_repository) {
    - 		const char *head_ref = resolve_ref_unsafe("HEAD", 0, NULL, &flag);
    +-		const char *head_ref = resolve_ref_unsafe("HEAD", 0, NULL, &flag);
    ++		const char *head_ref = refs_resolve_ref_unsafe(
    ++			get_main_ref_store(repo), "HEAD", 0, NULL, &flag);
      		if (head_ref && (flag & REF_ISSYMREF) &&
      		    skip_prefix(head_ref, "refs/heads/", &head_ref)) {
     -			the_repository->remote_state->current_branch =
     -				make_branch(head_ref, strlen(head_ref));
    -+			remote_state->current_branch = make_branch(
    -+				remote_state, head_ref, strlen(head_ref));
    ++			repo->remote_state->current_branch = make_branch(
    ++				repo->remote_state, head_ref, strlen(head_ref));
      		}
      	}
     -	git_config(handle_config, NULL);
     -	alias_all_urls();
    -+	git_config(handle_config, remote_state);
    -+	alias_all_urls(remote_state);
    ++	repo_config(repo, handle_config, repo->remote_state);
    ++	alias_all_urls(repo->remote_state);
      }
      
      static int valid_remote_nick(const char *name)
    +@@ remote.c: const char *pushremote_for_branch(struct branch *branch, int *explicit)
    + 			*explicit = 1;
    + 		return branch->pushremote_name;
    + 	}
    +-	if (the_repository->remote_state->pushremote_name) {
    ++	if (branch->remote_state->pushremote_name) {
    + 		if (explicit)
    + 			*explicit = 1;
    +-		return the_repository->remote_state->pushremote_name;
    ++		return branch->remote_state->pushremote_name;
    + 	}
    + 	return remote_for_branch(branch, explicit);
    + }
     @@ remote.c: static struct remote *remote_get_1(const char *name,
      	struct remote *ret;
      	int name_given = 0;
      
     -	read_config();
    -+	read_config(the_repository->remote_state);
    ++	read_config(the_repository);
      
      	if (name)
      		name_given = 1;
    @@ remote.c: static struct remote *remote_get_1(const char *name,
     +	ret = make_remote(the_repository->remote_state, name, 0);
      	if (valid_remote_nick(name) && have_git_dir()) {
      		if (!valid_remote(ret))
    --			read_remotes_file(ret);
    -+			read_remotes_file(the_repository->remote_state, ret);
    - 		if (!valid_remote(ret))
    --			read_branches_file(ret);
    -+			read_branches_file(the_repository->remote_state, ret);
    - 	}
    - 	if (name_given && !valid_remote(ret))
    --		add_url_alias(ret, name);
    -+		add_url_alias(the_repository->remote_state, ret, name);
    - 	if (!valid_remote(ret))
    - 		return NULL;
    - 	return ret;
    + 			read_remotes_file(ret);
     @@ remote.c: int remote_is_configured(struct remote *remote, int in_repo)
      int for_each_remote(each_remote_fn fn, void *priv)
      {
      	int i, result = 0;
     -	read_config();
    -+	read_config(the_repository->remote_state);
    ++	read_config(the_repository);
      	for (i = 0; i < the_repository->remote_state->remotes_nr && !result;
      	     i++) {
      		struct remote *remote =
    @@ remote.c: struct branch *branch_get(const char *name)
      	struct branch *ret;
      
     -	read_config();
    -+	read_config(the_repository->remote_state);
    ++	read_config(the_repository);
      	if (!name || !*name || !strcmp(name, "HEAD"))
      		ret = the_repository->remote_state->current_branch;
      	else
    @@ remote.c: struct branch *branch_get(const char *name)
      	set_merge(ret);
      	return ret;
      }
    +
    + ## remote.h ##
    +@@ remote.h: struct remote_state {
    + 
    + 	struct rewrites rewrites;
    + 	struct rewrites rewrites_push;
    ++
    ++	int initialized;
    + };
    + 
    + void remote_state_clear(struct remote_state *remote_state);
    +@@ remote.h: struct remote {
    + 
    + 	/* The method used for authenticating against `http_proxy`. */
    + 	char *http_proxy_authmethod;
    ++
    ++	/** The remote_state that this remote belongs to. This is only meant to
    ++	 * be used by remote_* functions. */
    ++	struct remote_state *remote_state;
    + };
    + 
    + /**
    +@@ remote.h: struct branch {
    + 	int merge_alloc;
    + 
    + 	const char *push_tracking_ref;
    ++
    ++	/** The remote_state that this branch belongs to. This is only meant to
    ++	 * be used by branch_* functions. */
    ++	struct remote_state *remote_state;
    + };
    + 
    + struct branch *branch_get(const char *name);
3:  ff12771f06 < -:  ---------- remote: add struct repository parameter to external functions
-:  ---------- > 3:  10fbb84496 remote: remove the_repository->remote_state from static methods
-:  ---------- > 4:  4013f74fd9 remote: add struct repository parameter to external functions
-- 
2.33.GIT

