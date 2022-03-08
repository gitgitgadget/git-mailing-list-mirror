Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DFAC433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 14:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347590AbiCHOkx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 09:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347573AbiCHOkg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 09:40:36 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8320439169
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 06:39:33 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id x15so28863315wru.13
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 06:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kfEW0dk/GJsWNlzL6rW1CD5ocGSfZpxQ5GeCl6aCtPw=;
        b=ctXRrc1trZnbASvvbunink1LUkAA7FV9V/R652DbdfqrOwBZXLlTLT6pNHvjeTJ6Xy
         QAIz1FdQkvF8uBa60k4DGrNbzZx5xHXJuWd48adrZf0j2PU7W5UbPWX8f9szHqLWklMX
         YGeCxpO+x74qmph1w5TFx1hZvLBaK6KwmCT/gcy1etkAF2OxHk26s9iMLh1NHY1lwbaS
         1gxuuB/7G8ZG1U+/2dKJvZYdTZDWzG0vhxzkL1azIcd2TZ9Jg8IABXysNE6c+GoGnAJ9
         m+68/5Vp3x+XA4a2euNL0lKwywHiJTT/9NvZeTsvz2hfR9jOh0+48F8CzF9cYCT/7ljj
         TglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kfEW0dk/GJsWNlzL6rW1CD5ocGSfZpxQ5GeCl6aCtPw=;
        b=mURqmewzYOH0jBAOkWoBcTRkVuOqLryRisSjH7QTjcTt0zqqKvU04k11qHVbdMfTdV
         x5BePp53Fq3+/c3PRFK6y2fBwi/wSRKFrPNJdlLHp3HWONZIqYyWbbMBEWv/AZHD3nDR
         4/qPBjQJ+OZTIDapHHH/2WOHfj2kXaE2Zo0qAT4E9Ce/CJqTOvExBIglVejX5abxvdgK
         EcO9q8Cgahd6yYS0yNsChaZuvq4Yk7hql3W1MhWYl5GXFgAZLRmMzC+ihKPvOqugDLR4
         Qaats0kswKZuRyP635DK7mnzXUO56NN2myR3fVYyK0u9KESBditpDKsTWQZLy0s6+TeV
         yV+A==
X-Gm-Message-State: AOAM530mR50UfufZUEHwbgqEgYyTBVbOqwwDgw79EcS5Ikq3Zzv1pr43
        S9+9AGOjzNuzKeBWHQGl29RjTtDVDj0=
X-Google-Smtp-Source: ABdhPJzMY6eP1um0RbTudrnozcrIXx2+A+2q7/JHq5gSJSrWG6vzKYY+W0ziyLlQBCUFF2yvhtTwuA==
X-Received: by 2002:a05:6000:10c2:b0:1f1:e43d:c979 with SMTP id b2-20020a05600010c200b001f1e43dc979mr12049353wrx.671.1646750371710;
        Tue, 08 Mar 2022 06:39:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k18-20020adfe8d2000000b0020294da2b42sm3689688wrn.117.2022.03.08.06.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 06:39:31 -0800 (PST)
Message-Id: <805e1d1172210c6a39b33edcb2cd6d21b754f821.1646750359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
References: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
        <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 14:39:19 +0000
Subject: [PATCH v3 12/12] clone: fail gracefully when cloning filtered bundle
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Users can create a new repository using 'git clone <bundle-file>'. The
new "@filter" capability for bundles means that we can generate a bundle
that does not contain all reachable objects, even if the header has no
negative commit OIDs.

It is feasible to think that we could make a filtered bundle work with
the command

  git clone --filter=$filter --bare <bundle-file>

or possibly replacing --bare with --no-checkout. However, this requires
having some repository-global config that specifies the specified object
filter and notifies Git about the existence of promisor pack-files.
Without a remote, that is currently impossible.

As a stop-gap, parse the bundle header during 'git clone' and die() with
a helpful error message instead of the current behavior of failing due
to "missing objects".

Most of the existing logic for handling bundle clones actually happens
in fetch-pack.c, but that logic is the same as if the user specified
'git fetch <bundle>', so we want to avoid failing to fetch a filtered
bundle when in an existing repository that has the proper config set up
for at least one remote.

Carefully comment around the test that this is not the desired long-term
behavior of 'git clone' in this case, but instead that we need to do
more work before that is possible.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/clone.c        | 13 +++++++++++++
 t/t6020-bundle-misc.sh | 12 ++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 9c29093b352..623a5040b1c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -33,6 +33,7 @@
 #include "packfile.h"
 #include "list-objects-filter-options.h"
 #include "hook.h"
+#include "bundle.h"
 
 /*
  * Overall FIXMEs:
@@ -1138,6 +1139,18 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		warning(_("--local is ignored"));
 	transport->cloning = 1;
 
+	if (is_bundle) {
+		struct bundle_header header = { 0 };
+		int fd = read_bundle_header(path, &header);
+		int has_filter = header.filter.choice != LOFC_DISABLED;
+
+		if (fd > 0)
+			close(fd);
+		bundle_header_release(&header);
+		if (has_filter)
+			die(_("cannot clone from filtered bundle"));
+	}
+
 	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
 
 	if (reject_shallow)
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 42e8cf2eb29..5160cb0a75c 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -537,4 +537,16 @@ do
 	'
 done
 
+# NEEDSWORK: 'git clone --bare' should be able to clone from a filtered
+# bundle, but that requires a change to promisor/filter config options.
+# For now, we fail gracefully with a helpful error. This behavior can be
+# changed in the future to succeed as much as possible.
+test_expect_success 'cloning from filtered bundle has useful error' '
+	git bundle create partial.bdl \
+		--all \
+		--filter=blob:none &&
+	test_must_fail git clone --bare partial.bdl partial 2>err &&
+	grep "cannot clone from filtered bundle" err
+'
+
 test_done
-- 
gitgitgadget
