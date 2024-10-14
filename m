Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220E118035
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914434; cv=none; b=XZ0I3iYNG1LbGMDOmL6LietsxNCS4Ns++nX9ABPs9eehYiuiqXog1CnODwOGNVVi3Y5BTRY7TS4MNWpwLulgDwfZp2to8uHHDM3KZPl4ekpHtFxl9Cuqckirjc2Uh8+7qF0QSuYrrjqCjpEk8qyEHhPo23mFZTEk8wUfs0zUtNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914434; c=relaxed/simple;
	bh=CUPe+7g4VT/JYDauAEH4Psv5y/dgiB7uXUPqEFxH+S8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tC+gbUwrDHmouPHgJPtg0aUdnaktXReEnNMBNo9ptQsEBZNEtKXowrsR8NUHa1lYYdndztYBOHZat7pAucbAHxHKJbWnmacVTvRzJN3b3amOjd7xX8GaaqwnMF10aiL8Uoufcrv88KqtPp6xg3uKhLv/+z7ZDsDlYMFPgcQlqak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B49Za71E; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B49Za71E"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5369f1c7cb8so5354403e87.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 07:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728914430; x=1729519230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CjIhU710wNioUNoNtq6AMhipYZ3M5H1gc22d+YaceEs=;
        b=B49Za71E62+BNXItnEy8b70gytWyiffRiOujN0lWhVf4qops0OzOtueGAiTD0Mcwrl
         MGD6K4YyHHy2GWHlZ951hXrt+V3834BPnlVCo9r9gOPYs62OYZJeoC1jZ5pdbd8yoFUV
         tSL3LsASIfrt+J9zWNjueaYCpv1NGgU86JV11mdKMMRQXbf7W+WqHnEmXvopusUMCY/U
         eFCM02dba44oFuLohHE39CERXXb/q5+Pn+POPoujTHDCb/3RD942QEmRviXHas6Medac
         hhIBuNwh8rPOy5nkyqVyppFuOle1Lh4ExXLl/5Rn6KPqQ6nie6CQjh5eobuWX8bNt3Fz
         IfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728914430; x=1729519230;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CjIhU710wNioUNoNtq6AMhipYZ3M5H1gc22d+YaceEs=;
        b=iCBqo6UEsXZIkt6kcZ5plPLazAAQd3SBOHRwpek5c3WSyKhlQlVFZcvmwpeXdNljBv
         jmEq++KYSTd+ZvigMstn1a5fvyWpNHw9Sh/HPKsci8LJiH69hMX83ShpL2lvi+hjBEN/
         xO+jHWf0RuL07KBDKtD9Qt/fXc4ObDfNv7lzohPjoL/qD3P113T5HMqA+9DHahSqoLlB
         o8NedoTSpB0dGevtLE474FxNy+fd6wlsjzAXaaz9L/b2ewSfVDPtG7lrzpdwho6/fN2L
         xX0tV7OqzrtCFvV2QNL06Rle7SW9kB8/pDgJu50HB4jJeiYS+ddza61EzCEsBZAcXCwd
         OIXw==
X-Gm-Message-State: AOJu0YzzOv9osF+Kc2SZmICQNmsyc2nXJUdKAUfwEJDW7B4aidL/OKWf
	42szxbCPsYP8C6E1QYbKOol8NnwAS9yxjrdr2WPQ0E/iQe8YjlmN
X-Google-Smtp-Source: AGHT+IF7iwDEYw2xbQvBOIkaP5GCYW3x0SfIdY9mS/I92VD5mv3WyWUTf4J+7DkBEG64a6/HqOFLNw==
X-Received: by 2002:a05:6512:401a:b0:536:54df:bff2 with SMTP id 2adb3069b0e04-539e574b7e4mr3080889e87.54.1728914429732;
        Mon, 14 Oct 2024 07:00:29 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d605c197bsm7195582f8f.38.2024.10.14.07.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 07:00:29 -0700 (PDT)
Message-ID: <879cac32-f59c-4adb-973e-4a8fc1770f8e@gmail.com>
Date: Mon, 14 Oct 2024 15:00:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy][PATCH v5] t6050: avoid pipes with upstream Git
 commands
To: chizobajames21@gmail.com
Cc: git@vger.kernel.org, gitster@pobox.com, phillip.wood@dunelm.org.uk,
 ps@pks.im, sunshine@sunshineco.com
References: <20241011235959.596136-1-chizobajames21@gmail.com>
 <20241012062126.603967-1-chizobajames21@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20241012062126.603967-1-chizobajames21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chizoba

On 12/10/2024 07:21, chizobajames21@gmail.com wrote:
> From: Chizoba ODINAKA <chizobajames21@gmail.com>
> 
> In pipes, the exit code of a chain of commands is determined by
> the final command. In order not to miss the exit code of a failed
> Git command, avoid pipes instead write output of Git commands
> into a file.
> For better debugging experience, instances of "grep" were changed
> to "test_grep". "test_grep" provides more context in case of a
> failed "grep".
> 
> Signed-off-by: Chizoba ODINAKA <chizobajames21@gmail.com>
> Changes in v5:
> - replace 'sort -o' which might not be supported by some platforms
>    to the more conventional output redirection, > .

It's really helpful to list the changes like this, but please do so 
below the "---" line so it does not become part of the commit message 
when the patch is applied. The range-diff looks good, with a fixed up 
commit message I think we can declare victory for this microproject.

Best Wishes

Phillip

> ---
> Range-diff against v4:
> 1:  28cab4c752 ! 1:  b339b1f550 t6050: avoid pipes with upstream Git commands
>      @@ Commit message
>           failed "grep".
>       
>           Signed-off-by: Chizoba ODINAKA <chizobajames21@gmail.com>
>      -    Changes in v4:
>      -    - Correct the subject
>      -    - fixed some ommitted output option in sorts that where writing to
>      -      stdout
>      +    Changes in v5:
>      +    - replace 'sort -o' which might not be supported by some platforms
>      +      to the more conventional output redirection, > .
>       
>        ## t/t6050-replace.sh ##
>       @@ t/t6050-replace.sh: test_expect_success 'set up buggy branch' '
>      @@ t/t6050-replace.sh: test_expect_success 'test --format medium' '
>        		echo "$MYTAG -> $HASH1"
>        	} | sort >expected &&
>       -	git replace -l --format medium | sort >actual &&
>      -+	git replace -l --format medium >actual &&
>      -+	sort actual -o actual &&
>      ++	git replace -l --format medium >output &&
>      ++	sort output >actual &&
>        	test_cmp expected actual
>        '
>        
>      @@ t/t6050-replace.sh: test_expect_success 'test --format long' '
>        		echo "$MYTAG (tag) -> $HASH1 (commit)"
>        	} | sort >expected &&
>       -	git replace --format=long | sort >actual &&
>      -+	git replace --format=long >actual &&
>      -+	sort actual -o actual &&
>      ++	git replace --format=long >output &&
>      ++	sort output >actual &&
>        	test_cmp expected actual
>        '
>        
> 
>   t/t6050-replace.sh | 133 +++++++++++++++++++++++++++++----------------
>   1 file changed, 86 insertions(+), 47 deletions(-)
> 
> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> index d7702fc756..37cb6547b6 100755
> --- a/t/t6050-replace.sh
> +++ b/t/t6050-replace.sh
> @@ -98,30 +98,42 @@ test_expect_success 'set up buggy branch' '
>   '
>   
>   test_expect_success 'replace the author' '
> -	git cat-file commit $HASH2 | grep "author A U Thor" &&
> -	R=$(git cat-file commit $HASH2 | sed -e "s/A U/O/" | git hash-object -t commit --stdin -w) &&
> -	git cat-file commit $R | grep "author O Thor" &&
> +	git cat-file commit $HASH2 >actual &&
> +	test_grep "author A U Thor" actual &&
> +	R=$(sed -e "s/A U/O/" actual | git hash-object -t commit --stdin -w) &&
> +	git cat-file commit $R >actual &&
> +	test_grep "author O Thor" actual &&
>   	git update-ref refs/replace/$HASH2 $R &&
> -	git show HEAD~5 | grep "O Thor" &&
> -	git show $HASH2 | grep "O Thor"
> +	git show HEAD~5 >actual &&
> +	test_grep "O Thor" actual &&
> +	git show $HASH2 >actual &&
> +	test_grep "O Thor" actual
>   '
>   
>   test_expect_success 'test --no-replace-objects option' '
> -	git cat-file commit $HASH2 | grep "author O Thor" &&
> -	git --no-replace-objects cat-file commit $HASH2 | grep "author A U Thor" &&
> -	git show $HASH2 | grep "O Thor" &&
> -	git --no-replace-objects show $HASH2 | grep "A U Thor"
> +	git cat-file commit $HASH2 >actual &&
> +	test_grep "author O Thor" actual &&
> +	git --no-replace-objects cat-file commit $HASH2 >actual &&
> +	test_grep "author A U Thor" actual &&
> +	git show $HASH2 >actual &&
> +	test_grep "O Thor" actual &&
> +	git --no-replace-objects show $HASH2 >actual &&
> +	test_grep "A U Thor" actual
>   '
>   
>   test_expect_success 'test GIT_NO_REPLACE_OBJECTS env variable' '
> -	GIT_NO_REPLACE_OBJECTS=1 git cat-file commit $HASH2 | grep "author A U Thor" &&
> -	GIT_NO_REPLACE_OBJECTS=1 git show $HASH2 | grep "A U Thor"
> +	GIT_NO_REPLACE_OBJECTS=1 git cat-file commit $HASH2 >actual &&
> +	test_grep "author A U Thor"  actual &&
> +	GIT_NO_REPLACE_OBJECTS=1 git show $HASH2 >actual &&
> +	test_grep "A U Thor" actual
>   '
>   
>   test_expect_success 'test core.usereplacerefs config option' '
>   	test_config core.usereplacerefs false &&
> -	git cat-file commit $HASH2 | grep "author A U Thor" &&
> -	git show $HASH2 | grep "A U Thor"
> +	git cat-file commit $HASH2 >actual &&
> +	test_grep "author A U Thor" actual &&
> +	git show $HASH2 >actual &&
> +	test_grep "A U Thor" actual
>   '
>   
>   cat >tag.sig <<EOF
> @@ -148,14 +160,18 @@ test_expect_success 'repack, clone and fetch work' '
>   	git clone --no-hardlinks . clone_dir &&
>   	(
>   		cd clone_dir &&
> -		git show HEAD~5 | grep "A U Thor" &&
> -		git show $HASH2 | grep "A U Thor" &&
> +		git show HEAD~5 >actual &&
> +		test_grep "A U Thor" actual &&
> +		git show $HASH2 >actual &&
> +		test_grep "A U Thor" actual &&
>   		git cat-file commit $R &&
>   		git repack -a -d &&
>   		test_must_fail git cat-file commit $R &&
>   		git fetch ../ "refs/replace/*:refs/replace/*" &&
> -		git show HEAD~5 | grep "O Thor" &&
> -		git show $HASH2 | grep "O Thor" &&
> +		git show HEAD~5 >actual &&
> +		test_grep "O Thor" actual &&
> +		git show $HASH2 >actual &&
> +		test_grep "O Thor" actual &&
>   		git cat-file commit $R
>   	)
>   '
> @@ -169,13 +185,15 @@ test_expect_success '"git replace" listing and deleting' '
>   	test_must_fail git replace --delete &&
>   	test_must_fail git replace -l -d $HASH2 &&
>   	git replace -d $HASH2 &&
> -	git show $HASH2 | grep "A U Thor" &&
> +	git show $HASH2 >actual &&
> +	test_grep "A U Thor" actual &&
>   	test -z "$(git replace -l)"
>   '
>   
>   test_expect_success '"git replace" replacing' '
>   	git replace $HASH2 $R &&
> -	git show $HASH2 | grep "O Thor" &&
> +	git show $HASH2 >actual &&
> +	test_grep "O Thor" actual &&
>   	test_must_fail git replace $HASH2 $R &&
>   	git replace -f $HASH2 $R &&
>   	test_must_fail git replace -f &&
> @@ -186,7 +204,8 @@ test_expect_success '"git replace" resolves sha1' '
>   	SHORTHASH2=$(git rev-parse --short=8 $HASH2) &&
>   	git replace -d $SHORTHASH2 &&
>   	git replace $SHORTHASH2 $R &&
> -	git show $HASH2 | grep "O Thor" &&
> +	git show $HASH2 >actual &&
> +	test_grep "O Thor" actual &&
>   	test_must_fail git replace $HASH2 $R &&
>   	git replace -f $HASH2 $R &&
>   	test_must_fail git replace --force &&
> @@ -209,10 +228,12 @@ test_expect_success '"git replace" resolves sha1' '
>   #
>   test_expect_success 'create parallel branch without the bug' '
>   	git replace -d $HASH2 &&
> -	git show $HASH2 | grep "A U Thor" &&
> +	git show $HASH2 >actual &&
> +	test_grep "A U Thor" actual &&
>   	git checkout $HASH1 &&
>   	git cherry-pick $HASH2 &&
> -	git show $HASH5 | git apply &&
> +	git show $HASH5 >actual &&
> +	git apply actual &&
>   	git commit --amend -m "hello: 4 more lines WITHOUT the bug" hello &&
>   	PARA2=$(git rev-parse --verify HEAD) &&
>   	git cherry-pick $HASH3 &&
> @@ -225,7 +246,8 @@ test_expect_success 'create parallel branch without the bug' '
>   	git checkout main &&
>   	cur=$(git rev-parse --verify HEAD) &&
>   	test "$cur" = "$HASH7" &&
> -	git log --pretty=oneline | grep $PARA2 &&
> +	git log --pretty=oneline >actual &&
> +	test_grep $PARA2 actual &&
>   	git remote add cloned ./clone_dir
>   '
>   
> @@ -234,23 +256,30 @@ test_expect_success 'push to cloned repo' '
>   	(
>   		cd clone_dir &&
>   		git checkout parallel &&
> -		git log --pretty=oneline | grep $PARA2
> +		git log --pretty=oneline >actual &&
> +		test_grep $PARA2 actual
>   	)
>   '
>   
>   test_expect_success 'push branch with replacement' '
> -	git cat-file commit $PARA3 | grep "author A U Thor" &&
> -	S=$(git cat-file commit $PARA3 | sed -e "s/A U/O/" | git hash-object -t commit --stdin -w) &&
> -	git cat-file commit $S | grep "author O Thor" &&
> +	git cat-file commit $PARA3 >actual &&
> +	test_grep "author A U Thor" actual &&
> +	S=$(sed -e "s/A U/O/" actual | git hash-object -t commit --stdin -w) &&
> +	git cat-file commit $S >actual &&
> +	test_grep "author O Thor" actual &&
>   	git replace $PARA3 $S &&
> -	git show $HASH6~2 | grep "O Thor" &&
> -	git show $PARA3 | grep "O Thor" &&
> +	git show $HASH6~2 >actual &&
> +	test_grep "O Thor" actual &&
> +	git show $PARA3 >actual &&
> +	test_grep "O Thor" actual &&
>   	git push cloned $HASH6^:refs/heads/parallel2 &&
>   	(
>   		cd clone_dir &&
>   		git checkout parallel2 &&
> -		git log --pretty=oneline | grep $PARA3 &&
> -		git show $PARA3 | grep "A U Thor"
> +		git log --pretty=oneline >actual &&
> +		test_grep $PARA3 actual &&
> +		git show $PARA3 >actual &&
> +		test_grep "A U Thor" actual
>   	)
>   '
>   
> @@ -260,14 +289,14 @@ test_expect_success 'fetch branch with replacement' '
>   		cd clone_dir &&
>   		git fetch origin refs/heads/tofetch:refs/heads/parallel3 &&
>   		git log --pretty=oneline parallel3 >output.txt &&
> -		! grep $PARA3 output.txt &&
> +		test_grep ! $PARA3 output.txt &&
>   		git show $PARA3 >para3.txt &&
> -		grep "A U Thor" para3.txt &&
> +		test_grep "A U Thor" para3.txt &&
>   		git fetch origin "refs/replace/*:refs/replace/*" &&
>   		git log --pretty=oneline parallel3 >output.txt &&
> -		grep $PARA3 output.txt &&
> +		test_grep $PARA3 output.txt &&
>   		git show $PARA3 >para3.txt &&
> -		grep "O Thor" para3.txt
> +		test_grep "O Thor" para3.txt
>   	)
>   '
>   
> @@ -284,8 +313,8 @@ test_expect_success 'bisect and replacements' '
>   '
>   
>   test_expect_success 'index-pack and replacements' '
> -	git --no-replace-objects rev-list --objects HEAD |
> -	git --no-replace-objects pack-objects test- &&
> +	git --no-replace-objects rev-list --objects HEAD >actual &&
> +	git --no-replace-objects pack-objects test- <actual &&
>   	git index-pack test-*.pack
>   '
>   
> @@ -319,7 +348,8 @@ test_expect_success '-f option bypasses the type check' '
>   '
>   
>   test_expect_success 'git cat-file --batch works on replace objects' '
> -	git replace | grep $PARA3 &&
> +	git replace >actual &&
> +	test_grep $PARA3 actual &&
>   	echo $PARA3 | git cat-file --batch
>   '
>   
> @@ -344,7 +374,8 @@ test_expect_success 'test --format medium' '
>   		echo "$PARA3 -> $S" &&
>   		echo "$MYTAG -> $HASH1"
>   	} | sort >expected &&
> -	git replace -l --format medium | sort >actual &&
> +	git replace -l --format medium >output &&
> +	sort output >actual &&
>   	test_cmp expected actual
>   '
>   
> @@ -356,7 +387,8 @@ test_expect_success 'test --format long' '
>   		echo "$PARA3 (commit) -> $S (commit)" &&
>   		echo "$MYTAG (tag) -> $HASH1 (commit)"
>   	} | sort >expected &&
> -	git replace --format=long | sort >actual &&
> +	git replace --format=long >output &&
> +	sort output >actual &&
>   	test_cmp expected actual
>   '
>   
> @@ -374,12 +406,16 @@ test_expect_success 'setup fake editors' '
>   test_expect_success '--edit with and without already replaced object' '
>   	test_must_fail env GIT_EDITOR=./fakeeditor git replace --edit "$PARA3" &&
>   	GIT_EDITOR=./fakeeditor git replace --force --edit "$PARA3" &&
> -	git replace -l | grep "$PARA3" &&
> -	git cat-file commit "$PARA3" | grep "A fake Thor" &&
> +	git replace -l >actual &&
> +	test_grep "$PARA3" actual &&
> +	git cat-file commit "$PARA3" >actual &&
> +	test_grep "A fake Thor" actual &&
>   	git replace -d "$PARA3" &&
>   	GIT_EDITOR=./fakeeditor git replace --edit "$PARA3" &&
> -	git replace -l | grep "$PARA3" &&
> -	git cat-file commit "$PARA3" | grep "A fake Thor"
> +	git replace -l >actual &&
> +	test_grep "$PARA3" actual &&
> +	git cat-file commit "$PARA3" >actual &&
> +	test_grep "A fake Thor" actual
>   '
>   
>   test_expect_success '--edit and change nothing or command failed' '
> @@ -387,8 +423,10 @@ test_expect_success '--edit and change nothing or command failed' '
>   	test_must_fail env GIT_EDITOR=true git replace --edit "$PARA3" &&
>   	test_must_fail env GIT_EDITOR="./failingfakeeditor" git replace --edit "$PARA3" &&
>   	GIT_EDITOR=./fakeeditor git replace --edit "$PARA3" &&
> -	git replace -l | grep "$PARA3" &&
> -	git cat-file commit "$PARA3" | grep "A fake Thor"
> +	git replace -l >actual &&
> +	test_grep "$PARA3" actual &&
> +	git cat-file commit "$PARA3" >actual &&
> +	test_grep "A fake Thor" actual
>   '
>   
>   test_expect_success 'replace ref cleanup' '
> @@ -468,7 +506,8 @@ test_expect_success GPG 'set up a merge commit with a mergetag' '
>   	git checkout main &&
>   	git merge -s ours test_tag &&
>   	HASH10=$(git rev-parse --verify HEAD) &&
> -	git cat-file commit $HASH10 | grep "^mergetag object"
> +	git cat-file commit $HASH10 >actual &&
> +	test_grep "^mergetag object" actual
>   '
>   
>   test_expect_success GPG '--graft on a commit with a mergetag' '

