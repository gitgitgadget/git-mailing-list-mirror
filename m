Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D4521F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 16:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbeK1DwB (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 22:52:01 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45434 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729763AbeK1DwA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 22:52:00 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so16972720lfa.12
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 08:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1POp7A0x0QOuoxW+bhpb80VjAWh8OmhLOYAqDBgTw1s=;
        b=B2tPlxMdG6SeNXHggZ84KrjfteeuJzrCKTIdy0faQdEp1H33xa8BR8aJbN49GoOsyO
         Dz7Y5kA10NECL7VkisRJnNhZHTzPMLqgA/3K7S1U0Fx4+RkhBkixuvrfho+7Vna7shgD
         AI5SAXCMEjx1BnFkUzwAKIgNR5p/3yiyBIEj6/30Ti7NQ2Ym1LQM8t7cN78qKFwt1hN8
         aLSLjx04huOENJN+78TOnTMBHVbTZkR6/dPb6bqjOjgq7oEfN5Ppx1FiPb+GqyLYXEQD
         jlKWVhMgzx2Ax4S2NYPfhg0i4gNCILUdJzwn/nMriT75AwzJkYMy6UMIqKAIbwm/I8sw
         6Vpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1POp7A0x0QOuoxW+bhpb80VjAWh8OmhLOYAqDBgTw1s=;
        b=fEJA8S2lGaKQfLudr1eV4tRAyAiVK/Fc43e3dca/n9W1kcVe/Aw4z2m7dfLtjgCrfP
         q/6j+a15Wxjp8KcrrPphSeDcdnPACSjDEMmU0MdcykTyMqCgUkaVe9iO+NbsfEIlEzPW
         BWzEMKLnVWYf+SqRO2JmAnBwP6roEeifMbbMzvLd9m9nO0CL6HXUuzIvCh3dvjh49UFx
         OapN8ddxc8H2i8JjgkKGNsfnm969ZSPhYuEI0HEIJCpoq9PfgEhVlp+6VJ3WgXez80cW
         NSUfoqiN8gghD8DHyhr6/FFXcU+Fj8zOEphfcNNrCjcadMPzSoWQVQZHJsJsf0bIqle6
         YO+Q==
X-Gm-Message-State: AGRZ1gIiaiARbJWymYvpQ7sVl0lQSwo0Fu3wBQWaUqrPEjWKkStMyyZp
        gAhbKa2uiyxx+/L/alx9ju+0zMwd
X-Google-Smtp-Source: AJdET5dc+FdirtAv8L3fGrsMWe1nFnShyOmXfHiz28KDdyFZ9XRgNkJ85UDIBmL8/FVtRO94nYAGbA==
X-Received: by 2002:a19:5402:: with SMTP id i2mr18717854lfb.128.1543337608603;
        Tue, 27 Nov 2018 08:53:28 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g66sm694016lfe.42.2018.11.27.08.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 08:53:27 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>, t.gummerer@gmail.com
Subject: [PATCH v2 1/7] parse-options: allow parse_options_concat(NULL, options)
Date:   Tue, 27 Nov 2018 17:52:05 +0100
Message-Id: <20181127165211.24763-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1327.g328c130451.dirty
In-Reply-To: <20181127165211.24763-1-pclouds@gmail.com>
References: <20181120174554.GA29910@duynguyen.home>
 <20181127165211.24763-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is currently no caller that calls this function with "a" being
NULL. But it will be introduced shortly. It is used to construct the
option array from scratch, e.g.

   struct parse_options opts = NULL;
   opts = parse_options_concat(opts, opts_1);
   opts = parse_options_concat(opts, opts_2);

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 parse-options-cb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index 8c9edce52f..c609d52926 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -126,7 +126,7 @@ struct option *parse_options_concat(struct option *a, struct option *b)
 	struct option *ret;
 	size_t i, a_len = 0, b_len = 0;
 
-	for (i = 0; a[i].type != OPTION_END; i++)
+	for (i = 0; a && a[i].type != OPTION_END; i++)
 		a_len++;
 	for (i = 0; b[i].type != OPTION_END; i++)
 		b_len++;
-- 
2.19.1.1327.g328c130451.dirty

