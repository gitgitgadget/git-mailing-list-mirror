Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CEBC43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 10:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349344AbiFJK5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 06:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349139AbiFJK5M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 06:57:12 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BD52ADF59
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 03:54:49 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x17so36002550wrg.6
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 03:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6NpiRs80V4EyAWLcIpjoCUBwX8WrfETnmq1wjdFiWl4=;
        b=SBR0Haaz5Bgse9QZBmYpCnJ5zUhUWhFvmGaIgHL3wA5HDBkTYlmR/st7uk/sRU8Prv
         gYqKNE5EIW8bDatA2WpwxL6gUMrH0dCxPGT7efY+kZLAbvL3SgBmS5k7akz8Q4aKbrpp
         UJqUrGrvaI8qPpoTccLTLKEt8XzAD6eqeN0boKGMtaj4sNwUPI+Bbe17lzPO2/TmcBVo
         BZW4AzrpFVJV1zOs+Wm6HEiZXqg8Mw0QkBtBskF8cKz2RFFpTJO1f6wYShW2354EkDXh
         uyvZoA2HVhDpNNQFnhyoICwk09qb0wg/uvms5dubpvL9CMMZ/RMefli+E5i3InufjaEl
         QHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6NpiRs80V4EyAWLcIpjoCUBwX8WrfETnmq1wjdFiWl4=;
        b=m0VCJfHO7bMW+UE6s+Dq6TpDFsSV8NJwkDpGtCkH1Cik9ZoO5UlCaM0g6H5vtRK02G
         Nwzd/61gCHFmvdX/Nyp7RyMzDNsDBYIZlGNaUTLqxI+IAyLvqc/PhIUn0QKdQoy4BX8r
         dQCpuicKYqZREDfKAbdTyQCpdUwT9dWzJso2SbICwpX9JR5/SZzRWqVTrJ+Su7r9xR61
         sRgSvoWCv/+klKmrWvNoH1siielJejYOFugMH52dEAkL9vsNVjgXtWMctlHmA9nxw/I5
         iSspLykclszguBtbtNja6g81zArw5qpiQXyYPjV1I4sC5nNUK6+N7x0TahvXdKrtMVuE
         ouNA==
X-Gm-Message-State: AOAM5324QrQ0whkvjUH4IEy+y4Gr163ICPfmY5Rl51K6kwMdUqVmirzl
        r4TV+eza1aQUoTuCRIF9bYoIk7QF8fivhw==
X-Google-Smtp-Source: ABdhPJyfdiZ1uerh7yHPdOr1VA3pO+WCjZZ4ilNm/fY4ISKnWOqcEnbizzyYJxLdsVakB6kW9qt9FQ==
X-Received: by 2002:a5d:6487:0:b0:218:35ed:d4ea with SMTP id o7-20020a5d6487000000b0021835edd4eamr28938373wri.344.1654858487127;
        Fri, 10 Jun 2022 03:54:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c2cac00b003942a244f40sm2717851wmc.25.2022.06.10.03.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 03:54:46 -0700 (PDT)
Message-Id: <b971558e1cba0a40b5adf20f53dfd3822dc7a42c.1654858481.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1246.v3.git.1654858481.gitgitgadget@gmail.com>
References: <pull.1246.v2.git.1654623814.gitgitgadget@gmail.com>
        <pull.1246.v3.git.1654858481.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Jun 2022 10:54:41 +0000
Subject: [PATCH v3 3/3] bitmap-format.txt: add information for trailing
 checksum
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Bitmap file has a trailing checksum at the end of the file. However
there is no information in the bitmap-format documentation about it.

Add a trailer section to include the trailing checksum info in the
`Documentation/technical/bitmap-format.txt` file.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 Documentation/technical/bitmap-format.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index cd621379f42..3f8cdd0ed91 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -138,6 +138,10 @@ in the index.
 
 		** The compressed bitmap itself, see Appendix A.
 
+	* {empty}
+	TRAILER: ::
+		Trailing checksum of the preceding contents.
+
 == Appendix A: Serialization format for an EWAH bitmap
 
 Ewah bitmaps are serialized in the same protocol as the JAVAEWAH
-- 
gitgitgadget
