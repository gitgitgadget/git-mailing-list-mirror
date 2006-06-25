From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] whatchanged: Default to DIFF_FORMAT_RAW
Date: Sun, 25 Jun 2006 14:11:02 +0300
Message-ID: <20060625141102.b68a7cae.tihirvon@gmail.com>
References: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
	<20060624202153.1001a66c.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 13:11:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuSWF-0003vI-1f
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 13:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWFYLLH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 07:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWFYLLH
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 07:11:07 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:41425 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932331AbWFYLLG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jun 2006 07:11:06 -0400
Received: by nf-out-0910.google.com with SMTP id m19so460126nfc
        for <git@vger.kernel.org>; Sun, 25 Jun 2006 04:11:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=nVGBFTs5E414+Q/C2MW0GAgRkpWY+qR4480DhNK2fmv5NfoNcT2AdSRvLdGrpfZn2btszr0JOkBPfJcYrTe/ABFzSs/a5/9ukDDYN0vkRjMNIltwLoZC5NVPmUB50hK67aPx26G89NtB2vCa7sWwTehoa8oqwyOAisgRXNx1eek=
Received: by 10.48.231.6 with SMTP id d6mr3980385nfh;
        Sun, 25 Jun 2006 04:11:04 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id d2sm1613336nfe.2006.06.25.04.11.04;
        Sun, 25 Jun 2006 04:11:04 -0700 (PDT)
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060624202153.1001a66c.tihirvon@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22612>


Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---
 builtin-log.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 5b3fadc..8a39770 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -28,6 +28,15 @@ static int cmd_log_wc(int argc, const ch
 			rev->always_show_header = 0;
 	}
 
+	if (!rev->diffopt.output_format && !rev->simplify_history) {
+		/* Ugly hack!
+		 *
+		 * rev->simplify_history == 0 -> whatchanged
+		 * Can't do this before setup_revisions()
+		 */
+		rev->diffopt.output_format = DIFF_FORMAT_RAW;
+	}
+
 	if (argc > 1)
 		die("unrecognized argument: %s", argv[1]);
 
-- 
1.4.1.rc1.g6e272-dirty
