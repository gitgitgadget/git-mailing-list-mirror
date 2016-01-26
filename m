From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 05/19] mingw: prepare the TMPDIR environment variable
 for shell scripts
Date: Tue, 26 Jan 2016 09:38:05 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601260934040.2964@virtualbox>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <80795bee09974f4bec6bda75fe9cb17a4326bed1.1453650173.git.johannes.schindelin@gmx.de> <CAPig+cTF0r1Z_4wre57pZHvPXT00TvhYTKmdHfDfTBZzMwdo+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 09:38:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNz8o-0005bh-Qt
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 09:38:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbcAZIiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 03:38:19 -0500
Received: from mout.gmx.net ([212.227.17.21]:56989 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752280AbcAZIiR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 03:38:17 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MVJze-1ablYX48Uw-00Ylg4; Tue, 26 Jan 2016 09:38:08
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAPig+cTF0r1Z_4wre57pZHvPXT00TvhYTKmdHfDfTBZzMwdo+A@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:YquParjSMAVNg/JfKT9QnZIkZ6j4/dKb+Y+BeUmLdqABSwi0jy4
 fbL9UyXdPMuaBZ9U0GVy+j6PzHhs5X2X3KghGbeoiCXOnnjBdZRLSP+n3ZLvlA7MaBnQMF4
 GEzFwLAt3k6WzF2OKug6pg79j1jNKKrYNzkYNYJRftvEwpC3PkJgk9S2+JhSHLleX0gikdk
 5OzsVotmX61tkI+GW1r4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ycrau698oWI=:7DVLNzwU89mL/gGhu3894P
 /94ounLc0uUXc/rgIvOzanhFcTqNm7XiLP8bUfr5r3rHaTNlOl6jIoSzlo4MxGEq6zDsXsd3A
 +YgaxuITImuRiHJ6nNW23aZoef9zsPGaCIMwCC4ga9/cuj7O5j4DnBG4NgQe2uVIvhOR8qiVA
 1L+VlPnrWzQMKCeph2Ww0T3WIHtXGjQy3BrPARHzOhhK+6mlE5CH36ixMvJ0LEDVc/h1uBr+9
 5vtRWTr6YgGvJWYakYDYt9P/WCqa5LXUAA5pdPAA/3GH9FEKfmBHR2DIr+uVn4IN5YC95vnPD
 ayf19T22q9y+9wueyLeDnPlDRrtCIi6g2vXs8mG5Vrs6U+v3sYKEwmHb/Uw4EecHnyKJHYfy+
 lH/3ZKKdhLpzUzikYhT7j4AZA/G20GzlZ8p12nDaimvkslT6fexF46YgXqeSfEH9EXBfTOePl
 Neejp5eYWyh/H9KUOTxIJNQHRf8gA0E0bfT3p5wCjhSZDGawVkSOUn6N6reUce9YBhc5ksCrJ
 jUvkmh4QniKi5VWaGZd/ZA57n/AOiAR97BQtVQpQTLzVr6dwsSor3jxJQ6ZeqclM8V+5Dl+8r
 03iPa7HT4KEubN+afccQsMWuEQLd1rfqCnS70VGFQemQbpUd2iTBHUs8gvr/qKB1RUkDfsBrZ
 gAwlX/LXue9XTbwBKT0QHCdJf55ZcZ5t+nGxJPy0e8AHES23RI9bCojap0H2A66c3wkakb5sB
 64iR5NPGktVQlYmkIRaDrSedKrVBVq39w4SdonDzNAi5ubWxWKHvP9elkSfhJzAOYnKcz1CN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284787>

Hi Eric,

On Sun, 24 Jan 2016, Eric Sunshine wrote:

> On Sun, Jan 24, 2016 at 10:43 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > When shell scripts access a $TMPDIR variable containing backslashes,
> > they will be mistaken for escape characters. Let's not let that happen
> > by converting them to forward slashes.
> >
> > This partially fixes t7800 with MSYS2.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/compat/mingw.c b/compat/mingw.c
> > @@ -2042,13 +2042,28 @@ int xwcstoutf(char *utf, const wchar_t *wcs, size_t utflen)
> >  static void setup_windows_environment()
> >  {
> > +       char *tmp = getenv("TMPDIR");
> > +
> >         /* on Windows it is TMP and TEMP */
> > -       if (!getenv("TMPDIR")) {
> > -               const char *tmp = getenv("TMP");
> > -               if (!tmp)
> > +       if (tmp) {
> > +               if (!(tmp = getenv("TMP")))
> >                         tmp = getenv("TEMP");
> > -               if (tmp)
> > +               if (tmp) {
> >                         setenv("TMPDIR", tmp, 1);
> > +                       tmp = getenv("TMPDIR");
> > +               }
> > +       }
> 
> Let me see if I understand this...
> 
> In the original code, if TMPDIR was *not* set, it would assign the
> value of TMP or TEMP to TEMPDIR.
> 
> The new code, however, checks TMP and TEMP only if TMPDIR is *already*
> set. Am I reading this correctly? Is this revised behavior correct?

Gaaah! When copy-pasting, I culled the exclamation point... Will be fixed
in v2 (see https://github.com/dscho/git/commit/909b0a413)

> > +       if (tmp) {
> > +               /*
> > +                * Convert all dir separators to forward slashes,
> > +                * to help shell commands called from the Git
> > +                * executable (by not mistaking the dir separators
> > +                * for escape characters).
> > +                */
> > +               for (; *tmp; tmp++)
> > +                       if (*tmp == '\\')
> > +                               *tmp = '/';
> 
> This transformation is performed on whatever memory was returned by
> getenv(). It is also performed after setenv(), so presumably setenv()
> isn't making a copy of the incoming string.

Actually, I made sure to re-getenv() after setenv():

	https://github.com/dscho/git/blob/909b0a413/compat/mingw.c#L2053

Thanks!
Dscho
