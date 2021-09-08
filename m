Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EF8C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 22:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B170260F5B
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 22:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbhIHWSb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 18:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbhIHWSa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 18:18:30 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A752CC06175F
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 15:17:21 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x6so5427817wrv.13
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 15:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/dfmxcYqlIsu/UwkRYNcSZeZirrrF6otX0QawEmFTYM=;
        b=rlgwuSPgztx3CGFQX1o540LAl06HU3YrBLbY7G2KGQrifRcz4jpWaEOahjsVGBnCOd
         9eRRdby2J+OgZ+EzHmIONkZuwqtJEhNXT43JnFC6mHWWCZK5LX0Uwf16XbIIvoAeZ+iJ
         4Rubjx2ntDmNamnLaV9YoudbVrknshuW2f6dmQXtwxJe4VaOHzqw857YK7CiqUKItkkp
         tAmY4jXZVAs0Rjl3IPEJKiBeapTPpRLkl8cg4j7CVUxHgHAXJKBFYZuWD+EcmPkdUepl
         36wdU4AoQ6Zxm/Drf19sNnoi2ebq/6ShoPojAqZ/8pZCUD52oOBYUfjHslncKQ83mq6x
         V8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/dfmxcYqlIsu/UwkRYNcSZeZirrrF6otX0QawEmFTYM=;
        b=hYzVf7/G5ovq2sGBGlju0806Ur+r0nAey99T/UbUaEWw7b053GcM2bWJhzEIAsMyOv
         vD3rHbUn/pzi3uBYYm8gApwOtsXiHWPS8gMmNYctZy9rxoaYYmAu95xHQl+fowrHBwnM
         I2N5dqzXOtSbUz8EQIPM0Hb444sxakEZ3QAqAYbtuV8ryAphZV4MgwNI/SrQwYOdESP6
         BcvkxdtmoClpFZ/5teOA31BpOxfCkE4vzSri3CCEKb2of4iwSYgMo3dQHb6uZTB4akL+
         zgm1za9nRK9VIcQCbSu/SxpSseTSA3gcBqlqeTRHBwuBIhTE+0WaAcXKrfLHVBvWpT4Y
         2vpA==
X-Gm-Message-State: AOAM530zZ0sWP/TB91BM8QwFBYaPhj/UxNc8hoaUPgStHl3LwA01lUDP
        e6iSJcspUEFymW9QISYjMgzESZV+OQp2hqf4
X-Google-Smtp-Source: ABdhPJxHR37txFP8aupqY2lj/Sef1TFcbnfUC/Vx897Z1nY7+N2zUy49T71/i178pLyjrfCzWu0vPA==
X-Received: by 2002:adf:c18d:: with SMTP id x13mr526060wre.380.1631139440015;
        Wed, 08 Sep 2021 15:17:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v10sm380197wrg.15.2021.09.08.15.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 15:17:19 -0700 (PDT)
Date:   Wed, 8 Sep 2021 18:17:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, gitster@pobox.com
Subject: [PATCH v2 1/3] pack-write.c: rename `.idx` files into place last
Message-ID: <cb3a8439943635d52bc15693d71c355f96b6219a.1631139433.git.me@ttaylorr.com>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631139433.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631139433.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We treat the presence of an `.idx` file as the indicator of whether or
not it's safe to use a packfile. But `finish_tmp_packfile()` (which is
responsible for writing the pack and moving the temporary versions of
all of its auxiliary files into place) is inconsistent about the write
order.

But the `.rev` file is moved into place after the `.idx`, so it's
possible for a process to open a pack in between the two (i.e., while
the `.idx` file is in place but the `.rev` file is not) and mistakenly
fall back to generating the pack's reverse index in memory. Though racy,
this amounts to an unnecessary slow-down at worst, and doesn't affect
the correctness of the resulting reverse index.

Close this race by moving the .rev file into place before moving the
.idx file into place.

While we're here, only call strbuf_setlen() if we actually modified the
buffer by bringing it inside of the same if-statement that calls
rename().

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-write.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index f1fc3ecafa..277c60165e 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -490,18 +490,18 @@ void finish_tmp_packfile(struct strbuf *name_buffer,
 
 	strbuf_setlen(name_buffer, basename_len);
 
-	strbuf_addf(name_buffer, "%s.idx", hash_to_hex(hash));
-	if (rename(idx_tmp_name, name_buffer->buf))
-		die_errno("unable to rename temporary index file");
-
-	strbuf_setlen(name_buffer, basename_len);
-
 	if (rev_tmp_name) {
 		strbuf_addf(name_buffer, "%s.rev", hash_to_hex(hash));
 		if (rename(rev_tmp_name, name_buffer->buf))
 			die_errno("unable to rename temporary reverse-index file");
+
+		strbuf_setlen(name_buffer, basename_len);
 	}
 
+	strbuf_addf(name_buffer, "%s.idx", hash_to_hex(hash));
+	if (rename(idx_tmp_name, name_buffer->buf))
+		die_errno("unable to rename temporary index file");
+
 	strbuf_setlen(name_buffer, basename_len);
 
 	free((void *)idx_tmp_name);
-- 
2.33.0.96.g73915697e6

