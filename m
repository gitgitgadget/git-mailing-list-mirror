Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884EAEEB560
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 17:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245126AbjIHRpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 13:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245447AbjIHRpD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 13:45:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67C91FE0
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 10:44:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7e79ec07b4so2431076276.0
        for <git@vger.kernel.org>; Fri, 08 Sep 2023 10:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694195095; x=1694799895; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4gq+PIpSuYKXx7X5Mfl46tvFsgyOkQFELo5vNvFD/hA=;
        b=gg/hoj0Xf1UGw8ifB27FSJb1YjHg1Vxah57Aaby7qAow6BQCirCj0Qj6WqsMnoyg7c
         LaFQfp3ay+zU0Dl5jVGIwG4BfIOiOZOv5vDV7JyAt96yRzA7SWBWxb1z+EUORgbY/EqD
         7EzKKoXz+PIzR4OByqKCMV0zxLEvOh6+8MmQu11ChwGRvds6J89Ydl8s9XrFk1Myzlou
         GQ7NVUDEsdV/Cqb9qfmqW6rzeLGRTwoyICSCV99+uC4K7EKTumObBM37JdWm+jgyI+WZ
         tyTqfLYU+UB8SnOr/2Wirjtj8fVJUXKgZe1US5yUmUyc3Mp/Jibuueb0Hu/UXCSmiROg
         5dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694195095; x=1694799895;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4gq+PIpSuYKXx7X5Mfl46tvFsgyOkQFELo5vNvFD/hA=;
        b=W51TGEgFlwBuZCJjc9EzoYvM8K8x3EtoQnu7Y0XnJAGt9s1ocaOMnH49MXxV8ZXxm+
         Ex4NgQkNECBxk/SPtV6TULpSjKQo8IuKOpX/ItluwRK1JrZ+Ti5wmmrPefkqxzSbw+zu
         oF5g/JABjSwP3hEvQuOZlfRdhhYCMhaMYud+5c4WUAGEqS3uNFTR6amQDgezugcy2zoX
         zeY8bWojUCT1ICxvoARumVosJfiHFOb9VMHSvF4z/GKQiyhNthaCniCbqdFUXXi4z51R
         JYg8gDCQ3AbdJ6d4AJL1E5kj/XdVVwfYhLnlxJc27q1vdZ3rsz2AoSEAjWOCT1E3bBR4
         V8nw==
X-Gm-Message-State: AOJu0YzvpqqST5Mm+WWnrmRKYiKEWyX2sV0GYtWa9hZvFcVqJSvxg4ee
        qGLKC6hZ2cZziF+LmLMESmVOO/QGWIgXf3gz/CCZGfQpWRo6dlc981Q0lFN59xGkl72mJ61C5y4
        sryNQdHDRKyr2ie9Yyjs6VAreHxbl6K0L0YrDKSexV5DmolxGV9E9Neu5OtXm4kbm1Q==
X-Google-Smtp-Source: AGHT+IFRw4oXtIgZAzVT5aGAfX16frgEzfXqS0FsWxfIK5OgpN0jtuQKhQWzgvQqS65Zf5dLOI8jX097S/AkdTU=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6902:1022:b0:d80:1250:89bb with SMTP
 id x2-20020a056902102200b00d80125089bbmr73020ybt.7.1694195094824; Fri, 08 Sep
 2023 10:44:54 -0700 (PDT)
Date:   Fri,  8 Sep 2023 17:44:40 +0000
In-Reply-To: <20230908174134.1026823-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230908174134.1026823-1-calvinwan@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230908174443.1027716-3-calvinwan@google.com>
Subject: [PATCH v3 3/6] config: correct bad boolean env value error message
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        jonathantanmy@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An incorrectly defined boolean environment value would result in the
following error message:

bad boolean config value '%s' for '%s'

This is a misnomer since environment value != config value. Instead of
calling git_config_bool() to parse the environment value, mimic the
functionality inside of git_config_bool() but with the correct error
message.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 config.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 3846a37be9..7dde0aaa02 100644
--- a/config.c
+++ b/config.c
@@ -2133,7 +2133,14 @@ void git_global_config(char **user_out, char **xdg_out)
 int git_env_bool(const char *k, int def)
 {
 	const char *v = getenv(k);
-	return v ? git_config_bool(k, v) : def;
+	int val;
+	if (!v)
+		return def;
+	val = git_parse_maybe_bool(v);
+	if (val < 0)
+		die(_("bad boolean environment value '%s' for '%s'"),
+		    v, k);
+	return val;
 }
 
 /*
-- 
2.42.0.283.g2d96d420d3-goog

