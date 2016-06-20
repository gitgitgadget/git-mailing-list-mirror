Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F2471FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 19:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546AbcFTTLn (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 15:11:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53348 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752485AbcFTTLl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 15:11:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B1D4024E3F;
	Mon, 20 Jun 2016 15:11:13 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZZXFbouDH0MYJUZlJQLUoO8hXjM=; b=FzmLnb
	p0Z5F2B5Nr8+Gc2LHucFGIINTdgf7ouO9kOy8gRa83oUXRywgtdMWFf/Kd6NncEn
	KQi1tmJDrc2Xl+yVRfMISyKiQdKoRMIzzbVssXL7tV7Tti5eagDorxMUsNaByOkA
	ix9g/cY57bsff8GnlfWocAJVSQRfelVyeXu1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ev9fstd5oUufETtyFWE+OrExBKw4LeX5
	9P1La9hII5dszXF0OKbWP/XLJ4NsFlMoGPR1+CzhvC3BDKZ58QBs8oJXu25R5NMU
	IK7PUSFL+wEjWMvafFho5Cjc8wV4xWB6f4E7yggM/SR5aGgUmqlDsdP5MEI2sgx3
	D9DXQuh4taQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A9C9924E3E;
	Mon, 20 Jun 2016 15:11:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2FD8924E3D;
	Mon, 20 Jun 2016 15:11:13 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] mingw: let the build succeed with DEVELOPER=1
References: <200865f29df65ccc53ed76029c7f38578430e487.1466253284.git.johannes.schindelin@gmx.de>
Date:	Mon, 20 Jun 2016 12:11:11 -0700
In-Reply-To: <200865f29df65ccc53ed76029c7f38578430e487.1466253284.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Sat, 18 Jun 2016 14:38:36 +0200
	(CEST)")
Message-ID: <xmqqinx3u14g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C13D043C-371A-11E6-B781-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The recently introduced developer flags identified a couple of
> old-style function declarations in the Windows-specific code where
> the parameter list was left empty instead of specifying "void"
> explicitly. Let's just fix them.

Thanks.  It's about time for them to be cleaned up.

Will queue.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	This came up when working on the rebase--helper changes.
>
> Published-As: https://github.com/dscho/git/releases/tag/mingw-dev-flags-v1
>  compat/mingw.c   | 6 +++---
>  compat/mingw.h   | 4 ++--
>  compat/winansi.c | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index a8218e6..2b5467d 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -2162,7 +2162,7 @@ int xwcstoutf(char *utf, const wchar_t *wcs, size_t utflen)
>  	return -1;
>  }
>  
> -static void setup_windows_environment()
> +static void setup_windows_environment(void)
>  {
>  	char *tmp = getenv("TMPDIR");
>  
> @@ -2204,7 +2204,7 @@ typedef struct {
>  extern int __wgetmainargs(int *argc, wchar_t ***argv, wchar_t ***env, int glob,
>  		_startupinfo *si);
>  
> -static NORETURN void die_startup()
> +static NORETURN void die_startup(void)
>  {
>  	fputs("fatal: not enough memory for initialization", stderr);
>  	exit(128);
> @@ -2224,7 +2224,7 @@ static char *wcstoutfdup_startup(char *buffer, const wchar_t *wcs, size_t len)
>  	return memcpy(malloc_startup(len), buffer, len);
>  }
>  
> -void mingw_startup()
> +void mingw_startup(void)
>  {
>  	int i, maxlen, argc;
>  	char *buffer;
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 69bb43d..9a8803b 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -532,8 +532,8 @@ extern CRITICAL_SECTION pinfo_cs;
>   * A replacement of main() that adds win32 specific initialization.
>   */
>  
> -void mingw_startup();
> -#define main(c,v) dummy_decl_mingw_main(); \
> +void mingw_startup(void);
> +#define main(c,v) dummy_decl_mingw_main(void); \
>  static int mingw_main(c,v); \
>  int main(int argc, char **argv) \
>  { \
> diff --git a/compat/winansi.c b/compat/winansi.c
> index 3be60ce..db4a5b0 100644
> --- a/compat/winansi.c
> +++ b/compat/winansi.c
> @@ -492,7 +492,7 @@ static inline ioinfo* _pioinfo(int fd)
>  			(fd & (IOINFO_ARRAY_ELTS - 1)) * sizeof_ioinfo);
>  }
>  
> -static int init_sizeof_ioinfo()
> +static int init_sizeof_ioinfo(void)
>  {
>  	int istty, wastty;
>  	/* don't init twice */
