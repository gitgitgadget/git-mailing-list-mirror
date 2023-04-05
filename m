Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E22C76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 12:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237877AbjDEMy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 08:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238009AbjDEMy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 08:54:58 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B7B30FE
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 05:54:57 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id bl22so12546896oib.11
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 05:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680699296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ptGztKbL3I2X13IFuuEixRJ9k8tG2nkxbhC1VkElABE=;
        b=ldZEDk1UUgXUSrAPgf0cU6o8kYl++iG3Hre0E59rsTBki22yKegvmSEOkMb2fMd/aT
         41BMZw34CmCybtsnYJjIsk6vwIwUw6sE9NdKvkk3rCQ8P+BP+H+C2eRbi1ky+mxOz2od
         y9TmpuGJUjzN/kdUW+MHdZckDLz0n+MsJ0ZOdosHOhz0dbN0rAh1XYvwqSl3kR1pGbCF
         2AX8C0HTgcbItcLb/TeZMtG02PDrnkw4ZscYvrTR4gR/h76NCc3mFlNU2+57+bew9wKL
         CU7mhfCv56/4tgkQwq6/lHwB7V78hn2ETGkFPD39dJBCbXnSR4h0rrbkOVdhURiJjM/5
         6uHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680699296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptGztKbL3I2X13IFuuEixRJ9k8tG2nkxbhC1VkElABE=;
        b=eHNppiQIWV0B70ykB+klwB2kybnkwLG0TVCvXf7Ldfuv3n7j7in15equBNXlNIXSiR
         QqJMPpg43Pko9EcUM6TbqJ1QC2jd+qmx/IMS2y+Pc53UGju0IJJJhaQqSlPAd9I8ehSh
         95qpCQWklX7ji5lUCVp2XXoMspZDx8TQSPS4LEr1agqOzOLmFv8UWNDG9+W7iDcbdWlc
         p5Uv1jNGWdym7GsXqd6wpWK2mL1dioGCGP2Y0GSmD1rfAhoe7FsartSyimR5ZBaMTZvF
         gIGp8h4wJnFF7hQpIj+ba91HNl+ncVv/znn2i2xAlPb508zzWVPFzHVfBnCnZKoiGhZi
         V/aQ==
X-Gm-Message-State: AAQBX9dkQyal0SP/L39XIKBjNeuFWwKomAbedKgBtLZTW/dfpQ2wNIWK
        71uAiQS8kxrwRIJaO2p1j1xJAOuKn9I=
X-Google-Smtp-Source: AKy350aYOvMSjJlNeSBPzdzT8SQOka798zTHso5Ah6TW6spGzoJggKvuSHM5V3fJ43mO2XAF5g0UAA==
X-Received: by 2002:a54:410e:0:b0:386:e3e0:fffa with SMTP id l14-20020a54410e000000b00386e3e0fffamr2664065oic.54.1680699295727;
        Wed, 05 Apr 2023 05:54:55 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id g11-20020a4a894b000000b0053bb2ae3a78sm6590167ooi.24.2023.04.05.05.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 05:54:54 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 0/3] doc: document for our use of legacy asciidoc.py
Date:   Wed,  5 Apr 2023 06:54:50 -0600
Message-Id: <20230405125453.49674-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I see many people confused about the AsciiDoc syntax in the mailing list. The
fact that we are using a deprecated syntax [1] of a legacy processor [2] (in
fact, considered legacy more than two years ago [3]) that is not maintained
anymore, does not help.

  AsciiDoc.py is a legacy processor for this syntax, handling an older
  rendition of AsciiDoc. As such, this will not properly handle the current
  AsciiDoc specification. It is suggested that unless you specifically require
  the AsciiDoc.py toolchain, you should find a processor that handles the
  modern AsciiDoc syntax.

But we refuse to move on and keep on carrying patches that were needed only 15
years ago [4] and not today, or worse: patches that were considered ancient in
2009 [5], never mind now.

Because we don't use the modern syntax, the canonical documentation [6] is only
partially useful.

Therefore we need documentation specific to us. This patch series attempts to
start that documentation.

[1] https://docs.asciidoctor.org/asciidoctor/latest/migrate/asciidoc-py/
[2] https://asciidoc-py.github.io/
[3] https://github.com/asciidoc-py/asciidoc-py/pull/175/files
[4] https://lore.kernel.org/git/20230323221523.52472-1-felipe.contreras@gmail.com/
[5] https://lore.kernel.org/git/20230322000815.132128-1-felipe.contreras@gmail.com/
[6] https://docs.asciidoctor.org/asciidoc/latest

Felipe Contreras (3):
  doc: add documentation guideline
  doc: use deprecated syntax in doc guideline
  doc: asciidoc.py workarounds for doc guideline

 Documentation/DocumentationGuideline.adoc | 194 ++++++++++++++++++++++
 Documentation/Makefile                    |   3 +
 2 files changed, 197 insertions(+)
 create mode 100644 Documentation/DocumentationGuideline.adoc

-- 
2.40.0+fc1

