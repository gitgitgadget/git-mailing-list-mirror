Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E6936309D
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661685; cv=none; b=aFXCAXU2X2QQeKUZurBKp7ODQBI9cR7a76cEU5/JMOsnGx2r1NrW4oHuB4Q1iqLxe2fgG1qWFU6o+oKUdbZhkddSES6/HzWyloln0bUFqMk9ElcDqpf5DH74HjcgDEcIOnY5JAS6WW9HDdDFnIWdjCTActyGgm58fY3W5xsCqNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661685; c=relaxed/simple;
	bh=U/VjxlQNmjrBb3tnWaIVUPyeH+u6KcvRDv010Ff6VSE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eEU79BESU9ixeabV1E+/fgQ1z5v3MOQSRkte84DDiVMKSx1DFPLJ865lL+x7PH80nV69y3GltIp6YzK3aMCttWbuIqJcNUnVIK6r+QOBR+XtUtzibesaZSLpv3l8zxA0Xw2SbNf3/DlLNQ7jmNOfMisMy9blAB4y5Mxu6O7rbMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cILAyA5z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o4r/WZGh; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cILAyA5z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o4r/WZGh"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A39C17A0277;
	Wed,  4 Mar 2026 17:01:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 04 Mar 2026 17:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772661680; x=1772748080; bh=2p0f0jHr6r
	p1qT7qyMQcue4E6hCY8aAqKYVOpWWUpkU=; b=cILAyA5zQBZYxJRZ4FRqkouWUL
	+aqjtsQq6TKi6xQZtuJvTsaF8uhdpRTvLVX7hyyQIciHCFNPHYKNI9EmdVzjmxDD
	dFg9fwfVROc1f4N3gv07TKhyDHse5gS2PgLUfvC5OJsBtYmBwQlppMFzh+8hqBfL
	9lkLLfWUgMMCyLb0pb6bnrwpK7qlLSZEPlyW5c9x2Y594+9oNNgusck12I0nqUdq
	IBR9fQQ9dPYB9c8MfuoFSQcxP08S03Z2GIkWKiZgDUoVYY/Z5SJ7lTeIS9CMYQWN
	vsmRZGb1tFsiCV8+DMjf7PuzICsTdc3WnH7B4Nj0JYYoOrR4tpCiGf+IitBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772661680; x=1772748080; bh=2p0f0jHr6rp1qT7qyMQcue4E6hCY8aAqKYV
	OpWWUpkU=; b=o4r/WZGhycP0A8M/UGtsYJbF2h8AlPAEGcM+Rp7wCpnmKnZscPu
	ShWniRQmsgleETtsaYhv33OD8+iy2RixMtcehblJ/MJga+SPdS+xpphbQxpo0B1A
	ZockboYhmOP3Uu7I3uP2L4l5LaM9yLfDCHRfcD65u07fcEHWpXQRz429do+Yd/qx
	eB+n5bPyUODrfZt8dOGyYvmIn6NIv+quiYsdtqziqxfn5vFxRX4gqY2j8zQqOlfO
	VvPLkDAEUh7VAlLuu5LcjS7WSe+dyEOCYGCPTlYFjy0Ccu0l0B3VinjnaXV3jwxV
	cxhOpoWWODmmyHiA1IhLnsR/axku9D5dylg==
X-ME-Sender: <xms:r6uoaYa1-Vug-KBRBPLXfXUL7kGdXqi3uE6PGFvLSFzvCbwPKxvfWg>
    <xme:r6uoaXHvYQXx4gxWGhm-Qvxk-ppLKUjrL2oCAruyDVu8iIJgmxN5v0k6Qb5JSplXY
    8Ktd7SNm_IKZAKMsiZeTiiKakLUBnTgEqp4Zv4_jLuRhqx1cTQ2>
X-ME-Received: <xmr:r6uoaczTwUrqTrQIRm5ck9hAi3StIdzIeJzBtXEHDwNAt-kZx7YOFvQ3CCfsnHlzIc1qOxThP8oF204AORBJ2SM6Cf3EFr8F2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieegieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhephefgtdehkeetueeigffgvdfhieeuheduffekveejhfduveekjeeifeegheej
    jeelnecuffhomhgrihhnpehnohhnshhtohhpthhoohhlshdrtghomhdpghhnuhdrohhrgh
    dpohhpvghnghhrohhuphdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtph
    htthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hmshhmihhlvgihsehgihhtlhgrsgdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegt
    rhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:r6uoaZnlzQT5TB6XSCJqC6Fy9fwZlYsyAfK3AV15z9XGnnAhMAwpFw>
    <xmx:r6uoaVkHdMWphyTO6vdH_cNPozOQADOlBM1ZrlMe9Uh94qjmKObGew>
    <xmx:r6uoabw1PdTwCY1wcTxkiJh6UPV4Mn-5msU4zibBKV5iRlH-lbwYDA>
    <xmx:r6uoaao_r_s1BYINOgPC3FxinGTv7qt7Ap95AwJtlnNSWoYyIP7Jkw>
    <xmx:sKuoabqSARyC01BGuwCQuby8-APw9g6j1Sg4GSMzcEGghItSzrKEeRQz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 17:01:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Matt Smiley <msmiley@gitlab.com>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 05/10] compat/posix: introduce writev(3p) wrapper
In-Reply-To: <20260303-pks-upload-pack-write-contention-v2-5-7321830f08fe@pks.im>
	(Patrick Steinhardt's message of "Tue, 03 Mar 2026 16:00:20 +0100")
References: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
	<20260303-pks-upload-pack-write-contention-v2-5-7321830f08fe@pks.im>
Date: Wed, 04 Mar 2026 14:01:18 -0800
Message-ID: <xmqqseaf5k5t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> In a subsequent commit we're going to add the first caller to
> writev(3p). Introduce a compatibility wrapper for this syscall that we
> can use on systems that don't have this syscall.
>
> The syscall exists on modern Unixes like Linux and macOS, and seemingly
> even for NonStop according to [1]. It doesn't seem to exist on Windows
> though.



>
> [1]: http://nonstoptools.com/manuals/OSS-SystemCalls.pdf
> [2]: https://www.gnu.org/software/gnulib/manual/html_node/writev.html
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Makefile         |  4 ++++
>  compat/posix.h   | 14 ++++++++++++++
>  compat/writev.c  | 29 +++++++++++++++++++++++++++++
>  config.mak.uname |  2 ++
>  meson.build      |  1 +
>  5 files changed, 50 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 7f37ad8f58..cb95ff2daf 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2021,6 +2021,10 @@ ifdef NO_PREAD
>  	COMPAT_CFLAGS += -DNO_PREAD
>  	COMPAT_OBJS += compat/pread.o
>  endif
> +ifdef NO_WRITEV
> +	COMPAT_CFLAGS += -DNO_WRITEV
> +	COMPAT_OBJS += compat/writev.o
> +endif
>  ifdef NO_FAST_WORKING_DIRECTORY
>  	BASIC_CFLAGS += -DNO_FAST_WORKING_DIRECTORY
>  endif
> diff --git a/compat/posix.h b/compat/posix.h
> index 245386fa4a..3c611d2736 100644
> --- a/compat/posix.h
> +++ b/compat/posix.h
> @@ -137,6 +137,9 @@
>  #include <sys/socket.h>
>  #include <sys/ioctl.h>
>  #include <sys/statvfs.h>
> +#ifndef NO_WRITEV
> +#include <sys/uio.h>
> +#endif
>  #include <termios.h>
>  #ifndef NO_SYS_SELECT_H
>  #include <sys/select.h>
> @@ -323,6 +326,17 @@ int git_lstat(const char *, struct stat *);
>  ssize_t git_pread(int fd, void *buf, size_t count, off_t offset);
>  #endif
>  
> +#ifdef NO_WRITEV
> +#define writev git_writev
> +#define iovec git_iovec
> +struct git_iovec {
> +	void *iov_base;
> +	size_t iov_len;
> +};
> +
> +ssize_t git_writev(int fd, const struct iovec *iov, int iovcnt);
> +#endif
> +
>  #ifdef NO_SETENV
>  #define setenv gitsetenv
>  int gitsetenv(const char *, const char *, int);
> diff --git a/compat/writev.c b/compat/writev.c
> new file mode 100644
> index 0000000000..b77e534d5d
> --- /dev/null
> +++ b/compat/writev.c
> @@ -0,0 +1,29 @@
> +#include "../git-compat-util.h"
> +#include "../wrapper.h"
> +
> +ssize_t git_writev(int fd, const struct iovec *iov, int iovcnt)
> +{
> +	size_t total_written = 0;
> +
> +	for (int i = 0; i < iovcnt; i++) {
> +		const char *bytes = iov[i].iov_base;
> +		size_t iovec_written = 0;
> +
> +		while (iovec_written < iov[i].iov_len) {
> +			ssize_t bytes_written = xwrite(fd, bytes + iovec_written,
> +						       iov[i].iov_len - iovec_written);
> +			if (bytes_written < 0) {
> +				if (total_written)
> +					goto out;
> +				return bytes_written;
> +			}
> +			if (!bytes_written)
> +				goto out;
> +			iovec_written += bytes_written;
> +			total_written += bytes_written;
> +		}
> +	}
> +
> +out:
> +	return cast_size_t_to_ssize_t(total_written);
> +}

Because we do not check the accumulation of bytes_written in the two
accumulator variables inside the inner loop, it is very possible for
total_written to wraparound size_t and end up below the largest
value possible to be stored in ssize_t type.

IOW, the cast_size_t_to_ssize_t() introduced in the previous step is
pointless, isn't it?

According to [*1*], the real

    ssize_t writev(int fd, const struct iovec *iov, int iovcnt)

is supposed to report error with errno set to EINVAL when the sum of
iov_len member of the iov[] array elements exceed half of the
maximum size_t.

       EINVAL The sum of the iov_len values overflows an ssize_t value.

So instead of dying with cast_size_t_to_ssize_t(), we probably would
want the check done in a more stupid and straight-forward way?
Adding up iov[i].iov_len while the addition would not wraparound in
each and every step, and return error with EINVAL before attempting
even a single call to xwrite(), and then have the above double loop
that does not care about integer wraparound at all, and return
total_written with simple cast to (ssize_t)?


[Reference]

 *1* https://pubs.opengroup.org/onlinepubs/9799919799/functions/writev.html


> diff --git a/config.mak.uname b/config.mak.uname
> index 5feb582558..ccb3f71881 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -459,6 +459,7 @@ ifeq ($(uname_S),Windows)
>  	SANE_TOOL_PATH ?= $(msvc_bin_dir_msys)
>  	HAVE_ALLOCA_H = YesPlease
>  	NO_PREAD = YesPlease
> +	NO_WRITEV = YesPlease
>  	NEEDS_CRYPTO_WITH_SSL = YesPlease
>  	NO_LIBGEN_H = YesPlease
>  	NO_POLL = YesPlease
> @@ -674,6 +675,7 @@ ifeq ($(uname_S),MINGW)
>  	pathsep = ;
>  	HAVE_ALLOCA_H = YesPlease
>  	NO_PREAD = YesPlease
> +	NO_WRITEV = YesPlease
>  	NEEDS_CRYPTO_WITH_SSL = YesPlease
>  	NO_LIBGEN_H = YesPlease
>  	NO_POLL = YesPlease
> diff --git a/meson.build b/meson.build
> index 762e2d0fc0..63514b6b84 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1409,6 +1409,7 @@ checkfuncs = {
>    'initgroups' : [],
>    'strtoumax' : ['strtoumax.c', 'strtoimax.c'],
>    'pread' : ['pread.c'],
> +  'writev' : ['writev.c'],
>  }
>  
>  if host_machine.system() == 'windows'
