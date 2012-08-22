From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: Porting git to HP NonStop
Date: Wed, 22 Aug 2012 18:30:15 +0200
Message-ID: <002a01cd8083$69fb9960$3df2cc20$@schmitz-digital.de>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de> <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com> <004701cd771e$21b7cbb0$65276310$@schmitz-digital.de> <CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com> <01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de> <7v628epzia.fsf@alter.siamese.dyndns.org> <000601cd7ebd$a4ef5740$eece05c0$@schmitz-digital.de> <7vy5l9lj6m.fsf@alter.siamese.dyndns.org> <001801cd7eee$24f95a50$6eec0ef0$@schmitz-digital.de> <7v4nnxld24.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Shawn Pearce'" <spearce@spearce.org>, <git@vger.kernel.org>,
	<rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 18:31:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Dph-0006bs-EW
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 18:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933060Ab2HVQa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 12:30:59 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:55241 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933021Ab2HVQa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 12:30:57 -0400
Received: from DualCore (dsdf-4d0a052e.pool.mediaWays.net [77.10.5.46])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0LtlMD-1Tl5Zo3VhN-011DHW; Wed, 22 Aug 2012 18:30:22 +0200
In-Reply-To: <7v4nnxld24.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJtb+yK82c1fE/4VXt1krEuodTb9QKmN7EfAdIAjkoB0Br5KAKVWWsnAm8TuDMCb+a+7QMjYLRhAalBYtECWH7b+ZV/EI2A
Content-Language: de
X-Provags-ID: V02:K0:0mmykqL9Wb1J5fOcJrRrPdN2TQZq6c+waR/WI/PkOZ7
 ZToutVAMLVj5xAgGbLIyqtszOi+Ivp8dXhOcM/Bu28fAJ2hit/
 l93B4ivS4TxUYStwJJSZlx+BbhbeloV8KxCwjfM5es5wYzcF4R
 OxXJ2aQqNSKKjYMODhG9zTKQevZ0r8/lSRyyfS2dqig+8HjrNo
 tdi8TUJV2yZWMQ9zvTf5iyG5q5RhEBAucV+2Yl0Ct75hG42JG0
 LfDFW6OQt3+rr3WUJeu0eYjIh35WtPPkUWKq26HJLySacxEoMf
 8B+VYYFVn/o+j1hLOCI/HaYztsITtw0qQLvfc8t3io8ZVYX/Vr
 msQeHrqh10ny+HOOlkQFEtXAwS+4HCchgo+T0Ymb6vN/fZfF1c
 qULEQ7fA0R8qQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204026>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Monday, August 20, 2012 6:54 PM
> To: Joachim Schmitz
> Cc: 'Shawn Pearce'; git@vger.kernel.org; rsbecker@nexbridge.com
> Subject: Re: Porting git to HP NonStop
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> > I haven't found any other to be needed. Well, poll, maybe, but with
> > only minor tweaks for the win32 one works for me (and those tweaks are
> > compatible with win32
> >
> >> A separate file, compat/tandem/mkdir.c, is fine, though.
> 
> If you wouldn't have dozens of them, so compat/tandem/mkdir.c is not
suitable;
> compat/tandem.c would be good, then.
> 
> >> > I'll go for git_mkdir(), similar to other git wrappers, (like for
> >> > mmap, pread, fopen, snprintf, vsnprintf, qsort).
> >>
> >> Again, no.  Your breakage is that having underlying system mkdir that
> >> does
> > not
> >> understand trailing slash, which may not be specific to __TANDEM, but
> > still is
> >> _not_ the only possible mode of breakage.

True.

> > Well, it is the only one GNUlib's mkdir caters for and I'd regard that
> > an authoritative source...
> 
> I suspect that you may be misunderstanding what compat/ is about

I don't think so, it server the same purpose for git as gnulib does for
others.

>, so let's try again.
> Platform difference in mkdir may not be limited to "on this platform, the
> underlying one supplied by the system does not like path ending with a
slash".
> 
> What I am saying is that it is unacceptable to call something that caters
to that
> specific kind of difference from what the codebase expects with a generic
> name such as "git_mkdir()".  Look at mingw's replacement.  The platform
> difference over there is that the one from the system does not take mode
> parameter.  Imagine that one was already called "git_mkdir()".  Now we
have
> two different kind of differences, and one has more officially-looking
> "git_mkdir()" name; yours cannot take it---what would you do in that case?
> Neither kind of difference is more officially sanctioned difference; don't
call
> yours any more official/generic than necessary.

Gnulib's rpl_mkdir caters for 3 possible problems, the WIN32 one which mkdir
taking only one argument, the trailing slash one discussed here (victims
being at least NetBSD 1.5.2 and current HP NonStop) and a trailing dot one
(that allegedly Cygwin 1.5 suffered from).

As far as I can see git will not suffer from the latter, but even if, at
that time a git_mkdir() could be expanded to cater for this to, just like
gnulib's one does, there it is an additional section inside their
rpl_mkdir().
And the WIN32 one is already being taken care of in compat/mingw.h. However,
this could as easily get integrated into 
a git_mkdir(), just like in gnulib.

> Your wrapper is not limited to tandem, but is applicable to ancient BSDs,
so it is
> fine to call it as compat_mkdir_wo_trailing_slash(), so that it can be
shared
> among platforms whose mkdir do not want to see trailing slashes.  If you
are
> going that route, the function should live in its own file (without any
other
> wrapper), and not be named after specific platform (should be named after
the
> specific difference from what we expect, instead).  I am perfectly fine
with that
> approach as well.
> 
> >> Squatting on a generic "git_mkdir()" name makes it harder for other
> >> people
> > to
> >> name their compat mkdir functions to tweak for the breakage on their
> >> platforms.  The examples you listed are all "the platform does not
> >> offer
> > it, so
> >> we implement the whole thing" kind, so it is in a different genre.
> >
> > Nope, git_fopen() definitly is a wrapper for fopen(), as is
> > git_vsnprintf() for vsnprintf().
> 
> I was talking more about mmap() and pread().
> 
> For the two you mentioned, ideally they should have been named after the
> specific breakages they cover (fopen that does not error out on
directories is
> primarily AIX thing IIRC, and snprintf returns bogus result are shared
between
> HPUX and Windows), but over these years we haven't seen any other kind of
> differences from various platforms, so the need to rename them away is
very
> low.
> 
> On the other hand, we already know there are at least two kinds of
platform
> mkdir() that need different compat/ layer support, so calling one
"git_mkdir()"
> to cover one particular kind of difference does not make any sense.
> 
> Besides, an earlier mistake is not a valid excuse to add new mistakes.

OK, so how about this:
/usr/local/bin/diff -EBbu ./compat/mkdir.c.orig ./compat/mkdir.c
--- ./compat/mkdir.c.orig       2012-08-21 05:02:11 -0500
+++ ./compat/mkdir.c    2012-08-21 05:02:11 -0500
@@ -0,0 +1,24 @@
+#include "../git-compat-util.h"
+#undef mkdir
+
+/* for platforms that can't deal with a trailing '/' */
+int compat_mkdir_wo_trailing_slash(const char *dir, mode_t mode)
+{
+       int retval;
+       char *tmp_dir = NULL;
+       size_t len = strlen(dir);
+
+       if (len && dir[len-1] == '/') {
+               if ((tmp_dir = strdup(dir)) == NULL)
+                       return -1;
+               tmp_dir[len-1] = '\0';
+       }
+       else
+               tmp_dir = (char *)dir;
+
+       retval = mkdir(tmp_dir, mode);
+       if (tmp_dir != dir)
+               free(tmp_dir);
+
+       return retval;
+}

BTW: I've just today reported that mkdir bug to HP NonStop development.
Let's see how fast they fix it and whether at all, but I'd be pretty
surprised if that happened earlier than 6 months from now.

Bye, Jojo
