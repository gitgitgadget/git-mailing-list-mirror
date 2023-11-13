Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8D73B2A2
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 23:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="DReJ0cqn"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48207D55
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 15:03:58 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B45D25B0E8;
	Mon, 13 Nov 2023 23:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1699916635;
	bh=hfC+I8gaZ7LAbuSx8i5K+Y+FxJ5xOAFyWN9U+NMXH2g=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=DReJ0cqnQe+WgKL63UjTeJGJjmYq82Y2Y4qcJ8qdXWBJOHankTKworxMkPYW1Mm8k
	 70kQejMO9YP8aQ8blu6f1qnNcTqgYOz3t2OhgXLwFFnfd663sa5EBpiD3ytRbM8YrZ
	 WT3awmBtunu/7JWlTx3LKFgBF7Wxk+QfMggkGDgrP6RtUSeL5tNSQC0krWKK/8TeXI
	 pgVekGiINKmNOYNIoFBwltav9De8lee+ucQN8m6+Y7M/vC43gxXVYYZvAfob5s4SyC
	 OJo60qqoxYjMpB5gWCZGlUB8IOghLCL9ygjNyp56UoZ7MqeP8G6nTc1/3bnPj/6GWg
	 WtV2th2Cimm7hQ4cntm6c3VBTiZ4DSO8qARiG+rqwXQ0m73qYIG/qdXWKAypBTxqw4
	 iF7Kl7dEy2JIjDRwpBHN82WZiXJua9dbBeI+6t0BPYKfu0UTv6ekQJ9Zb93nhTyNaN
	 nVu6UDBlX5OKNzp54ZYLZy+3VWW7cBbTZzf72rPe97VJM0zohYv
Date: Mon, 13 Nov 2023 23:03:53 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Haritha D via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Haritha <harithamma.d@ibm.com>
Subject: Re: [PATCH 02/13] Enable builds for z/OS.
Message-ID: <ZVKrWSv7JguKTSYw@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Haritha D via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Haritha <harithamma.d@ibm.com>
References: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
 <098b9ca8ece4fdce45a9b48e576b474ed81dced1.1699871056.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="STMSR9eJ4lVNPEOy"
Content-Disposition: inline
In-Reply-To: <098b9ca8ece4fdce45a9b48e576b474ed81dced1.1699871056.git.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--STMSR9eJ4lVNPEOy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-11-13 at 10:24:04, Haritha D via GitGitGadget wrote:
> From: Haritha D <harithamma.d@ibm.com>
>=20
> This commit enables git to build on z/OS.
> It takes advantage of enahanced ASCII
> services on z/OS to auto-convert input
> files to ASCII

In general, we don't want to convert files to ASCII, since we assume
text files are UTF-8 unless otherwise specified.  If you're suggesting
that your system is normally EBCDIC, changing that should be an initial
piece of setup code or something used in `xopen` on your platform so it
applies everywhere with minimal changes.

> It also adds support for
> [platform]-working-tree-encoding.
> Platform is substituted with uname_info.sysname,
> so it will only apply to the given platform.

I think this is going to need to be a separate patch and feature with
its own explanation of why it's valuable.

> Also adds support for scripts that are not in
> standard locations so that /bin/env bash
> can be specified.


> Signed-off-by: Harithamma D <harithamma.d@ibm.com>
> ---
>  Makefile              | 21 +++++++++---
>  builtin.h             |  3 ++
>  builtin/archive.c     |  6 ++++
>  builtin/hash-object.c | 28 +++++++++++++++
>  combine-diff.c        |  4 +++
>  config.c              |  7 ++++
>  configure.ac          |  3 ++
>  convert.c             | 44 ++++++++++++++++++++----
>  copy.c                |  3 ++
>  diff.c                | 11 ++++++
>  entry.c               | 26 ++++++++++++++
>  environment.c         |  3 ++
>  git-compat-util.h     |  8 +++++
>  negotiator/default.c  |  4 +--
>  negotiator/noop.c     |  4 +--
>  negotiator/skipping.c |  4 +--
>  object-file.c         | 80 ++++++++++++++++++++++++++++++++++++++++++-
>  read-cache.c          |  3 ++
>  utf8.c                | 11 ++++++
>  19 files changed, 255 insertions(+), 18 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 9c6a2f125f8..30aa76da4f4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -20,6 +20,8 @@ include shared.mak
>  #
>  # Define SHELL_PATH to a POSIX shell if your /bin/sh is broken.
>  #
> +# Define SHELL_PATH_FOR_SCRIPTS to a POSIX shell if your /bin/sh is brok=
en.
> +#
>  # Define SANE_TOOL_PATH to a colon-separated list of paths to prepend
>  # to PATH if your tools in /usr/bin are broken.
>  #
> @@ -215,6 +217,8 @@ include shared.mak
>  #
>  # Define PERL_PATH to the path of your Perl binary (usually /usr/bin/per=
l).
>  #
> +# Define PERL_PATH_FOR_SCRIPTS to a Perl binary if your /usr/bin/perl is=
 broken.

You will probably want to explain in your commit message why these two
are required to be different from the standard values and explain here
what the relevant difference is so that users can set them
appropriately.

> diff --git a/builtin/archive.c b/builtin/archive.c
> index 90761fdfee0..53ec794356f 100644
> --- a/builtin/archive.c
> +++ b/builtin/archive.c
> @@ -14,6 +14,12 @@
>  static void create_output_file(const char *output_file)
>  {
>  	int output_fd =3D xopen(output_file, O_CREAT | O_WRONLY | O_TRUNC, 0666=
);
> +#ifdef __MVS__
> + #if (__CHARSET_LIB =3D=3D 1)
> +	if (setbinaryfd(output_fd))
> +		die_errno(_("could not tag archive file '%s'"), output_file);
> + #endif
> +#endif

This would be better to place in `xopen` itself so that all files are
correctly configured.  That would do well as its own patch, and you'd
want to explain well in the commit message what this function does, why
it's necessary, and what the consequences of not using it are, as well
as any alternatives that you've rejected.

>  	if (output_fd !=3D 1) {
>  		if (dup2(output_fd, 1) < 0)
>  			die_errno(_("could not redirect output"));
> diff --git a/builtin/hash-object.c b/builtin/hash-object.c
> index 5ffec99dcea..b33b32ff977 100644
> --- a/builtin/hash-object.c
> +++ b/builtin/hash-object.c
> @@ -57,11 +57,39 @@ static void hash_fd(int fd, const char *type, const c=
har *path, unsigned flags,
>  	maybe_flush_or_die(stdout, "hash to stdout");
>  }
> =20
> +#ifdef __MVS__
> +#  if (__CHARSET_LIB =3D=3D 1)
> +#  include <stdio.h>
> +#  include <stdlib.h>

We typically don't include the standard headers here.  Instead, they're
included by git-compat-util.h because on some systems they have to be
included in a certain order with certain options.  If you include that
header instead at the top of the file, or one of the headers that
includes it, then typically that should do the right thing.

> +   int setbinaryfd(int fd)
> +   {
> +     attrib_t attr;
> +     int rc;
> +
> +     memset(&attr, 0, sizeof(attr));
> +     attr.att_filetagchg =3D 1;
> +     attr.att_filetag.ft_ccsid =3D FT_BINARY;
> +     attr.att_filetag.ft_txtflag =3D 0;
> +
> +     rc =3D __fchattr(fd, &attr, sizeof(attr));
> +     return rc;
> +   }
> +#  endif
> +#endif

I would think a comment explaining what this function does and why it's
necessary would be appropriate, since it's not in POSIX and isn't
typically necessary on POSIX systems.

> diff --git a/combine-diff.c b/combine-diff.c
> index f90f4424829..73445a517c7 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -1082,6 +1082,10 @@ static void show_patch_diff(struct combine_diff_pa=
th *elem, int num_parent,
>  			ssize_t done;
>  			int is_file, i;
> =20
> +#ifdef __MVS__
> +      __disableautocvt(fd);
> +#endif

Again, if this can be centralized, it should be, and it should be
explained well in the commit message.  I'm uncertain what it does or
what value it provides.

> diff --git a/config.c b/config.c
> index f9a1cca4e8a..37c124a37c0 100644
> --- a/config.c
> +++ b/config.c
> @@ -1521,6 +1521,13 @@ static int git_default_core_config(const char *var=
, const char *value,
>  		return 0;
>  	}
> =20
> +	#ifdef __MVS__
> +	if (!strcmp(var, "core.ignorefiletags")) {
> +		ignore_file_tags =3D git_config_bool(var, value);
> +		return 0;
> +	}
> +	#endif

This should also live in its own patch and the commit message should
explain what it does.  We'd also want it to be documented in the config
options in the Documentation directory.

> diff --git a/convert.c b/convert.c
> index a8870baff36..4f14ff6f1ed 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -377,12 +377,15 @@ static int check_roundtrip(const char *enc_name)
>  static const char *default_encoding =3D "UTF-8";
> =20
>  static int encode_to_git(const char *path, const char *src, size_t src_l=
en,
> -			 struct strbuf *buf, const char *enc, int conv_flags)
> +			 struct strbuf *buf, const char *enc, enum convert_crlf_action attr_a=
ction, int conv_flags)
>  {
>  	char *dst;
>  	size_t dst_len;
>  	int die_on_error =3D conv_flags & CONV_WRITE_OBJECT;
> =20
> +  if (attr_action =3D=3D CRLF_BINARY) {
> +    return 0;
> +  }

I'm pretty sure this is a change in behaviour from what we had before.
It should live in its own patch, with an explanation in the commit
message why it's a compelling and correct change overall, and with
suitable tests.

>  	/*
>  	 * No encoding is specified or there is nothing to encode.
>  	 * Tell the caller that the content was not modified.
> @@ -403,6 +406,11 @@ static int encode_to_git(const char *path, const cha=
r *src, size_t src_len,
>  		return 0;
> =20
>  	trace_encoding("source", path, enc, src, src_len);
> +#ifdef __MVS__
> +  // Don't convert ISO8859-1 on z/OS
> +  if (strcasecmp("ISO8859-1", enc) =3D=3D 0)
> +    return 0;
> +#endif

This definitely needs explanation in the commit message and should
probably be its own patch, explaining why z/OS has this compelling need
to not convert ISO8859-1.  Note that ISO8859-1 is not the same as "no
binary conversion", since it doesn't include many control codes.

Note that if, as it says later on, this really means "UTF-8", that's a
platform wart you'd want to paper over in a file in the compat code.  In
general, the compat directory is a good place to put anything that your
platform needs specifically.

> +static const char* get_platform() {
> +	struct utsname uname_info;
> +
> +	if (uname(&uname_info))
> +		die(_("uname() failed with error '%s' (%d)\n"),
> +			    strerror(errno),
> +			    errno);
> +
> +  if (!strcmp(uname_info.sysname, "OS/390"))
> +    return "zos";
> +  return uname_info.sysname;
> +}

This is definitely a new feature, and I'm not sure why it's necessary or
useful.  I suspect there's something about z/OS that makes it valuable,
but I don't know what it is since the commit message doesn't tell me.
I'm also not sure that these values will be correct on Windows.

I think I could go on to make similar comments about the rest of this
series.  I'm not opposed to seeing z/OS changes come in, but you've
amalgamated at least a half-dozen separate patches into one and haven't
explained them very thoroughly in the commit message.

I'd generally want to look at the commit message and understand the
problem the code is trying to solve and then look at the code and think,
"Oh, yes, this seems like the obvious and logical way to solve this
problem," or at least think, "Oh, no, I think we should solve this
problem in a different way," so I can help make a thoughtful review
comment.  Right now, I lack the information to have an informed opinion
and so I can't provide any helpful feedback or analysis of the patches.

When you're adding new features or fixing bugs, we'll also want tests
for those cases to help us avoid regressing that code in the future.
Even if we don't normally run the testsuite on z/OS, at least _you_ will
notice that the tests have failed and then we'll be able to address the
bugs in a timely manner.

I also noted that there were some fixup commits later on in the series
that address whitespace issues.  Typically, we'd want to squash those in
to the earlier patches.  Nobody expects perfection, but squashing errors
into earlier patches helps us keep the history neat and let us pretend
like you never made those errors at all.  It also lets tools like git
blame and git bisect work more nicely for users.

I'd recommend a quick pass over the SubmittingPatches file, which is
also available at https://git-scm.com/docs/SubmittingPatches.  The
sections on making separate commits for separate changes and describing
changes well come to mind as places to focus.

I know this may seem overwhelming and like I'm upset or disappointed;
I'm definitely not.  I'm very much interested in seeing Git available
for more platforms, but right now it's too hard for me to reason about
the changes for z/OS to provide helpful feedback, so I'm hoping you can
send a fixed v2 that helps me (and everyone else) understand these
changes better so you can get a helpful review.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--STMSR9eJ4lVNPEOy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZVKrWQAKCRB8DEliiIei
gQ+uAQCb7Q2XupsgyR959uMMbCcsSkwk2qXZLVlGZpxioDJKQQEA2A969el+PHcg
Y5us5H3K7G+4pHfURX7WThZI12ou7A4=
=s5c/
-----END PGP SIGNATURE-----

--STMSR9eJ4lVNPEOy--
