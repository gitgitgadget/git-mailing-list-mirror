Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EAA020A10
	for <e@80x24.org>; Sun,  1 Oct 2017 14:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbdJAOox (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 10:44:53 -0400
Received: from mout.web.de ([212.227.15.3]:56890 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbdJAOov (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 10:44:51 -0400
Received: from [192.168.178.36] ([91.20.57.42]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M3jsn-1d7wJ52qSv-00rHvW; Sun, 01
 Oct 2017 16:44:46 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] repository: use FREE_AND_NULL
Message-ID: <503c157c-70c8-7902-6170-3847c39ab0e0@web.de>
Date:   Sun, 1 Oct 2017 16:44:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:s27RrjUaM+yi9t35g294SGttAUcX8xSd5+77ke0wcdDMiA31sW+
 0Ts4ntXs6GkZp1eCckqSKz4vM6sC3XuygopfKzHvFk/mGlSZimyNpEvgplbP66spN3s2OBD
 25MrdENirCpdFbzyy6jASqTncRE3iKfbM9H341xRwz2ucChkgXmlFvtZtgzAcHk9cPxqXus
 mLMpFxjp8c1PZhHnGjRuQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cxT/Ebm1/mo=:LbW9f/d35mBqlReWzzNOrz
 96hTh4Tt983GJnJRl6BszwknCELfoz6sP0v2tmejQP6bkKYHztLmCg8T648QtQIN4JSKIna/T
 qs9RVf7pVMpHcoicjDKnRwr4IB0JdNLDgWn6vfO300Q39ceutZOkqOU5uxegVEyj0/MVYoLPO
 EfHeGI3UPUQPDxZkHGav+mgBkbuXrLOfhJ4YtZ5i81a/bfg/WzFZhWTo6WxYT06JbBcxxyc/h
 IRQ/gaDJhtm0Vg+UJmJdREws+r8wc095/VX9ptw2ZyZ+WcI2Up8nA21URTvG13l6fybsgYivN
 EkymZUuZqKEYR5OHZet193MM8kKBZutqxUAkf6otr2BDhY3udFYjZ9M3SAUHMB9rDsPrciZVu
 Pu5gDrL5BOBZjAlRh/w/EohYqugNPnGP4zlJrVLrrBJhyHP1Zm/m7bKVuDxFpFKPxsD9AINXn
 Pz8lBjxh1RHb4oAJM0NqZwdWI/XXlaq/GZfMpw5OU0PWzTjHF8JBnTVDt6OT98HS/qmYasfxe
 fvZdi4qAH30ijgK/854UDlzRLy4IB/rnWDIdUvGYaTfyJBK3GPUKDFYI9Q61ps6a7a7fUWQv+
 Ap171jP272dwof7ILukVppfGK4Rrg6pwtlRHOrPK/njN/8CVmlQT2OzwMeVAilmdVtG8vPX2b
 9IoWLkEQXaa87xyg66Vc89Q6xk8KPRBBmkocpDxEb/LyVGmfyOfLp8SE1s01YcFnOTOcS8oju
 PNZBO3HG7SDWtR21X5A7H6pFtIkfxBnm4TGFDH9Zy2w0kYXzJgUefq1jWKXEfbv6gAFwP0ZW6
 qHhpHbK7ukeFVnTWuRbVm0iEY67hnSECHfm5HKkXGXjLraoang=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the macro FREE_AND_NULL to release allocated objects and clear their
pointers.  This is shorter and documents the intent better by combining
the two related operations into one.

Patch generated with Coccinelle and contrib/coccinelle/free.cocci.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 repository.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/repository.c b/repository.c
index 97c732bd48..bb2fae5446 100644
--- a/repository.c
+++ b/repository.c
@@ -200,25 +200,17 @@ int repo_submodule_init(struct repository *submodule,
 
 void repo_clear(struct repository *repo)
 {
-	free(repo->gitdir);
-	repo->gitdir = NULL;
-	free(repo->commondir);
-	repo->commondir = NULL;
-	free(repo->objectdir);
-	repo->objectdir = NULL;
-	free(repo->graft_file);
-	repo->graft_file = NULL;
-	free(repo->index_file);
-	repo->index_file = NULL;
-	free(repo->worktree);
-	repo->worktree = NULL;
-	free(repo->submodule_prefix);
-	repo->submodule_prefix = NULL;
+	FREE_AND_NULL(repo->gitdir);
+	FREE_AND_NULL(repo->commondir);
+	FREE_AND_NULL(repo->objectdir);
+	FREE_AND_NULL(repo->graft_file);
+	FREE_AND_NULL(repo->index_file);
+	FREE_AND_NULL(repo->worktree);
+	FREE_AND_NULL(repo->submodule_prefix);
 
 	if (repo->config) {
 		git_configset_clear(repo->config);
-		free(repo->config);
-		repo->config = NULL;
+		FREE_AND_NULL(repo->config);
 	}
 
 	if (repo->submodule_cache) {
@@ -228,8 +220,7 @@ void repo_clear(struct repository *repo)
 
 	if (repo->index) {
 		discard_index(repo->index);
-		free(repo->index);
-		repo->index = NULL;
+		FREE_AND_NULL(repo->index);
 	}
 }
 
-- 
2.14.2
