Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE09B1F4CAA
	for <git@vger.kernel.org>; Thu, 15 May 2025 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314195; cv=none; b=Onjd2Is8QsAdentxKYD+lPmn+q/pmbP+eYQNx7huQQC+ZS6VBOUx2sQYdC7ncSsSkKUwmY/4t8QOoYBSYBi0OFstnoPm+XE+15NOvoKazXEmAG1pN25yOh+LtGwpgOSpPWjTby4a38kFNmHxdAqclzMOXa7RsLEZGq0rzDnyyk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314195; c=relaxed/simple;
	bh=ulG5WEXiA6C5pmRDUgzn0Nh7p6zybD5RsxsxhVJJzNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8bAHwh36vUfzsmqqKpyX/0v+fwqp8dtx3OspO+pY2AvQbLFTkd4QzGC5AD16vxGf6ME7+KcGjn/1wFLL+aOHKFKL0uB8CI17/Ak/dhVo7x7bhhom5b4LjfQQc94WJtVAatvCT8HkcYq3U6VKus5VOoLs0zBVbC3MVXPMdDDCAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxL4YDeR; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxL4YDeR"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a0be50048eso826964f8f.0
        for <git@vger.kernel.org>; Thu, 15 May 2025 06:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314192; x=1747918992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nx6Oy+t4JwzHkAR8muQuth1+s/oqbKBZapfh+vsTMDs=;
        b=SxL4YDeRezYLNajq1htWFqSMoMwCwcecI6eEKBk7GoycSg+UsilWNac38ohBBTJpX3
         JXgCjmfTAe6UQq+ha/SmS+BADvl2s3hW640i4rCGTFpj4noDXvFsIM+PMoVTUiPWW/xJ
         a2Kesld83qWeTabIysKghMk4tztctvAojNeSq6O/w4FkDdniGCRAiEQFCn1YLHHdcGPF
         4u29HTQkn5c3dGEKcc3v8w9V9HNOETOirVCTWjccvB2NdAVj8Z1GgluJZ80bQmgRrrXA
         hu51G3UxwJz3kVk2Nu1HF6m5ZmEhFhtcUpWhkhNuMIvHqcOTtk0uG6nP5cQ1d9iZF8M4
         OaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314192; x=1747918992;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nx6Oy+t4JwzHkAR8muQuth1+s/oqbKBZapfh+vsTMDs=;
        b=TPLs1h3b9MPrLP2K8GUbW6LMMX8HOhIUkkWsk8oyaneOLh07mcP6+CdgOh9m8zdV98
         udrJemMWY2CPNs/WpoYYg90VyyN1eKcR0A8UXIHHfmzWj5BdOK1SEpumb4fZzLWs2UPn
         vKj968naC76uG8SdPhewGd81WZWjWmkM77gPUBXqQHozXJd5SeLsf4ReEioaSCeeVTqz
         jyWcr2LcBIzl0HzxoDabSRStG9QCya2VMwlbfpawqCyEMczm5Q1ZMFOZTN+ud1y8JMte
         aXJflzA2rTa2tq+ZE4PH2iHzE20iQlsxotJ9CeKJ9sL6y4oQHj0c7y6DuLDb9teaQn3b
         pbRA==
X-Forwarded-Encrypted: i=1; AJvYcCVptkVRebtDlCjbW5P1G5fWU2pDaB/X3gwPdi5cdP41k4y109C0HcFvDqPnt6LZZJFDyTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWlvSA1ILQijvJxMxCxyikqQ7Sm3/mJCFy2bI7AFvv2P3KPNwj
	KhFRIDrNY+OCqUfuQOuTy5mYrJiu39s4HqsHY8boFeVcv/uZH3yDv0fmYA==
X-Gm-Gg: ASbGnctVzw6ATq4AnLs0/qdLftjNNXZ82TIKuAPHpuplZ0kCLZ3oPCzegVk3F/ePspy
	xroUwZJR2agBAGfry8iNwZqAIbdzQzmXQXzK7pQuQwOREe2ahn4zZhaqB0cAf/EOpLLzZNqftIT
	C6gi5ctMvbRYLIV7PP3Mo+wjNCn54I6YTGBdR5vD4JbjMtABoX0U4alIbzFoJcFD7aXeTHwQn0W
	I9itqz4mtlEdHLDTXG3jLtdRUxQOfnT4YJnT5bpv6A6h4dvF05O+imp8pyrrLejTsiekp5is9Ex
	ZYI6LSlJRbwTj086jbmPZua5EUuicG5qVr2W23vW9eBs7FDapHmsO1idwd6eF6kurK88sNTHlAi
	f8jcfnRFpZNLjRqYNqD3Z/Nun6jO8ny9v9A==
X-Google-Smtp-Source: AGHT+IE/UXghYMv02V4NUXt/S1px5ygN+jkjd0FcPw4des1FNbQWyRLp716bE/decy2AVlR0k9hyQQ==
X-Received: by 2002:a05:600c:4e0e:b0:43c:fdbe:4398 with SMTP id 5b1f17b1804b1-442f20bae9amr70870805e9.6.1747314180340;
        Thu, 15 May 2025 06:03:00 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:efb:6e00:24f3:2d85? ([2a0a:ef40:700:a501:efb:6e00:24f3:2d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ebd46aa4sm63530825e9.1.2025.05.15.06.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 06:02:59 -0700 (PDT)
Message-ID: <f1de4a91-2d64-457d-9272-3ccb56393825@gmail.com>
Date: Thu, 15 May 2025 14:02:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sequencer: make it clearer that commit descriptions are
 just comments
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
References: <pull.1923.git.1747275627422.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.1923.git.1747275627422.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Elijah

On 15/05/2025 03:20, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Every once in a while, users report that editing the commit summaries
> in the todo list does not get reflected in the rebase operation,
> suggesting that users are (a) only using one-line commit messages, and
> (b) not understanding that the commit summaries are merely helpful
> comments to help them find the right hashes.
> 
> It may be difficult to correct users' poor commit messages, but we can
> at least try to make it clearer that the commit summaries are not
> directives of some sort by inserting a comment character.  Hopefully
> that leads to them looking a little further and noticing the hints at
> the bottom to use 'reword' or 'edit' directives.
> 
> Yes, this change may look funny at first since it hardcodes '#' rather
> than using comment_line_str.  However:
> 
>    * comment_line_str exists to allow disambiguation between lines in
>      a commit message and lines that are instructions to users editing
>      the commit message.  No such disambiguation is needed for these
>      comments that occur on the same line after existing directives
>    * the exact "comment" character(s) on regular pick lines used aren't
>      actually important; I could have used anything, including completely
>      random variable length text for each line and it'd work because we
>      ignore everything after 'pick' and the hash.
>    * The whole point of this change is to signal to users that they
>      should NOT be editing any part of the line after the hash (and if
>      they do so, their edits will be ignored), while the whole point of
>      comment_line_str is to allow highly flexible editing.  So making
>      it more general by using comment_line_str actually feels
>      counterproductive.
>    * The character for merge directives absolutely must be '#'; that
>      has been deeply hardcoded for a long time (see below), and will
>      break if some other comment character is used instead.  In a
>      desire to have pick and merge directives be similar, I use the
>      same comment character for both.
>    * Perhaps merge directives could be fixed to not be inflexible about
>      the comment character used, if someone feels highly motivated, but
>      I think that should be done in a separate follow-on patch.
> 
> Here are (some of?) the locations where '#' has already been hardcoded
> for a long time for merges:
> 
>    1) In check_label_or_ref_arg():
> 	case TODO_LABEL:
> 		/*
> 		 * '#' is not a valid label as the merge command uses it to
> 		 * separate merge parents from the commit subject.
> 		 */
> 
>    2) In do_merge():
> 
> 	/*
> 	 * For octopus merges, the arg starts with the list of revisions to be
> 	 * merged. The list is optionally followed by '#' and the oneline.
> 	 */
> 	merge_arg_len = oneline_offset = arg_len;
> 	for (p = arg; p - arg < arg_len; p += strspn(p, " \t\n")) {
> 		if (!*p)
> 			break;
> 		if (*p == '#' && (!p[1] || isspace(p[1]))) {
> 
>    3) In label_oid():
> 
> 		if ((buf->len == the_hash_algo->hexsz &&
> 		     !get_oid_hex(label, &dummy)) ||
> 		    (buf->len == 1 && *label == '#') ||
> 		    hashmap_get_from_hash(&state->labels,
> 					  strihash(label), label)) {
> 			/*
> 			 * If the label already exists, or if the label is a
> 			 * valid full OID, or the label is a '#' (which we use
> 			 * as a separator between merge heads and oneline), we
> 			 * append a dash and a number to make it unique.
> 			 */

Thanks for the comprehensive commit message. I think this change is a 
very good idea. The code changes all look good to me. I've left one 
comment on the tests below though I should admit that I could feel my 
eyes glazing over by the time I got to the end of all the test changes. 
The test changes are pretty much all mechanical though so I'm reasonably 
confidant that the tests would fail if there was something wrong with 
the conversion.

> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 47534f1062d..52a5e4c016b 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -813,7 +813,7 @@ test_expect_success 'git pull --rebase does not reapply old patches' '
>   		cd dst &&
>   		test_must_fail git pull --rebase &&
>   		cat .git/rebase-merge/done .git/rebase-merge/git-rebase-todo >work &&
> -		grep -v -e \# -e ^$ work >patches &&
> +		sed -e s/#.*// work | grep -v ^$ >patches &&

I think we could just use 'sed -n "!/^#/p work >patches &&" here

Thanks

Phillip
