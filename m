From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 004/144] git-rebase--merge.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:09 -0700
Message-ID: <1395735989-3396-5-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:38:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMsV-0003f5-Vn
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbaCYIiY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:38:24 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:42569 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753618AbaCYI0k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:26:40 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so128257pdj.8
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=V+FMJ91cHVQ+cfL8BkZmvHQut0MNHyPWeZAnD1KduYo=;
        b=I7FsmzNKRVf6FeHauWii5tPLVQKGscv4HS+BvdIy8V21JhVAIiD9IzafT0iBEd50YZ
         KJO0f7DW2HMIFRwi8/I1FKR8t6AJJfYDK4UKww+8lu22xN/rgB2V+FHJdW7y5mxE5yZ7
         1e4zweFm1ztT3Q8ajwUuvfurEMJoi4Vd95riX6Q9yFffWtYQV+ye8NrKXEjsJSy9YRwv
         g/UQa7ErRsDARlgxDG4l0HepKX+AR+hgANSdMCoCuxgNthgd33dCxr0OhTTZlvnVatJR
         tWKmpXwG99pVmw/jjPrPw0UM8TKlgRUgPbIaZOJru3QgExnzyIB83ehaHkuYgdrMi9rR
         X2vQ==
X-Received: by 10.68.178.131 with SMTP id cy3mr9243188pbc.146.1395736000058;
        Tue, 25 Mar 2014 01:26:40 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.26.39
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:26:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245013>

The Git CodingGuidelines prefer the $( ... ) construct for command
substitution instead of using the back-quotes, or grave accents (`..`).

The backquoted form is the historical method for command substitution,
and is supported by POSIX. However,all but the simplest uses become
complicated quickly. In particular,embedded command substitutions
and/or the use of double quotes require careful escaping with the backs=
lash
character. Because of this the POSIX shell adopted the $(=E2=80=A6) fea=
ture from
the Korn shell.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 git-rebase--merge.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index 5381857..dc064f8 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -24,7 +24,7 @@ continue_merge () {
 		die "$resolvemsg"
 	fi
=20
-	cmt=3D`cat "$state_dir/current"`
+	cmt=3D$(cat "$state_dir/current")
 	if ! git diff-index --quiet --ignore-submodules HEAD --
 	then
 		if ! git commit ${gpg_sign_opt:+"$gpg_sign_opt"} --no-verify -C "$cm=
t"
@@ -132,7 +132,7 @@ echo "$onto_name" > "$state_dir/onto_name"
 write_basic_state
=20
 msgnum=3D0
-for cmt in `git rev-list --reverse --no-merges "$revisions"`
+for cmt in $(git rev-list --reverse --no-merges "$revisions")
 do
 	msgnum=3D$(($msgnum + 1))
 	echo "$cmt" > "$state_dir/cmt.$msgnum"
--=20
1.7.10.4
