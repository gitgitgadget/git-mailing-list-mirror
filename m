Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774EF17A311
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742379884; cv=none; b=E8KqolWIB/6yWQ65UjsIssqhHrxf5tEgyAj8bwAiT4TzD/Xt+rfqkWzneDNWZqDJ6tJ0OxJy+ONJoJF21MNPsVbmDbc+uBCqGDYRagkj7ylnEy4oTWtatOlzBiXidGwboT0Cx+Ud8lhdymgz7Zbi7bKWhgf4KoNHFRmyCD9mTSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742379884; c=relaxed/simple;
	bh=SzH6jqPbxdGFcfgUD40hlxyHjvc3yf7btY542YevjUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CsaemzeMXn7YQuwsolJKKJSyD4lf5VQfgRHuqo1tiOLhGweRgJXqIZLrQNQtRcyBKjflVxKyjYKZrwS6a0OpH+QU0+eBNtREXdLeRtslQWKDE9K7Tlc3cBF90EO3gzOzowuCgMEXMiG53OVLUcsTtcfgqhTO8m3amJwLP1VlGUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjcFIN14; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjcFIN14"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-390e3b3d3f4so4052644f8f.2
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 03:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742379880; x=1742984680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1UKR4gBPI0wrchC6SRx2t/zUKR09iX5LKzMjTrZohr4=;
        b=NjcFIN14K3p/r6LFF3vyoTXxo9f3DJPeo0JmCuQjODCly10Awh7P/w65ev37pbkV0f
         HMmE3nY7oYaEF876stAFBJ/m4jZg6gaWv9DcJF52TKKNLu2MSKlUFKJbIe6lv3ha/c2x
         DxWK3Zp4opNuBQAto4461hEkVyY15TbcpVfdHEg5hYmF1VO/iBjrhQDylK92rlpRQvBw
         Ym89+OF6KRpi/BKwdW8dSmqi75ScwIH0CugYAyuPmG0d7RwfkjzMp5d8AwQ+cWqCsjF4
         x9632LiyatdAVXyUoFw5ILq1ekBXfFL4H2C20t8gZd3pAQzXe1cNWI8zR69r8nw/dulO
         ccTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742379880; x=1742984680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1UKR4gBPI0wrchC6SRx2t/zUKR09iX5LKzMjTrZohr4=;
        b=GulMeKVqPr1h3tNVkv83CoIFcVhjsiVYTL+9/oLxH3pfSgRHsk4MzGNhNsCzkMMy3m
         tgiSuWPHU+E9ba0eevftTzIIAJf315BroPslGEYVpghfNqi74YsBZ/Uz6noFm5QFow5a
         WLsRyyEBNZwF4jMM4Sj3bgJleBjm7MIsBRIulfdMmcA8aAaX18C47XWlupZG9caZl8zs
         lmIzNE2tHpwFXG9CG3q3PRrvcqlWBKtzsVcg3pgmyzLYEKsh/pmeDGefKYr9IQg/DKMe
         r4Z7/3Vg/+7eQNCUJZX0r7WKxz+zGG0unS+kWZgwchHp0u03RaUaaiQVnC83ekbYNhcF
         9tPw==
X-Forwarded-Encrypted: i=1; AJvYcCVQheRXxs2/QY46RPFTJ6Vtt9F2VgSJSsj2BSJ2wfmF7BnXcgWfG+uJRvl+Ofx8MYOQKlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyfVr0fvJwwK2ESEg6fBvtUgDS/FMR5GX3TfMDXE64KY+46ce3
	WLqlZWOw7/ASQgMzxWZaPzikRDHHiLqALcVyq6F/mg6kEo96gD40
X-Gm-Gg: ASbGncsx0o9e4acdXTCKlAGLgh6KxybjcM9RIrPhN2azTZ5Dnf61uJcLYDiUOzhvbuy
	pshqWnsAVBdDsDBQhvD282KclqnZQcu/X+ZCSuFkiOWgecftkaMb2VEWeF6vRuQdoc1PyCb3rld
	4KW6NFUir7OtFWmhCiTPPI5p1gN0B5gQqhN5fzcw18h5+b7drcZnM5IrfbaOOcKuWzlq0s2A4pc
	FPITryIj++j25HuWwyA8uJgCcv+LauMliOznEgBv5jVOC6EjlsrRvob0BCKRZY/OuwBRT6NGyN+
	l8Oh9flamC7U68VNsCOlnx4boqj6953KZGpN7GURFldFITPfbyFrFqCVczd72xiOgDFL/E+Qpu2
	t7XT/laUoMk9nwcZod1qN
X-Google-Smtp-Source: AGHT+IEijpARABxaJLYXR9udg0RZUBstFumxUiH8qKNJqcFfpuEg2Cdbe7H4I5feIkfHXgrfDF60ow==
X-Received: by 2002:a05:6000:186b:b0:38f:28a1:501e with SMTP id ffacd0b85a97d-399739bc288mr1673930f8f.8.1742379879270;
        Wed, 19 Mar 2025 03:24:39 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed4b8sm14297635e9.35.2025.03.19.03.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 03:24:38 -0700 (PDT)
Message-ID: <56d8bd34-1301-40d6-8151-f85fb1d7560b@gmail.com>
Date: Wed, 19 Mar 2025 10:24:32 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/2] bundle-uri: copy all bundle references ino the
 refs/bundle space
To: Scott Chacon via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Scott Chacon <schacon@gmail.com>
References: <pull.1897.v2.git.git.1740825238.gitgitgadget@gmail.com>
 <pull.1897.v3.git.git.1742312173.gitgitgadget@gmail.com>
 <2ccbfdcc2dcc77aa33aabce3886ca8690b9253ac.1742312173.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <2ccbfdcc2dcc77aa33aabce3886ca8690b9253ac.1742312173.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Scott

On 18/03/2025 15:36, Scott Chacon via GitGitGadget wrote:
> From: Scott Chacon <schacon@gmail.com>
> 
> When downloading bundles via the bundle-uri functionality, we only copy the
> references from refs/heads into the refs/bundle space. I'm not sure why this
> refspec is hardcoded to be so limited, but it makes the ref negotiation on
> the subsequent fetch suboptimal, since it won't use objects that are
> referenced outside of the current heads of the bundled repository.
> 
> This change to copy everything in refs/ in the bundle to refs/bundles/
> significantly helps the subsequent fetch, since nearly all the references
> are now included in the negotiation.
> 
> The update to the bundle-uri unbundling refspec puts all the heads from a
> bundle file into refs/bundle/heads instead of directly into refs/bundle/ so
> the tests also need to be updated to look in the new heirarchy.

I've not used the bundle-uri feature but this change sounds sensible. 
The refspec that's changed here is documented in 
Documentation/technical/bundle-uri.adoc (see item 2 in the list under 
"Cloning with Bundle URIs") so we should update that. That document as 
says this refspec is configurable but it seems that was never 
implemented so it would be nice to fix that at the same time.

Thanks

Phillip

> Signed-off-by: Scott Chacon <schacon@gmail.com>
> ---
>   bundle-uri.c                |   2 +-
>   t/t5558-clone-bundle-uri.sh | 172 ++++++++++++++++++------------------
>   2 files changed, 87 insertions(+), 87 deletions(-)
> 
> diff --git a/bundle-uri.c b/bundle-uri.c
> index 744257c49c1..3371d56f4ce 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -403,7 +403,7 @@ static int unbundle_from_file(struct repository *r, const char *file)
>   		const char *branch_name;
>   		int has_old;
>   
> -		if (!skip_prefix(refname->string, "refs/heads/", &branch_name))
> +		if (!skip_prefix(refname->string, "refs/", &branch_name))
>   			continue;
>   
>   		strbuf_setlen(&bundle_ref, bundle_prefix_len);
> diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
> index 3816ed5058d..33a7009e9a2 100755
> --- a/t/t5558-clone-bundle-uri.sh
> +++ b/t/t5558-clone-bundle-uri.sh
> @@ -58,7 +58,7 @@ test_expect_success 'create bundle' '
>   test_expect_success 'clone with path bundle' '
>   	git clone --bundle-uri="clone-from/B.bundle" \
>   		clone-from clone-path &&
> -	git -C clone-path rev-parse refs/bundles/topic >actual &&
> +	git -C clone-path rev-parse refs/bundles/heads/topic >actual &&
>   	git -C clone-from rev-parse topic >expect &&
>   	test_cmp expect actual
>   '
> @@ -68,9 +68,9 @@ test_expect_success 'clone with bundle that has bad header' '
>   	git clone --bundle-uri="clone-from/bad-header.bundle" \
>   		clone-from clone-bad-header 2>err &&
>   	commit_b=$(git -C clone-from rev-parse B) &&
> -	test_grep "trying to write ref '\''refs/bundles/topic'\'' with nonexistent object $commit_b" err &&
> +	test_grep "trying to write ref '\''refs/bundles/heads/topic'\'' with nonexistent object $commit_b" err &&
>   	git -C clone-bad-header for-each-ref --format="%(refname)" >refs &&
> -	test_grep ! "refs/bundles/" refs
> +	test_grep ! "refs/bundles/heads/" refs
>   '
>   
>   test_expect_success 'clone with bundle that has bad object' '
> @@ -78,8 +78,8 @@ test_expect_success 'clone with bundle that has bad object' '
>   	git clone --bundle-uri="clone-from/bad-object.bundle" \
>   		clone-from clone-bad-object-no-fsck &&
>   	git -C clone-bad-object-no-fsck for-each-ref --format="%(refname)" >refs &&
> -	grep "refs/bundles/" refs >actual &&
> -	test_write_lines refs/bundles/bad >expect &&
> +	grep "refs/bundles/heads/" refs >actual &&
> +	test_write_lines refs/bundles/heads/bad >expect &&
>   	test_cmp expect actual &&
>   
>   	# Unbundle fails with fsckObjects set true, but clone can still proceed.
> @@ -87,14 +87,14 @@ test_expect_success 'clone with bundle that has bad object' '
>   		clone-from clone-bad-object-fsck 2>err &&
>   	test_grep "missingEmail" err &&
>   	git -C clone-bad-object-fsck for-each-ref --format="%(refname)" >refs &&
> -	test_grep ! "refs/bundles/" refs
> +	test_grep ! "refs/bundles/heads/" refs
>   '
>   
>   test_expect_success 'clone with path bundle and non-default hash' '
>   	test_when_finished "rm -rf clone-path-non-default-hash" &&
>   	GIT_DEFAULT_HASH=sha256 git clone --bundle-uri="clone-from/B.bundle" \
>   		clone-from clone-path-non-default-hash &&
> -	git -C clone-path-non-default-hash rev-parse refs/bundles/topic >actual &&
> +	git -C clone-path-non-default-hash rev-parse refs/bundles/heads/topic >actual &&
>   	git -C clone-from rev-parse topic >expect &&
>   	test_cmp expect actual
>   '
> @@ -102,7 +102,7 @@ test_expect_success 'clone with path bundle and non-default hash' '
>   test_expect_success 'clone with file:// bundle' '
>   	git clone --bundle-uri="file://$(pwd)/clone-from/B.bundle" \
>   		clone-from clone-file &&
> -	git -C clone-file rev-parse refs/bundles/topic >actual &&
> +	git -C clone-file rev-parse refs/bundles/heads/topic >actual &&
>   	git -C clone-from rev-parse topic >expect &&
>   	test_cmp expect actual
>   '
> @@ -173,12 +173,12 @@ test_expect_success 'clone bundle list (file, no heuristic)' '
>   	git -C clone-list-file cat-file --batch-check <oids &&
>   
>   	git -C clone-list-file for-each-ref --format="%(refname)" >refs &&
> -	grep "refs/bundles/" refs >actual &&
> +	grep "refs/bundles/heads/" refs >actual &&
>   	cat >expect <<-\EOF &&
> -	refs/bundles/base
> -	refs/bundles/left
> -	refs/bundles/merge
> -	refs/bundles/right
> +	refs/bundles/heads/base
> +	refs/bundles/heads/left
> +	refs/bundles/heads/merge
> +	refs/bundles/heads/right
>   	EOF
>   	test_cmp expect actual
>   '
> @@ -220,10 +220,10 @@ test_expect_success 'clone bundle list (file, all mode, some failures)' '
>   	git -C clone-all-some cat-file --batch-check <oids &&
>   
>   	git -C clone-all-some for-each-ref --format="%(refname)" >refs &&
> -	grep "refs/bundles/" refs >actual &&
> +	grep "refs/bundles/heads/" refs >actual &&
>   	cat >expect <<-\EOF &&
> -	refs/bundles/base
> -	refs/bundles/left
> +	refs/bundles/heads/base
> +	refs/bundles/heads/left
>   	EOF
>   	test_cmp expect actual
>   '
> @@ -253,7 +253,7 @@ test_expect_success 'clone bundle list (file, all mode, all failures)' '
>   	git -C clone-all-fail cat-file --batch-check <oids &&
>   
>   	git -C clone-all-fail for-each-ref --format="%(refname)" >refs &&
> -	! grep "refs/bundles/" refs
> +	! grep "refs/bundles/heads/" refs
>   '
>   
>   test_expect_success 'clone bundle list (file, any mode)' '
> @@ -282,9 +282,9 @@ test_expect_success 'clone bundle list (file, any mode)' '
>   	git -C clone-any-file cat-file --batch-check <oids &&
>   
>   	git -C clone-any-file for-each-ref --format="%(refname)" >refs &&
> -	grep "refs/bundles/" refs >actual &&
> +	grep "refs/bundles/heads/" refs >actual &&
>   	cat >expect <<-\EOF &&
> -	refs/bundles/base
> +	refs/bundles/heads/base
>   	EOF
>   	test_cmp expect actual
>   '
> @@ -313,7 +313,7 @@ test_expect_success 'clone bundle list (file, any mode, all failures)' '
>   	git -C clone-any-fail cat-file --batch-check <oids &&
>   
>   	git -C clone-any-fail for-each-ref --format="%(refname)" >refs &&
> -	! grep "refs/bundles/" refs
> +	! grep "refs/bundles/heads/" refs
>   '
>   
>   test_expect_success 'negotiation: bundle with part of wanted commits' '
> @@ -322,10 +322,10 @@ test_expect_success 'negotiation: bundle with part of wanted commits' '
>   	git clone --no-local --bundle-uri="clone-from/A.bundle" \
>   		clone-from nego-bundle-part &&
>   	git -C nego-bundle-part for-each-ref --format="%(refname)" >refs &&
> -	grep "refs/bundles/" refs >actual &&
> -	test_write_lines refs/bundles/topic >expect &&
> +	grep "refs/bundles/heads/" refs >actual &&
> +	test_write_lines refs/bundles/heads/topic >expect &&
>   	test_cmp expect actual &&
> -	# Ensure that refs/bundles/topic are sent as "have".
> +	# Ensure that refs/bundles/heads/topic are sent as "have".
>   	tip=$(git -C clone-from rev-parse A) &&
>   	test_grep "clone> have $tip" trace-packet.txt
>   '
> @@ -337,8 +337,8 @@ test_expect_success 'negotiation: bundle with all wanted commits' '
>   		--bundle-uri="clone-from/B.bundle" \
>   		clone-from nego-bundle-all &&
>   	git -C nego-bundle-all for-each-ref --format="%(refname)" >refs &&
> -	grep "refs/bundles/" refs >actual &&
> -	test_write_lines refs/bundles/topic >expect &&
> +	grep "refs/bundles/heads/" refs >actual &&
> +	test_write_lines refs/bundles/heads/topic >expect &&
>   	test_cmp expect actual &&
>   	# We already have all needed commits so no "want" needed.
>   	test_grep ! "clone> want " trace-packet.txt
> @@ -363,13 +363,13 @@ test_expect_success 'negotiation: bundle list (no heuristic)' '
>   		clone-from nego-bundle-list-no-heuristic &&
>   
>   	git -C nego-bundle-list-no-heuristic for-each-ref --format="%(refname)" >refs &&
> -	grep "refs/bundles/" refs >actual &&
> +	grep "refs/bundles/heads/" refs >actual &&
>   	cat >expect <<-\EOF &&
> -	refs/bundles/base
> -	refs/bundles/left
> +	refs/bundles/heads/base
> +	refs/bundles/heads/left
>   	EOF
>   	test_cmp expect actual &&
> -	tip=$(git -C nego-bundle-list-no-heuristic rev-parse refs/bundles/left) &&
> +	tip=$(git -C nego-bundle-list-no-heuristic rev-parse refs/bundles/heads/left) &&
>   	test_grep "clone> have $tip" trace-packet.txt
>   '
>   
> @@ -395,13 +395,13 @@ test_expect_success 'negotiation: bundle list (creationToken)' '
>   		clone-from nego-bundle-list-heuristic &&
>   
>   	git -C nego-bundle-list-heuristic for-each-ref --format="%(refname)" >refs &&
> -	grep "refs/bundles/" refs >actual &&
> +	grep "refs/bundles/heads/" refs >actual &&
>   	cat >expect <<-\EOF &&
> -	refs/bundles/base
> -	refs/bundles/left
> +	refs/bundles/heads/base
> +	refs/bundles/heads/left
>   	EOF
>   	test_cmp expect actual &&
> -	tip=$(git -C nego-bundle-list-heuristic rev-parse refs/bundles/left) &&
> +	tip=$(git -C nego-bundle-list-heuristic rev-parse refs/bundles/heads/left) &&
>   	test_grep "clone> have $tip" trace-packet.txt
>   '
>   
> @@ -428,10 +428,10 @@ test_expect_success 'negotiation: bundle list with all wanted commits' '
>   		clone-from nego-bundle-list-all &&
>   
>   	git -C nego-bundle-list-all for-each-ref --format="%(refname)" >refs &&
> -	grep "refs/bundles/" refs >actual &&
> +	grep "refs/bundles/heads/" refs >actual &&
>   	cat >expect <<-\EOF &&
> -	refs/bundles/base
> -	refs/bundles/left
> +	refs/bundles/heads/base
> +	refs/bundles/heads/left
>   	EOF
>   	test_cmp expect actual &&
>   	# We already have all needed commits so no "want" needed.
> @@ -465,7 +465,7 @@ test_expect_success 'clone HTTP bundle' '
>   
>   	git clone --bundle-uri="$HTTPD_URL/B.bundle" \
>   		"$HTTPD_URL/smart/fetch.git" clone-http &&
> -	git -C clone-http rev-parse refs/bundles/topic >actual &&
> +	git -C clone-http rev-parse refs/bundles/heads/topic >actual &&
>   	git -C clone-from rev-parse topic >expect &&
>   	test_cmp expect actual &&
>   
> @@ -476,7 +476,7 @@ test_expect_success 'clone HTTP bundle with non-default hash' '
>   	test_when_finished "rm -rf clone-http-non-default-hash" &&
>   	GIT_DEFAULT_HASH=sha256 git clone --bundle-uri="$HTTPD_URL/B.bundle" \
>   		"$HTTPD_URL/smart/fetch.git" clone-http-non-default-hash &&
> -	git -C clone-http-non-default-hash rev-parse refs/bundles/topic >actual &&
> +	git -C clone-http-non-default-hash rev-parse refs/bundles/heads/topic >actual &&
>   	git -C clone-from rev-parse topic >expect &&
>   	test_cmp expect actual
>   '
> @@ -553,12 +553,12 @@ test_expect_success 'clone bundle list (HTTP, any mode)' '
>   	git -C clone-any-http cat-file --batch-check <oids &&
>   
>   	git -C clone-list-file for-each-ref --format="%(refname)" >refs &&
> -	grep "refs/bundles/" refs >actual &&
> +	grep "refs/bundles/heads/" refs >actual &&
>   	cat >expect <<-\EOF &&
> -	refs/bundles/base
> -	refs/bundles/left
> -	refs/bundles/merge
> -	refs/bundles/right
> +	refs/bundles/heads/base
> +	refs/bundles/heads/left
> +	refs/bundles/heads/merge
> +	refs/bundles/heads/right
>   	EOF
>   	test_cmp expect actual
>   '
> @@ -641,9 +641,9 @@ test_expect_success 'clone incomplete bundle list (http, creationToken)' '
>   	test_cmp expect actual &&
>   
>   	# We now have only one bundle ref.
> -	git -C clone-token-http for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
> +	git -C clone-token-http for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
>   	cat >expect <<-\EOF &&
> -	refs/bundles/base
> +	refs/bundles/heads/base
>   	EOF
>   	test_cmp expect refs &&
>   
> @@ -679,13 +679,13 @@ test_expect_success 'clone incomplete bundle list (http, creationToken)' '
>   	test_cmp expect actual &&
>   
>   	# We now have all bundle refs.
> -	git -C clone-token-http for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
> +	git -C clone-token-http for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
>   
>   	cat >expect <<-\EOF &&
> -	refs/bundles/base
> -	refs/bundles/left
> -	refs/bundles/merge
> -	refs/bundles/right
> +	refs/bundles/heads/base
> +	refs/bundles/heads/left
> +	refs/bundles/heads/merge
> +	refs/bundles/heads/right
>   	EOF
>   	test_cmp expect refs
>   '
> @@ -721,9 +721,9 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
>   	test_cmp expect actual &&
>   
>   	# only received base ref from bundle-1
> -	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
> +	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
>   	cat >expect <<-\EOF &&
> -	refs/bundles/base
> +	refs/bundles/heads/base
>   	EOF
>   	test_cmp expect refs &&
>   
> @@ -749,10 +749,10 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
>   	test_cmp expect actual &&
>   
>   	# received left from bundle-2
> -	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
> +	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
>   	cat >expect <<-\EOF &&
> -	refs/bundles/base
> -	refs/bundles/left
> +	refs/bundles/heads/base
> +	refs/bundles/heads/left
>   	EOF
>   	test_cmp expect refs &&
>   
> @@ -795,12 +795,12 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
>   
>   	# received merge ref from bundle-4, but right is missing
>   	# because we did not download bundle-3.
> -	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
> +	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
>   
>   	cat >expect <<-\EOF &&
> -	refs/bundles/base
> -	refs/bundles/left
> -	refs/bundles/merge
> +	refs/bundles/heads/base
> +	refs/bundles/heads/left
> +	refs/bundles/heads/merge
>   	EOF
>   	test_cmp expect refs &&
>   
> @@ -862,7 +862,7 @@ test_expect_success 'creationToken heuristic with failed downloads (clone)' '
>   	test_cmp expect actual &&
>   
>   	# All bundles failed to unbundle
> -	git -C download-1 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
> +	git -C download-1 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
>   	test_must_be_empty refs &&
>   
>   	# Case 2: middle bundle does not exist, only two bundles can unbundle
> @@ -909,10 +909,10 @@ test_expect_success 'creationToken heuristic with failed downloads (clone)' '
>   	test_cmp expect actual &&
>   
>   	# bundle-1 and bundle-3 could unbundle, but bundle-4 could not
> -	git -C download-2 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
> +	git -C download-2 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
>   	cat >expect <<-EOF &&
> -	refs/bundles/base
> -	refs/bundles/right
> +	refs/bundles/heads/base
> +	refs/bundles/heads/right
>   	EOF
>   	test_cmp expect refs &&
>   
> @@ -961,11 +961,11 @@ test_expect_success 'creationToken heuristic with failed downloads (clone)' '
>   	test_cmp expect actual &&
>   
>   	# fake.bundle did not unbundle, but the others did.
> -	git -C download-3 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
> +	git -C download-3 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
>   	cat >expect <<-EOF &&
> -	refs/bundles/base
> -	refs/bundles/left
> -	refs/bundles/right
> +	refs/bundles/heads/base
> +	refs/bundles/heads/left
> +	refs/bundles/heads/right
>   	EOF
>   	test_cmp expect refs
>   '
> @@ -1083,15 +1083,15 @@ test_expect_success 'creationToken heuristic with failed downloads (fetch)' '
>   	test_cmp expect actual &&
>   
>   	# Check which bundles have unbundled by refs
> -	git -C fetch-1 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
> +	git -C fetch-1 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
>   	cat >expect <<-EOF &&
> -	refs/bundles/base
> -	refs/bundles/left
> -	refs/bundles/lefter
> -	refs/bundles/merge
> -	refs/bundles/right
> -	refs/bundles/righter
> -	refs/bundles/top
> +	refs/bundles/heads/base
> +	refs/bundles/heads/left
> +	refs/bundles/heads/lefter
> +	refs/bundles/heads/merge
> +	refs/bundles/heads/right
> +	refs/bundles/heads/righter
> +	refs/bundles/heads/top
>   	EOF
>   	test_cmp expect refs &&
>   
> @@ -1144,12 +1144,12 @@ test_expect_success 'creationToken heuristic with failed downloads (fetch)' '
>   	test_cmp expect actual &&
>   
>   	# Check which bundles have unbundled by refs
> -	git -C fetch-2 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
> +	git -C fetch-2 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
>   	cat >expect <<-EOF &&
> -	refs/bundles/base
> -	refs/bundles/left
> -	refs/bundles/merge
> -	refs/bundles/right
> +	refs/bundles/heads/base
> +	refs/bundles/heads/left
> +	refs/bundles/heads/merge
> +	refs/bundles/heads/right
>   	EOF
>   	test_cmp expect refs &&
>   
> @@ -1204,13 +1204,13 @@ test_expect_success 'creationToken heuristic with failed downloads (fetch)' '
>   	test_cmp expect actual &&
>   
>   	# Check which bundles have unbundled by refs
> -	git -C fetch-3 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
> +	git -C fetch-3 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
>   	cat >expect <<-EOF &&
> -	refs/bundles/base
> -	refs/bundles/left
> -	refs/bundles/lefter
> -	refs/bundles/right
> -	refs/bundles/righter
> +	refs/bundles/heads/base
> +	refs/bundles/heads/left
> +	refs/bundles/heads/lefter
> +	refs/bundles/heads/right
> +	refs/bundles/heads/righter
>   	EOF
>   	test_cmp expect refs
>   '

