From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Documentation: change -L:<regex> to -L:<funcname>
Date: Sun, 19 Apr 2015 19:29:55 +0200
Message-ID: <1429464595-11563-1-git-send-email-Matthieu.Moy@imag.fr>
References: <xmqqh9sepk20.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org, sunshine@sunshineco.com,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Apr 19 19:30:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yjt3T-0002Hl-Ig
	for gcvg-git-2@plane.gmane.org; Sun, 19 Apr 2015 19:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbbDSRap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2015 13:30:45 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36811 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751302AbbDSRao (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2015 13:30:44 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t3JHU36c029107
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 19 Apr 2015 19:30:03 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3JHU00I020713;
	Sun, 19 Apr 2015 19:30:00 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Yjt2e-0003EX-IN; Sun, 19 Apr 2015 19:30:00 +0200
X-Mailer: git-send-email 2.4.0.rc1.42.g9642cc6
In-Reply-To: <xmqqh9sepk20.fsf@gitster.dls.corp.google.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 19 Apr 2015 19:30:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3JHU36c029107
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1430069415.06432@TWdjVfq53MiNPIaqi+W4LA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267442>

The old wording was somehow implying that <start> and <end> were not
regular expressions. Also, the common case is to use a plain function
name here so <funcname> makes sense (the fact that it is a regular
expression is documented in line-range-format.txt).

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Junio C Hamano <gitster@pobox.com> writes:

> By adding :regex:file as a possibility, you are hinting that 'start'
> and 'end' are *not* regular expressions but numbers, but
>
>     $ git log -L'/^int main/,/^}/:git.c'
>
> is a perfectly fine way to specify start (i.e. the first line that
> matches '^int main') and end (i.e. the first line that matches '^}'
> after that).

OK, but the same argument applies to the documentation (where I
cut-and-pasted from actually). So I suggest this patch in addition
(I'd apply it right before the patch on the code).

> false impression to the other one, and use Eric's suggestion on top?
>
>     die("-L argument not 'start,end:file' or ':funcname:file': %s",
> 	item->string);
>
> With the matching update to tests, here is what I'll queue on top of
> this patch for now, but please send in objections and improvements.

Very good.

Let me know if you want me to resend the 2-patch series.

 Documentation/blame-options.txt     |  2 +-
 Documentation/git-log.txt           |  2 +-
 Documentation/gitk.txt              |  4 ++--
 Documentation/line-range-format.txt | 11 ++++++-----
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index b299b59..a09969b 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -10,7 +10,7 @@
 	Include additional statistics at the end of blame output.
 
 -L <start>,<end>::
--L :<regex>::
+-L :<funcname>::
 	Annotate only the given line range. May be specified multiple times.
 	Overlapping ranges are allowed.
 +
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 18bc716..f0ec283 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -62,7 +62,7 @@ produced by `--stat`, etc.
 	output by allowing them to allocate space in advance.
 
 -L <start>,<end>:<file>::
--L :<regex>:<file>::
+-L :<funcname>:<file>::
 	Trace the evolution of the line range given by "<start>,<end>"
 	(or the funcname regex <regex>) within the <file>.  You may
 	not give any pathspec limiters.  This is currently limited to
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 7ae50aa..d3b91ca 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -99,10 +99,10 @@ linkgit:git-rev-list[1] for a complete list.
 	detailed explanation.)
 
 -L<start>,<end>:<file>::
--L:<regex>:<file>::
+-L:<funcname>:<file>::
 
 	Trace the evolution of the line range given by "<start>,<end>"
-	(or the funcname regex <regex>) within the <file>.  You may
+	(or the funcname regex <funcname>) within the <file>.  You may
 	not give any pathspec limiters.  This is currently limited to
 	a walk starting from a single revision, i.e., you may only
 	give zero or one positive revision arguments.
diff --git a/Documentation/line-range-format.txt b/Documentation/line-range-format.txt
index d7f2603..829676f 100644
--- a/Documentation/line-range-format.txt
+++ b/Documentation/line-range-format.txt
@@ -22,8 +22,9 @@ This is only valid for <end> and will specify a number
 of lines before or after the line given by <start>.
 
 +
-If ``:<regex>'' is given in place of <start> and <end>, it denotes the range
-from the first funcname line that matches <regex>, up to the next
-funcname line. ``:<regex>'' searches from the end of the previous `-L` range,
-if any, otherwise from the start of file.
-``^:<regex>'' searches from the start of file.
+If ``:<funcname>'' is given in place of <start> and <end>, it is a
+regular expression that denotes the range from the first funcname line
+that matches <funcname>, up to the next funcname line. ``:<funcname>''
+searches from the end of the previous `-L` range, if any, otherwise
+from the start of file. ``^:<funcname>'' searches from the start of
+file.
-- 
2.4.0.rc1.42.g9642cc6
