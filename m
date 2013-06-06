From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 9/9] cherry-pick: don't barf when there's nothing to do
Date: Thu,  6 Jun 2013 03:59:04 -0500
Message-ID: <1370509144-31974-10-git-send-email-felipe.contreras@gmail.com>
References: <1370509144-31974-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 06 11:01:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkW4a-0006NP-6n
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 11:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442Ab3FFJB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 05:01:26 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:36070 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932264Ab3FFJBY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 05:01:24 -0400
Received: by mail-oa0-f47.google.com with SMTP id m17so245239oag.6
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 02:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=IEq5MofEGJD4qVtozSmjXbIE3Af1y203tov9DjBrKFU=;
        b=vC8cBO5WaipLNJK1Adb+5hU+7x8Tj1kFIIaBJdEZXI39UjGUwiOUBwBkYKDhNzgm0z
         5QDH01WTGhM26brjS5hCoU8AP9/cyahjHs6eaFgnh7ORw4nO87MyRO7GrhKb4YjwOl8Z
         g/mZpn6DHMvJtCevl9THNR3chB/vRD1gNshvjNdFOx5iWu7jPf+Ts3AeffV0hVVVWaHx
         rHboP9jtxJwe09F128aAma3yvOQwzQTeJ+Lk4GC2mbCwWnAuflnoAgvd4993TydIEA4p
         kpK1niSwRZazi37KlnwgDzakCSgqDJp6RUPXpU5ILVorsWVNfLI2kZeaGUDrpxGQq+i3
         d9YA==
X-Received: by 10.60.131.104 with SMTP id ol8mr17197959oeb.104.1370509284293;
        Thu, 06 Jun 2013 02:01:24 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id l4sm11778990obh.7.2013.06.06.02.01.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Jun 2013 02:01:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370509144-31974-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226494>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sequencer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index dd9de49..c3a17f8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -754,8 +754,8 @@ static void prepare_revs(struct replay_opts *opts)
 	if (prepare_revision_walk(opts->revs))
 		die(_("revision walk setup failed"));
 
-	if (!opts->revs->commits)
-		die(_("empty commit set passed"));
+	if (!opts->revs->commits && !opts->quiet)
+		error(_("empty commit set passed"));
 }
 
 static void read_and_refresh_cache(struct replay_opts *opts)
-- 
1.8.3.698.g079b096
