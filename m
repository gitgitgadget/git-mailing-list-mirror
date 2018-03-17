Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F7AB1F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 08:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbeCQIRv (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 04:17:51 -0400
Received: from mout.gmx.net ([212.227.15.15]:45401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751813AbeCQIRv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 04:17:51 -0400
Received: from Sonnenschein.localdomain ([87.175.177.109]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LcSAg-1eESLK2zmY-00ju9x; Sat, 17 Mar 2018 09:17:48 +0100
From:   Clemens Buchacher <drizzd@gmx.net>
To:     git@vger.kernel.org
Cc:     manlio.perillo@gmail.com, johannes.schindelin@gmx.de,
        Clemens Buchacher <drizzd@gmx.net>
Subject: [PATCH 2/2] completion: simplify ls-files filter
Date:   Sat, 17 Mar 2018 09:17:04 +0100
Message-Id: <1521274624-1370-2-git-send-email-drizzd@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521274624-1370-1-git-send-email-drizzd@gmx.net>
References: <1521274624-1370-1-git-send-email-drizzd@gmx.net>
X-Provags-ID: V03:K0:LoFFjFToQsx9K7cPVwRs3/XcXNK7YNxFKK8dbUGXsxONm8SzBOn
 F5PI3CkDnRRnJ1KPEYgLsdvgDTnlt6JzZ2+R47nEsp3pdUnJ55LaSIf3z6Ts/PbBGR0v+bS
 dwrk6VKE3/A4MhV4ZACNeyTyWptooWOiOxZxChT8fUBjIrM464005NBVAjtyfa8qS59fAg/
 Ukeb7/8sizvWQRi0dAMeA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AiMI2pgfVdo=:BtvW26lUUzDwP5WDSXA2zC
 d7LhG9i2lnRQOVdZebD2WcZeX8zQAmapmHScMgymQGgbhTXVUta27JElBgJR/PoOzwh+PmW+m
 tIjHT8oRNxB3lnUS6eFLU+vJQlysVddabuwY13B4E9oZmGj6CJJ2RQfzkYj/ZU0UlKUwq6ZJl
 PAyQGATVgmK9f7BY3RbJfpZszVsvNLNarPwtlWRRQIJ0Kzx4zWIw81WskRrqoiziVqfODM814
 3kOaC2nx7/wrXXgQDvKe5bg7zFcxGkPBGEkPkRJr5VBwIv2QNzfmQ0XwXs4TyE+gR2y7iekSS
 UACBHS/LP5p3dLzHRJ1TZsi5lhll8BCFBFMCVwXZ5mVozjq3AxvUpvOiwadIOE1N6Drz3QFjB
 9SED7/KBCMvZm/Hg85K1Fxd1RJ/JvU7Jfpqfb6rWIk/EfadvlkcqD5Fl3zpOURTWJ4jaiNJZD
 zD4rcr6TrXL/lXjnfAEsdP3QVJsLidxKx+ojz0KWdvfVTtBpZmoJQ6Fl7dlhAGezLT/JKtzW9
 asmSw7S7dmr/7AHVcFQONywqTQZDdiJABjhV2b0FI3dVbnJ4XIctDBKLh+maD731PyrPDw4jG
 rofqWbyrQ1W6JZ0WWMHXTQUE80+7t4TxcOsBACAh5X+LqIRqGjVnh6u6aFhiFCKx+/P4IB9CW
 Sd7bJyauz9f3ZE38vW0joGB72mtfp+W+JB9OMqgX6tSN8t9OUzxVJwT+JsUn61E4GZLimFM0A
 +kJGnDQdHmL8E/ZvIQL+fvxhiJxaDB2WmPOxgIBHLM5oZ6yNF+DM1CdfGAAfkRVggR3A3FbRv
 zB3DmhShDJO1hiEK55LWZsxWZIGTQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When filtering the ls-files output we take care not to touch absolute
paths. This is redundant, because ls-files will never output absolute
paths. Furthermore, sorting the output is also redundant, because the
output of ls-files is already sorted.

Remove the unnecessary operations.

Signed-off-by: Clemens Buchacher <drizzd@gmx.net>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e3ddf27..394c3df 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -384,7 +384,7 @@ __git_index_files ()
 	local root="${2-.}" file
 
 	__git_ls_files_helper "$root" "$1" |
-	sed -e '/^\//! s#/.*##' | sort | uniq
+	cut -f1 -d/ | uniq
 }
 
 # Lists branches from the local repository.
-- 
2.7.4

