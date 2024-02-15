Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4089113329E
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004988; cv=none; b=hLK4ApjXmRzoYk8TEm30dIeQJhW4b2FEalyjn55pvEa70d8XHMXzTAX+luEOMgYV43ZwEjrKHtYsSwJkK063jStu+wSiREYi9+WkjnM2UdNUSZt4s4uftNHI8iDc0Oidpvh5kRkelRVJNkx0RDNbCTApuOdAa26tZIkNVesUsH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004988; c=relaxed/simple;
	bh=21SVOvoQc1m+u9+nmFQCpiIJZR/84GBzPx3bUVs/0SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTtzkrN4F8WjkTeiUOktievem0raoxHwnPlZaP5FeevGW9dnJLymESKDfywHzz2kM0S3YM9KTvTyWPuAIplionoc/JZusQvF6EbqH8V5D+oVyZgA2lsoPGA5ow/1zuPLLA6ZxSd9quH/TKWrlT06M9TbRuek0J130K65ZBLOH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i1MMIF3r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YPEe/rD8; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i1MMIF3r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YPEe/rD8"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 5579A3200A81;
	Thu, 15 Feb 2024 08:49:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 15 Feb 2024 08:49:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708004982; x=1708091382; bh=mBDQ/nWnmV
	QWrVNr4shlrNse3+D9/KuKP5PvlzYPkR0=; b=i1MMIF3rVBO9R/HDqeYZwO9Gg5
	szZTwqiQOKR5y21UTKSbeJTmd+bUWsLV6sNaxNMBWXT6tv6fSKHV4uUTLtt8Xemg
	smJcVJR7FC3uJkX7Z81PoXIrhEQnLNh+4p4/epyJOvHLsQiOzabnSvr+MMBv/ym/
	mWFmpjxxgo7NQq/Ydos20zEPBGNnAOedgrgzfr+SA6phAjj6OKkzPJv1GJYIZU40
	u//03JZaKm8fIgk2lGuj7eKNm1REQmx3C19JLvglRqhiSWXdmozc7dvMeDYR9cje
	o6Lc5fml4/fSNoGIOzV/FUBgADlQjLTOxeOnjIpUvVvZPRx5AhNZqJ/bW3DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708004982; x=1708091382; bh=mBDQ/nWnmVQWrVNr4shlrNse3+D9
	/KuKP5PvlzYPkR0=; b=YPEe/rD8w0+7P4aREgwwxhJHkqUi+bva9eRRPkdbWcDc
	fw6sg0vBY+z8xBIkQA5vMDyz3o5X4xtMrzG2VeJBXoQAbGBJ5nTCgiATVViTBvoa
	nDKIyOnhYe8s3T+1lSLZTOspCg6enOodAlGerfQ2UATiNY6Mij8NLjyaRIDOUj4C
	IXQjNb/pRQPhLl64+VNsW5H4/DfnxfdktMiXkntJ/aRFQjO4i3Zu5/VWwvyK7xOo
	oGYbre866OiQ822qtFDt6MgP6GnjVbBcz3IV7V1H8IajadVUS9jKqkiaGJLvYIoa
	hQDM10vzqmgZoSESmvqX/PisNB1dNMejXnlafmPopQ==
X-ME-Sender: <xms:dhbOZS-yC-laGjYOWV8M3_4tVmmma2Cx7KEwDvDRnccvr1Ehn0pJ4w>
    <xme:dhbOZSs0WwmdMkM8lAh1oTmg0V7PdIwgEos2ncYOn3fU-Kp6UvHJhvMzTVf_wc2bn
    x1Pvm28wzPBx13JVA>
X-ME-Received: <xmr:dhbOZYAwuEXS9lvDxInexWNIGnFzCbjSSUdCo8qrm611SopQvkzvLNN3VinDGRW4WBSQF-_RZus_59n_RQO9vGYbXHBBt5_C5TETJSaLUFAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefgeeggfekfeeiieeiieduleeuheetgeelheeljeekjeffueeuudetvefgffetleen
    ucffohhmrghinhepmhgrnhejrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:dhbOZacS4yVdk2WfNc4xEj61V54J4TqAuP3d1lTeVgKQHFYkopAhCg>
    <xmx:dhbOZXO_qGS4WFYYXk3Rq5jKSLO992H1mwdIvnYqquClH3ktlojUvw>
    <xmx:dhbOZUlyxTDy3Ns4_Q7-wIErFkVS0ypvcxFjHRtoHLIh3rokYpok9Q>
    <xmx:dhbOZQg51FWjrShfYOfFAxjiBPvlf8GZMDplqlGtVtuz-afTz9Z4GA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 08:49:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 153547da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 13:45:48 +0000 (UTC)
Date: Thu, 15 Feb 2024 14:49:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "marzi.esipreh via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Eric Sunshine [ ]" <sunshine@sunshineco.com>,
	=?iso-8859-1?B?xnZhciBBcm5mavZy8CBCamFybWFzb24gWyBd?= <avarab@gmail.com>,
	"Glen Choo [ ]" <chooglen@google.com>,
	"Johannes Schindelin [ ]" <Johannes.Schindelin@gmx.de>,
	"Taylor Blau [ ]" <me@ttaylorr.com>, marzi <m.ispare63@gmail.com>,
	"marzi.esipreh" <marzi.esipreh@uber.com>
Subject: Re: [PATCH 7/7] fsmonitor: addressed comments for patch 1352
Message-ID: <Zc4WcgJbH73uyRtc@tanuki>
References: <pull.1667.git.git.1707992978.gitgitgadget@gmail.com>
 <74a4fa335a7c2014a35be8556887170169360b36.1707992978.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8iCGhldU5VLWydwv"
Content-Disposition: inline
In-Reply-To: <74a4fa335a7c2014a35be8556887170169360b36.1707992978.git.gitgitgadget@gmail.com>


--8iCGhldU5VLWydwv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 10:29:38AM +0000, marzi.esipreh via GitGitGadget wr=
ote:
> From: "marzi.esipreh" <marzi.esipreh@uber.com>
>=20
> addressed comments on 1352, rebased, resolved conflicts

Please squash these changes into the preceding commits whereever
required.

Patrick

>=20
> Signed-off-by: Marzieh Esipreh <m.ispare63@gmail.com>
> ---
>  compat/fsmonitor/fsm-health-linux.c     |   2 +-
>  compat/fsmonitor/fsm-ipc-unix.c         |   6 +-
>  compat/fsmonitor/fsm-listen-linux.c     | 170 ++++++++++++------------
>  compat/fsmonitor/fsm-path-utils-linux.c |   1 +
>  compat/fsmonitor/fsm-settings-unix.c    |   3 +
>  5 files changed, 95 insertions(+), 87 deletions(-)
>=20
> diff --git a/compat/fsmonitor/fsm-health-linux.c b/compat/fsmonitor/fsm-h=
ealth-linux.c
> index b9f709e8548..4c291f8a066 100644
> --- a/compat/fsmonitor/fsm-health-linux.c
> +++ b/compat/fsmonitor/fsm-health-linux.c
> @@ -1,4 +1,4 @@
> -#include "cache.h"
> +#include "git-compat-util.h"
>  #include "config.h"
>  #include "fsmonitor.h"
>  #include "fsm-health.h"
> diff --git a/compat/fsmonitor/fsm-ipc-unix.c b/compat/fsmonitor/fsm-ipc-u=
nix.c
> index eb25123fa12..70afddfd298 100644
> --- a/compat/fsmonitor/fsm-ipc-unix.c
> +++ b/compat/fsmonitor/fsm-ipc-unix.c
> @@ -1,10 +1,12 @@
> -#include "cache.h"
> +#include "git-compat-util.h"
>  #include "config.h"
>  #include "hex.h"
>  #include "strbuf.h"
>  #include "fsmonitor.h"
>  #include "fsmonitor-ipc.h"
>  #include "fsmonitor-path-utils.h"
> +#include "gettext.h"
> +#include "path.h"
> =20
>  static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon=
=2Eipc")
> =20
> @@ -17,7 +19,7 @@ const char *fsmonitor_ipc__get_path(struct repository *=
r)
>  	unsigned char hash[GIT_MAX_RAWSZ];
> =20
>  	if (!r)
> -		BUG("No repository passed into fsmonitor_ipc__get_path");
> +		BUG("no repository passed into fsmonitor_ipc__get_path");
> =20
>  	if (ipc_path)
>  		return ipc_path;
> diff --git a/compat/fsmonitor/fsm-listen-linux.c b/compat/fsmonitor/fsm-l=
isten-linux.c
> index e8548e4e009..84d8fb28d5d 100644
> --- a/compat/fsmonitor/fsm-listen-linux.c
> +++ b/compat/fsmonitor/fsm-listen-linux.c
> @@ -1,7 +1,10 @@
> -#include "cache.h"
> +#include "git-compat-util.h"
> +#include "config.h"
>  #include "fsmonitor.h"
>  #include "fsm-listen.h"
>  #include "fsmonitor--daemon.h"
> +#include "gettext.h"
> +#include "simple-ipc.h"
>  #include <dirent.h>
>  #include <fcntl.h>
>  #include <sys/inotify.h>
> @@ -129,15 +132,15 @@ static void remove_watch(struct watch_entry *w,
>  	hashmap_entry_init(&k1.ent, memhash(&w->wd, sizeof(int)));
>  	w1 =3D hashmap_remove_entry(&data->watches, &k1, ent, NULL);
>  	if (!w1)
> -		BUG("Double remove of watch for '%s'", w->dir);
> +		BUG("double remove of watch for '%s'", w->dir);
> =20
>  	if (w1->cookie)
> -		BUG("Removing watch for '%s' which has a pending rename", w1->dir);
> +		BUG("removing watch for '%s' which has a pending rename", w1->dir);
> =20
>  	hashmap_entry_init(&k2.ent, memhash(w->dir, strlen(w->dir)));
>  	w2 =3D hashmap_remove_entry(&data->revwatches, &k2, ent, NULL);
>  	if (!w2)
> -		BUG("Double remove of reverse watch for '%s'", w->dir);
> +		BUG("double remove of reverse watch for '%s'", w->dir);
> =20
>  	/* w1->dir and w2->dir are interned strings, we don't own them */
>  	free(w1);
> @@ -187,7 +190,7 @@ static void add_dir_rename(uint32_t cookie, const cha=
r *path,
>  	hashmap_entry_init(&k.ent, memhash(path, strlen(path)));
>  	w =3D hashmap_get_entry(&data->revwatches, &k, ent, NULL);
>  	if (!w) /* should never happen */
> -		BUG("No watch for '%s'", path);
> +		BUG("no watch for '%s'", path);
>  	w->cookie =3D cookie;
> =20
>  	/* add the pending rename to match against later */
> @@ -224,10 +227,10 @@ static void rename_dir(uint32_t cookie, const char =
*path,
>  			remove_watch(w, data);
>  			add_watch(path, data);
>  		} else {
> -			BUG("No matching watch");
> +			BUG("no matching watch");
>  		}
>  	} else {
> -		BUG("No matching cookie");
> +		BUG("no matching cookie");
>  	}
>  }
> =20
> @@ -249,7 +252,7 @@ static int register_inotify(const char *path,
>  	if (!dir)
>  		return error_errno("opendir('%s') failed", path);
> =20
> -	while ((de =3D readdir_skip_dot_and_dotdot(dir)) !=3D NULL) {
> +	while ((de =3D readdir_skip_dot_and_dotdot(dir))) {
>  		strbuf_reset(&current);
>  		strbuf_addf(&current, "%s/%s", path, de->d_name);
>  		if (lstat(current.buf, &fs)) {
> @@ -353,7 +356,7 @@ static void log_mask_set(const char *path, u_int32_t =
mask)
>  	if (mask & IN_IGNORED)
>  		strbuf_addstr(&msg, "IN_IGNORED|");
>  	if (mask & IN_ISDIR)
> -		strbuf_addstr(&msg, "IN_ISDIR|");
> +		strbuf_addstr(&msg, "IN_ISDIR");
> =20
>  	trace_printf_key(&trace_fsmonitor, "inotify_event: '%s', mask=3D%#8.8x =
%s",
>  				path, mask, msg.buf);
> @@ -373,8 +376,10 @@ int fsm_listen__ctor(struct fsmonitor_daemon_state *=
state)
>  	data->shutdown =3D SHUTDOWN_ERROR;
> =20
>  	fd =3D inotify_init1(O_NONBLOCK);
> -	if (fd < 0)
> +	if (fd < 0) {
> +		FREE_AND_NULL(data);
>  		return error_errno("inotify_init1() failed");
> +	}
> =20
>  	data->fd_inotify =3D fd;
> =20
> @@ -386,12 +391,10 @@ int fsm_listen__ctor(struct fsmonitor_daemon_state =
*state)
>  		ret =3D -1;
>  	else if (register_inotify(state->path_worktree_watch.buf, state, NULL))
>  		ret =3D -1;
> -	else if (state->nr_paths_watching > 1) {
> -		if (add_watch(state->path_gitdir_watch.buf, data))
> -			ret =3D -1;
> -		else if (register_inotify(state->path_gitdir_watch.buf, state, NULL))
> -			ret =3D -1;
> -	}
> +	else if (state->nr_paths_watching > 1 &&
> +		 (add_watch(state->path_gitdir_watch.buf, data) ||
> +		  register_inotify(state->path_gitdir_watch.buf, state, NULL)))
> +		ret =3D -1;
> =20
>  	if (!ret) {
>  		state->listen_error_code =3D 0;
> @@ -449,80 +452,80 @@ static int process_event(const char *path,
>  	const char *last_sep;
> =20
>  	switch (fsmonitor_classify_path_absolute(state, path)) {
> -		case IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX:
> -		case IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX:
> -			/* Use just the filename of the cookie file. */
> -			last_sep =3D find_last_dir_sep(path);
> -			string_list_append(cookie_list,
> -					last_sep ? last_sep + 1 : path);
> -			break;
> -		case IS_INSIDE_DOT_GIT:
> -		case IS_INSIDE_GITDIR:
> -			break;
> -		case IS_DOT_GIT:
> -		case IS_GITDIR:
> -			/*
> -			* If .git directory is deleted or renamed away,
> -			* we have to quit.
> -			*/
> -			if (em_dir_deleted(event->mask)) {
> -				trace_printf_key(&trace_fsmonitor,
> -						"event: gitdir removed");
> -				state->listen_data->shutdown =3D SHUTDOWN_FORCE;
> -				goto done;
> -			}
> +	case IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX:
> +	case IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX:
> +		/* Use just the filename of the cookie file. */
> +		last_sep =3D find_last_dir_sep(path);
> +		string_list_append(cookie_list,
> +				last_sep ? last_sep + 1 : path);
> +		break;
> +	case IS_INSIDE_DOT_GIT:
> +	case IS_INSIDE_GITDIR:
> +		break;
> +	case IS_DOT_GIT:
> +	case IS_GITDIR:
> +		/*
> +		* If .git directory is deleted or renamed away,
> +		* we have to quit.
> +		*/
> +		if (em_dir_deleted(event->mask)) {
> +			trace_printf_key(&trace_fsmonitor,
> +					"event: gitdir removed");
> +			state->listen_data->shutdown =3D SHUTDOWN_FORCE;
> +			goto done;
> +		}
> =20
> -			if (em_dir_renamed(event->mask)) {
> -				trace_printf_key(&trace_fsmonitor,
> -						"event: gitdir renamed");
> -				state->listen_data->shutdown =3D SHUTDOWN_FORCE;
> -				goto done;
> -			}
> -			break;
> -		case IS_WORKDIR_PATH:
> -			/* normal events in the working directory */
> -			if (trace_pass_fl(&trace_fsmonitor))
> -				log_mask_set(path, event->mask);
> +		if (em_dir_renamed(event->mask)) {
> +			trace_printf_key(&trace_fsmonitor,
> +					"event: gitdir renamed");
> +			state->listen_data->shutdown =3D SHUTDOWN_FORCE;
> +			goto done;
> +		}
> +		break;
> +	case IS_WORKDIR_PATH:
> +		/* normal events in the working directory */
> +		if (trace_pass_fl(&trace_fsmonitor))
> +			log_mask_set(path, event->mask);
> =20
> -			rel =3D path + state->path_worktree_watch.len + 1;
> -			fsmonitor_batch__add_path(batch, rel);
> +		rel =3D path + state->path_worktree_watch.len + 1;
> +		fsmonitor_batch__add_path(batch, rel);
> =20
> -			if (em_dir_deleted(event->mask))
> -				break;
> +		if (em_dir_deleted(event->mask))
> +			break;
> =20
> -			/* received IN_MOVE_FROM, add tracking for expected IN_MOVE_TO */
> -			if (em_rename_dir_from(event->mask))
> -				add_dir_rename(event->cookie, path, state->listen_data);
> +		/* received IN_MOVE_FROM, add tracking for expected IN_MOVE_TO */
> +		if (em_rename_dir_from(event->mask))
> +			add_dir_rename(event->cookie, path, state->listen_data);
> =20
> -			/* received IN_MOVE_TO, update watch to reflect new path */
> -			if (em_rename_dir_to(event->mask)) {
> -				rename_dir(event->cookie, path, state->listen_data);
> -				if (register_inotify(path, state, batch)) {
> -					state->listen_data->shutdown =3D SHUTDOWN_ERROR;
> -					goto done;
> -				}
> +		/* received IN_MOVE_TO, update watch to reflect new path */
> +		if (em_rename_dir_to(event->mask)) {
> +			rename_dir(event->cookie, path, state->listen_data);
> +			if (register_inotify(path, state, batch)) {
> +				state->listen_data->shutdown =3D SHUTDOWN_ERROR;
> +				goto done;
>  			}
> +		}
> =20
> -			if (em_dir_created(event->mask)) {
> -				if (add_watch(path, state->listen_data)) {
> -					state->listen_data->shutdown =3D SHUTDOWN_ERROR;
> -					goto done;
> -				}
> -				if (register_inotify(path, state, batch)) {
> -					state->listen_data->shutdown =3D SHUTDOWN_ERROR;
> -					goto done;
> -				}
> +		if (em_dir_created(event->mask)) {
> +			if (add_watch(path, state->listen_data)) {
> +				state->listen_data->shutdown =3D SHUTDOWN_ERROR;
> +				goto done;
>  			}
> -			break;
> -		case IS_OUTSIDE_CONE:
> -		default:
> -			trace_printf_key(&trace_fsmonitor,
> -					"ignoring '%s'", path);
> -			break;
> +			if (register_inotify(path, state, batch)) {
> +				state->listen_data->shutdown =3D SHUTDOWN_ERROR;
> +				goto done;
> +			}
> +		}
> +		break;
> +	case IS_OUTSIDE_CONE:
> +	default:
> +		trace_printf_key(&trace_fsmonitor,
> +				"ignoring '%s'", path);
> +		break;
>  	}
>  	return 0;
> -done:
> -	return -1;
> +	done:
> +		return -1;
>  }
> =20
>  /*
> @@ -531,7 +534,7 @@ static int process_event(const char *path,
>   */
>  static void handle_events(struct fsmonitor_daemon_state *state)
>  {
> -	 /* See https://man7.org/linux/man-pages/man7/inotify.7.html */
> +	/* See https://man7.org/linux/man-pages/man7/inotify.7.html */
>  	char buf[4096]
>  		__attribute__ ((aligned(__alignof__(struct inotify_event))));
> =20
> @@ -539,13 +542,12 @@ static void handle_events(struct fsmonitor_daemon_s=
tate *state)
>  	struct fsmonitor_batch *batch =3D NULL;
>  	struct string_list cookie_list =3D STRING_LIST_INIT_DUP;
>  	struct watch_entry k, *w;
> -	struct strbuf path;
>  	const struct inotify_event *event;
>  	int fd =3D state->listen_data->fd_inotify;
>  	ssize_t len;
>  	char *ptr, *p;
> =20
> -	strbuf_init(&path, PATH_MAX);
> +	struct strbuf path =3D STRBUF_INIT;
> =20
>  	for(;;) {
>  		len =3D read(fd, buf, sizeof(buf));
> @@ -581,7 +583,7 @@ static void handle_events(struct fsmonitor_daemon_sta=
te *state)
> =20
>  			w =3D hashmap_get_entry(&watches, &k, ent, NULL);
>  			if (!w) /* should never happen */
> -				BUG("No watch for '%s'", event->name);
> +				BUG("no watch for '%s'", event->name);
> =20
>  			/* directory watch was removed */
>  			if (em_remove_watch(event->mask)) {
> diff --git a/compat/fsmonitor/fsm-path-utils-linux.c b/compat/fsmonitor/f=
sm-path-utils-linux.c
> index c21d1349532..0e3b33ffa48 100644
> --- a/compat/fsmonitor/fsm-path-utils-linux.c
> +++ b/compat/fsmonitor/fsm-path-utils-linux.c
> @@ -3,6 +3,7 @@
>  #include "fsmonitor.h"
>  #include "fsmonitor-path-utils.h"
>  #include "fsm-path-utils-linux.h"
> +#include "gettext.h"
>  #include <errno.h>
>  #include <mntent.h>
>  #include <sys/mount.h>
> diff --git a/compat/fsmonitor/fsm-settings-unix.c b/compat/fsmonitor/fsm-=
settings-unix.c
> index d16dca89416..c9b75aa44fe 100644
> --- a/compat/fsmonitor/fsm-settings-unix.c
> +++ b/compat/fsmonitor/fsm-settings-unix.c
> @@ -1,6 +1,9 @@
> +#include "git-compat-util.h"
> +#include "config.h"
>  #include "fsmonitor.h"
>  #include "fsmonitor-ipc.h"
>  #include "fsmonitor-path-utils.h"
> +#include <stdint.h>
> =20
>   /*
>   * For the builtin FSMonitor, we create the Unix domain socket for the
> --=20
> gitgitgadget
>=20

--8iCGhldU5VLWydwv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXOFnIACgkQVbJhu7ck
PpRGhQ//XLgb+CyHvBlZxqb+IQHPDCWknnlegg0Omp9yML8ZYq+HLdQQKhr0pciG
tc/jFNZt3IOaw9Kculr8/HSQ1s53QSCwc6FTIO+HJTnaniTwc3taOVmqHDBj3ZS8
iiUOrdgNBIhwMXuuL7c3pBjfYakC5saaUAd3xn6luGNOxzOtWATQ8paWQUc1OL0j
aLl5dhLdGcg+F7NLRge0Z5FNpBcFolH7F6hudbOp5stY9J5rhZmKP9vPh2EhnRPL
qo6tKGZaxVIKyllk5TWCml5CAonUn3oP56oEWeyoQNx5R+RxZ8iQ1KKxIR0E0kd3
cxcr7Z+z++1FoFOQuN+xQhhOjyi3mIAJ+kRMNciIIp3Zk7OudIvJJFt6E8kEn1XR
p0JcUMy1KWmTXul/CXvj8ADWIuWBti2D7KARr+e6BwxhYU7u2z9CGJ0TENC9jBhu
eTWGsmJX2HpafsdJlG6xNxSTCcfp/KkUfB6rdBccbL+p2bJ2gbfTzsv1A5vBdwK6
1JAMA91ef8h6kW1Uah6+5AT6CXFu9LHzgW7ISDAMYNkKzbWXmNMPwqBJcKPNFWBu
9lMKnM3BIjVGKhxSM8WOqjS0Uo+KX/Gh69qWqY4Yy7pWtH/RJM/wRSp9tM3lXcY4
6fxaCD31NToZ9abvfmo0q9IcOgZcW+5EdOS9AkY1g0MJQUY7yX0=
=4Yb9
-----END PGP SIGNATURE-----

--8iCGhldU5VLWydwv--
