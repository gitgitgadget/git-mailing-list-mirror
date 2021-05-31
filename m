Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E38C47083
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13CDA61108
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbhEaR3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhEaR27 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:28:59 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8833C08EAF5
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:09:11 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id j189so11630979qkf.2
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yX60pwwVYg3meDSj7kEsQb0M0949bhAED8ZLB+YhpRg=;
        b=yn4SXSYenvx1uncbT4aU1AEk24hJGOocfg31vOnEmr8mpW02WJxxh83LtGl2eb2dPP
         htKB3vLqxn8XOeJrLVwqwd2yDS0jxdqkv9SpE9bxK7kKCYGQRihee/vlxwcR0LQH2KZH
         7OK36sEJt5qrl020fUsCqfqEkEoT7Hy0C66qJSJWgMrgVQ9+phoxci/40nfewFafSR0b
         Q1eD+ZYyXgoccCCGE8/AmTDpeYLoNxFtiatit1HZFiZk0uck5wsubq4jIkLJzDKwtWzI
         4OMqlcf9jsj7x2ybFL1fWLBr/XLB+p59q6kCJT2qLRo27KCEsBiXo99MOM11kb0c3Uil
         cORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yX60pwwVYg3meDSj7kEsQb0M0949bhAED8ZLB+YhpRg=;
        b=iFfX9Pp0uDXzG1mdttmFMEQGoF7aB4K6FFxJc+vPyx/3a6w5ehDdV2ytSe3cerXX1F
         st0nZk17g1Ljn5WY7/04c6I3scRefvVHPQ3B5E/p7TV/VGdK+oMvP5pS0xQrfJE9lceu
         7X6xucfvNWZWfeKvZiOH9rYIQ3ioCYEakSah7Msvz7YfeziWolXN3p5PjoziLwZCRRzY
         +mVJIMqP4X12dHkbW29KH9vRTMfdDOKQ03d8nHFQ6sZsiCVbpWc+l+A4HhNKZ2DXXx4V
         JEe84AmO6pgaCu8RaE0Up9RGyXKnuHVMtiPSHbMAjzWro4RZ5oUJ7YMFef75rkBbuDXw
         WxXw==
X-Gm-Message-State: AOAM533EHn5Cb0fqG7JeTX2NljSG2ZdYEzYDbEUHClBp4Y1yyAqGNO+2
        NGu9Ow/QGAVPY+9y0OR+CeqWdg==
X-Google-Smtp-Source: ABdhPJydQcJdpisCnbbEVDDx5HrAwi5CxC7q9A3o2KMQepVqbQeML8vkqPxHPDgVvqekdbSGA4qkxw==
X-Received: by 2002:a05:620a:5fc:: with SMTP id z28mr16936025qkg.378.1622477350306;
        Mon, 31 May 2021 09:09:10 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id h5sm9602295qkg.122.2021.05.31.09.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:09:09 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     avarab@gmail.com
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] t2080: fix cp invocation to copy symlinks instead of following them
Date:   Mon, 31 May 2021 13:09:03 -0300
Message-Id: <20210531160903.42347-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <871r9n2dlu.fsf@evledraar.gmail.com>
References: <871r9n2dlu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 31, 2021 at 11:16 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>
> There's still a failure[1] in t2082-parallel-checkout-attributes.sh
> though, which is new in 2.32.0-rc*. The difference is in an unexpected
> BOM:
>
>    avar@gcc119:[/scratch/avar/git/t]perl -nle 'print unpack "H*"' trash\ directory.t2082-parallel-checkout-attributes/encoding/A.internal
>    efbbbf74657874
>    avar@gcc119:[/scratch/avar/git/t]perl -nle 'print unpack "H*"' trash\ directory.t2082-parallel-checkout-attributes/encoding/utf8-text 
>    74657874
>
> I.e. the A.internal starts with 0xefbbbf. The 2nd test of t0028*.sh also
> fails similarly[2], so perhaps it's some old/iconv/whatever issue not
> per-se related to any change of yours.

I ran t2080 on the same machine (gcc119) to try debugging it but I could
not reproduce the test failure [1]. t0028 also passed here. Could it be
that we are building git differently? I did `gmake CC=gcc NO_CURL=YesPlease`.

The encoding inspection also seems OK here:

matheustavares@gcc119:[/home/matheustavares/git/t]perl -nle 'print unpack "H*"' trash\ directory.t2082-parallel-checkout-attributes/encoding/A.internal
74657874
matheustavares@gcc119:[/home/matheustavares/git/t]perl -nle 'print unpack "H*"' trash\ directory.t2082-parallel-checkout-attributes/encoding/utf8-text
74657874

[1]:
Initialized empty Git repository in /home/matheustavares/git/t/trash directory.t2082-parallel-checkout-attributes/encoding/.git/
+ cd encoding
+ echo text
+ 1> utf8-text
+ write_utf16
+ 0< utf8-text 1> utf16-text
checking prerequisite: NO_UTF16_BOM

mkdir -p "$TRASH_DIRECTORY/prereq-test-dir-NO_UTF16_BOM" &&
(
        cd "$TRASH_DIRECTORY/prereq-test-dir-NO_UTF16_BOM" &&
        test $(printf abc | iconv -f UTF-8 -t UTF-16 | wc -c) = 6

)
+ mkdir -p /home/matheustavares/git/t/trash directory.t2082-parallel-checkout-attributes/prereq-test-dir-NO_UTF16_BOM
+ cd /home/matheustavares/git/t/trash directory.t2082-parallel-checkout-attributes/prereq-test-dir-NO_UTF16_BOM
+ wc -c
+ iconv -f UTF-8 -t UTF-16
+ printf abc
+ test 6 = 6
prerequisite NO_UTF16_BOM ok
+ echo A working-tree-encoding=UTF-16
+ 1> .gitattributes
+ cp utf16-text A
+ cp utf8-text B
+ git add A B .gitattributes
+ git commit -m encoding
[master (root-commit) eb6a843] encoding
 Author: A U Thor <author@example.com>
 3 files changed, 3 insertions(+)
 create mode 100644 .gitattributes
 create mode 100644 A
 create mode 100644 B
+ git cat-file -p :A
+ 1> A.internal
+ test_cmp_bin utf8-text A.internal
+ rm A B
+ test_checkout_workers 2 git checkout A B
Updated 2 paths from the index
+ test_cmp_bin utf16-text A
+ test_cmp_bin utf8-text B
+ test_unconfig --global checkout.thresholdForParallelism
+ exit 0
+ eval_ret=0
+ test_unconfig --global checkout.workers
+ exit 0
+ eval_ret=0
+ :
ok 2 - parallel-checkout with re-encoding
