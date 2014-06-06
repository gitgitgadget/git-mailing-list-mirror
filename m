From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 34/40] refs.c: pass NULL as *flags to read_ref_full
Date: Fri,  6 Jun 2014 15:29:12 -0700
Message-ID: <1402093758-3162-35-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:30:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2ee-0002lC-TB
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbaFFW34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:29:56 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:46188 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbaFFW3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:24 -0400
Received: by mail-ve0-f202.google.com with SMTP id pa12so680330veb.1
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=26jwHzdcJwmvpMLco9vNqa8MCmcZ5UKEFhLDoH8jBxs=;
        b=W0mzxmZPlO0cN85Mdxsrnml7TADQxZF6tJ1efcxOavGzcjFUQUdlUv+Lswvh+3RelT
         JkJOsBpgYTBNmwsXYfAZSAIeeqfe4h3hBjMocRbsYOPeYaClqxyMEq9A1YhUSetsfSwU
         3FpdnrOBbiTMKH+uIMnIcdi54CtVOYXLExBTE9l3v7QlNUSUP9k2wdU3MFJmGZh8uOfY
         v6ftgpI4w+xWOCB1Sno6k259JSck6FfFwrIq/xTULWh/AHtZ5A5F6npSERJ6Nct91BAL
         FeLRaOMYQtDSwUFkCRQYSBedOLeVSB8zVXwowWWPzD6OlgeIui2Bq2yHcV6bJE4UXiV0
         Kc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=26jwHzdcJwmvpMLco9vNqa8MCmcZ5UKEFhLDoH8jBxs=;
        b=HnGNhYvn9gAta7CuMKWxawZq0fl+YA50k5IEDYEOYHVtuQwswJ245eAqg3CQP0ofWw
         SsmN1Bwd0MH4NWufaU120gf5dMyj8Xbv2mZmMwMpnQWtWNVi517VPsjZHOyPwFKBu5NG
         oQDC/EkrTK3AJs6J5apMBvlOPFb17cf0E/3NthN3XBPtOTVN7/Lj6AzQ1mr7ag4BlIAU
         6O2XlJ33kjRCWmeu0I6Lb2sm/U+vV20u6fIbDNQC72x2lRArTRllbMnzapKxSNTS+qRF
         R5B4ZP2GaukXl2Vcm/h9cJNz2eegaCK24hFxDwDRO1+jfwAanGpNAjh+j4dLIiVLxUqF
         vfVw==
X-Gm-Message-State: ALoCoQnHbCmi/SjP6yUl57PoMwhvje4AijBxgYyLBxXfGbgH1DO9omqLTw9rwsmLPvOeQnxPX2IC
X-Received: by 10.58.227.10 with SMTP id rw10mr4751192vec.39.1402093763353;
        Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id xn6si751082vdc.2.2014.06.06.15.29.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 21D755A44EE;
	Fri,  6 Jun 2014 15:29:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id EFC7EE10DE; Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250993>

We call read_ref_full with a pointer to flags from rename_ref but since
we never actually use the returned flags we can just pass NULL here instead.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 88d9351..8848dbf 100644
--- a/refs.c
+++ b/refs.c
@@ -2657,7 +2657,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, sha1, 1, &flag) &&
+	if (!read_ref_full(newrefname, sha1, 1, NULL) &&
 	    delete_ref(newrefname, sha1, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			if (remove_empty_directories(git_path("%s", newrefname))) {
-- 
2.0.0.582.ge25c160
