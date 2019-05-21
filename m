Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67D1B1F462
	for <e@80x24.org>; Tue, 21 May 2019 19:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfEUTeA (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 15:34:00 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33502 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfEUTeA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 15:34:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id n17so75920edb.0
        for <git@vger.kernel.org>; Tue, 21 May 2019 12:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=eaQA2O5Be+M6j+7ktYqJQ7LkOejmVInPTcDDtIE+AVU=;
        b=Y1twHL/mVvJn6b12MxdSynNrYufeMZ5e5mUT6bsUoaWdOom2SJbAYUt9ueDMNgWonh
         hUAAIYW4pP82r2VIJ9vXfbrBtaadpylS/8KtQhrxX65dDdqkf33pIT6l/wWfzzXcn1dJ
         ZSt1HInQ6V0szgTPpYnwNo/MRdHyrDSvucEITdV0E8PhWEhAEi2T33P1ewXLAsYJoRUi
         LuXTOY7b1u5NNycK5JoZszmB/lq/Qo/FmSkZ6IfECj/1s5gpExKSHINCzXQxF0K0loOz
         jqZ+A7P78J7OmlU1UQlKYM2j5RmtiboJjBlfFD4X6daS1DdiToTyP/2o6BjAk97z153Q
         rc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eaQA2O5Be+M6j+7ktYqJQ7LkOejmVInPTcDDtIE+AVU=;
        b=aexa9nf58ZgPd7kT0LJfLHC1vRMBqIb5vgJRDf9SABYt66uy8eU06uZCMCblJ2C+Mu
         S1UzzE9EcHLCLeXACYGubnsVjTva8jTfXjI3zthH3GaOGq6T+Aa6MbN2265cC4EVmMiQ
         heJ6QPvJyta5MxhMYXeqnbNFaGt/60C3giMGi+i9Wf0U7B3c+h78G62LIKBG/gsLQ1kN
         skrTjhzc41tbpFXjC2c/40ucjS0uU+2cAaZuNsmekpTgTJCWZ08vVUItaMUOfzCG90+L
         YlBD+fd71nlpPSwYW8z7Udp2m744zSKcR9LYWLVTubkWVYLeBHk7w8rVZbBHRiXPopzB
         F1HA==
X-Gm-Message-State: APjAAAXDFlJk7nnzmjzDKEJKNoJSbSBD0M+TX1YY9d/w8VOoYUX+9zi2
        TR+g33f20QoTI5uiOsCX8oSAsoup
X-Google-Smtp-Source: APXvYqxh3TPrKKfIH3jOEpPLTs8ZRts9ta8kMP5NkeKkC+JXI05DCDp0yQL6ugFPOApZOh8OyRYCHg==
X-Received: by 2002:a17:906:6a50:: with SMTP id n16mr66951890ejs.119.1558467238645;
        Tue, 21 May 2019 12:33:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m7sm6508843edd.64.2019.05.21.12.33.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 12:33:58 -0700 (PDT)
Date:   Tue, 21 May 2019 12:33:58 -0700 (PDT)
X-Google-Original-Date: Tue, 21 May 2019 19:33:56 GMT
Message-Id: <pull.222.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] trace2: fix tracing when NO_PTHREADS is defined
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit addresses the problem reported in:
https://public-inbox.org/git/92cfdf43-8841-9c5a-7838-dda995038908@jeffhostetler.com/T/#mbaf8069f6d1bc18d5a02d3682a1f9282f5547ea9

As Duy suggested, pthread_getspecific() just returns NULL when NO_PTHREADS
is defined. And pthread_setspecific() silently does not nothing. So this
problem was hidden from view.

I have to wonder if we should update pthread_*specific() to call BUG() when
NO_PTHREADS is defined as a way to catch unguarded usages easier or make
this issue more clear.

Jeff Hostetler (1):
  trace2: fix tracing when NO_PTHREADS is defined

 trace2/tr2_tls.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)


base-commit: aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-222%2Fjeffhostetler%2Ftrace2-no-pthread-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-222/jeffhostetler/trace2-no-pthread-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/222
-- 
gitgitgadget
