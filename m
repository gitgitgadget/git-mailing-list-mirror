Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apollographql.com header.i=@apollographql.com header.b="v0cBmbCn"
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671FB112
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 13:01:39 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41cd97d7272so8275601cf.0
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 13:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=apollographql.com; s=google; t=1701378098; x=1701982898; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NpuAqu5w7BqEPHp8ORYwHc4VaK9KMvz3dyNVXw4kC34=;
        b=v0cBmbCng4OkymLf1rPlZQAlUD1bvdwIGlS1EmB2RgPhl1Kr+wFdJ4vVIgQSFlPFlG
         KTyY1q6s2C3VJMRyi6ziEsdY+bGgLuO2FgqDNo9r6Fwnn/nPLExe20qSpCi7mbT1yRpF
         aVNK78fngbVytyrHhCVFiuqQai229bRlc0wdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701378098; x=1701982898;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NpuAqu5w7BqEPHp8ORYwHc4VaK9KMvz3dyNVXw4kC34=;
        b=xFFi9Oa2mZKk0u696TkCdCUuNq5iUldbKQhKmlEIVLUGteiNAPj+aobUHnq71zY3Cq
         oGByemjzjHLB9IFkmyqzUbkAXPNq3/L1Ca81uX1pLcOyFNZkow1h9soKpy7STHGnzbvw
         eLctQJAvVpGvEHWAcvaRWHUJ6JHhgUmEtaaOwP/S2r97FSH++EhqTP/RIq9+KsDpmdOC
         fY2MmNur/I2DmdQUSmp/HtAW1Tj1DYYhHjFAwrBJJIANnPC6JV5NkxKS7sONBQo39qCW
         sIxqMdPJO7qotyqZvY0vwtKs1FpOCgj/Oljlb42uQI8eLey5kzNUxE2bxWZp9oj6TbT6
         s3Vg==
X-Gm-Message-State: AOJu0Yy9b81Zeq27T54NcPLfLkAgIIPXFXObbNTNgfUgVde/eGAxpr8Q
	VTlO7RB40eySbV+3uRapMK/QX//idqLQNM9YMxQUpSQemzT80NaeLHE=
X-Google-Smtp-Source: AGHT+IHr5QiIe8kQUcOmX8NreI3aGqdvKBA/DIt53tGXbTIXVkMUUV8A5koai3IIHacDUkD7j4+p2ZD3BdZWjs+AVQg=
X-Received: by 2002:ac8:5915:0:b0:419:50d0:cf5a with SMTP id
 21-20020ac85915000000b0041950d0cf5amr28846361qty.2.1701378098483; Thu, 30 Nov
 2023 13:01:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1587.v4.git.1698347871200.gitgitgadget@gmail.com>
 <pull.1587.v5.git.1701206267300.gitgitgadget@gmail.com> <CAP8UFD1rd+q-dC_w2VgZ_jC++LDeF6gu5wDcbQzSuhU1ksfBpA@mail.gmail.com>
In-Reply-To: <CAP8UFD1rd+q-dC_w2VgZ_jC++LDeF6gu5wDcbQzSuhU1ksfBpA@mail.gmail.com>
From: Zach FettersMoore <zach.fetters@apollographql.com>
Date: Thu, 30 Nov 2023 16:01:27 -0500
Message-ID: <CAEWN6q14sd-KmMOgmKWqnKWPNUeW7MN5T=PhrkkN5d0VXQEohA@mail.gmail.com>
Subject: Re: [PATCH v5] subtree: fix split processing with multiple subtrees present
To: Christian Couder <christian.couder@gmail.com>
Cc: Zach FettersMoore via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>> To see this in practice you can use the open source GitHub repo
>> 'apollo-ios-dev' and do the following in order:
>>
>> -Make a changes to a file in 'apollo-ios'A and 'apollo-ios-codegen'

> It looks like there is a spurious A after 'apollo-ios' in the line above.

Thanks for catching that, definitely a typo on my part.

>> directories
>> -Create a commit containing these changes
>> -Do a split on apollo-ios-codegen
>> - git subtree split --prefix=apollo-ios-codegen --squash --rejoin

> I might be doing something stupid or wrong, but I get the following:
>
> $ git subtree split --prefix=apollo-ios-codegen --squash --rejoin
> fatal: could not rev-parse split hash
> cc70a7d49e84696f0df210710445784c504ed748 from commit
> 360f068ea0d57f250621ab7dbe205313f52a0e98
> hint: hash might be a tag, try fetching it from the subtree repository:
> hint: git fetch <subtree-repository> cc70a7d49e84696f0df210710445784c504ed748

Updated this to include doing a fetch to ensure all remote repo
info is available locally.

>> -Do a split on apollo-ios
>> - git subtree split --prefix=apollo-ios --squash --rejoin

> Same issue:
>
> $ git subtree split --prefix=apollo-ios --squash --rejoin
> fatal: could not rev-parse split hash
> b852c0aa1fd5ab9e1323da92b606ad3f2211e111 from commit
> b48030c3eb6e2faf4bff981c5c63ca72aceecdfa
> hint: hash might be a tag, try fetching it from the subtree repository:
> hint: git fetch <subtree-repository> b852c0aa1fd5ab9e1323da92b606ad3f2211e111
>
> I didn't try to get farther than this, as it seems that some
> instructions might be missing.

Same as above, added extra instruction to do a fetch first.

Also added a little extra info that the issue may present after the
first split in the instructions depending on the current state of the
repo being used. Also added a way to do the same steps with the changes
applied to see that it resolves the issue.

>> So this commit makes a change to the processing of commits for the
>> split command in order to ignore non-mainline commits from other
>> subtrees such as apollo-ios in the above breakdown by adding a new
>> function 'should_ignore_subtree_commit' which is called during
>> 'process_split_commit'. This allows the split/rejoin processing to
>> still function as expected but removes all of the unnecessary
>> processing that takes place currently which greatly inflates the
>> processing time. In the above example, previously the final split
>> would take ~10-12 minutes, while after this fix it takes seconds.

> Nice!
>
> Except for the above issues in the commit message, the rest of the
> patch looks good to me, thanks!

Great! Thanks for the review and guidance!
