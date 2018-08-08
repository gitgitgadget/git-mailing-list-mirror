Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93E141F405
	for <e@80x24.org>; Wed,  8 Aug 2018 22:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbeHIAjz (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 20:39:55 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:37931 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHIAjz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 20:39:55 -0400
Received: by mail-qt0-f201.google.com with SMTP id e4-v6so3013593qtj.5
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 15:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=796bRSe0KE5sayeqWf85fviahFlsDDMZyCqow6naLyo=;
        b=of8haR7UXthzs0yFwsTwUToYd+euJQTrmVl8jNAs2UCZVfbSoFryw3NkXRFwpvEMum
         mxbqxlYzb3pciGhY/j2pgUeXU4d9C1X6EGvXVXqPHGizpQ1T029rSi7F4Kw6onULL/kz
         ta4QxZXGK5litCnNJg6kE+dF06bLWnGW/npVD3raDplAU39bLmbMBhb38ntYyctiVJT7
         RydJu+M0TYCaBvs3X9RNlEo9N5oeu9q2HmPGufv+H+VHblJR6UCWRbaEsQd2+9OxMIkl
         jRrYu+S9x1cJLsZ+GLzcUoi9GYEaslA6K5ZBbVNPwL1oAbSdiNOi6/4gGc7r5L2oMonw
         SOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=796bRSe0KE5sayeqWf85fviahFlsDDMZyCqow6naLyo=;
        b=MAT6u4pCgeWQ68Kbo9HjKq+1+hjBTnVdrLMl9mAAHJnpHXGa/Sx5MWCdRoS3WFCKPm
         Z8/Jcp8VrjIbgNaNwMYMDhcW20trnJaGZdOySSzuaUCCqeoYbjMQShmEyCTvHw99C83w
         ABAD5G/zFLH5YsGX3RwfsMXbcQSuooOLsnAxcBCTDGJ5+wUX+BhJDORc5bx/PrYjwRyZ
         3wrJE6OV+JihJHzVzXpDzZ6ttcP0wLglT+i0CC+2L1E1pLdXaX34+LRtAibfsygmF4j5
         HE0kAXVtiuG8cFoaZ5U5/RjRFlUU6pcFDaaYnEFGhjQKihSNQrR/OYBamQhNafIB4MV3
         uCLA==
X-Gm-Message-State: AOUpUlFrrrLINnfKs8EVr9sBux2BjIOfr6cZrnossRIdMIisw46NjbTS
        ImHDD8vBibdST6KGsXnZWuoV1gTD12xVGFlAjWaiCHaNvRw72hnicZGfy9tMjrDqaLgiqHq5mI4
        P/JKtYFNwsN1jLrwqpqRp9vNtneoRCbuTKinZF0E1HVtaCM1ta0iH0WTElY1e
X-Google-Smtp-Source: AA+uWPwCcg450YwtJZhVQ60BgwGNdNOZ2OeXCIJ8z0SJ0ckfU7/C9FDK7ofbMqUwlRbkjWM1IfZLuVqrq5HS
X-Received: by 2002:ac8:5402:: with SMTP id b2-v6mr2469361qtq.49.1533766693972;
 Wed, 08 Aug 2018 15:18:13 -0700 (PDT)
Date:   Wed,  8 Aug 2018 15:17:45 -0700
In-Reply-To: <20180808221752.195419-1-sbeller@google.com>
Message-Id: <20180808221752.195419-4-sbeller@google.com>
Mime-Version: 1.0
References: <20180808221752.195419-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 03/10] sha1-array: provide oid_array_remove_if
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     hvoigt@hvoigt.net, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 sha1-array.c | 39 +++++++++++++++++++++++++++++++++++++++
 sha1-array.h |  3 +++
 2 files changed, 42 insertions(+)

diff --git a/sha1-array.c b/sha1-array.c
index 265941fbf40..10eb08b425e 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -77,3 +77,42 @@ int oid_array_for_each_unique(struct oid_array *array,
 	}
 	return 0;
 }
+
+int oid_array_remove_if(struct oid_array *array,
+			for_each_oid_fn fn,
+			void *data)
+{
+	int i, j;
+	char *to_remove = xcalloc(array->nr, sizeof(char));
+
+	/* No oid_array_sort() here! See the api-oid-array.txt docs! */
+
+	for (i = 0; i < array->nr; i++) {
+		int ret = fn(array->oid + i, data);
+		if (ret)
+			to_remove[i] = 1;
+	}
+
+	i = 0, j = 0;
+	while (i < array->nr && j < array->nr) {
+		while (i < array->nr && !to_remove[i])
+			i++;
+		/* i at first marked for deletion or out */
+		if (j < i)
+			j = i;
+		while (j < array->nr && to_remove[j])
+			j++;
+		/* j > i; j at first valid after first deletion range or out */
+		if (i < array->nr && j < array->nr)
+			oidcpy(&array->oid[i], &array->oid[j]);
+		else if (i >= array->nr)
+			assert(j >= array->nr);
+			/* no pruning happened, keep original array->nr */
+		else if (j >= array->nr)
+			array->nr = i;
+	}
+
+	free(to_remove);
+
+	return 0;
+}
diff --git a/sha1-array.h b/sha1-array.h
index 232bf950172..151c7ad7f30 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -22,5 +22,8 @@ int oid_array_for_each(struct oid_array *array,
 int oid_array_for_each_unique(struct oid_array *array,
 			      for_each_oid_fn fn,
 			      void *data);
+int oid_array_remove_if(struct oid_array *array,
+			for_each_oid_fn fn,
+			void *data);
 
 #endif /* SHA1_ARRAY_H */
-- 
2.18.0.597.ga71716f1ad-goog

