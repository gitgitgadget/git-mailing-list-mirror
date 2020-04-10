Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C43C2BB86
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 11:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35AC20753
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 11:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tR54Zh1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgDJL16 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 07:27:58 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42898 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgDJL15 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 07:27:57 -0400
Received: by mail-ed1-f68.google.com with SMTP id cw6so2051292edb.9
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 04:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=AN1/wCrE9GKlqNjDshykXbSd8zEHbOe9EjwdHKBjjgY=;
        b=tR54Zh1umLLJOTZmiRCRoT5ErIR01p0K8qWQYu/jt3ppJU4ONLlhC2TQ7rBa6sXSGI
         2HESPyntZ7BQYEZaQEugTmSMPabaYOwchg7k0ou/avkiQEwkQI+FHIBL6jzK3mQEfnqa
         RgLZSO4NUYy0Wp4x7uYgEKbPoiXB1KCsmFlaskX8/Gl9AIp+T0yagavwIs02KX2/CTJ8
         wrdr41MOY+jWQHV9RZm0gZ6G2opmsyYT8sFIBQvjCc26LWJK18nD/zWV9DUhbwB4rZqu
         77ukjiMo5MoWIerrb8M7mCkU06UPJ8g+XqJ2v4/iaqynKLQymzNKYaxXJzZfh7poGQUN
         UUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=AN1/wCrE9GKlqNjDshykXbSd8zEHbOe9EjwdHKBjjgY=;
        b=cY6us39aIR9bBMY2LeJWghAZy5YlHBu7pGbQbAsoatYCoXVPpkzGkoUP8cfV1kC0Et
         Nmut86O+GIvJ/1zmMypn4NY5E0ipIaem4lhmzTJZ0hL2Pxg6jAvW6/Va8McbNwDoxNZf
         eRC81/cpfqvlShyvMmEWGhdjJDEvk8riO9Z62L3dvc9QTQiYBxLfMOVdbhu+sqqKYpaY
         aZOBuDNsYcfyYwao87TK4bcZQk+L5zH0/ywTOPIHQuSyEzMsDU2RePBEbwXoryDd84ea
         MelEbVrbqqRS/tCdeUOqLd/j4rTJ+/hd5FkU04xOzsWwixT0EehefHFRt/hvf3Bl8xKy
         PRiA==
X-Gm-Message-State: AGi0PuZzuHasQCnmJY7BfazMMHsaLXHdpOJvwo3njPPh2Ow8uxbSkePe
        cEt/4olOCkGoZaPPyywucsQlnEXT
X-Google-Smtp-Source: APiQypLMajWKc1woip/7cSagFrzAd+EziBZD8gcnQL8MwC24mkCDxzTEsH+ALgNuudlmKTzV3OUnDw==
X-Received: by 2002:a50:e0c9:: with SMTP id j9mr4165292edl.127.1586518074670;
        Fri, 10 Apr 2020 04:27:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l62sm83486edl.89.2020.04.10.04.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 04:27:54 -0700 (PDT)
Message-Id: <d3949e42004f31e8741fad08352f782b4b8536eb.1586518072.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.755.v2.git.git.1586518072.gitgitgadget@gmail.com>
References: <pull.755.git.git.1586374380709.gitgitgadget@gmail.com>
        <pull.755.v2.git.git.1586518072.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=EB=A7=88=EB=88=84=EC=97=98?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 10 Apr 2020 11:27:51 +0000
Subject: [PATCH v2 2/2] Explicitly `fflush` stdout before expecting
 interactive input
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=EB=A7=88=EB=88=84=EC=97=98?= <nalla@hamal.uberspace.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=EB=A7=88=EB=88=84=EC=97=98?= <nalla@hamal.uberspace.de>

At least one interactive command writes a prompt to `stdout` and then
reads user input on `stdin`: `git clean --interactive`. If the prompt is
left in the buffer, the user will not realize the program is waiting for
their input.

So let's just flush `stdout` before reading the user's input.

Signed-off-by: 마누엘 <nalla@hamal.uberspace.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 prompt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/prompt.c b/prompt.c
index 098dcfb7cf9..5ded21a017f 100644
--- a/prompt.c
+++ b/prompt.c
@@ -77,8 +77,10 @@ char *git_prompt(const char *prompt, int flags)
 
 int git_read_line_interactively(struct strbuf *line)
 {
-	int ret = strbuf_getline_lf(line, stdin);
+	int ret;
 
+	fflush(stdout);
+	ret = strbuf_getline_lf(line, stdin);
 	if (ret != EOF)
 		strbuf_trim_trailing_newline(line);
 
-- 
gitgitgadget
