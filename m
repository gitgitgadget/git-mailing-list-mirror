From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 14/24] Show usage string for 'git rev-parse -h'
Date: Mon,  9 Nov 2009 09:04:54 -0600
Message-ID: <1257779104-23884-14-git-send-email-jrnieder@gmail.com>
References: <20091109150235.GA23871@progeny.tock>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:56:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7VfG-0002nn-M5
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:56:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756045AbZKIO4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 09:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755749AbZKIOze
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:55:34 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:44620 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755707AbZKIOzb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 09:55:31 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3179619ewy.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pb4nvHOOYf2V3VocIFFnK+sXg5+mf3gQUKimNnhee7o=;
        b=xw04uiLVKUYBj2RV31dWxfAlcNF7giQOCRZGekjUUDB0GFoewE/o4a4AjX/3SrUhmZ
         qtPehY05SsdjtEoG62cdZI3ldJGWJDgiJ+DwaweQMO0/RTkjXbBmIWcsIP75wkEuscxs
         gpJcHTJojlIOe9m3xGF9u8phngxVzgAku3eVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oQb1A7toec//XTESu7lkSYPbQqCXi1asAB0Uks4fkQnZWSb5v/BaW7FdZNACSfUJBr
         rvbSvDAaTmUU/V6pmhgQLAKPTd1FltmiDsK/9fW0MK2inMmRsU+l7S/EFTc+h8tr+t9j
         gCr0wg69ItP6jHwwNqoldlnIh1pNXLIp4cKns=
Received: by 10.216.85.138 with SMTP id u10mr2762465wee.185.1257778536754;
        Mon, 09 Nov 2009 06:55:36 -0800 (PST)
Received: from localhost.localdomain (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p37sm8922607gvf.9.2009.11.09.06.55.34
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:55:35 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <20091109150235.GA23871@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132475>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin-rev-parse.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 45bead6..24ee8b3 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -426,6 +426,13 @@ static void die_no_single_rev(int quiet)
 		die("Needed a single revision");
 }
 
+static const char builtin_rev_parse_usage[] =
+"git rev-parse --parseopt [options] -- [<args>...]\n"
+"   or: git rev-parse --sq-quote [<arg>...]\n"
+"   or: git rev-parse [options] [<arg>...]\n"
+"\n"
+"Run \"git rev-parse --parseopt -h\" for more information on the first usage.";
+
 int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 {
 	int i, as_is = 0, verify = 0, quiet = 0, revs_count = 0, type = 0;
@@ -438,6 +445,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 	if (argc > 1 && !strcmp("--sq-quote", argv[1]))
 		return cmd_sq_quote(argc - 2, argv + 2);
 
+	if (argc > 1 && !strcmp("-h", argv[1]))
+		usage(builtin_rev_parse_usage);
+
 	prefix = setup_git_directory();
 	git_config(git_default_config, NULL);
 	for (i = 1; i < argc; i++) {
-- 
1.6.5.2
