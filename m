Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABA3620248
	for <e@80x24.org>; Fri, 22 Feb 2019 20:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfBVULP (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 15:11:15 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:37777 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfBVULP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 15:11:15 -0500
Received: by mail-wr1-f53.google.com with SMTP id w6so410142wrs.4
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 12:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GQb2EC+X3O+S+SlxK80xBIeztFLes6i/v/Nw/jQwBIk=;
        b=VGjPvR8Q+sgTq2UYp2o/eTCK+84GuYzu1r2ssR0OZFKSPnAHIpJYxijeC858eTShFv
         5Ub/1aVMVgYTjrpxSBLFi4Syy0U2hhQwLaPmwS5fDCMIDsycYmLMdK9qVNDLQsvH9VBH
         ltMyZe6ttn3lHc461civ1lOfnjx2pcVdKdyr2Pw1O+3HCgA6Taq2e+eiQ5dfgHIyVoGF
         zvXawkWy2aq7lnUgn6b8iDr/eFTnoRFFQvA3pMsfUL9dUd+6hvy3oYaxIEAn39LjK2zU
         bVrZS+74uC5QAe0m1ZQXpP4unDniRU0ZxEf2OY8fQVINkvlvZdOrvWaVi7zQnjhdxpjD
         YFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=GQb2EC+X3O+S+SlxK80xBIeztFLes6i/v/Nw/jQwBIk=;
        b=PP72PJwrOaHX1yIK1X9Vu3YLwb8WwDfgcTh4sPfIdI335MkrQwN/m8mZARqmLs65Lb
         qjZjUX+5sfrSM2XyuqPH/ZzvSG61NgXrQQIg2sxBYSgk8dram7XPrOxgigT0AZe6PbTK
         zlYBsBY7XGYEPnquXaIjl2tYexUgbHHuopqq1xgGe6n73VYoxXb7NGRUZ8bsFp5DskfK
         n4NEU3q0FSHwfiSdCBjpfccWJd20C2rkyDrkKpviiI16zVfNGYQMmdUlPPSeNipuX3Ui
         7XIll5bWtDisU8bZ402T6t7P44XNEY2BOP/16sAARa3Tvp5W8m33myOX6CYUWKG0XXf1
         +eAg==
X-Gm-Message-State: AHQUAube2pqymRb3+fCX6UJ6MmhvPb4r6oF+vblvWIRuVI6vQcjsHzyG
        qeys5kIDzaxA5s/qyre39FHuAZ2X
X-Google-Smtp-Source: AHgI3IbCIt3L8S0cSEC+qdyx6lQ6CzRU8AwTbjlMfVhpqKsaW9+NHyWN+2fOELTxgoxkCZKHjRjzAA==
X-Received: by 2002:adf:f149:: with SMTP id y9mr4022976wro.282.1550866272871;
        Fri, 22 Feb 2019 12:11:12 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f134sm2261971wme.31.2019.02.22.12.11.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:11:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?= 
        <stdedos@gmail.com>
Subject: [PATCH 0/3] format-patch --no-clobber
Date:   Fri, 22 Feb 2019 12:11:08 -0800
Message-Id: <20190222201111.98196-1-gitster@pobox.com>
X-Mailer: git-send-email 2.21.0-rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you keep an output for an older iteration of the same topic in
the same directory around and use "git format-patch" to prepare a
newer iteration of the topic, those commits that happen to be at the
same position in the series that have not been retitled will get the
same filename---and the command opens them for writing without any
check.

Existing "-o outdir" and "-v number" options are both good ways to
avoid such name collisions, and in general helps to give good ways
to compare the latest iteration with older iteration(s), but let's
see if "--no-clobber" option that forbids overwrting existing files
would also help people.

I meant to have just a single patch for this, but it ended up to be
a three-patch series.

 - Preliminary clean-up of builtin/log.c updates messages in the
   file given to die()s and error()s that begin with capital by
   downcasing them to match majority of the messages in the system.

 - When we fail to open a patchfile for writing, we immediately stop
   and report failure, but we weren't careful about the cover letter
   output, which is fixed by the second patch.

 - The last one adds an experimental "--no-clobber" option to forbid
   the command from overwriting existing output files.  This is not
   enabled by default, as suggeted by Brian Carlson in [1], at least
   for now.

Junio C Hamano (3):
  builtin/log: downcase the beginning of error messages
  format-patch: notice failure to open cover letter for writing
  format-patch: --no-clobber refrains from overwriting output files

 Documentation/git-format-patch.txt |  8 +++-
 builtin/log.c                      | 72 +++++++++++++++++++-----------
 t/t4014-format-patch.sh            | 22 +++++++++
 3 files changed, 75 insertions(+), 27 deletions(-)



*1* <20190222001145.GD488342@genre.crustytoothpaste.net>



-- 
2.21.0-rc2


