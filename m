Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E5E41FAE2
	for <e@80x24.org>; Mon, 19 Mar 2018 13:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933089AbeCSNcZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:32:25 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40944 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933235AbeCSNcT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:19 -0400
Received: by mail-wm0-f66.google.com with SMTP id t6so15794922wmt.5
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jkqIUpNSVjyinOsbmuLS6UAPYvrtsYfsaIPbnZ445FU=;
        b=VQtyt0NGxTvhv3zlVGMuCowQW2WzLjGR6ekhNBA9Wmq7eylViNRxcbNo4XJgJnmSCN
         ubmg3yCD27mbw24u1iI1bI5Y7irK9eHkpJiTLGx40Q0n/KqRiv3Ddm8aGNWSsEzk6VJx
         Gwym2BBazq+Sga/F1bVbzppQjVQCFo+xINyHGpnX4csmcqQdv4X27ba3gJXS3kbKjSvJ
         HmblgxCZ4u6h6Tk+CT728RgWCtPlWKejW0q06mg0gcGrWYUj1P7VP1Lf2MGXIOnZ6cFC
         6cLVCfj/w4Lbsvkh3QaBym/DWYCTeHMPiC0mSArwY+uaczcCggktgLjaZWemjtPuwmte
         6x/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jkqIUpNSVjyinOsbmuLS6UAPYvrtsYfsaIPbnZ445FU=;
        b=ksd5QyuQ7yz919CmjD3TFgeuBQTSD2LqIltwsWyRLP2MUHgpZDveoL1Mf2AjvjwYOg
         35sbRttp3t6O+YLfd4agO4Vkr2StxKMoZ6ItCXD4VDP+6TPxAFotlt/oUVXkqYovloNB
         dRT+OQM1NeFXnp4XpTTT3QFPHQ3DDZPn/DwWiWAVDQWqhCcasDrLeO0pBf2uWuy0oz9E
         +tRKCU4/g8fXAz/ZImcCJm4cFAbJVTeS9d7XhWREkVJHrdNDch8bOQMUJETsbvjKIcNu
         yg+8tu5spFufHmwQy9e6DNdF7lZNzLPTiH4JK8U9WaPRINhytLZE6rVRoYE3SfJK1M2g
         P5tw==
X-Gm-Message-State: AElRT7GtvPxllLYqXvuouYXMksXkqHcxz9fBx4cKVvWsvP1smQLSc3ou
        yYG1wdhfZKoQLO9RFoyxwRy/LktN
X-Google-Smtp-Source: AG47ELtAlaB8hcT1dpslBVcusev07pL5/HMhAknSnqgtmv6RYo1wXjeBYNrJZ7dY2Z3GMgWs51liuQ==
X-Received: by 10.28.113.79 with SMTP id m76mr9423944wmc.27.1521466337662;
        Mon, 19 Mar 2018 06:32:17 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:16 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 07/36] odb-helper: add 'enum odb_helper_type'
Date:   Mon, 19 Mar 2018 14:31:18 +0100
Message-Id: <20180319133147.15413-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As there will be different kinds of helpers, let's add
an "enum odb_helper_type" to tell between the different
kinds.

Let's add a field with this type in "struct odb_helper",
and set it when reading the config file.

While at it let's also make it possible to find an helper
of a specific kind by adding a new find_odb_helper()
function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c | 13 +++++++++++++
 external-odb.h | 10 ++++++++++
 odb-helper.h   |  3 +++
 3 files changed, 26 insertions(+)

diff --git a/external-odb.c b/external-odb.c
index 5d0afb9762..9c77180d6c 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -57,6 +57,19 @@ int has_external_odb(void)
 	return !!helpers;
 }
 
+struct odb_helper *find_odb_helper(const char *dealer, enum odb_helper_type type)
+{
+	struct odb_helper *o;
+
+	external_odb_init();
+
+	for (o = helpers; o; o = o->next)
+		if (!strcmp(o->dealer, dealer) && o->type == type)
+			return o;
+
+	return NULL;
+}
+
 const char *external_odb_root(void)
 {
 	static const char *root;
diff --git a/external-odb.h b/external-odb.h
index fd6708163e..27c3d39c1b 100644
--- a/external-odb.h
+++ b/external-odb.h
@@ -1,7 +1,17 @@
 #ifndef EXTERNAL_ODB_H
 #define EXTERNAL_ODB_H
 
+enum odb_helper_type {
+	ODB_HELPER_NONE = 0,
+	ODB_HELPER_GIT_REMOTE,
+	ODB_HELPER_SCRIPT_CMD,
+	ODB_HELPER_SUBPROCESS_CMD,
+	OBJ_HELPER_MAX
+};
+
 extern int has_external_odb(void);
+extern struct odb_helper *find_odb_helper(const char *dealer,
+					  enum odb_helper_type type);
 extern const char *external_odb_root(void);
 extern int external_odb_has_object(const unsigned char *sha1);
 extern int external_odb_get_direct(const unsigned char *sha1);
diff --git a/odb-helper.h b/odb-helper.h
index 57b14fe814..d4b968693f 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -1,9 +1,12 @@
 #ifndef ODB_HELPER_H
 #define ODB_HELPER_H
 
+#include "external-odb.h"
+
 struct odb_helper {
 	const char *name;
 	const char *dealer;
+	enum odb_helper_type type;
 
 	struct odb_helper_object {
 		struct object_id oid;
-- 
2.17.0.rc0.37.g8f476fabe9

