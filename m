From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH 1/7] Documentation/git-push.txt: Document when --signed may fail
Date: Thu, 13 Aug 2015 15:00:45 -0400
Message-ID: <1439492451-11233-2-git-send-email-dborowitz@google.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 21:01:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPxkN-00032R-9L
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 21:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753706AbbHMTA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 15:00:58 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:34464 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342AbbHMTA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 15:00:56 -0400
Received: by iodb91 with SMTP id b91so61905579iod.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 12:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nGfr1TOnx1qGbSbkv/qzDdp0jjeSpCatu7E2cZmBRo8=;
        b=dZ9SAvQ+WUuT9lE06A3h1biUC8YcphZUaSbywj8QgATnll+PSPAO4jpYZq7ZD9vKys
         vWvIPYn0IgDmBxP93r9JmE6+qtXpuvRMqsEHwKILbZdNa8c6yD9p4zMzAGgPW/1feKsT
         1K2tQBcDG5RXD2WZDdO6gOdJpf3sVao6DL0eLZawZq4K8DvOfbuB4k5WHI9hnIWKH0bB
         IyteyiQPgutVZBMUhMRIDBmFIP8IHZP7v1Fo2BjkymPKCa8BlxxAgU5gsewYrGTi2YOe
         LQFYsEZxufUT7KBWIlZhU27CVZhmSBXjDkW8OXg91BFaww54aSeEaWiAG+XcvRV3etPB
         ZcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nGfr1TOnx1qGbSbkv/qzDdp0jjeSpCatu7E2cZmBRo8=;
        b=DM6UyvE+IyYKUzs1ARJEOgS8IbF+SbziREFOI5pND3avB9/5x/kCxPlyf4RzbExTsc
         yEjHUqWZC7IkzbHzBUyMIiKHAmBefBs2LBd2V7PHkxk7PDz2se1z6eqf3TTHGCnzIzBk
         FnkBX51O4pC6islF8idk5j2ezfEAcJFni9JRuIiBK0jQzLIdQGTQhlI/oXdWEkaJv7gB
         o7sKXLmbNxAo7fF/3eeEjTiTshKYKspcvXItwJDuBPstyiischySQMMT1OLwP2b0iL+Q
         dKdk5z7rmDgBQfu2oT4/9771dXuVAGF/KYgeeaPdQ4rV+mDCDZ+GM3iI7LPGx9xpejTo
         5d3g==
X-Gm-Message-State: ALoCoQnVUR/7ucJhOHdDj/O6CFgCx036nMT9eq5Qw8hHa2SrgerRoTboM+CZqEcqUFr0tsjhCXvO
X-Received: by 10.107.12.32 with SMTP id w32mr916274ioi.23.1439492456205;
        Thu, 13 Aug 2015 12:00:56 -0700 (PDT)
Received: from serval.arb.corp.google.com ([172.29.229.12])
        by smtp.gmail.com with ESMTPSA id c91sm2078646ioj.43.2015.08.13.12.00.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Aug 2015 12:00:55 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.276.gf5e568e
In-Reply-To: <1439492451-11233-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275878>

Like --atomic, --signed will fail if the server does not advertise the
necessary capability. In addition, it requires gpg on the client side.

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 Documentation/git-push.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 135d810..f8b8b8b 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -137,7 +137,9 @@ already exists on the remote side.
 	GPG-sign the push request to update refs on the receiving
 	side, to allow it to be checked by the hooks and/or be
 	logged.  See linkgit:git-receive-pack[1] for the details
-	on the receiving end.
+	on the receiving end.  If the `gpg` executable is not available,
+	or if the server does not support signed pushes, the push will
+	fail.
 
 --[no-]atomic::
 	Use an atomic transaction on the remote side if available.
-- 
2.5.0.276.gf5e568e
