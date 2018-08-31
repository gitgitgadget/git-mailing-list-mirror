Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 759241F404
	for <e@80x24.org>; Fri, 31 Aug 2018 08:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeHaMkm (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 08:40:42 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35021 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbeHaMkm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 08:40:42 -0400
Received: by mail-io0-f195.google.com with SMTP id w11-v6so9818190iob.2
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 01:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ff+wa9x+cEniCAE+yMNQb1J7s5hE/v/LDU+2+XRGgWI=;
        b=u3knTGtRrUl2N/2gThhOgiPPQQVtoVoIGSajuhqIWj1EMPtejEQYICwN9J+NnNHStZ
         3l//Hhnjtueho3NREbllty8XzkEQvB5Z9/NF7xLyMPCxmjudrCNyLFILpQOIf7HgMw66
         vkglCiM/Uw3e3eW0vgyxcREe/daO3fexANM7SyNi1PslVAQkTWAixslgGV6NLSwg38+I
         fzHcnuiNWharrVm1ny99fCngT4gPAhxaAX7HM4x3yCnllGnTMvVEPKrU9svrVjMt7MbE
         1uC5yluSq/2icUx7HSdh8HxpdUI/pZ1CDnrvtiCuKmW+fNF7cL23uqt3MRtxiuE0AFFf
         pzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ff+wa9x+cEniCAE+yMNQb1J7s5hE/v/LDU+2+XRGgWI=;
        b=BhlPnlhXXhoE6lFAOx9XvA8qUREEQHGqvlGjbAweSM8NEHO1J3kuKAgsGfLQ8/iGGC
         wyPJobjKVo6Ag+im/kvAUfkKbDtynyAfrSGzEJyui48XXQLr71BSRETbjrPoqET/XQJQ
         S5WmdW6d4YNRNMQ432yYU45d4JHNJxPjxzCVMVZ6C0scjOv0GDxRaJ8qvCLDOuLhk2wV
         BHj3XRVnvga+s6br6SMekfn5857CGw1IzDfRP2kNtwyYlUaTdUAMlAXPvwEE98Exk5Du
         X/38kiq26UCd0Hti5NxYZI1bymr+7aGQEN0DZkkY9dq6+n0cGOKkzSu4ybFlKeGdUaSu
         BWyQ==
X-Gm-Message-State: APzg51ByxDX3T5BO+U1Tsy83lCIFbafagXjjdMAJd63ZUP3CAjFJWReu
        2WbicTBzrXRh2gJxiUBIvh5zVJmS
X-Google-Smtp-Source: ANB0VdZPR3t8uexs5ANDlcCQVt2UlLPV53aH2+7DlRayOMX88pwGobRUYOQwYKn1lrP8C3c1pHa/Iw==
X-Received: by 2002:a6b:c995:: with SMTP id z143-v6mr11807615iof.266.1535704461142;
        Fri, 31 Aug 2018 01:34:21 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id n198-v6sm2071313itn.36.2018.08.31.01.34.20
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 31 Aug 2018 01:34:20 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] config.mak.uname: resolve FreeBSD iconv-related compilation warning
Date:   Fri, 31 Aug 2018 04:33:42 -0400
Message-Id: <20180831083342.34836-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.19.0.rc1.352.gb1634b371d
In-Reply-To: <20180805075736.GF44140@aiede.svl.corp.google.com>
References: <20180805075736.GF44140@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

OLD_ICONV has long been needed by FreeBSD so config.mak.uname defines
it unconditionally. However, recent versions do not need it, and its
presence results in compilation warnings. Resolve this issue by defining
OLD_ICONV only for older FreeBSD versions.

Specifically, revision r281550[1], which is part of FreeBSD 11, removed
the need for OLD_ICONV, and r282275[2] back-ported that change to 10.2.
Versions prior to 10.2 do need it.

[1] https://github.com/freebsd/freebsd/commit/b0813ee288f64f677a2cebf7815754b027a8215b
[2] https://github.com/freebsd/freebsd/commit/b709ec868adb5170d09bc5a66b18d0e0d5987ab6

[es: commit message; tweak version check to distinguish 10.x versions]

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This is a follow-up to [1] which encapsulates Jonathan's proposed change
as a proper patch. I made Jonathan as the author since he did all the
hard research and formulated the core of the change (whereas I only
reported the issue and extended the version check to correctly handle
FreeBSD 10.0 and 10.1). Jonathan's sign-off comes from [1].

[1]: https://public-inbox.org/git/20180805075736.GF44140@aiede.svl.corp.google.com/

 config.mak.uname | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 2be2f19811..e47af72e01 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -192,7 +192,17 @@ ifeq ($(uname_O),Cygwin)
 endif
 ifeq ($(uname_S),FreeBSD)
 	NEEDS_LIBICONV = YesPlease
-	OLD_ICONV = YesPlease
+	# Versions up to 10.1 require OLD_ICONV; 10.2 and beyond don't.
+	# A typical version string looks like "10.2-RELEASE".
+	ifeq ($(shell expr "$(uname_R)" : '[1-9]\.'),2)
+		OLD_ICONV = YesPlease
+	endif
+	ifeq ($(firstword $(subst -, ,$(uname_R))),10.0)
+		OLD_ICONV = YesPlease
+	endif
+	ifeq ($(firstword $(subst -, ,$(uname_R))),10.1)
+		OLD_ICONV = YesPlease
+	endif
 	NO_MEMMEM = YesPlease
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
-- 
2.19.0.rc1.352.gb1634b371d

