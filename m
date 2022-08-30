Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD70ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 18:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiH3SvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 14:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiH3Suv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 14:50:51 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440C04456C
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:35 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v16so12678359wrm.8
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=IZck1ZBApIc5FUkGzxG4wqWxnF4VcxRIyu7p+2Y8DMM=;
        b=Ia2c6PwnpJPPG9KdbbVmTE/IHauajmIlDIMocfge5cpQEy+XbRlXijW5ODMUOnrQ2J
         gEo+kqymNDb+qI/C3/RG4MfnV00LdM0lw5AJwLGcybvOIbT2ubHk0U0r763L3impUkJw
         GZkQTPkSAmej9PADK6TRWvWHAiO/V7o61a6SDxiz5Smui+nzCxXKPrhjEKU9G4yEQOMo
         BIJt9B/tf2pEn9A9pl7JIQ13eXFIYDFKsKEAabVSEjiECOEdw+h2nUD/H+tsxv4yGNrE
         lDXvNBFIAat9zFknZcxLC7bpq6InnW9tIPZOTpQmn9acxjlqq2uxcCwK8JUTnaRPg5HS
         fQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=IZck1ZBApIc5FUkGzxG4wqWxnF4VcxRIyu7p+2Y8DMM=;
        b=hIaGFgR+VezHTzj7B4s06B1qa/Ja2eWjYUYtvIISmtfhp7VAhmtmYV/pwuUH19y4bZ
         vpH9u1YAHb6KtrQb4mN2vL1yxOBpOBVcDYvipKj5LSEXpyH8bqQzl5cEULO3fjP9ZIAH
         19+YwysYLpdn6oTM335dG5uE/2wvtKWFyeDWVPYcSLEnv+4eYFHSiYDiZfyvTRjEwK8o
         g9d05ILxpQgYSeCMd3Lr120stbCErJDtaFbkmrJgoQEe3f1RMllDK5kN/5IRPgpAZfBg
         wTw5anlaem49Jo7Gklsv3zmNDo5tKzVONAgreSsZKjKwkwA42kNxJdkjeR+4WS7BTk6j
         SSmQ==
X-Gm-Message-State: ACgBeo28BOTQKDzzya3DIo12BBkE7U+UShOtgIR9pYsaJ5b5MfDyxUJ3
        UJt+Js8Dxkq5ytYQcjyy/4ACqBidX+M=
X-Google-Smtp-Source: AA6agR5x8/dEY1sqRBHFYMBvPnS06Ywh9pRfAh4rnnCuHgS1PZHh3zlwIRm66+77BAkrbZzW60lpEQ==
X-Received: by 2002:a5d:698e:0:b0:225:72d1:94c with SMTP id g14-20020a5d698e000000b0022572d1094cmr9448856wru.381.1661885433164;
        Tue, 30 Aug 2022 11:50:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20-20020a05600c15d400b003a331c6bffdsm12076474wmf.47.2022.08.30.11.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:50:32 -0700 (PDT)
Message-Id: <b202a0e386c91b0dbe4b1d27d55276e6e1d76587.1661885419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
References: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
        <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Aug 2022 18:50:13 +0000
Subject: [PATCH v6 10/16] bisect: avoid double-quoting when printing the
 failed command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We already quote the command via `sq_quote_argv()`, no need to enclose
the result in an extraneous pair of single-quotes.

Pointed out by Elijah Newren.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index ba4aa8059cb..05fe619c47c 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1390,7 +1390,7 @@ static int cmd_bisect_run(int argc, const char **argv, const char *prefix)
 
 		if (res < 0 || 128 <= res) {
 			error(_("bisect run failed: exit code %d from"
-				" '%s' is < 0 or >= 128"), res, command.buf);
+				" %s is < 0 or >= 128"), res, command.buf);
 			break;
 		}
 
-- 
gitgitgadget

