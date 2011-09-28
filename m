From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH v3] Docs: git checkout --orphan: `root commit' and
                                                 `branch head'
Date: Wed, 28 Sep 2011 16:23:00 -0000
Message-ID: <e4f46b39e9ed4203bfab8a81e25eb600-mfwitten@gmail.com>
References: <1316960136073-6829212.post@n2.nabble.com>
            <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
            <7vaa9r2jii.fsf@alter.siamese.dyndns.org>
            <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
            <vpq39fi9gf5.fsf@bauges.imag.fr>
            <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
            <vpqsjni6kkk.fsf@bauges.imag.fr>
            <553B5FA1A43748B1ADD759572EADA6FF@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Philip Oakley <philipoakley@iee.org>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 18:40:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8xBa-0000dy-6l
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 18:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590Ab1I1Qkh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Sep 2011 12:40:37 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54683 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568Ab1I1Qkg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 12:40:36 -0400
Received: by fxe4 with SMTP id 4so748414fxe.19
        for <git@vger.kernel.org>; Wed, 28 Sep 2011 09:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=SDq5woyeyDwbBoA97a5kbCOnyu132xI9lC5Hli41Qxc=;
        b=qzr6XcK46pzRru2JKpN7vmpQfLfCSBPrOY6Zvut8ORQdB5gjvQmUedcCXmKfXAN9lS
         J+tNw9Lc4ssSUKwLtxGOdtaYyQ3kNPXl5JbzITpfLq/nteG4sW72OwMJ/bQYvj/G4uam
         OsIJcM1rPQCdEim4k0Bm/FEwHbCHjtQkQ63/Y=
Received: by 10.223.32.140 with SMTP id c12mr3071985fad.9.1317228033085;
        Wed, 28 Sep 2011 09:40:33 -0700 (PDT)
Received: from gmail.com ([93.115.241.2])
        by mx.google.com with ESMTPS id w14sm27909890fae.13.2011.09.28.09.40.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Sep 2011 09:40:32 -0700 (PDT)
In-Reply-To: <553B5FA1A43748B1ADD759572EADA6FF@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182342>

See:

  Re: Can a git changeset be created with no parent
  Carlos Mart=C3=ADn Nieto <cmn@elego.de>
  Message-ID: <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
  http://article.gmane.org/gmane.comp.version-control.git/182170

and:

  git help glossary

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-checkout.txt |   65 +++++++++++++++++++++++++++-----=
-------
 1 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index c0a96e6..0b6e528 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -125,29 +125,54 @@ explicitly give a name with '-b' in such a case.
 	below for details.
=20
---orphan::
-	Create a new 'orphan' branch, named <new_branch>, started from
-	<start_point> and switch to it.  The first commit made on this
-	new branch will have no parents and it will be the root of a new
-	history totally disconnected from all the other branches and
-	commits.
-+
-The index and the working tree are adjusted as if you had previously r=
un
-"git checkout <start_point>".  This allows you to start a new history
-that records a set of paths similar to <start_point> by easily running
-"git commit -a" to make the root commit.
-+
-This can be useful when you want to publish the tree from a commit
-without exposing its full history. You might want to do this to publis=
h
-an open source branch of a project whose current tree is "clean", but
-whose full history contains proprietary or otherwise encumbered bits o=
f
-code.
-+
-If you want to start a disconnected history that records a set of path=
s
-that is totally different from the one of <start_point>, then you shou=
ld
-clear the index and the working tree right after creating the orphan
-branch by running "git rm -rf ." from the top level of the working tre=
e.
-Afterwards you will be ready to prepare your new files, repopulating t=
he
-working tree, by copying them from elsewhere, extracting a tarball, et=
c.
+--orphan::
+	Tell git to turn the next commit you create into a root commit
+	(that is, a commit without any parent); creating the next commit
+	is similar to creating the first commit after running "git{nbsp}init"=
,
+	except that the new commit will be referenced by the branch head
+	<new_branch> rather than "master".
++
+Furthermore, the working tree and index are adjusted as if you ran
+"git{nbsp}checkout{nbsp}<start_point>"; thus, by just running
+"git{nbsp}commit", you can create a root commit with a tree that is
+exactly the same as the tree of <start_point>.
++
+Naturally, before creating the commit, you may manipulate the index
+in any way you want. For example, if you want to create a root commit
+with a tree that is totally different from the tree of <start_point>,
+then just clear the working tree and index first: From the top level
+of the working tree, run "git{nbsp}rm{nbsp}-rf{nbsp}.", and then
+prepare your new working tree and index as desired.
++
+There are two common uses for this option:
++
+--
+	Separate history::
+		Suppose that for convenience, you want to maintain
+		the website for your project in the same repository
+		as the project itself. In such a case, it may not
+		make much sense to interleave the history of the
+		website with the history of the project; you can use
+		the "--orphan" option in order to create these two
+		completely separate histories.
+
+	Hidden history::
+		Suppose you have a project that has proprietary
+		material that is never meant to be released to the
+		public, yet you now want to maintain an open source
+		history that may be published widely.
++
+In this case, it would not be enough just to remove the proprietary
+material from the working tree and then create a new commit, because
+the proprietary material would still be accessible through the new
+commit's ancestry; the proprietary history must be hidden from the new
+commit, and the "--orphan" option allows you to do so by ensuring that
+the new commit has no parent.
++
+However, removing proprietary material from ancestry is usually a task
+that is better performed by linkgit:git-filter-branch[1] and
+linkgit:git-rebase[1], especially when there are multiple commits that
+are already suitable for the open source history.
+--
=20
 -m::
 --merge::
--=20
1.7.6.409.ge7a85
