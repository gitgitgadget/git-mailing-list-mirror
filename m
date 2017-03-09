Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30CAC20135
	for <e@80x24.org>; Thu,  9 Mar 2017 01:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754793AbdCIBds (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 20:33:48 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36856 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbdCIBdr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 20:33:47 -0500
Received: by mail-pf0-f182.google.com with SMTP id o126so21877196pfb.3
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 17:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8dfcpuA/4fTYF3GbEKhH0mGOOGu8YDouatxqwXimUvo=;
        b=THwVstAkielMWDvVPShYj8Y493Byl0pJXKOyVkRAZBBIl1zXg7LJfQdve3uSa/DEMH
         RoV28fet2OVBVJkbihLEPIcCUCo8h9GviI+UBkSs6cQvHhq4zPwWAYZFfpuP3U+NFstE
         ZAsAqnc6+CC7GYZ32CilXsgNb2O1M8InRSA8e8k3Zgg4O6QlOMyxViGf0WPadIiebVoH
         f4nifWJuzEsQSbPfC6cySyESUlWRAaWXchHZGKKMmk/EJBe3pSw0dXQscdFZ3TY0FDr3
         yWxPNhHRlkkRKLcAgMkp4vzztse7CHeJU0XVcbOABCIZc8HqUimTaFoeendQ1dscW8wm
         2nBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8dfcpuA/4fTYF3GbEKhH0mGOOGu8YDouatxqwXimUvo=;
        b=aMvfDicAfkH9ZUDDwsax3mOl41EMfTAsDy0gHBeJkeoPS+IQ5YcdSLSUS+mbJvfEkt
         lxDI8ug93ELsfvi66Q27us06eDOHF1F+amVyffgZX0an85+5v5N/O2al30Shg56pJQDf
         3bgUrGo30IfthhVdHciUzUWvGKspZsKrMmaD6Y+4Jh80sF7VK5dovd/JG843cv8ax/pM
         /xhFVuqD7KT2Ygbt4ToLekOmvd2lyIuX9F1THaCaE4nRc97y3XiIKf6021nweSQVryDE
         Gru1i5mczPai1++0JyGbYDmHafngQoASKmQGjaK80RffkpPWsFZ8vUzXpmcy2i93YJpe
         hahA==
X-Gm-Message-State: AMke39mMPDp49dqmHVnc4wW0ExCxyyhbimeza3UGdZqARotcTZJqR4Ql86u/OpXFqStRacDs
X-Received: by 10.99.163.110 with SMTP id v46mr10317261pgn.171.1489022648868;
        Wed, 08 Mar 2017 17:24:08 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id l71sm8479948pga.7.2017.03.08.17.24.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Mar 2017 17:24:07 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v2 10/11] submodule--helper init: set submodule.<name>.active
Date:   Wed,  8 Mar 2017 17:23:44 -0800
Message-Id: <20170309012345.180702-11-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170309012345.180702-1-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
 <20170309012345.180702-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When initializing a submodule set the submodule.<name>.active config to
true to indicate that the submodule is active.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/submodule--helper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index bceb62a20..44f2c02ba 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -329,6 +329,13 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 		die(_("No url found for submodule path '%s' in .gitmodules"),
 			displaypath);
 
+	/* Set active flag for the submodule being initialized */
+	if (!is_submodule_initialized(path)) {
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "submodule.%s.active", sub->name);
+		git_config_set_gently(sb.buf, "true");
+	}
+
 	/*
 	 * Copy url setting when it is not set yet.
 	 * To look up the url in .git/config, we must not fall back to
-- 
2.12.0.246.ga2ecc84866-goog

