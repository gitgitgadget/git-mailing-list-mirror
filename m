Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A4EC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243943AbiBWScQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243585AbiBWScJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:32:09 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF6F4B843
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:21 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i19so14277943wmq.5
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BE8pRQBi1xdCF9mnbjjcuFKiO+AGnnrTf1akRhh1Gvo=;
        b=bSXDAjWuyEujZNJ6elVW6ekW9pvViRm/bQL8nlb7eEFRhGIQ3PsDbF/LTrdVQh9LER
         0MGH7CftG2N2AtSAYMw32tNGuy+FsVH1Nc0wyN0rqCLTHv7Kjhn2jdbXOGVFp22L+OkS
         ODb/jp/RXgf05GtfJpwFFslVRTVa9fSsUbZTfTQQlpiMq3OK4b0M/qxgax/OTTxMAMeV
         Ziw1Fo6zeay2QVMN7275LG58MXoxeBlCLKtEP9yzegKxP22hAsIKGry3OwN4CJhrveHx
         koT+smUYB1gLH0KLeMFuYAPrf26WLzmk6wB8P+csOs5lFKIMLHlAUPsSlEnsOekDqyLp
         AlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BE8pRQBi1xdCF9mnbjjcuFKiO+AGnnrTf1akRhh1Gvo=;
        b=n4yozIeU0hMz9VMSl30iwixsmP81nH7l2BJ3P+05AYGXdU8GPmDpDSkcLPw6V95nxn
         ZX0QHAtVD4lFHArtDOTgblUuMjbb10/tOlRufMJRsxt/6gTFQJnbZZsRqaPuk7EORA4z
         eAA1bvsjTvXrV+qbbuQBntfiwIo/7vcpxAop8UVcPLDDDcrIyUAdG/3FG/HOi2GfdoZn
         QS/BTNP6R+OjJnH5b5meRWf5v0eB4nX9vUd0o5O3TditcQX2tqPpI8s6O/8UISXHSt0R
         I/ZrvXMnF7f4Uplnzmg5piLBYMxw9lGRLNN4nX+e9LlBZWQy3YitdSjiXn0bzPPm2Zdm
         tPLA==
X-Gm-Message-State: AOAM531XZuIGdbpHX4zEHi7c3okttB+zT+1KRr+1P+LJrUYeJkwyjTbm
        8pg/2WXWB4p4MF+UU/yl+NtS9UjNl28=
X-Google-Smtp-Source: ABdhPJxfntQh18FX1xsW4mIIiMNJ/VMHV+dJrpjnIvPrX7mRtzQVT+pehm+505LKqrLYMStLpLq5Tg==
X-Received: by 2002:a05:600c:21ce:b0:37c:526:4793 with SMTP id x14-20020a05600c21ce00b0037c05264793mr8655759wmj.120.1645641079440;
        Wed, 23 Feb 2022 10:31:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s7sm257603wro.104.2022.02.23.10.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:31:19 -0800 (PST)
Message-Id: <cdc81b2160ee4f5b98bc4eb24b0a933426eed494.1645641063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:30:52 +0000
Subject: [PATCH 14/25] clone: --bundle-uri cannot be combined with --depth
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, aevar@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change added the '--bundle-uri' option, but did not check
if the --depth parameter was included. Since bundles are not compatible
with shallow clones, provide an error message to the user who is
attempting this combination.

I am leaving this as its own change, separate from the one that
implements '--bundle-uri', because this is more of an advisory for the
user. There is nothing wrong with bootstrapping with bundles and then
fetching a shallow clone. However, that is likely going to involve too
much work for the client _and_ the server. The client will download all
of this bundle information containing the full history of the
repository only to ignore most of it. The server will get a shallow
fetch request, but with a list of haves that might cause a more painful
computation of that shallow pack-file.

RFC-TODO: add a test case for this error message.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/clone.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 6df3d513dc4..cfe3d96047a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -912,6 +912,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
+	if (bundle_uri) {
+		if (deepen)
+			die(_("--bundle-uri is incompatible with --depth, --shallow-since, and --shallow-exclude"));
+	}
+
 	repo_name = argv[0];
 
 	path = get_repo_path(repo_name, &is_bundle);
-- 
gitgitgadget

