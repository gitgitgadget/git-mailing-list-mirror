From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 043/144] t4013-diff-various.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:48 -0700
Message-ID: <1395735989-3396-44-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:35:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMpD-00085j-H6
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064AbaCYIeb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:34:31 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:45794 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787AbaCYI10 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:26 -0400
Received: by mail-pd0-f170.google.com with SMTP id v10so130371pde.29
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Jv9AzwNqgQp6j1P3CJfTfciW8FiM8Ua8hz/nxzht4BY=;
        b=zEk9KXB9XK+UdbP4TNafP7h61L3t7htDjX5ryZDSoh/9VurSmO1n80v1e8onw+yAIb
         oah0I3dWnyn6uuEH+n4faHEQb5pbsXVBlZM83UgKF1DVamOqKbq5+NZy/P1aqlpjEOJh
         vlkw59x5fAONqn/BwNuY8fMnjjZ58Xs4KBncKdnTt52P77F8e//ovhvLHuQ2sJHJd112
         B7/3jwJhmboqFOS032AKOfx/ZYRxObdyH+pZ6Ec8mOfKQyytRuvHdWLX+MVSPiKWVSzC
         uAlvGEDSHxSupmSGJwjT6JLbwxtzmXMyebRZajz/kKPd4O7WDwOwrTv8gdnCeJCaw056
         2DpA==
X-Received: by 10.68.235.6 with SMTP id ui6mr75314068pbc.45.1395736045933;
        Tue, 25 Mar 2014 01:27:25 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244989>

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
 t/t4013-diff-various.sh |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index e77c09c..805b055 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -107,14 +107,14 @@ test_expect_success setup '
 +*++ [initial] Initial
 EOF
=20
-V=3D`git version | sed -e 's/^git version //' -e 's/\./\\./g'`
+V=3D$(git version | sed -e 's/^git version //' -e 's/\./\\./g')
 while read cmd
 do
 	case "$cmd" in
 	'' | '#'*) continue ;;
 	esac
-	test=3D`echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g'`
-	pfx=3D`printf "%04d" $test_count`
+	test=3D$(echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g')
+	pfx=3D$(printf "%04d" $test_count)
 	expect=3D"$TEST_DIRECTORY/t4013/diff.$test"
 	actual=3D"$pfx-diff.$test"
=20
--=20
1.7.10.4
