From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 2/2] Makefile: automatically compute header
 dependencies
Date: Fri, 27 Nov 2009 22:24:03 -0600
Message-ID: <20091128042403.GA4006@progeny.tock>
References: <4B0F8825.3040107@viscovery.net>
 <alpine.DEB.1.00.0911271033460.4521@intel-tinevez-2-302>
 <20091127174558.GA3461@progeny.tock>
 <20091127175043.GC3461@progeny.tock>
 <fabb9a1e0911271457k31d8addcwbbc8fd34f9aedd8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 28 05:12:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEEfN-0004lc-Nj
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 05:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192AbZK1ELw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Nov 2009 23:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753906AbZK1ELw
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 23:11:52 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:33442 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbZK1ELv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 23:11:51 -0500
Received: by gxk26 with SMTP id 26so2439727gxk.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 20:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=UYgJd6lVReUrTvIF1MG4K8CW4s0cPzw9S6ZjeesRaAE=;
        b=RsrtrED9dqmpsa9rluL8uxlDfJfkxr8InkdRseQNZT3GQvV1FFZrBUdowALRz5m+gL
         Cyjv0mT5294KHoSi9whLEu+nScv0pbKpgfsyDJ91n0abAoF1RD2SVUuh+NQ2sdRimm2c
         fpRQ7AnwKvd/E+7mGOsXd7ttuLySoT0pcL4hQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=lkyyY5hyRmPA3dHBM7YjsrigtoO5SU5mVFbzsSJpUzn/KaHGXcx7pYXEA+6s5hKUjl
         0I4rxu2P51Os5mlL4Oc/peloK1EqpbEXe7YkYcFr/JGV9yNxXTv5fJaJGHJ+mHD4XmXk
         lcv3N+QwJams+NZNZqNq8bLATakdSxa6Ipy5E=
Received: by 10.90.217.3 with SMTP id p3mr234621agg.22.1259381517477;
        Fri, 27 Nov 2009 20:11:57 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 5sm1095559yxd.71.2009.11.27.20.11.55
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 27 Nov 2009 20:11:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <fabb9a1e0911271457k31d8addcwbbc8fd34f9aedd8c@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133945>

Sverre Rabbelier wrote:

> Ugh, git/git is already a horror to 'ls', adding another n files...
> :(.

They are dotfiles, though depending on how your 'ls' works, that may or
may not help.

> Which brings me back to "if only git had a seperate src/ and maybe
> /build directories" :P.

Hmm, I don=E2=80=99t want to work on that in general, but a separate de=
ps/
directory does not sound like a bad idea at all.

i.e., something vaguely like this.

 .gitignore |    1 +
 Makefile   |   20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index ac02a58..803247f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -170,6 +170,7 @@
 *.exe
 *.[aos]
 *.py[co]
+*.o.d
 *+
 /config.mak
 /autom4te.cache
diff --git a/Makefile b/Makefile
index ed0f461..1cc149b 100644
--- a/Makefile
+++ b/Makefile
@@ -488,6 +488,7 @@ LIB_H +=3D unpack-trees.h
 LIB_H +=3D userdiff.h
 LIB_H +=3D utf8.h
 LIB_H +=3D wt-status.h
+LIB_H :=3D
=20
 LIB_OBJS +=3D abspath.o
 LIB_OBJS +=3D advice.o
@@ -1559,13 +1560,23 @@ git.o git.spec \
 	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	: GIT-VERSION-FILE
=20
+dep_file =3D $(dir $@)deps/$(notdir $@).d
+dep_args =3D -MF $(dep_file) -MMD -MP
+
 %.o: %.c GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
+	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $<
 %.s: %.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $<
 %.o: %.S
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
=20
+objects :=3D $(wildcard *.o block-sha1/*.o ppc/*.o compat/*.o \
+		compat/*/*.o xdiff/*.o)
+dep_files :=3D $(wildcard $(foreach f,$(objects),$(dir $f)deps/$(notdi=
r $f).d))
+ifneq ($(dep_files),)
+include $(dep_files)
+endif
+
 exec_cmd.o: exec_cmd.c GIT-CFLAGS
 exec_cmd.o: ALL_CFLAGS +=3D \
 	'-DGIT_EXEC_PATH=3D"$(gitexecdir_SQ)"' \
@@ -1657,6 +1668,9 @@ TRACK_CFLAGS =3D $(subst ','\'',$(ALL_CFLAGS)):\
              $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix=
_SQ)
=20
 GIT-CFLAGS: .FORCE-GIT-CFLAGS
+	mkdir -p deps block-sha1/deps ppc/deps compat/deps \
+		compat/regex/deps compat/nedmalloc/deps compat/fnmatch/deps \
+		xdiff/deps
 	@FLAGS=3D'$(TRACK_CFLAGS)'; \
 	    if test x"$$FLAGS" !=3D x"`cat GIT-CFLAGS 2>/dev/null`" ; then \
 		echo 1>&2 "    * new build flags or prefix"; \
@@ -1873,8 +1887,10 @@ distclean: clean
 	$(RM) configure
=20
 clean:
-	$(RM) *.o block-sha1/*.o arm/*.o ppc/*.o compat/*.o compat/*/*.o xdif=
f/*.o \
+	$(RM) *.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o \
 		$(LIB_FILE) $(XDIFF_LIB)
+	$(RM) -r deps block-sha1/deps ppc/deps compat/deps \
+		compat/*/deps xdiff/deps
 	$(RM) $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags csco=
pe*
--=20
1.6.5.3
