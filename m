From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 1/3] t/gitweb-lib.sh: print to stderr when gitweb_run has errors
Date: Sat, 19 Feb 2011 19:16:19 +0100
Message-ID: <201102191916.21164.jnareb@gmail.com>
References: <1298124654-12051-1-git-send-email-avarab@gmail.com> <201102191646.02543.jnareb@gmail.com> <AANLkTimFyue2F6aRg7KdqOJZw9dOHY+B0XWCiVBYNOeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 19:16:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqrMN-00071M-Bd
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 19:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702Ab1BSSQd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 13:16:33 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56037 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754577Ab1BSSQc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 13:16:32 -0500
Received: by bwz15 with SMTP id 15so1912bwz.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 10:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=e1ffxQN+NRrKwLYiRcTjw8I3awdNFPrOf7GFnIDsAVU=;
        b=ps9Ky6RbrJOtpoz+GnfhcwajclDfVwlJSjxLgWaMe1bU4EhQFOyFr6qoiCEhylz57I
         ZrZ1o+2jN1n3Vp3ypSiQkm7Ic1TtnJmBzDCjQzCQhJVNglpEEituLD91rw7p+S4u+SeT
         k0TiHKK9fpKY3jyDtWngNTEm5QkKibpUS97h0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=EACOH9WDYsGWRvboPfizDJmm1huQAeL0P7waMutbzSlx6pHTlKuGe2Wqr2KhxXj4+i
         4fEJ2bNYURWDbyUeY+SUK5Ep0eEogcpyxwC77wq5afRYFdlXmXE1McdxobVCmgQ5XAwU
         pV/7kTW0bKCTXNGAce9R/sjOpHi+iYhjC0OE0=
Received: by 10.204.103.132 with SMTP id k4mr1884942bko.28.1298139389158;
        Sat, 19 Feb 2011 10:16:29 -0800 (PST)
Received: from [192.168.1.13] (abwm176.neoplus.adsl.tpnet.pl [83.8.236.176])
        by mx.google.com with ESMTPS id j11sm2419542bka.12.2011.02.19.10.16.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 10:16:27 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTimFyue2F6aRg7KdqOJZw9dOHY+B0XWCiVBYNOeg@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167304>

On Sat, 19 Feb 2011, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Sat, Feb 19, 2011 at 16:46, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>> On Sat, 19 Feb 2011, =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason wrote:
>>
>>> Change the gitweb_run test subroutine to spew errors to stderr if
>>> there are any, previously it would just silently fail, which made
>>> tests very hard to debug.
>>>
>>> Before you'd get this output, when running tests under `--verbose
>>> --immediate --debug`:
>>
>> Which test?
>>
>> [...]
>>> --- a/t/gitweb-lib.sh
>>> +++ b/t/gitweb-lib.sh
>>> @@ -82,7 +82,12 @@ gitweb_run () {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close O;
>>> =C2=A0 =C2=A0 =C2=A0 ' gitweb.output &&
>>> - =C2=A0 =C2=A0 if grep '^[[]' gitweb.log>/dev/null 2>&1; then fals=
e; else true; fi
>>> + =C2=A0 =C2=A0 if grep '^[[]' gitweb.log>/dev/null 2>&1; then
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cat gitweb.log>&2
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 false
>>> + =C2=A0 =C2=A0 else
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 true
>>> + =C2=A0 =C2=A0 fi
>>
>> I don't understand this change. =C2=A0Either it is not necessary, be=
cause
>> test suite (or at least t9500) has
>>
>> =C2=A0test_debug 'cat gitweb.log'
>>
>> after each test, so that error messages would be printed with `--deb=
ug`,
>> or it doesn't go far enough: if the above is used then those test_de=
bug
>> should be removed.
>=20
> The way you're using test_debug() is incompatible with
> --immediate. The test dies, but I'll never see your debug message
> because I'm using --immediate.

Ah, so that is what it is about: using --immediate negates --debug.

Note that it is *much* wider issue; it is not only gitweb tests that us=
e
test_debug in such way.  See for example t/t4114-apply-typechange.sh
where you have

  test_expect_success SYMLINKS 'directory becomes symlink' '
        git checkout -f foo-becomes-a-directory &&
        git diff-tree -p HEAD foo-symlinked-to-bar > patch &&
        git apply --index < patch
        '
  test_debug 'cat patch'

This causes the same problem.

> It would be better to just use test_debug in gitweb_run (instead of m=
y
> "cat gitweb.log").
>=20
> Anyway, if you feel like fixing that feel free, I wan't pursue this
> further (going to hack on what I was going to do before gitweb tests
> started failing).
>=20
> Junio, you can drop this patch since it'll produce duplicate output i=
f
> the test fails and the user *doesn't* use --immediate, but IMO this
> should be fixed by doing the debug output differently.
=20
Below there is proposed patch that removes duplication of --debug outpu=
t...
but does not solve issue for other places where we use test_debug in te=
st
suite and incompatibility with --immediate run.

-- >8 --
=46rom: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Subject: [PATCH] t/gitweb-lib.sh: Ensure that errors are shown for --de=
bug --immediate

Because '--immediate' stops test suite after first error, therefore in
this mode

  test_debug 'cat gitweb.log'

was never ran, thus in effect negating effect of '--debug' option.
This made finidng the cause of errors in gitweb test sute difficult.

Modify the gitweb_run test subroutine to run test_debug itself in the
case of errors (and also remove "test_debug 'cat gitweb.log'" from
gitweb tests).

This makes it possible to run *gitweb tests* with --immediate ---debug
combination of options; also it makes gitweb tests to not output
spurious debug data that is not considered error.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
---
 t/gitweb-lib.sh                          |    7 ++
 t/t9500-gitweb-standalone-no-errors.sh   |   86 ----------------------=
--------
 t/t9501-gitweb-standalone-http-status.sh |    1=20
 3 files changed, 6 insertions(+), 88 deletions(-)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index b9bb95f..143eb1f 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -82,7 +82,12 @@ gitweb_run () {
 		}
 		close O;
 	' gitweb.output &&
-	if grep '^[[]' gitweb.log >/dev/null 2>&1; then false; else true; fi
+	if grep '^[[]' gitweb.log >/dev/null 2>&1; then
+		test_debug 'cat gitweb.log >&2' &&
+		false
+	else
+		true
+	fi
=20
 	# gitweb.log is left for debugging
 	# gitweb.output is used to parse HTTP output
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-st=
andalone-no-errors.sh
index 21cd286..35c151d 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -18,42 +18,34 @@ or warnings to log.'
 test_expect_success \
 	'no commits: projects_list (implicit)' \
 	'gitweb_run'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'no commits: projects_index' \
 	'gitweb_run "a=3Dproject_index"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'no commits: .git summary (implicit)' \
 	'gitweb_run "p=3D.git"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'no commits: .git commit (implicit HEAD)' \
 	'gitweb_run "p=3D.git;a=3Dcommit"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'no commits: .git commitdiff (implicit HEAD)' \
 	'gitweb_run "p=3D.git;a=3Dcommitdiff"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'no commits: .git tree (implicit HEAD)' \
 	'gitweb_run "p=3D.git;a=3Dtree"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'no commits: .git heads' \
 	'gitweb_run "p=3D.git;a=3Dheads"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'no commits: .git tags' \
 	'gitweb_run "p=3D.git;a=3Dtags"'
-test_debug 'cat gitweb.log'
=20
=20
 # --------------------------------------------------------------------=
--
@@ -69,52 +61,42 @@ test_expect_success \
 test_expect_success \
 	'projects_list (implicit)' \
 	'gitweb_run'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'projects_index' \
 	'gitweb_run "a=3Dproject_index"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'.git summary (implicit)' \
 	'gitweb_run "p=3D.git"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'.git commit (implicit HEAD)' \
 	'gitweb_run "p=3D.git;a=3Dcommit"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'.git commitdiff (implicit HEAD, root commit)' \
 	'gitweb_run "p=3D.git;a=3Dcommitdiff"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'.git commitdiff_plain (implicit HEAD, root commit)' \
 	'gitweb_run "p=3D.git;a=3Dcommitdiff_plain"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'.git commit (HEAD)' \
 	'gitweb_run "p=3D.git;a=3Dcommit;h=3DHEAD"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'.git tree (implicit HEAD)' \
 	'gitweb_run "p=3D.git;a=3Dtree"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'.git blob (file)' \
 	'gitweb_run "p=3D.git;a=3Dblob;f=3Dfile"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'.git blob_plain (file)' \
 	'gitweb_run "p=3D.git;a=3Dblob_plain;f=3Dfile"'
-test_debug 'cat gitweb.log'
=20
 # --------------------------------------------------------------------=
--
 # nonexistent objects
@@ -122,37 +104,30 @@ test_debug 'cat gitweb.log'
 test_expect_success \
 	'.git commit (non-existent)' \
 	'gitweb_run "p=3D.git;a=3Dcommit;h=3Dnon-existent"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'.git commitdiff (non-existent)' \
 	'gitweb_run "p=3D.git;a=3Dcommitdiff;h=3Dnon-existent"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'.git commitdiff (non-existent vs HEAD)' \
 	'gitweb_run "p=3D.git;a=3Dcommitdiff;hp=3Dnon-existent;h=3DHEAD"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'.git tree (0000000000000000000000000000000000000000)' \
 	'gitweb_run "p=3D.git;a=3Dtree;h=3D0000000000000000000000000000000000=
000000"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'.git tag (0000000000000000000000000000000000000000)' \
 	'gitweb_run "p=3D.git;a=3Dtag;h=3D00000000000000000000000000000000000=
00000"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'.git blob (non-existent)' \
 	'gitweb_run "p=3D.git;a=3Dblob;f=3Dnon-existent"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'.git blob_plain (non-existent)' \
 	'gitweb_run "p=3D.git;a=3Dblob_plain;f=3Dnon-existent"'
-test_debug 'cat gitweb.log'
=20
=20
 # --------------------------------------------------------------------=
--
@@ -161,7 +136,6 @@ test_debug 'cat gitweb.log'
 test_expect_success \
 	'commitdiff(0): root' \
 	'gitweb_run "p=3D.git;a=3Dcommitdiff"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'commitdiff(0): file added' \
@@ -169,21 +143,18 @@ test_expect_success \
 	 git add new_file &&
 	 git commit -a -m "File added." &&
 	 gitweb_run "p=3D.git;a=3Dcommitdiff"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'commitdiff(0): mode change' \
 	'test_chmod +x new_file &&
 	 git commit -a -m "Mode changed." &&
 	 gitweb_run "p=3D.git;a=3Dcommitdiff"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'commitdiff(0): file renamed' \
 	'git mv new_file renamed_file &&
 	 git commit -a -m "File renamed." &&
 	 gitweb_run "p=3D.git;a=3Dcommitdiff"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success SYMLINKS \
 	'commitdiff(0): file to symlink' \
@@ -191,7 +162,6 @@ test_expect_success SYMLINKS \
 	 ln -s file renamed_file &&
 	 git commit -a -m "File to symlink." &&
 	 gitweb_run "p=3D.git;a=3Dcommitdiff"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'commitdiff(0): file deleted' \
@@ -199,7 +169,6 @@ test_expect_success \
 	 rm -f renamed_file &&
 	 git commit -a -m "File removed." &&
 	 gitweb_run "p=3D.git;a=3Dcommitdiff"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'commitdiff(0): file copied / new file' \
@@ -207,7 +176,6 @@ test_expect_success \
 	 git add file2 &&
 	 git commit -a -m "File copied." &&
 	 gitweb_run "p=3D.git;a=3Dcommitdiff"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'commitdiff(0): mode change and modified' \
@@ -215,7 +183,6 @@ test_expect_success \
 	 test_chmod +x file2 &&
 	 git commit -a -m "Mode change and modification." &&
 	 gitweb_run "p=3D.git;a=3Dcommitdiff"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'commitdiff(0): renamed and modified' \
@@ -233,7 +200,6 @@ EOF
 	 echo "Propter nomen suum." >> file3 &&
 	 git commit -a -m "File rename and modification." &&
 	 gitweb_run "p=3D.git;a=3Dcommitdiff"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'commitdiff(0): renamed, mode change and modified' \
@@ -242,7 +208,6 @@ test_expect_success \
 	 test_chmod +x file2 &&
 	 git commit -a -m "File rename, mode change and modification." &&
 	 gitweb_run "p=3D.git;a=3Dcommitdiff"'
-test_debug 'cat gitweb.log'
=20
 # --------------------------------------------------------------------=
--
 # commitdiff testing (taken from t4114-apply-typechange.sh)
@@ -279,42 +244,34 @@ test_expect_success SYMLINKS 'setup typechange co=
mmits' '
 test_expect_success \
 	'commitdiff(2): file renamed from foo to foo/baz' \
 	'gitweb_run "p=3D.git;a=3Dcommitdiff;hp=3Dinitial;h=3Dfoo-baz-renamed=
-from-foo"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'commitdiff(2): file renamed from foo/baz to foo' \
 	'gitweb_run "p=3D.git;a=3Dcommitdiff;hp=3Dfoo-baz-renamed-from-foo;h=3D=
initial"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'commitdiff(2): directory becomes file' \
 	'gitweb_run "p=3D.git;a=3Dcommitdiff;hp=3Dfoo-becomes-a-directory;h=3D=
initial"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'commitdiff(2): file becomes directory' \
 	'gitweb_run "p=3D.git;a=3Dcommitdiff;hp=3Dinitial;h=3Dfoo-becomes-a-d=
irectory"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'commitdiff(2): file becomes symlink' \
 	'gitweb_run "p=3D.git;a=3Dcommitdiff;hp=3Dinitial;h=3Dfoo-symlinked-t=
o-bar"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'commitdiff(2): symlink becomes file' \
 	'gitweb_run "p=3D.git;a=3Dcommitdiff;hp=3Dfoo-symlinked-to-bar;h=3Dfo=
o-back-to-file"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'commitdiff(2): symlink becomes directory' \
 	'gitweb_run "p=3D.git;a=3Dcommitdiff;hp=3Dfoo-symlinked-to-bar;h=3Dfo=
o-becomes-a-directory"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'commitdiff(2): directory becomes symlink' \
 	'gitweb_run "p=3D.git;a=3Dcommitdiff;hp=3Dfoo-becomes-a-directory;h=3D=
foo-symlinked-to-bar"'
-test_debug 'cat gitweb.log'
=20
 # --------------------------------------------------------------------=
--
 # commit, commitdiff: merge, large
@@ -330,12 +287,10 @@ test_expect_success \
 test_expect_success \
 	'commit(0): merge commit' \
 	'gitweb_run "p=3D.git;a=3Dcommit"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'commitdiff(0): merge commit' \
 	'gitweb_run "p=3D.git;a=3Dcommitdiff"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'Prepare large commit' \
@@ -371,12 +326,10 @@ test_expect_success \
 test_expect_success \
 	'commit(1): large commit' \
 	'gitweb_run "p=3D.git;a=3Dcommit;h=3Db"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'commitdiff(1): large commit' \
 	'gitweb_run "p=3D.git;a=3Dcommitdiff;h=3Db"'
-test_debug 'cat gitweb.log'
=20
 # --------------------------------------------------------------------=
--
 # tags testing
@@ -394,17 +347,14 @@ test_expect_success \
 	 git tag lightweight/tag-tree HEAD^{tree} &&
 	 git tag lightweight/tag-blob HEAD:file &&
 	 gitweb_run "p=3D.git;a=3Dtags"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'tag: Tag to commit object' \
 	'gitweb_run "p=3D.git;a=3Dtag;h=3Dtag-commit"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'tag: on lightweight tag (invalid)' \
 	'gitweb_run "p=3D.git;a=3Dtag;h=3Dlightweight/tag-commit"'
-test_debug 'cat gitweb.log'
=20
 # --------------------------------------------------------------------=
--
 # logs
@@ -412,22 +362,18 @@ test_debug 'cat gitweb.log'
 test_expect_success \
 	'logs: log (implicit HEAD)' \
 	'gitweb_run "p=3D.git;a=3Dlog"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'logs: shortlog (implicit HEAD)' \
 	'gitweb_run "p=3D.git;a=3Dshortlog"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'logs: history (implicit HEAD, file)' \
 	'gitweb_run "p=3D.git;a=3Dhistory;f=3Dfile"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'logs: history (implicit HEAD, non-existent file)' \
 	'gitweb_run "p=3D.git;a=3Dhistory;f=3Dnon-existent"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'logs: history (implicit HEAD, deleted file)' \
@@ -438,55 +384,45 @@ test_expect_success \
 	 git rm deleted_file &&
 	 git commit -m "Delete file" &&
 	 gitweb_run "p=3D.git;a=3Dhistory;f=3Ddeleted_file"'
-test_debug 'cat gitweb.log'
=20
 # --------------------------------------------------------------------=
--
 # path_info links
 test_expect_success \
 	'path_info: project' \
 	'gitweb_run "" "/.git"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'path_info: project/branch' \
 	'gitweb_run "" "/.git/b"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'path_info: project/branch:file' \
 	'gitweb_run "" "/.git/master:file"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'path_info: project/branch:dir/' \
 	'gitweb_run "" "/.git/master:foo/"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'path_info: project/branch:file (non-existent)' \
 	'gitweb_run "" "/.git/master:non-existent"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'path_info: project/branch:dir/ (non-existent)' \
 	'gitweb_run "" "/.git/master:non-existent/"'
-test_debug 'cat gitweb.log'
=20
=20
 test_expect_success \
 	'path_info: project/branch:/file' \
 	'gitweb_run "" "/.git/master:/file"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'path_info: project/:/file (implicit HEAD)' \
 	'gitweb_run "" "/.git/:/file"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'path_info: project/:/ (implicit HEAD, top tree)' \
 	'gitweb_run "" "/.git/:/"'
-test_debug 'cat gitweb.log'
=20
=20
 # --------------------------------------------------------------------=
--
@@ -495,17 +431,14 @@ test_debug 'cat gitweb.log'
 test_expect_success \
 	'feeds: OPML' \
 	'gitweb_run "a=3Dopml"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'feed: RSS' \
 	'gitweb_run "p=3D.git;a=3Drss"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'feed: Atom' \
 	'gitweb_run "p=3D.git;a=3Datom"'
-test_debug 'cat gitweb.log'
=20
 # --------------------------------------------------------------------=
--
 # encoding/decoding
@@ -517,7 +450,6 @@ test_expect_success \
 	 git add file &&
 	 git commit -F "$TEST_DIRECTORY"/t3900/1-UTF-8.txt &&
 	 gitweb_run "p=3D.git;a=3Dcommit"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'encode(commit): iso-8859-1' \
@@ -528,12 +460,10 @@ test_expect_success \
 	 git commit -F "$TEST_DIRECTORY"/t3900/ISO8859-1.txt &&
 	 git config --unset i18n.commitencoding &&
 	 gitweb_run "p=3D.git;a=3Dcommit"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'encode(log): utf-8 and iso-8859-1' \
 	'gitweb_run "p=3D.git;a=3Dlog"'
-test_debug 'cat gitweb.log'
=20
 # --------------------------------------------------------------------=
--
 # extra options
@@ -541,27 +471,22 @@ test_debug 'cat gitweb.log'
 test_expect_success \
 	'opt: log --no-merges' \
 	'gitweb_run "p=3D.git;a=3Dlog;opt=3D--no-merges"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'opt: atom --no-merges' \
 	'gitweb_run "p=3D.git;a=3Dlog;opt=3D--no-merges"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'opt: "file" history --no-merges' \
 	'gitweb_run "p=3D.git;a=3Dhistory;f=3Dfile;opt=3D--no-merges"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'opt: log --no-such-option (invalid option)' \
 	'gitweb_run "p=3D.git;a=3Dlog;opt=3D--no-such-option"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'opt: tree --no-merges (invalid option for action)' \
 	'gitweb_run "p=3D.git;a=3Dtree;opt=3D--no-merges"'
-test_debug 'cat gitweb.log'
=20
 # --------------------------------------------------------------------=
--
 # testing config_to_multi / cloneurl
@@ -569,14 +494,12 @@ test_debug 'cat gitweb.log'
 test_expect_success \
        'URL: no project URLs, no base URL' \
        'gitweb_run "p=3D.git;a=3Dsummary"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
        'URL: project URLs via gitweb.url' \
        'git config --add gitweb.url git://example.com/git/trash.git &&
         git config --add gitweb.url http://example.com/git/trash.git &=
&
         gitweb_run "p=3D.git;a=3Dsummary"'
-test_debug 'cat gitweb.log'
=20
 cat >.git/cloneurl <<\EOF
 git://example.com/git/trash.git
@@ -586,7 +509,6 @@ EOF
 test_expect_success \
        'URL: project URLs via cloneurl file' \
        'gitweb_run "p=3D.git;a=3Dsummary"'
-test_debug 'cat gitweb.log'
=20
 # --------------------------------------------------------------------=
--
 # gitweb config and repo config
@@ -604,12 +526,10 @@ EOF
 test_expect_success \
 	'config override: projects list (implicit)' \
 	'gitweb_run'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'config override: tree view, features not overridden in repo config' =
\
 	'gitweb_run "p=3D.git;a=3Dtree"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'config override: tree view, features disabled in repo config' \
@@ -617,14 +537,12 @@ test_expect_success \
 	 git config gitweb.snapshot none &&
 	 git config gitweb.avatar gravatar &&
 	 gitweb_run "p=3D.git;a=3Dtree"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success \
 	'config override: tree view, features enabled in repo config (1)' \
 	'git config gitweb.blame yes &&
 	 git config gitweb.snapshot "zip,tgz, tbz2" &&
 	 gitweb_run "p=3D.git;a=3Dtree"'
-test_debug 'cat gitweb.log'
=20
 cat >.git/config <<\EOF
 # testing noval and alternate separator
@@ -635,7 +553,6 @@ EOF
 test_expect_success \
 	'config override: tree view, features enabled in repo config (2)' \
 	'gitweb_run "p=3D.git;a=3Dtree"'
-test_debug 'cat gitweb.log'
=20
 # --------------------------------------------------------------------=
--
 # non-ASCII in README.html
@@ -645,7 +562,6 @@ test_expect_success \
 	'echo "<b>UTF-8 example:</b><br />" > .git/README.html &&
 	 cat "$TEST_DIRECTORY"/t3900/1-UTF-8.txt >> .git/README.html &&
 	 gitweb_run "p=3D.git;a=3Dsummary"'
-test_debug 'cat gitweb.log'
=20
 # --------------------------------------------------------------------=
--
 # syntax highlighting
@@ -666,7 +582,6 @@ test_expect_success HIGHLIGHT \
 	'syntax highlighting (no highlight, unknown syntax)' \
 	'git config gitweb.highlight yes &&
 	 gitweb_run "p=3D.git;a=3Dblob;f=3Dfile"'
-test_debug 'cat gitweb.log'
=20
 test_expect_success HIGHLIGHT \
 	'syntax highlighting (highlighted, shell script)' \
@@ -675,6 +590,5 @@ test_expect_success HIGHLIGHT \
 	 git add test.sh &&
 	 git commit -m "Add test.sh" &&
 	 gitweb_run "p=3D.git;a=3Dblob;f=3Dtest.sh"'
-test_debug 'cat gitweb.log'
=20
 test_done
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-=
standalone-http-status.sh
index 18825af..26102ee 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -126,7 +126,6 @@ test_expect_success 'load checking: load too high (=
default action)' '
 	grep "Status: 503 Service Unavailable" gitweb.headers &&
 	grep "503 - The load average on the server is too high" gitweb.body
 '
-test_debug 'cat gitweb.log' # just in case
 test_debug 'cat gitweb.headers'
=20
 # turn off load checking
