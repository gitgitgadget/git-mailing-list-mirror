From: Greg Price <price@MIT.EDU>
Subject: [PATCH 2/2] describe: Exclude --all --match=PATTERN
Date: Mon, 25 Feb 2013 00:31:52 -0500
Message-ID: <20130225053152.GI5688@biohazard-cafe.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 06:37:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9qka-0000Jo-9F
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 06:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861Ab3BYFg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 00:36:56 -0500
Received: from DMZ-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.37]:51273 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750759Ab3BYFgz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2013 00:36:55 -0500
X-AuditID: 12074425-b7fec6d000007584-2b-512af74a1133
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	by dmz-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 90.74.30084.A47FA215; Mon, 25 Feb 2013 00:31:54 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH-1.MIT.EDU [18.9.28.11])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id r1P5VsGQ025948;
	Mon, 25 Feb 2013 00:31:54 -0500
Received: from localhost (BIOHAZARD-CAFE.MIT.EDU [18.9.64.18])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id r1P5Vrc4026822;
	Mon, 25 Feb 2013 00:31:53 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixCmqrOv1XSvQoGm/vEXXlW4mi4beK8wO
	TB4XLyl7fN4kF8AUxWWTkpqTWZZapG+XwJVxvX0Ca8ES3oozj9czNjC+5Opi5OSQEDCROPK8
	nxnCFpO4cG89WxcjF4eQwD5GiRt35jJBOBsZJVZ8+MsI4XxmlOjs62ACaWERUJXY9L2ZFcRm
	E1CQ+DF/HdgoEQFxibfHZ7KD2MwCahLtm6aA1QgL2EjcXfYLKM7BwStgJbHhfyRImFdAUOLk
	zCcsEOVaEjf+vWQCKWEWkJZY/o8DJCwqoCJxbX872wRG/llIOmYh6ZiF0LGAkXkVo2xKbpVu
	bmJmTnFqsm5xcmJeXmqRroVebmaJXmpK6SZGUCCyu6juYJxwSOkQowAHoxIPr8ZyrUAh1sSy
	4srcQ4ySHExKory3vwKF+JLyUyozEosz4otKc1KLDzFKcDArifBqhgLleFMSK6tSi/JhUtIc
	LErivDdSbvoLCaQnlqRmp6YWpBbBZGU4OJQkeOd/A2oULEpNT61Iy8wpQUgzcXCCDOcBGj4F
	pIa3uCAxtzgzHSJ/ilFRSpw3GCQhAJLIKM2D64UlileM4kCvCPMuAqniASYZuO5XQIOZgAY/
	1FEHGVySiJCSamBc8yb0srSZeulRJfYj7x7PUo/KFrt8/NXnFO/TzzKyrwg/irH8qHjoV670
	ScvHsuab6wxObznzR3ad+L4fk6MqF67Yy/bp0Lut+2RdOesrzG5yv1q96esU14ZZszYKMjeG
	7wuaxNHXpFEYvNgsKn9JyvLpObmXPxhF9rjtedhlo3+o2GPX8sA/SizFGYmGWsxF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217032>

Currently when --all is passed, the effect of --match is only
to demote non-matching tags to be treated like non-tags.  This
is puzzling behavior and not consistent with the documentation,
especially with the suggested usage of avoiding information leaks.
The combination of --all and --match is an oxymoron anyway, so
just forbid it.

Signed-off-by: Greg Price <price@mit.edu>
---
This should be applied after the preceding patch; I mistakenly omitted
the '1/2' in its subject line.

 Documentation/git-describe.txt | 3 ++-
 builtin/describe.c             | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 711040d..fd5d8f2 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -83,7 +83,8 @@ OPTIONS
 --match <pattern>::
 	Only consider tags matching the given `glob(7)` pattern,
 	excluding the "refs/tags/" prefix.  This can be used to avoid
-	leaking private tags from the repository.
+	leaking private tags from the repository.  This option is
+	incompatible with `--all`.
 
 --always::
 	Show uniquely abbreviated commit object as fallback.
diff --git a/builtin/describe.c b/builtin/describe.c
index 04c185b..90a72af 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -435,6 +435,9 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	if (longformat && abbrev == 0)
 		die(_("--long is incompatible with --abbrev=0"));
 
+	if (pattern && all)
+		die(_("--match is incompatible with --all"));
+
 	if (contains) {
 		const char **args = xmalloc((7 + argc) * sizeof(char *));
 		int i = 0;
-- 
1.7.11.3
