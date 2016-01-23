From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 1/4] Refactor skipping DOS drive prefixes
Date: Sat, 23 Jan 2016 09:25:41 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601230924090.2964@virtualbox>
References: <cover.1452536924.git.johannes.schindelin@gmx.de> <cover.1452585382.git.johannes.schindelin@gmx.de> <05cb9e00756e8a364f972cd227804764f6a6380c.1452585382.git.johannes.schindelin@gmx.de> <56A279DA.8080809@kdbg.org>
 <xmqq60ylv3bk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 09:26:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMtWC-0006dx-68
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jan 2016 09:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbcAWIZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2016 03:25:57 -0500
Received: from mout.gmx.net ([212.227.15.18]:59803 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706AbcAWIZz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2016 03:25:55 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lug8u-1ZwfX52Eue-00zr8i; Sat, 23 Jan 2016 09:25:43
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq60ylv3bk.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Aq//rUWCbRPYlbKhVGh/WwP2ES5A2uF4v7/d0RClyAtPSHPYKwN
 DAUzUH0iXg9//gfc2UpwxnBKCH2GDkPGGFEaHx6qERUnhAiQreomNoYD/B9PYJ/6yx86ja4
 lxoh69FhWaDtNBb3A90t2UN1sb7WkEDhFdgevP3mldvjy/oR/vI5K15wg7LL1ebDnNdBm02
 /URx0k+Kw9tPDEO73mF5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lrAc7gcz18M=:MduinmWmWSOASq5qRUX/Bx
 wSKaEZ+JJ0a4rr9qYf1jNnDAjZkkRwCmGXqIGx+EmE9Sjq0XBueyKefZGEyIOkIuUZChGJxdo
 iXbUj77sGhGThJ0b7iZfzMWg5KoBx4Yp9dG8BE5xvaL8bbxawF7fLZEam6x1/BSxSASHnaveQ
 IY9fFTX5bErNv8lBcbK3uQeKA8M9w6N+QWjrVrDtQaKRRVmGKUAikdY2UpwNsyahKlZC35mMh
 eoElAwdGHmKYjohRZr5ls60tCmRkIuCWJgQXJNiu3P6Q/SD0Fm36LZ+BtKvgv/b3kzlnHb6hE
 dBt/tx9vdp5jS5QvqI7E+F80B39akcnlWFu0hTSFjB9sROCH0d0ruTa0xOjcDmvpSNmo+4Rap
 PjaDtantqewRFTEhkrrDAs1WI4nbxhRfI64eL2tRv9FXsMlwHK0q+nbeA5q4HBKPsX77dUrnA
 0n1cl5cnqPmmxzhUwEQ5LAH6YBdlOApFnbA6A1WZpMNbCyfcCUhaiGbMScQS/wen/UPoIMOYm
 LIMtx+szQutLXgy6sDQFR00ii1Om7tKWxl9g42FTm21u0gQm2+A7XgoCqcZl8np0qehI3zG+G
 V2e47udliywOfTuhcDyU2b+bMGoWwg0VNKjHmATRwc/7d88dbSkBDJMUTQo1XUEYHyF7xwASL
 We3sTqIFis7WRNkOu7I8MYxWkcQQTA9mYOZy3iaPDSdzT6Z/ZUG2vPl/ynvGEchCVgxpz+WM5
 wJkEJaBQccZFCDA1MFPndYH3UAvihbBqC6/+a8IL2gRvV2STN2NW2zPq59Mv3i+k6GR/HULC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284626>

Hi Junio,

On Fri, 22 Jan 2016, Junio C Hamano wrote:

> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > I suggest to move the function definition out of line:
> >
> > diff --git a/compat/mingw.c b/compat/mingw.c
> > index 10a51c0..0cebb61 100644
> > --- a/compat/mingw.c
> > +++ b/compat/mingw.c
> > @@ -1915,6 +1915,13 @@ pid_t waitpid(pid_t pid, int *status, int options)
> >  	return -1;
> >  }
> >  
> > +int mingw_skip_dos_drive_prefix(char **path)
> > +{
> > +	int ret = has_dos_drive_prefix(*path);
> > +	*path += ret;
> > +	return ret;
> > +}
> > +
> >  int mingw_offset_1st_component(const char *path)
> >  {
> >  	char *pos = (char *)path;
> > diff --git a/compat/mingw.h b/compat/mingw.h
> > index 9b5db4e..2099b79 100644
> > --- a/compat/mingw.h
> > +++ b/compat/mingw.h
> > @@ -360,12 +360,7 @@ HANDLE winansi_get_osfhandle(int fd);
> >  
> >  #define has_dos_drive_prefix(path) \
> >  	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
> > -static inline int mingw_skip_dos_drive_prefix(char **path)
> > -{
> > -	int ret = has_dos_drive_prefix(*path);
> > -	*path += ret;
> > -	return ret;
> > -}
> > +int mingw_skip_dos_drive_prefix(char **path);
> >  #define skip_dos_drive_prefix mingw_skip_dos_drive_prefix
> >  #define is_dir_sep(c) ((c) == '/' || (c) == '\\')
> >  static inline char *mingw_find_last_dir_sep(const char *path)
> 
> This sounds good to me.  Dscho?

Yep, sounds good to me, too.

Personally, I have no inclination to add compatibility with the
now-safely-obsolete MSys to my responsibilities, but if Hannes wants to do
it, who am I to stand in his way? Especially when the fix is as trivial as
here.

Ciao,
Dscho
