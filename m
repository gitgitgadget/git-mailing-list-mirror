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
	by dcvr.yhbt.net (Postfix) with ESMTP id 01C6E1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 22:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfF0Wyh (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 18:54:37 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:52353 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfF0Wyg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 18:54:36 -0400
Received: by mail-pf1-f202.google.com with SMTP id a20so2472169pfn.19
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 15:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S+6irJWpzfC/LlA6nHhdC8F/0EGj3YmAm6cyz5TWzUc=;
        b=shWfYMsLBN+O3+d7ndH8WtlK7XXSpTw4N6HDg6Zh4yw9dw97aGFZT5YCGfDf7dc4He
         q3k1zsbW80fOaAy2kP5qxGnpOOW2nQX2hh3YjlDb1WBmKginF6bps1nC7ufD6FK0P6jm
         K2GjktZsdt6FtpAjRLI2wEJlxk2AxrXEjwCJP26p8RK40NN/q3mKNz31uXtcdyctP0iL
         0Wv/myddHAc2nN0PIQgz/6SeWY2l/JDWSddeDskqHtIq8Ngxy2YDdOFOYd3Xre67oHef
         628nlQGwSfBHv3Mr9H56sKRyftPdUJXR4cyPDWTMGncU276JkgHQKwc6jUmnxJYxKily
         DVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S+6irJWpzfC/LlA6nHhdC8F/0EGj3YmAm6cyz5TWzUc=;
        b=X4aUEBtG7PufjpauxsaJNjaIAF6+KaTuYtQxfNT+RU22iKCznB6pvJPkoTAlFcypKC
         hN7FKIqza3HHw1rZ0gxYIvAjIo3FkJifR4wH48wZozrBHYWYrC/ZLR7ZkIkNhSW5gRp9
         B2zSkvn2K8E/h3mmlb3kOjymxqYWAW9WuquW5oXSv/sbC/shYjAw5Rvk132QO0yw3mXa
         t4vFIPcJuj51tHubYtOfxLoDYlasJrwdkuJ1oO/6cV+IYnt8mnrbFRyKxX+O0IkDaFv7
         Lt2JDThHIkmnnb5h4PJdfx4IHbAcewhddkYlEI+MOtHSnhK/CE00xC9+n/L0Fm6N8Ko1
         8MrA==
X-Gm-Message-State: APjAAAUodWOD9v3bzL6sMP0S5YRu6EV+5u6f5YxsKHx5QCFtI702xTXc
        vwDkRTry4c25VnDaUMD4BdkpswrknMNoV8a8WRpWA/rnBWkFFMi6FO5HKrWXreOrIddmxyaGXF5
        lQLLhY5TVubZcwuwFdMmhV3UmYuU3wwFb04dbp2iNFdBTRYLZFFJAdBW+5vs=
X-Google-Smtp-Source: APXvYqyyOM7sjr9rtj/wCYoy1zIOTDeu4ApPuredSohTkWDdk8SAV4bzN1KkB2WIU5Ts+G2qkjFS+2WnUhTx
X-Received: by 2002:a63:221c:: with SMTP id i28mr2281427pgi.114.1561676074996;
 Thu, 27 Jun 2019 15:54:34 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:54:09 -0700
In-Reply-To: <cover.1561675151.git.matvore@google.com>
Message-Id: <32d1d81e5dc3b6ccbaa94266823e9c6c4657c191.1561675151.git.matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com> <cover.1561675151.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 05/10] list-objects-filter-options: move error check up
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, emilyshaffer@google.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net,
        Johannes.Schindelin@gmx.de
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
index 75d0236ee2..5fe2814841 100644
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

