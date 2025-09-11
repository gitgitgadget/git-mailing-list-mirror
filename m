Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C569034AB16
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604421; cv=none; b=njz8ZNsip7zcQMx0aU6WWII94RJd5iApyG73PqWoECK6y1maI7mQnfY+A1FL83QDNkivkJh9FLn+6oHg1KcENEvPGQ8kzCWIg6gJqGKmYpwYgVVzJiWNKsOH6uXKsh5sLnipFAATEzymE0f0IYpcQa+KovrBv8ex3QjpcfYT4LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604421; c=relaxed/simple;
	bh=xswPPHlONsK0ayCe2Ll+yUubibpVMXCCi3OCF8+pG8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvyjPHueJ/dVUX8U51Sxaqioc4e6OQyYTzmf8Qac5+ezSP5rKNWHAJ9njiqJ7XZnkdiRRRwxKgVVfCC7BfTeKXRNf5iLfmedxnyJSx/NzvSX4rJ8JRamgxscVtrJjxDkxb+B5R33egSRCeUqzEYR6/HPfDeKctI76yjDBzWKQYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEno1UZf; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEno1UZf"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-817f3d08465so78558885a.2
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 08:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757604419; x=1758209219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fcE86ESXyl3wSpLFPRbtDGwgDVYiKqRZ084VZumwoss=;
        b=XEno1UZf6pSj6c0DDF4aZ1ItNHjdUKTa3gP/6qP631pkiDrtNFBye6FfPZuh43I0Dw
         eDcYZ9pCgrOzOPz1g4QhNoAJ1DP/ZdGj0U9t6SjtY04XD6B8tLrdKlxMUSw59uScy7n7
         0Z9eO5WefhqiYt7XHIV0jPtB3dMGMAytbz9aeAAkBXZx8ABMFomf4tsnm+jH7LI2yInN
         D6aUflrFNyHemkSUGC4iAZXXSVtHr4qF+LfbiYvfqWC7xWKsleDDzGrkD15rH6JQ876x
         m1sp27IdeUcV0pUJHJe15MDo6jwnLASs909ypf6MANq7Ucx5ZQwO3yIh18m0WbbQQ4fR
         yCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757604419; x=1758209219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcE86ESXyl3wSpLFPRbtDGwgDVYiKqRZ084VZumwoss=;
        b=LKtqe05NMoa85+lZbOFIpFCiGi64hWcxigs5HZF6AbWeHS4A+R7dVM4ZMk7iUIAb7s
         R/uCsolFYjaciWs4ws8m9REKEBPGoZhD679jkbJc1a4UFDxRGBsi6zM69Z4fY/R57Qks
         quEhYYZ9PHNHB0IL5+Q/IY4ymWVP5QKkvGt3qF3JfImzucakp7F63AVkMQmaw6yDOoFs
         EuQIt+qGnTAWG0c5M5OhrTQtPcVEWOnbCvJ0RzB9lPVc8b5rsqwREyzjGp0L1C31KtOi
         7Z76hqnR4Wclls4YCJZX6fg64qotWG9IgXnmVJdM74vEchSE1KPeAYzVL5d3cJBKaa6w
         LLwA==
X-Gm-Message-State: AOJu0YyXCvsL1zznH5mQP1uD81ygSjHJktoVWwGVrj7IXOSKxwl1P4FZ
	HQzmq4W9mBymjkHP4cZRw2RljfnuOjxaifDjr2Dh6DCJGa7Pmow1wkwz
X-Gm-Gg: ASbGncvbviD/kvgY90+nqeO7g0bw8NnI9PBMSF0dw7BnU9SGZSlSvs3jfslDPhwXWHw
	OzUO5Pak/PH0TBZK47lXD+NHRPgbEXNAO4KSOsvZaFgwcEdKvpJVGIjMykAstg3jSatjg5aG0ho
	3d3ra8ksQJ8lB/75N9haf2sARPxJ8eZLnfMeOHMpnuxUhwbSjbxY18eRNjlClL6kRKLTkZVUpFY
	KauvRlLNUt/fDYlZVFo1yJ0ZB87T8OOgdRPDo+wJnJYNQQ5roVybxgpywOvSmnZynoTA8Iex3oB
	1z9edS/EufamSVLzkWcI6BZKuDnlpaut9X2Vx0Nw168ZuvPb624Lb/nbyBjjgrPNXpoPYhaeXFp
	89622VMXTU/aVpbzONL5oipmuq5s9SYyDPUWHQmekUwTynFlQPmhhmp3YbKv1FT53Lxgs7J2+0x
	O06ZQsfTdXoAdsb29A1i0cRIM=
X-Google-Smtp-Source: AGHT+IGjgb8Uk6FnwaIpcYiYNFYyGU0B4NfbzJXQFYUqc92t7C4wtzzxnuDxmgShEDi1X1QND5NukQ==
X-Received: by 2002:a05:620a:1a1d:b0:81d:5a83:e695 with SMTP id af79cd13be357-81d5a83e6dbmr968715285a.80.1757604418504;
        Thu, 11 Sep 2025 08:26:58 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6de:d300:e181:657e:57d:cd88? ([2605:a601:a6de:d300:e181:657e:57d:cd88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820cd70478fsm121112385a.40.2025.09.11.08.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 08:26:57 -0700 (PDT)
Message-ID: <9b8d6c20-e91d-4ef6-9260-5016870f27c7@gmail.com>
Date: Thu, 11 Sep 2025 11:26:56 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] sparse-checkout: make 'clean' clear more files
To: Elijah Newren <newren@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Patrick Steinhardt <ps@pks.im>
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
 <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
 <82c24ce51980d85e1a53e746b462397e6e6c908a.1752716054.git.gitgitgadget@gmail.com>
 <CABPp-BHLcy-A4yLR8gP1Sjt_EKQ4K08kPyb7G6yifdZj+0MJNg@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BHLcy-A4yLR8gP1Sjt_EKQ4K08kPyb7G6yifdZj+0MJNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/5/25 8:21 PM, Elijah Newren wrote:
> On Wed, Jul 16, 2025 at 6:34 PM Derrick Stolee via GitGitGadget

>>          test_path_is_missing repo/deep/deeper2 &&
>> -       test_path_exists repo/folder1 &&
>> +       test_path_is_missing repo/folder1 &&
>>          test_path_exists repo/folder2
> 
> What this doesn't show is that afterwards:
> 
> $ git -C repo status
> 
> On branch main
> You are in a sparse checkout with 78% of tracked files present.
> 
> Changes to be committed:
>    (use "git restore --staged <file>..." to unstage)
>      new file:   folder1/file
> 
> Changes not staged for commit:
>    (use "git add/rm <file>..." to update what will be committed)
>    (use "git restore <file>..." to discard changes in working directory)
>      deleted:    folder1/file
>      modified:   folder2/a

You make an excellent point about SKIP_WORKTREE bit states across
changes like this. I'll expand on this flow in the test script.

>> +               test_path_exists deep/deeper2/extra &&
>> +
>> +               cat >expect <<-\EOF &&
>> +               Removing deep/deeper2/
>> +               Removing folder1/
>> +               EOF
>>
>>                  # clean does not remove the file, because the
>>                  # SKIP_WORKTREE bit was not cleared by the merge command.
> 
> Shouldn't the comment be updated, given the testcase updates?

Yes. Good catch.

>>                  git sparse-checkout clean -f >out &&
>> -               test_line_count = 0 out &&
>> -               test_path_exists folder1/even/more/dirs/file &&
>> -
>> -               git sparse-checkout reapply &&
>> -               test_path_is_missing folder1
>> +               test_cmp expect out &&
>> +               test_path_is_missing folder1 &&
>> +               test_path_is_missing deep/deeper2
> 
> Yes, but why does `git status` show folder1/even/more/dirs/file as
> being locally deleted?  Does the code forget to update the
> SKIP_WORKTREE status after clearing out the files?

This is an interesting quirk about how "git add --sparse <path>"
works, which is to remove the SKIP_WORKTREE bit. It's further
interesting that the file is still being "tracked as a deletion"
while also being "collapsed to a sparse directory".

By expanding the earlier test cases to include these post-clean
statuses, we can see that this change is causing this new view
of a deleted file. I will see what I can do to determine exactly
what's different this time and how we can minimize that
strangeness (or: consider dropping this patch).

Thanks,
-Stolee

