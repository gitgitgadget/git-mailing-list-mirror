Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123681DF753
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732293879; cv=none; b=NlnebmljzrMnkkcaFj22gD8mcSXvz7/0V4KFQhYqawiZdMVhY8A/agTL2yh17fuf/TaqJm+gqXmxTUIkxQ2nQ+TCO53w+WCSpajyo3/HyvaTEG/cnx76GenY9pMzmd4Vap5gvQ35spHu/+Nu+kKbyhZx+vq+/6iUcPHN64fKjIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732293879; c=relaxed/simple;
	bh=BaxuctNMArHKJn8G89iOrUCB0KkQpSfaJtfqKcSaZIs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FXPI8dqq5k9fPdeUNv0TAocA1yzcf9cIam8ugSyKZw5L1KZUQr8Z4K7EpOQKV4FPMaiULhuSqpsXikTEMz03bXU7j4BgkedJdLvu6ob1DRwJjRpgM5UrgX0Zd5ogMe8/6h8LKZfZ7JaJDSw7EPjTYftddLyljZ3hE1lxSpSimFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V00x9Y72; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V00x9Y72"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3823cf963f1so1396760f8f.1
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 08:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732293876; x=1732898676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/xIOAK+WeUVv3FQdXW0qTCPjtX4jnqje8QOY19ICsyc=;
        b=V00x9Y72w3wI9jkD0c+LhwtmeGtWQ3dW027aQWJux3elAaHrjkXQrd2XeMXyedlQ+q
         yw8rbhs5jgSmTOvMl+EP5EZO1yuEjrlydcRM86VhMjwWp0UFbCGkuyRBepvl3Kic/0wY
         9n9knF0ZIe19vXXluVxJqgk/piNKR0B5Od7CyXnXQhMrH+mKntjZTT9wdzpG1OBSzH+s
         dcu35dMrivt061EyAL15w4fkVajztXsxGpAJ11IPFDWThxi5GGM5qIE2e1qj6IuYDXEc
         PvNr/TgnjUU1+UbkSLIpiZlw0doQHh06PggK6YMM7mD4PMKxAmNncdANv81QxXUMQXqU
         8I2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732293876; x=1732898676;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xIOAK+WeUVv3FQdXW0qTCPjtX4jnqje8QOY19ICsyc=;
        b=k6vNkubcOCFv2AaljrW8fZqPY/iwK7vhjeDrf4d9Xdt+1L4wnC8mVABAB/33/DtKvd
         cckFP/2KDsfRVcvSKY/ywTOt/BJolPwS54Agzq4oo7s43okN4KTGquB04G28nG+Gr2ZD
         UmF+jn4WrwpDom+VbFGc9zSDlXcfv3NuwnLNW5g3QTqnjE+Qv15nOunuIP1ArXZqJdQt
         0NG570cTWJcGH7UbxbQhrgLj6FF/cF+SwEatA6MwEM4ip6AxGkJ8nJWOlyOg2srVhw1f
         arDhbZFc1OpYLBlq7xQOy7upp916taCj2bKGLyHqPxAGbRX4QC9Bq9tWUuM776kHdqAe
         Np+A==
X-Forwarded-Encrypted: i=1; AJvYcCVim0AnmjY4qQqX+r3VEkF/Ls4x3fQzME+fyeZ9Y4x+ugFJuAl66cXFKu6jGI5KfHWGOlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydaz1XQWedVQkRaVcLEJrNg3BIUkmehcIXplHPzP+xPZDIb02C
	IqL01nA0ZqO204n7+yo1qmDkMosYB6RXCzvjrta7fKlzNwaNjqzH
X-Gm-Gg: ASbGncs4pokeIzk9GTyvQmHbky/PNRCnP4rLO6eio/ClsFBQQFE1sppShrZA3+6Y99E
	I0e5TYi0FKP1IM4NdvaXbwHWJi6cERJ3JKBYcHkTXh3SLRo9Fw3FO+qUCr7GwIFwg9el7cf0KFB
	6ozQ6J5WY6uBfjWQJRcQ1b8jpud2pbTuW9JRcqySbsralV1Ntgl2G3kczHS19Y/+h7QfX+A+ypT
	FMRjiEDchR8qBa8RUgzMvNt7PdfunuLBRZ8Gccz7aTIbPSawpE2sVF3bcO/B3nT8a7on9uNvOwa
	MAfhz5wQ0SPuroYOe6p5pLGJfw==
X-Google-Smtp-Source: AGHT+IGvGpAlKwyBFvh3IDgxOfz9L/u2ewZZkfTJVrxnd5Ldl0mhuVywQ3SuXcB2UA/T/I776bub0w==
X-Received: by 2002:a5d:6dab:0:b0:37c:d244:bdb1 with SMTP id ffacd0b85a97d-38260b6ac70mr2869776f8f.26.1732293876268;
        Fri, 22 Nov 2024 08:44:36 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6a8:b801:610:d596:f87c:e591? ([2a0a:ef40:6a8:b801:610:d596:f87c:e591])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbe91a6sm2892369f8f.86.2024.11.22.08.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 08:44:35 -0800 (PST)
Message-ID: <7ddddf98-840d-4d36-b3bb-6d5265a1362f@gmail.com>
Date: Fri, 22 Nov 2024 16:44:35 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 5/8] worktree: add relative cli/config options to `add`
 command
To: Caleb White <cdwhite3@pm.me>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
 <20241031-wt_relative_options-v4-5-07a3dc0f02a3@pm.me>
 <20fdb5ba-075f-48b5-9e92-f85378500710@gmail.com>
 <D5QQQCUL0DR7.31L4W6C4NT6UU@pm.me>
Content-Language: en-US
In-Reply-To: <D5QQQCUL0DR7.31L4W6C4NT6UU@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Caleb

On 20/11/2024 05:01, Caleb White wrote:
> On Tue Nov 19, 2024 at 9:07 AM CST, Phillip Wood wrote:
> 
>>> +--[no-]relative-paths::
>>> +	Overrides the `worktree.useRelativePaths` config option, see
>>> +	linkgit:git-config[1].
>>
>> I think it would be helpful to describe what this option does directly,
>> rather than in terms of a config setting which is documented elsewhere
>> and that may not be set
> 
> I originally had a description here, but it was requested by another
> reviewer that I remove the duplicate information and simply reference
> the config option. I don't mind which direction we go, but we need
> some consensus on this.

Oh right, from a user's point of view describing an option in terms of a 
config option that may not be set seems a bit confusing. Looking at the 
man page we describe --[no-]guess-remote and then mention the config 
option rather than just referring the reader to the config man page.

Best Wishes

Phillip

>>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>>> index dae63dedf4cac2621f51f95a39aa456b33acd894..e3b4a71ee0bc13d5e817cf7dcc398e9e2bd975de 100644
>>> --- a/builtin/worktree.c
>>> +++ b/builtin/worktree.c
>>> @@ -120,12 +120,14 @@ struct add_opts {
>>>    	int quiet;
>>>    	int checkout;
>>>    	int orphan;
>>> +	int relative_paths;
>>
>> Excellent - thanks for getting rind of the global in /worktree.c
> 
> Thanks! I'm happy with how this turned out.
> 
>>> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
>>> index cfc4aeb1798c6d023909cec771e5b74e983af5ea..d36d8a4db0e924877787697579544f10f92dc0cf 100755
>>> --- a/t/t2400-worktree-add.sh
>>> +++ b/t/t2400-worktree-add.sh
>>> @@ -1207,4 +1207,58 @@ test_expect_success '"add" with initialized submodule, with submodule.recurse se
>>>    	git -C project-clone -c submodule.recurse worktree add ../project-5
>>>    '
>>>
>>> +test_expect_success 'can create worktrees with relative paths' '
>>> +	test_when_finished "git worktree remove relative" &&
>>> +	git config worktree.useRelativePaths false &&
>>
>> Using test_config instead of "git config" ensures the setting is cleared
>> at the end of the test
> 
> Ah, good to know! I'll update.
> 
>>> +	git worktree add --relative-paths ./relative &&
>>> +	cat relative/.git >actual &&
>>
>> There's no need to copy the file just so we can say "actual" below
> 
> Good point. I saw this pattern in other tests and thought it was
> standard practice. I'll update.
> 
>>> +test_expect_success 'can create worktrees with absolute paths' '
>>> +	git config worktree.useRelativePaths true &&
>>> +	git worktree add ./relative &&
>>> +	cat relative/.git >actual &&
>>> +	echo "gitdir: ../.git/worktrees/relative" >expect &&
>>> +	test_cmp expect actual &&
>>> +	git worktree add --no-relative-paths ./absolute &&
>>> +	cat absolute/.git >actual &&
>>> +	echo "gitdir: $(pwd)/.git/worktrees/absolute" >expect &&
>>> +	test_cmp expect actual
>>> +'
>>
>> We're only checking ".git" here and not the "gitdir" file as well, I
>> guess that's ok as the implemntation that writes the files is tested
>> above and here we're interesting in testing the config setting.
> 
> I can just add a test for the other file to be complete.
> 
>>> +test_expect_success 'move repo without breaking relative internal links' '
>>> +	test_when_finished rm -rf repo moved &&
>>> +	git init repo &&
>>> +	(
>>> +		cd repo &&
>>> +		git config worktree.useRelativePaths true &&
>>> +		test_commit initial &&
>>> +		git worktree add wt1 &&
>>> +		cd .. &&
>>> +		mv repo moved &&
>>> +		cd moved/wt1 &&
>>> +		git status >out 2>err &&
>>> +		test_must_be_empty err
>>
>> This relies on "git status" failing if the worktree links are broken. A
>> more direct test might be to check the output of "git worktree list" or
>> "git rev-parse --git-dir".
> 
> All three commands would have the same error message, but I suppose I
> could switch to `git worktree list` for a more direct test.
> 
>>> +test_expect_success 'relative worktree sets extension config' '
>>> +	test_when_finished "rm -rf repo" &&
>>> +	git init repo &&
>>> +	git -C repo commit --allow-empty -m base &&
>>> +	git -C repo worktree add --relative-paths ./foo &&
>>> +	git -C repo config get core.repositoryformatversion >actual &&
>>> +	echo 1 >expected &&
>>> +	test_cmp expected actual &&
>>
>> This can be done with
>>
>> 	test_cmp_config -C repo 1 core.repositoryformatversion
> 
> Sweet! I like it.
> 
> 
> Best,
> 
> Caleb
> 
> 

