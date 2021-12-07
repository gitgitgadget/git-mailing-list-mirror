Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73ADC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 11:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbhLGLsx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 06:48:53 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:53043 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231338AbhLGLsw (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Dec 2021 06:48:52 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CC3935C01AA;
        Tue,  7 Dec 2021 06:45:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 07 Dec 2021 06:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=XvOmJBSbsoU56lMyE5+GmcBndjc
        +vP39zCI2XMB5G+w=; b=HdT7zQR6kAVlCFO067ZPSFySyhh/+HusF3YfBVlRFbT
        VzxqK6bakXnx8YS6B853E6nS7/0Z6MKODeNMDD0eoOHSKC67IsyZGJyG7YU0+EMk
        FvNRYPWAJNjsL/tyHkfum9ddfaNvm9U1WBJlOtrsAJN2T+HEM4PXNNZybWDjdUBL
        EZhXUsbwy3L0qnGn5H9EJXhtW+i0yptHzAUIuKXUWFQJdj3CPLuXRP9khIAtH6He
        xOae/x/6FwO8XUr7BeVPydEIS7MrnUeKKXR3Gr3vbZ6v4sQaSw1MZM6GR5eu843E
        7Jiddm0aj4wKOrTxHmGiH1ybKlLXpkwPiTQiOORDdgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=XvOmJB
        SbsoU56lMyE5+GmcBndjc+vP39zCI2XMB5G+w=; b=BhM60vS4LCTJ/4ox/EI6Ob
        jAxQslsw7QhKekOJGMIizB2eCRnB3T9ARhlWqAB62jsbtxWns98AHjlxS0H4tLFD
        jPY1g+gOdezel8c9NmXW5QvfUnFIMWcT1hBbPtRlXvHqDwpnWBSZhBHNpzaG2CPq
        X5j/1WRUt1mNe8yG/Gvgbt+ALfKtl3st12kEdwFp1OYTKUkQX7FaiCZf8YKF5zeh
        4tFmWPZwdb8gjlvfIDX//Ihg2L28V5mFW7faK41wEWrnll2w+UZjgN3r/yVngabf
        rCCP3z1epMiPwnvOLizrO5YArlNP4iuJIYsj7Pv2lESKlAF3T3KZrrhscQ6X6QMw
        ==
X-ME-Sender: <xms:UUmvYf-QE0HZadiwg6mkgEEVAgj8lfBPkove_9c4bPa2RyPRe9Rq5w>
    <xme:UUmvYbvyo16Puz45PD7w2gV3iJLIjI3ETJKNzkZpRj4_3H013iNbEeoWMVyDr_d7O
    S7NRAeBBgPcZGFsCw>
X-ME-Received: <xmr:UUmvYdCzpn0xkynKPV2xIZaJRgBWfJF5fC6YEgfxq_WcqnVUJg27xaBuWUYTqJ9pgPyM99FQ5J_VYQn9gMUYC-n6fmC4sIi9VD67mU4Q4DBQGvPSDj2U00ZD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeehgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:UUmvYbfbKq5JtkW38B0qF1S3bLclkao-81-yRKgK73eF60KATv_grg>
    <xmx:UUmvYUO7nSTHbkR_maXo0YEnSNGEjZJiueHCSueI1DhHhkWbNsu6GQ>
    <xmx:UUmvYdmJEYovA8NLExqDMDZSCHhnzMhGxCOM4Mp_w8a9pjExgGhGIw>
    <xmx:UUmvYQA0E6y_muZIhuViVUXQCPLcjrhktwhSQsPsyHC75oKRbqDA7Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Dec 2021 06:45:20 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 9fd2bf31 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 7 Dec 2021 13:14:56 +0000 (UTC)
Date:   Tue, 7 Dec 2021 12:44:38 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com, bagasdotme@gmail.com,
        newren@gmail.com, avarab@gmail.com, nksingh85@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 1/3] core.fsyncmethod: add writeout-only mode
Message-ID: <Ya9JJlItvDJCLHqj@ncase>
References: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
 <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com>
 <e79522cbdd4feb45b062b75225475f34039d1866.1638845211.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FRW3ky2b/hqIXfuW"
Content-Disposition: inline
In-Reply-To: <e79522cbdd4feb45b062b75225475f34039d1866.1638845211.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FRW3ky2b/hqIXfuW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 07, 2021 at 02:46:49AM +0000, Neeraj Singh via GitGitGadget wro=
te:
> From: Neeraj Singh <neerajsi@microsoft.com>
[snip]
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -329,6 +329,9 @@ int mingw_getpagesize(void);
>  #define getpagesize mingw_getpagesize
>  #endif
> =20
> +int win32_fsync_no_flush(int fd);
> +#define fsync_no_flush win32_fsync_no_flush
> +
>  struct rlimit {
>  	unsigned int rlim_cur;
>  };
> diff --git a/compat/win32/flush.c b/compat/win32/flush.c
> new file mode 100644
> index 00000000000..75324c24ee7
> --- /dev/null
> +++ b/compat/win32/flush.c
> @@ -0,0 +1,28 @@
> +#include "../../git-compat-util.h"
> +#include <winternl.h>
> +#include "lazyload.h"
> +
> +int win32_fsync_no_flush(int fd)
> +{
> +       IO_STATUS_BLOCK io_status;
> +
> +#define FLUSH_FLAGS_FILE_DATA_ONLY 1
> +
> +       DECLARE_PROC_ADDR(ntdll.dll, NTSTATUS, NtFlushBuffersFileEx,
> +			 HANDLE FileHandle, ULONG Flags, PVOID Parameters, ULONG ParameterSiz=
e,
> +			 PIO_STATUS_BLOCK IoStatusBlock);
> +
> +       if (!INIT_PROC_ADDR(NtFlushBuffersFileEx)) {
> +		errno =3D ENOSYS;
> +		return -1;
> +       }

I'm wondering whether it would make sense to fall back to fsync(3P) in
case we cannot use writeout-only, but I see that were doing essentially
that in `fsync_or_die()`. There is no indicator to the user though that
writeout-only doesn't work -- do we want to print a one-time warning?

> +       memset(&io_status, 0, sizeof(io_status));
> +       if (NtFlushBuffersFileEx((HANDLE)_get_osfhandle(fd), FLUSH_FLAGS_=
FILE_DATA_ONLY,
> +				NULL, 0, &io_status)) {
> +		errno =3D EINVAL;
> +		return -1;
> +       }
> +
> +       return 0;
> +}

[snip]
> diff --git a/wrapper.c b/wrapper.c
> index 36e12119d76..1c5f2c87791 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -546,6 +546,62 @@ int xmkstemp_mode(char *filename_template, int mode)
>  	return fd;
>  }
> =20
> +int git_fsync(int fd, enum fsync_action action)
> +{
> +	switch (action) {
> +	case FSYNC_WRITEOUT_ONLY:
> +
> +#ifdef __APPLE__
> +		/*
> +		 * on macOS, fsync just causes filesystem cache writeback but does not
> +		 * flush hardware caches.
> +		 */
> +		return fsync(fd);

Below we're looping around `EINTR` -- are Apple systems never returning
it?

Patrick

> +#endif
> +
> +#ifdef HAVE_SYNC_FILE_RANGE
> +		/*
> +		 * On linux 2.6.17 and above, sync_file_range is the way to issue
> +		 * a writeback without a hardware flush. An offset of 0 and size of 0
> +		 * indicates writeout of the entire file and the wait flags ensure tha=
t all
> +		 * dirty data is written to the disk (potentially in a disk-side cache)
> +		 * before we continue.
> +		 */
> +
> +		return sync_file_range(fd, 0, 0, SYNC_FILE_RANGE_WAIT_BEFORE |
> +						 SYNC_FILE_RANGE_WRITE |
> +						 SYNC_FILE_RANGE_WAIT_AFTER);
> +#endif
> +
> +#ifdef fsync_no_flush
> +		return fsync_no_flush(fd);
> +#endif
> +
> +		errno =3D ENOSYS;
> +		return -1;
> +
> +	case FSYNC_HARDWARE_FLUSH:
> +		/*
> +		 * On some platforms fsync may return EINTR. Try again in this
> +		 * case, since callers asking for a hardware flush may die if
> +		 * this function returns an error.
> +		 */
> +		for (;;) {
> +			int err;
> +#ifdef __APPLE__
> +			err =3D fcntl(fd, F_FULLFSYNC);
> +#else
> +			err =3D fsync(fd);
> +#endif
> +			if (err >=3D 0 || errno !=3D EINTR)
> +				return err;
> +		}
> +
> +	default:
> +		BUG("unexpected git_fsync(%d) call", action);
> +	}
> +}
> +
>  static int warn_if_unremovable(const char *op, const char *file, int rc)
>  {
>  	int err;
> diff --git a/write-or-die.c b/write-or-die.c
> index 0b1ec8190b6..0702acdd5e8 100644
> --- a/write-or-die.c
> +++ b/write-or-die.c
> @@ -57,10 +57,12 @@ void fprintf_or_die(FILE *f, const char *fmt, ...)
> =20
>  void fsync_or_die(int fd, const char *msg)
>  {
> -	while (fsync(fd) < 0) {
> -		if (errno !=3D EINTR)
> -			die_errno("fsync error on '%s'", msg);
> -	}
> +	if (fsync_method =3D=3D FSYNC_METHOD_WRITEOUT_ONLY &&
> +	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) >=3D 0)
> +		return;
> +
> +	if (git_fsync(fd, FSYNC_HARDWARE_FLUSH) < 0)
> +		die_errno("fsync error on '%s'", msg);
>  }
> =20
>  void write_or_die(int fd, const void *buf, size_t count)
> --=20
> gitgitgadget
>=20

--FRW3ky2b/hqIXfuW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGvSSYACgkQVbJhu7ck
PpSusRAAkSCjo70fipT9enLRntvP2bsxSqddv23zIdvhQMzsThePBBlvA8+6lK6H
VT6LHKUpeSeknLmMNOOF1+JX38aKOqn1OGFTviNchPDrsJYxM6wRUGrMoEpD1yOJ
fol0XQ74XC9v5eW81Fc4XEc6rsXMfByRT5Iyp3e5mp+plekzspUh4+i4v/FdrE4e
eY7dRZOD009h2sxXqlHQVUjPZ1O2eIUGKjdHX1T1T/4/ctuv2zkOR1dHpAChNKRe
KxKjTDWiR0sLZjrvwpuDu7Wyo+z5bDg3t8NFthZKYmmvf+R40GOOlXN8eVDT6kiU
zF6h3L4+sNCJl13KWKIaHLSVech4Xst0c4cEfVyE9Z7d7MDBRuRBBJbEEm1znLJm
54LfkAFIvGArfUFSyecwgL+4k7PAncrn3uIR5Qf0qSgIsGdYI8cbnl8N3w9zOdNM
GMH6VafsDwPQG5+jGt4KpQIOTq6KsoYaTkyntvCTkgRNyg0FneEj/HRFnwuGx8h4
P7q7VMhgD3Q7YFxLWyYNQMxyCgPdMNhhcw83CfTMgubcGCHr3Ubw0xYrFIt7wtfV
RDmrtrCculP94prD4tJwpvkkvbtVXBYIQDu7lDgk50yMvKSYfZu0FqelaiuMwKzX
u6RTZ56FHEYYeuuJoPJk4zulJOpSiu50ETYUsloS15kSrYfxpMQ=
=oHAu
-----END PGP SIGNATURE-----

--FRW3ky2b/hqIXfuW--
