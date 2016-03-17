From: Hui Yiqun <huiyiqun@gmail.com>
Subject: [PATCH v2/GSoC 3/4] git-credential-cache: put socket to xdg-compatible path
Date: Fri, 18 Mar 2016 00:48:45 +0800
Message-ID: <1458233326-7735-3-git-send-email-huiyiqun@gmail.com>
References: <1458233326-7735-1-git-send-email-huiyiqun@gmail.com>
Cc: gitster@pobox.com, pickfire@riseup.net, peff@peff.net,
	Hui Yiqun <huiyiqun@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 17:49:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agb79-0007w0-MA
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 17:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbcCQQtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 12:49:32 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35844 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932875AbcCQQta (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 12:49:30 -0400
Received: by mail-pf0-f195.google.com with SMTP id q129so12103963pfb.3
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 09:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HOT1hMFOirY77exE043IRUMArGAEan2GURfsa2DNDjQ=;
        b=Jh+2v4NtOSh0kgtCXxiXzr45AgLLNv2uj8HEr+l5iCIJAGrR1XMDSMWvJTCbu06XM8
         ZOJrDO1aborVof3BjH90NucydY0KSaU9MGD9UBFHRJQAaks442hF1VvCcynW5eDVgyhl
         1sMcA7nyhiPO0IEg4LlyAEdI+bzchWjCteHyw2gpdAJMGto4+1SbVOWo6xKSo/rd4DLo
         tEQL5YYyQtjWCgKR/7MTPBaWKVC63RdvWHxia14+y1hJuTFJlFgEBVDfvFCBPpVIL4fU
         OHT4K+YGUU4/95S/sjJkRBfTz8jTqNZh+inyDWx0v442B/KKvLCsraVPHGv1uuUXOuv5
         JwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HOT1hMFOirY77exE043IRUMArGAEan2GURfsa2DNDjQ=;
        b=hM4rXcZCtGd62xOuBMQksVPFbNLB0thwlPIbCbtDXnVkoPYkqzZ6SwG6TD3oLdL52T
         JrvXarZjkc9JlsdrhP4IshnJfRmhY7grz532E6/4FdINiYHFEBCKoCWdmidILpwm9TSs
         5AEFtIXOltD33GDR0NoqsdtxRysIMuMBMbcwWgKqAHHhCZe5WrfmJ29ZRCipk9YYQvSk
         JgXVOLQSQHHgx1WPr6878vqSPoiOfVi89agP4EuDoz76UqjKEuWdIyhYmUS/Rqh94ZgN
         VfvcPsKwWFgBRpUDNnoaXX1/8Va/5B9tq0Jb4URrjyflSf1EkTYXNhKsrpv/aHaB4zem
         zsIQ==
X-Gm-Message-State: AD7BkJLb4uOpKHsYRgrzdZAFtQbeLLxEQq3nS4fxgyesgWIj7HcDXjlpXC74ZU2aioAnzg==
X-Received: by 10.98.74.6 with SMTP id x6mr16307671pfa.80.1458233369615;
        Thu, 17 Mar 2016 09:49:29 -0700 (PDT)
Received: from localhost.localdomain (hashi.inv.dotkrnl.com. [133.130.122.94])
        by smtp.gmail.com with ESMTPSA id kw10sm14643290pab.0.2016.03.17.09.49.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Mar 2016 09:49:29 -0700 (PDT)
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1458233326-7735-1-git-send-email-huiyiqun@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289125>

move .git-credential-cache/socket to xdg_runtime_dir("credential-cache.sock")

Signed-off-by: Hui Yiqun <huiyiqun@gmail.com>
---
 credential-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/credential-cache.c b/credential-cache.c
index f4afdc6..40d838b 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -105,7 +105,7 @@ int main(int argc, const char **argv)
 	op = argv[0];
 
 	if (!socket_path)
-		socket_path = expand_user_path("~/.git-credential-cache/socket");
+		socket_path = xdg_runtime_dir("credential-cache.sock");
 	if (!socket_path)
 		die("unable to find a suitable socket path; use --socket");
 
-- 
2.7.3
