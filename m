Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC274C76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 12:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238014AbjDEMzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 08:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237832AbjDEMzC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 08:55:02 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D892659D5
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 05:55:00 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id cm7-20020a056830650700b006a11f365d13so17667726otb.0
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 05:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680699300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vE2aGtnJ2La74fOnLY/ZgKmfAxYcesFBjnMADPel69k=;
        b=UYlsRZSzgjoLlyOVZe0WHKOXQJhulIhY9pxO+q6lJErqolMnlnVzBJ2ji1KdIjX6IG
         yg+SqUEo8JgMoEcT7J9JxHEw8qwOrjVONl3uqIDJ50R6s2L9ZV5i3V55GAUjqmwwVtte
         y2B/evN0UvyvB+kopIzJfkBKIy505eD8MN70Gk+EtjiK993SERIP5TPexH+FJWtlEF31
         l4C7K0cbVTC3nWG8g9x9EFwT2Wo0tavCsECu0dGwvW2rNDWliUuDQgNX0sSNHR36DKWy
         Fy1zGroxVErFKcU+exLd+ghqPwPNXMBuEa9gYKnmT12yCoVjG1DzFSCWSeDa+H9DibDX
         eCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680699300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vE2aGtnJ2La74fOnLY/ZgKmfAxYcesFBjnMADPel69k=;
        b=Q6YKipxhEqkNNaf8h/ILqq4oZCZ/ZBz4nE0GFBBD2SsSAmpGvSBAcfpI7e9Nev2q4w
         3bTQtjt1VZqfu4VbggH1GnFTHhlnMP57O3KJn2hBo5QZ8yf+sqG7CEG6axWScnJKtLYF
         5yYsJW+TstfL2tKwh3GtU4hlzW2GfCX4PfSQhzxlWETXsapEhFVoqlBl30nTQlk8mEYf
         BC2OC3SrhPj9kZ1LSk6OngolY6lf0vlx3FR7mPAqWug3+iaI7CnhOEjqF8h5VZjC0wfl
         RyX7p1uVMh/nkEBuWC7YCN5OphH3PpH0WuQ6a5JqcztWcw0g/Z+mNS+3OWTigbN2tUR0
         ye9Q==
X-Gm-Message-State: AAQBX9erbv09btD21aq2wT1q1OfSFy0r3b7ExXHvf1wLl1gzPZRncCXF
        NJWl3/9xB7AETrdJgSMeB5q7VozhSh8=
X-Google-Smtp-Source: AKy350ZwSOZwORQ8XR/tgeIT+y6cg/ML3Gb4zJrMi9ow4gRluIhB3rU0EX8oJCNJWX0XFTqKKHfP9w==
X-Received: by 2002:a05:6830:4d5:b0:69c:497:50f9 with SMTP id s21-20020a05683004d500b0069c049750f9mr1118848otd.4.1680699299839;
        Wed, 05 Apr 2023 05:54:59 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id e12-20020a9d730c000000b006a3ae1c5a30sm427294otk.9.2023.04.05.05.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 05:54:59 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 3/3] doc: asciidoc.py workarounds for doc guideline
Date:   Wed,  5 Apr 2023 06:54:53 -0600
Message-Id: <20230405125453.49674-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230405125453.49674-1-felipe.contreras@gmail.com>
References: <20230405125453.49674-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

asciidoc.py for some reason can't handle one URL, and doesn't understand
listings inside listings (of obvious different levels).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/DocumentationGuideline.adoc | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/DocumentationGuideline.adoc b/Documentation/DocumentationGuideline.adoc
index 8f1300f898..a581c47f05 100644
--- a/Documentation/DocumentationGuideline.adoc
+++ b/Documentation/DocumentationGuideline.adoc
@@ -4,7 +4,7 @@
 :3: https://docs.asciidoctor.org/asciidoc/latest/text/troubleshoot-unconstrained-formatting/
 :4: https://docs.asciidoctor.org/asciidoc/latest/text/literal-monospace/
 :5: https://lore.kernel.org/git/pull.1304.git.git.1659387885711.gitgitgadget@gmail.com/[[PATCH\\] Documentation/git-reflog: remove unneeded \ from \{]
-:6: https://lore.kernel.org/git/CABPp-BEEDS%3Dv7ouOKts83OFMxDq%3DF0TKO1XvHEbnmXJ+Z1WELA@mail.gmail.com/[Re: [PATCH\\] git-merge-tree.txt: replace spurious HTML entity]
+:6: https://lore.kernel.org/git/CAMP44s3Kqyrdavp1OiozNbA7k4EHCj0KiQq4d2Dyg_KZSEAUuQ@mail.gmail.com/[Re: [PATCH\\] git-merge-tree.txt: replace spurious HTML entity]
 
 Documents shall follow the AsciiDoc format, a simple markup language specified in the {1}[AsciiDoc Language
 Documentation].
@@ -78,12 +78,13 @@ Renders as:
 
 Often you'll want to include example code, for that you can use listing blocks:
 
------
+[listing]
+....
 ----
 __attribute__((format (printf, 2, 3)))
 void fprintf_or_die(FILE *, const char *fmt, ...);
 ----
------
+....
 
 Renders as:
 
-- 
2.40.0+fc1

