Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D4FC77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 22:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjEAW05 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 18:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjEAW04 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 18:26:56 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A2E2123
        for <git@vger.kernel.org>; Mon,  1 May 2023 15:26:55 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b46186c03so3545413b3a.3
        for <git@vger.kernel.org>; Mon, 01 May 2023 15:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1682980015; x=1685572015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I4NbsRNRSKuBqSBSGgqoGSOVZxfnpeu+HWIHrhQZyWM=;
        b=RdA7FpaduvnnMoTuR5Xw0hxtd5RQizrc2FV0JFrfRe5JLcfz+s6xNb5TjMDoHsZa7u
         VGLNIEoAwGn01HiBCBhAH4DT5AFHo7adGlnOfkOPJez87WnCV5RLJiFmxMyjxuH+ZR+B
         cYo4L7CYYCWZgh1MOcqlmpxSwhF5770azp02z6P8/qEd9M+tiGx3JqPVMdqdBYju00NV
         0lxqrTzTUjX77LP5hY8WcNIPS7EH1TfucQzubO7INKH3fGBZ/OYaJKPS3SdXemKUQRHj
         vbCWROSakU9SQmPMA0ktTjJ1T8hRqGZYgoSfKdVi/3oijiYmBXiHNopBtWLh2weUbsx1
         GQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682980015; x=1685572015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4NbsRNRSKuBqSBSGgqoGSOVZxfnpeu+HWIHrhQZyWM=;
        b=EjPX0wU63kl8nKpEiVJIAvpgnFza3bcTch41Uu8alsW1+Ndh2n7OI7pQQ6irI2Blaw
         dVbXkDOSYm4UbMtJkLgDloEvVr7c4LmH0m7Va1bRN1UWsME4YqdetovGYy+a0y8vxTa5
         QoqmmqqIJQVPJF17AGGZdpvFIFZ7Lt9BVojVuqDCAeUpUQbwwwva4aoOGLZ/+ZoTG21b
         ByvXLilSiEOlghWyx9Stz9JZUxmOskt5/beP9jUPjj5+yoiHrWfVnOZSj5ipVSb7rxWj
         fcWdSDNdr/0IhnFtpTq3XHZHgN1DIxyEU4PT/lKIyH7uY7+2aYRnVBfbb4/0MUgT/uYu
         sxUA==
X-Gm-Message-State: AC+VfDzHJdWVCN2bT/g/x3ega5z9KJp2geNOvg2rRiEnZ+iOVu5E1ZKC
        3ZiHHsxPQ93vQqbqtDCgGZu3
X-Google-Smtp-Source: ACHHUZ5140epZKyj6Fi1aCylTMu0U+orD0Y+0LRamEubfwQk3LlrNjuCiYQ91EoptBTQI/QLSJ7HrQ==
X-Received: by 2002:a05:6a00:1a14:b0:63d:2d7d:b6f2 with SMTP id g20-20020a056a001a1400b0063d2d7db6f2mr22816531pfv.4.1682980014873;
        Mon, 01 May 2023 15:26:54 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id f20-20020a056a00229400b00627fafe49f9sm20432893pfe.106.2023.05.01.15.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 15:26:54 -0700 (PDT)
Message-ID: <427dff83-536d-46ee-6326-15e2f548082c@github.com>
Date:   Mon, 1 May 2023 15:26:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v8 2/2] diff-files: integrate with sparse index
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com
References: <20230322161820.3609-1-cheskaqiqi@gmail.com>
 <20230423010721.1402736-1-cheskaqiqi@gmail.com>
 <20230423010721.1402736-3-cheskaqiqi@gmail.com>
Content-Language: en-US
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230423010721.1402736-3-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 3c140103c5..7ebcfe785e 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1377,7 +1377,10 @@ test_expect_success 'index.sparse disabled inline uses full index' '
>  	! test_region index ensure_full_index trace2.txt
>  '
>  
> -ensure_not_expanded () {
> +ensure_index_state () {
> +	local expected_expansion="$1"
> +	shift
> +
>  	rm -f trace2.txt &&
>  	if test -z "$WITHOUT_UNTRACKED_TXT"
>  	then
> @@ -1398,7 +1401,21 @@ ensure_not_expanded () {
>  			>sparse-index-out \
>  			2>sparse-index-error || return 1
>  	fi &&
> -	test_region ! index ensure_full_index trace2.txt
> +
> +	if [ "$expected_expansion" = "expanded" ]
> +	then
> +		test_region index ensure_full_index trace2.txt
> +	else
> +		test_region ! index ensure_full_index trace2.txt
> +	fi
> +}
> +
> +ensure_expanded () {
> +	ensure_index_state "expanded" "$@"
> +}
> +
> +ensure_not_expanded () {
> +	ensure_index_state "not_expanded" "$@"
>  }

This still seems a bit more complicated than necessary (mainly due to the
new string comparison & local arg). What about something like this (applied
on top)?

-------- 8< -------- 8< -------- 8< --------
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 9d11d28891..333822f322 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1377,10 +1377,7 @@ test_expect_success 'index.sparse disabled inline uses full index' '
 	! test_region index ensure_full_index trace2.txt
 '
 
-ensure_index_state () {
-	local expected_expansion="$1"
-	shift
-
+run_sparse_index_trace2 () {
 	rm -f trace2.txt &&
 	if test -z "$WITHOUT_UNTRACKED_TXT"
 	then
@@ -1400,22 +1397,17 @@ ensure_index_state () {
 			git -C sparse-index "$@" \
 			>sparse-index-out \
 			2>sparse-index-error || return 1
-	fi &&
-
-	if [ "$expected_expansion" = "expanded" ]
-	then
-		test_region index ensure_full_index trace2.txt
-	else
-		test_region ! index ensure_full_index trace2.txt
 	fi
 }
 
 ensure_expanded () {
-	ensure_index_state "expanded" "$@"
+	run_sparse_index_trace2 "$@" &&
+	test_region index ensure_full_index trace2.txt
 }
 
 ensure_not_expanded () {
-	ensure_index_state "not_expanded" "$@"
+	run_sparse_index_trace2 "$@" &&
+	test_region ! index ensure_full_index trace2.txt
 }
 
 test_expect_success 'sparse-index is not expanded' '
-------- >8 -------- >8 -------- >8 --------

That said, given that this is my only complaint with this iteration (and
it's pretty subjective), if others are happy with it then I'm not opposed to
merging to 'next'.

