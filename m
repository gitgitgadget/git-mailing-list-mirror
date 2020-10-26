Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1341EC4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 16:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C741B241A4
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 16:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkFEPbKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785032AbgJZQJY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 12:09:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52926 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1785022AbgJZQJY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 12:09:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id c194so12235017wme.2
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 09:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KQ/Om1iJNa++UOs6ipGuMhVM81spY9yADMMzBFismRs=;
        b=UkFEPbKrM21h6vEIme2BuyGyOjUZHhnt4g719mNM2Dn4czpIR5jY7NKaVpfkvKayFo
         IO53CfdrycD952jowHAWdD4IW/xhoEq/Xp/zkSjP/WZ1bErkLOaggN2WX5C0M4pOlx36
         7pGNiVQTc5njGwgFvr3zTwlZXZOR4NI0Mh52f9q7LKO2M5UaTqJdda3XHXaIAOavQXjr
         f7fRztv3lzhsc+sPFhfxRu2TyX0RDg+dkd9DOpXJVJP1cZOolQ2Cg9W0bfNDPTxqRicf
         NK30+5+z42hVxE5DaejoPRV0unwgoNUK2qhaLegxsgWYCEoRe6ulh2VCa3ucYuS9xBUu
         +RNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KQ/Om1iJNa++UOs6ipGuMhVM81spY9yADMMzBFismRs=;
        b=L7URBveVGgCvxXc8l02KfZqRITGduut/qmKc7808AYgkxY8KPktHbgt7q3YX/KmbKb
         Y+3rSO2PirVg426TFXlBr3HjA4hBdZ41pS5VifPkavka3I5jrxqf42Rv5/wbVvIRvcWQ
         o0YgN+NIu/blp3BLzaQ8CqQYWN+KJakcZJ92hOc1CHYbakg2mfRK8HWcukEujyexkf3J
         /1GAtWK6EdP6IaID0H07DDq6awaoGAaXjnXJSNrjbDAXSacfIOgXb+YEa8eREua8+Hhe
         LkQPUdjR6LZjH5o5XVQSXYUPDrHdsNQRCxJvlhZR+PQfT4HcuQhtGKYMq4Pin2QXy7pJ
         tMVA==
X-Gm-Message-State: AOAM531O9ThlWWyvxcvVEkiQ9hw55Qp8QzZ4phl34mGaAxc1sn17O5ij
        N6POPi72yBh8hTLv8NrZaX4OPegIPOI=
X-Google-Smtp-Source: ABdhPJxoDJ6htJO7w0r5lmNzG/guuaZpNEeyLvjrRA7GI/a0ibQIYSvsUgJ9wEDaa265y/pzKwEcpQ==
X-Received: by 2002:a1c:cc01:: with SMTP id h1mr17648201wmb.114.1603728558583;
        Mon, 26 Oct 2020 09:09:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t19sm19526065wmj.42.2020.10.26.09.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 09:09:18 -0700 (PDT)
Message-Id: <9ffcc5b78e358d0ed4da2c52ba87174dc94e544c.1603728555.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.753.v3.git.1603728555.gitgitgadget@gmail.com>
References: <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
        <pull.753.v3.git.1603728555.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 16:09:15 +0000
Subject: [PATCH v3 2/2] sideband: report unhandled incomplete sideband
 messages as bugs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It was pretty tricky to verify that incomplete sideband messages are
handled correctly by the `recv_sideband()`/`demultiplex_sideband()`
code: they have to be flushed out at the end of the loop in
`recv_sideband()`, but the actual flushing is done by the
`demultiplex_sideband()` function (which therefore has to know somehow
that the loop will be done after it returns).

To catch future bugs where incomplete sideband messages might not be
shown by mistake, let's catch that condition and report a bug.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 pkt-line.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 844c253ccd..657a702927 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -471,6 +471,9 @@ int recv_sideband(const char *me, int in_stream, int out)
 			write_or_die(out, buf + 1, len - 1);
 			break;
 		default: /* errors: message already written */
+			if (scratch.len > 0)
+				BUG("unhandled incomplete sideband: '%s'",
+				    scratch.buf);
 			return sideband_type;
 		}
 	}
-- 
gitgitgadget
