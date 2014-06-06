From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 04/40] refs.c: allow passing NULL to ref_transaction_free
Date: Fri,  6 Jun 2014 15:28:42 -0700
Message-ID: <1402093758-3162-5-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:38:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2m4-0006nC-NR
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbaFFWiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:38:05 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:36887 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbaFFWiD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:38:03 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so744285obc.2
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jp2w1MJ14tmrXh4Wm2+bIOezYJUzIjOeuaL5+W1SEx0=;
        b=jm7+bvNO8ZphN07WWnlh54MGGaxze99wvspdqFhp14dsoPwTgQvOMETw6fJyoPClj+
         mSd/mW5skmm60Eugwkw6otZcKtW3Le7+k/FRtzI0Ea/i1ZnLtWeyHwtKOQtvMh6o7wgN
         +h1SPKB1PDtLcKcskBOpvZt1+Oqjk+jG920kCeX8mORRMLs2xIwIV4GhG0q9Qs+LQx2w
         bL7BUsWYMxwT+xEODydjdRsx/R+b+/GkGPW+UuPaNuM36ICQ4wSxJlDR3D9h4Qupo6/l
         IlMeK4obITHjhGAlh/Xn7PbXYSuix9DWx6b2nH3yZ3uM8WUaj+iHTcwhO3aMSueT9zm1
         lr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jp2w1MJ14tmrXh4Wm2+bIOezYJUzIjOeuaL5+W1SEx0=;
        b=IyYS6nqPUPFo0nP0rUni9CBQJcgC1Rl3sHA5DCgsnerK8NGQgsy2lou/i9VxX9ZaqU
         Ozje2qTULgxd6JhxYcTfKeWUZgrFVJiFQ5n0XiuKdpgPVceoP3DayYFa3yGBBIKnhdk4
         TvqIdSJCtbbsybiChDAgkuJrfBG7QzgkNOuCmVdw6FWmOZpA9wGl0/uSx/E8OHenqE3Z
         /nOtewCkSzaOK1tLgo3PfcOnMuhRZhW2SFH3878rU4zU1db+oz00B7ac0LMIWXUGw0Ei
         zXFno1gq5Ynyn66dITWqnYB3O7umOzfvydVKMQBHgV5hk2MOo3zAasIMVVDCKEIDpdrT
         URvw==
X-Gm-Message-State: ALoCoQl8EFnd+Ro7pvaUQPoWRUzAv0+iMwS5SLgmzrAgdNbOjBojoWaeDcebjJkdKpnymXAw/h3Q
X-Received: by 10.182.104.161 with SMTP id gf1mr4563416obb.45.1402094282871;
        Fri, 06 Jun 2014 15:38:02 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id xn6si753229vdc.2.2014.06.06.15.38.02
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:38:02 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6C33631C621;
	Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1AF75E0878; Fri,  6 Jun 2014 15:29:20 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251014>

Allow ref_transaction_free(NULL) as a no-op. This makes ref_transaction_free
easier to use and more similar to plain 'free'.

In particular, it lets us rollback unconditionally as part of cleanup code
after setting 'transaction = NULL' if a transaction has been committed or
rolled back already.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/refs.c b/refs.c
index a767ef6..0faed29 100644
--- a/refs.c
+++ b/refs.c
@@ -3312,6 +3312,9 @@ void ref_transaction_free(struct ref_transaction *transaction)
 {
 	int i;
 
+	if (!transaction)
+		return;
+
 	for (i = 0; i < transaction->nr; i++)
 		free(transaction->updates[i]);
 
-- 
2.0.0.582.ge25c160
