Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229C1C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353071AbiETSmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352996AbiETSlF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:41:05 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFE1340C4
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r23so12660040wrr.2
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ei13q35JnIP56MGW9+yGcMOJNWxzdwmSopfzDB7yags=;
        b=idM3y7Mk3oSyjxY+u92ahqDRemnhbHF0pBOQT4AQZGeLkgg74qaMCUTMV9OOGzOd+T
         CfZk+/HUaHwH7WhcY0DJIl3NO5g7M4FiEcyDM1WPzPTV3JbCv0V13FHqUG+UpoYBcXw+
         SZsx4+A6IBQfeuyHHa3DKcDC1jax6FcG4tiAvkVWxzUAzqB/r5JDWAsV+AusUsx12qxS
         bkhbaBfaawbSxgqlXlfAuTJDltyEs28iN+HCt3eKrBgz+jjFGJPTzclhH+EZUw3up/Dd
         12f9B5Pd7QDXY+X+xqGrKfCkKKrN7sAjaIpccKWJkxMQakLdGdUW551TTkCxcGqnm3q6
         aJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ei13q35JnIP56MGW9+yGcMOJNWxzdwmSopfzDB7yags=;
        b=5l27tuU2VfM4HmIQDpHw0Ofieq1loHFoC4X+m32e3txVQy4okICOs5Y5xtmguBvcW7
         d8W/AkgBvMw7+A9N55CUPNigMrbxQzp9p6Eki4FCiwWslP4kuYWFY0SzziNjOrK+iUj+
         dkxQS+dhOLufvKBlJ5E2RQ1/a+pBtG2SSnx7xJZ9ei0YAvQgfLT3EUAKb6DPqCuDRMxC
         VUmiPE6eV9DNrT283pzd4+OSNbuwZub4wWoifc+rv73/qAI0bZzipy7DjcL6tXEaGpq4
         DYAdejEeHju8NqNkRXqcY7uTymkVEsOjEF1oBOL9bYLQ/gvdJbwsZUXMNlC5/upcbhsc
         liXw==
X-Gm-Message-State: AOAM533qIbllcXPlz8ecmnnXco/g3NruwbzH7hKJoNRe1qGrq3wtUA+s
        tUAT0G5NVYn7MgYvsA4SwErwl+IkPJE=
X-Google-Smtp-Source: ABdhPJwW/zDKY2K927SXAwZxQRgh5VazRX5kfPvlLORanCyA2hGdIzjfLdceVi1YsfW4aNC8OPr67A==
X-Received: by 2002:adf:ae09:0:b0:20e:e4f0:2133 with SMTP id x9-20020adfae09000000b0020ee4f02133mr3536429wrc.104.1653072053210;
        Fri, 20 May 2022 11:40:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c12-20020adfa70c000000b0020e0b9487besm2977697wrd.109.2022.05.20.11.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:40:52 -0700 (PDT)
Message-Id: <333180f80904a2a0675bfa65fab62107fa13b2a9.1653072042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
References: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 18:40:26 +0000
Subject: [PATCH 08/24] clone: --bundle-uri cannot be combined with --depth
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Teng Long <dyroneteng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
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
index fd1ae82e57b..a9caa5dfed6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -926,6 +926,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
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

