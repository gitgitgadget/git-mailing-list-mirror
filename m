Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05D3C433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 07:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241796AbiCPHc3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 03:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbiCPHc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 03:32:28 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BA933EBC
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 00:31:14 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D577B3201FD6;
        Wed, 16 Mar 2022 03:31:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 16 Mar 2022 03:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=1lv2jstDO5TE3ZZbiJ/8vQGF3bU16ovzSVgBl/
        sVcis=; b=EIE1lsLKM1EusqVtk4hVUHa8GmhsCyJ1Ce8AkkuxV5RhRDWJn70xwZ
        VVrwQk8YEEzy/kgOF9We0sL/Ur7nGIBMrbbgjTc7e0RzxQqth9tlUj4LGND3zSP5
        UlivsJzHBBFRq5C049n0qhfBCbKj0BcgaFVMU36Yjc6W8QpB0xoNQHxc3iFGh+Xq
        /uy6CHxA+q8Xp0UjSIvxv9OjomQqRPDA0/8T8rmAeBzsievaOp/FGcZhkPxPY7nd
        wx1/lAbKax32wLj8oieJyGikAyHR5F/FYgBiKSLjjrnkWc7Is0V2lV9Dclbqf/j1
        KJmxyAAPm08+cBL//2mromPXO/nqi91g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=1lv2jstDO5TE3ZZbi
        J/8vQGF3bU16ovzSVgBl/sVcis=; b=hvoMSnkjjsDCw+u37hYbZ5lGAPTLc8oHN
        pgYAKyBwnmE2ShLK5YTu+3XH0Mmnaf2ELy4+MHWZR6q/ohdsMg3Q8DbMFq1YUIIB
        2G5zQTEhD+85W8VHXd7V4Zq35QCAfoHENXTIP+5nf0d0m2F3HJR75pqTPupUWp5+
        v9sTAh05uc9yQS3B8SNI+yBw8j/dr/Q92e3xH5A8lBK0EwHZxKtgXHUFWKTZ1rKf
        bUhUxrTnHpvQDduAZ2+BuMNQIABRIHlKeoVukK6I7J2LcKqQV3V9bxi8PFqU4QJt
        IXQqDX4T2Oq/NqQjAR/5VC/ZbkrE1hnkViX6e6wJwXRnRCCiOz7NQ==
X-ME-Sender: <xms:P5IxYjEyF-eQ_Idk_Ub7o_LYn-YbkXqrfavAjP1MPvcMd3GQM71TYA>
    <xme:P5IxYgWBGkclatCYq1kw6nVwLhVNEc5KDlUs2bgktvc-NLQGUAStmxLHnzxLaa3RG
    rjfZol7YUEGuoLOWg>
X-ME-Received: <xmr:P5IxYlLFL1SV_kcxY77XXhendhCOqC-o4emcsbdMETwW-kPVe3ND8lIh-8uxsW3sMg_6A3EmE764efxDwcAeLHq8xqLValvl9XY0LUmDoKCwe6G5BAtFXwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefuddguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:P5IxYhEcGgzZZIoxjc5I--D441NCZ6Otscin1tiR9rVR0aWP2qQ9Xg>
    <xmx:P5IxYpX9RHaSYCi0GNdNNaCFI1jVI6mE1uGhY1hsF-FPMLmKMPpikg>
    <xmx:P5IxYsNydtNIn0Hu60a0AcTu2-OXj0aycAAGYvI-fHycE83aA5k1sA>
    <xmx:P5IxYvzTad-HPaTx5TVr7mn2xmikOtaN0G7z3dlHaNFmBF1u87N9-Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Mar 2022 03:31:10 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 338af619 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Mar 2022 07:31:05 +0000 (UTC)
Date:   Wed, 16 Mar 2022 08:31:04 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        nksingh85@gmail.com, "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH 2/7] core.fsyncmethod: batched disk flushes for
 loose-objects
Message-ID: <YjGSOJlZnDSske3s@ncase>
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <d38f20b4430bada1d0dccc1e600e6f0b098f3767.1647379859.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hvFco3wl5duwUMfN"
Content-Disposition: inline
In-Reply-To: <d38f20b4430bada1d0dccc1e600e6f0b098f3767.1647379859.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hvFco3wl5duwUMfN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 15, 2022 at 09:30:54PM +0000, Neeraj Singh via GitGitGadget wro=
te:
> From: Neeraj Singh <neerajsi@microsoft.com>
>=20
> When adding many objects to a repo with `core.fsync=3Dloose-object`,
> the cost of fsync'ing each object file can become prohibitive.
>=20
> One major source of the cost of fsync is the implied flush of the
> hardware writeback cache within the disk drive. This commit introduces
> a new `core.fsyncMethod=3Dbatch` option that batches up hardware flushes.
> It hooks into the bulk-checkin plugging and unplugging functionality,
> takes advantage of tmp-objdir, and uses the writeout-only support code.
>=20
> When the new mode is enabled, we do the following for each new object:
> 1. Create the object in a tmp-objdir.
> 2. Issue a pagecache writeback request and wait for it to complete.
>=20
> At the end of the entire transaction when unplugging bulk checkin:
> 1. Issue an fsync against a dummy file to flush the hardware writeback
>    cache, which should by now have seen the tmp-objdir writes.
> 2. Rename all of the tmp-objdir files to their final names.
> 3. When updating the index and/or refs, we assume that Git will issue
>    another fsync internal to that operation. This is not the default
>    today, but the user now has the option of syncing the index and there
>    is a separate patch series to implement syncing of refs.
>=20
> On a filesystem with a singular journal that is updated during name
> operations (e.g. create, link, rename, etc), such as NTFS, HFS+, or XFS
> we would expect the fsync to trigger a journal writeout so that this
> sequence is enough to ensure that the user's data is durable by the time
> the git command returns.
>=20
> Batch mode is only enabled if core.fsyncObjectFiles is false or unset.
>=20
> _Performance numbers_:
>=20
> Linux - Hyper-V VM running Kernel 5.11 (Ubuntu 20.04) on a fast SSD.
> Mac - macOS 11.5.1 running on a Mac mini on a 1TB Apple SSD.
> Windows - Same host as Linux, a preview version of Windows 11.
>=20
> Adding 500 files to the repo with 'git add' Times reported in seconds.
>=20
> object file syncing | Linux | Mac   | Windows
> --------------------|-------|-------|--------
>            disabled | 0.06  |  0.35 | 0.61
>               fsync | 1.88  | 11.18 | 2.47
>               batch | 0.15  |  0.41 | 1.53
>=20
> Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> ---
>  Documentation/config/core.txt |  5 +++
>  bulk-checkin.c                | 67 +++++++++++++++++++++++++++++++++++
>  bulk-checkin.h                |  2 ++
>  cache.h                       |  8 ++++-
>  config.c                      |  2 ++
>  object-file.c                 |  2 ++
>  6 files changed, 85 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
> index 062e5259905..c041ed33801 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -628,6 +628,11 @@ core.fsyncMethod::
>  * `writeout-only` issues pagecache writeback requests, but depending on =
the
>    filesystem and storage hardware, data added to the repository may not =
be
>    durable in the event of a system crash. This is the default mode on ma=
cOS.
> +* `batch` enables a mode that uses writeout-only flushes to stage multip=
le
> +  updates in the disk writeback cache and then a single full fsync to tr=
igger
> +  the disk cache flush at the end of the operation. This mode is expecte=
d to
> +  be as safe as `fsync` on macOS for repos stored on HFS+ or APFS filesy=
stems
> +  and on Windows for repos stored on NTFS or ReFS filesystems.

This mode will not be supported by all parts of our stack that use our
new fsync infra. So I think we should both document that some parts of
the stack don't support batching, and say what the fallback behaviour is
for those that don't.

>  core.fsyncObjectFiles::
>  	This boolean will enable 'fsync()' when writing object files.
> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 93b1dc5138a..5c13fe17802 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -3,14 +3,20 @@
>   */
>  #include "cache.h"
>  #include "bulk-checkin.h"
> +#include "lockfile.h"
>  #include "repository.h"
>  #include "csum-file.h"
>  #include "pack.h"
>  #include "strbuf.h"
> +#include "string-list.h"
> +#include "tmp-objdir.h"
>  #include "packfile.h"
>  #include "object-store.h"
> =20
>  static int bulk_checkin_plugged;
> +static int needs_batch_fsync;
> +
> +static struct tmp_objdir *bulk_fsync_objdir;
> =20
>  static struct bulk_checkin_state {
>  	char *pack_tmp_name;
> @@ -80,6 +86,34 @@ clear_exit:
>  	reprepare_packed_git(the_repository);
>  }
> =20
> +/*
> + * Cleanup after batch-mode fsync_object_files.
> + */
> +static void do_batch_fsync(void)
> +{
> +	/*
> +	 * Issue a full hardware flush against a temporary file to ensure
> +	 * that all objects are durable before any renames occur.  The code in
> +	 * fsync_loose_object_bulk_checkin has already issued a writeout
> +	 * request, but it has not flushed any writeback cache in the storage
> +	 * hardware.
> +	 */
> +
> +	if (needs_batch_fsync) {
> +		struct strbuf temp_path =3D STRBUF_INIT;
> +		struct tempfile *temp;
> +
> +		strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX", get_object_directory()=
);
> +		temp =3D xmks_tempfile(temp_path.buf);
> +		fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
> +		delete_tempfile(&temp);
> +		strbuf_release(&temp_path);
> +	}
> +
> +	if (bulk_fsync_objdir)
> +		tmp_objdir_migrate(bulk_fsync_objdir);
> +}
> +

We never unset `bulk_fsync_objdir` anywhere. Shouldn't we be doing that
when we unplug this infrastructure?

Patrick

>  static int already_written(struct bulk_checkin_state *state, struct obje=
ct_id *oid)
>  {
>  	int i;
> @@ -274,6 +308,24 @@ static int deflate_to_pack(struct bulk_checkin_state=
 *state,
>  	return 0;
>  }
> =20
> +void fsync_loose_object_bulk_checkin(int fd)
> +{
> +	/*
> +	 * If we have a plugged bulk checkin, we issue a call that
> +	 * cleans the filesystem page cache but avoids a hardware flush
> +	 * command. Later on we will issue a single hardware flush
> +	 * before as part of do_batch_fsync.
> +	 */
> +	if (bulk_checkin_plugged &&
> +	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) >=3D 0) {
> +		assert(bulk_fsync_objdir);
> +		if (!needs_batch_fsync)
> +			needs_batch_fsync =3D 1;
> +	} else {
> +		fsync_or_die(fd, "loose object file");
> +	}
> +}
> +
>  int index_bulk_checkin(struct object_id *oid,
>  		       int fd, size_t size, enum object_type type,
>  		       const char *path, unsigned flags)
> @@ -288,6 +340,19 @@ int index_bulk_checkin(struct object_id *oid,
>  void plug_bulk_checkin(void)
>  {
>  	assert(!bulk_checkin_plugged);
> +
> +	/*
> +	 * A temporary object directory is used to hold the files
> +	 * while they are not fsynced.
> +	 */
> +	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT)) {
> +		bulk_fsync_objdir =3D tmp_objdir_create("bulk-fsync");
> +		if (!bulk_fsync_objdir)
> +			die(_("Could not create temporary object directory for core.fsyncobje=
ctfiles=3Dbatch"));
> +
> +		tmp_objdir_replace_primary_odb(bulk_fsync_objdir, 0);
> +	}
> +
>  	bulk_checkin_plugged =3D 1;
>  }
> =20
> @@ -297,4 +362,6 @@ void unplug_bulk_checkin(void)
>  	bulk_checkin_plugged =3D 0;
>  	if (bulk_checkin_state.f)
>  		finish_bulk_checkin(&bulk_checkin_state);
> +
> +	do_batch_fsync();
>  }
> diff --git a/bulk-checkin.h b/bulk-checkin.h
> index b26f3dc3b74..08f292379b6 100644
> --- a/bulk-checkin.h
> +++ b/bulk-checkin.h
> @@ -6,6 +6,8 @@
> =20
>  #include "cache.h"
> =20
> +void fsync_loose_object_bulk_checkin(int fd);
> +
>  int index_bulk_checkin(struct object_id *oid,
>  		       int fd, size_t size, enum object_type type,
>  		       const char *path, unsigned flags);
> diff --git a/cache.h b/cache.h
> index d347d0757f7..4d07691e791 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1040,7 +1040,8 @@ extern int use_fsync;
> =20
>  enum fsync_method {
>  	FSYNC_METHOD_FSYNC,
> -	FSYNC_METHOD_WRITEOUT_ONLY
> +	FSYNC_METHOD_WRITEOUT_ONLY,
> +	FSYNC_METHOD_BATCH
>  };
> =20
>  extern enum fsync_method fsync_method;
> @@ -1766,6 +1767,11 @@ void fsync_or_die(int fd, const char *);
>  int fsync_component(enum fsync_component component, int fd);
>  void fsync_component_or_die(enum fsync_component component, int fd, cons=
t char *msg);
> =20
> +static inline int batch_fsync_enabled(enum fsync_component component)
> +{
> +	return (fsync_components & component) && (fsync_method =3D=3D FSYNC_MET=
HOD_BATCH);
> +}
> +
>  ssize_t read_in_full(int fd, void *buf, size_t count);
>  ssize_t write_in_full(int fd, const void *buf, size_t count);
>  ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
> diff --git a/config.c b/config.c
> index 261ee7436e0..0b28f90de8b 100644
> --- a/config.c
> +++ b/config.c
> @@ -1688,6 +1688,8 @@ static int git_default_core_config(const char *var,=
 const char *value, void *cb)
>  			fsync_method =3D FSYNC_METHOD_FSYNC;
>  		else if (!strcmp(value, "writeout-only"))
>  			fsync_method =3D FSYNC_METHOD_WRITEOUT_ONLY;
> +		else if (!strcmp(value, "batch"))
> +			fsync_method =3D FSYNC_METHOD_BATCH;
>  		else
>  			warning(_("ignoring unknown core.fsyncMethod value '%s'"), value);
> =20
> diff --git a/object-file.c b/object-file.c
> index 295cb899e22..ef6621ffe56 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1894,6 +1894,8 @@ static void close_loose_object(int fd)
> =20
>  	if (fsync_object_files > 0)
>  		fsync_or_die(fd, "loose object file");
> +	else if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
> +		fsync_loose_object_bulk_checkin(fd);
>  	else
>  		fsync_component_or_die(FSYNC_COMPONENT_LOOSE_OBJECT, fd,
>  				       "loose object file");
> --=20
> gitgitgadget
>=20

--hvFco3wl5duwUMfN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIxkjcACgkQVbJhu7ck
PpQQrA//WRlqho7z0uRZmiTb8VZ9Yo1m47GlUGVGAd63GhT2hacvWOSjhoNPb0gO
a3hZPqUI7qN1ZQlj9omY4aNP59Pvrxp9Lgd6QNvx4VEyO+aeh5IDoYuyINsSnCzc
SDrQ+v3VCYhmXY7Ah8AE0k837PdW4tEmvI7a2sQ11eID5MwvpfVl8nhyhmP6C4KV
M/Ojzo5PasVrOe9iyQaNGHRC3ucfB2wloOXvP2a2JpLO6j0SLlbHMjj5KtEt4sug
zc9Qh6rAROz77stf8KT+j3RFO0wNv52JuAb5CoXRisiSVXj0ngnqckDIHrmaxBuY
RJovPuBpsXwDA6lSRT2IfUEUtEjsBWkzFPSUd60W1On8Vdh02e3V5vZjnkt+5YWP
x/EDBDyM6CIgTDaujzdpHd+MTPetHAvI8uBwBuaYWtW1qHS2C9qsTyYGBXnc980H
FQOMphJ/ObtO7Lveer5CU6ylRC9Vs0ekELxJL137u0V0WQXsqZ7hi22DuzUkz2fr
BSgoSlenDOfT2vh/1kncfocX0ihnzHpcRqMyY6IewbpRytiwEOH/wN+F5nj0oYcu
qxFCqFZkh39N8ApvtjePGkkT0/WxKJpAqmqXx9g01Ay7BZtvOUE0RxYcHFQJZm6Y
f7kekliRfAIJkXNp9LWlOgV4gv27cqVs1ZiOwXWNY1oSi+mzxOo=
=yfBP
-----END PGP SIGNATURE-----

--hvFco3wl5duwUMfN--
