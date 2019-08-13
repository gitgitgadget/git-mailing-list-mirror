Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C78A1F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 12:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfHMM1J (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 08:27:09 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:33594 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfHMM1I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 08:27:08 -0400
Received: by mail-wr1-f51.google.com with SMTP id n9so107685363wru.0
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 05:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lf73a4k5qNaZ0MsWkZqS8r3G+DF6g1OFUgOp7gFTHK8=;
        b=pm5D3toCn8dGpWKnz+8mAoOikRiRE04cW8GpAJvueUGEXC5wEJ2u0LunDW1RHjTgwl
         Uo5KnffDEbAXU1xqkIuT9WS2ctLCongqA8mj+fqkQ6BakULOtFkQPXLIniTdJLOiZ4e7
         I1dWeOXsJeQv205TGKl9eKDOC11wF/z/oj8gU4rW3tkwN12l/xC/KVxunBPRMqRUyDqe
         HFMi5IkshqUxBm5aJsLwpyCn3MXEgibZOqZZ1sef453U4CMKnOvkOhNzZtMKMAfVdRsd
         teuepPqUQrI+XdMJNdNwrCzo/blCHRGkkChdRgyB0lxGFn06nltyNFL/LMxmHu1YIadQ
         Tiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lf73a4k5qNaZ0MsWkZqS8r3G+DF6g1OFUgOp7gFTHK8=;
        b=WT4a8JgKfMScfjVAANfDS26KtCgst9XJNhYMqxSlrX8coGawI33qM0ZrWc2RAWzThW
         1Zci3rBsGwU0cahiQEghuVGuOsBT3eEDLvJFYw05fe0ZXmniV+Dmxtk4BJxnRgBEkX4A
         yDxAINrsEtGcXJwEtHkYFwTiiyVHq0fBIfuRvbw3lHO8/oJg7FTSQ6Etp5DnewqAgqsn
         uYhokiUHihway0M3cx85hiDnzHVkkOUd5yPhG+1HtPhqmEUhEWKObIketjTDRKZups5U
         DE8CuMzFdV0hbfuhBNYaQAPqY3ScbGAU9ITT2XHfuxyllzojRm2Focg/2BeZ59P4ufFW
         cK4Q==
X-Gm-Message-State: APjAAAV07bteIKKOXiHe5y9/hdwDM6eTiFAtKK8DnJxTD2UmP50kS0PY
        B11lvxfAdTMJ90FCjshS9gM=
X-Google-Smtp-Source: APXvYqwvDmWI1WWhlF9e8LkfPXxNxLV906M4Cgd5GR792CBRYzJ4wIUv1MUqu2mOmLz1wifLIhKIIg==
X-Received: by 2002:adf:e710:: with SMTP id c16mr37588747wrm.292.1565699226271;
        Tue, 13 Aug 2019 05:27:06 -0700 (PDT)
Received: from localhost.localdomain (x4db44abf.dyn.telefonica.de. [77.180.74.191])
        by smtp.gmail.com with ESMTPSA id r5sm1978069wmh.35.2019.08.13.05.27.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 05:27:05 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 02/11] completion: complete more values of more 'color.*' configuration variables
Date:   Tue, 13 Aug 2019 14:26:43 +0200
Message-Id: <20190813122652.16468-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.350.gf4fdc32db7
In-Reply-To: <20190813122652.16468-1-szeder.dev@gmail.com>
References: <20190813122652.16468-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most 'color.*' configuration variables, with the sole exception of
'color.pager', accept the same set of values, but our completion
script recognizes only about half of them.  We could explicitly add
all those missing variables, but let's try to reduce future
maintenance burden, and use the catch-all 'color.*' pattern instead,
so this list won't get out of sync when a similar new configuration
variable accepting the same values is introduced [1].

Furthermore, their documentation explicitly mentions that they all
accept the standard boolean values 'false' and 'true' as well, so list
these, too, among the possible values.

[1] OTOH, there will be a maintenance burden if ever a new
    'color.something' is introduced which doesn't accept the same set
    of values.  We'll see which one happens first...

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Notes:
    I find the documentation of these configuration variables confusing.
    A so-called "boolean" (quoting the docs), that besides 'false' and
    'true' (and their standard 0,no,1,yes and non-standard 'never'/'auto'
    synonyms) can have a third possible value 'always', too, is, well, not
    a boolean.

 contrib/completion/git-completion.bash | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index cd9d8e1940..c59347daee 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2277,11 +2277,6 @@ _git_config ()
 		__gitcomp "$__git_merge_strategies"
 		return
 		;;
-	color.branch|color.diff|color.interactive|\
-	color.showbranch|color.status|color.ui)
-		__gitcomp "always never auto"
-		return
-		;;
 	color.pager)
 		__gitcomp "false true"
 		return
@@ -2293,6 +2288,10 @@ _git_config ()
 			"
 		return
 		;;
+	color.*)
+		__gitcomp "false true always never auto"
+		return
+		;;
 	diff.submodule)
 		__gitcomp "$__git_diff_submodule_formats"
 		return
-- 
2.23.0.rc2.350.gf4fdc32db7

