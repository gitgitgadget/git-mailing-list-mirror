From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/2] show-ref.c: Add missing call to git_config()
Date: Sat, 15 Jun 2013 21:29:12 +0100
Message-ID: <51BCCE98.3070201@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 15 22:32:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Unx9E-0007f1-M1
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 22:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605Ab3FOUcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 16:32:21 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:36591 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754517Ab3FOUcD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 16:32:03 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 122CB384081;
	Sat, 15 Jun 2013 21:32:02 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 7EA3638407C;
	Sat, 15 Jun 2013 21:32:01 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Sat, 15 Jun 2013 21:32:00 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227971>


At present, 'git show-ref' ignores any attempt to set config
variables (e.g. core.checkstat) from the command line using
the -c option to git. In order to enable such usage, add the
missing call to git_config() from cmd_show_ref().

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 builtin/show-ref.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 8d9b76a..95f5ca9 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -191,6 +191,8 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(show_ref_usage, show_ref_options);
 
+	git_config(git_default_config, NULL);
+
 	argc = parse_options(argc, argv, prefix, show_ref_options,
 			     show_ref_usage, PARSE_OPT_NO_INTERNAL_HELP);
 
-- 
1.8.3
