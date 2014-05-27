From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 04/41] refs.c: allow passing NULL to ref_transaction_free
Date: Tue, 27 May 2014 13:25:23 -0700
Message-ID: <1401222360-21175-5-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:26:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNws-0001gi-O4
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109AbaE0U0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:26:09 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:49737 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbaE0U0E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:04 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so1921413obc.0
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=leuXpXso/iX91033KO+jAEFLWCXazZ8v+ti3RzM+D6c=;
        b=gSvlXlexE/rVL1rWxVx2vDNV5eqEMkfHYANELbrCCcEBjsIupDIkNYtApMbVssjnKo
         EO9Ba46+L8q192xNVIdvp6dsTRPgaVjW65tM9QCxtgzaMkjSzFC3MZen//lDa13hy0t9
         0fjCSxtRstpWV+y9S8yb9444NWbMrZAAgB/J7rJaA6i0EyrWq9CzYoKZ/iAX9OrOgiPk
         xIfaW/URNrbV8lBXv9rbgb46pJaLmB+lJzwJkfHRsgRL6HmVCk/f7raGn5yfr0Uxkgtz
         1eqzpeEdomB/gd++JEbZJhfHjOJfX40Y9flIJu4JFjWK4pjIWe9bJw/YhAdrwzFT25R2
         5A6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=leuXpXso/iX91033KO+jAEFLWCXazZ8v+ti3RzM+D6c=;
        b=FJ/aKEk17V42PPSxRnA0NknP8bvdYqTIldcINbGmvWIK6tCHKrf9pmkJJ+zS3s2N+R
         0MAbqyvAWkbdCQnNYRLiY38wyR6jNIWcyBFK2SjDXNwYxOxpiwxa1lqTL/AoGxPX84kD
         AKVv75cek1l4dk+F0X7bsvwweOW25kTqB0g+8vDaxjwKd/rYWzeKCI3PajD7IgrPgpeG
         B2kcFrKJm9VBqfyEXPL8kYsc6EGKD5V29Tuq0KA7WAHuv3tcbgJAM66KLk+LaUpWUq5P
         MUjg7eIA1X9dBBnY8+rV0N9bC23Ot1HBOUelONDqsolloQqZy3g/LzBmOH1TjbaLZ4hZ
         HPQA==
X-Gm-Message-State: ALoCoQmqnume3nH8yhp+TLL9viesD1e5idgptICEwG6412k2Krtgg+WcKdA9m9X2SjBACFDzz9EW
X-Received: by 10.182.197.172 with SMTP id iv12mr14602259obc.1.1401222363937;
        Tue, 27 May 2014 13:26:03 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n59si1574264yhi.6.2014.05.27.13.26.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:03 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id C19A3370571;
	Tue, 27 May 2014 13:26:03 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6DAD2E0D62; Tue, 27 May 2014 13:26:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250198>

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
2.0.0.rc3.474.g0203784
