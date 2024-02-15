Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A284013248B
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004981; cv=none; b=rbIOGfKgbSfQENzULno/9Dx+ADtlu+1L16Udrpl7BNsPbxuXVGKI+arR96hBhEYgz4W3Vn/MjEAEM8BhOEi25tQf4IIVGvyIiGvOCQRiBNJ7D0X4v34AGWNBR4Mnc0U6rLkZv4L5AQLnDq+nl5DdqF3pwexorJlFWtBapX5QZ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004981; c=relaxed/simple;
	bh=MJJPkYmPv3UeH8B6iLAoWajl9TMfUpRizD7kR472bJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQEygHd2gGpQcFRZLTPdevDjKSM0nlu7mkuP7K5e/WXIWsr48dDOWdmhsWDq+ij9K/wa/PiEc3Nk1he0u+tFb2zS6ECD0XTmNpz8rjqVJn8Xy6KheVJl0i6jHwSyKVFjEtrtBTcj/9rBadwsfTxJi6Yy0NwXX2KMsQDC8GT6n+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PROEfJhD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BfoLSxJt; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PROEfJhD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BfoLSxJt"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 0C6883200A76;
	Thu, 15 Feb 2024 08:49:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 15 Feb 2024 08:49:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708004976; x=1708091376; bh=0hG2Ld8N8U
	MXdKcE2jq1XF2MHyVE7J/O6qYb7YbtCSQ=; b=PROEfJhDViuSmcP1SL4/VGsHNH
	HUeHonv11vHbLtrfSvEKmgxR+TUAraGq1/JRkwKvdur+t+ZhlNhfXfkmlG4qrmDN
	gFTCY0+QT3vATUyYAbullfDEtZ9HrF4tA6tc96YzrEts3ExaBWw53M3xV1ioi2VI
	q3HD9kSmcZt7wO98V241ilca20raw/cW5qtCXVVZDkSJ6vMOn6uzh4pRtU8pSHPY
	31h3Dzgf7LAZHspbyIJhz7BgW42fAhvD2Yzt+Ojl//3diuLEkn5+A2Rm4WqVghjl
	91lNUUv93eB2yZo0VppUde86vFTANUQdGBe4pzsA2tUTRDA0+OhOmLjxqQ+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708004976; x=1708091376; bh=0hG2Ld8N8UMXdKcE2jq1XF2MHyVE
	7J/O6qYb7YbtCSQ=; b=BfoLSxJtnKJlLd1HWEzbYmoADZHFO58KRoZkVrv8KPih
	/U93r7e3H6MHw9iNM+NeuK4yHuDlnTL/JhMcgtVn+wNQp3EamRDsQygLHHQwr/aB
	mnU8BcoJCZjxgP8ZOrjazia/HhqsiUEqcAwY6CxPsb7Nq6EmHXoSp7fahnpFgVGN
	awQml8w/JI+PCazeq4LuWTvO+7+Vh0FowVjij48L9thlBlQK1gzeyGgXVrojYVJr
	oXNqX6phcy3GOmYrlIzWHXF+q/kQKzn3hWkYUrPnlmlvnS3TzNX6RocPeW75lMJG
	8BesmAW0jCqwAe1S+YqBxvHXSMAIx3c4pu/VkWjfug==
X-ME-Sender: <xms:cBbOZXytSeEZ86RGzc_HSzh-R8xjDCAD3Hv-CAHpnQ9gmDCxL3ot3Q>
    <xme:cBbOZfRhgtwZaEsOXCHtz6OFk6Ydb6CcFheXQRW53A0EEA403Wd1N_pFo8IdVPN0a
    _n5s6luNa9t2jyQBg>
X-ME-Received: <xmr:cBbOZRVF1eM6AGSOoczMzYLGW3YF9pOOVaTbL3Q0WyvUoKfZrUIEDz66L8e5rZZXRpOGV_SRxM9xu2CG2bm7l-ep09Nx9DOApTbnrwu-PCda>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefgeeggfekfeeiieeiieduleeuheetgeelheeljeekjeffueeuudetvefgffetleen
    ucffohhmrghinhepmhgrnhejrdhorhhgnecuvehluhhsthgvrhfuihiivgepudenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:cBbOZRi0HsjKbh28xM6gvJNqZYV3zW-ZygsAlrpvrKaBPcrGbs1i6A>
    <xmx:cBbOZZACRN3mBY9hIES6LycEyeEmT0cup4QNRmlz7gUmiypfmEVeUA>
    <xmx:cBbOZaIT6Q3KjJKI4kY33oRJnTgrXWerPEq2Q5QOjpJCEUcbzeh_LQ>
    <xmx:cBbOZd2c4-hboLaSDY3jZkSB8gmL6C2ZNqd_AVSvatmGpgQ3XIlO9w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 08:49:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a2ab7651 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 13:45:42 +0000 (UTC)
Date: Thu, 15 Feb 2024 14:49:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Eric Sunshine [ ]" <sunshine@sunshineco.com>,
	=?iso-8859-1?B?xnZhciBBcm5mavZy8CBCamFybWFzb24gWyBd?= <avarab@gmail.com>,
	"Glen Choo [ ]" <chooglen@google.com>,
	"Johannes Schindelin [ ]" <Johannes.Schindelin@gmx.de>,
	"Taylor Blau [ ]" <me@ttaylorr.com>, marzi <m.ispare63@gmail.com>,
	Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH 3/7] fsmonitor: implement filesystem change listener for
 Linux
Message-ID: <Zc4Wbc1EIbVRCkad@tanuki>
References: <pull.1667.git.git.1707992978.gitgitgadget@gmail.com>
 <5fad429b4d53dee4eb509f0db98ef860762436fc.1707992978.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8TCCcnyCXBQBR8AO"
Content-Disposition: inline
In-Reply-To: <5fad429b4d53dee4eb509f0db98ef860762436fc.1707992978.git.gitgitgadget@gmail.com>


--8TCCcnyCXBQBR8AO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 10:29:34AM +0000, Eric DeCosta via GitGitGadget wro=
te:
> From: Eric DeCosta <edecosta@mathworks.com>
>=20
> Implement a filesystem change listener for Linux based on the inotify API:
> https://man7.org/linux/man-pages/man7/inotify.7.html
>=20
> inotify requires registering a watch on every directory in the worktree a=
nd
> special handling of moves/renames.

I assume that fsmonitor is especially important in the context of repos
with large trees, and to the best of my knowledge inotify(7) does not
scale well when installing many watches. I thus have to wonder whether
fanotify(7) would be a better match to implement this nowadays, and what
the considerations were to pick one over the other.

> Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
> ---
>  compat/fsmonitor/fsm-listen-linux.c | 676 ++++++++++++++++++++++++++++
>  1 file changed, 676 insertions(+)
>  create mode 100644 compat/fsmonitor/fsm-listen-linux.c
>=20
> diff --git a/compat/fsmonitor/fsm-listen-linux.c b/compat/fsmonitor/fsm-l=
isten-linux.c
> new file mode 100644
> index 00000000000..e8548e4e009
> --- /dev/null
> +++ b/compat/fsmonitor/fsm-listen-linux.c
> @@ -0,0 +1,676 @@
> +#include "cache.h"
> +#include "fsmonitor.h"
> +#include "fsm-listen.h"
> +#include "fsmonitor--daemon.h"
> +#include <dirent.h>
> +#include <fcntl.h>
> +#include <sys/inotify.h>
> +#include <sys/stat.h>
> +
> +/*
> + * Safe value to bitwise OR with rest of mask for
> + * kernels that do not support IN_MASK_CREATE
> + */
> +#ifndef IN_MASK_CREATE
> +#define IN_MASK_CREATE 0x00000000
> +#endif
> +
> +enum shutdown_reason {
> +	SHUTDOWN_CONTINUE =3D 0,
> +	SHUTDOWN_STOP,
> +	SHUTDOWN_ERROR,
> +	SHUTDOWN_FORCE
> +};
> +
> +struct watch_entry {
> +	struct hashmap_entry ent;
> +	int wd;
> +	uint32_t cookie;
> +	const char *dir;
> +};
> +
> +struct rename_entry {
> +	struct hashmap_entry ent;
> +	time_t whence;
> +	uint32_t cookie;
> +	const char *dir;
> +};
> +
> +struct fsm_listen_data {
> +	int fd_inotify;
> +	enum shutdown_reason shutdown;
> +	struct hashmap watches;
> +	struct hashmap renames;
> +	struct hashmap revwatches;
> +};
> +
> +static int watch_entry_cmp(const void *cmp_data,
> +			  const struct hashmap_entry *eptr,
> +			  const struct hashmap_entry *entry_or_key,
> +			  const void *keydata)
> +{
> +	const struct watch_entry *e1, *e2;
> +
> +	e1 =3D container_of(eptr, const struct watch_entry, ent);
> +	e2 =3D container_of(eptr, const struct watch_entry, ent);
> +	return e1->wd !=3D e2->wd;
> +}
> +
> +static int revwatches_entry_cmp(const void *cmp_data,
> +			  const struct hashmap_entry *eptr,
> +			  const struct hashmap_entry *entry_or_key,
> +			  const void *keydata)
> +{
> +	const struct watch_entry *e1, *e2;
> +
> +	e1 =3D container_of(eptr, const struct watch_entry, ent);
> +	e2 =3D container_of(eptr, const struct watch_entry, ent);
> +	return strcmp(e1->dir, e2->dir);
> +}
> +
> +static int rename_entry_cmp(const void *cmp_data,
> +			  const struct hashmap_entry *eptr,
> +			  const struct hashmap_entry *entry_or_key,
> +			  const void *keydata)
> +{
> +	const struct rename_entry *e1, *e2;
> +
> +	e1 =3D container_of(eptr, const struct rename_entry, ent);
> +	e2 =3D container_of(eptr, const struct rename_entry, ent);
> +	return e1->cookie !=3D e2->cookie;
> +}
> +
> +/*
> + * Register an inotify watch, add watch descriptor to path mapping
> + * and the reverse mapping.
> + */
> +static int add_watch(const char *path, struct fsm_listen_data *data)
> +{
> +	const char *interned =3D strintern(path);
> +	struct watch_entry *w1, *w2;
> +
> +	/* add the inotify watch, don't allow watches to be modified */
> +	int wd =3D inotify_add_watch(data->fd_inotify, interned,
> +				(IN_ALL_EVENTS | IN_ONLYDIR | IN_MASK_CREATE)
> +				^ IN_ACCESS ^ IN_CLOSE ^ IN_OPEN);
> +	if (wd < 0)
> +		return error_errno("inotify_add_watch('%s') failed", interned);
> +
> +	/* add watch descriptor -> directory mapping */
> +	CALLOC_ARRAY(w1, 1);
> +	w1->wd =3D wd;
> +	w1->dir =3D interned;
> +	hashmap_entry_init(&w1->ent, memhash(&w1->wd, sizeof(int)));
> +	hashmap_add(&data->watches, &w1->ent);
> +
> +	/* add directory -> watch descriptor mapping */
> +	CALLOC_ARRAY(w2, 1);
> +	w2->wd =3D wd;
> +	w2->dir =3D interned;
> +	hashmap_entry_init(&w2->ent, memhash(w2->dir, strlen(w2->dir)));
> +	hashmap_add(&data->revwatches, &w2->ent);
> +
> +	return 0;
> +}
> +
> +/*
> + * Remove the inotify watch, the watch descriptor to path mapping
> + * and the reverse mapping.
> + */
> +static void remove_watch(struct watch_entry *w,
> +	struct fsm_listen_data *data)
> +{
> +	struct watch_entry k1, k2, *w1, *w2;
> +
> +	/* remove watch, ignore error if kernel already did it */
> +	if (inotify_rm_watch(data->fd_inotify, w->wd) && errno !=3D EINVAL)
> +		error_errno("inotify_rm_watch() failed");
> +
> +	hashmap_entry_init(&k1.ent, memhash(&w->wd, sizeof(int)));
> +	w1 =3D hashmap_remove_entry(&data->watches, &k1, ent, NULL);
> +	if (!w1)
> +		BUG("Double remove of watch for '%s'", w->dir);
> +
> +	if (w1->cookie)
> +		BUG("Removing watch for '%s' which has a pending rename", w1->dir);
> +
> +	hashmap_entry_init(&k2.ent, memhash(w->dir, strlen(w->dir)));
> +	w2 =3D hashmap_remove_entry(&data->revwatches, &k2, ent, NULL);
> +	if (!w2)
> +		BUG("Double remove of reverse watch for '%s'", w->dir);
> +
> +	/* w1->dir and w2->dir are interned strings, we don't own them */
> +	free(w1);
> +	free(w2);
> +}
> +
> +/*
> + * Check for stale directory renames.
> + *
> + * https://man7.org/linux/man-pages/man7/inotify.7.html
> + *
> + * Allow for some small timeout to account for the fact that insertion o=
f the
> + * IN_MOVED_FROM+IN_MOVED_TO event pair is not atomic, and the possibili=
ty that
> + * there may not be any IN_MOVED_TO event.
> + *
> + * If the IN_MOVED_TO event is not received within the timeout then even=
ts have
> + * been missed and the monitor is in an inconsistent state with respect =
to the
> + * filesystem.
> + */
> +static int check_stale_dir_renames(struct hashmap *renames, time_t max_a=
ge)
> +{
> +	struct rename_entry *re;
> +	struct hashmap_iter iter;
> +
> +	hashmap_for_each_entry(renames, &iter, re, ent) {
> +		if (re->whence <=3D max_age)
> +			return -1;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Track pending renames.
> + *
> + * Tracking is done via a event cookie to watch descriptor mapping.
> + *
> + * A rename is not complete until matching a IN_MOVED_TO event is receiv=
ed
> + * for a corresponding IN_MOVED_FROM event.
> + */
> +static void add_dir_rename(uint32_t cookie, const char *path,
> +	struct fsm_listen_data *data)

Nit: `add_dir_rename()` and the below `rename_dir()` sound as if we
actually perform the rename ourselves. How about `track_dir_rename()`
and `finalize_dir_rename()`?

> +{
> +	struct watch_entry k, *w;
> +	struct rename_entry *re;
> +
> +	/* lookup the watch descriptor for the given path */
> +	hashmap_entry_init(&k.ent, memhash(path, strlen(path)));
> +	w =3D hashmap_get_entry(&data->revwatches, &k, ent, NULL);
> +	if (!w) /* should never happen */
> +		BUG("No watch for '%s'", path);

Error message should start with lower-case character.

> +	w->cookie =3D cookie;
> +
> +	/* add the pending rename to match against later */
> +	CALLOC_ARRAY(re, 1);
> +	re->dir =3D w->dir;
> +	re->cookie =3D w->cookie;
> +	re->whence =3D time(NULL);
> +	hashmap_entry_init(&re->ent, memhash(&re->cookie, sizeof(uint32_t)));
> +	hashmap_add(&data->renames, &re->ent);
> +}
> +
> +/*
> + * Handle directory renames
> + *
> + * Once a IN_MOVED_TO event is received, lookup the rename tracking info=
rmation
> + * via the event cookie and use this information to update the watch.
> + */
> +static void rename_dir(uint32_t cookie, const char *path,
> +	struct fsm_listen_data *data)
> +{
> +	struct rename_entry rek, *re;
> +	struct watch_entry k, *w;
> +
> +	/* lookup a pending rename to match */
> +	rek.cookie =3D cookie;
> +	hashmap_entry_init(&rek.ent, memhash(&rek.cookie, sizeof(uint32_t)));
> +	re =3D hashmap_get_entry(&data->renames, &rek, ent, NULL);
> +	if (re) {
> +		k.dir =3D re->dir;
> +		hashmap_entry_init(&k.ent, memhash(k.dir, strlen(k.dir)));
> +		w =3D hashmap_get_entry(&data->revwatches, &k, ent, NULL);
> +		if (w) {
> +			w->cookie =3D 0; /* rename handled */
> +			remove_watch(w, data);
> +			add_watch(path, data);
> +		} else {
> +			BUG("No matching watch");
> +		}
> +	} else {
> +		BUG("No matching cookie");

The above two bugs should start with a lower-case letter.

> +	}
> +}
> +
> +/*
> + * Recursively add watches to every directory under path
> + */
> +static int register_inotify(const char *path,
> +	struct fsmonitor_daemon_state *state,
> +	struct fsmonitor_batch *batch)
> +{
> +	DIR *dir;
> +	const char *rel;
> +	struct strbuf current =3D STRBUF_INIT;
> +	struct dirent *de;
> +	struct stat fs;
> +	int ret =3D -1;
> +
> +	dir =3D opendir(path);
> +	if (!dir)
> +		return error_errno("opendir('%s') failed", path);
> +
> +	while ((de =3D readdir_skip_dot_and_dotdot(dir)) !=3D NULL) {
> +		strbuf_reset(&current);
> +		strbuf_addf(&current, "%s/%s", path, de->d_name);
> +		if (lstat(current.buf, &fs)) {
> +			error_errno("lstat('%s') failed", current.buf);

Missing `_()` translation marker.

> +			goto failed;
> +		}
> +
> +		/* recurse into directory */
> +		if (S_ISDIR(fs.st_mode)) {
> +			if (add_watch(current.buf, state->listen_data))
> +				goto failed;
> +			if (register_inotify(current.buf, state, batch))
> +				goto failed;
> +		} else if (batch) {
> +			rel =3D current.buf + state->path_worktree_watch.len + 1;
> +			trace_printf_key(&trace_fsmonitor, "explicitly adding '%s'", rel);
> +			fsmonitor_batch__add_path(batch, rel);
> +		}
> +	}
> +	ret =3D 0;
> +
> +failed:
> +	strbuf_release(&current);
> +	if (closedir(dir) < 0)
> +		return error_errno("closedir('%s') failed", path);

Missing `_()` translation marker.

> +	return ret;
> +}
> +
> +static int em_rename_dir_from(u_int32_t mask)
> +{
> +	return ((mask & IN_ISDIR) && (mask & IN_MOVED_FROM));
> +}
> +
> +static int em_rename_dir_to(u_int32_t mask)
> +{
> +	return ((mask & IN_ISDIR) && (mask & IN_MOVED_TO));
> +}
> +
> +static int em_remove_watch(u_int32_t mask)
> +{
> +	return (mask & IN_DELETE_SELF);
> +}
> +
> +static int em_dir_renamed(u_int32_t mask)
> +{
> +	return ((mask & IN_ISDIR) && (mask & IN_MOVE));
> +}
> +
> +static int em_dir_created(u_int32_t mask)
> +{
> +	return ((mask & IN_ISDIR) && (mask & IN_CREATE));
> +}
> +
> +static int em_dir_deleted(uint32_t mask)
> +{
> +	return ((mask & IN_ISDIR) && (mask & IN_DELETE));
> +}
> +
> +static int em_force_shutdown(u_int32_t mask)
> +{
> +	return (mask & IN_UNMOUNT) || (mask & IN_Q_OVERFLOW);
> +}
> +
> +static int em_ignore(u_int32_t mask)
> +{
> +	return (mask & IN_IGNORED) || (mask & IN_MOVE_SELF);
> +}
> +
> +static void log_mask_set(const char *path, u_int32_t mask)
> +{
> +	struct strbuf msg =3D STRBUF_INIT;
> +
> +	if (mask & IN_ACCESS)
> +		strbuf_addstr(&msg, "IN_ACCESS|");
> +	if (mask & IN_MODIFY)
> +		strbuf_addstr(&msg, "IN_MODIFY|");
> +	if (mask & IN_ATTRIB)
> +		strbuf_addstr(&msg, "IN_ATTRIB|");
> +	if (mask & IN_CLOSE_WRITE)
> +		strbuf_addstr(&msg, "IN_CLOSE_WRITE|");
> +	if (mask & IN_CLOSE_NOWRITE)
> +		strbuf_addstr(&msg, "IN_CLOSE_NOWRITE|");
> +	if (mask & IN_OPEN)
> +		strbuf_addstr(&msg, "IN_OPEN|");
> +	if (mask & IN_MOVED_FROM)
> +		strbuf_addstr(&msg, "IN_MOVED_FROM|");
> +	if (mask & IN_MOVED_TO)
> +		strbuf_addstr(&msg, "IN_MOVED_TO|");
> +	if (mask & IN_CREATE)
> +		strbuf_addstr(&msg, "IN_CREATE|");
> +	if (mask & IN_DELETE)
> +		strbuf_addstr(&msg, "IN_DELETE|");
> +	if (mask & IN_DELETE_SELF)
> +		strbuf_addstr(&msg, "IN_DELETE_SELF|");
> +	if (mask & IN_MOVE_SELF)
> +		strbuf_addstr(&msg, "IN_MOVE_SELF|");
> +	if (mask & IN_UNMOUNT)
> +		strbuf_addstr(&msg, "IN_UNMOUNT|");
> +	if (mask & IN_Q_OVERFLOW)
> +		strbuf_addstr(&msg, "IN_Q_OVERFLOW|");
> +	if (mask & IN_IGNORED)
> +		strbuf_addstr(&msg, "IN_IGNORED|");
> +	if (mask & IN_ISDIR)
> +		strbuf_addstr(&msg, "IN_ISDIR|");

Doesn't this end up with one trailing '|' in `msg`? You could use
`strbuf_strip_suffix(msg, "|")` to drop it.

> +	trace_printf_key(&trace_fsmonitor, "inotify_event: '%s', mask=3D%#8.8x =
%s",
> +				path, mask, msg.buf);
> +
> +	strbuf_release(&msg);
> +}
> +
> +int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
> +{
> +	int fd;
> +	int ret =3D 0;
> +	struct fsm_listen_data *data;
> +
> +	CALLOC_ARRAY(data, 1);
> +	state->listen_data =3D data;
> +	state->listen_error_code =3D -1;
> +	data->shutdown =3D SHUTDOWN_ERROR;
> +
> +	fd =3D inotify_init1(O_NONBLOCK);
> +	if (fd < 0)
> +		return error_errno("inotify_init1() failed");
> +
> +	data->fd_inotify =3D fd;
> +
> +	hashmap_init(&data->watches, watch_entry_cmp, NULL, 0);
> +	hashmap_init(&data->renames, rename_entry_cmp, NULL, 0);
> +	hashmap_init(&data->revwatches, revwatches_entry_cmp, NULL, 0);
> +
> +	if (add_watch(state->path_worktree_watch.buf, data))
> +		ret =3D -1;
> +	else if (register_inotify(state->path_worktree_watch.buf, state, NULL))
> +		ret =3D -1;
> +	else if (state->nr_paths_watching > 1) {
> +		if (add_watch(state->path_gitdir_watch.buf, data))
> +			ret =3D -1;
> +		else if (register_inotify(state->path_gitdir_watch.buf, state, NULL))
> +			ret =3D -1;
> +	}

Style: if one of the branches requires braces then all of them should.

> +
> +	if (!ret) {
> +		state->listen_error_code =3D 0;
> +		data->shutdown =3D SHUTDOWN_CONTINUE;
> +	}
> +
> +	return ret;
> +}
> +
> +void fsm_listen__dtor(struct fsmonitor_daemon_state *state)
> +{
> +	struct fsm_listen_data *data;
> +	struct hashmap_iter iter;
> +	struct watch_entry *w;
> +	int fd;
> +
> +	if (!state || !state->listen_data)
> +		return;
> +
> +	data =3D state->listen_data;
> +	fd =3D data->fd_inotify;
> +
> +	hashmap_for_each_entry(&data->watches, &iter, w, ent) {
> +		w->cookie =3D 0; /* ignore any pending renames */
> +		remove_watch(w, data);
> +	}
> +	hashmap_clear(&data->watches);
> +
> +	hashmap_clear(&data->revwatches); /* remove_watch freed the entries */
> +
> +	hashmap_clear_and_free(&data->renames, struct rename_entry, ent);
> +
> +	FREE_AND_NULL(state->listen_data);

The empty lines between all these cleanups  can probably be removed.

> +
> +	if (fd && (close(fd) < 0))
> +		error_errno(_("closing inotify file descriptor failed"));
> +}
> +
> +void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
> +{
> +	if (!state->listen_data->shutdown)
> +		state->listen_data->shutdown =3D SHUTDOWN_STOP;
> +}
> +
> +/*
> + * Process a single inotify event and queue for publication.
> + */
> +static int process_event(const char *path,
> +	const struct inotify_event *event,
> +	struct fsmonitor_batch *batch,
> +	struct string_list *cookie_list,
> +	struct fsmonitor_daemon_state *state)
> +{
> +	const char *rel;
> +	const char *last_sep;
> +
> +	switch (fsmonitor_classify_path_absolute(state, path)) {
> +		case IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX:
> +		case IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX:
> +			/* Use just the filename of the cookie file. */
> +			last_sep =3D find_last_dir_sep(path);
> +			string_list_append(cookie_list,
> +					last_sep ? last_sep + 1 : path);
> +			break;
> +		case IS_INSIDE_DOT_GIT:
> +		case IS_INSIDE_GITDIR:
> +			break;
> +		case IS_DOT_GIT:
> +		case IS_GITDIR:
> +			/*
> +			* If .git directory is deleted or renamed away,
> +			* we have to quit.
> +			*/
> +			if (em_dir_deleted(event->mask)) {
> +				trace_printf_key(&trace_fsmonitor,
> +						"event: gitdir removed");
> +				state->listen_data->shutdown =3D SHUTDOWN_FORCE;
> +				goto done;
> +			}
> +
> +			if (em_dir_renamed(event->mask)) {
> +				trace_printf_key(&trace_fsmonitor,
> +						"event: gitdir renamed");
> +				state->listen_data->shutdown =3D SHUTDOWN_FORCE;
> +				goto done;
> +			}
> +			break;
> +		case IS_WORKDIR_PATH:
> +			/* normal events in the working directory */
> +			if (trace_pass_fl(&trace_fsmonitor))
> +				log_mask_set(path, event->mask);
> +
> +			rel =3D path + state->path_worktree_watch.len + 1;
> +			fsmonitor_batch__add_path(batch, rel);
> +
> +			if (em_dir_deleted(event->mask))
> +				break;
> +
> +			/* received IN_MOVE_FROM, add tracking for expected IN_MOVE_TO */
> +			if (em_rename_dir_from(event->mask))
> +				add_dir_rename(event->cookie, path, state->listen_data);
> +
> +			/* received IN_MOVE_TO, update watch to reflect new path */
> +			if (em_rename_dir_to(event->mask)) {
> +				rename_dir(event->cookie, path, state->listen_data);
> +				if (register_inotify(path, state, batch)) {
> +					state->listen_data->shutdown =3D SHUTDOWN_ERROR;
> +					goto done;
> +				}
> +			}
> +
> +			if (em_dir_created(event->mask)) {
> +				if (add_watch(path, state->listen_data)) {
> +					state->listen_data->shutdown =3D SHUTDOWN_ERROR;
> +					goto done;
> +				}
> +				if (register_inotify(path, state, batch)) {
> +					state->listen_data->shutdown =3D SHUTDOWN_ERROR;
> +					goto done;
> +				}
> +			}
> +			break;
> +		case IS_OUTSIDE_CONE:
> +		default:
> +			trace_printf_key(&trace_fsmonitor,
> +					"ignoring '%s'", path);
> +			break;
> +	}
> +	return 0;
> +done:
> +	return -1;
> +}
> +
> +/*
> + * Read the inotify event stream and pre-process events before further
> + * processing and eventual publishing.
> + */
> +static void handle_events(struct fsmonitor_daemon_state *state)
> +{
> +	 /* See https://man7.org/linux/man-pages/man7/inotify.7.html */
> +	char buf[4096]
> +		__attribute__ ((aligned(__alignof__(struct inotify_event))));
> +
> +	struct hashmap watches =3D state->listen_data->watches;
> +	struct fsmonitor_batch *batch =3D NULL;
> +	struct string_list cookie_list =3D STRING_LIST_INIT_DUP;
> +	struct watch_entry k, *w;
> +	struct strbuf path;
> +	const struct inotify_event *event;
> +	int fd =3D state->listen_data->fd_inotify;
> +	ssize_t len;
> +	char *ptr, *p;

I think many of the variables could be moved into deeper scopes. Makes
it easier to assess what is being used where.

> +
> +	strbuf_init(&path, PATH_MAX);
> +
> +	for(;;) {
> +		len =3D read(fd, buf, sizeof(buf));
> +		if (len =3D=3D -1 && errno !=3D EAGAIN) {

Wouldn't we also have to handle EINTR here?

> +			error_errno(_("reading inotify message stream failed"));
> +			state->listen_data->shutdown =3D SHUTDOWN_ERROR;
> +			goto done;
> +		}
> +
> +		/* nothing to read */
> +		if (len <=3D 0)
> +			goto done;
> +
> +		/* Loop over all events in the buffer. */
> +		for (ptr =3D buf; ptr < buf + len;
> +			 ptr +=3D sizeof(struct inotify_event) + event->len) {

Nit: there's an additional whitespace here.

> +
> +			event =3D (const struct inotify_event *) ptr;
> +
> +			if (em_ignore(event->mask))
> +				continue;
> +
> +			/* File system was unmounted or event queue overflowed */
> +			if (em_force_shutdown(event->mask)) {
> +				if (trace_pass_fl(&trace_fsmonitor))
> +					log_mask_set("Forcing shutdown", event->mask);
> +				state->listen_data->shutdown =3D SHUTDOWN_FORCE;
> +				goto done;
> +			}
> +
> +			hashmap_entry_init(&k.ent, memhash(&event->wd, sizeof(int)));
> +			k.wd =3D event->wd;
> +
> +			w =3D hashmap_get_entry(&watches, &k, ent, NULL);
> +			if (!w) /* should never happen */
> +				BUG("No watch for '%s'", event->name);

Error messages should start with a lower-case letter.

> +
> +			/* directory watch was removed */
> +			if (em_remove_watch(event->mask)) {
> +				remove_watch(w, state->listen_data);
> +				continue;
> +			}
> +
> +			strbuf_reset(&path);
> +			strbuf_add(&path, w->dir, strlen(w->dir));
> +			strbuf_addch(&path, '/');
> +			strbuf_addstr(&path, event->name);

The above three lines can be simplified to:

```
strbuf_addf("%s/%s", w->dir, event->name);
```

> +
> +			p =3D fsmonitor__resolve_alias(path.buf, &state->alias);
> +			if (!p)
> +				p =3D strbuf_detach(&path, NULL);
> +
> +			if (!batch)
> +				batch =3D fsmonitor_batch__new();
> +
> +			if (process_event(p, event, batch, &cookie_list, state)) {
> +				free(p);
> +				goto done;
> +			}
> +			free(p);
> +		}
> +		strbuf_reset(&path);
> +		fsmonitor_publish(state, batch, &cookie_list);
> +		string_list_clear(&cookie_list, 0);
> +		batch =3D NULL;
> +	}
> +done:
> +	strbuf_release(&path);
> +	fsmonitor_batch__free_list(batch);
> +	string_list_clear(&cookie_list, 0);
> +}
> +
> +/*
> + * Non-blocking read of the inotify events stream. The inotify fd is pol=
led
> + * frequently to help minimize the number of queue overflows.
> + */
> +void fsm_listen__loop(struct fsmonitor_daemon_state *state)
> +{
> +	int poll_num;
> +	const int interval =3D 1000;

You could rename the variable to `interval_ms` to clarify its unit.

> +	time_t checked =3D time(NULL);
> +	struct pollfd fds[1];
> +	fds[0].fd =3D state->listen_data->fd_inotify;
> +	fds[0].events =3D POLLIN;
> +
> +	for(;;) {

Nit: `while (1)`

> +		switch (state->listen_data->shutdown) {
> +			case SHUTDOWN_CONTINUE:
> +				poll_num =3D poll(fds, 1, 1);

Why do you pick a timeout of 1 millisecond here? I'd have expected us to
instruct poll(3p) to either not block at all (0) or to block for
`interval`.

> +				if (poll_num =3D=3D -1) {
> +					if (errno =3D=3D EINTR)
> +						continue;

Wouldn't we also have to handle EAGAIN here?

Patrick

> +					error_errno(_("polling inotify message stream failed"));
> +					state->listen_data->shutdown =3D SHUTDOWN_ERROR;
> +					continue;
> +				}
> +
> +				if ((time(NULL) - checked) >=3D interval) {
> +					checked =3D time(NULL);
> +					if (check_stale_dir_renames(&state->listen_data->renames,
> +						checked - interval)) {
> +						trace_printf_key(&trace_fsmonitor,
> +							"Missed IN_MOVED_TO events, forcing shutdown");
> +						state->listen_data->shutdown =3D SHUTDOWN_FORCE;
> +						continue;
> +					}
> +				}
> +
> +				if (poll_num > 0 && (fds[0].revents & POLLIN))
> +					handle_events(state);
> +
> +				continue;
> +			case SHUTDOWN_ERROR:
> +				state->listen_error_code =3D -1;
> +				ipc_server_stop_async(state->ipc_server_data);
> +				break;
> +			case SHUTDOWN_FORCE:
> +				state->listen_error_code =3D 0;
> +				ipc_server_stop_async(state->ipc_server_data);
> +				break;
> +			case SHUTDOWN_STOP:
> +			default:
> +				state->listen_error_code =3D 0;
> +				break;
> +		}
> +		return;
> +	}
> +}
> --=20
> gitgitgadget
>=20
>=20

--8TCCcnyCXBQBR8AO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXOFmwACgkQVbJhu7ck
PpRDmA/9GxOfIA3G2h3c9AFJ2xJ0rYz+L2i/zKxhOgnDt00GAV/1bodnefIPLeAQ
86ElbntA8yLZP93ljPXnkG77lLNCIph8ZutzwHUY6sGuOp32Kx5WM1RT9h00JJwr
zGRKnYTn61NNSqny4PEV+Ic68kC8+SGwgqLNhY71GPVTjEM75hlzvriOa38AQ+S0
w0HLsQYtfG3P1m/KrWL2H5+EWpugiIEWfEnFpw165TZGCtNoHb7nw/JnVU3+4XbO
WfWJlugM9Wgj5X5USLAeU2CSIWu44OkgVb16T9jLWxQ7W+zFY4X9+mZT+bgN0umS
hYgF/VulA/rvT1JohYeh8tg3rtyTBijEbMq/21LJRryrpPUvvmtEPpqXcjmlxIm1
iEEBRWRvo7ZwzrIuAXmxNNbPDJV9/rHTpl4tsRWVPvurSJ+qQaTt9hkB+QU8kiWm
XTHX3uHYyNu5VlR9hWOKplLAA0ew48K2t8e8JafLAzHjvJ608Y5PK7ZVHqNU/RmD
hSeGVWpfvYUtxpAvzDfAZVqpg1404/P4JPv3r/N3B0j6NpKj2cYZZG5fkve7G9Oj
pkVrwPn/5oTsb+i5y14TYbm+C4LemCgzE+3YfZUBMvJGcMdrUPvGG/slfbR0xjgu
u2U4K58G8y9kJgqo/mNnHkm8Fop23h4IcHt6pzxAUTA6ZJxGQs0=
=aGWq
-----END PGP SIGNATURE-----

--8TCCcnyCXBQBR8AO--
