From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v14 2/6] test-parse-options: print quiet as integer
Date: Tue, 12 Apr 2016 23:02:17 +0000
Message-ID: <010201540cb60955-e7575250-a84d-40a7-baea-d004b92579de-000000@eu-west-1.amazonses.com>
References: <010201540cb60832-9402a692-3caa-47a1-9e8e-ae5a1bc7eb2f-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 01:02:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq7KC-0002bS-PW
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 01:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbcDLXCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 19:02:21 -0400
Received: from a6-247.smtp-out.eu-west-1.amazonses.com ([54.240.6.247]:35714
	"EHLO a6-247.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934388AbcDLXCT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2016 19:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1460502137;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=crnN1BMPRfrkbJztH/WR8nHJR0jundxLXYoxjToUe4M=;
	b=InMmP55PpqU3mcMZb6BDTg9OlMZxHO3bGus8BOf4kSQ0knMkQl9wBhxa8RShcnAh
	nAwPnTQUu9MUHCO7wIEr/vpgkEqF7s/QNV19YrkDgUAkqcXNCEaHMludi5xdI4epnTj
	QM3342IBa0itu9jdZdgO88ZgH09pPUKB9waoywNw=
In-Reply-To: <010201540cb60832-9402a692-3caa-47a1-9e8e-ae5a1bc7eb2f-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.04.12-54.240.6.247
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291309>

We would want to see how multiple --quiet options affect the value of
the underlying variable (we may want "--quiet --quiet" to still be 1, or
we may want to see the value incremented to 2). Show the value as
integer to allow us to inspect it.

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 t/t0040-parse-options.sh | 26 +++++++++++++-------------
 test-parse-options.c     |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 477fcff..450da45 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -64,7 +64,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
@@ -164,7 +164,7 @@ timestamp: 0
 string: 123
 abbrev: 7
 verbose: 2
-quiet: no
+quiet: 0
 dry run: yes
 file: prefix/my.file
 EOF
@@ -184,7 +184,7 @@ timestamp: 0
 string: 321
 abbrev: 10
 verbose: 2
-quiet: no
+quiet: 0
 dry run: no
 file: prefix/fi.le
 EOF
@@ -212,7 +212,7 @@ timestamp: 0
 string: 123
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 arg 00: a1
@@ -235,7 +235,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
@@ -264,7 +264,7 @@ timestamp: 0
 string: 123
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
@@ -303,7 +303,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 arg 00: --quux
@@ -323,7 +323,7 @@ timestamp: 1
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: yes
+quiet: 1
 dry run: no
 file: (not set)
 arg 00: foo
@@ -345,7 +345,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
@@ -374,7 +374,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
@@ -399,7 +399,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
@@ -430,7 +430,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
@@ -449,7 +449,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
diff --git a/test-parse-options.c b/test-parse-options.c
index 2c8c8f1..86afa98 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -90,7 +90,7 @@ int main(int argc, char **argv)
 	printf("string: %s\n", string ? string : "(not set)");
 	printf("abbrev: %d\n", abbrev);
 	printf("verbose: %d\n", verbose);
-	printf("quiet: %s\n", quiet ? "yes" : "no");
+	printf("quiet: %d\n", quiet);
 	printf("dry run: %s\n", dry_run ? "yes" : "no");
 	printf("file: %s\n", file ? file : "(not set)");
 

--
https://github.com/git/git/pull/218
