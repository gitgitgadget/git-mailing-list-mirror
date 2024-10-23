Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C191C9B80
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700398; cv=none; b=lpCIxZq1YGa7UxnEygOB11LMeoEWCOHAOEmjK8akWgx05lXv4ESUpdMqQpufVt/vLgs4chiFI7JojQkvaxIKD30Fn8mGRNdPmlgPNbbFeo0mdCMKSvJWfgYvukr5Qc8LEpIf67BYoxsObhlZn8j6AI+OFV/CMq95uZKELeSbFz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700398; c=relaxed/simple;
	bh=Zmf1hKzF7JQnIaM7gs/ZOuXmmPq6GGZ4656J2p1U+yY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KoDATS6EB3TvDEB/DG9d/WEtcVn3SP3A6DmaP/nkSitsyz7um6HgcYeO194ttWiRK+MvjuB7Ycfl8y6CjT/4TjYBi4nQr780PbAWjxNNPUTZ4MebFSo06Gc+MKVlNU6XChP9qifDcDt93eiQwlSBb/vgdwWqe7GHs3Wv00loFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Bo0n+kDE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hEe3KpIU; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Bo0n+kDE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hEe3KpIU"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 178BE13800ED;
	Wed, 23 Oct 2024 12:19:55 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 23 Oct 2024 12:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729700395;
	 x=1729786795; bh=xbRmugFoLDwxAqzEnxFYfOBmu41jdUYA0kv+2x4I2qo=; b=
	Bo0n+kDEuN9d+UIOot1EudlY7WEJ2m+7msx+sNlse1Du3+xyhwUhX0kttbLayMNo
	S3YHUUDcdyjF+gpw6o9poBa60o/7XRhcKdvl2tQxPxZBXyYJwrvX5Tcw0eoGLmZW
	nhjljDqUoUHEfxqhG1HdAogaMgLfsvFHcY2wpsuYmtby51tWmwMOS7rpc7v9KoJe
	bnK/DYSf1UWRA56fmqvOTlK/uc8ckIgsG1CKkbyhY2Fzmii5nkzmz5AJx3oD8Jrk
	xItQgMsf3CxynPd8qkH1ClmNue9ZkjFfWyKw4O1MJtSccpQsmqDdoDWYWT4vjka0
	Vc0fmO6mXWjJZFGPNQhHOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729700395; x=
	1729786795; bh=xbRmugFoLDwxAqzEnxFYfOBmu41jdUYA0kv+2x4I2qo=; b=h
	Ee3KpIUwG7G2T57q5ONlVIjZQb/vuiHB2oj6z1DovWpV5RMFRyeGsHw9pO2kbxQ8
	giqWAYTtEBFqru4qBvWE5POSgWkESBCyNMNSserCabJ/6fkULYzW4CE4jBt4I82F
	Rb8+qN9ZagSNZSTXZsDNAL1pWxfacZznko//0RR7Yc/WW9mqU4bVK3n9PaQRA66X
	GgrcrmExX+QQ8LSMQ+mXVDlDWI4JXJhfkkTnVZH+jYjsoXgO3nUpeX8J/GuqeRKZ
	gMmI2ETEy2TO8pqgO6EJqqoO2E41yM68UcOD5GjDduROOsXbYCa8qQ70fX/g9qxc
	oRH0CN5g2la9VvHkxcvzA==
X-ME-Sender: <xms:KiIZZwcRJOtEhOOqQ1_ylfFTR9D6SohTBoz-puguQsXt7ZUu47Q6hTw>
    <xme:KiIZZyOmEZLRDlryQMPVjdkktlcdyT_Ewj6bUVEl-g9oh3knY5BGOPoFGTUxfjxQC
    rCoRauk4dqo91pGhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghn
    nhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KiIZZxiHa4aP73do0Xgys70dU2kPA2rX5fsMo7QMzgoPpbjF4ypZTA>
    <xmx:KiIZZ1-BK3YB_VilG5Z4j4RLhgKHHvgrTMpHv-3xXZsSFB-yNiUxhQ>
    <xmx:KiIZZ8szmUixm_Defk0cFbbkYxayEMpDlKGEwNlMXj2HvkpYb7NeCA>
    <xmx:KiIZZ8ELztcew0d0Tm36OajbDB0vaX6iAQpqjmMQ1I650MvDEYRtLA>
    <xmx:KyIZZ17PDNHmRF1G13hwmNg9mdnzwPDIz-tbbHlMnZg3pTdEdNmDa0eS>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C6138780068; Wed, 23 Oct 2024 12:19:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Oct 2024 18:17:15 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Message-Id: <bc829d84-6696-4e16-9687-8ba611af29ff@app.fastmail.com>
In-Reply-To: 
 <3552feddb332b31744c2ab723b112b9b08926436.1729695349.git.ps@pks.im>
References: <cover.1729695349.git.ps@pks.im>
 <3552feddb332b31744c2ab723b112b9b08926436.1729695349.git.ps@pks.im>
Subject: Re: [PATCH 2/3] compat/mingw: allow deletion of most opened files
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024, at 17:05, Patrick Steinhardt wrote:
> On Windows, we emulate open(3p) via `mingw_open()`. This function
> implements handling of some platform- specific quirks that are required

s/platform- specific/platform-specific/

Linewrapping artifact?

> to make it behave as closely as possible like open(3p) would, but for
> most cases we just call the Windows-specific `_wopen()` function.
>
> This function has a major downside though: it does not allow us to
> specify the sharing mode. While there is `_wsopen()` that allows us to
> pass sharing flags, those sharing flags are not the same `FILE_SHARE_*`
> flags as `CreateFileW()` accepts. Instead, `_wsopen()` only allows
> concurrent read- and write-access, but does not allow for concurrent
> deletions. Unfortunately though, we have to allow concurrent deletions
> if we want to have POSIX-style atomic renames on top of an existing fi=
le
> that has open file handles.
>
> Implement a new function that emulates open(3p) for existing files via
> `CreateFileW()` such that we can set the required sharing flags.
>
> While we have the same issue when calling open(3p) with `O_CREAT`,

s/O_CREAT/O_CREATE/ ?

> implementing that mode would be more complex due to the required
> permission handling. Furthermore, atomic updates via renames typically
> write to exclusive lockfile and then perform the rename, and thus we
> don't have to handle the case where the locked path has been created
> with `O_CREATE`. So while it would be nice to have proper POSIX
> semantics in all paths, we instead aim for a minimum viable fix here.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  compat/mingw.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index e326c6fcd2d..ce95f3a5968 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -532,6 +532,59 @@ static int mingw_open_append(wchar_t const
> *wfilename, int oflags, ...)
>  	return fd;
>  }
>
> +/*
> + * Ideally, we'd use `_wopen()` to implement this functionality so th=
at we
> + * don't have to reimplement it, but unfortunately we do not have tig=
ht control
> + * over the share mode there. And while `_wsopen()` and friends exist=
 that give
> + * us _some_ control over the share mode, this family of functions do=
esn't give
> + * us the ability to enable FILE_SHARE_DELETE, either. But this is a =
strict
> + * requirement for us though so that we can unlink or rename over fil=
es that
> + * are held open by another process.
> + *
> + * We are thus forced to implement our own emulation of `open()`. To =
make our
> + * life simpler we only implement basic support for this, namely open=
ing
> + * existing files for reading and/or writing. This means that newly c=
reated
> + * files won't have their sharing mode set up correctly, but for now =
I couldn't
> + * find any case where this matters. We may have to revisit that in t=
he future
> + * though based on our needs.
> + */

This is above my technical level but the comment reads nicely.

> +static int mingw_open_existing(const wchar_t *filename, int oflags, .=
..)
> +{
> +	SECURITY_ATTRIBUTES security_attributes =3D {
> +	    .nLength =3D sizeof(security_attributes),
> +	    .bInheritHandle =3D !(oflags & O_NOINHERIT),

`clang-format` thinks that these two lines should be indented with tabs
instead (so two tabs in total).

(Ubuntu clang-format version 14.0.0-1ubuntu1.1)

> +	};
> +	HANDLE handle;
> +	int access;
> +	int fd;
> +
> +	/* We only support basic flags. */
> +	if (oflags & ~(O_ACCMODE | O_NOINHERIT))
> +		return errno =3D ENOSYS, -1;

This use of the comma operator is maybe an idiom to save space and avoid
a brace around the `if`?  This pattern is already in use in
`mingw_open_append`.  I see in `mingw.h` that it uses:

```
static inline int symlink(const char *oldpath UNUSED, const char *newpat=
h UNUSED)
{ errno =3D ENOSYS; return -1; }
```

> +	if (oflags & O_RDWR)
> +		access =3D GENERIC_READ | GENERIC_WRITE;
> +	else if (oflags & O_WRONLY)
> +		access =3D GENERIC_WRITE;
> +	else
> +		access =3D GENERIC_READ;
> +
> +	handle =3D CreateFileW(filename, access,
> +			     FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE,
> +			     &security_attributes, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, N=
ULL);

`clang-format` says that these two lines are too long.

> +	if (handle =3D=3D INVALID_HANDLE_VALUE) {
> +		DWORD err =3D GetLastError();
> +		if (err =3D=3D ERROR_INVALID_PARAMETER)
> +			err =3D ERROR_PATH_NOT_FOUND;
> +		errno =3D err_win_to_posix(err);
> +		return -1;

Here you don=E2=80=99t use the comma operator, presumably because it wou=
ldn=E2=80=99t
turn the `if` into a one-statement block.

> +	}
> +
> +	fd =3D _open_osfhandle((intptr_t)handle, oflags | O_BINARY);
> +	if (fd < 0)
> +		CloseHandle(handle);
> +	return fd;
> +}
> +
>  /*
>   * Does the pathname map to the local named pipe filesystem?
>   * That is, does it have a "//./pipe/" prefix?
> @@ -567,6 +620,8 @@ int mingw_open (const char *filename, int oflags, =
...)
>
>  	if ((oflags & O_APPEND) && !is_local_named_pipe_path(filename))
>  		open_fn =3D mingw_open_append;
> +	else if (!(oflags & ~(O_ACCMODE | O_NOINHERIT)))
> +		open_fn =3D mingw_open_existing;
>  	else
>  		open_fn =3D _wopen;
>
> --
> 2.47.0.118.gfd3785337b.dirty
