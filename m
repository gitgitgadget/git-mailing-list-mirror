Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B6A61F462
	for <e@80x24.org>; Sat, 15 Jun 2019 00:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfFOAmP (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 20:42:15 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:45632 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfFOAmP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 20:42:15 -0400
Received: by mail-pl1-f201.google.com with SMTP id y9so2536715plp.12
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 17:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1zFD6YFt8Rea+rRBPnsW2o/r1D/zcHJbHj9HyztpWwI=;
        b=PmuQ59yiBStWTNsyeD4joAAPtv6QhE2+crVJnHPCzkw7mxGordfutTJIllzLTQYLqO
         M4FtOxSO2+PDAB/nDDQuphnDEuodkRSv5WFWEXHII6ZVd0EzLqReR13T7z/Lo9bsKXwX
         +Xmx38ZK2e6UDFWs6LrImzalr7mAMxBlmtURFDaFH1bb7cSd/IFdaQpAEoFMjV5WX5me
         ZU1zVSGnHD02hi0OlCm2Dn6ScF6/ZFdRaTmxUuaG6ao0YbBpOO4Oq9swiVANfuhmAGnA
         wvTS1ltO2NXMVVH2oWcH+wfri/GQQM0axgrbFBJvf9ArtozEDC44/WujpRm1DbHDPmI5
         ZL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1zFD6YFt8Rea+rRBPnsW2o/r1D/zcHJbHj9HyztpWwI=;
        b=cCZ3cta1xp6NffklTyPsdRPT0IbgTdYWg2O05LlDHT/4/0IqYmAERgRq7JFpXO4vdF
         oMOSaNueTboQoQT5nzStdk6VOHbxUN1jPC86reheJs/xm6dLWt4DSbaTnxtnXDdDfzNI
         POOzN/hcvbnBoFokjUT2OtaX1BPtWeWNJowfptpRH3hJWcyuTSsJXmKLfbPXYOnn9x2w
         t4EheTNm6LKlH+FG8mc4GgKLZHVrUeSjTGrscKVZpLrRfKzRo8ioTyVxKPsMMvLkpSEU
         Ees7PKH7ZHo+xSY7eI8Ms2P+8gFkgrm129opaj7JbnS7CM9ZZYgceUsemZ4YUmOqM827
         ddag==
X-Gm-Message-State: APjAAAXtQkOkwEsYRy16mNLlIff8S4Sz7FBCSo1NELvSlQQmts+3MsY1
        QW+U6rs3u9QNP9gWtKtUxfpvM8rjUPMhQV2kpjSbf3b/yC9JFB4HaklWrETbZ39GH8vattA7OUk
        nuOjTOhoQ2N/NNS7gIjQW9XZPQ7K0lIUDHz62mte2FFTT52BB3HLAMA4s6v0=
X-Google-Smtp-Source: APXvYqxytqfw47V/MhcGg/i4O+6RWJ7wqR6SWY2e/HoCmCJBX1ab+rGEqMcqzunvElK9WTTa9VsmRj1g0k+8
X-Received: by 2002:a63:3d0f:: with SMTP id k15mr7906205pga.343.1560559334265;
 Fri, 14 Jun 2019 17:42:14 -0700 (PDT)
Date:   Fri, 14 Jun 2019 17:40:11 -0700
In-Reply-To: <cover.1560558910.git.matvore@google.com>
Message-Id: <2ca58159914d0712916915b92027fd56b0b93fef.1560558910.git.matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com> <cover.1560558910.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v4 05/10] list-objects-filter-options: move error check up
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, emilyshaffer@google.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the check that filter_options->choice is set to higher in the call
stack. This can only be set when the gentle parse function is called
from one of the two call sites.

This is important because in an upcoming patch this may or may not be an
error, and whether it is an error is only known to the
parse_list_objects_filter function.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter-options.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 1c402c6059..ab2c983031 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -28,25 +28,22 @@ static int parse_combine_filter(
  * expand_list_objects_filter_spec() first).  We also "intern" the arg for the
  * convenience of the current command.
  */
 static int gently_parse_list_objects_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg,
 	struct strbuf *errbuf)
 {
 	const char *v0;
 
-	if (filter_options->choice) {
-		strbuf_addstr(
-			errbuf, _("multiple filter-specs cannot be combined"));
-		return 1;
-	}
+	if (filter_options->choice)
+		BUG("filter_options already populated");
 
 	if (!strcmp(arg, "blob:none")) {
 		filter_options->choice = LOFC_BLOB_NONE;
 		return 0;
 
 	} else if (skip_prefix(arg, "blob:limit=", &v0)) {
 		if (git_parse_ulong(v0, &filter_options->blob_limit_value)) {
 			filter_options->choice = LOFC_BLOB_LIMIT;
 			return 0;
 		}
@@ -178,20 +175,22 @@ static int parse_combine_filter(
 		list_objects_filter_release(filter_options);
 		memset(filter_options, 0, sizeof(*filter_options));
 	}
 	return result;
 }
 
 int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
 			      const char *arg)
 {
 	struct strbuf buf = STRBUF_INIT;
+	if (filter_options->choice)
+		die(_("multiple filter-specs cannot be combined"));
 	filter_options->filter_spec = strdup(arg);
 	if (gently_parse_list_objects_filter(filter_options, arg, &buf))
 		die("%s", buf.buf);
 	return 0;
 }
 
 int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset)
 {
 	struct list_objects_filter_options *filter_options = opt->value;
-- 
2.21.0

