From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/4] Actually remove compat fnmatch source code
Date: Sat, 15 Feb 2014 09:01:49 +0700
Message-ID: <1392429709-9237-5-git-send-email-pclouds@gmail.com>
References: <1392429709-9237-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 15 03:02:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEUaB-0004bC-SG
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 03:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbaBOCCI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Feb 2014 21:02:08 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:50983 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbaBOCCG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 21:02:06 -0500
Received: by mail-pa0-f52.google.com with SMTP id bj1so13001157pad.25
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 18:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gx7uRo3Fywyu1IB3sIK38eAEdHidtaJcjnqypf0C8Mw=;
        b=B6cyFyTIJlKd4upRMSoLAln4op4Iz7+YlgqbI/20/jm81da4k044IvGQ2aPMIOBdrv
         3DMRr1fzQHlnSKcPpi655nrH7ZQy983NJ/SDEEEAbjFKE+slDP0Ko5+a+1DF+gmCz+Ec
         0shP0WBYFaGOCnfvgNHg0bLBx9aQUr7Z6vV4YC69M1Otz50LdL/5Q+I2OacYqKziAiv/
         ruGsDi8YpE94N7CCVkHIW3+esqqBtiVo6dF9zOkS/wd02YSHtp6upRCi1Jl1tN217mad
         97RPnmW8HNCSOoSsIusKQ7QsQ54HPE9x2bHzIpMIfyXuqIKr2qUGcBJVEIY6VWOM24kd
         JYZQ==
X-Received: by 10.66.163.2 with SMTP id ye2mr12631265pab.110.1392429725436;
        Fri, 14 Feb 2014 18:02:05 -0800 (PST)
Received: from lanh ([115.73.215.60])
        by mx.google.com with ESMTPSA id om6sm21812844pbc.43.2014.02.14.18.02.02
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Feb 2014 18:02:04 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 15 Feb 2014 09:02:15 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392429709-9237-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242174>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 compat/fnmatch/fnmatch.c (gone) | 494 --------------------------------=
--------
 compat/fnmatch/fnmatch.h (gone) |  84 -------
 2 files changed, 578 deletions(-)

diff --git a/compat/fnmatch/fnmatch.c b/compat/fnmatch/fnmatch.c
deleted file mode 100644
index 378c467..0000000
--- a/compat/fnmatch/fnmatch.c
+++ /dev/null
@@ -1,494 +0,0 @@
-/* Copyright (C) 1991, 92, 93, 96, 97, 98, 99 Free Software Foundation=
, Inc.
-   This file is part of the GNU C Library.
-
-   This library is free software; you can redistribute it and/or
-   modify it under the terms of the GNU Library General Public License=
 as
-   published by the Free Software Foundation; either version 2 of the
-   License, or (at your option) any later version.
-
-   This library is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   Library General Public License for more details.
-
-   You should have received a copy of the GNU Library General Public
-   License along with this library; see the file COPYING.LIB.  If not,
-   write to the Free Software Foundation, Inc., 59 Temple Place - Suit=
e 330,
-   Boston, MA 02111-1307, USA.  */
-
-#if HAVE_CONFIG_H
-# include <config.h>
-#endif
-
-/* Enable GNU extensions in fnmatch.h.  */
-#ifndef _GNU_SOURCE
-# define _GNU_SOURCE	1
-#endif
-
-#include <stddef.h>
-#include <errno.h>
-#include <fnmatch.h>
-#include <ctype.h>
-
-#if HAVE_STRING_H || defined _LIBC
-# include <string.h>
-#else
-# include <strings.h>
-#endif
-
-#if defined STDC_HEADERS || defined _LIBC
-# include <stdlib.h>
-#endif
-
-/* For platforms which support the ISO C amendment 1 functionality we
-   support user defined character classes.  */
-#if defined _LIBC || (defined HAVE_WCTYPE_H && defined HAVE_WCHAR_H)
-/* Solaris 2.5 has a bug: <wchar.h> must be included before <wctype.h>=
=2E  */
-# include <wchar.h>
-# include <wctype.h>
-#endif
-
-/* Comment out all this code if we are using the GNU C Library, and ar=
e not
-   actually compiling the library itself.  This code is part of the GN=
U C
-   Library, but also included in many other GNU distributions.  Compil=
ing
-   and linking in this code is a waste when using the GNU C library
-   (especially if it is a shared library).  Rather than having every G=
NU
-   program understand `configure --with-gnu-libc' and omit the object =
files,
-   it is simpler to just do this in the source for each such file.  */
-
-#if defined NO_FNMATCH || defined NO_FNMATCH_CASEFOLD || \
-    defined _LIBC || !defined __GNU_LIBRARY__
-
-
-# if defined STDC_HEADERS || !defined isascii
-#  define ISASCII(c) 1
-# else
-#  define ISASCII(c) isascii(c)
-# endif
-
-# ifdef isblank
-#  define ISBLANK(c) (ISASCII (c) && isblank (c))
-# else
-#  define ISBLANK(c) ((c) =3D=3D ' ' || (c) =3D=3D '\t')
-# endif
-# ifdef isgraph
-#  define ISGRAPH(c) (ISASCII (c) && isgraph (c))
-# else
-#  define ISGRAPH(c) (ISASCII (c) && isprint (c) && !isspace (c))
-# endif
-
-# define ISPRINT(c) (ISASCII (c) && isprint (c))
-# define ISDIGIT(c) (ISASCII (c) && isdigit (c))
-# define ISALNUM(c) (ISASCII (c) && isalnum (c))
-# define ISALPHA(c) (ISASCII (c) && isalpha (c))
-# define ISCNTRL(c) (ISASCII (c) && iscntrl (c))
-# define ISLOWER(c) (ISASCII (c) && islower (c))
-# define ISPUNCT(c) (ISASCII (c) && ispunct (c))
-# define ISSPACE(c) (ISASCII (c) && isspace (c))
-# define ISUPPER(c) (ISASCII (c) && isupper (c))
-# define ISXDIGIT(c) (ISASCII (c) && isxdigit (c))
-
-# define STREQ(s1, s2) ((strcmp (s1, s2) =3D=3D 0))
-
-# if defined _LIBC || (defined HAVE_WCTYPE_H && defined HAVE_WCHAR_H)
-/* The GNU C library provides support for user-defined character class=
es
-   and the functions from ISO C amendment 1.  */
-#  ifdef CHARCLASS_NAME_MAX
-#   define CHAR_CLASS_MAX_LENGTH CHARCLASS_NAME_MAX
-#  else
-/* This shouldn't happen but some implementation might still have this
-   problem.  Use a reasonable default value.  */
-#   define CHAR_CLASS_MAX_LENGTH 256
-#  endif
-
-#  ifdef _LIBC
-#   define IS_CHAR_CLASS(string) __wctype (string)
-#  else
-#   define IS_CHAR_CLASS(string) wctype (string)
-#  endif
-# else
-#  define CHAR_CLASS_MAX_LENGTH  6 /* Namely, `xdigit'.  */
-
-#  define IS_CHAR_CLASS(string)						      \
-   (STREQ (string, "alpha") || STREQ (string, "upper")			      \
-    || STREQ (string, "lower") || STREQ (string, "digit")		      \
-    || STREQ (string, "alnum") || STREQ (string, "xdigit")		      \
-    || STREQ (string, "space") || STREQ (string, "print")		      \
-    || STREQ (string, "punct") || STREQ (string, "graph")		      \
-    || STREQ (string, "cntrl") || STREQ (string, "blank"))
-# endif
-
-/* Avoid depending on library functions or files
-   whose names are inconsistent.  */
-
-# if !defined _LIBC && !defined getenv
-extern char *getenv (const char *name);
-# endif
-
-# ifndef errno
-extern int errno;
-# endif
-
-# ifndef NULL
-#  define NULL 0
-# endif
-
-/* This function doesn't exist on most systems.  */
-
-# if !defined HAVE___STRCHRNUL && !defined _LIBC
-static char *
-__strchrnul (const char *s, int c)
-
-
-{
-  char *result =3D strchr (s, c);
-  if (result =3D=3D NULL)
-    result =3D strchr (s, '\0');
-  return result;
-}
-# endif
-
-# ifndef internal_function
-/* Inside GNU libc we mark some function in a special way.  In other
-   environments simply ignore the marking.  */
-#  define internal_function
-# endif
-
-/* Match STRING against the filename pattern PATTERN, returning zero i=
f
-   it matches, nonzero if not.  */
-static int internal_fnmatch __P ((const char *pattern, const char *str=
ing,
-				  int no_leading_period, int flags))
-     internal_function;
-static int
-internal_function
-internal_fnmatch (const char *pattern, const char *string, int no_lead=
ing_period, int flags)
-
-
-
-
-{
-  register const char *p =3D pattern, *n =3D string;
-  register unsigned char c;
-
-/* Note that this evaluates C many times.  */
-# ifdef _LIBC
-#  define FOLD(c) ((flags & FNM_CASEFOLD) ? tolower (c) : (c))
-# else
-#  define FOLD(c) ((flags & FNM_CASEFOLD) && ISUPPER (c) ? tolower (c)=
 : (c))
-# endif
-
-  while ((c =3D *p++) !=3D '\0')
-    {
-      c =3D FOLD (c);
-
-      switch (c)
-	{
-	case '?':
-	  if (*n =3D=3D '\0')
-	    return FNM_NOMATCH;
-	  else if (*n =3D=3D '/' && (flags & FNM_FILE_NAME))
-	    return FNM_NOMATCH;
-	  else if (*n =3D=3D '.' && no_leading_period
-		   && (n =3D=3D string
-		       || (n[-1] =3D=3D '/' && (flags & FNM_FILE_NAME))))
-	    return FNM_NOMATCH;
-	  break;
-
-	case '\\':
-	  if (!(flags & FNM_NOESCAPE))
-	    {
-	      c =3D *p++;
-	      if (c =3D=3D '\0')
-		/* Trailing \ loses.  */
-		return FNM_NOMATCH;
-	      c =3D FOLD (c);
-	    }
-	  if (FOLD ((unsigned char) *n) !=3D c)
-	    return FNM_NOMATCH;
-	  break;
-
-	case '*':
-	  if (*n =3D=3D '.' && no_leading_period
-	      && (n =3D=3D string
-		  || (n[-1] =3D=3D '/' && (flags & FNM_FILE_NAME))))
-	    return FNM_NOMATCH;
-
-	  for (c =3D *p++; c =3D=3D '?' || c =3D=3D '*'; c =3D *p++)
-	    {
-	      if (*n =3D=3D '/' && (flags & FNM_FILE_NAME))
-		/* A slash does not match a wildcard under FNM_FILE_NAME.  */
-		return FNM_NOMATCH;
-	      else if (c =3D=3D '?')
-		{
-		  /* A ? needs to match one character.  */
-		  if (*n =3D=3D '\0')
-		    /* There isn't another character; no match.  */
-		    return FNM_NOMATCH;
-		  else
-		    /* One character of the string is consumed in matching
-		       this ? wildcard, so *??? won't match if there are
-		       less than three characters.  */
-		    ++n;
-		}
-	    }
-
-	  if (c =3D=3D '\0')
-	    /* The wildcard(s) is/are the last element of the pattern.
-	       If the name is a file name and contains another slash
-	       this does mean it cannot match.  */
-	    return ((flags & FNM_FILE_NAME) && strchr (n, '/') !=3D NULL
-		    ? FNM_NOMATCH : 0);
-	  else
-	    {
-	      const char *endp;
-
-	      endp =3D __strchrnul (n, (flags & FNM_FILE_NAME) ? '/' : '\0');
-
-	      if (c =3D=3D '[')
-		{
-		  int flags2 =3D ((flags & FNM_FILE_NAME)
-				? flags : (flags & ~FNM_PERIOD));
-
-		  for (--p; n < endp; ++n)
-		    if (internal_fnmatch (p, n,
-					  (no_leading_period
-					   && (n =3D=3D string
-					       || (n[-1] =3D=3D '/'
-						   && (flags
-						       & FNM_FILE_NAME)))),
-					  flags2)
-			=3D=3D 0)
-		      return 0;
-		}
-	      else if (c =3D=3D '/' && (flags & FNM_FILE_NAME))
-		{
-		  while (*n !=3D '\0' && *n !=3D '/')
-		    ++n;
-		  if (*n =3D=3D '/'
-		      && (internal_fnmatch (p, n + 1, flags & FNM_PERIOD,
-					    flags) =3D=3D 0))
-		    return 0;
-		}
-	      else
-		{
-		  int flags2 =3D ((flags & FNM_FILE_NAME)
-				? flags : (flags & ~FNM_PERIOD));
-
-		  if (c =3D=3D '\\' && !(flags & FNM_NOESCAPE))
-		    c =3D *p;
-		  c =3D FOLD (c);
-		  for (--p; n < endp; ++n)
-		    if (FOLD ((unsigned char) *n) =3D=3D c
-			&& (internal_fnmatch (p, n,
-					      (no_leading_period
-					       && (n =3D=3D string
-						   || (n[-1] =3D=3D '/'
-						       && (flags
-							   & FNM_FILE_NAME)))),
-					      flags2) =3D=3D 0))
-		      return 0;
-		}
-	    }
-
-	  /* If we come here no match is possible with the wildcard.  */
-	  return FNM_NOMATCH;
-
-	case '[':
-	  {
-	    /* Nonzero if the sense of the character class is inverted.  */
-	    static int posixly_correct;
-	    register int not;
-	    char cold;
-
-	    if (posixly_correct =3D=3D 0)
-	      posixly_correct =3D getenv ("POSIXLY_CORRECT") !=3D NULL ? 1 : =
-1;
-
-	    if (*n =3D=3D '\0')
-	      return FNM_NOMATCH;
-
-	    if (*n =3D=3D '.' && no_leading_period && (n =3D=3D string
-						   || (n[-1] =3D=3D '/'
-						       && (flags
-							   & FNM_FILE_NAME))))
-	      return FNM_NOMATCH;
-
-	    if (*n =3D=3D '/' && (flags & FNM_FILE_NAME))
-	      /* `/' cannot be matched.  */
-	      return FNM_NOMATCH;
-
-	    not =3D (*p =3D=3D '!' || (posixly_correct < 0 && *p =3D=3D '^'))=
;
-	    if (not)
-	      ++p;
-
-	    c =3D *p++;
-	    for (;;)
-	      {
-		unsigned char fn =3D FOLD ((unsigned char) *n);
-
-		if (!(flags & FNM_NOESCAPE) && c =3D=3D '\\')
-		  {
-		    if (*p =3D=3D '\0')
-		      return FNM_NOMATCH;
-		    c =3D FOLD ((unsigned char) *p);
-		    ++p;
-
-		    if (c =3D=3D fn)
-		      goto matched;
-		  }
-		else if (c =3D=3D '[' && *p =3D=3D ':')
-		  {
-		    /* Leave room for the null.  */
-		    char str[CHAR_CLASS_MAX_LENGTH + 1];
-		    size_t c1 =3D 0;
-# if defined _LIBC || (defined HAVE_WCTYPE_H && defined HAVE_WCHAR_H)
-		    wctype_t wt;
-# endif
-		    const char *startp =3D p;
-
-		    for (;;)
-		      {
-			if (c1 > CHAR_CLASS_MAX_LENGTH)
-			  /* The name is too long and therefore the pattern
-			     is ill-formed.  */
-			  return FNM_NOMATCH;
-
-			c =3D *++p;
-			if (c =3D=3D ':' && p[1] =3D=3D ']')
-			  {
-			    p +=3D 2;
-			    break;
-			  }
-			if (c < 'a' || c >=3D 'z')
-			  {
-			    /* This cannot possibly be a character class name.
-			       Match it as a normal range.  */
-			    p =3D startp;
-			    c =3D '[';
-			    goto normal_bracket;
-			  }
-			str[c1++] =3D c;
-		      }
-		    str[c1] =3D '\0';
-
-# if defined _LIBC || (defined HAVE_WCTYPE_H && defined HAVE_WCHAR_H)
-		    wt =3D IS_CHAR_CLASS (str);
-		    if (wt =3D=3D 0)
-		      /* Invalid character class name.  */
-		      return FNM_NOMATCH;
-
-		    if (__iswctype (__btowc ((unsigned char) *n), wt))
-		      goto matched;
-# else
-		    if ((STREQ (str, "alnum") && ISALNUM ((unsigned char) *n))
-			|| (STREQ (str, "alpha") && ISALPHA ((unsigned char) *n))
-			|| (STREQ (str, "blank") && ISBLANK ((unsigned char) *n))
-			|| (STREQ (str, "cntrl") && ISCNTRL ((unsigned char) *n))
-			|| (STREQ (str, "digit") && ISDIGIT ((unsigned char) *n))
-			|| (STREQ (str, "graph") && ISGRAPH ((unsigned char) *n))
-			|| (STREQ (str, "lower") && ISLOWER ((unsigned char) *n))
-			|| (STREQ (str, "print") && ISPRINT ((unsigned char) *n))
-			|| (STREQ (str, "punct") && ISPUNCT ((unsigned char) *n))
-			|| (STREQ (str, "space") && ISSPACE ((unsigned char) *n))
-			|| (STREQ (str, "upper") && ISUPPER ((unsigned char) *n))
-			|| (STREQ (str, "xdigit") && ISXDIGIT ((unsigned char) *n)))
-		      goto matched;
-# endif
-		  }
-		else if (c =3D=3D '\0')
-		  /* [ (unterminated) loses.  */
-		  return FNM_NOMATCH;
-		else
-		  {
-		  normal_bracket:
-		    if (FOLD (c) =3D=3D fn)
-		      goto matched;
-
-		    cold =3D c;
-		    c =3D *p++;
-
-		    if (c =3D=3D '-' && *p !=3D ']')
-		      {
-			/* It is a range.  */
-			unsigned char cend =3D *p++;
-			if (!(flags & FNM_NOESCAPE) && cend =3D=3D '\\')
-			  cend =3D *p++;
-			if (cend =3D=3D '\0')
-			  return FNM_NOMATCH;
-
-			if (cold <=3D fn && fn <=3D FOLD (cend))
-			  goto matched;
-
-			c =3D *p++;
-		      }
-		  }
-
-		if (c =3D=3D ']')
-		  break;
-	      }
-
-	    if (!not)
-	      return FNM_NOMATCH;
-	    break;
-
-	  matched:
-	    /* Skip the rest of the [...] that already matched.  */
-	    while (c !=3D ']')
-	      {
-		if (c =3D=3D '\0')
-		  /* [... (unterminated) loses.  */
-		  return FNM_NOMATCH;
-
-		c =3D *p++;
-		if (!(flags & FNM_NOESCAPE) && c =3D=3D '\\')
-		  {
-		    if (*p =3D=3D '\0')
-		      return FNM_NOMATCH;
-		    /* XXX 1003.2d11 is unclear if this is right.  */
-		    ++p;
-		  }
-		else if (c =3D=3D '[' && *p =3D=3D ':')
-		  {
-		    do
-		      if (*++p =3D=3D '\0')
-			return FNM_NOMATCH;
-		    while (*p !=3D ':' || p[1] =3D=3D ']');
-		    p +=3D 2;
-		    c =3D *p;
-		  }
-	      }
-	    if (not)
-	      return FNM_NOMATCH;
-	  }
-	  break;
-
-	default:
-	  if (c !=3D FOLD ((unsigned char) *n))
-	    return FNM_NOMATCH;
-	}
-
-      ++n;
-    }
-
-  if (*n =3D=3D '\0')
-    return 0;
-
-  if ((flags & FNM_LEADING_DIR) && *n =3D=3D '/')
-    /* The FNM_LEADING_DIR flag says that "foo*" matches "foobar/frobo=
zz".  */
-    return 0;
-
-  return FNM_NOMATCH;
-
-# undef FOLD
-}
-
-
-int
-fnmatch (const char *pattern, const char *string, int flags)
-
-
-
-{
-  return internal_fnmatch (pattern, string, flags & FNM_PERIOD, flags)=
;
-}
-
-#endif	/* _LIBC or not __GNU_LIBRARY__.  */
diff --git a/compat/fnmatch/fnmatch.h b/compat/fnmatch/fnmatch.h
deleted file mode 100644
index cc3ec37..0000000
--- a/compat/fnmatch/fnmatch.h
+++ /dev/null
@@ -1,84 +0,0 @@
-/* Copyright (C) 1991, 92, 93, 96, 97, 98, 99 Free Software Foundation=
, Inc.
-   This file is part of the GNU C Library.
-
-   The GNU C Library is free software; you can redistribute it and/or
-   modify it under the terms of the GNU Library General Public License=
 as
-   published by the Free Software Foundation; either version 2 of the
-   License, or (at your option) any later version.
-
-   The GNU C Library is distributed in the hope that it will be useful=
,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   Library General Public License for more details.
-
-   You should have received a copy of the GNU Library General Public
-   License along with the GNU C Library; see the file COPYING.LIB.  If=
 not,
-   write to the Free Software Foundation, Inc., 59 Temple Place - Suit=
e 330,
-   Boston, MA 02111-1307, USA.  */
-
-#ifndef	_FNMATCH_H
-#define	_FNMATCH_H	1
-
-#ifdef	__cplusplus
-extern "C" {
-#endif
-
-#if defined __cplusplus || (defined __STDC__ && __STDC__) || defined W=
INDOWS32
-# if !defined __GLIBC__ || !defined __P
-#  undef	__P
-#  define __P(protos)	protos
-# endif
-#else /* Not C++ or ANSI C.  */
-# undef	__P
-# define __P(protos)	()
-/* We can get away without defining `const' here only because in this =
file
-   it is used only inside the prototype for `fnmatch', which is elided=
 in
-   non-ANSI C where `const' is problematical.  */
-#endif /* C++ or ANSI C.  */
-
-#ifndef const
-# if (defined __STDC__ && __STDC__) || defined __cplusplus
-#  define __const	const
-# else
-#  define __const
-# endif
-#endif
-
-/* We #undef these before defining them because some losing systems
-   (HP-UX A.08.07 for example) define these in <unistd.h>.  */
-#undef	FNM_PATHNAME
-#undef	FNM_NOESCAPE
-#undef	FNM_PERIOD
-
-/* Bits set in the FLAGS argument to `fnmatch'.  */
-#define	FNM_PATHNAME	(1 << 0) /* No wildcard can ever match `/'.  */
-#define	FNM_NOESCAPE	(1 << 1) /* Backslashes don't quote special chars=
=2E  */
-#define	FNM_PERIOD	(1 << 2) /* Leading `.' is matched only explicitly.=
  */
-
-#if !defined _POSIX_C_SOURCE || _POSIX_C_SOURCE < 2 || defined _GNU_SO=
URCE
-# define FNM_FILE_NAME	 FNM_PATHNAME	/* Preferred GNU name.  */
-# define FNM_LEADING_DIR (1 << 3)	/* Ignore `/...' after a match.  */
-# define FNM_CASEFOLD	 (1 << 4)	/* Compare without regard to case.  */
-#endif
-
-/* Value returned by `fnmatch' if STRING does not match PATTERN.  */
-#define	FNM_NOMATCH	1
-
-/* This value is returned if the implementation does not support
-   `fnmatch'.  Since this is not the case here it will never be
-   returned but the conformance test suites still require the symbol
-   to be defined.  */
-#ifdef _XOPEN_SOURCE
-# define FNM_NOSYS	(-1)
-#endif
-
-/* Match NAME against the filename pattern PATTERN,
-   returning zero if it matches, FNM_NOMATCH if not.  */
-extern int fnmatch __P ((__const char *__pattern, __const char *__name=
,
-			 int __flags));
-
-#ifdef	__cplusplus
-}
-#endif
-
-#endif /* fnmatch.h */
--=20
1.8.5.2.240.g8478abd
