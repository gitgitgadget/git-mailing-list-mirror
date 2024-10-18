Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AFAF9E6
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259396; cv=none; b=K7mUSoXtoTEzGp2ZtbDnzaE6zLiSXLgPibVFlZKe7/UWyTbgkJr/6gsoaTGH9Rz9F3I9M39kxU7mm1LvyueI0AOpn8GdJUOuvZuaLlphLAuh+zVpZnDSxhvIvc6Yq3f1wAI0eB/ljIvT7WaNENHYIfOX2Wx1Z77BrlrqmBsTpb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259396; c=relaxed/simple;
	bh=ZGQBvEM43ddZqLnCvue0gJMh2pnVErPUM82U0Prm+60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7Lg0/wdSR2d4pwfJj4ScairIK+fMUKRCX7l0bVfd4hgaPc8Dx1yWxUWCsePXb8yekXOA+5YTN7NuDO3WBnNPGJ9Dii78xMbRzOdr2m/9k4G+c8eZUgc/9X8YDschJoyzw4+AolMfDb5Pc8Dv7CTyeadWF7CsIxlWvaLdqdhSY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPWA8wiS; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPWA8wiS"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e467c3996so1381440b3a.2
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 06:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729259394; x=1729864194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lv6WomhkHTLPkpmOzeXBGWMi8d/9NgCBTjpswfg2Gxw=;
        b=nPWA8wiS9ajuFaQE1QGNrsq+w+p3MOI5vcSnDBI3xHLWkGnJcEXsqJNoVmx7OzlXxC
         HvyIDnvS1tvfGFZ5hP7ACqaFOkxWT6j/0y1tIxYDWo2staPL3ouTseOOXSug3YpkTNxu
         GjWTJ3gkh+ZxO9EuaRf0XybuRqCMXrNI3rodh085RBIFLO3oOcljM7O7M7Yy0VH/OmFy
         yk64c0UhL7nu5fu1kwCQw3CqX4s94HHyxPCpepV4shW2UmSNJdYrFVqEURFGhhTM2rjX
         DmLwIVUFchDr4nNupoCUIirNj+V9ZHTwHdfZ3LKFUcTb6WU12pNgGAkfXQ49agRefwly
         EMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729259394; x=1729864194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lv6WomhkHTLPkpmOzeXBGWMi8d/9NgCBTjpswfg2Gxw=;
        b=F8U+V1oys/2r+wKo1EFpwBBJp/+QADYpjcJeMfJ2e4Umt1YHco17SEmRYIi1FQTZ3+
         STngv51vP1k+HpFsMDlSUDbN+WYrb8KVWoEBW/v/adUPr5Q3SpGYUBaTwEmYvYQ+oR23
         FC76dEC7GCDaKcALhM0ojXUqQe4Z9ocXHah+IG8zz8rca4W25n50vnBhexuWQSxj4X7U
         GvAKjgJ2blFNGJBfI/PM5rP+sWbLsM8hTDCitVAxyxwIauLZ8g8/kvW8GSaVg4zVkfo5
         IoPxXJLWvYpj0bNyfAO0KBXBUidrPDO3/hniJsYk5w2SEI7FQ25Bja9diO9nwUL/tkIm
         MDaw==
X-Gm-Message-State: AOJu0YzahABftew8Z4GkBMyBbv4UMMP5Ck3KWS6UAPmE+Vgyr26iE36s
	fjSc7sWInZ57s86jlZUh35oBOE61UeScAo9uvikyBJydnQejDjn/
X-Google-Smtp-Source: AGHT+IHKoWMkD9bny/jO1DZVAenTjFjBowsTTU2XxpHJbIkRLC3mQaOZ3eRU5iBHU/F+d58n/3YTxA==
X-Received: by 2002:a05:6a21:78b:b0:1cf:ff65:22f4 with SMTP id adf61e73a8af0-1d92c5ac004mr3373473637.41.1729259393509;
        Fri, 18 Oct 2024 06:49:53 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea34b36f3sm1429162b3a.212.2024.10.18.06.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 06:49:52 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 568274433457; Fri, 18 Oct 2024 20:49:49 +0700 (WIB)
Date: Fri, 18 Oct 2024 20:49:49 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Patrick Steinhardt <ps@pks.im>, Edgar Bonet <bonet@grenoble.cnrs.fr>
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: clar unit testing framework FTBFS on uclibc systems (wchar_t
 unsupported)
Message-ID: <ZxJnfYtuxnAEBc1E@archie.me>
References: <ZxCJqe4-rsRo1yHg@archie.me>
 <ZxESP0xHV4cK64i0@pks.im>
 <ZxEXFI80i4Q_4NJT@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LaxtlXrEIYgXMuMy"
Content-Disposition: inline
In-Reply-To: <ZxEXFI80i4Q_4NJT@pks.im>


--LaxtlXrEIYgXMuMy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 03:54:28PM +0200, Patrick Steinhardt wrote:
> Okay, uclibc indeed has _optional_ support for `wchar_t`. But what
> really throws me off: "include/wchar.h" from uclibc has the following
> snippet right at the top:
>=20
>     #ifndef __UCLIBC_HAS_WCHAR__
>     #error Attempted to include wchar.h when uClibc built without wide ch=
ar support.
>     #endif
>=20
> We unconditionally include <wchar.h>, and your system does not seem to
> have support for it built in. So why doesn't the `#error` trigger? It's
> also not like this is a recent error, it has been added with 581deed72
> (The obligatory forgotten files..., 2002-05-06).
>=20
> We can do something like the below patch in clar, but I'd first like to
> understand why your platform seems to be broken in such a way.
>=20
> Patrick
>=20
> diff --git a/clar.c b/clar.c
> index 64879cf..06fe3d1 100644
> --- a/clar.c
> +++ b/clar.c
> @@ -9,6 +9,11 @@
>  #define _DARWIN_C_SOURCE
>  #define _DEFAULT_SOURCE
> =20
> +#if defined(__UCLIBC__) && ! defined(__UCLIBC_HAS_WCHAR__)
> +#else
> +#	define HAVE_WCHAR
> +#endif
> +
>  #include <errno.h>
>  #include <setjmp.h>
>  #include <stdlib.h>
> @@ -16,7 +21,9 @@
>  #include <string.h>
>  #include <math.h>
>  #include <stdarg.h>
> +#ifdef HAVE_WCHAR
>  #include <wchar.h>
> +#endif
>  #include <time.h>
>  #include <inttypes.h>
> =20
> @@ -766,6 +773,7 @@ void clar__assert_equal(
>  			}
>  		}
>  	}
> +#ifdef HAVE_WCHAR
>  	else if (!strcmp("%ls", fmt)) {
>  		const wchar_t *wcs1 =3D va_arg(args, const wchar_t *);
>  		const wchar_t *wcs2 =3D va_arg(args, const wchar_t *);
> @@ -801,6 +809,7 @@ void clar__assert_equal(
>  			}
>  		}
>  	}
> +#endif // HAVE_WCHAR
>  	else if (!strcmp("%"PRIuMAX, fmt) || !strcmp("%"PRIxMAX, fmt)) {
>  		uintmax_t sz1 =3D va_arg(args, uintmax_t), sz2 =3D va_arg(args, uintma=
x_t);
>  		is_equal =3D (sz1 =3D=3D sz2);
>=20

Hi,

On Buildroot site, Edgar Bonet (Cc:'ed) suggests to improve your patch by
wrapping strcmps [1]:

---- >8 ----
diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
index cef0f023c2..6de0b415b1 100644
--- a/t/unit-tests/clar/clar.c
+++ b/t/unit-tests/clar/clar.c
@@ -18,6 +18,13 @@
 #include <sys/types.h>
 #include <sys/stat.h>
=20
+#if defined(__UCLIBC__) && ! defined(__UCLIBC_HAS_WCHAR__)
+   /* uClibc can be built without wchar support, in which case the
+      installed <wchar.h> is a stub that does not define wchar_t. */
+#else
+#  define HAVE_WCHAR
+#endif
+
 #ifdef _WIN32
 #	define WIN32_LEAN_AND_MEAN
 #	include <windows.h>
@@ -763,6 +770,7 @@ void clar__assert_equal(
 			}
 		}
 	}
+#ifdef HAVE_WCHAR
 	else if (!strcmp("%ls", fmt)) {
 		const wchar_t *wcs1 =3D va_arg(args, const wchar_t *);
 		const wchar_t *wcs2 =3D va_arg(args, const wchar_t *);
@@ -798,6 +806,7 @@ void clar__assert_equal(
 			}
 		}
 	}
+#endif // HAVE_WCHAR
 	else if (!strcmp("%"PRIuZ, fmt) || !strcmp("%"PRIxZ, fmt)) {
 		size_t sz1 =3D va_arg(args, size_t), sz2 =3D va_arg(args, size_t);
 		is_equal =3D (sz1 =3D=3D sz2);

Thanks.

[1]: https://lore.kernel.org/buildroot/f517190c-6fcd-4101-afa6-f6ea521feb9e=
@grenoble.cnrs.fr/

--=20
An old man doll... just what I always wanted! - Clara

--LaxtlXrEIYgXMuMy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZxJndQAKCRB7tWyQc2rT
CB/LAP9FnY346y/Db8Q+6WIdP8mUFQSpA/UMQh8vy2WPoOULmQEAxiXl7ghCqzNv
m/T8FvoU/Vl3wqBPajSZ9IyDqTU5NQM=
=jzNR
-----END PGP SIGNATURE-----

--LaxtlXrEIYgXMuMy--
