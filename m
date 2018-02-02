Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC7231F404
	for <e@80x24.org>; Fri,  2 Feb 2018 02:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbeBBCp5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 21:45:57 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37213 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbeBBCpz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 21:45:55 -0500
Received: by mail-wm0-f53.google.com with SMTP id v71so9468879wmv.2
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 18:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ig5SMsXyY/QqQK1Fz5w95xZKaMeBzAlYFFH5A1kbDBs=;
        b=i+1zvnQPnJrr8cvWUKFDz13mt5uCVdQ2wRKorF/uqvQKKwViumCx2s3cVsOlB0Sp8b
         i/lx9oeA4CvjBsOJe8j84MUewJQZ8gvjA7NGzDR3VnAH7z6MYTaEKmJ7TSegaYXET3Os
         T567vPDSzBeuChGTdxz7S4u/mQDfza2kfw5xEPSnfC3+XimwG2jMTyn1ahkf4+EeKlWe
         BZ3MinkhHEkqvWW2nffhVmYvQEfI/CAjH1H576j8Zve+t2KCvaSzZxcX96v9qGDlKhfw
         OlneDmKyT8CNOyb3qiaOMYKXoAQToX8l5vJLeaxKbTJmyNiU2vkVrJaqlO4d6jBfaTDD
         CdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ig5SMsXyY/QqQK1Fz5w95xZKaMeBzAlYFFH5A1kbDBs=;
        b=gBZqBfInlIB0zANQaZoEFRB7/E8uI2JiGfa/KYAO5QXNpOChvMiF7qPxMOUs47doiz
         juxi84RTtex6gM1E+yu7xw94AtAkJ1qd2t7k8Wp9oAG0dR64KNeMdeWfRgzW4BXJ91vL
         ILV3z7HjsmiJe9zNh0Wl8l504I/g66ewSlR4lknPsL6rndHKgEktwi/FwG0N+IhLKG7Q
         RuJm3ZHDVhJVDl31zhsqZcT20YT0B8ijFW/UMID6ZcEMcDCda0jV5ZZrct8jixXMP/03
         VysscelbFJF8Frk3r/u7vOhiyE6TAAvW+hecpNE6ij53f/GZLYuMJ/2KFiv83SojVLtN
         742g==
X-Gm-Message-State: AKwxytedgRg6wrwa3AqCGXEzXxj/AY10UOwWEeLjiuwjffL+NkTIs6SS
        clXH5MQaiyi9G2En6rdCleI=
X-Google-Smtp-Source: AH8x227NyaD25wWpBFsTiMqA9xyAYRQxmaWxfSkqkFY3/dRc02UvSVf5+QBnk+MLtZ3KNILGksZpug==
X-Received: by 10.28.37.5 with SMTP id l5mr18806421wml.143.1517539554436;
        Thu, 01 Feb 2018 18:45:54 -0800 (PST)
Received: from localhost.localdomain (x4db049fc.dyn.telefonica.de. [77.176.73.252])
        by smtp.gmail.com with ESMTPSA id 77sm546025wmt.37.2018.02.01.18.45.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 18:45:53 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, sbeller@google.com, dstolee@microsoft.com
Subject: Re: [PATCH v2 07/14] commit-graph: implement git-commit-graph --update-head
Date:   Fri,  2 Feb 2018 03:45:48 +0100
Message-Id: <20180202024548.2663-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <1517348383-112294-8-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com> <1517348383-112294-8-git-send-email-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index da565624e3..d1a23bcdaf 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh


> @@ -107,6 +112,9 @@ test_expect_success 'setup bare repo' \
>  test_expect_success 'write graph in bare repo' \
>      'graphbare=$(git commit-graph --write) &&
>       test_path_is_file ${baredir}/graph-${graphbare}.graph &&
> +     test_path_is_file ${baredir}/graph-head &&

This test and the one preceeding it are wrong.

Note that 'git commit-graph --write' above is missing the
'--update-head' option, so there should be no graph-head file written,
yet this 'this test_path_is_file' doesn't fail the test.

The devil lies in the previous test 'setup bare repo', where this bare
repo is created by cloning from a local remote: a simple 'git clone
--bare full bare' hardlinks all files under .git/objects, including
all graph and graph-head files that exist in the remote repo.

The previous test should run 'git clone --bare --no-local full bare'
instead, and then this test would fail because of the missing
graph-head file, as it should.  Specifying '--update-head' will make
it work again.


> +     echo ${graphbare} >expect &&
> +     cmp -n 40 expect ${baredir}/graph-head &&
>       git commit-graph --read --graph-hash=${graphbare} >output &&
>       _graph_read_expect "18" "${baredir}" &&
>       cmp expect output'


