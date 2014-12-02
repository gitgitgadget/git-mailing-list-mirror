From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/4] refs.c: rename transaction.updates to ref_updates
Date: Mon,  1 Dec 2014 18:02:30 -0800
Message-ID: <1417485752-10502-2-git-send-email-sbeller@google.com>
References: <1417485752-10502-1-git-send-email-sbeller@google.com>
To: jrnieder@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 02 03:02:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvcnY-0006ue-TM
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 03:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbaLBCCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 21:02:36 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:59400 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbaLBCCf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 21:02:35 -0500
Received: by mail-ig0-f177.google.com with SMTP id z20so9996841igj.10
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 18:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=exQDIA0DEGGmFAvwgmG/g/xBNDoOn0b3VSuBiE+0AG8=;
        b=fhBt4sb3rVN8eFjRSglNprjh3xBRfa02Dh5XqE4csgOMWmRErChU43XROYucy90uVT
         9mzq5wI4wPdRQJOeLKszFTpCXAEKfabkfYuRefvmaRLjPpYdWauSaA0ccKoGMVv6oBW/
         kSm67ntB9MUheEcUWS6kaA51zBQ2P9vOirwjv1wfyC0FbYbR93GE1IwVMsW1lp1oPo27
         FE7FD5W1cUPuTWeNDNQOWHdGfOKY6KRLvIa1ra6h0ssqPXKtBHl39znsp/VnuMGHRQcQ
         +5wvE2iN3NeMdrZUj/Vsk23NXIdSw7qn2iRMyIdQ1HxnEyeq1nmTDlr5/s78UiPceZBc
         wxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=exQDIA0DEGGmFAvwgmG/g/xBNDoOn0b3VSuBiE+0AG8=;
        b=mkthHAjj9mzewmtHNnbu/L6oAGsgn2YJoDaNF8YbJUFAK8yAIwfzk8Mh3aOauEw8lI
         0TcP9zejB/+o2U61uQxVtw/IGQ1UpBwT+JSUAdqe4kvK/A/ESS9mP4fQVNhM1uEqttr/
         ORWTQ5alTJliV5SfIcxeVLOs960LH2fWfo7FnNc6iRCA5M24FMngRjNnFz0L3GK32/OB
         Kh9+jjBXGUeydXrH03xqwD0mEnqXk67fMHl1uXK8LM+bRXu00H+tA3EePF77jCCw1J8h
         npd0zZZh8aayxkMKlUTO5Vi88SLs7Zn6nd9xpXHlGOIoJ9oonYJCnzrZYO9WPBOplfvk
         D0gw==
X-Gm-Message-State: ALoCoQln3uv9qYa6tISt8cvJ+kHAu3zOtjaSiTQnV8E+R0UfN31WbXbDGAA6kioe4EoAGLBQXJsw
X-Received: by 10.107.136.146 with SMTP id s18mr55600552ioi.36.1417485755031;
        Mon, 01 Dec 2014 18:02:35 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:21e7:446b:f329:a30a])
        by mx.google.com with ESMTPSA id 7sm10437417iol.44.2014.12.01.18.02.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Dec 2014 18:02:34 -0800 (PST)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417485752-10502-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260520>

The updates are only holding refs not reflogs, so express it to the reader.

Change-Id: Ifdc87722f0e7314f3d0febb970aa7769eada6d33
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index f0f0d23..58de60c 100644
--- a/refs.c
+++ b/refs.c
@@ -3554,7 +3554,7 @@ enum transaction_state {
  * as atomically as possible.  This structure is opaque to callers.
  */
 struct transaction {
-	struct ref_update **updates;
+	struct ref_update **ref_updates;
 	size_t alloc;
 	size_t nr;
 	enum transaction_state state;
@@ -3575,10 +3575,10 @@ void transaction_free(struct transaction *transaction)
 		return;
 
 	for (i = 0; i < transaction->nr; i++) {
-		free(transaction->updates[i]->msg);
-		free(transaction->updates[i]);
+		free(transaction->ref_updates[i]->msg);
+		free(transaction->ref_updates[i]);
 	}
-	free(transaction->updates);
+	free(transaction->ref_updates);
 	free(transaction);
 }
 
@@ -3589,8 +3589,8 @@ static struct ref_update *add_update(struct transaction *transaction,
 	struct ref_update *update = xcalloc(1, sizeof(*update) + len + 1);
 
 	strcpy((char *)update->refname, refname);
-	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
-	transaction->updates[transaction->nr++] = update;
+	ALLOC_GROW(transaction->ref_updates, transaction->nr + 1, transaction->alloc);
+	transaction->ref_updates[transaction->nr++] = update;
 	return update;
 }
 
@@ -3712,7 +3712,7 @@ int transaction_commit(struct transaction *transaction,
 	int ret = 0, delnum = 0, i;
 	const char **delnames;
 	int n = transaction->nr;
-	struct ref_update **updates = transaction->updates;
+	struct ref_update **updates = transaction->ref_updates;
 
 	assert(err);
 
-- 
2.2.0
