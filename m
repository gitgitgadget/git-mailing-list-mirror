From: =?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@gmail.com>
Subject: Re: [StGit PATCH] edit: Allow setting git tree SHA1 of a patch
Date: Fri, 21 May 2010 20:45:27 +0200
Message-ID: <AANLkTinPDGsSEQeY1jfBDLAuQD42fEUoUeGXuvgJ8ZI3@mail.gmail.com>
References: <20100516172738.5043.94039.stgit@localhost.localdomain>
	 <AANLkTikcG3Chw1cpiKB00MrnZz-HZk9xAF_KtTTiVECi@mail.gmail.com>
	 <u5tzkzt73us.fsf@beatles.e.vtech>
	 <AANLkTilV3VQARdyZ-m9GCXz1Rwt0j6Q6noNyFrmmDzR5@mail.gmail.com>
	 <AANLkTimYCxzT16aI96dztmcKYuVrvKikSkrkRHT-Ckcd@mail.gmail.com>
	 <AANLkTimIxtmaUNxp-LNy_ui5__BEBetcjTYE17ygIXD2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>,
	kha@treskal.com, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 21 20:45:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFXE0-0007pK-0Q
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 20:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757Ab0EUSpa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 May 2010 14:45:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55705 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580Ab0EUSp3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 May 2010 14:45:29 -0400
Received: by fxm5 with SMTP id 5so1133254fxm.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 11:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OPP+NZUvqj964dVjlqOlz+tr/TmThUz5gYn4gTMsjm4=;
        b=OFRyNrdoyXccwCqv5KoIdxo6cjSDrWkfEyY3yMdVDYdq4HSNSljvKddwzGVMfjVtUy
         CqevApcRFQ3VNf+BpSwtjDAgT6GKAYgYjju6uXaMRfPzatH8wmBB0kTGU0t+o+bIJUPu
         9E0X5CbaSEoymQoxjgFHMdOiUvHHAeFr2fnbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RLBZB4H87hJi4mBYCsFhTvrsH27UItomx66aqcOslGOwqrugODaHjGKNGnJzPAPmI9
         pi66n9T1NUD9puYFx5ibPSt0QrGlInd6tGIuiPM7PH2Zrh9I/LhppgYzKDXb1Q9hZL4m
         xv/Mun2VVq2wJHtRxAIo9oAn1d02UkGWBBerA=
Received: by 10.204.131.198 with SMTP id y6mr314444bks.4.1274467527281; Fri, 
	21 May 2010 11:45:27 -0700 (PDT)
Received: by 10.204.76.68 with HTTP; Fri, 21 May 2010 11:45:27 -0700 (PDT)
In-Reply-To: <AANLkTimIxtmaUNxp-LNy_ui5__BEBetcjTYE17ygIXD2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147493>

On Fri, May 21, 2010 at 5:58 PM, Catalin Marinas
<catalin.marinas@gmail.com> wrote:
> OK. As I said, I don't have =A0a problem with the patch. Maybe you co=
uld
> mention in the help that it's usually meant for tools like Emacs,
> otherwise people would wonder how to use it from the command line but
> as it is, the patch looks fine.

Here's an updated patch. The only difference to the previous patch is
in the help text.

Note that it doesn't handle incorrect SHA1 sums very well.
In fact they often end up causing EPIPE as 'git commit-tree' exits
before all data has been written to it.

=46rom a brief glance I cannot find any previous code that verifies the
correctness of a SHA1.
Any pointers to how I would add this would be welcome.
Would a new flag to Repository.get_tree() that makes it verify the
correctness be appropriate?
Or a new method in Repository?

- Gustav

----

Also fix capitalization in edit's short description.

Signed-off-by: Gustav H=E5llberg <gustav@gmail.com>
---
 stgit/commands/edit.py |   22 +++++++++++++++++++---
 t/t3300-edit.sh        |   15 +++++++++++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/stgit/commands/edit.py b/stgit/commands/edit.py
index f3f731f..a863611 100644
--- a/stgit/commands/edit.py
+++ b/stgit/commands/edit.py
@@ -24,7 +24,7 @@ from stgit.commands import common
 from stgit.lib import git as gitlib, transaction, edit
 from stgit.out import *

-help =3D 'edit a patch description or diff'
+help =3D 'Edit a patch description or diff'
 kind =3D 'patch'
 usage =3D ['[options] [--] [<patch>]']
 description =3D """
@@ -52,7 +52,14 @@ invoked even if such command-line options are given.=
)

 If the patch diff is edited but does not apply, no changes are made to
 the patch at all. The edited patch is saved to a file which you can
-feed to "stg edit --file", once you have made sure it does apply."""
+feed to "stg edit --file", once you have made sure it does apply.
+
+With --set-tree you set the git tree of the patch to the specified
+SHA1, without changing the tree of any other patches. When used on the
+top patch, the index and work tree will be updated to match the tree.
+This low-level option is primarily meant to be used by tools built on
+top of stgit, such as the Emacs mode. See also the --set-tree flag of
+stg push."""

 args =3D [argparse.applied_patches, argparse.unapplied_patches,
         argparse.hidden_patches]
@@ -61,6 +68,9 @@ options =3D [
         short =3D 'Edit the patch diff'),
     opt('-e', '--edit', action =3D 'store_true',
         short =3D 'Invoke interactive editor'),
+    opt('-t', '--set-tree', action =3D 'store',
+        metavar =3D 'SHA1',
+        short =3D 'Set the git tree of the patch to SHA1'),
     ] + (argparse.sign_options() +
          argparse.message_options(save_template =3D True) +
          argparse.author_options() + argparse.diff_opts_option())
@@ -86,6 +96,9 @@ def func(parser, options, args):

     cd =3D orig_cd =3D stack.patches.get(patchname).commit.data

+    if options.set_tree:
+        cd =3D cd.set_tree(stack.repository.get_tree(options.set_tree)=
)
+
     cd, failed_diff =3D edit.auto_edit_patch(
         stack.repository, cd, msg =3D options.message, contains_diff =3D=
 True,
         author =3D options.author, committer =3D lambda p: p,
@@ -128,7 +141,10 @@ def func(parser, options, args):
     trans.patches[patchname] =3D stack.repository.commit(cd)
     try:
         for pn in popped:
-            trans.push_patch(pn, iw, allow_interactive =3D True)
+            if options.set_tree:
+                trans.push_tree(pn)
+            else:
+                trans.push_patch(pn, iw, allow_interactive =3D True)
     except transaction.TransactionHalted:
         pass
     try:
diff --git a/t/t3300-edit.sh b/t/t3300-edit.sh
index 7003a27..078d4c3 100755
--- a/t/t3300-edit.sh
+++ b/t/t3300-edit.sh
@@ -212,4 +212,19 @@ test_expect_failure 'Fail to set invalid author da=
te' '
     test "$(date HEAD)" =3D "2013-01-28 22:30:00 -0300"
 '

+test_expect_success 'Set patch tree SHA1' '
+    p2tree=3D$(git log -1 --pretty=3Dformat:%T $(stg id p2)) &&
+    p4tree=3D$(git log -1 --pretty=3Dformat:%T $(stg id p4)) &&
+    stg edit --set-tree $p4tree &&
+    test $(git write-tree) =3D $p4tree &&
+    grep "^333zz$" foo &&
+    stg pop &&
+    stg edit --set-tree $p2tree p2 &&
+    stg push --set-tree &&
+    test $(git write-tree) =3D $p2tree &&
+    grep "^333$" foo &&
+    stg edit --set-tree $p2tree p1 &&
+    test "$(echo $(stg series --empty --all))" =3D "+ p1 0> p2 - p3 ! =
p4"
+'
+
 test_done
--=20
1.7.0.4
