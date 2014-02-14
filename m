From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: Re: Bug: Problem with CRLF line ending in git-diff with coloring
Date: Fri, 14 Feb 2014 22:17:13 +0100
Message-ID: <20140214211712.GJ7560@pille.home>
References: <20140209110155.GB16189@scotty.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 14 22:17:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEQ8b-0007rY-W4
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 22:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673AbaBNVRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 16:17:30 -0500
Received: from moutng.kundenserver.de ([212.227.17.10]:63985 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158AbaBNVR3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Feb 2014 16:17:29 -0500
Received: from pille.home (port-92-205-19-133.dynamic.qsc.de [92.205.19.133])
	by mrelayeu.kundenserver.de (node=mreue104) with ESMTP (Nemesis)
	id 0MOiCE-1W8Nic3kUo-0065nO; Fri, 14 Feb 2014 22:17:17 +0100
Received: from pille.home (localhost [127.0.0.1])
	by pille.home (8.14.4/8.14.4/Debian-4) with ESMTP id s1ELHEVI000952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2014 22:17:15 +0100
Received: (from hs@localhost)
	by pille.home (8.14.4/8.14.4/Submit) id s1ELHDxL000951;
	Fri, 14 Feb 2014 22:17:13 +0100
X-Authentication-Warning: pille.home: hs set sender to stefan.hahn@s-hahn.de using -f
Content-Disposition: inline
In-Reply-To: <20140209110155.GB16189@scotty.home>
X-Mailer: Mutt http://www.mutt.org/
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:yENCAVXdb7eq0T3bNz7QiXbmqWrCxWUj7HEaCllFSMw
 RmIPh3aGR+ptazTzHyNJ25zyywppvxejHMI5DLz8pYhlvj0i+H
 84jf9N6ad3CMS5/Drm9QcjhAoZ0LT7XytFh+wMVj2kknXRCqu5
 +bCJnPLaT/IijdyXdr5JBd6TUFflgd6SNEjpctboLVsrsiI0JO
 mbwYCBrcrUoc24U8Rl+BMhT9QZrYxrZJ+iJDUXlSXmXU/uY4FC
 01/8PZtrutYAJJBWbptdoAy+JC7bFCTOrf6vd4CfD3GjAyrTWa
 NJv/m+JNpILO2SwUm4UJU2SMhxcAmkEn57l1x5cX5F93uMp5Qq
 AOhAmRGD9gAKuALZR7XQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242146>

Mail von Stefan-W. Hahn, Sun, 09 Feb 2014 at 12:01:55 +0100:

Good afternoon,

I updated the test a little bit. Test 3 and 7 are going wrong.
Both tests have a CRLF line ending in the changed line.

I you redirect the output of the test to a file you see the main
problem:

,----
| -[32m+[m[32mZeile 22[m[32m
[m
| +[32m+[m[32mZeile 22[m[41m
[m
`----

> It's the right solution. IOW, you should place something like this in
> your .gitattributes:
>  *.html whitespace=cr-at-eol

Sorry, but this is not possible, because I have files of both sorts (mainly
C/C++) files in my repository and cannot change the files as I wish.

Second try, the mail was blocked because of the attachment blocked the mail,
so not as attachment.

,----
| Date: Fri, 14 Feb 2014 11:50:37 -0500
| From: Administrator <scanmail@arrisi.com>
| To: stefan.hahn@s-hahn.de
| Subject: [MailServer Notification]Attachment Blocking Notification
| From prvs=81222a4311=scanmail@arrisi.com  Fri Feb 14 22:03:58 2014
| X-Mailer: Microsoft CDO for Windows 2000
| 
| The t4060-diff-eol.sh has been blocked since it violated the Microsoft
| Exchange attachment policy and Replace with text/file has been taken on
| 2/14/2014 11:49:56 AM.
| Please zip the attachment and send it again. If you have any questions,
| please contact IT. Thank you
| 
| Message details:
| Server: ATLOWA1
| Sender: stefan.hahn@s-hahn.de;
| Recipient: git@vger.kernel.org;
| Subject: Re: Bug: Problem with CRLF line ending in git-diff with coloring
| Attachment name: t4060-diff-eol.sh
| ~
`----


With kind regards,
Stefan

#!/bin/sh
#
# Copyright (c) 2014 Stefan-W. Hahn
#

test_description='Test coloring of diff with CRLF line ending.

'
. ./test-lib.sh

get_color ()
{
	git config --get-color "$1"
}

test_expect_success setup '
        git config color.diff.plain black &&
        git config color.diff.meta blue &&
        git config color.diff.frag yellow &&
        git config color.diff.func normal &&
        git config color.diff.old red &&
        git config color.diff.new green &&
        git config color.diff.commit normal &&
	c_reset=$(git config --get-color no.such.color reset) &&
	c_plain=$(get_color color.diff.plain) &&
	c_meta=$(get_color color.diff.meta) &&
	c_frag=$(get_color color.diff.frag) &&
	c_func=$(get_color color.diff.func) &&
	c_old=$(get_color color.diff.old) &&
	c_new=$(get_color color.diff.new) &&
	c_commit=$(get_color color.diff.commit) &&
	c_whitespace=$(get_color color.diff.whitespace)
'

# Test cases
# - DOS line ending
#   - change one line
#   - change one line ending to UNIX
# - UNIX line ending
#   - change one line (trivial not tested here)
#   - change one line ending to DOS

tr 'Q' '\015' << EOF > x
Zeile 1Q
Zeile 2Q
Zeile 3Q
EOF

git update-index --add x

tr 'Q' '\015' << EOF > x
Zeile 1Q
Zeile 22Q
Zeile 3Q
EOF

tr 'Q' '\015' << EOF > expect
diff --git a/x b/x
index 3411cc1..68a4b2c 100644
--- a/x
+++ b/x
@@ -1,3 +1,3 @@
 Zeile 1Q
-Zeile 2Q
+Zeile 22Q
 Zeile 3Q
EOF

tr 'Q' '\015' << EOF > expect_color
${c_meta}diff --git a/x b/x${c_reset}
${c_meta}index 3411cc1..68a4b2c 100644${c_reset}
${c_meta}--- a/x${c_reset}
${c_meta}+++ b/x${c_reset}
${c_frag}@@ -1,3 +1,3 @@${c_reset}
${c_plain} Zeile 1${c_reset}Q
${c_old}-Zeile 2${c_reset}Q
${c_new}+${c_reset}${c_new}Zeile 22${c_reset}${c_new}Q${c_reset}
${c_plain} Zeile 3${c_reset}Q
EOF

git -c color.diff=false diff > out
test_expect_success "diff files: change line in DOS file without color" '
        test_cmp expect out'

git -c color.diff=always diff > out
test_expect_success "diff files: change line in DOS file with color" '
        test_cmp expect_color out'


tr 'Q' '\015' << EOF > x
Zeile 1Q
Zeile 2Q
Zeile 3Q
EOF

git update-index --add x

tr 'Q' '\015' << EOF > x
Zeile 1Q
Zeile 2
Zeile 3Q
EOF

tr 'Q' '\015' << EOF > expect
diff --git a/x b/x
index 3411cc1..c040c67 100644
--- a/x
+++ b/x
@@ -1,3 +1,3 @@
 Zeile 1Q
-Zeile 2Q
+Zeile 2
 Zeile 3Q
EOF

tr 'Q' '\015' << EOF > expect_color
${c_meta}diff --git a/x b/x${c_reset}
${c_meta}index 3411cc1..c040c67 100644${c_reset}
${c_meta}--- a/x${c_reset}
${c_meta}+++ b/x${c_reset}
${c_frag}@@ -1,3 +1,3 @@${c_reset}
${c_plain} Zeile 1${c_reset}Q
${c_old}-Zeile 2${c_reset}Q
${c_new}+${c_reset}${c_new}Zeile 2${c_reset}
${c_plain} Zeile 3${c_reset}Q
EOF

git -c color.diff=false diff > out
test_expect_success "diff files: change line ending in DOS file to LF ending without color" '
        test_cmp expect out'

git -c color.diff=always diff > out
test_expect_success "diff files: change line ending in DOS file to LF ending with color" '
        test_cmp expect_color out'

tr 'Q' '\015' << EOF > x
Zeile 1
Zeile 2
Zeile 3
EOF

git update-index --add x

tr 'Q' '\015' << EOF > x
Zeile 1
Zeile 2Q
Zeile 3
EOF

tr 'Q' '\015' << EOF > expect
diff --git a/x b/x
index a385875..63416d7 100644
--- a/x
+++ b/x
@@ -1,3 +1,3 @@
 Zeile 1
-Zeile 2
+Zeile 2Q
 Zeile 3
EOF

tr 'Q' '\015' << EOF > expect_color
${c_meta}diff --git a/x b/x${c_reset}
${c_meta}index a385875..63416d7 100644${c_reset}
${c_meta}--- a/x${c_reset}
${c_meta}+++ b/x${c_reset}
${c_frag}@@ -1,3 +1,3 @@${c_reset}
${c_plain} Zeile 1${c_reset}
${c_old}-Zeile 2${c_reset}
${c_new}+${c_reset}${c_new}Zeile 2${c_reset}${c_new}Q${c_reset}
${c_plain} Zeile 3${c_reset}
EOF

git -c color.diff=false diff > out
test_expect_success "diff files: change line ending in UNIX file to CRLF ending without color" '
        test_cmp expect out'

git -c color.diff=always diff > out
test_expect_success "diff files: change line ending in UNIX file to CRLF ending with color" '
        test_cmp expect_color out'

test_done


-- 
Stefan-W. Hahn                          It is easy to make things.
                                        It is hard to make things simple.
