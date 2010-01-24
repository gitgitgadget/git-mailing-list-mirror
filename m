From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git 1.6.6.1 on glibc 2.2
Date: Sun, 24 Jan 2010 11:40:08 -0600
Organization: 
Message-ID: <20100124174008.GA7622@progeny.tock>
References: <x6y6jn4txy@gzp>
 <20100124122751.GA3265@progeny.tock>
 <x6d40zmte6@gzp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Gabor Z. Papp" <gzp@papp.hu>
X-From: git-owner@vger.kernel.org Sun Jan 24 18:40:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ6Rg-00019q-Km
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 18:40:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665Ab0AXRkP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jan 2010 12:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753431Ab0AXRkO
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 12:40:14 -0500
Received: from mail-iw0-f196.google.com ([209.85.223.196]:56083 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379Ab0AXRkN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 12:40:13 -0500
Received: by iwn34 with SMTP id 34so2251723iwn.21
        for <git@vger.kernel.org>; Sun, 24 Jan 2010 09:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=6gS+McVorY1aieeIeH+wBxTyeaQ8iuCXaYscCwLmQIU=;
        b=E375kOJ5y5l0pDPEBJs7wPXAB1T4XBgGdUjqT+2kUhgcEFVXvUXhnHa+C7+G5yMwH+
         5oAZeBxg2OpgVK+J6Z9uRnM9dxieoplKgy3eDr6vavjWMWZ+azYzlr9PtFLGp5uLg+7q
         7B/6wtSYUU6rgS6V0Z2gQjhaRQ7W05377YIQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=p84o2qu2/jzHZsQkMjMzJYZqcdXO7QTzUr5fE1qXxSEYWPxBLqSYgM2RAVAUaIP7h+
         eitd5deGdvwKUww960uvz82ZL15EKqCGtHuvbPgTww/s1EZ+tA8IpOiwuERCXSUfYgVM
         HKrIKD6RNRr/ntp8mYIrumY/uAB3cyPaQSUxc=
Received: by 10.231.162.9 with SMTP id t9mr17707ibx.5.1264354812245;
        Sun, 24 Jan 2010 09:40:12 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm4160001iwn.12.2010.01.24.09.40.11
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 24 Jan 2010 09:40:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <x6d40zmte6@gzp>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137904>

Gabor Z. Papp wrote:
>| Gabor Z. Papp wrote:
=20
>|> trying to compile git 1.6.6.1 on Linux 2.4.37.7, glibc 2.2.5:
>|>=20
>|> read-cache.c: In function 'fill_stat_cache_info':
>|> read-cache.c:72: error: 'struct stat' has no member named 'st_ctim'
[...]=20
> Thanks Jonathan, compiles fine defining NO_NSEC, but my glibc is 2.2.=
5
> and the comment abot USE_NSEC says it requires at least glibc
> 2.2.4. Maybe the comment is wrong? glibc 2.3.6 compiles fine.

Hmm, in the glibc changelog I find this, from ChangeLog.14:

| 2003-01-04  Andreas Schwab  <schwab@suse.de>
|
|	* sysdeps/unix/sysv/linux/m68k/bits/stat.h: Add nanosecond fields.

That=E2=80=99s around the time of glibc 2.3.2.

The stat(2) man page tells a little more:

| Since kernel 2.5.48, the stat structure supports nanosecond resolutio=
n for
| the  three  file timestamp fields.  Glibc exposes the nanosecond comp=
onent
| of each field using names either  of  the  form  st_atim.tv_nsec,  if=
  the
| _BSD_SOURCE  or _SVID_SOURCE feature test macro is defined, or of the=
 form
| st_atimensec, if neither of these macros is defined.  On file systems=
 that
| do not support sub-second timestamps, these nanosecond fields are ret=
urned
| with the value 0.

Searching a little harder yields commit cvs/glibc-2_3_2~418
(2002-12-31) of git://sourceware.org/git/glibc.git, in which the
feature was added.  There=E2=80=99s a lovely discussion about it from t=
hen on
libc-alpha. [1]

The comment you mention is from commit bdd4da5 (Make nsec checking
optional, 2005-04-13); I am guessing 2.2.4 was just mentioned as a lowe=
r
bound.

So how about something like the following?  Please feel free to
write something better --- in particular, I am not sure the
documentation for USE_NSEC is the most obvious place to look when
something goes wrong.

Thanks,
Jonathan

[1] http://sourceware.org/ml/libc-alpha/2002-12/threads.html#00011

-- %< --
Subject: Makefile: document minimal glibc version supporting tv_nsec

Compiling git with the default settings and old glibc produces
errors like the following:

| read-cache.c: In function 'fill_stat_cache_info':
| read-cache.c:72: error: 'struct stat' has no member named 'st_ctim'

The Makefile seems to imply that versions after 2.2.4 should be
okay, but that is not true: NO_NSEC must be set to build with
glibc versions before 2.3.2.

Reported-by: Gabor Z. Papp <gzp@papp.hu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/Makefile b/Makefile
index fd7f51e..8ebc966 100644
--- a/Makefile
+++ b/Makefile
@@ -134,7 +134,7 @@ all::
 # "-Wl,-rpath=3D/path/lib" is used instead.
 #
 # Define USE_NSEC below if you want git to care about sub-second file =
mtimes
-# and ctimes. Note that you need recent glibc (at least 2.2.4) for thi=
s, and
+# and ctimes. Note that you need recent glibc (at least 2.3.2) for thi=
s, and
 # it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will=
 likely
 # randomly break unless your underlying filesystem supports those sub-=
second
 # times (my ext3 doesn't).
