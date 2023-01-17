Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AECC3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 19:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbjAQS6f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 13:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjAQSyy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 13:54:54 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A7B5AA5F
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 10:18:05 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id cx21-20020a17090afd9500b00228f2ecc6dbso290014pjb.0
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 10:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PRgGkTkGSfGAcPcWfSi9XEOGi5RWaXZ3fQ71sdQjQKo=;
        b=YVkSJOFTjMf21r7P8maYBoZJBs2A3gh/BIoQRs79FURgUuxL8QfmbLgUy7ITTUvtx0
         tciZY2vZkF1S6/rloXdq3e2Gpw0RSFPfHQmpDWGjBPJaDMPVT7CLkZPkXze3w8yb+9y+
         c9KUkwrAkzs21urVk9CcLvvrxhpf3xzDFAi+U+nPiqticdvmaWubp90nrNTIXMAiMqFE
         qAdvvvdWKpSpCgmkT96ocLUEqb8RbeedaiUgAIhZ+Ui+WFfKU++fB9835SW0iM12tdyK
         ULH5FnBQdGB/cf+Uwd4m5V9ZhRcnHVXFMF395c8JrKUBtyefY+ycmx1vsDmmLZUfCcCI
         s0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRgGkTkGSfGAcPcWfSi9XEOGi5RWaXZ3fQ71sdQjQKo=;
        b=v50zuk8QHRy/uDh0NstV8mgUuQsqEQ6RsXOm6qwB/juHvIZpJWTExXhlMs2TPDD9yL
         qItJV4k4ps/6muAa5BsdUifmR5DFQLmPEYaD+SGvs/+WQ2Gi6qSWp7SECW5LDY2WICzd
         raZI8UrnyAMjyrT0dTqUn9aRyeAdPI+HCPkDPOCAT9bQ3/lCbuw7LuXc/CyQeoiiQ6Vv
         2DRUORU0FjITohaOpZoVTlw+3QoBNCgqghVTCv+Rd4zZ3RAhujyoSuUo3JrjnYWM6ZEN
         +LZ/EqzoBmpfPiFMRJVijQTWYZbn4zsrbZvgt1pn2QXsIQlrN/tfDdw1bdMxgokesNDd
         tINQ==
X-Gm-Message-State: AFqh2kozSEtCq3LyzDqluArzIO1l3+Q4km4HIt+gn5TUzHIvLAqqMaRp
        fgcuhZCVuVjr3OL3mUEHkEe+
X-Google-Smtp-Source: AMrXdXtGug1+W9h6dJnyJsjZwdlRkPXAbt/BYybkJc7/wHkVYmYXfhsk300m8DtiOR8GMsTfSXZahw==
X-Received: by 2002:a05:6a20:9305:b0:b8:7ce2:7fad with SMTP id r5-20020a056a20930500b000b87ce27fadmr3469536pzh.51.1673979465706;
        Tue, 17 Jan 2023 10:17:45 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id z18-20020a63c052000000b0049f2c7e59f5sm17413733pgi.27.2023.01.17.10.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 10:17:45 -0800 (PST)
Message-ID: <4d13cea1-e9f6-381f-14ef-8a5a645e2a8f@github.com>
Date:   Tue, 17 Jan 2023 10:17:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/8] t5558: add tests for creationToken heuristic
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, avarab@gmail.com,
        steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <39eed9148782c37f5184c5fff7d0e4d1a7a2a1fe.1673037405.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <39eed9148782c37f5184c5fff7d0e4d1a7a2a1fe.1673037405.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> As documented in the bundle URI design doc in 2da14fad8fe (docs:
> document bundle URI standard, 2022-08-09), the 'creationToken' member of
> a bundle URI allows a bundle provider to specify a total order on the
> bundles.
> 
> Future changes will allow the Git client to understand these members and
> modify its behavior around downloading the bundles in that order. In the
> meantime, create tests that add creation tokens to the bundle list. For
> now, the Git client correctly ignores these unknown keys.
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  t/t5558-clone-bundle-uri.sh | 52 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
> index 9155f31fa2c..328caeeae9a 100755
> --- a/t/t5558-clone-bundle-uri.sh
> +++ b/t/t5558-clone-bundle-uri.sh
> @@ -284,7 +284,17 @@ test_expect_success 'clone HTTP bundle' '
>  	test_config -C clone-http log.excludedecoration refs/bundle/
>  '
>  
> +# usage: test_bundle_downloaded <bundle-name> <trace-file>
> +test_bundle_downloaded () {
> +	cat >pattern <<-EOF &&
> +	"event":"child_start".*"argv":\["git-remote-https","$HTTPD_URL/$1"\]
> +	EOF
> +	grep -f pattern "$2"
> +}
> +
>  test_expect_success 'clone bundle list (HTTP, no heuristic)' '
> +	test_when_finished rm -f trace*.txt &&
> +
>  	cp clone-from/bundle-*.bundle "$HTTPD_DOCUMENT_ROOT_PATH/" &&
>  	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
>  	[bundle]
> @@ -304,12 +314,19 @@ test_expect_success 'clone bundle list (HTTP, no heuristic)' '
>  		uri = $HTTPD_URL/bundle-4.bundle
>  	EOF
>  
> -	git clone --bundle-uri="$HTTPD_URL/bundle-list" \
> +	GIT_TRACE2_EVENT="$(pwd)/trace-clone.txt" \
> +		git clone --bundle-uri="$HTTPD_URL/bundle-list" \
>  		clone-from clone-list-http  2>err &&
>  	! grep "Repository lacks these prerequisite commits" err &&
>  
>  	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
> -	git -C clone-list-http cat-file --batch-check <oids
> +	git -C clone-list-http cat-file --batch-check <oids &&
> +
> +	for b in 1 2 3 4
> +	do
> +		test_bundle_downloaded bundle-$b.bundle trace-clone.txt ||
> +			return 1
> +	done

Because the current state of bundle list handling is equivalent to "no
heuristic", this pre-existing test is just updated to verify all bundles are
downloaded. This isn't new behavior, but it'll be relevant to compare with
the behavior of the 'creationToken' heuristic. 

I was going to ask how the tests verify that *only* the expected bundles are
downloaded, and it looks like later patches [1] handle that with
'! test_bundle_downloaded' checks. That approach seems a bit fragile (if a
bundle's name doesn't match the '! test_bundle_downloaded' check for some
reason, the bundle can be either downloaded or not with no effect on the
test result). Would something like a 'test_downloaded_bundle_count' work
instead?

-------- 8< --------

diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 0604d721f1..b2f55dd983 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -292,6 +292,16 @@ test_bundle_downloaded () {
 	grep -f pattern "$2"
 }
 
+test_download_bundle_count () {
+	cat >exclude <<-EOF &&
+	"event":"child_start".*"argv":\["git-remote-https","$HTTPD_URL/bundle-list"\]
+	EOF
+	cat >pattern <<-EOF &&
+	"event":"child_start".*"argv":\["git-remote-https","$HTTPD_URL/.*"\]
+	EOF
+	test $(grep -f pattern "$2" | grep -v -f exclude | wc -l) -eq "$1"
+}
+
 test_expect_success 'clone bundle list (HTTP, no heuristic)' '
 	test_when_finished rm -f trace*.txt &&
 
@@ -322,6 +332,7 @@ test_expect_success 'clone bundle list (HTTP, no heuristic)' '
 	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
 	git -C clone-list-http cat-file --batch-check <oids &&
 
+	test_download_bundle_count 4 trace-clone.txt &&
 	for b in 1 2 3 4
 	do
 		test_bundle_downloaded bundle-$b.bundle trace-clone.txt ||

-------- >8 --------

[1] https://lore.kernel.org/git/51f210ddeb46fb06e885dc384a486c4bb16ad8cd.1673037405.git.gitgitgadget@gmail.com/

>  '
>  
>  test_expect_success 'clone bundle list (HTTP, any mode)' '
> @@ -350,6 +367,37 @@ test_expect_success 'clone bundle list (HTTP, any mode)' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'clone bundle list (http, creationToken)' '
> +	cp clone-from/bundle-*.bundle "$HTTPD_DOCUMENT_ROOT_PATH/" &&
> +	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
> +	[bundle]
> +		version = 1
> +		mode = all
> +		heuristic = creationToken
> +
> +	[bundle "bundle-1"]
> +		uri = bundle-1.bundle
> +		creationToken = 1
> +
> +	[bundle "bundle-2"]
> +		uri = bundle-2.bundle
> +		creationToken = 2
> +
> +	[bundle "bundle-3"]
> +		uri = bundle-3.bundle
> +		creationToken = 3
> +
> +	[bundle "bundle-4"]
> +		uri = bundle-4.bundle
> +		creationToken = 4
> +	EOF
> +
> +	git clone --bundle-uri="$HTTPD_URL/bundle-list" . clone-list-http-2 &&
> +
> +	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
> +	git -C clone-list-http-2 cat-file --batch-check <oids

This test looks like the one that was updated above, but adds the
'creationToken' heuristic key. However, the 'test_bundle_downloaded' check
isn't included - if it were, it would need to verify that all bundles were
downloaded, with the heuristic being ignored, all bundles will be downloaded
(which isn't consistent with what the 'creationToken' heuristic will
*eventually* do).

As a matter of personal preference (so no pressure to change if you
disagree), I find this test in its current state a bit misleading; because
it's a 'test_expect_success' and there's no "NEEDSWORK" or "TODO", I could
easily assume that cloning from a bundle list with the 'creationToken'
heuristic is working as-intended at this point (that is, there's no
indication that it's not implemented). 

If you did want to change it, adding a 'NEEDSWORK' comment, changing to
'test_expect_failure' & including the appropriate 'test_bundle_downloaded'
check, or moving this test to the patch where the heuristic is implemented
would mitigate any confusion. That said, this "issue" is resolved by the
end of the series anyway, so it's really a low priority fix.

> +'
> +
>  # Do not add tests here unless they use the HTTP server, as they will
>  # not run unless the HTTP dependencies exist.
>  

