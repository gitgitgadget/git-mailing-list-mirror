Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDFEC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 11:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbhLGMAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 07:00:41 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:56471 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235916AbhLGMAi (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Dec 2021 07:00:38 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 8A9D05C01BF;
        Tue,  7 Dec 2021 06:57:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 07 Dec 2021 06:57:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=yTsM3ChADsA5R3oEkE8Z0fFEibu
        sT5IwxdPJ20ZBAPc=; b=UhDJUQ4YQVs5U8Td4lQkxawGtZBKH8vrjqCtzyd5AP+
        CA73mS6/w5yDTO429wHJgYnhC418U8HaYO6/ollRFuZ3DjjQhpC1j+ZZdSCVliVx
        R1RuMXea5jbWV9aID1ejLXdnlaAEyps8gkUXnUFtWOGw9BsIVfCGHJMidH4QIbpe
        6X7k8keBrXyLD6o0JG5MDYEXrYh+Thm+7uSOr+NTGxg3kx+TJE6IydpId94EuhE5
        G8+ARn8lTR26X8stuAnQSXIRp5TQH7MhFfuxtyByDSfwJD3MXqkn+vnvCL5f5ZJX
        afwNb7qwL5fJEQ8Bz9U0nLL27yXFt9pMP6erSKtfx4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=yTsM3C
        hADsA5R3oEkE8Z0fFEibusT5IwxdPJ20ZBAPc=; b=c6Sr4fmu6wnoQfnAghu8UP
        g0rrr4YoVHWLPoUDyre9SI4zyl49zIBFnhuhOaH+lwp9fJU86beuWeWcQuO9Y6Wr
        OPSYRk0MaTH1lRHq5z7Rg3xdh+ZhBmp5k/TmZFXUQ31nOKbDzJPaZoVkMlb22Cgb
        heWgC3Vq+23kwX3ioIuBD/RVVUIuQbvgyM9zCuSz0ZboWqQcJfWS4LOqJmdStcm3
        uip+3WDjYAvHl/GSkY5kDxgqZlfh09/iEGPFTaWP8MAM0ihe6/wR5oh+6NHY++r3
        q8kOOKzEOfDrWHkXyv3f5hJgDRnHeJv3U1DvmrP9bgay0OJSMO7IiXCb9LvzLatw
        ==
X-ME-Sender: <xms:EkyvYXNEn4kcGByamPANFHhfrLyQ9m5CqAu_S2N3aAZ-HrIsKsa8fA>
    <xme:EkyvYR-TSczu3jqff-trFRzfEg4QTE2uNbj5bf0zeiI5NxmRchtgt6ny7bBYcNP9O
    reZ5_h9Q35Ddv_7SQ>
X-ME-Received: <xmr:EkyvYWTWdY9hVcEOL4PSSP43bDI7W4n8BzzcwT87RjgF1H4ivPpW1KjZ8Gf531ynVaiyniEUCi7Ifklnj37snnQP7RVZbhxQtMxVoym5do2PYtJbJWQ-rUZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeehgdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epgeffgfefudevhfehveffgedvleekkeehueffveekffdtfeefkedvteeiveehleevnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:EkyvYbuM3ZSP3h-pFmkA7BdWc_t5AJ1FmhpupMw40yj6-sIcEdzc4g>
    <xmx:EkyvYfexbJFtnewG7edIbSGbQ-Ouom-Txi7WQyWbyhFljAZpBR4OzQ>
    <xmx:EkyvYX1MxlXhRXcB2PLBycDXiiHEv4OcT_I1PhYbTMkiIUVe0DDAfQ>
    <xmx:EkyvYXSsgv9Yl_Scte5DhijjxEDysgogjGbcpjLSc5rK77i4NT3UVA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Dec 2021 06:57:05 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 5fdc8190 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 7 Dec 2021 13:26:37 +0000 (UTC)
Date:   Tue, 7 Dec 2021 12:56:20 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com, bagasdotme@gmail.com,
        newren@gmail.com, avarab@gmail.com, nksingh85@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 0/3] A design for future-proofing fsync() configuration
Message-ID: <Ya9L5GJqlBF1YEk2@ncase>
References: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
 <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jJsNv0ui80iiTX3C"
Content-Disposition: inline
In-Reply-To: <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jJsNv0ui80iiTX3C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 07, 2021 at 02:46:48AM +0000, Neeraj K. Singh via GitGitGadget =
wrote:
> This is an implementation of an extensible configuration mechanism for
> fsyncing persistent components of a repo.
>=20
> The main goals are to separate the "what" to sync from the "how". There a=
re
> now two settings: core.fsync - Control the 'what', including the index.
> core.fsyncMethod - Control the 'how'. Currently we support writeout-only =
and
> full fsync.
>=20
> Syncing of refs can be layered on top of core.fsync. And batch mode will =
be
> layered on core.fsyncMethod.
>=20
> core.fsyncobjectfiles is removed and will issue a deprecation warning if
> it's seen.
>=20
> I'd like to get agreement on this direction before submitting batch mode =
to
> the list. The batch mode series is available to view at
> https://github.com/neerajsi-msft/git/pull/1.
>=20
> Please see [1], [2], and [3] for discussions that led to this series.
>=20
> V2 changes:
>=20
>  * Updated the documentation for core.fsyncmethod to be less certain.
>    writeout-only probably does not do the right thing on Linux.
>  * Split out the core.fsync=3Dindex change into its own commit.
>  * Rename REPO_COMPONENT to FSYNC_COMPONENT. This is really specific to
>    fsyncing, so the name should reflect that.
>  * Re-add missing Makefile change for SYNC_FILE_RANGE.
>  * Tested writeout-only mode, index syncing, and general config settings.
>=20
> [1] https://lore.kernel.org/git/211110.86r1bogg27.gmgdl@evledraar.gmail.c=
om/
> [2]
> https://lore.kernel.org/git/dd65718814011eb93ccc4428f9882e0f025224a6.1636=
029491.git.ps@pks.im/
> [3]
> https://lore.kernel.org/git/pull.1076.git.git.1629856292.gitgitgadget@gma=
il.com/

While I bail from the question of whether we want to grant as much
configurability to the user as this patch series does, I quite like the
implementation. It feels rather straight-forward and it's easy to see
how to extend it to support syncing of other subsystems like the loose
refs.

Thanks!

Patrick

> Neeraj Singh (3):
>   core.fsyncmethod: add writeout-only mode
>   core.fsync: introduce granular fsync control
>   core.fsync: new option to harden the index
>=20
>  Documentation/config/core.txt       | 35 +++++++++---
>  Makefile                            |  6 ++
>  builtin/fast-import.c               |  2 +-
>  builtin/index-pack.c                |  4 +-
>  builtin/pack-objects.c              |  8 ++-
>  bulk-checkin.c                      |  5 +-
>  cache.h                             | 48 +++++++++++++++-
>  commit-graph.c                      |  3 +-
>  compat/mingw.h                      |  3 +
>  compat/win32/flush.c                | 28 +++++++++
>  config.c                            | 89 ++++++++++++++++++++++++++++-
>  config.mak.uname                    |  3 +
>  configure.ac                        |  8 +++
>  contrib/buildsystems/CMakeLists.txt |  3 +-
>  csum-file.c                         |  5 +-
>  csum-file.h                         |  3 +-
>  environment.c                       |  3 +-
>  git-compat-util.h                   | 24 ++++++++
>  midx.c                              |  3 +-
>  object-file.c                       |  3 +-
>  pack-bitmap-write.c                 |  3 +-
>  pack-write.c                        | 13 +++--
>  read-cache.c                        | 19 ++++--
>  wrapper.c                           | 56 ++++++++++++++++++
>  write-or-die.c                      | 10 ++--
>  25 files changed, 344 insertions(+), 43 deletions(-)
>  create mode 100644 compat/win32/flush.c
>=20
>=20
> base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1093%2F=
neerajsi-msft%2Fns%2Fcore-fsync-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1093/neera=
jsi-msft/ns/core-fsync-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1093
>=20
> Range-diff vs v1:
>=20
>  1:  527380ddc3f ! 1:  e79522cbdd4 fsync: add writeout-only mode for fsyn=
cing repo data
>      @@ Metadata
>       Author: Neeraj Singh <neerajsi@microsoft.com>
>      =20
>        ## Commit message ##
>      -    fsync: add writeout-only mode for fsyncing repo data
>      +    core.fsyncmethod: add writeout-only mode
>      +
>      +    This commit introduces the `core.fsyncmethod` configuration
>      +    knob, which can currently be set to `fsync` or `writeout-only`.
>      =20
>           The new writeout-only mode attempts to tell the operating syste=
m to
>           flush its in-memory page cache to the storage hardware without =
issuing a
>      @@ Documentation/config/core.txt: core.whitespace::
>       +	using fsync and related primitives.
>       ++
>       +* `fsync` uses the fsync() system call or platform equivalents.
>      -+* `writeout-only` issues requests to send the writes to the storage
>      -+  hardware, but does not send any FLUSH CACHE request. If the oper=
ating system
>      -+  does not support the required interfaces, this falls back to fsy=
nc().
>      ++* `writeout-only` issues pagecache writeback requests, but dependi=
ng on the
>      ++  filesystem and storage hardware, data added to the repository ma=
y not be
>      ++  durable in the event of a system crash. This is the default mode=
 on macOS.
>       +
>        core.fsyncObjectFiles::
>        	This boolean will enable 'fsync()' when writing object files.
>        +
>      =20
>      + ## Makefile ##
>      +@@ Makefile: all::
>      + #
>      + # Define HAVE_CLOCK_MONOTONIC if your platform has CLOCK_MONOTONIC.
>      + #
>      ++# Define HAVE_SYNC_FILE_RANGE if your platform has sync_file_range.
>      ++#
>      + # Define NEEDS_LIBRT if your platform requires linking with librt =
(glibc version
>      + # before 2.17) for clock_gettime and CLOCK_MONOTONIC.
>      + #
>      +@@ Makefile: ifdef HAVE_CLOCK_MONOTONIC
>      + 	BASIC_CFLAGS +=3D -DHAVE_CLOCK_MONOTONIC
>      + endif
>      +=20
>      ++ifdef HAVE_SYNC_FILE_RANGE
>      ++	BASIC_CFLAGS +=3D -DHAVE_SYNC_FILE_RANGE
>      ++endif
>      ++
>      + ifdef NEEDS_LIBRT
>      + 	EXTLIBS +=3D -lrt
>      + endif
>      +
>        ## cache.h ##
>       @@ cache.h: extern int read_replace_refs;
>        extern char *git_replace_ref_base;
>  2:  23311a10142 ! 2:  ff80a94bf9a core.fsync: introduce granular fsync c=
ontrol
>      @@ Commit message
>           knob which can be used to control how components of the
>           repository are made durable on disk.
>      =20
>      -    This setting allows future extensibility of components
>      -    that could be synced in two ways:
>      +    This setting allows future extensibility of the list of
>      +    syncable components:
>           * We issue a warning rather than an error for unrecognized
>             components, so new configs can be used with old Git versions.
>           * We support negation, so users can choose one of the default
>             aggregate options and then remove components that they don't
>      -      want.
>      +      want. The user would then harden any new components added in
>      +      a Git version update.
>      =20
>      -    This also support the common request of doing absolutely no
>      +    This also supports the common request of doing absolutely no
>           fysncing with the `core.fsync=3Dnone` value, which is expected
>           to make the test suite faster.
>      =20
>      -    This commit introduces the new ability for the user to harden
>      -    the index, which is a requirement for being able to actually
>      -    find a file that has been added to the repo and then deleted
>      -    from the working tree.
>      -
>           Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
>      =20
>        ## Documentation/config/core.txt ##
>      @@ Documentation/config/core.txt: core.whitespace::
>       +	hardened via the core.fsyncMethod when created or modified. You c=
an
>       +	disable hardening of any component by prefixing it with a '-'. La=
ter
>       +	items take precedence over earlier ones in the list. For example,
>      -+	`core.fsync=3Dall,-index` means "harden everything except the ind=
ex".
>      -+	Items that are not hardened may be lost in the event of an unclean
>      -+	system shutdown.
>      ++	`core.fsync=3Dall,-pack-metadata` means "harden everything except=
 pack
>      ++	metadata." Items that are not hardened may be lost in the event o=
f an
>      ++	unclean system shutdown.
>       ++
>       +* `none` disables fsync completely. This must be specified alone.
>       +* `loose-object` hardens objects added to the repo in loose-object=
 form.
>       +* `pack` hardens objects added to the repo in packfile form.
>       +* `pack-metadata` hardens packfile bitmaps and indexes.
>       +* `commit-graph` hardens the commit graph file.
>      -+* `index` hardens the index when it is modified.
>       +* `objects` is an aggregate option that includes `loose-objects`, =
`pack`,
>       +  `pack-metadata`, and `commit-graph`.
>       +* `default` is an aggregate option that is equivalent to `objects,=
-loose-object`
>      @@ Documentation/config/core.txt: core.whitespace::
>        	A value indicating the strategy Git will use to harden repository=
 data
>        	using fsync and related primitives.
>       @@ Documentation/config/core.txt: core.fsyncMethod::
>      -   hardware, but does not send any FLUSH CACHE request. If the oper=
ating system
>      -   does not support the required interfaces, this falls back to fsy=
nc().
>      +   filesystem and storage hardware, data added to the repository ma=
y not be
>      +   durable in the event of a system crash. This is the default mode=
 on macOS.
>       =20
>       -core.fsyncObjectFiles::
>       -	This boolean will enable 'fsync()' when writing object files.
>      @@ builtin/fast-import.c: static void end_packfile(void)
>       =20
>        		close_pack_windows(pack_data);
>       -		finalize_hashfile(pack_file, cur_pack_oid.hash, 0);
>      -+		finalize_hashfile(pack_file, cur_pack_oid.hash, REPO_COMPONENT_P=
ACK, 0);
>      ++		finalize_hashfile(pack_file, cur_pack_oid.hash, FSYNC_COMPONENT_=
PACK, 0);
>        		fixup_pack_header_footer(pack_data->pack_fd, pack_data->hash,
>        					 pack_data->pack_name, object_count,
>        					 cur_pack_oid.hash, pack_size);
>      @@ builtin/index-pack.c: static void conclude_pack(int fix_thin_pack=
, const char *c
>        		stop_progress_msg(&progress, msg.buf);
>        		strbuf_release(&msg);
>       -		finalize_hashfile(f, tail_hash, 0);
>      -+		finalize_hashfile(f, tail_hash, REPO_COMPONENT_PACK, 0);
>      ++		finalize_hashfile(f, tail_hash, FSYNC_COMPONENT_PACK, 0);
>        		hashcpy(read_hash, pack_hash);
>        		fixup_pack_header_footer(output_fd, pack_hash,
>        					 curr_pack, nr_objects,
>      @@ builtin/index-pack.c: static void final(const char *final_pack_na=
me, const char
>        		close(input_fd);
>        	} else {
>       -		fsync_or_die(output_fd, curr_pack_name);
>      -+		fsync_component_or_die(REPO_COMPONENT_PACK, output_fd, curr_pack=
_name);
>      ++		fsync_component_or_die(FSYNC_COMPONENT_PACK, output_fd, curr_pac=
k_name);
>        		err =3D close(output_fd);
>        		if (err)
>        			die_errno(_("error while closing pack file"));
>      @@ builtin/pack-objects.c: static void write_pack_file(void)
>        		 */
>        		if (pack_to_stdout) {
>       -			finalize_hashfile(f, hash, CSUM_HASH_IN_STREAM | CSUM_CLOSE);
>      -+			finalize_hashfile(f, hash, REPO_COMPONENT_NONE,
>      ++			finalize_hashfile(f, hash, FSYNC_COMPONENT_NONE,
>       +					  CSUM_HASH_IN_STREAM | CSUM_CLOSE);
>        		} else if (nr_written =3D=3D nr_remaining) {
>       -			finalize_hashfile(f, hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC | C=
SUM_CLOSE);
>      -+			finalize_hashfile(f, hash, REPO_COMPONENT_PACK,
>      ++			finalize_hashfile(f, hash, FSYNC_COMPONENT_PACK,
>       +					  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
>        		} else {
>       -			int fd =3D finalize_hashfile(f, hash, 0);
>      -+			int fd =3D finalize_hashfile(f, hash, REPO_COMPONENT_PACK, 0);
>      ++			int fd =3D finalize_hashfile(f, hash, FSYNC_COMPONENT_PACK, 0);
>        			fixup_pack_header_footer(fd, hash, pack_tmp_name,
>        						 nr_written, hash, offset);
>        			close(fd);
>      @@ bulk-checkin.c: static void finish_bulk_checkin(struct bulk_check=
in_state *state
>        		goto clear_exit;
>        	} else if (state->nr_written =3D=3D 1) {
>       -		finalize_hashfile(state->f, hash, CSUM_HASH_IN_STREAM | CSUM_FSY=
NC | CSUM_CLOSE);
>      -+		finalize_hashfile(state->f, hash, REPO_COMPONENT_PACK,
>      ++		finalize_hashfile(state->f, hash, FSYNC_COMPONENT_PACK,
>       +				  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
>        	} else {
>       -		int fd =3D finalize_hashfile(state->f, hash, 0);
>      -+		int fd =3D finalize_hashfile(state->f, hash, REPO_COMPONENT_PACK=
, 0);
>      ++		int fd =3D finalize_hashfile(state->f, hash, FSYNC_COMPONENT_PAC=
K, 0);
>        		fixup_pack_header_footer(fd, hash, state->pack_tmp_name,
>        					 state->nr_written, hash,
>        					 state->offset);
>      @@ cache.h: void reset_shared_repository(void);
>       -extern int fsync_object_files;
>       +/*
>       + * These values are used to help identify parts of a repository to=
 fsync.
>      -+ * REPO_COMPONENT_NONE identifies data that will not be a persiste=
nt part of the
>      ++ * FSYNC_COMPONENT_NONE identifies data that will not be a persist=
ent part of the
>       + * repository and so shouldn't be fsynced.
>       + */
>      -+enum repo_component {
>      -+	REPO_COMPONENT_NONE			=3D 0,
>      -+	REPO_COMPONENT_LOOSE_OBJECT		=3D 1 << 0,
>      -+	REPO_COMPONENT_PACK			=3D 1 << 1,
>      -+	REPO_COMPONENT_PACK_METADATA		=3D 1 << 2,
>      -+	REPO_COMPONENT_COMMIT_GRAPH		=3D 1 << 3,
>      -+	REPO_COMPONENT_INDEX			=3D 1 << 4,
>      ++enum fsync_component {
>      ++	FSYNC_COMPONENT_NONE			=3D 0,
>      ++	FSYNC_COMPONENT_LOOSE_OBJECT		=3D 1 << 0,
>      ++	FSYNC_COMPONENT_PACK			=3D 1 << 1,
>      ++	FSYNC_COMPONENT_PACK_METADATA		=3D 1 << 2,
>      ++	FSYNC_COMPONENT_COMMIT_GRAPH		=3D 1 << 3,
>       +};
>       +
>      -+#define FSYNC_COMPONENTS_DEFAULT (REPO_COMPONENT_PACK | \
>      -+				  REPO_COMPONENT_PACK_METADATA | \
>      -+				  REPO_COMPONENT_COMMIT_GRAPH)
>      ++#define FSYNC_COMPONENTS_DEFAULT (FSYNC_COMPONENT_PACK | \
>      ++				  FSYNC_COMPONENT_PACK_METADATA | \
>      ++				  FSYNC_COMPONENT_COMMIT_GRAPH)
>       +
>      -+#define FSYNC_COMPONENTS_OBJECTS (REPO_COMPONENT_LOOSE_OBJECT | \
>      -+				  REPO_COMPONENT_PACK | \
>      -+				  REPO_COMPONENT_PACK_METADATA | \
>      -+				  REPO_COMPONENT_COMMIT_GRAPH)
>      ++#define FSYNC_COMPONENTS_OBJECTS (FSYNC_COMPONENT_LOOSE_OBJECT | \
>      ++				  FSYNC_COMPONENT_PACK | \
>      ++				  FSYNC_COMPONENT_PACK_METADATA | \
>      ++				  FSYNC_COMPONENT_COMMIT_GRAPH)
>       +
>      -+#define FSYNC_COMPONENTS_ALL (REPO_COMPONENT_LOOSE_OBJECT | \
>      -+			      REPO_COMPONENT_PACK | \
>      -+			      REPO_COMPONENT_PACK_METADATA | \
>      -+			      REPO_COMPONENT_COMMIT_GRAPH | \
>      -+			      REPO_COMPONENT_INDEX)
>      ++#define FSYNC_COMPONENTS_ALL (FSYNC_COMPONENT_LOOSE_OBJECT | \
>      ++			      FSYNC_COMPONENT_PACK | \
>      ++			      FSYNC_COMPONENT_PACK_METADATA | \
>      ++			      FSYNC_COMPONENT_COMMIT_GRAPH)
>       +
>       +
>       +/*
>       + * A bitmask indicating which components of the repo should be fsy=
nced.
>       + */
>      -+extern enum repo_component fsync_components;
>      ++extern enum fsync_component fsync_components;
>       =20
>        enum fsync_method {
>        	FSYNC_METHOD_FSYNC,
>      @@ cache.h: int copy_file_with_time(const char *dst, const char *src=
, int mode);
>        void write_or_die(int fd, const void *buf, size_t count);
>        void fsync_or_die(int fd, const char *);
>       =20
>      -+inline void fsync_component_or_die(enum repo_component component, =
int fd, const char *msg)
>      ++inline void fsync_component_or_die(enum fsync_component component,=
 int fd, const char *msg)
>       +{
>       +	if (fsync_components & component)
>       +		fsync_or_die(fd, msg);
>      @@ commit-graph.c: static int write_commit_graph_file(struct write_c=
ommit_graph_con
>       =20
>        	close_commit_graph(ctx->r->objects);
>       -	finalize_hashfile(f, file_hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
>      -+	finalize_hashfile(f, file_hash, REPO_COMPONENT_COMMIT_GRAPH,
>      ++	finalize_hashfile(f, file_hash, FSYNC_COMPONENT_COMMIT_GRAPH,
>       +			  CSUM_HASH_IN_STREAM | CSUM_FSYNC);
>        	free_chunkfile(cf);
>       =20
>      @@ config.c: static int git_parse_maybe_bool_text(const char *value)
>       =20
>       +static const struct fsync_component_entry {
>       +	const char *name;
>      -+	enum repo_component component_bits;
>      ++	enum fsync_component component_bits;
>       +} fsync_component_table[] =3D {
>      -+	{ "loose-object", REPO_COMPONENT_LOOSE_OBJECT },
>      -+	{ "pack", REPO_COMPONENT_PACK },
>      -+	{ "pack-metadata", REPO_COMPONENT_PACK_METADATA },
>      -+	{ "commit-graph", REPO_COMPONENT_COMMIT_GRAPH },
>      -+	{ "index", REPO_COMPONENT_INDEX },
>      ++	{ "loose-object", FSYNC_COMPONENT_LOOSE_OBJECT },
>      ++	{ "pack", FSYNC_COMPONENT_PACK },
>      ++	{ "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
>      ++	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
>       +	{ "objects", FSYNC_COMPONENTS_OBJECTS },
>       +	{ "default", FSYNC_COMPONENTS_DEFAULT },
>       +	{ "all", FSYNC_COMPONENTS_ALL },
>       +};
>       +
>      -+static enum repo_component parse_fsync_components(const char *var,=
 const char *string)
>      ++static enum fsync_component parse_fsync_components(const char *var=
, const char *string)
>       +{
>      -+	enum repo_component output =3D 0;
>      ++	enum fsync_component output =3D 0;
>       +
>       +	if (!strcmp(string, "none"))
>       +		return output;
>      @@ csum-file.c: static void free_hashfile(struct hashfile *f)
>       =20
>       -int finalize_hashfile(struct hashfile *f, unsigned char *result, u=
nsigned int flags)
>       +int finalize_hashfile(struct hashfile *f, unsigned char *result,
>      -+		      enum repo_component component, unsigned int flags)
>      ++		      enum fsync_component component, unsigned int flags)
>        {
>        	int fd;
>       =20
>      @@ csum-file.c: int finalize_hashfile(struct hashfile *f, unsigned c=
har *result, un
>        			die_errno("%s: sha1 file error on close", f->name);
>      =20
>        ## csum-file.h ##
>      +@@
>      + #ifndef CSUM_FILE_H
>      + #define CSUM_FILE_H
>      +=20
>      ++#include "cache.h"
>      + #include "hash.h"
>      +=20
>      + struct progress;
>       @@ csum-file.h: int hashfile_truncate(struct hashfile *, struct has=
hfile_checkpoint *);
>        struct hashfile *hashfd(int fd, const char *name);
>        struct hashfile *hashfd_check(const char *name);
>        struct hashfile *hashfd_throughput(int fd, const char *name, struc=
t progress *tp);
>       -int finalize_hashfile(struct hashfile *, unsigned char *, unsigned=
 int);
>      -+int finalize_hashfile(struct hashfile *, unsigned char *, enum rep=
o_component, unsigned int);
>      ++int finalize_hashfile(struct hashfile *, unsigned char *, enum fsy=
nc_component, unsigned int);
>        void hashwrite(struct hashfile *, const void *, unsigned int);
>        void hashflush(struct hashfile *f);
>        void crc32_begin(struct hashfile *);
>      @@ environment.c: const char *git_hooks_path;
>        int zlib_compression_level =3D Z_BEST_SPEED;
>        int pack_compression_level =3D Z_DEFAULT_COMPRESSION;
>        enum fsync_method fsync_method =3D FSYNC_METHOD_DEFAULT;
>      -+enum repo_component fsync_components =3D FSYNC_COMPONENTS_DEFAULT;
>      ++enum fsync_component fsync_components =3D FSYNC_COMPONENTS_DEFAULT;
>        size_t packed_git_window_size =3D DEFAULT_PACKED_GIT_WINDOW_SIZE;
>        size_t packed_git_limit =3D DEFAULT_PACKED_GIT_LIMIT;
>        size_t delta_base_cache_limit =3D 96 * 1024 * 1024;
>      @@ midx.c: static int write_midx_internal(const char *object_dir,
>        	write_chunkfile(cf, &ctx);
>       =20
>       -	finalize_hashfile(f, midx_hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
>      -+	finalize_hashfile(f, midx_hash, REPO_COMPONENT_PACK_METADATA,
>      ++	finalize_hashfile(f, midx_hash, FSYNC_COMPONENT_PACK_METADATA,
>       +			  CSUM_FSYNC | CSUM_HASH_IN_STREAM);
>        	free_chunkfile(cf);
>       =20
>      @@ object-file.c: int hash_object_file(const struct git_hash_algo *a=
lgo, const void
>        {
>       -	if (fsync_object_files)
>       -		fsync_or_die(fd, "loose object file");
>      -+	fsync_component_or_die(REPO_COMPONENT_LOOSE_OBJECT, fd, "loose ob=
ject file");
>      ++	fsync_component_or_die(FSYNC_COMPONENT_LOOSE_OBJECT, fd, "loose o=
bject file");
>        	if (close(fd) !=3D 0)
>        		die_errno(_("error when closing loose object file"));
>        }
>      @@ pack-bitmap-write.c: void bitmap_writer_finish(struct pack_idx_en=
try **index,
>        		write_hash_cache(f, index, index_nr);
>       =20
>       -	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSU=
M_CLOSE);
>      -+	finalize_hashfile(f, NULL, REPO_COMPONENT_PACK_METADATA,
>      ++	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
>       +			  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
>       =20
>        	if (adjust_shared_perm(tmp_file.buf))
>      @@ pack-write.c: const char *write_idx_file(const char *index_name, =
struct pack_idx
>        	hashwrite(f, sha1, the_hash_algo->rawsz);
>       -	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_CLOSE |
>       -				    ((opts->flags & WRITE_IDX_VERIFY)
>      -+	finalize_hashfile(f, NULL, REPO_COMPONENT_PACK_METADATA,
>      +-				    ? 0 : CSUM_FSYNC));
>      ++	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
>       +			  CSUM_HASH_IN_STREAM | CSUM_CLOSE |
>      -+			  ((opts->flags & WRITE_IDX_VERIFY)
>      - 				    ? 0 : CSUM_FSYNC));
>      ++			  ((opts->flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
>        	return index_name;
>        }
>      +=20
>       @@ pack-write.c: const char *write_rev_file_order(const char *rev_n=
ame,
>        	if (rev_name && adjust_shared_perm(rev_name) < 0)
>        		die(_("failed to make %s readable"), rev_name);
>       =20
>       -	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_CLOSE |
>       -				    ((flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
>      -+	finalize_hashfile(f, NULL, REPO_COMPONENT_PACK_METADATA,
>      ++	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
>       +			  CSUM_HASH_IN_STREAM | CSUM_CLOSE |
>       +			  ((flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
>       =20
>      @@ pack-write.c: void fixup_pack_header_footer(int pack_fd,
>        	the_hash_algo->final_fn(new_pack_hash, &new_hash_ctx);
>        	write_or_die(pack_fd, new_pack_hash, the_hash_algo->rawsz);
>       -	fsync_or_die(pack_fd, pack_name);
>      -+	fsync_component_or_die(REPO_COMPONENT_PACK, pack_fd, pack_name);
>      ++	fsync_component_or_die(FSYNC_COMPONENT_PACK, pack_fd, pack_name);
>        }
>       =20
>        char *index_pack_lockfile(int ip_out, int *is_well_formed)
>      =20
>        ## read-cache.c ##
>      -@@ read-cache.c: static int record_ieot(void)
>      -  * rely on it.
>      -  */
>      - static int do_write_index(struct index_state *istate, struct tempf=
ile *tempfile,
>      --			  int strip_extensions)
>      -+			  int strip_extensions, unsigned flags)
>      - {
>      - 	uint64_t start =3D getnanotime();
>      - 	struct hashfile *f;
>      -@@ read-cache.c: static int do_write_index(struct index_state *ista=
te, struct tempfile *tempfile,
>      - 	struct strbuf previous_name_buf =3D STRBUF_INIT, *previous_name;
>      - 	int drop_cache_tree =3D istate->drop_cache_tree;
>      - 	off_t offset;
>      -+	int csum_fsync_flag;
>      - 	int ieot_entries =3D 1;
>      - 	struct index_entry_offset_table *ieot =3D NULL;
>      - 	int nr, nr_threads;
>       @@ read-cache.c: static int do_write_index(struct index_state *ista=
te, struct tempfile *tempfile,
>        			return -1;
>        	}
>       =20
>       -	finalize_hashfile(f, istate->oid.hash, CSUM_HASH_IN_STREAM);
>      -+	csum_fsync_flag =3D 0;
>      -+	if (!alternate_index_output && (flags & COMMIT_LOCK))
>      -+		csum_fsync_flag =3D CSUM_FSYNC;
>      -+
>      -+	finalize_hashfile(f, istate->oid.hash, REPO_COMPONENT_INDEX,
>      -+			  CSUM_HASH_IN_STREAM | csum_fsync_flag);
>      -+
>      ++	finalize_hashfile(f, istate->oid.hash, FSYNC_COMPONENT_NONE, CSUM=
_HASH_IN_STREAM);
>        	if (close_tempfile_gently(tempfile)) {
>        		error(_("could not close '%s'"), get_tempfile_path(tempfile));
>        		return -1;
>      -@@ read-cache.c: static int do_write_locked_index(struct index_stat=
e *istate, struct lock_file *l
>      - 	 */
>      - 	trace2_region_enter_printf("index", "do_write_index", the_reposit=
ory,
>      - 				   "%s", get_lock_file_path(lock));
>      --	ret =3D do_write_index(istate, lock->tempfile, 0);
>      -+	ret =3D do_write_index(istate, lock->tempfile, 0, flags);
>      - 	trace2_region_leave_printf("index", "do_write_index", the_reposit=
ory,
>      - 				   "%s", get_lock_file_path(lock));
>      -=20
>      -@@ read-cache.c: static int clean_shared_index_files(const char *cu=
rrent_hex)
>      - }
>      -=20
>      - static int write_shared_index(struct index_state *istate,
>      --			      struct tempfile **temp)
>      -+			      struct tempfile **temp, unsigned flags)
>      - {
>      - 	struct split_index *si =3D istate->split_index;
>      - 	int ret, was_full =3D !istate->sparse_index;
>      -@@ read-cache.c: static int write_shared_index(struct index_state *=
istate,
>      -=20
>      - 	trace2_region_enter_printf("index", "shared/do_write_index",
>      - 				   the_repository, "%s", get_tempfile_path(*temp));
>      --	ret =3D do_write_index(si->base, *temp, 1);
>      -+	ret =3D do_write_index(si->base, *temp, 1, flags);
>      - 	trace2_region_leave_printf("index", "shared/do_write_index",
>      - 				   the_repository, "%s", get_tempfile_path(*temp));
>      -=20
>      -@@ read-cache.c: int write_locked_index(struct index_state *istate,=
 struct lock_file *lock,
>      - 			ret =3D do_write_locked_index(istate, lock, flags);
>      - 			goto out;
>      - 		}
>      --		ret =3D write_shared_index(istate, &temp);
>      -+		ret =3D write_shared_index(istate, &temp, flags);
>      -=20
>      - 		saved_errno =3D errno;
>      - 		if (is_tempfile_active(temp))
>  -:  ----------- > 3:  86e39b8f8d1 core.fsync: new option to harden the i=
ndex
>=20
> --=20
> gitgitgadget

--jJsNv0ui80iiTX3C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGvS+MACgkQVbJhu7ck
PpQv0Q/9GZfj5q4KMTcGuVtsXC0Qkj+JfQ822pNDq2C41jtxJp9acx2D8bqREAkl
QG+YzgjXyq1pik0hezQZr7OLoYV65GUye2as0q4WJlMpd1SKYRZh2uukqFNzILql
AintZfTSUNFRz00xHkRBGiwtxFeCNn2saegJemzQdu/pVDA5cuIfAS17fGgRrCIk
ZhFkIObr8ZYqUHzI6PKG6I7SlzwDx9iGcjDx+4DIlRhN3skBIRvhIKN9TA/dfvdz
CbQ0HE7ID64LIIxX+1e50D9nWuO6TmSHeOFjyUmnZLTmzbVp+edq/WuCNmWvU0BR
yXGj8Ia+y72fqfTQBJHsZ/8gvbyAtV6sAe9NuGiOM2JbSm82HowQGtmMml/RELVT
eRCVTyttCS4wkYuZb8wUgD5C1inYHDVIUcY90n69T7Uy3XPZRuOJ/Qm+qddKGTE0
r5+G8+guCI8b4gMdsS50X1sLgkbJHc+sBd4zcV4LSzwyQX/+TxiA0c5Gl6d9AdIv
f998RMpfljJ5hdNTUtX1YKsNmO9HSM8X2EHRp3z5hi7VxdK9EH/2lNekjaDsqYNI
JgcYmuWH7TS0bKXu9dZA78gf2t4PKoe2xBGAeP/CRHKx9VyRwWJpWBdudh04NRI6
QkFnwu0jTh4cD0FzE4oIj5hpvKFPuEtdHI2TWak49McEz+U2GZk=
=U8Y2
-----END PGP SIGNATURE-----

--jJsNv0ui80iiTX3C--
