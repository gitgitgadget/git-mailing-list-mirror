From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2] pull: introduce a pull.rebase option to enable --rebase
Date: Sun,  6 Nov 2011 10:50:10 +0100
Message-ID: <1320573010-12296-1-git-send-email-avarab@gmail.com>
References: <7v8vnt7kvd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Eric Herman <eric@freesa.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Fernando Vezzosi <buccia@repnz.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 06 10:54:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMzQe-00034L-Bi
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 10:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962Ab1KFJuo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Nov 2011 04:50:44 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38856 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab1KFJun (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 04:50:43 -0500
Received: by faao14 with SMTP id o14so4163711faa.19
        for <git@vger.kernel.org>; Sun, 06 Nov 2011 01:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Mf2aItc/DoZoSBMSKxugJnR5I/gCqForPamv/deH+Oo=;
        b=SIunE71crD/eG+xf2stCtZTipV+NlJeYbxyLgWyHWe13A+cajuS6Nig7aI2+Tigecf
         oM5Sm/LSAJ6tFKjq2Dtnvr2bPeGqQ7Vv7BIE/qY/4ftJd0UQFsVe3CVU/hosuAzDUBlc
         rWP0VEulVsXihZ3Qyx5GupmurQX49SY9WJFvY=
Received: by 10.223.76.197 with SMTP id d5mr38385441fak.13.1320573041405;
        Sun, 06 Nov 2011 01:50:41 -0800 (PST)
Received: from snth.ams7.corp.booking.com ([62.140.137.119])
        by mx.google.com with ESMTPS id f14sm2520151fah.6.2011.11.06.01.50.38
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Nov 2011 01:50:40 -0800 (PST)
X-Mailer: git-send-email 1.7.6.3
In-Reply-To: <7v8vnt7kvd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184907>

Currently we either need to set branch.<name>.rebase for existing
branches if we'd like "git pull" to mean "git pull --rebase", or have
the forethought of setting "branch.autosetuprebase" before we create
the branch.

But there's no way to globally configure "git pull" to mean "git pull
--rebase" for existing branches, introduce a "pull.rebase" option to
do that.

This option will be considered at a lower priority than
branch.<name>.rebase, i.e. we could set pull.rebase=3Dtrue and
branch.<name>.rebase=3Dfalse and the latter configuration option would
win.

Reviewed-by: Sverre Rabbelier <srabbelier@gmail.com>
Reviewed-by: Fernando Vezzosi <buccia@repnz.net>
Reviewed-by: Eric Herman <eric@freesa.org>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

On Sun, Nov 6, 2011 at 08:47, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> This option will be considered at a lower priority than
>> branch.<name>.rebase, i.e. we could set pull.rebase=3Dtrue and
>> branch.<name>.rebase=3Dfalse and the latter configuration option wou=
ld
>> win.
>>
>> Reviewed-by: Sverre Rabbelier <srabbelier@gmail.com>
>> Reviewed-by: Fernando Vezzosi <buccia@repnz.net>
>> Reviewed-by: Eric Herman <eric@freesa.org>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.=
com>
>
> I see many reviewed-by lines, but what kind of review did this patch =
have,
> exactly? It seem to break its own test (branch.to-rebase.rebase shoul=
d
> override pull.rebase).

We all stood behind my laptop while I explained what it did and
why. Sverre pointed out that I should use the test_when_finished()
function for unsetting the config variables, Eric and Fernando looked
it over as well.

> I think I've queued most (if not all) of the patches in flight except=
 for
> Ram's sequencer reroll to 'pu' and pu^ passes the test but the tip of=
 pu
> does not due to this topic.

Due to a trivial error of mine. I sent out the wrong patch as Sverre
thought, the problem was that I was trying to --unset a config
variable twice, that's now fixed and the tests pass with this patch.

 Documentation/config.txt   |   14 +++++++++++++-
 Documentation/git-pull.txt |    2 +-
 git-pull.sh                |    4 ++++
 t/t5520-pull.sh            |   23 +++++++++++++++++++++--
 4 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5a841da..b2d7d92 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -677,7 +677,9 @@ branch.<name>.mergeoptions::
 branch.<name>.rebase::
 	When true, rebase the branch <name> on top of the fetched branch,
 	instead of merging the default branch from the default remote when
-	"git pull" is run.
+	"git pull" is run. See "pull.rebase" for doing this in a non
+	branch-specific manner.
+
 	*NOTE*: this is a possibly dangerous operation; do *not* use
 	it unless you understand the implications (see linkgit:git-rebase[1]
 	for details).
@@ -1590,6 +1592,16 @@ pretty.<name>::
 	Note that an alias with the same name as a built-in format
 	will be silently ignored.
=20
+pull.rebase::
+	When true, rebase branches on top of the fetched branch, instead
+	of merging the default branch from the default remote when "git
+	pull" is run. See "branch.<name>.rebase" for setting this on a
+	per-branch basis.
+
+	*NOTE*: this is a possibly dangerous operation; do *not* use
+	it unless you understand the implications (see linkgit:git-rebase[1]
+	for details).
+
 pull.octopus::
 	The default merge strategy to use when pulling multiple branches
 	at once.
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index e1da468..0f18ec8 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -108,7 +108,7 @@ include::merge-options.txt[]
 	fetched, the rebase uses that information to avoid rebasing
 	non-local changes.
 +
-See `branch.<name>.rebase` and `branch.autosetuprebase` in
+See `pull.rebase`, `branch.<name>.rebase` and `branch.autosetuprebase`=
 in
 linkgit:git-config[1] if you want to make `git pull` always use
 `{litdd}rebase` instead of merging.
 +
diff --git a/git-pull.sh b/git-pull.sh
index 9868a0b..24b6b7c 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -44,6 +44,10 @@ merge_args=3D
 curr_branch=3D$(git symbolic-ref -q HEAD)
 curr_branch_short=3D"${curr_branch#refs/heads/}"
 rebase=3D$(git config --bool branch.$curr_branch_short.rebase)
+if test -z "$rebase"
+then=20
+	rebase=3D$(git config --bool pull.rebase)
+fi
 dry_run=3D
 while :
 do
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 0e5eb67..35304b4 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -94,16 +94,35 @@ test_expect_success '--rebase' '
 	test $(git rev-parse HEAD^) =3D $(git rev-parse copy) &&
 	test new =3D $(git show HEAD:file2)
 '
+test_expect_success 'pull.rebase' '
+	git reset --hard before-rebase &&
+	git config --bool pull.rebase true &&
+	test_when_finished "git config --unset pull.rebase" &&
+	git pull . copy &&
+	test $(git rev-parse HEAD^) =3D $(git rev-parse copy) &&
+	test new =3D $(git show HEAD:file2)
+'
=20
 test_expect_success 'branch.to-rebase.rebase' '
 	git reset --hard before-rebase &&
-	git config branch.to-rebase.rebase 1 &&
+	git config --bool branch.to-rebase.rebase true &&
+	test_when_finished "git config --unset branch.to-rebase.rebase" &&
 	git pull . copy &&
-	git config branch.to-rebase.rebase 0 &&
 	test $(git rev-parse HEAD^) =3D $(git rev-parse copy) &&
 	test new =3D $(git show HEAD:file2)
 '
=20
+test_expect_success 'branch.to-rebase.rebase should override pull.reba=
se' '
+	git reset --hard before-rebase &&
+	git config --bool pull.rebase true &&
+	test_when_finished "git config --unset pull.rebase" &&
+	git config --bool branch.to-rebase.rebase false &&
+	test_when_finished "git config --unset branch.to-rebase.rebase" &&
+	git pull . copy &&
+	test $(git rev-parse HEAD^) !=3D $(git rev-parse copy) &&
+	test new =3D $(git show HEAD:file2)
+'
+
 test_expect_success '--rebase with rebased upstream' '
=20
 	git remote add -f me . &&
--=20
1.7.6.3
