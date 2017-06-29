Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C87981F623
	for <e@80x24.org>; Thu, 29 Jun 2017 22:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbdF2WWm (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 18:22:42 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35144 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751813AbdF2WWk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 18:22:40 -0400
Received: by mail-wm0-f67.google.com with SMTP id u23so4979893wma.2
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 15:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Z06MgsF1riZ7EiREHgzkmRAYNOm6hHGcwy9BibuJQGw=;
        b=RE5MZkH+4ky70eER8H2UZMqSU5Su0jTwCVn7adm7L1Yp5la0UaeqctGp5rjurQ7oKC
         0nf1bJRclaol0EvqQJgjTFiAxfmddGbSrvNoDGTw9RYLL4IMR0g/cWWewS6a9cJKW287
         93r4G+Sx545zduPvkJtAAAW4C3vwCYchW9WMz5MDpUreO+YN4StoRVPa0KdSXAsyXZrL
         zXZE5Bz3fdMaTuCAVtHQ7w9twg9ENpHO5OLuFV51ZIXoS0ZZ31rehM0AdBFWWqCtvVRj
         HCoEg9Mv2UtQhOLki1/X475+DiJtoml4Q72VZxB85qqU5pwt0tEHDVfJ0miwDbRuKbH8
         O5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Z06MgsF1riZ7EiREHgzkmRAYNOm6hHGcwy9BibuJQGw=;
        b=p3JlLVraeTKwsiV4RCWJQMKuXPD6aDSlsHXfGVt4530wMGnOjKltkVcm7dakP2cgOM
         wzk29Vgs7eEMnjd+dxs86w+NwMPBAZ4csspB5ZFJ982izkWsOtxc5Jdnlgga7iF0ezRd
         XjlplgEQvYsGgw2DZbqtl3Uqie+Qc3UPd/3aGrgl0qWussAQ4AJX2H+gn4RXAIz80avP
         75cvm16vJBhO69H/5VkV9PGjwYKkDg7PhtWcfsPBqqYTbEhP3dKl3J2wsM3z1gsWTR3C
         /86l/IorS+coGcRh/xYIl7gGe9zT+lfHcyY28L9jIS53QkuguHezGwnJyzH8r0hSXLEd
         oRUg==
X-Gm-Message-State: AKS2vOzzeKwQIUe+3MMOrJalA8hq9+reyfSpEufv0mWBO4/ayZQSE7mX
        eLzLy1zAcf5ofd+9KIo=
X-Received: by 10.80.212.10 with SMTP id t10mr3093016edh.172.1498774959184;
        Thu, 29 Jun 2017 15:22:39 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c36sm1181183edb.31.2017.06.29.15.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jun 2017 15:22:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        J Smith <dark.panda@gmail.com>,
        Joe Ratterman <jratt0@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/6] grep: remove redundant "fixed" field re-assignment to 0
Date:   Thu, 29 Jun 2017 22:22:19 +0000
Message-Id: <20170629222222.4694-4-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170629222222.4694-1-avarab@gmail.com>
References: <20170629222222.4694-1-avarab@gmail.com>
In-Reply-To: <20170628215809.23060-1-avarab@gmail.com>
References: <20170628215809.23060-1-avarab@gmail.com>
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
index 817270d081..86dc9b696f 100644
--- a/grep.c
+++ b/grep.c
@@ -626,8 +626,6 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	    has_null(p->pattern, p->patternlen) ||
 	    is_fixed(p->pattern, p->patternlen))
 		p->fixed = !icase || ascii_only;
-	else
-		p->fixed = 0;
 
 	if (p->fixed) {
 		p->kws = kwsalloc(icase ? tolower_trans_tbl : NULL);
-- 
2.13.1.611.g7e3b11ae1

