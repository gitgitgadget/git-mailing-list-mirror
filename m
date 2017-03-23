Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9BAA20958
	for <e@80x24.org>; Thu, 23 Mar 2017 13:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932783AbdCWNHM (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 09:07:12 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32782 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752034AbdCWNHG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 09:07:06 -0400
Received: by mail-wr0-f196.google.com with SMTP id 20so3084996wrx.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 06:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NRzauk5W0c4i3AtDmB1tB3FNvj5mK7aRwx6rTnT6lcM=;
        b=bAg+OKBUcdBsl9VOtt9c1VQIoTz+C4NoBO+CzWtc3FtxQniTQBhQOVKbM4DH9JLfeg
         HE53IuVFLqB6nqOxcFPCtwpR4s85+vd1ve9Az5Si56FFyUdRjYmC/IlBHhtSsVyhnV4k
         KjlkK96DEl0mrAZpZkezqKOWRzqfFa/qaW3yvN5kP8+mZxStqIuN2wRh32iFMk4+M3y0
         AxTB8abYt2i9/x0OFmXsYMZNJ7PoZisR74kxERWni25X6qm+QjuxcaGQZ38mW3muHBdt
         Pe7b8xhRwdzmo0Lch6B97XenPqJkyiWFdiK8amsJKB2jdZ7k1qyvmR2N/n5E7CqQwRDO
         OM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NRzauk5W0c4i3AtDmB1tB3FNvj5mK7aRwx6rTnT6lcM=;
        b=FsGIptk6mrTA81lpQiRcrb78HrzvTUHwy0Cu85vG6hW5+tsu3hlXd0LwJPWALJZbu5
         /LDTenDthAgit/WuW1/PkJT3uXUOmM7s3aMb0OdyhnxMDPa3suwAkIOtgAM0YqQYBdiB
         w0eMt5MkhXV+It25jmWnufzGEaz82AvbMYcU+Dgjv6VmCHjq4lUK2M//Xc2nKb4gmTii
         8ia9Pv1LQzkYsxsh0C1EEDEHpyGzO8kyx0oMLP9PUmv/8B7ooUB8LQsv/t71VRSpxocW
         ngz14nz9cjWmGXoFgsxquIRgqae83p4lBGQZQmhjJxDmAZsmcUAIH2L762s65IBaKDa9
         cIYg==
X-Gm-Message-State: AFeK/H1MLtpa6lrWVqxi8kmDSMuUWk8L233iAQLg39mlOpJwDY2xTKQ7+f/UtTaCJ1wYOg==
X-Received: by 10.223.161.78 with SMTP id r14mr2575030wrr.101.1490274405479;
        Thu, 23 Mar 2017 06:06:45 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h3sm5810071wrb.6.2017.03.23.06.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2017 06:06:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 10/16] parse-options: add OPT_NONEG to the "contains" option
Date:   Thu, 23 Mar 2017 13:05:23 +0000
Message-Id: <20170323130529.11361-11-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170323130529.11361-1-avarab@gmail.com>
References: <20170323130529.11361-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the OPT_NONEG flag to the "contains" option and its hidden synonym
"with". Since this was added in commit 694a577519 ("git-branch
--contains=commit", 2007-11-07) giving --no-{contains,with} hasn't
been an error, but has emitted the help output since
filter.with_commit wouldn't get set.

Now git will emit "error: unknown option `no-{contains,with}'" at the
top of the help output.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/parse-options.h b/parse-options.h
index dcd8a0926c..9f48f554ba 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -258,7 +258,7 @@ extern int parse_opt_passthru_argv(const struct option *, const char *, int);
 	  PARSE_OPT_LASTARG_DEFAULT | flag, \
 	  parse_opt_commits, (intptr_t) "HEAD" \
 	}
-#define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, 0)
-#define OPT_WITH(v, h) _OPT_CONTAINS_OR_WITH("with", v, h, PARSE_OPT_HIDDEN)
+#define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, PARSE_OPT_NONEG)
+#define OPT_WITH(v, h) _OPT_CONTAINS_OR_WITH("with", v, h, PARSE_OPT_HIDDEN | PARSE_OPT_NONEG)
 
 #endif
-- 
2.11.0

