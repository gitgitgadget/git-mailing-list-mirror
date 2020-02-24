Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2E2C11D2F
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 15:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4F92082F
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 15:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOvemqzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgBXPNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:13:23 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37602 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbgBXPNX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 10:13:23 -0500
Received: by mail-ed1-f67.google.com with SMTP id t7so12277161edr.4
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 07:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lolcPEH9dhf4EWrJllSyFaba3lqKmwgtdjkj9k8UdV0=;
        b=jOvemqzORz5fguF9vOVVnoV7J7CdKFd4uKO9AxxfJJ8+f0ZexxWIESKI0vJ/5pLo2I
         soaiQy7QRLTDBZS7323kwqqwHUyf8eLIWSFbKWYP+aemVObkZy2Gk/0DTBkXtyKT3dKV
         bhVVBx9rMuuguqPEaIeigmTkGpt13f+kpokWcjI6ZHm+NF/SvtjXdFrlimTu7dZ9ajIH
         4GHfJXYvytY0rl7n6gy1x+M5lAfJXKX0dAng6/a6zQ07358wWj+ExDBPwe+FuOyQGE/1
         BLbjwko7JvHtNh0fxgvFrGzHXl/vbUXaw17kT/AKM7cafKGS7DmcmiaaklOW7JJMWjEB
         joUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lolcPEH9dhf4EWrJllSyFaba3lqKmwgtdjkj9k8UdV0=;
        b=sp9Pm3hfERt0tSddXzJ8gynsZXjNM1mP2JdCV5kcQ8FAAGVWEaRB2oQeYwgg5xqeIz
         K2foaHvT/USTYTTnwzDjZYzG3NhnSFbryIaPTW1F5RFS0QSghyBQaUrlXRXkGd2AWW6V
         MsSwgRtzrveli8bKDIITOgqeRoo6gih4DdKg0fwZep+dEk9n9pcGol2E66qQNQffgqdy
         XtxuJDC10nAl+tPWXYK4URuYIlF4Bi8dUx5JuN/ZZJPUxHF+yolyTElfIUyICp0VTc1P
         KT43SND5J72NIHvdc3/IK+MmJkODejIa/kPP7yGBIqymwaexbmO9ZN2g3EANnwaMi+Me
         wFnQ==
X-Gm-Message-State: APjAAAXO4/YJMkLhWhUCsegDHju0Z2UJJu7L/dLIym7R2qQEPA9Z1aVm
        iijLvTxzKhf+v6RSgwF8HGup+LX9
X-Google-Smtp-Source: APXvYqz4Ph0vSJd3OoCGrvfdTT6XFjwdrWRLLEOSaB7ELR8FMsNVjHpsBZoQhQsNk5ajT6w55+DnvQ==
X-Received: by 2002:a17:907:118b:: with SMTP id uz11mr49175579ejb.273.1582557201556;
        Mon, 24 Feb 2020 07:13:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g6sm966958edf.25.2020.02.24.07.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 07:13:21 -0800 (PST)
Message-Id: <f668d9b7ca04da1d8adf0a146b48a46559471501.1582557199.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
References: <pull.548.v3.git.1582144442.gitgitgadget@gmail.com>
        <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Feb 2020 15:13:16 +0000
Subject: [PATCH v4 1/3] advice: extract vadvise() from advise()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

In preparation for a new advice method, extract a version of advise()
that uses an explict 'va_list' parameter. Call it from advise() for a
functionally equivalent version.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 advice.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/advice.c b/advice.c
index 249c60dcf32..fd836332dad 100644
--- a/advice.c
+++ b/advice.c
@@ -96,15 +96,12 @@ static struct {
 	{ "pushNonFastForward", &advice_push_update_rejected }
 };
 
-void advise(const char *advice, ...)
+static void vadvise(const char *advice, va_list params)
 {
 	struct strbuf buf = STRBUF_INIT;
-	va_list params;
 	const char *cp, *np;
 
-	va_start(params, advice);
 	strbuf_vaddf(&buf, advice, params);
-	va_end(params);
 
 	for (cp = buf.buf; *cp; cp = np) {
 		np = strchrnul(cp, '\n');
@@ -118,6 +115,14 @@ void advise(const char *advice, ...)
 	strbuf_release(&buf);
 }
 
+void advise(const char *advice, ...)
+{
+	va_list params;
+	va_start(params, advice);
+	vadvise(advice, params);
+	va_end(params);
+}
+
 int git_default_advice_config(const char *var, const char *value)
 {
 	const char *k, *slot_name;
-- 
gitgitgadget

