From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 17/19] transport-helper: export is no longer always the last command
Date: Wed,  8 Jun 2011 20:48:48 +0200
Message-ID: <1307558930-16074-18-git-send-email-srabbelier@gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>, "Jeff King" <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:50:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNpN-00087c-SL
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076Ab1FHSt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:49:57 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49219 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab1FHStx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:49:53 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so282606ewy.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 11:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=QlOzXyJydm6o50vw/YxBrNL8orMCa4nipVIHnBiBKSA=;
        b=kCEYsOLsps0BZuvK59O/7EQorTzJaAV69yD4bysgOWeHUdyQBWL4FshlloogpJcc2M
         Ox8HX4wAVOYUYSX7E6mSAbcZRYKNDanWImZSgG0b/WYlpW31f3LptNiu5Av6rkshvAFG
         B+7S2En4H4JrDIJg1ZkGC0ECpa5kiRp0HDGg8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LrzryO0x9Qpc+5evZMfEgieZ1A0OOLN17LEOdou9yG+GuIOhnjxWyTIx0Mj3WV8WHP
         K+MQ985i7rUgaUWoXyDm1Zdjhf7FD2sCWtdgEw3BORWMv62WcfJIubmWFkvZ1e4/UwN1
         B3gBO0qsbt+oIf6bFgP/YOp2zWdrVo3bZUrz4=
Received: by 10.213.106.193 with SMTP id y1mr2159509ebo.22.1307558992457;
        Wed, 08 Jun 2011 11:49:52 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id b1sm729674eeg.19.2011.06.08.11.49.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 11:49:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175436>

Now that the remote helper protocol uses the new done command in its
fast-import streams, export no longer needs to be the last command in
the stream.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged from my original series, but with commit message updated
  after review.

 transport-helper.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index c089928..f78b670 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -762,7 +762,6 @@ static int push_refs_with_export(struct transport *transport,
 			 export_marks, import_marks, &revlist_args))
 		die("Couldn't run fast-export");
 
-	data->no_disconnect_req = 1;
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
 	push_update_refs_status(data, remote_refs);
-- 
1.7.5.1.292.g728120
