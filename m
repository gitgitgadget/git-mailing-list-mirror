From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 04/48] refs.c: allow passing NULL to ref_transaction_free
Date: Thu, 12 Jun 2014 10:20:55 -0700
Message-ID: <1402593699-13983-5-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:21:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8hB-0006ic-UQ
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756306AbaFLRVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:21:46 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:50640 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756169AbaFLRVn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:43 -0400
Received: by mail-pb0-f74.google.com with SMTP id rr13so186343pbb.3
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vAjq37MfKKhFVXMHdPMPfFPEqEAgpu+BhmYF3iwK6zw=;
        b=l/DdjXDc45G0uF8PYIQeHLEDr81qDnJw1N79rkr5txxoexzMcE4VZcrritg/DgRDpT
         Dsr6ptogsatVuMoLEXJmMK30nOKMmkhp9iU/r+4XrlzWLGka5590WWa5b4g6fzIsvEHO
         9cvFK5FUteRQN2/SgyhXMdjhs925euSPNbluc9UU+9jvBszj07taunFcNbZcqgQQH7kK
         T487/lkfbzKhIA/WLEl1ePquyP66Rb28otCrcaDf8EJ/OqrznuAs0cKWUMb4eTXQ7wHd
         PnVkuKQOpuQBFABxnv6DK3mQ1xJPUS+gonTvSdURnCL1YEPDeviU69ux3oaxNe+cmQRi
         Pokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vAjq37MfKKhFVXMHdPMPfFPEqEAgpu+BhmYF3iwK6zw=;
        b=dbrMHQAojj+oYWJszvMReh1RzPvK6hnZ0J3b++kBHo94HUYwKKixj0aYlUFCzI9A4T
         dMUCTy82G+/KJLI2orvm4YVUEk05E5PLJ7zFq5QUMQVopSH8gM36cU5T+F3OC7V57Sae
         vGt81U54ZlkgkXOUc/gBFqbB8v64ZEU6PIyX5DNtRFcSyk/0hq9gGkRC+UnbKQ4PP539
         43yFRSLJ0raCu9hFf76x0ETOeNs9g8ebk2JHSCqyQBYFTZ0VdpQ61hbGX0lwlVC9xq5n
         Yczf0DBbAHorkFItKu6Drbm5MGWCqyh8ejKmDZpWdtzipmu1ZLreJKX/Yc0ltQoZHnk+
         gbNw==
X-Gm-Message-State: ALoCoQmiaWOmvKpV0oqhEpcfC4Am3wCwFaVPtWt1LCq6xqwWBHrhyRQ6g96+4/l+gZksU2zqOVd0
X-Received: by 10.68.216.230 with SMTP id ot6mr2755667pbc.3.1402593702918;
        Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id t4si113762yhm.0.2014.06.12.10.21.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id B9E255A4749;
	Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 648BDE0A0A; Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251416>

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
2.0.0.599.g83ced0e
