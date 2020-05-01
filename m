Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52408C47253
	for <git@archiver.kernel.org>; Fri,  1 May 2020 14:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 232F7208DB
	for <git@archiver.kernel.org>; Fri,  1 May 2020 14:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnB19jR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgEAOVH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 10:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728737AbgEAOVG (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 May 2020 10:21:06 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6107AC061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 07:21:06 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id m5so4550402ilj.10
        for <git@vger.kernel.org>; Fri, 01 May 2020 07:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E8ENykxIwCIl0SuaqeY5/fFL8I9SuePOORi0Uvgepms=;
        b=mnB19jR59OnTvMpvBEvkqhsizFF31j6cHVfpyJ1sbt0iN+IM1yZ8LG47JoZrIqIzeS
         0Y1b50JaDjJ7donWxV0IIMSbdc8Ix2Q1dk7HHWjCR822hUxQ3xVh0sJgvcWUpo5svvtj
         pqfZKORewAVMqLVP9xFVh+QCsXMxhwP6hVSWCxmaknsgSxqLtV8/kpORT8JrEbKQDeRO
         Nnols8coNY5vIKDfVCTRK9QC312aerkNHFyfjgYL38rFK9xM94Cy58aMyJUfbcpeq3VZ
         jpF8980aH0iUaSNQ6SGbklkddncCKprRsDHxebKO4Y85/yPD4V451s/xE/IbiEl/e17J
         PuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E8ENykxIwCIl0SuaqeY5/fFL8I9SuePOORi0Uvgepms=;
        b=NGA4MBYhv7+cDZPmPwJyG0uYw3yrfuhrmIC0DBu/ac5lKga9AuE87sGh0XcUAHH94L
         8ivs/dleiJQlcMsBq3UR/Y2f9F1b2QVh0akPs/vthHCfOk/oHCU/Okrxyvz7qjl/JefI
         gvIHyokhSJKvkOgNwkNKpWhaBzHE3Is7CIC+02++LOfqres2IiY4iWQ74qRTGarZ+Lw6
         OR4Zn6+xy2oHn1UJLL8ktB8nvXFSCJQmVfo8CkWPUjIVP+xCSlHptAKrL3qkAlU9MZxP
         5FGW1SgHqnvcXkNo8sndObo72eaLoS0mC9I2yU07+DyX/gEMSeKP00x31xTeKJhQw0Zt
         Pijw==
X-Gm-Message-State: AGi0PuYqgItolmebdjaikIY5w0EW+NidBHFwJtDYerKop+FnLKAwytjC
        aJpwQeE444PBZnbIwmR6+qA=
X-Google-Smtp-Source: APiQypLDe0hrPTTmXl4DUK0rlotYBT4wH7nWXuJoTR4ahIq50bSS36RFUZa5rIxjquIdqFg6yLJ6Dw==
X-Received: by 2002:a92:8885:: with SMTP id m5mr3513547ilh.154.1588342865611;
        Fri, 01 May 2020 07:21:05 -0700 (PDT)
Received: from ?IPv6:2601:8c0:37f:6012:e01d:d556:c354:b051? ([2601:8c0:37f:6012:e01d:d556:c354:b051])
        by smtp.gmail.com with ESMTPSA id e16sm1007941iol.38.2020.05.01.07.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 07:21:05 -0700 (PDT)
Subject: [PATCH 1/3 v3] Clean up t6016-rev-list-graph-simplify-history
From:   Antonio Russo <antonio.e.russo@gmail.com>
To:     git-ml <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Derrick Stolee <dstolee@microsoft.com>
References: <df0b9e59-e6d7-8839-ca3b-86145dc3bdf3@gmail.com>
 <d3079ba8-33e1-3b68-23d2-ea97b9ca1e97@gmail.com>
Message-ID: <3a2605b6-c612-f70c-a11e-1e1cc3f59184@gmail.com>
Date:   Fri, 1 May 2020 08:21:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d3079ba8-33e1-3b68-23d2-ea97b9ca1e97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplifies the logic used to test rev-list, making adding new tests
easier.  Uses a heredoc and postprocessing of the rev-list output
instead of shell substitutions and manually escaped echo's.

Signed-off-by: Antonio Russo <antonio.e.russo@gmail.com>
---
 t/t6016-rev-list-graph-simplify-history.sh | 349 ++++++++++-----------
 1 file changed, 166 insertions(+), 183 deletions(-)

diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
index f5e6e92f5b..eac271a4fa 100755
--- a/t/t6016-rev-list-graph-simplify-history.sh
+++ b/t/t6016-rev-list-graph-simplify-history.sh
@@ -9,6 +9,12 @@ test_description='--graph and simplified history'

 . ./test-lib.sh

+check_graph () {
+	cat >expected &&
+	git rev-list --graph "$@" | sed "$(cat sedscript)" > actual &&
+	test_cmp expected actual
+}
+
 test_expect_success 'set up rev-list --graph test' '
 	# 3 commits on branch A
 	test_commit A1 foo.txt &&
@@ -43,76 +49,62 @@ test_expect_success 'set up rev-list --graph test' '

 	test_commit A7 bar.txt &&

-	# Store commit names in variables for later use
-	A1=$(git rev-parse --verify A1) &&
-	A2=$(git rev-parse --verify A2) &&
-	A3=$(git rev-parse --verify A3) &&
-	A4=$(git rev-parse --verify A4) &&
-	A5=$(git rev-parse --verify A5) &&
-	A6=$(git rev-parse --verify A6) &&
-	A7=$(git rev-parse --verify A7) &&
-	B1=$(git rev-parse --verify B1) &&
-	B2=$(git rev-parse --verify B2) &&
-	C1=$(git rev-parse --verify C1) &&
-	C2=$(git rev-parse --verify C2) &&
-	C3=$(git rev-parse --verify C3) &&
-	C4=$(git rev-parse --verify C4)
-	'
+	echo "s/ *$//;" > sedscript &&
+	( for tag in $(git tag -l) ; do echo "s/$(git rev-parse --verify $tag)/$tag/;" >> sedscript ; done )
+'

 test_expect_success '--graph --all' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "*   $A6" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "| * $C3" >> expected &&
-	echo "* | $A5" >> expected &&
-	echo "| |   " >> expected &&
-	echo "|  \\  " >> expected &&
-	echo "*-. | $A4" >> expected &&
-	echo "|\\ \\| " >> expected &&
-	echo "| | * $C2" >> expected &&
-	echo "| | * $C1" >> expected &&
-	echo "| * | $B2" >> expected &&
-	echo "| * | $B1" >> expected &&
-	echo "* | | $A3" >> expected &&
-	echo "| |/  " >> expected &&
-	echo "|/|   " >> expected &&
-	echo "* | $A2" >> expected &&
-	echo "|/  " >> expected &&
-	echo "* $A1" >> expected &&
-	git rev-list --graph --all > actual &&
-	test_cmp expected actual
-	'
+	check_graph --all <<-\EOF
+	* A7
+	*   A6
+	|\
+	| * C4
+	| * C3
+	* | A5
+	| |
+	|  \
+	*-. | A4
+	|\ \|
+	| | * C2
+	| | * C1
+	| * | B2
+	| * | B1
+	* | | A3
+	| |/
+	|/|
+	* | A2
+	|/
+	* A1
+	EOF
+'

 # Make sure the graph_is_interesting() code still realizes
 # that undecorated merges are interesting, even with --simplify-by-decoration
 test_expect_success '--graph --simplify-by-decoration' '
-	rm -f expected &&
 	git tag -d A4 &&
-	echo "* $A7" >> expected &&
-	echo "*   $A6" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "| * $C3" >> expected &&
-	echo "* | $A5" >> expected &&
-	echo "| |   " >> expected &&
-	echo "|  \\  " >> expected &&
-	echo "*-. | $A4" >> expected &&
-	echo "|\\ \\| " >> expected &&
-	echo "| | * $C2" >> expected &&
-	echo "| | * $C1" >> expected &&
-	echo "| * | $B2" >> expected &&
-	echo "| * | $B1" >> expected &&
-	echo "* | | $A3" >> expected &&
-	echo "| |/  " >> expected &&
-	echo "|/|   " >> expected &&
-	echo "* | $A2" >> expected &&
-	echo "|/  " >> expected &&
-	echo "* $A1" >> expected &&
-	git rev-list --graph --all --simplify-by-decoration > actual &&
-	test_cmp expected actual
-	'
+	check_graph --all --simplify-by-decoration <<-\EOF
+	* A7
+	*   A6
+	|\
+	| * C4
+	| * C3
+	* | A5
+	| |
+	|  \
+	*-. | A4
+	|\ \|
+	| | * C2
+	| | * C1
+	| * | B2
+	| * | B1
+	* | | A3
+	| |/
+	|/|
+	* | A2
+	|/
+	* A1
+	EOF
+'

 test_expect_success 'setup: get rid of decorations on B' '
 	git tag -d B2 &&
@@ -122,142 +114,133 @@ test_expect_success 'setup: get rid of decorations on B' '

 # Graph with branch B simplified away
 test_expect_success '--graph --simplify-by-decoration prune branch B' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "*   $A6" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "| * $C3" >> expected &&
-	echo "* | $A5" >> expected &&
-	echo "* | $A4" >> expected &&
-	echo "|\\| " >> expected &&
-	echo "| * $C2" >> expected &&
-	echo "| * $C1" >> expected &&
-	echo "* | $A3" >> expected &&
-	echo "|/  " >> expected &&
-	echo "* $A2" >> expected &&
-	echo "* $A1" >> expected &&
-	git rev-list --graph --simplify-by-decoration --all > actual &&
-	test_cmp expected actual
-	'
+	check_graph --simplify-by-decoration --all <<-\EOF
+	* A7
+	*   A6
+	|\
+	| * C4
+	| * C3
+	* | A5
+	* | A4
+	|\|
+	| * C2
+	| * C1
+	* | A3
+	|/
+	* A2
+	* A1
+	EOF
+'

 test_expect_success '--graph --full-history -- bar.txt' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "*   $A6" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "* | $A5" >> expected &&
-	echo "* | $A4" >> expected &&
-	echo "|\\| " >> expected &&
-	echo "* | $A3" >> expected &&
-	echo "|/  " >> expected &&
-	echo "* $A2" >> expected &&
-	git rev-list --graph --full-history --all -- bar.txt > actual &&
-	test_cmp expected actual
-	'
+	check_graph --full-history --all -- bar.txt <<-\EOF
+	* A7
+	*   A6
+	|\
+	| * C4
+	* | A5
+	* | A4
+	|\|
+	* | A3
+	|/
+	* A2
+	EOF
+'

 test_expect_success '--graph --full-history --simplify-merges -- bar.txt' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "*   $A6" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "* | $A5" >> expected &&
-	echo "* | $A3" >> expected &&
-	echo "|/  " >> expected &&
-	echo "* $A2" >> expected &&
-	git rev-list --graph --full-history --simplify-merges --all \
-		-- bar.txt > actual &&
-	test_cmp expected actual
-	'
+	check_graph --full-history --simplify-merges --all -- bar.txt <<-\EOF
+	* A7
+	*   A6
+	|\
+	| * C4
+	* | A5
+	* | A3
+	|/
+	* A2
+	EOF
+'

 test_expect_success '--graph -- bar.txt' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "* $A5" >> expected &&
-	echo "* $A3" >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "|/  " >> expected &&
-	echo "* $A2" >> expected &&
-	git rev-list --graph --all -- bar.txt > actual &&
-	test_cmp expected actual
-	'
+	check_graph --all -- bar.txt <<-\EOF
+	* A7
+	* A5
+	* A3
+	| * C4
+	|/
+	* A2
+	EOF
+'

 test_expect_success '--graph --sparse -- bar.txt' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "* $A6" >> expected &&
-	echo "* $A5" >> expected &&
-	echo "* $A4" >> expected &&
-	echo "* $A3" >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "| * $C3" >> expected &&
-	echo "| * $C2" >> expected &&
-	echo "| * $C1" >> expected &&
-	echo "|/  " >> expected &&
-	echo "* $A2" >> expected &&
-	echo "* $A1" >> expected &&
-	git rev-list --graph --sparse --all -- bar.txt > actual &&
-	test_cmp expected actual
-	'
+	check_graph --sparse --all -- bar.txt <<-\EOF
+	* A7
+	* A6
+	* A5
+	* A4
+	* A3
+	| * C4
+	| * C3
+	| * C2
+	| * C1
+	|/
+	* A2
+	* A1
+	EOF
+'

 test_expect_success '--graph ^C4' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "* $A6" >> expected &&
-	echo "* $A5" >> expected &&
-	echo "*   $A4" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $B2" >> expected &&
-	echo "| * $B1" >> expected &&
-	echo "* $A3" >> expected &&
-	git rev-list --graph --all ^C4 > actual &&
-	test_cmp expected actual
-	'
+	check_graph --all ^C4 <<-\EOF
+	* A7
+	* A6
+	* A5
+	*   A4
+	|\
+	| * B2
+	| * B1
+	* A3
+	EOF
+'

 test_expect_success '--graph ^C3' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "*   $A6" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "* $A5" >> expected &&
-	echo "*   $A4" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $B2" >> expected &&
-	echo "| * $B1" >> expected &&
-	echo "* $A3" >> expected &&
-	git rev-list --graph --all ^C3 > actual &&
-	test_cmp expected actual
-	'
+	check_graph --all ^C3 <<-\EOF
+	* A7
+	*   A6
+	|\
+	| * C4
+	* A5
+	*   A4
+	|\
+	| * B2
+	| * B1
+	* A3
+	EOF
+'

 # I don't think the ordering of the boundary commits is really
 # that important, but this test depends on it.  If the ordering ever changes
 # in the code, we'll need to update this test.
 test_expect_success '--graph --boundary ^C3' '
-	rm -f expected &&
-	echo "* $A7" >> expected &&
-	echo "*   $A6" >> expected &&
-	echo "|\\  " >> expected &&
-	echo "| * $C4" >> expected &&
-	echo "* | $A5" >> expected &&
-	echo "| |     " >> expected &&
-	echo "|  \\    " >> expected &&
-	echo "*-. \\   $A4" >> expected &&
-	echo "|\\ \\ \\  " >> expected &&
-	echo "| * | | $B2" >> expected &&
-	echo "| * | | $B1" >> expected &&
-	echo "* | | | $A3" >> expected &&
-	echo "o | | | $A2" >> expected &&
-	echo "|/ / /  " >> expected &&
-	echo "o / / $A1" >> expected &&
-	echo " / /  " >> expected &&
-	echo "| o $C3" >> expected &&
-	echo "|/  " >> expected &&
-	echo "o $C2" >> expected &&
-	git rev-list --graph --boundary --all ^C3 > actual &&
-	test_cmp expected actual
-	'
+	check_graph --boundary --all ^C3 <<-\EOF
+	* A7
+	*   A6
+	|\
+	| * C4
+	* | A5
+	| |
+	|  \
+	*-. \   A4
+	|\ \ \
+	| * | | B2
+	| * | | B1
+	* | | | A3
+	o | | | A2
+	|/ / /
+	o / / A1
+	 / /
+	| o C3
+	|/
+	o C2
+	EOF
+'

 test_done
-- 
2.26.2

