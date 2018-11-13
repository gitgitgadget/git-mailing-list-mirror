Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 496371F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 07:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbeKMRhM (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 12:37:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42257 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbeKMRhM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 12:37:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so1140939pfr.9
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 23:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p0Vt9r/gi0iKngaZ4WOTr9YblcXYP/VnurxMqAYhBLQ=;
        b=noKc+nK2VCytq5Cp1Wo1I5gYGNu+l3CoKU+0O7H0Fx1LNXBjQYMnMYIZWhisTdVV4O
         e7fG4JLT+KXGwxs+clvST3BRLIFW//oKmgSohCA9B9VgutdH5IM+SDzhnuawJW8rczp9
         MvIR4NkXZM4VAt0o32km81FKVmoLkW0NQS/RuWPOWK68LvltBrmj0pdttcRqKAEih5Te
         o8HnAOfJ+nh+MOmswwxsEnMtGMksypMf2RkVUSovC6z8gQ7eWgd6SufYnOprRa6WQxYN
         iAXhLX/2wtkQZQXCKqe9J2foan2FXGT8RqTqjldjQco0TXKW6i+PRFkCqxPxUhG2yzx2
         LZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p0Vt9r/gi0iKngaZ4WOTr9YblcXYP/VnurxMqAYhBLQ=;
        b=UOE/X9q/ijbPAgvXR2yUhbaxADzjSVVPpHxhoOT2nGeX3Oc0vDTrgouOt9SZUz51gb
         +hsosMVdwHthQJtiGTUN/CBiCnhiFXL0/6EZqxM46UrTuwuVDqjI13CzddplpEikFVsv
         /JFxNFI/qnQ6uYSXJkQSilJRXxxLI3cTcbeUi5V5v/psIsRUKsJQkeD8Pe/acfqLiAZ1
         0XQTWY/BkPEZCYhfl1iKxFrjMhmQuAZP2FTcOpX2Et63Q3NkyFJJfi2xpZd96jrFRaZV
         /PRtVGGpGhZwWQQZfJMSOeml8mGfTOTayN71H0AYQEm38hQRKx8jppVf4MJRgAYxKlJu
         pHcQ==
X-Gm-Message-State: AGRZ1gJYiIO4r0dRnGuZs1e5+Qlq15jLkMcQ5qMRAoDUfOl8nSe4uVzp
        jR/ZG7Ennr1BmM+yoyvnaekc7iJN
X-Google-Smtp-Source: AJdET5f5MCLvEQ1Nz+fmPD8ZC8bSAClkmcrGHm5dNdNGW1J7i/oKfkQoX4l8NfGKCsxc1iy9BhqMig==
X-Received: by 2002:a63:4b18:: with SMTP id y24-v6mr3858803pga.181.1542094820202;
        Mon, 12 Nov 2018 23:40:20 -0800 (PST)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id b81-v6sm23367098pfj.183.2018.11.12.23.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 23:40:19 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com, peff@peff.net,
        sunshine@sunshineco.com
Subject: [PATCH 2/2] read-cache: use time_t instead of unsigned long
Date:   Mon, 12 Nov 2018 23:40:17 -0800
Message-Id: <20181113074017.17292-1-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <xmqq7ehi1gpb.fsf@gitster-ct.c.googlers.com>
References: <xmqq7ehi1gpb.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are still some more possible improvements around this code but
they are orthogonal to this change :

* migrate to approxidate_careful or parse_expiry_date
* maybe make sure only approxidate are used for expiration

Changes in v2:
* improved commit message as suggested by Eric
* failsafe against time_t truncation as suggested by Junio

-- >8 --
Subject: [PATCH v2 2/2] read-cache: use time specific types instead of
 unsigned long

b968372279 ("read-cache: unlink old sharedindex files", 2017-03-06)
introduced get_shared_index_expire_date using unsigned long to track
the modification times of a shared index.

dddbad728c ("timestamp_t: a new data type for timestamps", 2017-04-26)
shows why that might be problematic so move to timestamp_t/time_t.

if time_t can't represent a valid time keep the indexes for failsafe

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 read-cache.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 7b1354d759..7d322f11c8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2625,9 +2625,9 @@ static int write_split_index(struct index_state *istate,
 
 static const char *shared_index_expire = "2.weeks.ago";
 
-static unsigned long get_shared_index_expire_date(void)
+static timestamp_t get_shared_index_expire_date(void)
 {
-	static unsigned long shared_index_expire_date;
+	static timestamp_t shared_index_expire_date;
 	static int shared_index_expire_date_prepared;
 
 	if (!shared_index_expire_date_prepared) {
@@ -2643,12 +2643,12 @@ static unsigned long get_shared_index_expire_date(void)
 static int should_delete_shared_index(const char *shared_index_path)
 {
 	struct stat st;
-	unsigned long expiration;
+	time_t expiration;
+	timestamp_t t = get_shared_index_expire_date();
 
-	/* Check timestamp */
-	expiration = get_shared_index_expire_date();
-	if (!expiration)
+	if (!t || date_overflows(t))
 		return 0;
+	expiration = t;
 	if (stat(shared_index_path, &st))
 		return error_errno(_("could not stat '%s'"), shared_index_path);
 	if (st.st_mtime > expiration)
-- 
2.19.1.856.g8858448bb

