Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD49C2D0A3
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DE7122280
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UoCnKZCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgKBWbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 17:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgKBWbW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 17:31:22 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499A0C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 14:31:22 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id z9so9203514qvo.20
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 14:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=8EmPdbNGLatWhx+M1mauicW758Nhpdi0kjChavoMEKk=;
        b=UoCnKZCXpPOLgITobEbYZD8NkySsCwhb/HBcC/SHfcUEIH1pdKn3m2UzC7uzhuiGNc
         72LMBdcBXH0mTjPtFrAe98MO2nL41yTgHHYZzhrJcEPF32KC8wKkPTgNQNPpfg5Wj8Ac
         JkDmKzkIrnmuAE40MJoZqTC5I+dLbtrbXWV8Mb0WXOMJcf/hqvq3MVjO6TYnwhSZJRaT
         GvMJybbqTsSQ6boY/Ff+6CRxuP8MFTdsWfbubvwA/x/K+0MIMBZdb56PwJ2DS2Ek+ljF
         NqI6F7LnuDqonrHVuyHal/E7LW8tUsVBXE3QiQh22EE96FPMdRQWXz3dc+Tt/STLDrN7
         7qcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=8EmPdbNGLatWhx+M1mauicW758Nhpdi0kjChavoMEKk=;
        b=EKX5vke9fJELICdCISgwwBk+f4RmL+ItuqX+7icBLi3KzTqO1Pz5wVFWvQbEJmAhCI
         b+qUlw26/rHSg8uF284pccB7OKsgP2g+omrTQy2NEf+EZWl0dYYWEcPsU8FTQFrK9mk3
         +L2toTrGCfSShvWKRySw8aBV6izKYhN7un+HJ5dNMVYwcx5lAz8BqfFnxdpiNcjTjTn/
         fikh16Bli9pFHdzQLr5mDtXXpt/swOr8ExJQtxU4XcujBUMYV57U6SMaU30jXlUgMnuD
         U7Is158ciSJ47xK3WnX/lmKeZLFaGx963oZ8oAswhFbNYjy0snnFM17LUNDq1kJwAahc
         OKRw==
X-Gm-Message-State: AOAM5332XOXw1YEBhehPYd8zyK3y4yYzPd27wlSOwEXTLoTZwPPvYpUG
        2Y70y+9fWDfdHPlZlCh/km1IQuhSuC9AAHtcsMoEgJ0jH+1s2ucTyKUWcfN/QKZLoCva1mbJJue
        jsCvgEq6JCHrvgQ3vbRgb91umphzE7Myp/vzVILMyEe3CHkAAvisoiWD5bWB838Y=
X-Google-Smtp-Source: ABdhPJyKr0Qf6Z26hpu65jVALYn9lMsQZwJJmLonX57dmylkpBwMPhB71/+6VPDDmjgdN8buuyLF7iuOOgxI0Q==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a05:6214:18cf:: with SMTP id
 cy15mr24918021qvb.53.1604356281376; Mon, 02 Nov 2020 14:31:21 -0800 (PST)
Date:   Mon,  2 Nov 2020 14:31:03 -0800
In-Reply-To: <cover.1604355792.git.steadmon@google.com>
Message-Id: <7003189c81b7642922eb73bac9b2a688c014a8bb.1604355792.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com> <cover.1604355792.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v2 05/11] receive-pack: advertise trace2 SID in v0 capabilities
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When trace2 is enabled and trace2.advertiseSID is true, advertise
receive-pack's trace2 session ID via the new trace2-sid capability.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 builtin/receive-pack.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index bb9909c52e..2fe5a8b4fd 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -54,6 +54,7 @@ static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int advertise_atomic_push = 1;
 static int advertise_push_options;
+static int advertise_trace2_sid;
 static int unpack_limit = 100;
 static off_t max_input_size;
 static int report_status;
@@ -248,6 +249,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "trace2.advertisesid") == 0) {
+		advertise_trace2_sid = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -268,6 +274,8 @@ static void show_ref(const char *path, const struct object_id *oid)
 			strbuf_addf(&cap, " push-cert=%s", push_cert_nonce);
 		if (advertise_push_options)
 			strbuf_addstr(&cap, " push-options");
+		if (advertise_trace2_sid && trace2_is_enabled())
+			strbuf_addf(&cap, " trace2-sid=%s", trace2_session_id());
 		strbuf_addf(&cap, " object-format=%s", the_hash_algo->name);
 		strbuf_addf(&cap, " agent=%s", git_user_agent_sanitized());
 		packet_write_fmt(1, "%s %s%c%s\n",
-- 
2.29.1.341.ge80a0c044ae-goog

