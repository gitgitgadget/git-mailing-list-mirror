Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81D6B1F462
	for <e@80x24.org>; Tue,  4 Jun 2019 02:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfFDCNk (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 22:13:40 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42580 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFDCNi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 22:13:38 -0400
Received: by mail-ot1-f65.google.com with SMTP id i2so17086342otr.9
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 19:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=od4biYS3NOd6r2UJvGzkdOrtz3Tfd1qCtNAQC3sZNDo=;
        b=lJPv6GVHONyQ0217kTL6kkHzhVr+VmUy93Hxdab2PObQsyW8o6Xq/1DzexJRb6/wXU
         tlEPvj0eahD1wSQOtfB8W809nmCrv7L4kLFPSxACONVRYXqLw+hPaYA7whQu9pH/e7Yi
         gi91RAUppV9pwr0VplMIBYWzaQ2FhQjU71BIO2svRqJzgv9NKblQsDLl2iEXEAeSCbUz
         aeaAr/WstdqjHUWp7SfNBczddOyOZRxSF6OSGrURlryaDnCXToUk0FRdOCGAFNAW7Xk9
         5IWT9zXNtIbfsatMgOhxWhKP8W28x5wTOq9I51v3DTzo7tVSt7LOT/nLHkwkqQ+aszyn
         v8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=od4biYS3NOd6r2UJvGzkdOrtz3Tfd1qCtNAQC3sZNDo=;
        b=cDOCav9JCcofCmjB3UHsQ6OvMXqIkJfTj6lXkMJhH0aBLaJ8Y4YEB2adiKol5iRP4P
         1/via9zhY/RJlnDyiCUwB8oP67ltXTE6CG348RLlZ9eDGX2Ro4bOEstSmVS5SWGaB+oF
         8tIShvYuyhojAHnW9mTmUe+RGoQWWHriR4u6qB+L0lQ+/aoFFUoVhM6rHS/tuFjNOU6p
         f0+DiKB1itEH+sYrcd/Mb5LEP4hocce5sGIbBNnDO1VWG4842cMJ2y6ngeNk+OxPGFIX
         3TnurClKFoWmOW3g4Yt8WOA19BrKInTL7jcYJFLuimnP0YDLsDJcLG1XPcwzjC8gFcLn
         ytEw==
X-Gm-Message-State: APjAAAWGHYScxUJ0M6Zm35SqWg6v7xQs9SDJyHmS+VX4VQ/1Sze2eaxk
        EQbLP0BADZfuexMN9CW/apN2oL4YDx8=
X-Google-Smtp-Source: APXvYqy9iGwl1YZWTWCZcpohx+XJclgF886VMzBeukeZcZtXx9vGyPgclCFlk146hQ9T9v3OSsI8kw==
X-Received: by 2002:a9d:6503:: with SMTP id i3mr3480276otl.139.1559614416977;
        Mon, 03 Jun 2019 19:13:36 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id s201sm6533364oie.40.2019.06.03.19.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 19:13:36 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 4/5] fetch: make the code more understandable
Date:   Mon,  3 Jun 2019 21:13:29 -0500
Message-Id: <20190604021330.16130-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190604021330.16130-1-felipe.contreras@gmail.com>
References: <20190604021330.16130-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The comment makes it seem as if the condition is the other way around.
The exception is when the oid is null, so check for that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fetch.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8af5e319f1..9dc551551e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -367,19 +367,21 @@ static void find_non_local_tags(const struct ref *refs,
 	 */
 	for_each_string_list_item(remote_ref_item, &remote_refs_list) {
 		const char *refname = remote_ref_item->string;
+		struct ref *rm;
 
 		item = hashmap_get_from_hash(&remote_refs, strhash(refname), refname);
 		if (!item)
 			BUG("unseen remote ref?");
 
 		/* Unless we have already decided to ignore this item... */
-		if (!is_null_oid(&item->oid)) {
-			struct ref *rm = alloc_ref(item->refname);
-			rm->peer_ref = alloc_ref(item->refname);
-			oidcpy(&rm->old_oid, &item->oid);
-			**tail = rm;
-			*tail = &rm->next;
-		}
+		if (is_null_oid(&item->oid))
+			continue;
+
+		rm = alloc_ref(item->refname);
+		rm->peer_ref = alloc_ref(item->refname);
+		oidcpy(&rm->old_oid, &item->oid);
+		**tail = rm;
+		*tail = &rm->next;
 	}
 	hashmap_free(&remote_refs, 1);
 	string_list_clear(&remote_refs_list, 0);
-- 
2.21.0

