Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDBC31F462
	for <e@80x24.org>; Thu, 25 Jul 2019 10:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfGYKny (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 06:43:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41980 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfGYKny (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 06:43:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so22565006pff.8
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 03:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ODqneuLXkHRyjYiUcpBpdDH8WrTWGhdYABqNhA3bla8=;
        b=i89LPlrJCbk1xKJThpRqC0ECnV96YW11DPwCFZiqed68viC4K52Q/tU6YGDG+cc8eh
         Ee7un2xngKo83Nbe3/R7NTFVDAbn6ne/aqxT2SjlVYaT2gL5QPt2otBCHYU0zRQ7n634
         WQcLNiWJXf3++KoF3O8W/NNSlnHsl4h7CULlfQajkHfQB199Jy1YIiT8RblukGGEfhV+
         RcSY0KDzIJKBcJ7J/vLguW1VQE2HZIjgx4HTxvcAgeV4LnilcO9UYDgcV66a6fPHLtMz
         lS3RX9nW1nqDjqinEMHPRkMj/DFwfvWlH3fd/3ISV6nRR+SGBpJX7xhx4Q81IUkBtEOR
         ZrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ODqneuLXkHRyjYiUcpBpdDH8WrTWGhdYABqNhA3bla8=;
        b=NKUfzSbEs9xH2KpkuwW1boKxJ9UwgIBK2JI+P6uoY20ZAvRrvH1BDqmcECi4Fgfamr
         8xrFKv/5N54FvUGc7dcXgwZ/jjlMihswa9GckgWugBBEFFT7B9urVRin0o9KGVK+NCA7
         nQQhNwzCDHq9cZ35QsO6uxG+vAD1xccxrJNuRdjMjn7X+2ntye+t6C9S8jiK+yPwXau2
         jw9hHxgvE4mmA7jrwY1ctIKMA8gAUgz3n0GmQfipEhFpN2M7wP7W0g4toaYNUQh2dyU0
         rHjmDoKlWRLRWj7to2i9aQo5CWSE9Mtz2zVbUIP0+nyt/QY+qk6U7b+JgTLun6X00iIG
         4/8A==
X-Gm-Message-State: APjAAAU1sOJF+S4CEYPqbCMo4Aru2aO2FNMJa++0efaFtt0TT3DuoFIF
        5DRqmrZ44619uBQ8qx6EBUqYOYROS6Q=
X-Google-Smtp-Source: APXvYqxXTh7Gx41n3hmbrWfEJqF1ZQrtCoVh9pE+3XgZLTT4pLxPcaEfxxMyXX2vdlvYpv3D2YZPMA==
X-Received: by 2002:a63:66c5:: with SMTP id a188mr85376133pgc.127.1564051433651;
        Thu, 25 Jul 2019 03:43:53 -0700 (PDT)
Received: from centos7.localdomain ([154.48.254.150])
        by smtp.gmail.com with ESMTPSA id f12sm44189864pgo.85.2019.07.25.03.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 03:43:53 -0700 (PDT)
From:   simon gao <simon29rock@gmail.com>
To:     git@vger.kernel.org
Cc:     simon gao <simon29rock@gmail.com>
Subject: [PATCH] stop it from failing silently when git apply patch and show err info
Date:   Thu, 25 Jul 2019 06:43:45 -0400
Message-Id: <1564051425-69139-1-git-send-email-simon29rock@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: simon gao <simon29rock@gmail.com>
---
 apply.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index 4992eca..47b16aa 100644
--- a/apply.c
+++ b/apply.c
@@ -2093,8 +2093,10 @@ static int use_patch(struct apply_state *state, struct patch *p)
 	/* Paths outside are not touched regardless of "--include" */
 	if (state->prefix && *state->prefix) {
 		const char *rest;
-		if (!skip_prefix(pathname, state->prefix, &rest) || !*rest)
+		if (!skip_prefix(pathname, state->prefix, &rest) || !*rest){
+			error(_("%s doesn't contain the prefix(%s)"), pathname, state->prefix);
 			return 0;
+		}
 	}
 
 	/* See if it matches any of exclude/include rule */
-- 
1.8.3.1

