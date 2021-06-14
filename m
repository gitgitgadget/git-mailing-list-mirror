Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9C6C48BE8
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 13:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C4D6128B
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 13:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbhFNNH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 09:07:57 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:46062 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbhFNNH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 09:07:56 -0400
Received: by mail-wr1-f49.google.com with SMTP id z8so14481459wrp.12
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 06:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=C2fhi4sGIwCd6f3bzXoZbauTUlLHF9Dc66GIKqv4YcA=;
        b=dv9Cv8eGhHAzryKh2Zqg14RDjXgHrl+S+YiC/M5TIJBgUf+RnfAY/UWfpU8yxc88PN
         AxPpKbrQZ3dNr2A3FVpiMBxrdEipdnxcuITnsLULLoDic+PV43QlZZcalfBY61MhKtci
         2/9XkVo7PiwIoUANjcxXNNpTMyzL51qCKlsIHnNcl8uzr/dKgurlj/ytccnjaLt8ZWKQ
         XRm1OI7KPkH6QkBcl6AA9eLJv/W4WOXsc63L6yqFAwv0NIGRi2tMciSL8yYY4Ij/e9z5
         45N7jOjqT2V8mdLQd9NlXNPBU1MyDGDfYiWdVWcqFvZVaIr+BABcCgS2sY7Elstosyhu
         JTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=C2fhi4sGIwCd6f3bzXoZbauTUlLHF9Dc66GIKqv4YcA=;
        b=uYg2stiehwbwsTylDJ21pFR9752aXDNpK+2sOyZG2nn2HrIvTKzKfXK63ruARdBReB
         btTXE0YbZKXK+BK+yqMiyn5IoiAjHfGAxhchaAGuOExNYRoeAczpK4jIOo2Xp3ESHEem
         wCYUNlk3dlcsXG/V82iUeJmgLDcM1Q7Tz7ydbpLAk9bDF4WC6SF2L9Z7QxWsHLmvQLNy
         eMXu9YWWv8X3UlwMOogJvZgJHWpgoNcv1QKLAD1nMAxd/4ApLWbOdEypdeN4XFGK+P8v
         ks9LCsjJIgp47U2/Er4CudrFn1UTo+hhQDOkVhM/Cr9v5w5SVSufPlTKegE8XOrjh+hF
         aOzA==
X-Gm-Message-State: AOAM531z0NmRKojSmEFJfLflAi9zAUz8pOdDc1Y63pcPcOIDaGB+QDIr
        imMxsuAs1it8CP6AOXWTyXRYo8ntHfc=
X-Google-Smtp-Source: ABdhPJzhwhmBbutsAGHNhQs9C6/n1/CjG3v19tVpHHVXKuLrx6Zbj5pWIIlFvZMGsSw9cXQQFoURcA==
X-Received: by 2002:a05:6000:1888:: with SMTP id a8mr18335583wri.11.1623675893405;
        Mon, 14 Jun 2021 06:04:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g23sm18492319wmk.3.2021.06.14.06.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 06:04:53 -0700 (PDT)
Message-Id: <cec0c2d04d704a0b969eda13a1c1858a7ba6fbc0.1623675889.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.git.1623675888.gitgitgadget@gmail.com>
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Jun 2021 13:04:43 +0000
Subject: [PATCH 05/10] diff --color-moved: call comparison function directly
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Calling xdiff_compare_lines() directly rather than using a function
pointer from the hash map reduces the time very slightly but more
importantly it will allow us to easily combine pmb_advance_or_null()
and pmb_advance_or_null_multi_match() in the next commit.

Before this change
Benchmark #1: bin-wrappers/git diff --diff-algorithm=myers --color-moved --no-color-moved-ws v2.28.0 v2.29.0
  Time (mean ± σ):      1.136 s ±  0.004 s    [User: 1.079 s, System: 0.053 s]
  Range (min … max):    1.130 s …  1.141 s    10 runs

After this change
Benchmark #1: bin-wrappers/git diff --diff-algorithm=myers --color-moved --no-color-moved-ws v2.28.0 v2.29.0
  Time (mean ± σ):      1.118 s ±  0.003 s    [User: 1.062 s, System: 0.053 s]
  Range (min … max):    1.114 s …  1.121 s    10 runs

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 5d5d168107a6..c8fdfc9049bb 100644
--- a/diff.c
+++ b/diff.c
@@ -995,17 +995,20 @@ static void add_lines_to_move_detection(struct diff_options *o,
 }
 
 static void pmb_advance_or_null(struct diff_options *o,
-				struct moved_entry *match,
-				struct hashmap *hm,
+				struct emitted_diff_symbol *l,
 				struct moved_block *pmb,
 				int pmb_nr)
 {
 	int i;
+	unsigned flags = o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;
+
 	for (i = 0; i < pmb_nr; i++) {
 		struct moved_entry *prev = pmb[i].match;
 		struct moved_entry *cur = (prev && prev->next_line) ?
 				prev->next_line : NULL;
-		if (cur && !hm->cmpfn(o, &cur->ent, &match->ent, NULL)) {
+		if (cur && xdiff_compare_lines(cur->es->line, cur->es->len,
+						l->line, l->len,
+						flags)) {
 			pmb[i].match = cur;
 		} else {
 			pmb[i].match = NULL;
@@ -1154,7 +1157,7 @@ static void mark_color_as_moved(struct diff_options *o,
 		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
 			pmb_advance_or_null_multi_match(o, l, pmb, pmb_nr);
 		else
-			pmb_advance_or_null(o, match, hm, pmb, pmb_nr);
+			pmb_advance_or_null(o, l, pmb, pmb_nr);
 
 		pmb_nr = shrink_potential_moved_blocks(pmb, pmb_nr);
 
-- 
gitgitgadget

