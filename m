Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285602571B0
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771920205; cv=none; b=id2LwZdnhDfFgIuWt2LFrMRYNOyEYKefdqkCZU2+1XbAG0M8a3+I00NH1EeUlWAyj3CVp+2IET+FYBMQOB6cUeDHSh/ulUt+2xG+0BtqMOEjJxmuMKD30QKfKEtaNbCAUkihKtkbhSz3QA6cStzn53PKccbK2x2X86/l7Sw4wsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771920205; c=relaxed/simple;
	bh=FfOdYvrIZzrTJzjhKEtNhUbCbcWNcq6dppB2//xQO+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvMpmrkpkGSGSuwX78pTecTaHZeNKwskCDdQoS4I04XinhYr0gATPB9Q+s0FhYPwAz+X+1bSuCPekjIsRMn26/6FmQ5V4w1xenqdL0jv7DzbmK6SP1P79i1ihkbrU09u9f2majxSANWWOJ6JlAZMS1/EGVKTaSNCx0UN+mt+6FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n062ki4b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gAQFTX01; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n062ki4b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gAQFTX01"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6663014001E9;
	Tue, 24 Feb 2026 03:03:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 24 Feb 2026 03:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771920202; x=1772006602; bh=a/rwOERFKg
	sraQh8ajIDgL2jWs5vw5KIDLyTMEUI8zg=; b=n062ki4bqfgRVqKrpRzejKuj7+
	CA3PpqIc9y14RrWnJzolczBwyi2EzpIt+N+Ue0sEGMATEDZP/J7TWwVlch0v13s/
	bJh/Xm85tAplrQm0t6J90u+hKuqXY2cbYR99hUN7y1hMRaT23iYM2Nos8Zv87RsC
	kI+aStoL5I3l/MdM/lM/oeaQpuCLDNeBQ42ppfLfKBmwCPlCNM5ut309M8pmjSzR
	dSlGk2LGxoQ7aJAXeugjswm0q3vONDqLdULmLFTvNJ0O+Jt1Q8tTx1WLQAzfWpGU
	ZIl6YZUTV4HC5Knyyl4ap+NuD9XVFiCYhUWogsUDmkvmbTS6BsajjMVJqBNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771920202; x=1772006602; bh=a/rwOERFKgsraQh8ajIDgL2jWs5vw5KIDLy
	TMEUI8zg=; b=gAQFTX01N2KsbFjcKUrcHgIAifc+GmLfq2XZjx7TzxtXqYjbFpk
	WYLj9HIcV/raRosPOAWSpb47sc+SrdoJogtewVpfyh6cXoXFuFpaLytEdvrojstK
	/l1FRPcz16WijME0s9wBnc6o769whoCEFBo7Ivl6EowMw69g13bee9EEop/vXnXC
	fWsQZ0KBC+En2i+vcVEU1xPTYN+YjePt2M4gCjWnvC0gSzIJpH7uzZfNSgrDXp/A
	j102GijDmr/bKVnWIzrJ+BdceC6Kb+Z3ybN2INVLdJYZ+9PdGPHoVBnowUpxSDc+
	7lmAfmmbag5lFU3eDRZpxmvWVkU06nxmbyQ==
X-ME-Sender: <xms:SludaeVkLBXwyUny9QyN2STdfOAG-3I_dL7nfz1-Bc3v3e3l7WKiVA>
    <xme:SludaRl01-K9wM1k-q7SVnyKbWV0PtL9Yxs4zVU2HgmiPD3V0QPkS9ZMvEjuhaGnS
    wKdPpxUFu4lz1gtGDGFI1QRWqHUPn6c2ESFXVQvinJONtQIW0nPoQ>
X-ME-Received: <xmr:SludaXbyAEsp_uIqU-4syqBhh6xYh7aIUVnTiBRrTdhOJgvFMzdZL_-zRxCgZMUzwbS3a7RfERJmkuNq1fwQHIcFF7vLD80R-D3KiM_bi7bC0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeelieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epkeeitdfhjeetvefgkedtfeffffdutedvheehtdeggfevgfekheevvdevvedvtedtnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhdpmhgrnhejrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgs
    pghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhhuh
    gssehprghulhhishgrghgvvghkrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughg
    vghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehprghulhesphgruhhlthgrrhhjrghnrdgtohhm
X-ME-Proxy: <xmx:SludaUNOJXsECUSztJUwkR5MiUpeyn9mgFjhgV4r3YHS2_HBPJzuEA>
    <xmx:SludaUa6N-DhNjS7D_IjbhZkCIOHC1p9ei78V3WIcWT2Cw73X9SzpQ>
    <xmx:Sludaa2BM0QJGHS3jl1CrrNPzUNPyUX_hM4xQl75okScOOdMBs8pwA>
    <xmx:SludaSe41mnEfsHKRBRf6FWGhmE9oiEY3GiiJf0KMN7looVNA9SxAw>
    <xmx:SludadZG-MV4GUyOM89dAk0E7aSUjlZDnuRNZojBKegg4ATEjhTRhYG7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 03:03:21 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6b4e8ddd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Feb 2026 08:03:20 +0000 (UTC)
Date: Tue, 24 Feb 2026 09:03:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Paul Tarjan <paul@paultarjan.com>,
	Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v5] fsmonitor: implement filesystem change listener for
 Linux
Message-ID: <aZ1bRQv9Cjke298f@pks.im>
References: <pull.2147.v4.git.git.1767202894884.gitgitgadget@gmail.com>
 <pull.2147.v5.git.git.1771896704209.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2147.v5.git.git.1771896704209.gitgitgadget@gmail.com>

On Tue, Feb 24, 2026 at 01:31:44AM +0000, Paul Tarjan via GitGitGadget wrote:
> From: Paul Tarjan <github@paulisageek.com>
> 
> Implement fsmonitor for Linux using the inotify API, bringing it to
> feature parity with existing Windows and macOS implementations.
> 
> The Linux implementation uses inotify to monitor filesystem events.
> Unlike macOS's FSEvents which can watch a single root directory,
> inotify requires registering watches on every directory of interest.
> The implementation carefully handles directory renames and moves
> using inotify's cookie mechanism to track IN_MOVED_FROM/IN_MOVED_TO
> event pairs.

I think other than stating that this uses inotify, what this commit
message should also explain is why it was chosen over its alternatives
like fanotify.

> Key implementation details:
> - Uses inotify_init1(O_NONBLOCK) for non-blocking event monitoring
> - Maintains bidirectional hashmaps between watch descriptors and paths
>   for efficient event processing
> - Handles directory creation, deletion, and renames dynamically
> - Detects remote filesystems (NFS, CIFS, SMB, etc.) via statfs()
> - Falls back to $HOME/.git-fsmonitor-* for socket when .git is remote
> 
> Build configuration:
> - Enabled via FSMONITOR_DAEMON_BACKEND=linux and FSMONITOR_OS_SETTINGS=linux
> - Requires NO_PTHREADS and NO_UNIX_SOCKETS to be unset
> - Adds HAVE_LINUX_MAGIC_H for filesystem type detection

It would be great to avoid all these bulleted lists here and instead
have some paragraphs that explain the design decisions.

> Documentation updated to note that fsmonitor.socketDir is now supported
> on both Mac OS and Linux, and adds a section about inotify watch limits.
> 
> Issues addressed from PR #1352 (git/git) review comments:
> - GPLv3 ME_REMOTE macro: Rewrote remote filesystem detection from
>   scratch using statfs() and linux/magic.h constants (no GPLv3 code)
> - Memory leak on inotify_init1 failure: Added FREE_AND_NULL cleanup
> - Unsafe hashmap iteration in dtor: Collect entries first, then modify
> - Missing null checks in stop_async: Added proper guard conditions
> - dirname() modifying argument: Create copy with xstrdup() first
> - Non-portable f_fsid.__val: Use memcmp() for fsid comparison
> - Missing worktree null check: Added BUG() for null worktree
> - Header updates: Use git-compat-util.h, hash_to_hex_algop()
> - Code style: Use xstrdup() not xmemdupz(), proper pointer style
> 
> Issues addressed from PR #1667 (git/git) review comments:
> - EINTR handling: read() now handles both EAGAIN and EINTR
> - Trailing pipe in log_mask_set: Added strbuf_strip_suffix()
> - Unchecked add_watch return: Now logs failure in rename_dir()
> - String building: Consolidated strbuf operations with strbuf_addf()
> - Translation markers: Added _() to all error_errno() messages

The issues that you've addressed don't typically belong into the commit
message. They are useful context when part of a cover letter, but are
less useful in the commit messages themselves.

> Based on work from https://github.com/git/git/pull/1352 by Eric DeCosta,
> and https://github.com/git/git/pull/1667 by Marziyeh Esipreh, updated to
> work with the current codebase and address all review feedback.

In that case it might make sense to say "Based-on-patch-by:" for both of
these authors.

> diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
> index 242c594646..4d52622e24 100644
> --- a/builtin/fsmonitor--daemon.c
> +++ b/builtin/fsmonitor--daemon.c
> @@ -671,7 +671,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
>  	const struct fsmonitor_batch *batch;
>  	struct fsmonitor_batch *remainder = NULL;
>  	intmax_t count = 0, duplicates = 0;
> -	kh_str_t *shown;
> +	kh_str_t *shown = NULL;
>  	int hash_ret;
>  	int do_trivial = 0;
>  	int do_flush = 0;
> @@ -909,8 +909,6 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
>  		total_response_len += payload.len;
>  	}
>  
> -	kh_release_str(shown);
> -
>  	pthread_mutex_lock(&state->main_lock);
>  
>  	if (token_data->client_ref_count > 0)
> @@ -954,6 +952,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
>  	trace2_data_intmax("fsmonitor", the_repository, "response/count/duplicates", duplicates);
>  
>  cleanup:
> +	kh_destroy_str(shown);
>  	strbuf_release(&response_token);
>  	strbuf_release(&requested_token_id);
>  	strbuf_release(&payload);
> @@ -1405,6 +1404,7 @@ static int fsmonitor_run_daemon(void)
>  done:
>  	pthread_cond_destroy(&state.cookies_cond);
>  	pthread_mutex_destroy(&state.main_lock);
> +	hashmap_clear(&state.cookies);
>  	fsm_listen__dtor(&state);
>  	fsm_health__dtor(&state);
>  

These feel like while-at-it memory leak fixes. They should probably be
moved into separate commits with a proper explanation.

> diff --git a/compat/fsmonitor/fsm-ipc-linux.c b/compat/fsmonitor/fsm-ipc-linux.c
> new file mode 100644
> index 0000000000..d34a6419bc
> --- /dev/null
> +++ b/compat/fsmonitor/fsm-ipc-linux.c

This is (almost) the exact same implementation as we have on macOS. We
should probably deduplicate the logic.

> diff --git a/compat/fsmonitor/fsm-listen-linux.c b/compat/fsmonitor/fsm-listen-linux.c
> new file mode 100644
> index 0000000000..04441c5120
> --- /dev/null
> +++ b/compat/fsmonitor/fsm-listen-linux.c
> @@ -0,0 +1,740 @@
> +#include "git-compat-util.h"
> +#include "dir.h"
> +#include "fsmonitor-ll.h"
> +#include "fsm-listen.h"
> +#include "fsmonitor--daemon.h"
> +#include "fsmonitor-path-utils.h"
> +#include "gettext.h"
> +#include "simple-ipc.h"
> +#include "string-list.h"
> +#include "trace.h"
> +
> +#include <dirent.h>
> +#include <fcntl.h>
> +#include <poll.h>
> +#include <sys/inotify.h>
> +#include <sys/stat.h>

From these we should really only require <sys/inotify.h>, as all others
are included via "compat/posix.h"

> +/*
> + * Register an inotify watch, add watch descriptor to path mapping
> + * and the reverse mapping.
> + */
> +static int add_watch(const char *path, struct fsm_listen_data *data)
> +{
> +	const char *interned = strintern(path);
> +	struct watch_entry *w1, *w2;
> +
> +	/* add the inotify watch, don't allow watches to be modified */
> +	int wd = inotify_add_watch(data->fd_inotify, interned,
> +				   (IN_ALL_EVENTS | IN_ONLYDIR | IN_MASK_CREATE)
> +				    ^ IN_ACCESS ^ IN_CLOSE ^ IN_OPEN);
> +	if (wd < 0) {
> +		if (errno == ENOENT || errno == ENOTDIR)
> +			return 0; /* directory was deleted or is not a directory */
> +		if (errno == EEXIST)
> +			return 0; /* watch already exists, no action needed */

Hm. In case the watch already exists, can't it be the case that we have
raced e.g. during a rename? For example, the old watch hasn't been
removed yet, but we already try to create the new watch. If we then see
EEXIST we wouldn't update the hash map and thus keep the old path
intact.

Or is the order of inotify events guaranteed?

> +		return error_errno(_("inotify_add_watch('%s') failed"), interned);
> +	}
> +
> +	/* add watch descriptor -> directory mapping */
> +	CALLOC_ARRAY(w1, 1);
> +	w1->wd = wd;
> +	w1->dir = interned;
> +	hashmap_entry_init(&w1->ent, memhash(&w1->wd, sizeof(int)));
> +	hashmap_add(&data->watches, &w1->ent);
> +
> +	/* add directory -> watch descriptor mapping */
> +	CALLOC_ARRAY(w2, 1);
> +	w2->wd = wd;
> +	w2->dir = interned;
> +	hashmap_entry_init(&w2->ent, strhash(w2->dir));
> +	hashmap_add(&data->revwatches, &w2->ent);

We have to create two watch entries here, which is a bit puzzling at
first as you'd expect that we can simply sotre the same entry twice. But
this is a limitation of our hashmap interface.

> +	return 0;
> +}
> +
> +/*
> + * Remove the inotify watch, the watch descriptor to path mapping
> + * and the reverse mapping.
> + */
> +static void remove_watch(struct watch_entry *w, struct fsm_listen_data *data)
> +{
> +	struct watch_entry k1, k2, *w1, *w2;
> +
> +	/* remove watch, ignore error if kernel already did it */
> +	if (inotify_rm_watch(data->fd_inotify, w->wd) && errno != EINVAL)
> +		error_errno(_("inotify_rm_watch() failed"));
> +
> +	k1.wd = w->wd;
> +	hashmap_entry_init(&k1.ent, memhash(&k1.wd, sizeof(int)));
> +	w1 = hashmap_remove_entry(&data->watches, &k1, ent, NULL);
> +	if (!w1)
> +		BUG("Double remove of watch for '%s'", w->dir);

Error messages should start with a lower-case letter.

> +/*
> + * Recursively add watches to every directory under path
> + */
> +static int register_inotify(const char *path,
> +			    struct fsmonitor_daemon_state *state,
> +			    struct fsmonitor_batch *batch)
> +{
> +	DIR *dir;
> +	const char *rel;
> +	struct strbuf current = STRBUF_INIT;
> +	struct dirent *de;
> +	struct stat fs;
> +	int ret = -1;
> +
> +	dir = opendir(path);
> +	if (!dir) {
> +		if (errno == ENOENT || errno == ENOTDIR)
> +			return 0; /* directory was deleted */

Is it correct to conflate ENOENT and ENOTDIR here? In the first case the
directory was deleted, sure. But in the second case the directory might
have turned into a file due to renames, so don't we have to treat it a
bit differently?

> +		return error_errno(_("opendir('%s') failed"), path);
> +	}
> +
> +	while ((de = readdir_skip_dot_and_dotdot(dir)) != NULL) {
> +		strbuf_reset(&current);
> +		strbuf_addf(&current, "%s/%s", path, de->d_name);
> +		if (lstat(current.buf, &fs)) {
> +			if (errno == ENOENT)
> +				continue; /* file was deleted */
> +			error_errno(_("lstat('%s') failed"), current.buf);
> +			goto failed;
> +		}

We don't use fstatat(3p) in our codebase yet, also because it's
not easily portable to Windows. But I wonder whether we should use it
here to be safer against races.

> +/*
> + * Process a single inotify event and queue for publication.
> + */
> +static int process_event(const char *path,
> +			 const struct inotify_event *event,
> +			 struct fsmonitor_batch **batch,
> +			 struct string_list *cookie_list,
> +			 struct fsmonitor_daemon_state *state)
> +{
> +	const char *rel;
> +	const char *last_sep;
> +
> +	switch (fsmonitor_classify_path_absolute(state, path)) {
> +	case IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX:
> +	case IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX:
> +		/* Use just the filename of the cookie file. */
> +		last_sep = find_last_dir_sep(path);
> +		string_list_append(cookie_list,
> +				   last_sep ? last_sep + 1 : path);
> +		break;
> +	case IS_INSIDE_DOT_GIT:
> +	case IS_INSIDE_GITDIR:
> +		break;
> +	case IS_DOT_GIT:
> +	case IS_GITDIR:
> +		/*
> +		 * If .git directory is deleted or renamed away,
> +		 * we have to quit.
> +		 */
> +		if (em_dir_deleted(event->mask)) {
> +			trace_printf_key(&trace_fsmonitor,
> +					 "event: gitdir removed");
> +			state->listen_data->shutdown = SHUTDOWN_FORCE;
> +			goto done;
> +		}
> +
> +		if (em_dir_renamed(event->mask)) {
> +			trace_printf_key(&trace_fsmonitor,
> +					 "event: gitdir renamed");
> +			state->listen_data->shutdown = SHUTDOWN_FORCE;
> +			goto done;
> +		}
> +		break;
> +	case IS_WORKDIR_PATH:
> +		/* normal events in the working directory */
> +		if (trace_pass_fl(&trace_fsmonitor))
> +			log_mask_set(path, event->mask);
> +
> +		if (!*batch)
> +			*batch = fsmonitor_batch__new();
> +
> +		rel = path + state->path_worktree_watch.len + 1;
> +		fsmonitor_batch__add_path(*batch, rel);
> +
> +		if (em_dir_deleted(event->mask))
> +			break;

Curious. Don't we have to unregister the watcher in case a directory was
deleted?

> +/*
> + * Read the inotify event stream and pre-process events before further
> + * processing and eventual publishing.
> + */
> +static void handle_events(struct fsmonitor_daemon_state *state)
> +{
> +	/* See https://man7.org/linux/man-pages/man7/inotify.7.html */
> +	char buf[4096]
> +		__attribute__ ((aligned(__alignof__(struct inotify_event))));
> +
> +	struct hashmap *watches = &state->listen_data->watches;
> +	struct fsmonitor_batch *batch = NULL;
> +	struct string_list cookie_list = STRING_LIST_INIT_DUP;
> +	struct watch_entry k, *w;
> +	struct strbuf path = STRBUF_INIT;
> +	const struct inotify_event *event;
> +	int fd = state->listen_data->fd_inotify;
> +	ssize_t len;
> +	char *ptr, *p;
> +
> +	for (;;) {
> +		len = read(fd, buf, sizeof(buf));
> +		if (len == -1) {
> +			if (errno == EAGAIN || errno == EINTR)
> +				goto done;
> +			error_errno(_("reading inotify message stream failed"));
> +			state->listen_data->shutdown = SHUTDOWN_ERROR;
> +			goto done;
> +		}
> +
> +		/* nothing to read */
> +		if (len == 0)
> +			goto done;
> +
> +		/* Loop over all events in the buffer. */
> +		for (ptr = buf; ptr < buf + len;
> +		     ptr += sizeof(struct inotify_event) + event->len) {
> +
> +			event = (const struct inotify_event *)ptr;
> +
> +			if (em_ignore(event->mask))
> +				continue;
> +
> +			/* File system was unmounted or event queue overflowed */
> +			if (em_force_shutdown(event->mask)) {
> +				if (trace_pass_fl(&trace_fsmonitor))
> +					log_mask_set("Forcing shutdown", event->mask);
> +				state->listen_data->shutdown = SHUTDOWN_FORCE;
> +				goto done;
> +			}
> +
> +			k.wd = event->wd;
> +			hashmap_entry_init(&k.ent, memhash(&k.wd, sizeof(int)));
> +
> +			w = hashmap_get_entry(watches, &k, ent, NULL);
> +			if (!w) {
> +				/* Watch was removed, skip event */
> +				continue;
> +			}
> +
> +			/* directory watch was removed */
> +			if (em_remove_watch(event->mask)) {
> +				remove_watch(w, state->listen_data);
> +				continue;
> +			}

Can it happen that events arrive out-of-order so that we have some
events queued up that would touch the same path? In such a case we might
silently ignore such queued events.

> +/*
> + * Non-blocking read of the inotify events stream. The inotify fd is polled
> + * frequently to help minimize the number of queue overflows.
> + */
> +void fsm_listen__loop(struct fsmonitor_daemon_state *state)
> +{
> +	int poll_num;
> +	const int interval = 1000;
> +	time_t checked = time(NULL);

Do we need to use a monotonic clock here to ensure that there cannot be
any backwards jumps in time, e.g. when switching from summer to winter
time?

> +	struct pollfd fds[1];
> +
> +	fds[0].fd = state->listen_data->fd_inotify;
> +	fds[0].events = POLLIN;
> +
> +	/*
> +	 * Our fs event listener is now running, so it's safe to start
> +	 * serving client requests.
> +	 */
> +	ipc_server_start_async(state->ipc_server_data);
> +
> +	for (;;) {
> +		switch (state->listen_data->shutdown) {

Do we have to synchronize access to `state->listen_data->shutdown`? As
far as I can see it's being set by the fs event listener.

> +		case SHUTDOWN_CONTINUE:
> +			poll_num = poll(fds, 1, 1);
> +			if (poll_num == -1) {
> +				if (errno == EINTR)
> +					continue;
> +				error_errno(_("polling inotify message stream failed"));
> +				state->listen_data->shutdown = SHUTDOWN_ERROR;
> +				continue;
> +			}
> +
> +			if ((time(NULL) - checked) >= interval) {

Is it intended that the polling timeout is 1000 seconds, or ~16 minutes?
If so, it feels like something that might warrant a comment.

> diff --git a/compat/fsmonitor/fsm-path-utils-linux.c b/compat/fsmonitor/fsm-path-utils-linux.c
> new file mode 100644
> index 0000000000..fc4acbc20d
> --- /dev/null
> +++ b/compat/fsmonitor/fsm-path-utils-linux.c
> @@ -0,0 +1,223 @@
> +#include "git-compat-util.h"
> +#include "fsmonitor-ll.h"
> +#include "fsmonitor-path-utils.h"
> +#include "gettext.h"
> +#include "trace.h"
> +
> +#include <errno.h>
> +#include <stdio.h>
> +#include <string.h>

These includes shouldn't be required, as they are already included via
"git-compat-util.h".

[snip]
> +/*
> + * Find the mount point for a given path by reading /proc/mounts.
> + * Returns the filesystem type for the longest matching mount point.
> + */
> +static char *find_mount(const char *path, struct statfs *fs)
> +{
> +	FILE *fp;
> +	struct strbuf line = STRBUF_INIT;
> +	struct strbuf match = STRBUF_INIT;
> +	struct strbuf fstype = STRBUF_INIT;
> +	char *result = NULL;
> +	struct statfs path_fs;
> +
> +	if (statfs(path, &path_fs) < 0)
> +		return NULL;
> +
> +	fp = fopen("/proc/mounts", "r");
> +	if (!fp)
> +		return NULL;

In which cases do we need to have this fallback for statfs? This syscall
exists in Linux since the 90s, so shouldn't we be able to assume that we
can use it? Or are there specific error cases that we need to worry
about here?

> diff --git a/compat/fsmonitor/fsm-settings-linux.c b/compat/fsmonitor/fsm-settings-linux.c
> new file mode 100644
> index 0000000000..23e7442d0c
> --- /dev/null
> +++ b/compat/fsmonitor/fsm-settings-linux.c

This file is again an almost exact copy of what we have in
"fsm-settings-darwin.c", and as far as I can see there isn't even
anything specific to either of the systems here. So we should probably
deduplicate the logic.

> diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
> index 409cd0cd12..d2f1f1097e 100755
> --- a/t/t7527-builtin-fsmonitor.sh
> +++ b/t/t7527-builtin-fsmonitor.sh
> @@ -520,6 +520,28 @@ test_expect_success 'directory changes to a file' '
>  	grep "^event: dir1$" .git/trace
>  '
>  
> +test_expect_success 'rapid nested directory creation' '
> +	test_when_finished "git fsmonitor--daemon stop; rm -rf rapid" &&
> +
> +	start_daemon --tf "$PWD/.git/trace" &&
> +
> +	# Rapidly create nested directories to exercise race conditions
> +	# where directory watches may be added concurrently during
> +	# event processing and recursive scanning.
> +	for i in $(test_seq 1 20)
> +	do
> +		mkdir -p "rapid/nested/dir$i/subdir/deep" || return 1
> +	done &&
> +
> +	# Give the daemon time to process all events
> +	sleep 1 &&
> +
> +	test-tool fsmonitor-client query --token 0 &&
> +
> +	# Verify daemon is still running (did not crash)
> +	git fsmonitor--daemon status
> +'

It's a bit unclear why specifically this test was added. Does it catch
an edge case that you have discovered? Might make sense to also add it
in a preparatory commit so that we can get a bit of context.
