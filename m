X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	T_TVD_MIME_NO_HEADERS shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [GIT PATCH] Makefile missing git-runstatus in PROGRAMS list
Date: Tue, 14 Nov 2006 20:51:20 -0800
Message-ID: <7v64dhs46v.fsf@assigned-by-dhcp.cox.net>
References: <FE74AC4E0A23124DA52B99F17F44159701A11D6A@PA-EXCH03.vmware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
NNTP-Posting-Date: Wed, 15 Nov 2006 04:51:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <FE74AC4E0A23124DA52B99F17F44159701A11D6A@PA-EXCH03.vmware.com>
	(Bhavesh Davda's message of "Tue, 14 Nov 2006 20:09:49 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31415>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkCkC-0004vi-5d for gcvg-git@gmane.org; Wed, 15 Nov
 2006 05:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966638AbWKOEvY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 23:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966642AbWKOEvY
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 23:51:24 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:14254 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S966638AbWKOEvW
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 23:51:22 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115045121.MQIT9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Tue, 14
 Nov 2006 23:51:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id msrS1V00t1kojtg0000000; Tue, 14 Nov 2006
 23:51:28 -0500
To: "Bhavesh Davda" <bhavesh@vmware.com>
Sender: git-owner@vger.kernel.org

--=-=-=

"Bhavesh Davda" <bhavesh@vmware.com> writes:

> So I just blew away /usr/bin/git*, and removed my Makefile patch, and did
> another:
>
> make prefix=/usr all (as myself)
>
> and then
>
> sudo make prefix=/usr install
>
> I now *don't* have /usr/bin/git-runstatus.
>
> And none of the files under /usr/bin/git* are hard links. There are in all 79
> files beginning with /usr/bin/git*:
>
> git git-am git-applymbox git-applypatch git-archimport git-bisect
> git-checkout git-cherry-pick git-clean git-clone git-commit
>...
> git-var git-verify-pack git-verify-tag gitk
>
> I haven't tried make -p yet, but can do that to see why git-runstatus isn't
> installed under /usr/bin

Interesting.  You do not seem to have not just git-runstatus but
anything built-in.  The last action in "make install" should
look like this log entry (I just did "make prefix=/var/tmp/ggg
clean all install"):

rm -f '/var/tmp/ggg/bin/git-format-patch' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/git-format-patch' ;  rm -f '/var/tmp/ggg/bin/git-show' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/git-show' ; ... rm -f '/var/tmp/ggg/bin/git-verify-pack' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/git-verify-pack' ;  rm -f '/var/tmp/ggg/bin/git-write-tree' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/git-write-tree' ;

that installs 47 hardlinks to $(prefix)/bin/git.


--=-=-=
Content-Disposition: inline; filename=ggg-log
Content-Transfer-Encoding: quoted-printable
Content-Description: script from \"make prefix=/var/tmp/ggg clean all
 install\"

Script started on Tue 14 Nov 2006 08:42:08 PM PST
gitster; make prefix=3D/var/tmp/ggg clean all install
GIT_VERSION =3D 1.4.3.5.gfe14
rm -f *.o mozilla-sha1/*.o arm/*.o ppc/*.o compat/*.o xdiff/*.o \
		libgit.a xdiff/lib.a
rm -f git-convert-objects git-fetch-pack git-fsck-objects git-hash-object g=
it-index-pack git-local-fetch git-merge-base git-daemon git-merge-index git=
-mktag git-mktree git-patch-id git-peek-remote git-receive-pack git-send-pa=
ck git-shell git-show-index git-ssh-fetch git-ssh-upload git-unpack-file gi=
t-update-server-info git-upload-pack git-verify-pack git-pack-redundant git=
-var git-describe git-merge-tree git-blame git-imap-send git-merge-recursiv=
e  git-ssh-pull git-ssh-push git-http-fetch git-http-push git-bisect git-br=
anch git-checkout git-cherry git-clean git-clone git-commit git-fetch git-l=
s-remote git-merge-one-file git-parse-remote git-pull git-rebase git-repack=
 git-request-pull git-reset git-resolve git-revert git-sh-setup git-tag git=
-verify-tag git-applymbox git-applypatch git-am git-merge git-merge-stupid =
git-merge-octopus git-merge-resolve git-merge-ours git-lost-found git-quilt=
import git-archimport git-cvsimport git-relink git-shortlog git-rerere git-=
annotate git-cvsserver git-svnimport git-cvsexportcommit git-send-email git=
-svn git-merge-recursive-old git-cherry-pick git-status git-instaweb git-me=
rge-recur git-format-patch git-show git-whatchanged git-get-tar-commit-id g=
it-add git-apply git-archive git-cat-file git-checkout-index git-check-ref-=
format git-commit-tree git-count-objects git-diff git-diff-files git-diff-i=
ndex git-diff-stages git-diff-tree git-fmt-merge-msg git-grep git-init-db g=
it-log git-ls-files git-ls-tree git-mailinfo git-mailsplit git-mv git-name-=
rev git-pack-objects git-prune git-prune-packed git-push git-read-tree git-=
repo-config git-rev-list git-rev-parse git-rm git-runstatus git-show-branch=
 git-stripspace git-symbolic-ref git-tar-tree git-unpack-objects git-update=
-index git-update-ref git-upload-archive git-verify-pack git-write-tree git
rm -f *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags
rm -rf autom4te.cache
rm -f configure config.log config.mak.autogen config.mak.append config.stat=
us config.cache
rm -rf git-1.4.3.5.gfe14 .doc-tmp-dir
rm -f git-1.4.3.5.gfe14.tar.gz git-core_1.4.3.5.gfe14-*.tar.gz
rm -f git-htmldocs-1.4.3.5.gfe14.tar.gz git-manpages-1.4.3.5.gfe14.tar.gz
rm -f gitweb/gitweb.cgi
make -C Documentation/ clean
make[1]: Entering directory `/git.git/Documentation'
rm -f doc.dep+ doc.dep
perl ./build-docdep.perl >doc.dep+
mv doc.dep+ doc.dep
make[1]: Leaving directory `/git.git/Documentation'
make[1]: Entering directory `/git.git/Documentation'
rm -f *.xml *.html *.1 *.7 howto-index.txt howto/*.html doc.dep README
make[1]: Leaving directory `/git.git/Documentation'
[ ! -f perl/Makefile ] || make -C perl/ clean || make -C perl/ clean
rm -f perl/ppport.h perl/Makefile.old
make -C templates/ clean
make[1]: Entering directory `/git.git/templates'
rm -rf blt boilerplates.made
make[1]: Leaving directory `/git.git/templates'
make -C t/ clean
make[1]: Entering directory `/git.git/t'
rm -fr trash
make[1]: Leaving directory `/git.git/t'
rm -f GIT-VERSION-FILE GIT-CFLAGS
    * new build flags or prefix
(cd perl && /usr/bin/perl Makefile.PL \
		PREFIX=3D'/var/tmp/ggg')
Writing Makefile for Git
gcc -o convert-objects.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>'=
 -DNO_STRLCPY convert-objects.c
gcc -o blob.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLC=
PY blob.c
gcc -o commit.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STR=
LCPY commit.c
gcc -o connect.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_ST=
RLCPY connect.c
gcc -o csum-file.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_=
STRLCPY csum-file.c
gcc -o cache-tree.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO=
_STRLCPY cache-tree.c
gcc -o base85.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STR=
LCPY base85.c
gcc -o date.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLC=
PY date.c
gcc -o diff-delta.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO=
_STRLCPY diff-delta.c
gcc -o entry.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRL=
CPY entry.c
gcc -o exec_cmd.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_S=
TRLCPY '-DGIT_EXEC_PATH=3D"/var/tmp/ggg/bin"' exec_cmd.c
gcc -o ident.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRL=
CPY ident.c
gcc -o interpolate.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DN=
O_STRLCPY interpolate.c
gcc -o lockfile.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_S=
TRLCPY lockfile.c
gcc -o object.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STR=
LCPY object.c
gcc -o pack-check.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO=
_STRLCPY pack-check.c
gcc -o patch-delta.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DN=
O_STRLCPY patch-delta.c
gcc -o path.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLC=
PY path.c
gcc -o pkt-line.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_S=
TRLCPY pkt-line.c
gcc -o sideband.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_S=
TRLCPY sideband.c
gcc -o quote.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRL=
CPY quote.c
gcc -o read-cache.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO=
_STRLCPY read-cache.c
gcc -o refs.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLC=
PY refs.c
gcc -o run-command.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DN=
O_STRLCPY run-command.c
gcc -o dir.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCP=
Y dir.c
gcc -o object-refs.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DN=
O_STRLCPY object-refs.c
gcc -o server-info.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DN=
O_STRLCPY server-info.c
gcc -o setup.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRL=
CPY setup.c
gcc -o sha1_file.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_=
STRLCPY sha1_file.c
gcc -o sha1_name.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_=
STRLCPY sha1_name.c
gcc -o strbuf.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STR=
LCPY strbuf.c
gcc -o tag.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCP=
Y tag.c
gcc -o tree.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLC=
PY tree.c
gcc -o usage.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRL=
CPY usage.c
gcc -o config.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STR=
LCPY config.c
gcc -o environment.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DN=
O_STRLCPY environment.c
gcc -o ctype.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRL=
CPY ctype.c
gcc -o copy.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLC=
PY copy.c
gcc -o fetch-clone.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DN=
O_STRLCPY fetch-clone.c
gcc -o revision.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_S=
TRLCPY revision.c
gcc -o pager.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRL=
CPY pager.c
gcc -o tree-walk.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_=
STRLCPY tree-walk.c
gcc -o xdiff-interface.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>'=
 -DNO_STRLCPY xdiff-interface.c
gcc -o write_or_die.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -D=
NO_STRLCPY write_or_die.c
gcc -o trace.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRL=
CPY trace.c
gcc -o list-objects.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -D=
NO_STRLCPY list-objects.c
gcc -o grep.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLC=
PY grep.c
gcc -o alloc.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRL=
CPY alloc.c
gcc -o merge-file.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO=
_STRLCPY merge-file.c
gcc -o path-list.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_=
STRLCPY path-list.c
./generate-cmdlist.sh > common-cmds.h+
mv common-cmds.h+ common-cmds.h
gcc -o help.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLC=
PY help.c
gcc -o unpack-trees.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -D=
NO_STRLCPY unpack-trees.c
gcc -o diff.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLC=
PY diff.c
gcc -o diff-lib.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_S=
TRLCPY diff-lib.c
gcc -o diffcore-break.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' =
-DNO_STRLCPY diffcore-break.c
gcc -o diffcore-order.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' =
-DNO_STRLCPY diffcore-order.c
gcc -o diffcore-pickaxe.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>=
' -DNO_STRLCPY diffcore-pickaxe.c
gcc -o diffcore-rename.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>'=
 -DNO_STRLCPY diffcore-rename.c
gcc -o tree-diff.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_=
STRLCPY tree-diff.c
gcc -o combine-diff.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -D=
NO_STRLCPY combine-diff.c
gcc -o diffcore-delta.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' =
-DNO_STRLCPY diffcore-delta.c
gcc -o log-tree.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_S=
TRLCPY log-tree.c
gcc -o color.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRL=
CPY color.c
gcc -o wt-status.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_=
STRLCPY wt-status.c
gcc -o archive-zip.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DN=
O_STRLCPY archive-zip.c
gcc -o archive-tar.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DN=
O_STRLCPY archive-tar.c
gcc -o compat/strlcpy.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' =
-DNO_STRLCPY compat/strlcpy.c
rm -f libgit.a && ar rcs libgit.a blob.o commit.o connect.o csum-file.o cac=
he-tree.o base85.o date.o diff-delta.o entry.o exec_cmd.o ident.o interpola=
te.o lockfile.o object.o pack-check.o patch-delta.o path.o pkt-line.o sideb=
and.o quote.o read-cache.o refs.o run-command.o dir.o object-refs.o server-=
info.o setup.o sha1_file.o sha1_name.o strbuf.o tag.o tree.o usage.o config=
.o environment.o ctype.o copy.o fetch-clone.o revision.o pager.o tree-walk.=
o xdiff-interface.o write_or_die.o trace.o list-objects.o grep.o alloc.o me=
rge-file.o path-list.o help.o unpack-trees.o diff.o diff-lib.o diffcore-bre=
ak.o diffcore-order.o diffcore-pickaxe.o diffcore-rename.o tree-diff.o comb=
ine-diff.o diffcore-delta.o log-tree.o color.o wt-status.o archive-zip.o ar=
chive-tar.o compat/strlcpy.o
gcc -o xdiff/xdiffi.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -D=
NO_STRLCPY xdiff/xdiffi.c
gcc -o xdiff/xprepare.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' =
-DNO_STRLCPY xdiff/xprepare.c
gcc -o xdiff/xutils.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -D=
NO_STRLCPY xdiff/xutils.c
gcc -o xdiff/xemit.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DN=
O_STRLCPY xdiff/xemit.c
rm -f xdiff/lib.a && ar rcs xdiff/lib.a xdiff/xdiffi.o xdiff/xprepare.o xdi=
ff/xutils.o xdiff/xemit.o
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-con=
vert-objects   convert-objects.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o fetch-pack.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO=
_STRLCPY fetch-pack.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-fet=
ch-pack   fetch-pack.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o fsck-objects.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -D=
NO_STRLCPY fsck-objects.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-fsc=
k-objects   fsck-objects.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o hash-object.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DN=
O_STRLCPY hash-object.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-has=
h-object   hash-object.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o index-pack.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO=
_STRLCPY index-pack.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-ind=
ex-pack   index-pack.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o local-fetch.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DN=
O_STRLCPY local-fetch.c
gcc -o fetch.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRL=
CPY fetch.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-loc=
al-fetch   local-fetch.o fetch.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o merge-base.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO=
_STRLCPY merge-base.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-mer=
ge-base   merge-base.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o daemon.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STR=
LCPY daemon.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-dae=
mon   daemon.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o merge-index.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DN=
O_STRLCPY merge-index.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-mer=
ge-index   merge-index.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o mktag.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRL=
CPY mktag.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-mkt=
ag   mktag.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o mktree.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STR=
LCPY mktree.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-mkt=
ree   mktree.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o patch-id.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_S=
TRLCPY patch-id.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-pat=
ch-id   patch-id.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o peek-remote.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DN=
O_STRLCPY peek-remote.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-pee=
k-remote   peek-remote.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o receive-pack.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -D=
NO_STRLCPY receive-pack.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-rec=
eive-pack   receive-pack.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o send-pack.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_=
STRLCPY send-pack.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-sen=
d-pack   send-pack.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o shell.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRL=
CPY shell.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-she=
ll   shell.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o show-index.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO=
_STRLCPY show-index.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-sho=
w-index   show-index.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o ssh-fetch.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_=
STRLCPY ssh-fetch.c
gcc -o rsh.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCP=
Y rsh.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-ssh=
-fetch   ssh-fetch.o rsh.o fetch.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o ssh-upload.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO=
_STRLCPY ssh-upload.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-ssh=
-upload   ssh-upload.o rsh.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o unpack-file.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DN=
O_STRLCPY unpack-file.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-unp=
ack-file   unpack-file.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o update-server-info.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.=
h>' -DNO_STRLCPY update-server-info.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-upd=
ate-server-info   update-server-info.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o upload-pack.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DN=
O_STRLCPY upload-pack.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-upl=
oad-pack   upload-pack.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o builtin-add.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DN=
O_STRLCPY builtin-add.c
gcc -o builtin-apply.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -=
DNO_STRLCPY builtin-apply.c
gcc -o builtin-archive.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>'=
 -DNO_STRLCPY builtin-archive.c
gcc -o builtin-cat-file.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>=
' -DNO_STRLCPY builtin-cat-file.c
gcc -o builtin-checkout-index.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/=
sha.h>' -DNO_STRLCPY builtin-checkout-index.c
gcc -o builtin-check-ref-format.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openss=
l/sha.h>' -DNO_STRLCPY builtin-check-ref-format.c
gcc -o builtin-commit-tree.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha=
.h>' -DNO_STRLCPY builtin-commit-tree.c
gcc -o builtin-count-objects.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/s=
ha.h>' -DNO_STRLCPY builtin-count-objects.c
gcc -o builtin-diff.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -D=
NO_STRLCPY builtin-diff.c
gcc -o builtin-diff-files.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.=
h>' -DNO_STRLCPY builtin-diff-files.c
gcc -o builtin-diff-index.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.=
h>' -DNO_STRLCPY builtin-diff-index.c
gcc -o builtin-diff-stages.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha=
.h>' -DNO_STRLCPY builtin-diff-stages.c
gcc -o builtin-diff-tree.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h=
>' -DNO_STRLCPY builtin-diff-tree.c
gcc -o builtin-fmt-merge-msg.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/s=
ha.h>' -DNO_STRLCPY builtin-fmt-merge-msg.c
gcc -o builtin-grep.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -D=
NO_STRLCPY builtin-grep.c
gcc -o builtin-init-db.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>'=
 -DNO_STRLCPY -DDEFAULT_GIT_TEMPLATE_DIR=3D'"/var/tmp/ggg/share/git-core/te=
mplates/"' builtin-init-db.c
gcc -o builtin-log.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DN=
O_STRLCPY builtin-log.c
gcc -o builtin-ls-files.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>=
' -DNO_STRLCPY builtin-ls-files.c
gcc -o builtin-ls-tree.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>'=
 -DNO_STRLCPY builtin-ls-tree.c
gcc -o builtin-mailinfo.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>=
' -DNO_STRLCPY builtin-mailinfo.c
gcc -o builtin-mailsplit.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h=
>' -DNO_STRLCPY builtin-mailsplit.c
gcc -o builtin-mv.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO=
_STRLCPY builtin-mv.c
gcc -o builtin-name-rev.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>=
' -DNO_STRLCPY builtin-name-rev.c
gcc -o builtin-pack-objects.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sh=
a.h>' -DNO_STRLCPY builtin-pack-objects.c
gcc -o builtin-prune.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -=
DNO_STRLCPY builtin-prune.c
gcc -o builtin-prune-packed.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sh=
a.h>' -DNO_STRLCPY builtin-prune-packed.c
gcc -o builtin-push.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -D=
NO_STRLCPY builtin-push.c
gcc -o builtin-read-tree.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h=
>' -DNO_STRLCPY builtin-read-tree.c
gcc -o builtin-repo-config.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha=
.h>' -DNO_STRLCPY builtin-repo-config.c
gcc -o builtin-rev-list.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>=
' -DNO_STRLCPY builtin-rev-list.c
gcc -o builtin-rev-parse.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h=
>' -DNO_STRLCPY builtin-rev-parse.c
gcc -o builtin-rm.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO=
_STRLCPY builtin-rm.c
gcc -o builtin-runstatus.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h=
>' -DNO_STRLCPY builtin-runstatus.c
gcc -o builtin-show-branch.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha=
.h>' -DNO_STRLCPY builtin-show-branch.c
gcc -o builtin-stripspace.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.=
h>' -DNO_STRLCPY builtin-stripspace.c
gcc -o builtin-symbolic-ref.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sh=
a.h>' -DNO_STRLCPY builtin-symbolic-ref.c
gcc -o builtin-tar-tree.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>=
' -DNO_STRLCPY builtin-tar-tree.c
gcc -o builtin-unpack-objects.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/=
sha.h>' -DNO_STRLCPY builtin-unpack-objects.c
gcc -o builtin-update-index.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sh=
a.h>' -DNO_STRLCPY builtin-update-index.c
gcc -o builtin-update-ref.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.=
h>' -DNO_STRLCPY builtin-update-ref.c
gcc -o builtin-upload-archive.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/=
sha.h>' -DNO_STRLCPY builtin-upload-archive.c
gcc -o builtin-verify-pack.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha=
.h>' -DNO_STRLCPY builtin-verify-pack.c
gcc -o builtin-write-tree.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.=
h>' -DNO_STRLCPY builtin-write-tree.c
gcc -DGIT_VERSION=3D'"1.4.3.5.gfe14"' \
		-g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git git.c=
 \
		builtin-add.o builtin-apply.o builtin-archive.o builtin-cat-file.o builti=
n-checkout-index.o builtin-check-ref-format.o builtin-commit-tree.o builtin=
-count-objects.o builtin-diff.o builtin-diff-files.o builtin-diff-index.o b=
uiltin-diff-stages.o builtin-diff-tree.o builtin-fmt-merge-msg.o builtin-gr=
ep.o builtin-init-db.o builtin-log.o builtin-ls-files.o builtin-ls-tree.o b=
uiltin-mailinfo.o builtin-mailsplit.o builtin-mv.o builtin-name-rev.o built=
in-pack-objects.o builtin-prune.o builtin-prune-packed.o builtin-push.o bui=
ltin-read-tree.o builtin-repo-config.o builtin-rev-list.o builtin-rev-parse=
.o builtin-rm.o builtin-runstatus.o builtin-show-branch.o builtin-stripspac=
e.o builtin-symbolic-ref.o builtin-tar-tree.o builtin-unpack-objects.o buil=
tin-update-index.o builtin-update-ref.o builtin-upload-archive.o builtin-ve=
rify-pack.o builtin-write-tree.o   libgit.a xdiff/lib.a -lz  -lcrypto
rm -f git-verify-pack && ln git git-verify-pack
gcc -o pack-redundant.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' =
-DNO_STRLCPY pack-redundant.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-pac=
k-redundant   pack-redundant.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o var.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCP=
Y var.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-var=
   var.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o describe.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_S=
TRLCPY describe.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-des=
cribe   describe.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o merge-tree.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO=
_STRLCPY merge-tree.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-mer=
ge-tree   merge-tree.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o blame.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRL=
CPY blame.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-bla=
me   blame.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o imap-send.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_=
STRLCPY imap-send.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-ima=
p-send   imap-send.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o merge-recursive.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>'=
 -DNO_STRLCPY merge-recursive.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-mer=
ge-recursive   merge-recursive.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o ssh-pull.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_S=
TRLCPY ssh-pull.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-ssh=
-pull   ssh-pull.o rsh.o fetch.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o ssh-push.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_S=
TRLCPY ssh-push.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-ssh=
-push   ssh-push.o rsh.o libgit.a xdiff/lib.a -lz  -lcrypto
gcc -o http.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLC=
PY -DGIT_USER_AGENT=3D'"git/1.4.3.5.gfe14"' http.c
gcc -o http-fetch.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO=
_STRLCPY http-fetch.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-htt=
p-fetch   fetch.o http.o http-fetch.o \
		libgit.a xdiff/lib.a -lz  -lcrypto -lcurl -lexpat
gcc -o http-push.o -c -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_=
STRLCPY http-push.c
gcc -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -DNO_STRLCPY -o git-htt=
p-push   revision.o http.o http-push.o \
		libgit.a xdiff/lib.a -lz  -lcrypto -lcurl -lexpat
rm -f git-bisect git-bisect+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-bisect.sh >git-bisect+
chmod +x git-bisect+
mv git-bisect+ git-bisect
rm -f git-branch git-branch+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-branch.sh >git-branch+
chmod +x git-branch+
mv git-branch+ git-branch
rm -f git-checkout git-checkout+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-checkout.sh >git-checkout+
chmod +x git-checkout+
mv git-checkout+ git-checkout
rm -f git-cherry git-cherry+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-cherry.sh >git-cherry+
chmod +x git-cherry+
mv git-cherry+ git-cherry
rm -f git-clean git-clean+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-clean.sh >git-clean+
chmod +x git-clean+
mv git-clean+ git-clean
rm -f git-clone git-clone+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-clone.sh >git-clone+
chmod +x git-clone+
mv git-clone+ git-clone
rm -f git-commit git-commit+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-commit.sh >git-commit+
chmod +x git-commit+
mv git-commit+ git-commit
rm -f git-fetch git-fetch+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-fetch.sh >git-fetch+
chmod +x git-fetch+
mv git-fetch+ git-fetch
rm -f git-ls-remote git-ls-remote+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-ls-remote.sh >git-ls-remote+
chmod +x git-ls-remote+
mv git-ls-remote+ git-ls-remote
rm -f git-merge-one-file git-merge-one-file+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-merge-one-file.sh >git-merge-one-file+
chmod +x git-merge-one-file+
mv git-merge-one-file+ git-merge-one-file
rm -f git-parse-remote git-parse-remote+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-parse-remote.sh >git-parse-remote+
chmod +x git-parse-remote+
mv git-parse-remote+ git-parse-remote
rm -f git-pull git-pull+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-pull.sh >git-pull+
chmod +x git-pull+
mv git-pull+ git-pull
rm -f git-rebase git-rebase+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-rebase.sh >git-rebase+
chmod +x git-rebase+
mv git-rebase+ git-rebase
rm -f git-repack git-repack+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-repack.sh >git-repack+
chmod +x git-repack+
mv git-repack+ git-repack
rm -f git-request-pull git-request-pull+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-request-pull.sh >git-request-pull+
chmod +x git-request-pull+
mv git-request-pull+ git-request-pull
rm -f git-reset git-reset+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-reset.sh >git-reset+
chmod +x git-reset+
mv git-reset+ git-reset
rm -f git-resolve git-resolve+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-resolve.sh >git-resolve+
chmod +x git-resolve+
mv git-resolve+ git-resolve
rm -f git-revert git-revert+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-revert.sh >git-revert+
chmod +x git-revert+
mv git-revert+ git-revert
rm -f git-sh-setup git-sh-setup+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-sh-setup.sh >git-sh-setup+
chmod +x git-sh-setup+
mv git-sh-setup+ git-sh-setup
rm -f git-tag git-tag+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-tag.sh >git-tag+
chmod +x git-tag+
mv git-tag+ git-tag
rm -f git-verify-tag git-verify-tag+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-verify-tag.sh >git-verify-tag+
chmod +x git-verify-tag+
mv git-verify-tag+ git-verify-tag
rm -f git-applymbox git-applymbox+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-applymbox.sh >git-applymbox+
chmod +x git-applymbox+
mv git-applymbox+ git-applymbox
rm -f git-applypatch git-applypatch+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-applypatch.sh >git-applypatch+
chmod +x git-applypatch+
mv git-applypatch+ git-applypatch
rm -f git-am git-am+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-am.sh >git-am+
chmod +x git-am+
mv git-am+ git-am
rm -f git-merge git-merge+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-merge.sh >git-merge+
chmod +x git-merge+
mv git-merge+ git-merge
rm -f git-merge-stupid git-merge-stupid+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-merge-stupid.sh >git-merge-stupid+
chmod +x git-merge-stupid+
mv git-merge-stupid+ git-merge-stupid
rm -f git-merge-octopus git-merge-octopus+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-merge-octopus.sh >git-merge-octopus+
chmod +x git-merge-octopus+
mv git-merge-octopus+ git-merge-octopus
rm -f git-merge-resolve git-merge-resolve+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-merge-resolve.sh >git-merge-resolve+
chmod +x git-merge-resolve+
mv git-merge-resolve+ git-merge-resolve
rm -f git-merge-ours git-merge-ours+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-merge-ours.sh >git-merge-ours+
chmod +x git-merge-ours+
mv git-merge-ours+ git-merge-ours
rm -f git-lost-found git-lost-found+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-lost-found.sh >git-lost-found+
chmod +x git-lost-found+
mv git-lost-found+ git-lost-found
rm -f git-quiltimport git-quiltimport+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's|@@PERL@@|/usr/bin/perl|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    git-quiltimport.sh >git-quiltimport+
chmod +x git-quiltimport+
mv git-quiltimport+ git-quiltimport
rm -f git-archimport git-archimport+
INSTLIBDIR=3D`make -C perl -s --no-print-directory instlibdir` && \
	sed -e '1{' \
	    -e '	s|#!.*perl|#!/usr/bin/perl|' \
	    -e '	h' \
	    -e '	s=3D.*=3Duse lib (split(/:/, $ENV{GITPERLLIB} || "@@INSTLIBDIR@@"=
));=3D' \
	    -e '	H' \
	    -e '	x' \
	    -e '}' \
	    -e 's|@@INSTLIBDIR@@|'"$INSTLIBDIR"'|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    git-archimport.perl >git-archimport+
chmod +x git-archimport+
mv git-archimport+ git-archimport
rm -f git-cvsimport git-cvsimport+
INSTLIBDIR=3D`make -C perl -s --no-print-directory instlibdir` && \
	sed -e '1{' \
	    -e '	s|#!.*perl|#!/usr/bin/perl|' \
	    -e '	h' \
	    -e '	s=3D.*=3Duse lib (split(/:/, $ENV{GITPERLLIB} || "@@INSTLIBDIR@@"=
));=3D' \
	    -e '	H' \
	    -e '	x' \
	    -e '}' \
	    -e 's|@@INSTLIBDIR@@|'"$INSTLIBDIR"'|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    git-cvsimport.perl >git-cvsimport+
chmod +x git-cvsimport+
mv git-cvsimport+ git-cvsimport
rm -f git-relink git-relink+
INSTLIBDIR=3D`make -C perl -s --no-print-directory instlibdir` && \
	sed -e '1{' \
	    -e '	s|#!.*perl|#!/usr/bin/perl|' \
	    -e '	h' \
	    -e '	s=3D.*=3Duse lib (split(/:/, $ENV{GITPERLLIB} || "@@INSTLIBDIR@@"=
));=3D' \
	    -e '	H' \
	    -e '	x' \
	    -e '}' \
	    -e 's|@@INSTLIBDIR@@|'"$INSTLIBDIR"'|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    git-relink.perl >git-relink+
chmod +x git-relink+
mv git-relink+ git-relink
rm -f git-shortlog git-shortlog+
INSTLIBDIR=3D`make -C perl -s --no-print-directory instlibdir` && \
	sed -e '1{' \
	    -e '	s|#!.*perl|#!/usr/bin/perl|' \
	    -e '	h' \
	    -e '	s=3D.*=3Duse lib (split(/:/, $ENV{GITPERLLIB} || "@@INSTLIBDIR@@"=
));=3D' \
	    -e '	H' \
	    -e '	x' \
	    -e '}' \
	    -e 's|@@INSTLIBDIR@@|'"$INSTLIBDIR"'|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    git-shortlog.perl >git-shortlog+
chmod +x git-shortlog+
mv git-shortlog+ git-shortlog
rm -f git-rerere git-rerere+
INSTLIBDIR=3D`make -C perl -s --no-print-directory instlibdir` && \
	sed -e '1{' \
	    -e '	s|#!.*perl|#!/usr/bin/perl|' \
	    -e '	h' \
	    -e '	s=3D.*=3Duse lib (split(/:/, $ENV{GITPERLLIB} || "@@INSTLIBDIR@@"=
));=3D' \
	    -e '	H' \
	    -e '	x' \
	    -e '}' \
	    -e 's|@@INSTLIBDIR@@|'"$INSTLIBDIR"'|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    git-rerere.perl >git-rerere+
chmod +x git-rerere+
mv git-rerere+ git-rerere
rm -f git-annotate git-annotate+
INSTLIBDIR=3D`make -C perl -s --no-print-directory instlibdir` && \
	sed -e '1{' \
	    -e '	s|#!.*perl|#!/usr/bin/perl|' \
	    -e '	h' \
	    -e '	s=3D.*=3Duse lib (split(/:/, $ENV{GITPERLLIB} || "@@INSTLIBDIR@@"=
));=3D' \
	    -e '	H' \
	    -e '	x' \
	    -e '}' \
	    -e 's|@@INSTLIBDIR@@|'"$INSTLIBDIR"'|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    git-annotate.perl >git-annotate+
chmod +x git-annotate+
mv git-annotate+ git-annotate
rm -f git-cvsserver git-cvsserver+
INSTLIBDIR=3D`make -C perl -s --no-print-directory instlibdir` && \
	sed -e '1{' \
	    -e '	s|#!.*perl|#!/usr/bin/perl|' \
	    -e '	h' \
	    -e '	s=3D.*=3Duse lib (split(/:/, $ENV{GITPERLLIB} || "@@INSTLIBDIR@@"=
));=3D' \
	    -e '	H' \
	    -e '	x' \
	    -e '}' \
	    -e 's|@@INSTLIBDIR@@|'"$INSTLIBDIR"'|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    git-cvsserver.perl >git-cvsserver+
chmod +x git-cvsserver+
mv git-cvsserver+ git-cvsserver
rm -f git-svnimport git-svnimport+
INSTLIBDIR=3D`make -C perl -s --no-print-directory instlibdir` && \
	sed -e '1{' \
	    -e '	s|#!.*perl|#!/usr/bin/perl|' \
	    -e '	h' \
	    -e '	s=3D.*=3Duse lib (split(/:/, $ENV{GITPERLLIB} || "@@INSTLIBDIR@@"=
));=3D' \
	    -e '	H' \
	    -e '	x' \
	    -e '}' \
	    -e 's|@@INSTLIBDIR@@|'"$INSTLIBDIR"'|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    git-svnimport.perl >git-svnimport+
chmod +x git-svnimport+
mv git-svnimport+ git-svnimport
rm -f git-cvsexportcommit git-cvsexportcommit+
INSTLIBDIR=3D`make -C perl -s --no-print-directory instlibdir` && \
	sed -e '1{' \
	    -e '	s|#!.*perl|#!/usr/bin/perl|' \
	    -e '	h' \
	    -e '	s=3D.*=3Duse lib (split(/:/, $ENV{GITPERLLIB} || "@@INSTLIBDIR@@"=
));=3D' \
	    -e '	H' \
	    -e '	x' \
	    -e '}' \
	    -e 's|@@INSTLIBDIR@@|'"$INSTLIBDIR"'|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    git-cvsexportcommit.perl >git-cvsexportcommit+
chmod +x git-cvsexportcommit+
mv git-cvsexportcommit+ git-cvsexportcommit
rm -f git-send-email git-send-email+
INSTLIBDIR=3D`make -C perl -s --no-print-directory instlibdir` && \
	sed -e '1{' \
	    -e '	s|#!.*perl|#!/usr/bin/perl|' \
	    -e '	h' \
	    -e '	s=3D.*=3Duse lib (split(/:/, $ENV{GITPERLLIB} || "@@INSTLIBDIR@@"=
));=3D' \
	    -e '	H' \
	    -e '	x' \
	    -e '}' \
	    -e 's|@@INSTLIBDIR@@|'"$INSTLIBDIR"'|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    git-send-email.perl >git-send-email+
chmod +x git-send-email+
mv git-send-email+ git-send-email
rm -f git-svn git-svn+
INSTLIBDIR=3D`make -C perl -s --no-print-directory instlibdir` && \
	sed -e '1{' \
	    -e '	s|#!.*perl|#!/usr/bin/perl|' \
	    -e '	h' \
	    -e '	s=3D.*=3Duse lib (split(/:/, $ENV{GITPERLLIB} || "@@INSTLIBDIR@@"=
));=3D' \
	    -e '	H' \
	    -e '	x' \
	    -e '}' \
	    -e 's|@@INSTLIBDIR@@|'"$INSTLIBDIR"'|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    git-svn.perl >git-svn+
chmod +x git-svn+
mv git-svn+ git-svn
rm -f git-merge-recursive-old git-merge-recursive-old+
sed -e '1s|#!.*python|#!/usr/bin/python|' \
	    -e 's|@@GIT_PYTHON_PATH@@|/var/tmp/ggg/share/git-core/python|g' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    git-merge-recursive-old.py >git-merge-recursive-old+
chmod +x git-merge-recursive-old+
mv git-merge-recursive-old+ git-merge-recursive-old
cp git-revert git-cherry-pick+
mv git-cherry-pick+ git-cherry-pick
cp git-commit git-status+
mv git-status+ git-status
rm -f gitweb/gitweb.cgi gitweb/gitweb.cgi+
sed -e '1s|#!.*perl|#!/usr/bin/perl|' \
	    -e 's|++GIT_VERSION++|1.4.3.5.gfe14|g' \
	    -e 's|++GIT_BINDIR++|/var/tmp/ggg/bin|g' \
	    -e 's|++GITWEB_CONFIG++|gitweb_config.perl|g' \
	    -e 's|++GITWEB_HOME_LINK_STR++|projects|g' \
	    -e 's|++GITWEB_SITENAME++||g' \
	    -e 's|++GITWEB_PROJECTROOT++|/pub/git|g' \
	    -e 's|++GITWEB_EXPORT_OK++||g' \
	    -e 's|++GITWEB_STRICT_EXPORT++||g' \
	    -e 's|++GITWEB_BASE_URL++||g' \
	    -e 's|++GITWEB_LIST++||g' \
	    -e 's|++GITWEB_HOMETEXT++|indextext.html|g' \
	    -e 's|++GITWEB_CSS++|gitweb.css|g' \
	    -e 's|++GITWEB_LOGO++|git-logo.png|g' \
	    -e 's|++GITWEB_FAVICON++|git-favicon.png|g' \
	    gitweb/gitweb.perl >gitweb/gitweb.cgi+
chmod +x gitweb/gitweb.cgi+
mv gitweb/gitweb.cgi+ gitweb/gitweb.cgi
rm -f git-instaweb git-instaweb+
sed -e '1s|#!.*/sh|#!/bin/sh|' \
	    -e 's/@@GIT_VERSION@@/1.4.3.5.gfe14/g' \
	    -e 's/@@NO_CURL@@//g' \
	    -e 's/@@NO_PYTHON@@//g' \
	    -e '/@@GITWEB_CGI@@/r gitweb/gitweb.cgi' \
	    -e '/@@GITWEB_CGI@@/d' \
	    -e '/@@GITWEB_CSS@@/r gitweb/gitweb.css' \
	    -e '/@@GITWEB_CSS@@/d' \
	    git-instaweb.sh > git-instaweb+
chmod +x git-instaweb+
mv git-instaweb+ git-instaweb
rm -f git-merge-recur && ln git-merge-recursive git-merge-recur
rm -f git-format-patch && ln git git-format-patch
rm -f git-show && ln git git-show
rm -f git-whatchanged && ln git git-whatchanged
rm -f git-get-tar-commit-id && ln git git-get-tar-commit-id
rm -f git-add && ln git git-add
rm -f git-apply && ln git git-apply
rm -f git-archive && ln git git-archive
rm -f git-cat-file && ln git git-cat-file
rm -f git-checkout-index && ln git git-checkout-index
rm -f git-check-ref-format && ln git git-check-ref-format
rm -f git-commit-tree && ln git git-commit-tree
rm -f git-count-objects && ln git git-count-objects
rm -f git-diff && ln git git-diff
rm -f git-diff-files && ln git git-diff-files
rm -f git-diff-index && ln git git-diff-index
rm -f git-diff-stages && ln git git-diff-stages
rm -f git-diff-tree && ln git git-diff-tree
rm -f git-fmt-merge-msg && ln git git-fmt-merge-msg
rm -f git-grep && ln git git-grep
rm -f git-init-db && ln git git-init-db
rm -f git-log && ln git git-log
rm -f git-ls-files && ln git git-ls-files
rm -f git-ls-tree && ln git git-ls-tree
rm -f git-mailinfo && ln git git-mailinfo
rm -f git-mailsplit && ln git git-mailsplit
rm -f git-mv && ln git git-mv
rm -f git-name-rev && ln git git-name-rev
rm -f git-pack-objects && ln git git-pack-objects
rm -f git-prune && ln git git-prune
rm -f git-prune-packed && ln git git-prune-packed
rm -f git-push && ln git git-push
rm -f git-read-tree && ln git git-read-tree
rm -f git-repo-config && ln git git-repo-config
rm -f git-rev-list && ln git git-rev-list
rm -f git-rev-parse && ln git git-rev-parse
rm -f git-rm && ln git git-rm
rm -f git-runstatus && ln git git-runstatus
rm -f git-show-branch && ln git git-show-branch
rm -f git-stripspace && ln git git-stripspace
rm -f git-symbolic-ref && ln git git-symbolic-ref
rm -f git-tar-tree && ln git git-tar-tree
rm -f git-unpack-objects && ln git git-unpack-objects
rm -f git-update-index && ln git git-update-index
rm -f git-update-ref && ln git git-update-ref
rm -f git-upload-archive && ln git git-upload-archive
rm -f git-write-tree && ln git git-write-tree
make -C perl
make[1]: Entering directory `/git.git/perl'
cp Git.pm blib/lib/Git.pm
Manifying blib/man3/Git.3pm
make[1]: Leaving directory `/git.git/perl'
make -C templates
make[1]: Entering directory `/git.git/templates'
ls *--* 2>/dev/null | \
	while read boilerplate; \
	do \
		case "$boilerplate" in *~) continue ;; esac && \
		dst=3D`echo "$boilerplate" | sed -e 's|^this|.|;s|--|/|g'` && \
		dir=3D`expr "$dst" : '\(.*\)/'` && \
		mkdir -p blt/$dir && \
		case "$boilerplate" in \
		*--) ;; \
		*) cp $boilerplate blt/$dst ;; \
		esac || exit; \
	done || exit
date >boilerplates.made
: no custom templates yet
make[1]: Leaving directory `/git.git/templates'
install -d -m755 '/var/tmp/ggg/bin'
install -d -m755 '/var/tmp/ggg/bin'
install git-convert-objects git-fetch-pack git-fsck-objects git-hash-object=
 git-index-pack git-local-fetch git-merge-base git-daemon git-merge-index g=
it-mktag git-mktree git-patch-id git-peek-remote git-receive-pack git-send-=
pack git-shell git-show-index git-ssh-fetch git-ssh-upload git-unpack-file =
git-update-server-info git-upload-pack git-verify-pack git-pack-redundant g=
it-var git-describe git-merge-tree git-blame git-imap-send git-merge-recurs=
ive  git-ssh-pull git-ssh-push git-http-fetch git-http-push git-bisect git-=
branch git-checkout git-cherry git-clean git-clone git-commit git-fetch git=
-ls-remote git-merge-one-file git-parse-remote git-pull git-rebase git-repa=
ck git-request-pull git-reset git-resolve git-revert git-sh-setup git-tag g=
it-verify-tag git-applymbox git-applypatch git-am git-merge git-merge-stupi=
d git-merge-octopus git-merge-resolve git-merge-ours git-lost-found git-qui=
ltimport git-archimport git-cvsimport git-relink git-shortlog git-rerere gi=
t-annotate git-cvsserver git-svnimport git-cvsexportcommit git-send-email g=
it-svn git-merge-recursive-old git-cherry-pick git-status git-instaweb git-=
merge-recur '/var/tmp/ggg/bin'
install git gitk '/var/tmp/ggg/bin'
make -C templates DESTDIR=3D'' install
make[1]: Entering directory `/git.git/templates'
: no custom templates yet
install -d -m755 '/var/tmp/ggg/share/git-core/templates/'
(cd blt && tar cf - .) | \
	(cd '/var/tmp/ggg/share/git-core/templates/' && tar xf -)
make[1]: Leaving directory `/git.git/templates'
make -C perl install
make[1]: Entering directory `/git.git/perl'
Installing /var/tmp/ggg/share/perl/5.8.8/Git.pm
Installing /var/tmp/ggg/man/man3/Git.3pm
Writing /var/tmp/ggg/lib/perl/5.8.8/auto/Git/.packlist
Appending installation info to /var/tmp/ggg/lib/perl/5.8.8/perllocal.pod
make[1]: Leaving directory `/git.git/perl'
install -d -m755 '/var/tmp/ggg/share/git-core/python'
install gitMergeCommon.py '/var/tmp/ggg/share/git-core/python'
if test 'z/var/tmp/ggg/bin' !=3D 'z/var/tmp/ggg/bin'; \
	then \
		ln -f '/var/tmp/ggg/bin/git' \
			'/var/tmp/ggg/bin/git' || \
		cp '/var/tmp/ggg/bin/git' \
			'/var/tmp/ggg/bin/git'; \
	fi
rm -f '/var/tmp/ggg/bin/git-format-patch' && ln '/var/tmp/ggg/bin/git' '/va=
r/tmp/ggg/bin/git-format-patch' ;  rm -f '/var/tmp/ggg/bin/git-show' && ln =
'/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/git-show' ;  rm -f '/var/tmp/ggg/b=
in/git-whatchanged' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/git-what=
changed' ;  rm -f '/var/tmp/ggg/bin/git-get-tar-commit-id' && ln '/var/tmp/=
ggg/bin/git' '/var/tmp/ggg/bin/git-get-tar-commit-id' ;  rm -f '/var/tmp/gg=
g/bin/git-add' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/git-add' ;  r=
m -f '/var/tmp/ggg/bin/git-apply' && ln '/var/tmp/ggg/bin/git' '/var/tmp/gg=
g/bin/git-apply' ;  rm -f '/var/tmp/ggg/bin/git-archive' && ln '/var/tmp/gg=
g/bin/git' '/var/tmp/ggg/bin/git-archive' ;  rm -f '/var/tmp/ggg/bin/git-ca=
t-file' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/git-cat-file' ;  rm =
-f '/var/tmp/ggg/bin/git-checkout-index' && ln '/var/tmp/ggg/bin/git' '/var=
/tmp/ggg/bin/git-checkout-index' ;  rm -f '/var/tmp/ggg/bin/git-check-ref-f=
ormat' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/git-check-ref-format'=
 ;  rm -f '/var/tmp/ggg/bin/git-commit-tree' && ln '/var/tmp/ggg/bin/git' '=
/var/tmp/ggg/bin/git-commit-tree' ;  rm -f '/var/tmp/ggg/bin/git-count-obje=
cts' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/git-count-objects' ;  r=
m -f '/var/tmp/ggg/bin/git-diff' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg=
/bin/git-diff' ;  rm -f '/var/tmp/ggg/bin/git-diff-files' && ln '/var/tmp/g=
gg/bin/git' '/var/tmp/ggg/bin/git-diff-files' ;  rm -f '/var/tmp/ggg/bin/gi=
t-diff-index' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/git-diff-index=
' ;  rm -f '/var/tmp/ggg/bin/git-diff-stages' && ln '/var/tmp/ggg/bin/git' =
'/var/tmp/ggg/bin/git-diff-stages' ;  rm -f '/var/tmp/ggg/bin/git-diff-tree=
' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/git-diff-tree' ;  rm -f '/=
var/tmp/ggg/bin/git-fmt-merge-msg' && ln '/var/tmp/ggg/bin/git' '/var/tmp/g=
gg/bin/git-fmt-merge-msg' ;  rm -f '/var/tmp/ggg/bin/git-grep' && ln '/var/=
tmp/ggg/bin/git' '/var/tmp/ggg/bin/git-grep' ;  rm -f '/var/tmp/ggg/bin/git=
-init-db' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/git-init-db' ;  rm=
 -f '/var/tmp/ggg/bin/git-log' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/b=
in/git-log' ;  rm -f '/var/tmp/ggg/bin/git-ls-files' && ln '/var/tmp/ggg/bi=
n/git' '/var/tmp/ggg/bin/git-ls-files' ;  rm -f '/var/tmp/ggg/bin/git-ls-tr=
ee' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/git-ls-tree' ;  rm -f '/=
var/tmp/ggg/bin/git-mailinfo' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bi=
n/git-mailinfo' ;  rm -f '/var/tmp/ggg/bin/git-mailsplit' && ln '/var/tmp/g=
gg/bin/git' '/var/tmp/ggg/bin/git-mailsplit' ;  rm -f '/var/tmp/ggg/bin/git=
-mv' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/git-mv' ;  rm -f '/var/=
tmp/ggg/bin/git-name-rev' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/gi=
t-name-rev' ;  rm -f '/var/tmp/ggg/bin/git-pack-objects' && ln '/var/tmp/gg=
g/bin/git' '/var/tmp/ggg/bin/git-pack-objects' ;  rm -f '/var/tmp/ggg/bin/g=
it-prune' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/git-prune' ;  rm -=
f '/var/tmp/ggg/bin/git-prune-packed' && ln '/var/tmp/ggg/bin/git' '/var/tm=
p/ggg/bin/git-prune-packed' ;  rm -f '/var/tmp/ggg/bin/git-push' && ln '/va=
r/tmp/ggg/bin/git' '/var/tmp/ggg/bin/git-push' ;  rm -f '/var/tmp/ggg/bin/g=
it-read-tree' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/git-read-tree'=
 ;  rm -f '/var/tmp/ggg/bin/git-repo-config' && ln '/var/tmp/ggg/bin/git' '=
/var/tmp/ggg/bin/git-repo-config' ;  rm -f '/var/tmp/ggg/bin/git-rev-list' =
&& ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/git-rev-list' ;  rm -f '/var=
/tmp/ggg/bin/git-rev-parse' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/=
git-rev-parse' ;  rm -f '/var/tmp/ggg/bin/git-rm' && ln '/var/tmp/ggg/bin/g=
it' '/var/tmp/ggg/bin/git-rm' ;  rm -f '/var/tmp/ggg/bin/git-runstatus' && =
ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/git-runstatus' ;  rm -f '/var/t=
mp/ggg/bin/git-show-branch' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/=
git-show-branch' ;  rm -f '/var/tmp/ggg/bin/git-stripspace' && ln '/var/tmp=
/ggg/bin/git' '/var/tmp/ggg/bin/git-stripspace' ;  rm -f '/var/tmp/ggg/bin/=
git-symbolic-ref' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/git-symbol=
ic-ref' ;  rm -f '/var/tmp/ggg/bin/git-tar-tree' && ln '/var/tmp/ggg/bin/gi=
t' '/var/tmp/ggg/bin/git-tar-tree' ;  rm -f '/var/tmp/ggg/bin/git-unpack-ob=
jects' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/git-unpack-objects' ;=
  rm -f '/var/tmp/ggg/bin/git-update-index' && ln '/var/tmp/ggg/bin/git' '/=
var/tmp/ggg/bin/git-update-index' ;  rm -f '/var/tmp/ggg/bin/git-update-ref=
' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/git-update-ref' ;  rm -f '=
/var/tmp/ggg/bin/git-upload-archive' && ln '/var/tmp/ggg/bin/git' '/var/tmp=
/ggg/bin/git-upload-archive' ;  rm -f '/var/tmp/ggg/bin/git-verify-pack' &&=
 ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bin/git-verify-pack' ;  rm -f '/va=
r/tmp/ggg/bin/git-write-tree' && ln '/var/tmp/ggg/bin/git' '/var/tmp/ggg/bi=
n/git-write-tree' ;
: gitster;=20
Script done on Tue 14 Nov 2006 08:44:28 PM PST

--=-=-=--
