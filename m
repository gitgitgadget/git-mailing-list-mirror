From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/2 v2] Document date formats accepted by parse_date()
Date: Thu,  3 Dec 2009 00:49:19 +0100
Message-ID: <465359e7bb6f00b622a1a5df5bc178eee019f4a2.1259797598.git.vmiklos@frugalware.org>
References: <7v638p9ebz.fsf@alter.siamese.dyndns.org>
Cc: Nanako Shiraishi <nanako3@lavabit.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 00:47:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFyv1-0006oQ-Hk
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 00:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755121AbZLBXrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 18:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754621AbZLBXrW
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 18:47:22 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:55985 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991AbZLBXrW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 18:47:22 -0500
Received: from vmobile.example.net (dsl5401C01C.pool.t-online.hu [84.1.192.28])
	by yugo.frugalware.org (Postfix) with ESMTPA id AF21F1A49F;
	Thu,  3 Dec 2009 00:47:27 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id BA0BC181FDB; Thu,  3 Dec 2009 00:49:19 +0100 (CET)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <7v638p9ebz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134420>

---

On Wed, Dec 02, 2009 at 02:54:40PM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> I agree with the "native->internal" part of the suggestion.

Changed.

> Also "test-date parse" seems to accept things like these:
>
>     '2009.04.07 20:21:22 -0000'
>     '04/07/2009 20:21:22 -0000'
>     '07.04.2009 20:21:22 -0000'

Ah OK, I just tried 2009.04.07 (without the time part) and thought it
was about approxidate() as well. I added them.

 Documentation/date-formats.txt    |   26 ++++++++++++++++++++++++++
 Documentation/git-commit-tree.txt |    1 +
 Documentation/git-commit.txt      |    2 ++
 3 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/date-formats.txt

diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
new file mode 100644
index 0000000..c000f08
--- /dev/null
+++ b/Documentation/date-formats.txt
@@ -0,0 +1,26 @@
+DATE FORMATS
+------------
+
+The GIT_AUTHOR_DATE, GIT_COMMITTER_DATE environment variables
+ifdef::git-commit[]
+and the `--date` option
+endif::git-commit[]
+support the following date formats:
+
+Git internal format::
+	It is `<unix timestamp> <timezone offset>`, where `<unix
+	timestamp>` is the number of seconds since the UNIX epoch.
+	`<timezone offset>` is a positive or negative offset from UTC.
+	For example CET (which is 2 hours ahead UTC) is `+0200`.
+
+RFC 2822::
+	The standard email format as described by RFC 2822, for example
+	`Thu, 07 Apr 2005 22:13:13 +0200`.
+
+ISO 8601::
+	Time and date specified by the ISO 8601 standard, for example
+	`2005-04-07T22:13:13`. The parser accepts a space instead of the
+	`T` character as well.
++
+NOTE: In addition, the date part is accepted in the following formats:
+`YYYY.MM.DD`, `MM/DD/YYYY` and `DD.MM.YYYY`.
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index b8834ba..4fec5d5 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -73,6 +73,7 @@ A commit comment is read from stdin. If a changelog
 entry is not provided via "<" redirection, 'git-commit-tree' will just wait
 for one to be entered and terminated with ^D.
 
+include::date-formats.txt[]
 
 Diagnostics
 -----------
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index cbbbeeb..17783b4 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -220,6 +220,8 @@ specified.
 	these files are also staged for the next commit on top
 	of what have been staged before.
 
+:git-commit: 1
+include::date-formats.txt[]
 
 EXAMPLES
 --------
-- 
1.6.5.2
