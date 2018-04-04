Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A914C1F404
	for <e@80x24.org>; Wed,  4 Apr 2018 06:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeDDGHy (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 02:07:54 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41019 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeDDGHx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 02:07:53 -0400
Received: by mail-pl0-f65.google.com with SMTP id bj1-v6so10158090plb.8
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 23:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BWPXfS4M4d/GUt8BdSR1jqEWdzpIUX51qhBfN/ASu5I=;
        b=fS/V5rEVNc/NsaTJw0B7LNhOXsMDdt40jV9nfWpmtnZrRGKeNGbjmEqU4QawYSv4e7
         ngb/RWXJ44YZymlS5pDQLQVqjL6D5RloeCI7RFjE5mCJR0CozkuF3+58KSR26lRWmp4m
         0C/ZtjTJStu3Usce1jeE9VM/LnE6Pr7Nr5CqtqCreMcawnEF/PKM2xXG6ZS45+EU1ZPe
         UIeaN7kJx2BufT9jAaraQesqKE43xlelG0JkP+DWrp3yHmdXaPY6IywCtsNPec3MYTXu
         cC4JWARse0wRlVzwL6IaAgLZXibw/9gTGZQyZhHihiC6UXi8utczqgabptydSQODPfYn
         WQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BWPXfS4M4d/GUt8BdSR1jqEWdzpIUX51qhBfN/ASu5I=;
        b=dt4vzIFIBfC5/xSpSsxMVGlXLMLrPE++VvhLOpXRltqIIwcmB8qUFNHkmICcJom+9o
         3VHLNpSwoJAwMuaM3O8F0cYXY0+ezF8kLdZ4gsK8JUtycLs3la3QVbwAPj2O9038poS3
         tzoHGzeJA4lQBPLNtTSOmEidm2FRm0R0vlTl8QTXXGIlhnVMUCj83oaJE2pMbP2p0htZ
         BsWFLZvQwlI/9xq9nrvjsZ2pUbpME4f2Kv3iCUqStV0EjruagDTpDNwkI+i0N1rQvtuE
         MdvGC6UgkdPlkm6ea4A7ZWa8cnsy6E5zMAf/EfTisg6IlXm6IWJCsd6kLNuktlYR1X8b
         TszQ==
X-Gm-Message-State: AElRT7HI3hGGqOk3xz8jmFgfw6qky/A2Zi0greNFPVQ+S8W+X21DqB8G
        asDu+UmLHJ/m+f0dzo/DeKVkx1ob4C0Ceg==
X-Google-Smtp-Source: AIpwx48wRxhfPZdvi7GKin9A/EaSmcJmAw9/xIBe+uxx5qgRijBh/CCN7UDpk6zMWd8BigzhdzgJCQ==
X-Received: by 10.98.253.9 with SMTP id p9mr12685394pfh.152.1522822072228;
        Tue, 03 Apr 2018 23:07:52 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:3471:d3e4:760a:b8dd])
        by smtp.gmail.com with ESMTPSA id k24sm8435210pfj.32.2018.04.03.23.07.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Apr 2018 23:07:50 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, l.s.r@web.de, --@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 0/2] builtin/config.c: prefer `--type=bool` over `--bool`, etc.
Date:   Tue,  3 Apr 2018 23:07:41 -0700
Message-Id: <20180404060743.39278-1-me@ttaylorr.com>
X-Mailer: git-send-email 2.16.2.440.gc6284da4f
In-Reply-To: <20180328234719.595-1-me@ttaylorr.com>
References: <20180328234719.595-1-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here is a v3 of a series to (1) treat type specifiers in `git config` as
singulars rather than a collection of bits, and (2) to prefer --type=<t> over
--<t>.

I have made the following changes since v2:

  - Fix some misspellings in Documentation/git-config.txt (cc: René).
  - Handle --no-type correctly (cc: Peff).
  - No longer prefer (1 << x) style for enumerating type specifiers (cc: Peff).
  - Fix awkward rebase (cc: Peff).

Thanks as always for your review :-).


Thanks,
Taylor

Taylor Blau (2):
  builtin/config.c: treat type specifiers singularly
  builtin/config.c: prefer `--type=bool` over `--bool`, etc.

 Documentation/git-config.txt | 66 ++++++++++++++++---------------
 builtin/config.c             | 77 +++++++++++++++++++++++-------------
 t/t1300-repo-config.sh       | 29 ++++++++++++++
 3 files changed, 113 insertions(+), 59 deletions(-)

--
2.16.2.440.gc6284da4f

