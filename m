From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] commit: reword --author error message
Date: Thu, 15 Jan 2015 15:23:08 +0100
Message-ID: <84cf10a22858275d6e213311c93df7f6a5408f60.1421331608.git.git@drmicha.warpmail.net>
References: <54B7CCCD.1070708@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>,
	Gunnar Wagner <gunnar.wagner@irisgermanica.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 15:23:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBlKN-0002Kw-TI
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 15:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613AbbAOOXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 09:23:11 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56681 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754478AbbAOOXK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2015 09:23:10 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 3271520B4A
	for <git@vger.kernel.org>; Thu, 15 Jan 2015 09:23:10 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 15 Jan 2015 09:23:10 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=lE4n+XciaLB+RK
	Og0wJZ7Fui42I=; b=u3gEy8+HlKuhN9Ne5+b4dj7RyWsqOQUrmgIKcUf0utuvhc
	JWQNG8UtOU7/cAX1cmxjenlNgmDQhX8iAIrFuKB5NN1gtDq8yJPWwg/eqyUugLlJ
	MHzan+zC43YnnphmceHcNWmE6UNd2euFbhEGhoqfl8jdYJYAWkWEF+VHceTcs=
X-Sasl-enc: yWXu3NyYXR3f/JtChH1Vrendmdj9F5p31fJLn8Ag3itz 1421331789
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id BE8E4C00012;
	Thu, 15 Jan 2015 09:23:09 -0500 (EST)
X-Mailer: git-send-email 2.3.0.rc0.202.g6f441c7
In-Reply-To: <54B7CCCD.1070708@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262480>

If an --author argument is specified but does not contain a '>' then git tries
to find the argument within the exiting authors; and gives the error
message "No existing author found with '%s'" if there is no match.

This is confusing for users who try to specify a valid complete author
name.

Rename the error message to make it clearer that the failure has two
reasons in this case:
"Bad --author parameter '%s': neither completely wellformed nor part of
an existing one"

(This codepath is touched only when we know already that the argument
cannot be a completely wellformed author ident.)

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 7d90c35..851e2c5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1056,7 +1056,7 @@ static const char *find_author_by_nickname(const char *name)
 		clear_mailmap(&mailmap);
 		return strbuf_detach(&buf, NULL);
 	}
-	die(_("No existing author found with '%s'"), name);
+	die(_("Bad --author parameter '%s': neither completely wellformed nor part of an existing one"), name);
 }
 
 
-- 
2.3.0.rc0.202.g6f441c7
