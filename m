Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 197F11F454
	for <e@80x24.org>; Thu,  7 Nov 2019 18:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfKGSvk (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 13:51:40 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35420 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbfKGSvj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 13:51:39 -0500
Received: by mail-pg1-f193.google.com with SMTP id q22so2607693pgk.2
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 10:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TiPCmfYzMvBxDpCZ1CIUpZqG/XTg1YN4i5l/jM+IYKE=;
        b=c3PaoP6XN3DOnvI4zWk5adCrDQ56cbAJwV9PAxE1STs7JsfjOfpeyOs6z3B9ZzUGYs
         7zGuq8iqkB6SBNAMkBFZgsXBsSSjQTfJwpYSg2xF+Vgy3XSSoqxtj3+yy3U6WU4d/WAf
         9O7WPayp0nJTioLoUWUj9GnWCK4BPf7h+26qhFRg4Ca9uO/ws3mmWxK0sdBH7dY1Il9/
         NbhJRCzra9aZN0aX1f8X5KmXCooJzkGTn+LodCeZ7yG6s2+4ih3SfNxSuuGLG3G1o4Uh
         I/jYdSKbX3pZ3WQ270xCO4Nb18VofBnNsuIPVXr/a2WkwHKaHev1zPDIhZ4A5gj++sKc
         qvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TiPCmfYzMvBxDpCZ1CIUpZqG/XTg1YN4i5l/jM+IYKE=;
        b=QIJfxGEpkWQ3oNhx+ZQK+sBw5ejqHNCpSnP5esvFbKDOvSINChQjV1GOIkYB4KgPTg
         5oTiK/HMMwtT42CD1iGqUznyRoYvTKaIbEH5Cz0ZJI3ILswHNH2tHM4NVoQXXDjO1/Dx
         4vv/tvN8tSgmrEVZFM2h/X/vxoQfYWhLi1krtDsgrPcU9jlwbvfj2BS24MVmCjTGxoss
         OIOcKLvFkthp+lMd+AUpaYu5/SouKlz0EgU8/XhP718Dxto3TXds6z/sxT+LTX1VpaId
         Gp5cv6l4T04cyRo8s1reW4Kwc+zCx5P34LocHace6B+q0ln89Vw1fBrA+rrtDe9BK/XO
         hFoQ==
X-Gm-Message-State: APjAAAWOTcON35Z8HRm1L6yG1yZ9p3oXnjDjOnpS3vhC6O7T2xBJWsP0
        FmN9vA0iRjbAqt//1n45U7/6uzTa
X-Google-Smtp-Source: APXvYqyAAfgmJgwVqP0gNTWzA/59BfU0/uJ/RY5nvzIY4Dai4hKRP8S4SQhigo5uRYpcaIyci21xGw==
X-Received: by 2002:a63:fe09:: with SMTP id p9mr6220090pgh.293.1573152698841;
        Thu, 07 Nov 2019 10:51:38 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id j24sm3139192pff.71.2019.11.07.10.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 10:51:38 -0800 (PST)
Date:   Thu, 7 Nov 2019 10:51:36 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 08/14] t5520: replace test -{n,z} with test-lib functions
Message-ID: <f31142c6834c74931dfe0e353f696c354584938c.1573152599.git.liu.denton@gmail.com>
References: <cover.1571739459.git.liu.denton@gmail.com>
 <cover.1573152598.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573152598.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When wrapping a Git command in a subshell within another command, we
throw away the Git command's exit code. In case the Git command fails,
we would like to know about it rather than the failure being silent.
Extract Git commands so that their exit codes are not lost.

Instead of using `test -n` or `test -z`, replace them respectively with
invocations of test_file_not_empty() and test_must_be_empty() so that we
get better debugging information in the case of a failure.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 0ca4867e96..18225d8430 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -206,15 +206,18 @@ test_expect_success 'fail if the index has unresolved entries' '
 	test_when_finished "git checkout -f copy && git branch -D third" &&
 	test "$(cat file)" = file &&
 	test_commit modified2 file &&
-	test -z "$(git ls-files -u)" &&
+	git ls-files -u >unmerged &&
+	test_must_be_empty unmerged &&
 	test_must_fail git pull . second &&
-	test -n "$(git ls-files -u)" &&
+	git ls-files -u >unmerged &&
+	test_file_not_empty unmerged &&
 	cp file expected &&
 	test_must_fail git pull . second 2>err &&
 	test_i18ngrep "Pulling is not possible because you have unmerged files." err &&
 	test_cmp expected file &&
 	git add file &&
-	test -z "$(git ls-files -u)" &&
+	git ls-files -u >unmerged &&
+	test_must_be_empty unmerged &&
 	test_must_fail git pull . second 2>err &&
 	test_i18ngrep "You have not concluded your merge" err &&
 	test_cmp expected file
@@ -667,7 +670,8 @@ test_expect_success 'git pull --rebase detects upstreamed changes' '
 	(
 		cd dst &&
 		git pull --rebase &&
-		test -z "$(git ls-files -u)"
+		git ls-files -u >untracked &&
+		test_must_be_empty untracked
 	)
 '
 
-- 
2.24.0.rc2.262.g2d07a97ef5

