From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH v2 1/9] Documentation/git-push.txt: Document when --signed may fail
Date: Wed, 19 Aug 2015 11:26:39 -0400
Message-ID: <1439998007-28719-2-git-send-email-dborowitz@google.com>
References: <1439998007-28719-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 19 17:27:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS5Gq-0004p0-Bk
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 17:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbbHSP1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 11:27:17 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36862 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbbHSP1O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 11:27:14 -0400
Received: by igxp17 with SMTP id p17so108039588igx.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 08:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H636N67N2kHV1hKm9+Wq7hZen7SaL+BQ2f54p/TgW10=;
        b=OGM+djmSPVZTPQNUZEkvDRk9IIUTOsCEf6rJIbH/oxkaeBhAKPeFrXWL65bi4LlK//
         p0roEIeGGGXy/B8/uWp+EXmqRK6mlfDtVlwRvtv4jAYtosSdRBQLsKqkS/FPCX17ExTk
         Y8CHmljQPSWVMLm+K5j3c8LIU/E5Bkf7fq/yL5QvT1giIG2JV/reqi2gGNody1nY9DWQ
         IJsFKEjYtnwhMSN64C7tYdSKHXruDt6MsRXxw0owdExcxjxF6F5Ul8WENg6ik0cSx36a
         7JhxDjYNOV4IgSE/q84XWGvL6r8QwNXQ67PoPkPOg3oRGJilO3HUOA4VKDeG2VmSKQKP
         nJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H636N67N2kHV1hKm9+Wq7hZen7SaL+BQ2f54p/TgW10=;
        b=P0wZtO+RjaziC97Ee9cAQKc3euIC2NOqmK1+OEodp07K6o+3LZ+4Nc+HAET802JmFM
         sVT049AdVeFBid2UJRRvogkgPI2OZ/R821buhv6BvhC1+c3PDHv2whlR4lHVaHtWu+e7
         Od8A5WO/ljw+FeIxRX3G0NrTbBQ0hQTdtus/7XYhIZ91zni62DgyEjoatJb4AsYUCvgN
         iAHJm0WJVqzsMJgbXXxO1D0y4HXF7BHCGDpn7f/JAV5u44nlXTizCS1eL1M5L9tFABgl
         PR3oEY1Ws2mlAHY37SZuqyDXoNOLLyHMio+EAaF7KvzG1vopuUL6DUJy+UsGco0YrWve
         JMrA==
X-Gm-Message-State: ALoCoQlgIR3+qSnkk28AKLqOKECg38nCfrITac/4arwzzmOby/u+EzXWgpB/eFq+EvkZSMDfrHOi
X-Received: by 10.50.64.212 with SMTP id q20mr2383004igs.5.1439998033611;
        Wed, 19 Aug 2015 08:27:13 -0700 (PDT)
Received: from serval.arb.corp.google.com ([172.29.229.12])
        by smtp.gmail.com with ESMTPSA id o19sm2347819igs.18.2015.08.19.08.27.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Aug 2015 08:27:12 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.276.gf5e568e
In-Reply-To: <1439998007-28719-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276187>

Like --atomic, --signed will fail if the server does not advertise the
necessary capability. In addition, it requires gpg on the client side.

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 Documentation/git-push.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 135d810..da0a98d 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -137,7 +137,9 @@ already exists on the remote side.
 	GPG-sign the push request to update refs on the receiving
 	side, to allow it to be checked by the hooks and/or be
 	logged.  See linkgit:git-receive-pack[1] for the details
-	on the receiving end.
+	on the receiving end.  If the attempt to sign with `gpg` fails,
+	or if the server does not support signed pushes, the push will
+	fail.
 
 --[no-]atomic::
 	Use an atomic transaction on the remote side if available.
-- 
2.5.0.276.gf5e568e
