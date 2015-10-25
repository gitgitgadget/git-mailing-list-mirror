From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/2] Demonstrate rebase fails when the editor saves with
 CR/LF
Date: Sun, 25 Oct 2015 13:50:18 +0100 (CET)
Message-ID: <90f2eabb6968d9b2fe650d67662ec613a86011cb.1445777347.git.johannes.schindelin@gmx.de>
References: <cover.1445777347.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Chad Boles <chadbo@microsoft.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 13:50:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqKkr-0005Ae-8A
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 13:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbbJYMu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 08:50:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:49354 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074AbbJYMu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2015 08:50:28 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0Lb5Tp-1aEiLi1e0H-00kdCE;
 Sun, 25 Oct 2015 13:50:19 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1445777347.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:v0yy7wSLyaht1AMxHCRB3V9uzvydPpU5VSx21ZaXguldd9cbDEE
 AVM4He1AcE2fYs6umQ6ndMeE+d+1+5OUPC3QNsp5o85yTilHZZ1/iDmbSyvH1sqg8fdMo6n
 kj/Q74frDc/e/NSENDAsXTAwX5t3K5xUrDBqJSDxR85UTCc/FgvTWuyD0iGFceNfp+rP8V/
 YXMNGWVJb0pbNl+Zdt8/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YkB1pVlBzAs=:DzBZTI9FQ0tOT5JfPhgzmD
 +sVeskpjBRPwBc6heHplRG9n0LaXVWZ00wC00MUTG/EWOq9zQCK6YGHdWc15G33yEiQ0H2TYA
 JwMX78ofEJBJX3Lh4EON2nm+EXn/bcI0VADtYw5i7D57tEGsO4FfP4yHOjF1Kffxja+456eOR
 CDanojmuhZMFebxRiPUzzNOkexQ6+MbkCJ1AGFBXS6p7RatqT6KdHK345dBkGgSDxsOfoBtRB
 CEgRJXZJmqYPdCBvkYlvsCu6A1MCmX/L0HgiK01Sy3y+R4eW2jqYgpezRblkT5a2sWg7wWgf+
 pSPRoQc8tCgIGshEEnz+UVWdogvkaC8vEFHce7Kxdg0ae53q7yqPDGA+MBoMGhFC8uoSgtBlz
 ko9IjypNQ5DtCssJ/sphTLNvn891xdOkK+UTWhlYCNdXuiX96wIQB+T+veBRsjBaCW7TosInx
 cc+aQvG47QooV3segNjogdDG/HgmtUkroFANhduRZDFurkEK2tKpYY4zQldi16t9FzX9WHBTD
 I2+waHdNOdm0aghDlJTCVFPKnLqWVkfMIhYpAJbuKzvAYNaauZR5poULIJfjTA01H7K2VMyfa
 xpCratdVgaxJ91ciaiRdL6XLKU+wtDI5ZYZr6qh+rH+RIG8T7Q7KTKAoNkqgIH1MjTTx5uCP3
 oR6OEy+r5+Q+yp6gCJVttRaTiDjafoWJnl6P2oLFgu97z/JwXzdTs24UTW9DruhQvoPLTzhTz
 Y4XTxRtoQh8hpooajSQhox5wLbV3QpPHC67XZCGZV/0lksYRXs0f219Br5IDoc73aXOkdwQn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280143>

Based on a bug report by Chad Boles.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3404-rebase-interactive.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 3de0b1d..5dfa16a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1261,4 +1261,16 @@ test_expect_success 'static check of bad SHA-1' '
 	test E = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
+test_expect_failure 'editor saves as CR/LF' '
+	git checkout -b with-crlf &&
+	write_script add-crs.sh <<-\EOF &&
+	sed -e "s/\$/Q/" <"$1" | tr Q "" >"$1".new &&
+	mv -f "$1".new "$1"
+	EOF
+	(
+		test_set_editor "$(pwd)/add-crs.sh" &&
+		git rebase -i HEAD^
+	)
+'
+
 test_done
-- 
2.1.4
