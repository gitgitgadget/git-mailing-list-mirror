Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5EDC433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCA9D6109D
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbhJ0MGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbhJ0MGw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 08:06:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D374C061745
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:27 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d13so3711194wrf.11
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uEWYiN3zMagJGskhmrwR0avZIR39YtJZYgnhZg5J5eg=;
        b=AClcxJxgzfc5CDFOjzpEBWEc/6Q/jxUPGK35QsK8kiNvzkx2hIHDbx7/t94v5BgxKZ
         hUqoxvTyWmQ0gjwHmj+RVJ9wwg/bIKXdNzvlAGQp/Nh6Q109jJsUMgCZtJfZ63je63Cy
         6QKsBIHQkhCNGr/+v10nrDnmibm+SOIbJiIRge3X2qHjNFAZolhxsyZPQXoZdxVHw3Hc
         E0/4CWYK1JTGsCg0Bp36uVp9Vv1Wbh+52jYQfHJPSVwPzwOXm2rafqphHR2zr5T0DXQh
         lc883oK+3ahXM/+f/2SGjmipa/i8vrhnp1Gme71CRtkotyohMbJLG5NPxXHXrAYSnwZx
         mh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uEWYiN3zMagJGskhmrwR0avZIR39YtJZYgnhZg5J5eg=;
        b=eMtppiL7PDgUWev/SZnfalMsXt8eRXZnHzVJwqLd6A8j+4y09CVsRGe7TL5EMUXczm
         nE/HPsbM/pFATZif2Lx6vQSrEalCj7+CbhquB2z5rTLj8m37GaW8XbguoT5CGOuh8Tad
         lkySPMs1qMmVtCqwHwGPnbbkzxpn+d2qcRjwtUvfGCyo6anqCYJ4/OqVOvH105PuMtaB
         GsDKc2/Dx4I778ZwwoAa90fhmfC0QLw8XVYJwCh3Fhyyr6qCj6okQCHvewi+hfq4xZ1c
         dJrTu5mJ1l9dkQV2jf2QaGkEnK1X/YhvonAwwAuwjTU9ipqk6sKybxMoZ2/ocSbRCx4W
         N0hg==
X-Gm-Message-State: AOAM533ocRjhAOrJ8k7WFuTPM5D+fU4a5v27o1I5Ls3gWawFH8MLZuat
        vob+Fr8gHUiYUziw8yOx69K4It41JYk=
X-Google-Smtp-Source: ABdhPJwneWwwWiE9Fhegzp6X6/PZa5wsRPiCwvVvUlVb2ScXHN86BsvgVAltT8jdrb2NdNxAh/QP9w==
X-Received: by 2002:adf:8bd0:: with SMTP id w16mr38735368wra.32.1635336265605;
        Wed, 27 Oct 2021 05:04:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p7sm21499522wrm.61.2021.10.27.05.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 05:04:25 -0700 (PDT)
Message-Id: <8fc8914a37b3c343cd92bb0255088f7b000ff7f7.1635336262.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
References: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
        <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 12:04:08 +0000
Subject: [PATCH v3 01/15] diff --color-moved: add perf tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add some tests so we can monitor changes to the performance of the
move detection code. The tests record the performance of a single
large diff and a sequence of smaller diffs.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/perf/p4002-diff-color-moved.sh | 45 ++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100755 t/perf/p4002-diff-color-moved.sh

diff --git a/t/perf/p4002-diff-color-moved.sh b/t/perf/p4002-diff-color-moved.sh
new file mode 100755
index 00000000000..ad56bcb71e4
--- /dev/null
+++ b/t/perf/p4002-diff-color-moved.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+test_description='Tests diff --color-moved performance'
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+if ! git rev-parse --verify v2.29.0^{commit} >/dev/null
+then
+	skip_all='skipping because tag v2.29.0 was not found'
+	test_done
+fi
+
+GIT_PAGER_IN_USE=1
+test_export GIT_PAGER_IN_USE
+
+test_perf 'diff --no-color-moved --no-color-moved-ws large change' '
+	git diff --no-color-moved --no-color-moved-ws v2.28.0 v2.29.0
+'
+
+test_perf 'diff --color-moved --no-color-moved-ws large change' '
+	git diff --color-moved=zebra --no-color-moved-ws v2.28.0 v2.29.0
+'
+
+test_perf 'diff --color-moved-ws=allow-indentation-change large change' '
+	git diff --color-moved=zebra --color-moved-ws=allow-indentation-change \
+		v2.28.0 v2.29.0
+'
+
+test_perf 'log --no-color-moved --no-color-moved-ws' '
+	git log --no-color-moved --no-color-moved-ws --no-merges --patch \
+		-n1000 v2.29.0
+'
+
+test_perf 'log --color-moved --no-color-moved-ws' '
+	git log --color-moved=zebra --no-color-moved-ws --no-merges --patch \
+		-n1000 v2.29.0
+'
+
+test_perf 'log --color-moved-ws=allow-indentation-change' '
+	git log --color-moved=zebra --color-moved-ws=allow-indentation-change \
+		--no-merges --patch -n1000 v2.29.0
+'
+
+test_done
-- 
gitgitgadget

