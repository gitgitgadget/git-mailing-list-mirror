Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 245EA1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 23:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbeGaAmI (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 20:42:08 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:44640 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbeGaAmI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 20:42:08 -0400
Received: by mail-it0-f73.google.com with SMTP id z8-v6so933329itc.9
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 16:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=fLesSD7TtjNkbVOoPtrLiCucHaAd5TEMADhPsASofug=;
        b=bbhTUWgG7fq4SdJzfpnqeAd85/GVGmeAF7okum4fWs4lLUP/0i+mM2t5MScg6NFPGb
         oVCXMjo/lr5c6IPlI/briTr6F4XyWb2TZp+QaBAvjknynI20wqCFAdXyIWMKcYPHMwZq
         JhqymQwJaUuv1fP15/jzxx668zO0fJyHRysjXdq1KwJ0hJVi/7do+qayxyhDYjpJJUbb
         7GhjnQ2wyHq3tuMMYZSN2WYRg9tJXy/cGdYgcrHAdrvt2/sI/3qrOoWtvx/Jepbu1iBu
         Rb2sJ4IeijJD313GfP00IT5WM1/5uJF+P9RQjuFQjB5p0Ftsnw79VvVWDkJWsbNLEfQQ
         UzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=fLesSD7TtjNkbVOoPtrLiCucHaAd5TEMADhPsASofug=;
        b=M/IywQoj7Fu4oAJ5HG/49UwaK16ozGNt5v0VPVDSRSUWYaQSgrA6T0sxXzfsEy4OJS
         6oMidpR2KqVXVVmzJEyjrYfFlpISH131kOlvf9t3Fx9SWPW8Wld+nQvqGlpLP7cK1//B
         AauPYnYpx08NTdDuj4TmNMxd0E2V/b9kWT5BCIdmWMkv5veq3LwEEEdiaTaNuJfLoFsN
         v+YaMe92aHfMwBSNdag94tbszvl6bIaobAcR7ycIGgsZn00lZkbkKhbDaDbcHpo/p65C
         HBtpFCaQKF38Q5OqkEsBW//y6gUhefyHWX/RTUItfAag53o4oSHmcKmSeHGurqyXW+uP
         fRWA==
X-Gm-Message-State: AOUpUlEMzBu0LP+OZFnp4I9aePMZ4WShdfQhhhO117zpH0k8s4Pe5v4j
        Fo4h4NCVb5KEpXL8NTl3gQwBRDa0Cd7d
X-Google-Smtp-Source: AAOMgpf9VPMdHuJrGtKFStj1HMRVEEM0QnutWAq5+EqMsy3egBkBIOgbadPuF/GrVolErkhqrTsSSb7crG1B
MIME-Version: 1.0
X-Received: by 2002:a5e:d811:: with SMTP id l17-v6mr7132047iok.91.1532991894030;
 Mon, 30 Jul 2018 16:04:54 -0700 (PDT)
Date:   Mon, 30 Jul 2018 16:04:43 -0700
In-Reply-To: <20180730230443.74416-1-sbeller@google.com>
Message-Id: <20180730230443.74416-4-sbeller@google.com>
References: <nycvar.QRO.7.76.6.1807301438440.10478@tvgsbejvaqbjf.bet> <20180730230443.74416-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 3/3] config: treat section case insensitive in store_aux_event
From:   Stefan Beller <sbeller@google.com>
To:     johannes.schindelin@gmx.de
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        peff@google.com, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a no-op because the section names are lower-cased already in
get_base_var, this is purely for demonstration that we do not need to
care about case issues in this part of the code.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 config.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index de646d2c56f..c247164ad17 100644
--- a/config.c
+++ b/config.c
@@ -2355,14 +2355,28 @@ static int store_aux_event(enum config_event_t type,
 	store->parsed[store->parsed_nr].type = type;
 
 	if (type == CONFIG_EVENT_SECTION) {
+		char *p;
+		int slen; /* section length */
 		if (cf->var.len < 2 || cf->var.buf[cf->var.len - 1] != '.')
 			return error("invalid section name '%s'", cf->var.buf);
 
+		p = strchr(cf->var.buf, '.');
+		if (!p)
+			/* no subsection, so treat all as section: */
+			slen = store->baselen;
+		else
+			slen = p - cf->var.buf;
+
+		if (slen > store->baselen)
+			slen = store->baselen;
+
 		/* Is this the section we were looking for? */
 		store->is_keys_section =
 			store->parsed[store->parsed_nr].is_keys_section =
 			cf->var.len - 1 == store->baselen &&
-			!strncmp(cf->var.buf, store->key, store->baselen);
+			!strncasecmp(cf->var.buf, store->key, slen) &&
+			!strncmp(cf->var.buf + slen, store->key + slen,
+				 store->baselen - slen);
 		if (store->is_keys_section) {
 			store->section_seen = 1;
 			ALLOC_GROW(store->seen, store->seen_nr + 1,
-- 
2.18.0.132.g195c49a2227

