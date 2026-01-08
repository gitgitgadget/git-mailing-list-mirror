Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F92225779
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 01:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767837546; cv=none; b=laFmfZe8q14MxdQOCy0oFjla/btJd6SaOd/adLtf1h7UGHlPcGTeDV0EhkIeYK4NKhVff3QMDgcdwnp0sED1Aal2MMonLxeekk3BnCbuZfWUcA4ECysKl44eiFz6HL4yX29iCBniY74Lv9LBoqhi2DAbiNMtG+FCNzVJc2uVklg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767837546; c=relaxed/simple;
	bh=77qRtaceiYPUZdSmDHfjIU8S14PS+Xoxw0YrdfBt93E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OT5dCcGr/j+wPYCbCrn1B4Tkns7r49OHngSRMJpM5LTQgAyKzAwiDByYM8wHfachDC3oe12YrItQbp7FUk/5Hio2qeP11s+8Bk/ZYz9fsZCA1xK7lH0zwFwFDt82S/6amARewGicEKXe5nNiuD7jwuBSHYZC0Ub4iUWIZcylVqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ICZF+fhh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eQcpKkiT; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ICZF+fhh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eQcpKkiT"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 8B07CEC010E;
	Wed,  7 Jan 2026 20:59:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 07 Jan 2026 20:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767837542; x=1767923942; bh=xULW28qp0C
	e5K8FzCXKYn3tzJCZDDOTzONGo4t129VI=; b=ICZF+fhhG+mrYP9R/JuwkYEgDW
	lW7HHaeU36VVCswkYwTqGW3u2/vtb88wRDAh15jNVkCruzN1deynxUlFALcRd73Q
	B86Y/bxxFGFSexzbNBlflNooYfbiWdzcdACf3v+Fq+i4/Bn65HiKll1idETFdaDS
	F+AK8BoZeZYJA1iWiemE7zQLiTUNvuWvxJ895JEi6ruo2ELz7qYxGGofpgV2Es71
	5S/abmMl3xF5aoDPq0SBGigoP8EurSxBvJp07AQQqKlJCyNq6k3YBdB5f1EOnBhZ
	R0XBGba2t6qb5/S92fvpyJgLsZKCvfkWm6Fh1YCxDSgmzVSl6qWFrA0ED08w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767837542; x=1767923942; bh=xULW28qp0Ce5K8FzCXKYn3tzJCZDDOTzONG
	o4t129VI=; b=eQcpKkiTP7Y9ERbnjSt7wp8G+aLrsF5J4QRBy3/vNXKh4505wNR
	+Pdo9UITqE2gV4SxKl9OiLtq6KTaSn/X+cLK6D1L+884S3GbA8AJVv7no2FkH3b/
	aG9kNrahTIbkVnL/T1jTQ0tviie0Xg30vtGmPC33P5vFN/EaNxWq5g5uy7s5YqPq
	RggYI0nnJ8EiCRQkj2l0tD3N0qXb5xKdHpvfLb8U/cOGeIoZGwjQZvYrHHrmTQ9D
	Fl+1dkUfo5rYI8ItsMOyTCYsSUc/kAd+K5ZDxxoCX5eJiJ14OVMeTGx24CR1Zp3O
	CW7EZStgFkIYmaA6c4Hl8w1yEO82ayzxzOA==
X-ME-Sender: <xms:Zg9faSTG7tGn24mi36PrqF7T7K2qIee3m0iLbj7_SWjQ-DPgphjxlw>
    <xme:Zg9faUWcqkEbIfC-bw65N10luzor6BbY0GcBinqZcP7HCFSEnZUpqo--mGTrXzteW
    W-l3yJ3rzPP1AOETsIs1pCOxefKz5wWiUnQzcmHmW2I63c5dlMWXw>
X-ME-Received: <xmr:Zg9faUTATJeDxSxoQ5SC0ZQVWBx1d7_yJW0U6hFFeVWL6ZCHMcK-s65WNRAIk2AsEtHQGFY-pWap8WDkB3kW2nXEaHKgJvz6_2ZA_B8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdegieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehtsghovghgihesfigvsgdruggvpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehprghulhhordgtrghsrg
    hrvghtthhosehshhhophhifhihrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopehptggrshgrrhgvthhtohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Zg9faU32j8cKsG372YBOaHWLvWB076eCetPEdcA-wVD832GFRHpzTQ>
    <xmx:Zg9facfkroCqgPjWM05KghcopFf7ZMl2E7RPJGCRQ4DNDi0eDrRi2A>
    <xmx:Zg9faUOqeD576Ntx_CRT3P5L1SWbk5veoLoLNaw3XW1fw-hX6WiSDQ>
    <xmx:Zg9faYUZ3aULLgQHH2GdGNoQNeiJtkZopDFA4w1_DHOe7gCaqtbKbg>
    <xmx:Zg9faRLSAHwZm5EOCFF1zhkyzaiFKn5BjSt-w-3uHAKASDRTl9QYGd5J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 20:59:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Paulo Casaretto via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Torsten =?utf-8?Q?B=C3=B6gershausen?=
 <tboegi@web.de>,  Jeff King
 <peff@peff.net>,  "Paulo Casaretto (Shopify)"
 <paulo.casaretto@shopify.com>,  Patrick Steinhardt <ps@pks.im>,  Paulo
 Casaretto <pcasaretto@gmail.com>
Subject: Re: [PATCH v4] lockfile: add PID file for debugging stale locks
In-Reply-To: <pull.2011.v4.git.1767804355831.gitgitgadget@gmail.com> (Paulo
	Casaretto via GitGitGadget's message of "Wed, 07 Jan 2026 16:45:55
	+0000")
References: <pull.2011.v3.git.1766579053136.gitgitgadget@gmail.com>
	<pull.2011.v4.git.1767804355831.gitgitgadget@gmail.com>
Date: Thu, 08 Jan 2026 10:59:00 +0900
Message-ID: <xmqqbjj4hnkr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Paulo Casaretto via GitGitGadget" <gitgitgadget@gmail.com> writes:

> For a lock file "foo.lock", the PID file is named "foo~pid.lock". The
> tilde character is forbidden in refnames and allowed in Windows
> filenames, which guarantees no collision with the refs namespace
> (e.g., refs "foo" and "foo~pid" cannot both exist). The file contains
> a single line in the format "pid <value>" followed by a newline.

For a lockfile used for manipulating refs, that would be good, but
it would be more assuring to enumerate what other things do we use
lockfiles for, especially things whose filenames are under end-user
control (e.g., $GIT_DIR/index using index.lock and index~pid.lock
would probably be OK as the "index" part is unlikely to be renamed.
Is the ref-files the only thing that needs to address names
controlled by the end-user?).

> The PID file is created when a lock is acquired (if enabled), and
> automatically cleaned up when the lock is released (via commit or
> rollback). The file is registered as a tempfile so it gets cleaned up
> by signal and atexit handlers if the process terminates abnormally.
>
> When a lock conflict occurs, the code checks for an existing PID file
> and, if found, uses kill(pid, 0) to determine if the process is still
> running. This allows providing context-aware error messages:
>
>   Lock is held by process 12345. Wait for it to finish, or remove
>   the lock file to continue.
>
> Or for a stale lock:
>
>   Lock was held by process 12345, which is no longer running.
>   Remove the stale lock file to continue.

Two additional thoughts.

 * 12345 may be running as your kill(12345,0) did not fail, but that
   may be a process different from the one that held the lock and
   then died without cleaning up.

 * 12345 may be running and may have the lock.  You may decide to
   break the lock and take the risk of breaking your repository, or
   you may wait until that process finishes what it is doing.  If
   you go the former route, however, would it make more sense to
   kill the process so that it does not any harm interfering with
   your new attempt?  "remove the lock file to continue" sounds like
   a fairly irresponsible suggestion.  Not that "kill the process,
   remove the lock file and then do whatever you wanted to do" is
   any better.

> The feature is controlled via core.lockfilePid configuration (boolean).
> Defaults to false. When enabled, PID files are created for all lock
> operations.
>
> Existing PID files are always read when displaying lock errors,
> regardless of the core.lockfilePid setting. This ensures helpful
> diagnostics even when the feature was previously enabled and later
> disabled.

This makes it even more easily triggerable to notice a running
process that happens to be reusing a process ID an old process used
to have (i.e. the first "thought" above---the phrasing of the
message needs to be carefully thought out).

>     Changes in v4:
>     
>      * Simplified core.lockfilePid from per-component configuration to a
>        simple boolean (true/false), as suggested by Jeff and Patrick. The
>        per-subsystem granularity added complexity without a clear use case -
>        if someone wants PID files for debugging, they likely want them
>        everywhere.

Very nice.

>      * Removed the enum lockfile_pid_component and all LOCKFILE_PID_*
>        constants
>      * Removed the component parameter from hold_lock_file_for_update*()
>        functions, restoring their original signatures
>      * Simplified config parsing to use git_config_bool() instead of the
>        fsync-style component parser
>      * Fixed error handling in create_lock_pid_file() to unlink the file on
>        write failure, as noted by Junio
>      * Clarified documentation to describe the file format directly ("pid "
>        followed by a newline) rather than referencing "Git object headers"
>      * Updated tests and documentation to reflect the boolean config

Nicely enumerated changes.

>  Documentation/config/core.adoc |  11 +++
>  builtin/commit.c               |   3 +-
>  builtin/gc.c                   |   6 +-
>  compat/mingw.c                 |  10 ++
>  environment.c                  |   6 ++
>  lockfile.c                     | 170 ++++++++++++++++++++++++++++++---
>  lockfile.h                     |  43 ++++++---
>  t/meson.build                  |   1 +
>  t/t0031-lockfile-pid.sh        | 105 ++++++++++++++++++++
>  9 files changed, 320 insertions(+), 35 deletions(-)
>  create mode 100755 t/t0031-lockfile-pid.sh
>
> diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
> index 01202da7cd..5c4bc9206f 100644
> --- a/Documentation/config/core.adoc
> +++ b/Documentation/config/core.adoc
> @@ -348,6 +348,17 @@ confusion unless you know what you are doing (e.g. you are creating a
>  read-only snapshot of the same index to a location different from the
>  repository's usual working tree).
>  
> +core.lockfilePid::
> +	If true, Git will create a PID file alongside lock files. When a
> +	lock acquisition fails and a PID file exists, Git can provide

Is it "Git can provide", or "Git provides"?  I thought that I read
in the proposed log message that this configuration variable does
not control what happens when we see the pid file?

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 0243f17d53..4378256fa5 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -539,8 +539,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
>  
>  	path = repo_git_path(the_repository, "next-index-%"PRIuMAX,
>  			     (uintmax_t) getpid());
> -	hold_lock_file_for_update(&false_lock, path,
> -				  LOCK_DIE_ON_ERROR);
> +	hold_lock_file_for_update(&false_lock, path, LOCK_DIE_ON_ERROR);

Is this change necessary to achieve the goal of your topic?

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 92c6e7b954..1dcc8dd550 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -748,8 +748,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
>  		xsnprintf(my_host, sizeof(my_host), "unknown");
>  
>  	pidfile_path = repo_git_path(the_repository, "gc.pid");
> -	fd = hold_lock_file_for_update(&lock, pidfile_path,
> -				       LOCK_DIE_ON_ERROR);
> +	fd = hold_lock_file_for_update(&lock, pidfile_path, LOCK_DIE_ON_ERROR);

Ditto.

> @@ -1016,8 +1015,7 @@ int cmd_gc(int argc,
>  
>  	if (daemonized) {
>  		char *path = repo_git_path(the_repository, "gc.log");
> -		hold_lock_file_for_update(&log_lock, path,
> -					  LOCK_DIE_ON_ERROR);
> +		hold_lock_file_for_update(&log_lock, path, LOCK_DIE_ON_ERROR);

Ditto.

> diff --git a/compat/mingw.c b/compat/mingw.c
> index 939f938fe2..146b2585ce 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1972,6 +1972,16 @@ int mingw_kill(pid_t pid, int sig)
>  			CloseHandle(h);
>  			return 0;
>  		}
> +		/*
> +		 * OpenProcess returns ERROR_INVALID_PARAMETER for
> +		 * non-existent PIDs. Map this to ESRCH for POSIX
> +		 * compatibility with kill(pid, 0).
> +		 */
> +		if (GetLastError() == ERROR_INVALID_PARAMETER)
> +			errno = ESRCH;
> +		else
> +			errno = err_win_to_posix(GetLastError());
> +		return -1;
>  	}
>  
>  	errno = EINVAL;
> diff --git a/environment.c b/environment.c
> index a770b5921d..4adcce8606 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -21,6 +21,7 @@
>  #include "gettext.h"
>  #include "git-zlib.h"
>  #include "ident.h"
> +#include "lockfile.h"
>  #include "mailmap.h"
>  #include "object-name.h"
>  #include "repository.h"
> @@ -532,6 +533,11 @@ static int git_default_core_config(const char *var, const char *value,
>  		return 0;
>  	}
>  
> +	if (!strcmp(var, "core.lockfilepid")) {
> +		lockfile_pid_enabled = git_config_bool(var, value);
> +		return 0;
> +	}
> +
>  	if (!strcmp(var, "core.createobject")) {
>  		if (!value)
>  			return config_error_nonbool(var);

OK.  Presumably lockfile.h declares the variable.

> diff --git a/lockfile.c b/lockfile.c
> index 1d5ed01682..ac7eb86541 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -71,19 +74,119 @@ static void resolve_symlink(struct strbuf *path)
> ...
> + * Naming: For "foo.lock", the PID file is "foo~pid.lock". The tilde is
> + * forbidden in refnames and allowed in Windows filenames, guaranteeing
> + * no collision with the refs namespace.

A comment on other uses of lockfiles is needed here.

> +/*
> + * Path generation helpers.
> + * Given base path "foo", generate:
> + *   - lock path: "foo.lock"
> + *   - pid path:  "foo-pid.lock"
> + */

Is the caller responsible for supplying an empty "out" buf?  I am
wondering if it would make it easier to use if these functions
cleared the supplied strbuf as the first thing they do.

You could imagine a calling sequence

	strbuf_reset(&outbuf);
	strbuf_add(&outbuf, "seed");
	get_lock_path(&outbuf, "index");
	... use outbuf.buf ...

	strbuf_reset(&outbuf);
	strbuf_add(&outbuf, "seed");
	get_pid_path(&outbuf, "index");
	... use outbuf.buf ...


to give some prefix to the filenames used for locks, and making
these functions clear the strbuf upfront would not allow such a
calling sequence, but such a caller can just feed "seedindex" to the
API, so it does not feel like a huge loss.

Of course, we could go to the other extreme, and make it the
responsibility of the caller to stuff "path" to the strbuf before
calling these functions, i.e.,

	strbuf_reset(&outbuf);
	strbuf_add(&outbuf, "index");
	get_lock_path(&outbuf);

I am not sure if it is a good direction to go, though.  Certainly
the functions need to be renamed to "add_lock_suffix()" and
"add_pid_suffix" respectively, if we go that route.

> +static void get_lock_path(struct strbuf *out, const char *path)
> +{
> +	strbuf_addstr(out, path);
> +	strbuf_addstr(out, LOCK_SUFFIX);
> +}
> +
> +static void get_pid_path(struct strbuf *out, const char *path)
> +{
> +	strbuf_addstr(out, path);
> +	strbuf_addstr(out, LOCK_PID_INFIX);
> +	strbuf_addstr(out, LOCK_SUFFIX);
> +}

> +static struct tempfile *create_lock_pid_file(const char *pid_path, int mode)
> +{
> +	struct strbuf content = STRBUF_INIT;
> +	struct tempfile *pid_tempfile = NULL;
> +	int fd = -1;
> +
> +	if (!lockfile_pid_enabled)
> +		goto out;
> +
> +	fd = open(pid_path, O_WRONLY | O_CREAT | O_EXCL, mode);
> +	if (fd < 0)
> +		goto out;
> +
> +	strbuf_addf(&content, "pid %" PRIuMAX "\n", (uintmax_t)getpid());
> +	if (write_in_full(fd, content.buf, content.len) < 0) {
> +		warning_errno(_("could not write lock pid file '%s'"), pid_path);
> +		close(fd);
> +		fd = -1;

You can leave the above two lines out, as jumping to "out" would
take care of closing the file descriptor.

> +		unlink(pid_path);
> +		goto out;
> +	}
> +
> +	close(fd);
> +	fd = -1;
> +	pid_tempfile = register_tempfile(pid_path);
> +
> +out:
> +	if (fd >= 0)
> +		close(fd);
> +	strbuf_release(&content);
> +	return pid_tempfile;
> +}

> +static int read_lock_pid(const char *pid_path, uintmax_t *pid_out)
> +{
> +	struct strbuf content = STRBUF_INIT;
> +	const char *val;
> +	int ret = -1;
> +
> +	if (strbuf_read_file(&content, pid_path, LOCK_PID_MAXLEN) <= 0)
> +		goto out;
> +
> +	strbuf_rtrim(&content);
> +
> +	if (skip_prefix(content.buf, "pid ", &val)) {
> +		char *endptr;
> +		*pid_out = strtoumax(val, &endptr, 10);
> +		if (*pid_out > 0 && !*endptr)
> +			ret = 0;

Zero is a valid process ID; comparing endptr with the val to ensure
that we did read _some_ digits would be a more robust test.

If you drop strbuf_rtrim() above, then you can even check if endptr
points at a '\n' byte to validate the whole line while ensuring that
you read the decimal number correctly.

>  static int lock_file(struct lock_file *lk, const char *path, int flags,
>  		     int mode)
>  {
> -	struct strbuf filename = STRBUF_INIT;
> +	struct strbuf base_path = STRBUF_INIT;
> +	struct strbuf lock_path = STRBUF_INIT;
> +	struct strbuf pid_path = STRBUF_INIT;
>  
> -	strbuf_addstr(&filename, path);
> +	strbuf_addstr(&base_path, path);
>  	if (!(flags & LOCK_NO_DEREF))
> -		resolve_symlink(&filename);
> +		resolve_symlink(&base_path);
> +
> +	get_lock_path(&lock_path, base_path.buf);
> +	get_pid_path(&pid_path, base_path.buf);

Looking at this place alone, add_lock/pid_suffix() I alluded to
earlier may not be _too_ bad.  There may be other callers that makes
the "caller prepares the filename in the strbuf and calls add suffix
helpers" pattern unwieldy.

> @@ -151,16 +254,47 @@ static int lock_file_timeout(struct lock_file *lk, const char *path,
>  void unable_to_lock_message(const char *path, int err, struct strbuf *buf)
>  {
>  	if (err == EEXIST) {
> -		strbuf_addf(buf, _("Unable to create '%s.lock': %s.\n\n"
> -		    "Another git process seems to be running in this repository, e.g.\n"
> -		    "an editor opened by 'git commit'. Please make sure all processes\n"
> -		    "are terminated then try again. If it still fails, a git process\n"
> -		    "may have crashed in this repository earlier:\n"
> -		    "remove the file manually to continue."),
> -			    absolute_path(path), strerror(err));
> -	} else
> +		const char *abs_path = absolute_path(path);
> +		struct strbuf lock_path = STRBUF_INIT;
> +		struct strbuf pid_path = STRBUF_INIT;
> +		uintmax_t pid;
> +		int pid_status = 0; /* 0 = unknown, 1 = running, -1 = stale */
> +
> +		get_lock_path(&lock_path, abs_path);
> +		get_pid_path(&pid_path, abs_path);
> +
> +		strbuf_addf(buf, _("Unable to create '%s': %s.\n\n"),
> +			    lock_path.buf, strerror(err));

I wonder if code snippet from here ....

> +		/*
> +		 * Try to read PID file unconditionally - it may exist if
> +		 * core.lockfilePid was enabled.
> +		 */
> +		if (!read_lock_pid(pid_path.buf, &pid)) {
> +			if (kill((pid_t)pid, 0) == 0 || errno == EPERM)
> +				pid_status = 1;  /* running (or no permission to signal) */
> +			else if (errno == ESRCH)
> +				pid_status = -1; /* no such process - stale lock */
> +		}
> +
> +		if (pid_status == 1)
> +			strbuf_addf(buf, _("Lock is held by process %" PRIuMAX ". "
> +					   "Wait for it to finish, or remove the lock file to continue"),
> +				    pid);
> +		else if (pid_status == -1)
> +			strbuf_addf(buf, _("Lock was held by process %" PRIuMAX ", "
> +					   "which is no longer running. Remove the stale lock file to continue"),
> +				    pid);
> +		else
> +			strbuf_addstr(buf, _("Another git process seems to be running in this repository. "
> +					     "Wait for it to finish, or remove the lock file to continue"));

... to here should be in a separate helper function.  It would make
the control flow easier to follow.

> +		strbuf_release(&lock_path);
> +		strbuf_release(&pid_path);
> +	} else {
>  		strbuf_addf(buf, _("Unable to create '%s.lock': %s"),
>  			    absolute_path(path), strerror(err));
> +	}
>  }
>  
>  NORETURN void unable_to_lock_die(const char *path, int err)
> @@ -207,6 +341,8 @@ int commit_lock_file(struct lock_file *lk)
>  {
>  	char *result_path = get_locked_file_path(lk);
>  
> +	delete_tempfile(&lk->pid_tempfile);
> +
>  	if (commit_lock_file_to(lk, result_path)) {
>  		int save_errno = errno;
>  		free(result_path);
> @@ -216,3 +352,9 @@ int commit_lock_file(struct lock_file *lk)
>  	free(result_path);
>  	return 0;
>  }
> +
> +int rollback_lock_file(struct lock_file *lk)
> +{
> +	delete_tempfile(&lk->pid_tempfile);
> +	return delete_tempfile(&lk->tempfile);
> +}
> diff --git a/lockfile.h b/lockfile.h
> index 1bb9926497..e7233f28de 100644
> --- a/lockfile.h
> +++ b/lockfile.h
> @@ -119,6 +119,7 @@
>  
>  struct lock_file {
>  	struct tempfile *tempfile;
> +	struct tempfile *pid_tempfile;
>  };
>  
>  #define LOCK_INIT { 0 }
> @@ -127,6 +128,22 @@ struct lock_file {
>  #define LOCK_SUFFIX ".lock"
>  #define LOCK_SUFFIX_LEN 5
>  
> +/*
> + * PID file naming: for a lock file "foo.lock", the PID file is "foo~pid.lock".
> + * The tilde is forbidden in refnames and allowed in Windows filenames, avoiding
> + * namespace collisions (e.g., refs "foo" and "foo~pid" cannot both exist).
> + */
> +#define LOCK_PID_INFIX "~pid"
> +#define LOCK_PID_INFIX_LEN 4
> +
> +/* Maximum length for PID file content */
> +#define LOCK_PID_MAXLEN 32
> +
> +/*
> + * Whether to create PID files alongside lock files.
> + * Configured via core.lockfilePid (boolean).
> + */
> +extern int lockfile_pid_enabled;
>  
>  /*
>   * Flags
> @@ -169,12 +186,12 @@ struct lock_file {
>   * handling, and mode are described above.
>   */
>  int hold_lock_file_for_update_timeout_mode(
> -		struct lock_file *lk, const char *path,
> -		int flags, long timeout_ms, int mode);
> +	struct lock_file *lk, const char *path,
> +	int flags, long timeout_ms, int mode);
>  
>  static inline int hold_lock_file_for_update_timeout(
> -		struct lock_file *lk, const char *path,
> -		int flags, long timeout_ms)
> +	struct lock_file *lk, const char *path,
> +	int flags, long timeout_ms)
>  {
>  	return hold_lock_file_for_update_timeout_mode(lk, path, flags,
>  						      timeout_ms, 0666);
> @@ -186,15 +203,14 @@ static inline int hold_lock_file_for_update_timeout(
>   * argument and error handling are described above.
>   */
>  static inline int hold_lock_file_for_update(
> -		struct lock_file *lk, const char *path,
> -		int flags)
> +	struct lock_file *lk, const char *path, int flags)
>  {
>  	return hold_lock_file_for_update_timeout(lk, path, flags, 0);
>  }
>  
>  static inline int hold_lock_file_for_update_mode(
> -		struct lock_file *lk, const char *path,
> -		int flags, int mode)
> +	struct lock_file *lk, const char *path,
> +	int flags, int mode)
>  {
>  	return hold_lock_file_for_update_timeout_mode(lk, path, flags, 0, mode);
>  }
> @@ -319,13 +335,10 @@ static inline int commit_lock_file_to(struct lock_file *lk, const char *path)
>  
>  /*
>   * Roll back `lk`: close the file descriptor and/or file pointer and
> - * remove the lockfile. It is a NOOP to call `rollback_lock_file()`
> - * for a `lock_file` object that has already been committed or rolled
> - * back. No error will be returned in this case.
> + * remove the lockfile and any associated PID file. It is a NOOP to
> + * call `rollback_lock_file()` for a `lock_file` object that has already
> + * been committed or rolled back. No error will be returned in this case.
>   */
> -static inline int rollback_lock_file(struct lock_file *lk)
> -{
> -	return delete_tempfile(&lk->tempfile);
> -}
> +int rollback_lock_file(struct lock_file *lk);
>  
>  #endif /* LOCKFILE_H */
> diff --git a/t/meson.build b/t/meson.build
> index 459c52a489..2aec2c011e 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -98,6 +98,7 @@ integration_tests = [
>    't0028-working-tree-encoding.sh',
>    't0029-core-unsetenvvars.sh',
>    't0030-stripspace.sh',
> +  't0031-lockfile-pid.sh',
>    't0033-safe-directory.sh',
>    't0034-root-safe-directory.sh',
>    't0035-safe-bare-repository.sh',
> diff --git a/t/t0031-lockfile-pid.sh b/t/t0031-lockfile-pid.sh
> new file mode 100755
> index 0000000000..44f3ba1f25
> --- /dev/null
> +++ b/t/t0031-lockfile-pid.sh
> @@ -0,0 +1,105 @@
> +#!/bin/sh
> +
> +test_description='lock file PID info tests
> +
> +Tests for PID info file alongside lock files.
> +The feature is opt-in via core.lockfilePid config setting (boolean).
> +'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'stale lock detected when PID is not running' '
> +	git init repo &&
> +	(
> +		cd repo &&
> +		touch .git/index.lock &&
> +		printf "pid 99999" >.git/index~pid.lock &&
> +		test_must_fail git -c core.lockfilePid=true add . 2>err &&
> +		test_grep "process 99999, which is no longer running" err &&
> +		test_grep "Remove the stale lock file" err
> +	)
> +'
> +
> +test_expect_success 'PID info not shown by default' '
> +	git init repo2 &&
> +	(
> +		cd repo2 &&
> +		touch .git/index.lock &&
> +		printf "pid 99999" >.git/index~pid.lock &&
> +		test_must_fail git add . 2>err &&
> +		# Should not crash, just show normal error without PID
> +		test_grep "Unable to create" err &&
> +		! test_grep "is held by process" err
> +	)
> +'
> +
> +test_expect_success 'running process detected when PID is alive' '
> +	git init repo3 &&
> +	(
> +		cd repo3 &&
> +		echo content >file &&
> +		# Get the correct PID for this platform
> +		shell_pid=$$ &&
> +		if test_have_prereq MINGW && test -f /proc/$shell_pid/winpid
> +		then
> +			# In Git for Windows, Bash uses MSYS2 PIDs but git.exe
> +			# uses Windows PIDs. Use the Windows PID.
> +			shell_pid=$(cat /proc/$shell_pid/winpid)
> +		fi &&
> +		# Create a lock and PID file with current shell PID (which is running)
> +		touch .git/index.lock &&
> +		printf "pid %d" "$shell_pid" >.git/index~pid.lock &&
> +		# Verify our PID is shown in the error message
> +		test_must_fail git -c core.lockfilePid=true add file 2>err &&
> +		test_grep "held by process $shell_pid" err
> +	)
> +'
> +
> +test_expect_success 'PID info file cleaned up on successful operation when enabled' '
> +	git init repo4 &&
> +	(
> +		cd repo4 &&
> +		echo content >file &&
> +		git -c core.lockfilePid=true add file &&
> +		# After successful add, no lock or PID files should exist
> +		test_path_is_missing .git/index.lock &&
> +		test_path_is_missing .git/index~pid.lock
> +	)
> +'
> +
> +test_expect_success 'no PID file created by default' '
> +	git init repo5 &&
> +	(
> +		cd repo5 &&
> +		echo content >file &&
> +		git add file &&
> +		# PID file should not be created when feature is disabled
> +		test_path_is_missing .git/index~pid.lock
> +	)
> +'
> +
> +test_expect_success 'core.lockfilePid=false does not create PID file' '
> +	git init repo6 &&
> +	(
> +		cd repo6 &&
> +		echo content >file &&
> +		git -c core.lockfilePid=false add file &&
> +		# PID file should not be created when feature is disabled
> +		test_path_is_missing .git/index~pid.lock
> +	)
> +'
> +
> +test_expect_success 'existing PID files are read even when feature disabled' '
> +	git init repo7 &&
> +	(
> +		cd repo7 &&
> +		touch .git/index.lock &&
> +		printf "pid 99999" >.git/index~pid.lock &&
> +		# Even with lockfilePid disabled, existing PID files are read
> +		# to help diagnose stale locks
> +		test_must_fail git add . 2>err &&
> +		test_grep "process 99999" err
> +	)
> +'
> +
> +test_done
>
> base-commit: 66ce5f8e8872f0183bb137911c52b07f1f242d13
