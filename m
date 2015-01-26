From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2] commit: reword --author error message
Date: Mon, 26 Jan 2015 16:48:33 +0100
Message-ID: <7e2e1d1e7f4a25d84a6f7a1c0cb035221529f189.1422286879.git.git@drmicha.warpmail.net>
References: <xmqqfvba1p07.fsf@gitster.dls.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Philip Oakley <philipoakley@iee.org>,
	Gunnar Wagner <gunnar.wagner@irisgermanica.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 16:48:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFlu3-0008Ff-H4
	for gcvg-git-2@plane.gmane.org; Mon, 26 Jan 2015 16:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755955AbbAZPsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2015 10:48:36 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51769 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754790AbbAZPsf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jan 2015 10:48:35 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 8A23F20A7C
	for <git@vger.kernel.org>; Mon, 26 Jan 2015 10:48:34 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Mon, 26 Jan 2015 10:48:34 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=rNZJ519UWt+O5i
	zP2uyYPoJD6vQ=; b=OXrOh4XYzvh6P5pRO1uMqkqvvW9UvBAn95sCPhlw39QTP1
	S2qkPY3OOrhldfhNRb5EmIetYGG5n02jMiS7aFhJI84Wqnvu1o4FgBR5oaJVmWdZ
	UaxBmMNSZoYOLb2hl1zGH1rxs3N4Qbl/xpxi1E1GyGsEun+/C1/KdJUVBYhiE=
X-Sasl-enc: 6/cfk8f7SqezGBs+H0PX1FthVt5n1ywt+3i/GGLZsJRu 1422287314
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1D927C0001A;
	Mon, 26 Jan 2015 10:48:34 -0500 (EST)
X-Mailer: git-send-email 2.3.0.rc1.222.gae238f2
In-Reply-To: <xmqqfvba1p07.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263032>

If an --author argument is specified but does not contain a '>' then git tries
to find the argument within the existing authors; and gives the error
message "No existing author found with '%s'" if there is no match.

This is confusing for users who try to specify a valid complete author
name.

Rename the error message to make it clearer that the failure has two
reasons in this case.

(This codepath is touched only when we know already that the argument
cannot be a completely wellformed author ident.)

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
There's really not much by me in this patch any more...
Everyone on cc contributed - bikeshedding in its best, productive form!

BTW: How do you pull cc/msgid from the list into format-patch/send-email most effectively?
(granted that I move away from gmane/nntp, which is likely)

 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 7d90c35..240423b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1056,7 +1056,7 @@ static const char *find_author_by_nickname(const char *name)
 		clear_mailmap(&mailmap);
 		return strbuf_detach(&buf, NULL);
 	}
-	die(_("No existing author found with '%s'"), name);
+	die(_("--author '%s': neither 'Name <email>' nor a match for an existing author"), name);
 }
 
 
-- 
2.3.0.rc1.222.gae238f2
