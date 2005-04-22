From: Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] git-pasky debian dir
Date: Fri, 22 Apr 2005 09:16:35 -0700
Message-ID: <20050422161635.GA5324@shell0.pdx.osdl.net>
References: <200504220918.06977.jcorbin@wunjo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 18:13:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP0lb-0002Go-Qt
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 18:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVDVQRC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 22 Apr 2005 12:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbVDVQRC
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 12:17:02 -0400
Received: from fire.osdl.org ([65.172.181.4]:2507 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261341AbVDVQQh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 12:16:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3MGGZs4014484
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 22 Apr 2005 09:16:35 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3MGGZQ4032032;
	Fri, 22 Apr 2005 09:16:35 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j3MGGZlg032031;
	Fri, 22 Apr 2005 09:16:35 -0700
To: "Joshua T. Corbin" <jcorbin@wunjo.org>
Content-Disposition: inline
In-Reply-To: <200504220918.06977.jcorbin@wunjo.org>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Joshua T. Corbin (jcorbin@wunjo.org) wrote:
> After seeing the spec file, I had to do this:
>=20
> You can get the binary here:
> =A0 http://node1.wunjo.org/~jcorbin/git-pasky_0.6.3-1_i386.deb
>=20
> alternatively you can pull from here:
> =A0 rsync://node1.wunjo.org/git/git
>=20
> It's against b31d16fad0013b3f106b227232559e24daf36962. It installs=20
> to /usr/bin, but I hacked things about so that *.sh goes=20
> in /usr/share/git-pasky/scripts. Haven't had many people try it yet, =
but it=20
> works for me; this isn't exactly my first debian package, but if anyo=
ne sees=20
> any glaring issues with it, I'd love to hear about it.
>=20
> --- /dev/null
> +++ 2f556bba4a059b3aaefb0bbacac64d60a14e127a/debian/scriptdir.diff
> @@ -0,0 +1,82 @@
> +diff -u a/Makefile b/Makefile
> +--- a/Makefile	2005-04-22 00:59:22.000000000 -0400
> ++++ b/Makefile	2005-04-22 00:59:43.000000000 -0400
> +@@ -18,6 +18,7 @@
> + prefix=3D$(HOME)
> +=20
> + bindir=3D$(prefix)/bin
> ++scriptdir=3D$(prefix)/share/git-pasky/scripts
> +=20
> + CC=3Dgcc
> + AR=3Dar
> +@@ -28,11 +29,11 @@
> + 	check-files ls-tree merge-base merge-cache unpack-file git-export =
\
> + 	diff-cache convert-cache
> +=20
> +-SCRIPT=3D	parent-id tree-id git gitXnormid.sh gitadd.sh gitaddremot=
e.sh \
> +-	gitcommit.sh gitdiff-do gitdiff.sh gitlog.sh gitls.sh gitlsobj.sh =
\
> +-	gitmerge.sh gitpull.sh gitrm.sh gittag.sh gittrack.sh gitexport.sh=
 \
> +-	gitapply.sh gitcancel.sh gitXlntree.sh commit-id gitlsremote.sh \
> +-	gitfork.sh gitinit.sh gitseek.sh gitstatus.sh gitpatch.sh \
> ++BINSCRIPTS=3D parent-id tree-id git gitdiff-do commit-id
> ++SCRIPT=3D	gitXnormid.sh gitadd.sh gitaddremote.sh gitcommit.sh gitd=
iff.sh \
> ++  gitlog.sh gitls.sh gitlsobj.sh gitmerge.sh gitpull.sh gitrm.sh gi=
ttag.sh \
> ++	gittrack.sh gitexport.sh gitapply.sh gitcancel.sh gitXlntree.sh \
> ++	gitlsremote.sh gitfork.sh gitinit.sh gitseek.sh gitstatus.sh gitpa=
tch.sh \
> + 	gitmerge-file.sh
> +=20
> + COMMON=3D	read-cache.o
> +@@ -80,7 +81,9 @@
> +=20
> + install: $(PROG) $(GEN_SCRIPT)
> + 	install -m755 -d $(DESTDIR)$(bindir)
> +-	install $(PROG) $(SCRIPT) $(GEN_SCRIPT) $(DESTDIR)$(bindir)
> ++	install -m755 -d $(DESTDIR)$(scriptdir)
> ++	install $(PROG) $(BINSCRIPTS) $(DESTDIR)$(bindir)
> ++	install $(SCRIPT) $(GEN_SCRIPT) $(DESTDIR)$(scriptdir)

This whole bit should be formalized.  Ideally, I'd like to do /usr/bin/=
git
frontend, with all scripts in /usr/libexec/git/.  However, this require=
s
something more than hardcoding paths.

> + clean:
> + 	rm -f *.o mozilla-sha1/*.o $(PROG) $(GEN_SCRIPT) $(LIB_FILE)
> +diff -u a/commit-id b/commit-id
> +--- a/commit-id	2005-04-22 00:59:22.000000000 -0400
> ++++ b/commit-id	2005-04-22 01:02:40.000000000 -0400
> +@@ -5,4 +5,4 @@
> + #
> + # Takes the appropriate ID, defaults to HEAD.
> +=20
> +-gitXnormid.sh -c $1
> ++/usr/share/git-pasky/scripts/gitXnormid.sh -c $1

like this...

> +Common subdirectories: a/contrib and b/contrib
> +Only in b: debian
> +diff -u a/git b/git
> +--- a/git	2005-04-22 00:59:22.000000000 -0400
> ++++ b/git	2005-04-22 01:01:43.000000000 -0400
> +@@ -17,6 +17,7 @@
> + 	exit 1
> + }
> +=20
> ++export PATH=3D/usr/share/git-pasky/scripts:$PATH

Or this...

> + help () {
> + 	cat <<__END__
> +Common subdirectories: a/mozilla-sha1 and b/mozilla-sha1
> +diff -u a/parent-id b/parent-id
> +--- a/parent-id	2005-04-22 00:59:22.000000000 -0400
> ++++ b/parent-id	2005-04-22 01:02:01.000000000 -0400
> +@@ -7,6 +7,6 @@
> +=20
> + PARENT=3D"^parent [A-Za-z0-9]{40}$"
> +=20
> +-id=3D$(gitXnormid.sh -c $1) || exit 1
> ++id=3D$(/usr/share/git-pasky/scripts/gitXnormid.sh -c $1) || exit 1

ditto...

> + cat-file commit $id | egrep "$PARENT" | cut -d ' ' -f 2
> +diff -u a/tree-id b/tree-id
> +--- a/tree-id	2005-04-22 00:59:22.000000000 -0400
> ++++ b/tree-id	2005-04-22 01:00:40.000000000 -0400
> +@@ -5,4 +5,4 @@
> + #
> + # Takes ID of the appropriate commit, defaults to HEAD.
> +=20
> +-gitXnormid.sh $1
> ++/usr/share/git-pasky/scripts/gitXnormid.sh $1

You get the idea ;-)  I certainly see how it makes sense for a first
run to get it going.  But this will need fixing upstream.

thanks,
-chris
--=20
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits=
=2Enet
