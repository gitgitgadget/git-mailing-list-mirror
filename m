Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F0741F404
	for <e@80x24.org>; Tue, 27 Feb 2018 21:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbeB0VR7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 16:17:59 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36038 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751777AbeB0VR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 16:17:59 -0500
Received: by mail-wm0-f68.google.com with SMTP id 188so1237204wme.1
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 13:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=rs8rHEwJB9BUwyuFwcLNWDnLd9wKqZz6FKYTvSglL3M=;
        b=rabBsJ1xLVnm61y3g+wcF1oWZ94YIzbGuUFKFA8/AUpEtvHNZmKGrISJH7P9uklWzf
         EwWz7XQbbczpnqKXXOCq3alN+15Uj4TGFxyEl37TLzL76Kjp7sUdcezRkLTKCF/o7jR0
         uWk+N1WJdwHA4DTh7VBg0fSag3XJxmStyqHt6zOAv6IFYvS8ZA8q1N+5jAGNvI8D78ac
         3RoErAJH4/6avN7has2tkwy/SxpYdWPnYjVzmvOXQabCLrny0Bu9Fl/3BSKMwfn8wL3u
         bsn/DwWT458cBS3Dy8Vx3WmRjDzKNe+FjRvt+Cbz5SFg35EfRwaW9w4uIhagNP1YuQit
         THJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=rs8rHEwJB9BUwyuFwcLNWDnLd9wKqZz6FKYTvSglL3M=;
        b=GSZZ9eLDtD6eCJVTo49SHg1b5T/Om6v3JuSXQnGY99fU3fJz2fxcmpdufZ4b6HaDW5
         7RgC/LWiU7/6de2UWI/PLOq2SMDpOQ4Q2RsEazmf16gysW5PhToNUUcI3qyCxMvd5RrB
         M+RQWz/53DRSGjfRn33v+AECfJ22ai7L5xvh84tO3USX+gK5H4hGtKcAESg5q5UM7LJ5
         ecVjUunr53PJQ2TJkePM/gLMK7JbLWAeUuN78q5/yNDkvHLPVlBkOqSZscl7Wrw4RD+6
         HfaYMEq9QAQVzm6BCaxqQ8u1AATJhRg/ihXjmh5/Xtikzldb13El01qdQERHj90u4Tat
         fhEw==
X-Gm-Message-State: APf1xPBIKRgE3QG38NSDuwzOI5awEwYlpEfaX9nFE/s6cgc9i/ngZloR
        Fl813Y+ltsWTsGs7w31kyho=
X-Google-Smtp-Source: AG47ELsrvq2AL5m3kUQI6S2kCzv9ZHLquDZYpBlgGn6dxZNvtaQzJyrTr0Dk710nRjfbvj829v9vNQ==
X-Received: by 10.28.21.67 with SMTP id 64mr7656545wmv.151.1519766277577;
        Tue, 27 Feb 2018 13:17:57 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h38sm76149wrh.61.2018.02.27.13.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 13:17:57 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 04/11] t3030-merge-recursive: don't check the stderr of a subshell
References: <20180223233951.11154-1-szeder.dev@gmail.com>
        <20180223233951.11154-5-szeder.dev@gmail.com>
Date:   Tue, 27 Feb 2018 13:17:56 -0800
In-Reply-To: <20180223233951.11154-5-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Sat, 24 Feb 2018 00:39:44 +0100")
Message-ID: <xmqqlgfep1x7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> +		git read-tree -i -m $c3 2>actual-err &&
> +		test_must_be_empty expected-err &&
> +		git update-index --ignore-missing --refresh 2>>actual-err &&
> +		test_must_be_empty expected-err &&
> +		git merge-recursive $c0 -- $c3 $c7 2>>actual-err &&
> +		test_must_be_empty expected-err &&
> +		git ls-files -s >actual-files 2>>actual-err &&
> +		test_must_be_empty expected-err

Also, with the error output of individual steps tested like this
(assuming that test-must-be-empty checks are to be done on
the actual-err file, not ecpected-err that nobody creates), I do not
see a point in appending to the file.  So perhaps squash this in?

 t/t3030-merge-recursive.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index cbeea1cf94..3563e77b37 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -526,13 +526,13 @@ test_expect_success 'merge-recursive w/ empty work tree - ours has rename' '
 		export GIT_INDEX_FILE &&
 		mkdir "$GIT_WORK_TREE" &&
 		git read-tree -i -m $c7 2>actual-err &&
-		test_must_be_empty expected-err &&
+		test_must_be_empty actual-err &&
 		git update-index --ignore-missing --refresh 2>actual-err &&
-		test_must_be_empty expected-err &&
+		test_must_be_empty actual-err &&
 		git merge-recursive $c0 -- $c7 $c3 2>actual-err &&
-		test_must_be_empty expected-err &&
+		test_must_be_empty actual-err &&
 		git ls-files -s >actual-files 2>actual-err &&
-		test_must_be_empty expected-err
+		test_must_be_empty actual-err
 	) &&
 	cat >expected-files <<-EOF &&
 	100644 $o3 0	b/c
@@ -551,13 +551,13 @@ test_expect_success 'merge-recursive w/ empty work tree - theirs has rename' '
 		export GIT_INDEX_FILE &&
 		mkdir "$GIT_WORK_TREE" &&
 		git read-tree -i -m $c3 2>actual-err &&
-		test_must_be_empty expected-err &&
-		git update-index --ignore-missing --refresh 2>>actual-err &&
-		test_must_be_empty expected-err &&
-		git merge-recursive $c0 -- $c3 $c7 2>>actual-err &&
-		test_must_be_empty expected-err &&
-		git ls-files -s >actual-files 2>>actual-err &&
-		test_must_be_empty expected-err
+		test_must_be_empty actual-err &&
+		git update-index --ignore-missing --refresh 2>actual-err &&
+		test_must_be_empty actual-err &&
+		git merge-recursive $c0 -- $c3 $c7 2>actual-err &&
+		test_must_be_empty actual-err &&
+		git ls-files -s >actual-files 2>actual-err &&
+		test_must_be_empty actual-err
 	) &&
 	cat >expected-files <<-EOF &&
 	100644 $o3 0	b/c
