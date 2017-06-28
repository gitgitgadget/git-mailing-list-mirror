Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1633620285
	for <e@80x24.org>; Wed, 28 Jun 2017 21:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbdF1V6d (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 17:58:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35374 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751652AbdF1V6a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 17:58:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id 131so13851085wmq.2
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 14:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=N90EacLkGnvnrStH/dGSMDn20DdHA57D/k8yqq5A+50=;
        b=PNqqKCSBR7kIeIBDqcFpC85iVVMlINptOGgpfZfywRuj+7V/gL4uKu5PLjMAhmKmWf
         H+bb4MBZlBTU9Evc3S7kzGr5wtRlnR8HiCP7pkQSk7f4OAFmjbjU5tlNUtg+vAZ3jtjQ
         t6HBHv9NddmU3yAaEMiCMqqD+EEgjFQQjyTGGiVx/2O55P3hR2+8bpMOiZzZ/7kZT7Np
         09rwRasilO0HNBXP8SjfGFp99HiB3kUd20xXoDxcqpAs5KIRkxzreSiEH3UvOmbnxZK2
         Get+pwpRUmwzQgGX6r1nn5eHv6+TtdTgfsiNFx6/BPe8P4gCBVEhwKTFlaRoqZ8yQ+/8
         Gq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=N90EacLkGnvnrStH/dGSMDn20DdHA57D/k8yqq5A+50=;
        b=kKFed9C7UAdHv0fSMl8OiNe7rPtky3iTaxVVmiE70ycCHykuxAfayiky6mN3KQIHec
         49eIQcRAHDcoeuIyA+oLFafwZ/wWcoeWayp76fnx/bbHAjWlHl2RzPR/rVx5fEIeHqG/
         KDTW/vIKwJ6C+THzlU4pDmkZVgLX3h9LH4Wa5pCSb7Fyf83ETyOV3HEagrxXOGYClDbC
         5Dnd8sTxesfWGFSQOa+cNgfqSnBAi+IWkz+l7VvqGPrP/ZEtw5JWE6rfwC5RfGtdC76j
         ncn5KrjNpm6oJE0MzUxCealYhVj0alJ/NoP+Nl3HdazAC3nT8BgxPy4a2fF+RtY4TKiW
         FBag==
X-Gm-Message-State: AKS2vOyP0tX+zO670djIffLdPfmz5xixfHqt1GGVOmpKKiyDTi2J9psk
        fMgUYsgB8fgkNpd+Cps=
X-Received: by 10.80.137.173 with SMTP id g42mr9200644edg.125.1498687109126;
        Wed, 28 Jun 2017 14:58:29 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id g25sm1926975eda.59.2017.06.28.14.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jun 2017 14:58:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        J Smith <dark.panda@gmail.com>,
        Joe Ratterman <jratt0@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] grep: remove redundant "fixed" field re-assignment to 0
Date:   Wed, 28 Jun 2017 21:58:07 +0000
Message-Id: <20170628215809.23060-4-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170628215809.23060-1-avarab@gmail.com>
References: <20170628215809.23060-1-avarab@gmail.com>
In-Reply-To: <CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn7wmkA=1KO2g@mail.gmail.com>
References: <CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn7wmkA=1KO2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the redundant re-assignment of the fixed field to zero right
after the entire struct has been set to zero via memset(...).

Unlike some nearby commits this pattern doesn't date back to the
pattern described in e0b9f8ae09 ("grep: remove redundant regflags
assignments", 2017-05-25), instead it was apparently cargo-culted in
9eceddeec6 ("Use kwset in grep", 2011-08-21).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/grep.c b/grep.c
index 6614042fdc..7cd8a6512f 100644
--- a/grep.c
+++ b/grep.c
@@ -627,8 +627,6 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	    has_null(p->pattern, p->patternlen) ||
 	    is_fixed(p->pattern, p->patternlen))
 		p->fixed = !icase || ascii_only;
-	else
-		p->fixed = 0;
 
 	if (p->fixed) {
 		p->kws = kwsalloc(icase ? tolower_trans_tbl : NULL);
-- 
2.13.1.611.g7e3b11ae1

