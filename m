Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EFD12FF88
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004973; cv=none; b=K4gp2YygREi//YPAot/B1EZfR74AVxcvUNXrGvvdNBuGMxusaEs1I6Pjj1F/v60ZZRV415ySSgAwRsuyzms2TCPvv8wAHTWmKV8HliS4e+EycMWncdl1Go0L4MINi7Luph6JbIsEQ8t3oYQgcY+JWQapySaxBLkbM29U9apGVIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004973; c=relaxed/simple;
	bh=mitcJGeHhF99UspNid+5OZR83m9bOcpFLmkzL6Murq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4gL2pzoOmz658z59E9haEFZmWIQq+qfWEXtndTsWnv5y7sq4quqDXRqjJvKFg7qrDZdktXI26RWoCsSGierB2dR0jytqp4/DZZkH0cTo5XaDPpADlY3fRcRH8h533RMWvlA7U2bxShXHaMHG0KuXwLzqOQnQ9nrfSwYxqopuo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HR7Zw75t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GSl+f3en; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HR7Zw75t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GSl+f3en"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 74F2C320024A;
	Thu, 15 Feb 2024 08:49:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 15 Feb 2024 08:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708004967; x=1708091367; bh=br8UJS65Kw
	7phBzf40bajp1ZZS9zpsmAbEyH7fMxlco=; b=HR7Zw75tzIw0SAp+uFoJQqKwLp
	urrCQNgDJwfVIhWJ1hi2QZcSedQEUKxoxf26Sx7UtMu0O61oCG0CtcWe1aVaAKtH
	t9r7s78So3GjpZVdmS7ViAvUQOpcOHjSzBxs4PVTXoJ5UK2DRNkNLdw9SokUFP/8
	1PIBJQ+NcStW0HhKzodBsbOojORHgQnMoHsm7J7zewdhKDR4eiTYDwxJAgh2qMfI
	B5AyeXOkcmrA1zicw7+Rt6qD88bT+BZuKjE/qDTcw2yIdAmTHqt/iJshe47cAAAp
	21c//7bat77AYMg80pof51S+ft50CioU33PEDgJZ4Pp90skIfuCm7kqBUNOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708004967; x=1708091367; bh=br8UJS65Kw7phBzf40bajp1ZZS9z
	psmAbEyH7fMxlco=; b=GSl+f3enaTdBuK/D8du1bFqo2xVfGUoR0COodHjt/z4F
	jCMfZtfnYmV8CgSpR3N2i0L3MOskn/ihqx8m4mdjZRnKO/E/A4oKf1UwiexBci2x
	zfrJPRFHdysZG7jahpSt9/e1kacBFOh6FsWpK2GDWhHVJTK15boffKLy93d/5ApL
	VxfbOHYu4bJTSsbrk9v8Bdugp4ZaX/L6wIVEeh09FHgQTKtm/rp0hX7w0ImhgB2j
	Z42yMf+4ZA74rD4QbSlQkRNtzR93C1yj/uFacsZT/0Jpp/wzskl8yiR6GVtRW6nu
	dtJ5Cd4JS2R4dSiPTCib/N45voLvCdtiiEJ90wkgtw==
X-ME-Sender: <xms:ZxbOZSJA4ASNDEXmBkXhusScOyENkR1xzGweMlsOt_JNuGkbHJgoYA>
    <xme:ZxbOZaL2Z3CFo_nyQ6t-hTP8yldAdWCTDcER8GjOUPAcrxVdNb8yJMTN-FGrViv38
    f3tByK_ol62u1ZsIA>
X-ME-Received: <xmr:ZxbOZSvnkRTdOc9aEv_IyXdP1Eag7vi6JAP4JvHLnMRb4PVqnST9tI0htCm4BnvApPN-6Kj3lZeLOwCA-gmnEpqQxmiTnHv8IJxv_8jKQLr1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:ZxbOZXZ7V4LgXSIm0rpzCKrXq0xOlgUYfUCg5Qnq4KXHsXlpMovzuQ>
    <xmx:ZxbOZZZZN3kg_Z5i01zvghkml0MTqUIvHqZO2Kytrd1K94pihvO88A>
    <xmx:ZxbOZTCFPILdFp-i7gLn24O4ajxTsZwL8XAAsv0u1PkDyjQA5QEvbA>
    <xmx:ZxbOZXPwBHSHLDA8Zy_tvI8OzWP6Lw1ucIqCC3X_Ixl1Tio8SPDqqQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 08:49:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c26d605e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 13:45:31 +0000 (UTC)
Date: Thu, 15 Feb 2024 14:49:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Eric Sunshine [ ]" <sunshine@sunshineco.com>,
	=?iso-8859-1?B?xnZhciBBcm5mavZy8CBCamFybWFzb24gWyBd?= <avarab@gmail.com>,
	"Glen Choo [ ]" <chooglen@google.com>,
	"Johannes Schindelin [ ]" <Johannes.Schindelin@gmx.de>,
	"Taylor Blau [ ]" <me@ttaylorr.com>, marzi <m.ispare63@gmail.com>,
	Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH 1/7] fsmonitor: rebase with master
Message-ID: <Zc4WYrozXIJ41xtW@tanuki>
References: <pull.1667.git.git.1707992978.gitgitgadget@gmail.com>
 <5973bbe18aeecf486d8256cc402285665c45e66a.1707992978.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AAqU0H4QVnW9TIQv"
Content-Disposition: inline
In-Reply-To: <5973bbe18aeecf486d8256cc402285665c45e66a.1707992978.git.gitgitgadget@gmail.com>


--AAqU0H4QVnW9TIQv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 10:29:32AM +0000, Eric DeCosta via GitGitGadget wro=
te:
> From: Eric DeCosta <edecosta@mathworks.com>
>=20
> rebased with master, and resolved conflicts

It would be a lot more useful if you adopted the original phrasing of
the commit:

```
fsmonitor: prepare to share code between Mac OS and Linux=20

Linux and Mac OS can share some of the code originally developed for Mac OS.

Mac OS and Linux can share fsm-ipc-unix.c and fsm-settings-unix.c

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
```

Depending on whether or not you have made significant changes during the
rebase I'd also convert the trailers to:

Patch-originally-by: Eric DeCoste <edecosta@mathworks.com>
Signed-off-by: Marzieh Esipreh <m.ispare63@gmail.com>

Furthermore, I think it would be useful if this commit was split up even
further than it already is. Having a preparatory patch that moves around
shareable code is a different topic than introducing the code skeleton
for Linux support, and as far as I can see the shared code does not end
up requiring anything from the new "*-linux.c" files.

Patrick

> Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
> ---
>  compat/fsmonitor/fsm-health-linux.c    | 24 ++++++++++
>  compat/fsmonitor/fsm-ipc-darwin.c      | 57 +----------------------
>  compat/fsmonitor/fsm-ipc-linux.c       |  1 +
>  compat/fsmonitor/fsm-ipc-unix.c        | 53 +++++++++++++++++++++
>  compat/fsmonitor/fsm-settings-darwin.c | 64 +-------------------------
>  compat/fsmonitor/fsm-settings-linux.c  |  1 +
>  compat/fsmonitor/fsm-settings-unix.c   | 61 ++++++++++++++++++++++++
>  7 files changed, 142 insertions(+), 119 deletions(-)
>  create mode 100644 compat/fsmonitor/fsm-health-linux.c
>  create mode 100644 compat/fsmonitor/fsm-ipc-linux.c
>  create mode 100644 compat/fsmonitor/fsm-ipc-unix.c
>  create mode 100644 compat/fsmonitor/fsm-settings-linux.c
>  create mode 100644 compat/fsmonitor/fsm-settings-unix.c
>=20
> diff --git a/compat/fsmonitor/fsm-health-linux.c b/compat/fsmonitor/fsm-h=
ealth-linux.c
> new file mode 100644
> index 00000000000..b9f709e8548
> --- /dev/null
> +++ b/compat/fsmonitor/fsm-health-linux.c
> @@ -0,0 +1,24 @@
> +#include "cache.h"
> +#include "config.h"
> +#include "fsmonitor.h"
> +#include "fsm-health.h"
> +#include "fsmonitor--daemon.h"
> +
> +int fsm_health__ctor(struct fsmonitor_daemon_state *state)
> +{
> +	return 0;
> +}
> +
> +void fsm_health__dtor(struct fsmonitor_daemon_state *state)
> +{
> +	return;
> +}
> +
> +void fsm_health__loop(struct fsmonitor_daemon_state *state)
> +{
> +	return;
> +}
> +
> +void fsm_health__stop_async(struct fsmonitor_daemon_state *state)
> +{
> +}
> diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc=
-darwin.c
> index 6f3a95410cc..4c3c92081ee 100644
> --- a/compat/fsmonitor/fsm-ipc-darwin.c
> +++ b/compat/fsmonitor/fsm-ipc-darwin.c
> @@ -1,56 +1 @@
> -#include "git-compat-util.h"
> -#include "config.h"
> -#include "gettext.h"
> -#include "hex.h"
> -#include "path.h"
> -#include "repository.h"
> -#include "strbuf.h"
> -#include "fsmonitor-ll.h"
> -#include "fsmonitor-ipc.h"
> -#include "fsmonitor-path-utils.h"
> -
> -static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon=
=2Eipc")
> -
> -const char *fsmonitor_ipc__get_path(struct repository *r)
> -{
> -	static const char *ipc_path =3D NULL;
> -	git_SHA_CTX sha1ctx;
> -	char *sock_dir =3D NULL;
> -	struct strbuf ipc_file =3D STRBUF_INIT;
> -	unsigned char hash[GIT_MAX_RAWSZ];
> -
> -	if (!r)
> -		BUG("No repository passed into fsmonitor_ipc__get_path");
> -
> -	if (ipc_path)
> -		return ipc_path;
> -
> -
> -	/* By default the socket file is created in the .git directory */
> -	if (fsmonitor__is_fs_remote(r->gitdir) < 1) {
> -		ipc_path =3D fsmonitor_ipc__get_default_path();
> -		return ipc_path;
> -	}
> -
> -	git_SHA1_Init(&sha1ctx);
> -	git_SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
> -	git_SHA1_Final(hash, &sha1ctx);
> -
> -	repo_config_get_string(r, "fsmonitor.socketdir", &sock_dir);
> -
> -	/* Create the socket file in either socketDir or $HOME */
> -	if (sock_dir && *sock_dir) {
> -		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
> -					sock_dir, hash_to_hex(hash));
> -	} else {
> -		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));
> -	}
> -	free(sock_dir);
> -
> -	ipc_path =3D interpolate_path(ipc_file.buf, 1);
> -	if (!ipc_path)
> -		die(_("Invalid path: %s"), ipc_file.buf);
> -
> -	strbuf_release(&ipc_file);
> -	return ipc_path;
> -}
> +#include "fsm-ipc-unix.c"
> diff --git a/compat/fsmonitor/fsm-ipc-linux.c b/compat/fsmonitor/fsm-ipc-=
linux.c
> new file mode 100644
> index 00000000000..4c3c92081ee
> --- /dev/null
> +++ b/compat/fsmonitor/fsm-ipc-linux.c
> @@ -0,0 +1 @@
> +#include "fsm-ipc-unix.c"
> diff --git a/compat/fsmonitor/fsm-ipc-unix.c b/compat/fsmonitor/fsm-ipc-u=
nix.c
> new file mode 100644
> index 00000000000..eb25123fa12
> --- /dev/null
> +++ b/compat/fsmonitor/fsm-ipc-unix.c
> @@ -0,0 +1,53 @@
> +#include "cache.h"
> +#include "config.h"
> +#include "hex.h"
> +#include "strbuf.h"
> +#include "fsmonitor.h"
> +#include "fsmonitor-ipc.h"
> +#include "fsmonitor-path-utils.h"
> +
> +static GIT_PATH_FUNC(fsmonitor_ipc__get_default_path, "fsmonitor--daemon=
=2Eipc")
> +
> +const char *fsmonitor_ipc__get_path(struct repository *r)
> +{
> +	static const char *ipc_path =3D NULL;
> +	git_SHA_CTX sha1ctx;
> +	char *sock_dir =3D NULL;
> +	struct strbuf ipc_file =3D STRBUF_INIT;
> +	unsigned char hash[GIT_MAX_RAWSZ];
> +
> +	if (!r)
> +		BUG("No repository passed into fsmonitor_ipc__get_path");
> +
> +	if (ipc_path)
> +		return ipc_path;
> +
> +
> +	/* By default the socket file is created in the .git directory */
> +	if (fsmonitor__is_fs_remote(r->gitdir) < 1) {
> +		ipc_path =3D fsmonitor_ipc__get_default_path();
> +		return ipc_path;
> +	}
> +
> +	git_SHA1_Init(&sha1ctx);
> +	git_SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
> +	git_SHA1_Final(hash, &sha1ctx);
> +
> +	repo_config_get_string(r, "fsmonitor.socketdir", &sock_dir);
> +
> +	/* Create the socket file in either socketDir or $HOME */
> +	if (sock_dir && *sock_dir) {
> +		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
> +					sock_dir, hash_to_hex(hash));
> +	} else {
> +		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));
> +	}
> +	free(sock_dir);
> +
> +	ipc_path =3D interpolate_path(ipc_file.buf, 1);
> +	if (!ipc_path)
> +		die(_("Invalid path: %s"), ipc_file.buf);
> +
> +	strbuf_release(&ipc_file);
> +	return ipc_path;
> +}
> diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fs=
m-settings-darwin.c
> index a3825906351..14baf9f0603 100644
> --- a/compat/fsmonitor/fsm-settings-darwin.c
> +++ b/compat/fsmonitor/fsm-settings-darwin.c
> @@ -1,63 +1 @@
> -#include "git-compat-util.h"
> -#include "config.h"
> -#include "fsmonitor-ll.h"
> -#include "fsmonitor-ipc.h"
> -#include "fsmonitor-settings.h"
> -#include "fsmonitor-path-utils.h"
> -
> - /*
> - * For the builtin FSMonitor, we create the Unix domain socket for the
> - * IPC in the .git directory.  If the working directory is remote,
> - * then the socket will be created on the remote file system.  This
> - * can fail if the remote file system does not support UDS file types
> - * (e.g. smbfs to a Windows server) or if the remote kernel does not
> - * allow a non-local process to bind() the socket.  (These problems
> - * could be fixed by moving the UDS out of the .git directory and to a
> - * well-known local directory on the client machine, but care should
> - * be taken to ensure that $HOME is actually local and not a managed
> - * file share.)
> - *
> - * FAT32 and NTFS working directories are problematic too.
> - *
> - * The builtin FSMonitor uses a Unix domain socket in the .git
> - * directory for IPC.  These Windows drive formats do not support
> - * Unix domain sockets, so mark them as incompatible for the daemon.
> - *
> - */
> -static enum fsmonitor_reason check_uds_volume(struct repository *r)
> -{
> -	struct fs_info fs;
> -	const char *ipc_path =3D fsmonitor_ipc__get_path(r);
> -	struct strbuf path =3D STRBUF_INIT;
> -	strbuf_add(&path, ipc_path, strlen(ipc_path));
> -
> -	if (fsmonitor__get_fs_info(dirname(path.buf), &fs) =3D=3D -1) {
> -		strbuf_release(&path);
> -		return FSMONITOR_REASON_ERROR;
> -	}
> -
> -	strbuf_release(&path);
> -
> -	if (fs.is_remote ||
> -		!strcmp(fs.typename, "msdos") ||
> -		!strcmp(fs.typename, "ntfs")) {
> -		free(fs.typename);
> -		return FSMONITOR_REASON_NOSOCKETS;
> -	}
> -
> -	free(fs.typename);
> -	return FSMONITOR_REASON_OK;
> -}
> -
> -enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
> -{
> -	enum fsmonitor_reason reason;
> -
> -	if (ipc) {
> -		reason =3D check_uds_volume(r);
> -		if (reason !=3D FSMONITOR_REASON_OK)
> -			return reason;
> -	}
> -
> -	return FSMONITOR_REASON_OK;
> -}
> +#include "fsm-settings-unix.c"
> diff --git a/compat/fsmonitor/fsm-settings-linux.c b/compat/fsmonitor/fsm=
-settings-linux.c
> new file mode 100644
> index 00000000000..14baf9f0603
> --- /dev/null
> +++ b/compat/fsmonitor/fsm-settings-linux.c
> @@ -0,0 +1 @@
> +#include "fsm-settings-unix.c"
> diff --git a/compat/fsmonitor/fsm-settings-unix.c b/compat/fsmonitor/fsm-=
settings-unix.c
> new file mode 100644
> index 00000000000..d16dca89416
> --- /dev/null
> +++ b/compat/fsmonitor/fsm-settings-unix.c
> @@ -0,0 +1,61 @@
> +#include "fsmonitor.h"
> +#include "fsmonitor-ipc.h"
> +#include "fsmonitor-path-utils.h"
> +
> + /*
> + * For the builtin FSMonitor, we create the Unix domain socket for the
> + * IPC in the .git directory.  If the working directory is remote,
> + * then the socket will be created on the remote file system.  This
> + * can fail if the remote file system does not support UDS file types
> + * (e.g. smbfs to a Windows server) or if the remote kernel does not
> + * allow a non-local process to bind() the socket.  (These problems
> + * could be fixed by moving the UDS out of the .git directory and to a
> + * well-known local directory on the client machine, but care should
> + * be taken to ensure that $HOME is actually local and not a managed
> + * file share.)
> + *
> + * FAT32 and NTFS working directories are problematic too.
> + *
> + * The builtin FSMonitor uses a Unix domain socket in the .git
> + * directory for IPC.  These Windows drive formats do not support
> + * Unix domain sockets, so mark them as incompatible for the daemon.
> + *
> + */
> +static enum fsmonitor_reason check_uds_volume(struct repository *r)
> +{
> +	struct fs_info fs;
> +	const char *ipc_path =3D fsmonitor_ipc__get_path(r);
> +	struct strbuf path =3D STRBUF_INIT;
> +	strbuf_addstr(&path, ipc_path);
> +
> +	if (fsmonitor__get_fs_info(dirname(path.buf), &fs) =3D=3D -1) {
> +		free(fs.typename);
> +		strbuf_release(&path);
> +		return FSMONITOR_REASON_ERROR;
> +	}
> +
> +	strbuf_release(&path);
> +
> +	if (fs.is_remote ||
> +		!strcmp(fs.typename, "msdos") ||
> +		!strcmp(fs.typename, "ntfs")) {
> +		free(fs.typename);
> +		return FSMONITOR_REASON_NOSOCKETS;
> +	}
> +
> +	free(fs.typename);
> +	return FSMONITOR_REASON_OK;
> +}
> +
> +enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
> +{
> +	enum fsmonitor_reason reason;
> +
> +	if (ipc) {
> +		reason =3D check_uds_volume(r);
> +		if (reason !=3D FSMONITOR_REASON_OK)
> +			return reason;
> +	}
> +
> +	return FSMONITOR_REASON_OK;
> +}
> --=20
> gitgitgadget
>=20
>=20

--AAqU0H4QVnW9TIQv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXOFmEACgkQVbJhu7ck
PpStgg/+LDPYBXjrJxTwTwMn8MkIxerPW+4BzDarW3u/3xI00o18V3U8TSCltk7Z
DyajFk5tHduspftCqtbzCSOwGGdEefMVNsvFBXPKaEPsSrZ8FWshAYX9+iDzFXrV
L3cagwWasGwlEXkOMTm2+LUxkgeMgX2880F542cI8QSTruulXqBxUaN9TLi7FwgK
cGkXjSHBVLr5jnzZLo3DwehDLem6AvnWWhM1zYs/fE6iRz4uhLrPqYQ26FnsAO51
F0uIfUwQRciXn6vk31iuNCHKofxG3Z4v+b5aNjhdBA0LdgXde1UrXbnaiFXvfeeP
1sMBB8trFnLWz71ojT5CYT7Yk8XC/3SjKCDyltI6FMsDt/E4NDzzJHrPbQlxHjvu
W9xLfkLEhDLbUI0MDAI35gdNRJtqkfXO2JQS5h/gkmxwZPPsLISAoBCGlTS8rV01
W3Moix4dZoDcuVbXepRxev5VvsyuxmIPhKNosJUJ+1r/euaRYP+nPlBKOeHolQPJ
P7qhmD1HXi7GjysEltsEKwXHkNPulhDh1t/j6JcBOGsa+w1f765rRwFoglX2UAim
3o20Gs1+1Rwex9EHgXxKA+ngm9BqMlPajMdlbtM6iggUaV3o9KxFA8fVR5f9+iyE
Ur9gWtzB90Ji281RBrQMtpjR6K16poFWITw4FwWpkt9yB1Ha2Qo=
=WVhG
-----END PGP SIGNATURE-----

--AAqU0H4QVnW9TIQv--
