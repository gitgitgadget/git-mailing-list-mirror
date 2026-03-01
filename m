Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C902773D3
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772383389; cv=none; b=Zyyre8shz8ERRqkVOjElu5Yf1M7Xj2hkAlNFU8ENgR1p3lsgiK3zmOGIgxGs0lyOGJjbf+1LNru8GUpLHr6dRpNNuwLSYSe/8FfPgfmULtV/8W4JDtgXfrXx3iKsxKOaV9nAR5/fQp1eBTgNi82ftvHopUnfs+8k6NCJkGJ3SKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772383389; c=relaxed/simple;
	bh=v12Fs+r66Jkl6gBmJqQT5H9g8aB8Rj2kpAbrVf8NC1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxNxq+Qrcba4ddn2gSN8GKc7v0qxZe2DvNVQVuX0l3AI5F43/EJVkG4sOwP+sk+RYvmp6H89aIjySEhXjQhnTSC8WN4x+JS39/ESqSKpt3ST+Vl1mN595oJvcKyLP4y5OLQA0BpstzLWoMxZc1oQAsZXn2fxtv55HZ7faVNonVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ll8sJnN6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ll8sJnN6"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4836e3288cdso24484885e9.0
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 08:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772383386; x=1772988186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mrGoi64uX0tC9rlKkQxiluUDqa1Vb87yVWmbpQiDoc4=;
        b=Ll8sJnN6g1HCvY9OFfWOGHZcJZAaj14TzYr9VgR+gsKF5ZKaVZtFvLMY3zXF6om09/
         xBGxHQUwk+bjSQfDSG0bESWZfH155YWRhX5RsCPA47xBSp3EIjgb8AQDOUzrIiUkmXA6
         Mv6FfptBxE1XahdplZ8s+62WtPF845C98Eu9dE22+CBB8l9qFqaf8+Wky5QkvbXug7ta
         KBlQrmwnbnCvQOYtFGYipsD4tB1B5FOA/oOHXCSeu7qHqYtp7ge1snzshxoEXYm3bCDv
         Q09pZhnn6rKcTrFh+QPQzig+oPg/mq7GqaSFRYkuWAr9ZVhbTD7x94lJOqE+tP9xUWG2
         aKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772383386; x=1772988186;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrGoi64uX0tC9rlKkQxiluUDqa1Vb87yVWmbpQiDoc4=;
        b=lYcYphdX7Nc5Y5guGM6RD2ZSRWVN9Faq86AwXhDlUVzH93FiRW/eYJHi3tzC7PT9HC
         BhRwfzXZaEZ+KQXKNwTT/VvqkcSSeX2wNwxalY+5Aw6i7XXZV/ZoXdfD/zN/GTPugyBc
         0Hw2M2Ay5P4W1C7tJ/UWeW6AZNc/iraj9BmDnaE0i78LZy0ukbInTsSZ+FtmedxTpfrW
         iEcd5CZy2w9n13/EDBt/Qt8FKWoY5ruxtKKfDelCFcrzk4qvpm9SScdcq/7jGAMfX96G
         hTuOUTpoR0SuTT7R5oq+bjEdj3jVt8ott11ToCWFLiRO/zPCYGmrSfB3rl39zXkxrbIz
         RDdg==
X-Forwarded-Encrypted: i=1; AJvYcCUgW9PdS1TesgVZoguVrxzCHmLXwc3X25U0BVimc6l9bgdtoMTAkNw2crnXpIIwrDwEm4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Brk50FcDyFHXRgfyTI4XVJCx5TxraAa61rQJXSjNnVjPDfSp
	CJW7cObGIO0wvabNG0ve/x9arLRJhe1j11n7OpiOLZTwpVyuoVbWiuBr
X-Gm-Gg: ATEYQzzwWnt3svAUVUKllDczvsJhSNh6C6X3G/DcfA5nJAKf6thP6feS31yyPOtspo+
	umzPm4OUOL7T6Zql4YO0g0x4NfbfPiGqPpwBxXBHz6N74flADaqeo/yMWfwAL/WxNQrntbzCt60
	ZMQ3QZmu/ztXLrsiDsqAUXKygkrKZDYbA4fQPEpp6pQrQ5k6OUMi7dFsutH7THv3DWJSI2MCnYz
	RnHriWVahi9rSLb4m/Hmv39+53l72fQgjK9kM/43rcV9jaUgo80C19TIzXJljJAKpjuCLqLTMjR
	TFm7JVMZVAwZSKdn+mWSPBQnntFKe0RDW4XBPtnqmVSoCcNy2CnrGVtCM7cSpGQ3V81ZZvfqZ5p
	hDmGEhiC0p5T1Y28kUrm8JPRUZeRqojJLMQ8I1XmI2fX85gkpLake4GOWHq4yOb+A3X+DibYzyN
	9Q36/flZKd+E5RkPHsO0pcRg+SXk2TMZ2oITPgG7SF03mn0CcQ5Jy5R/D4Ro6/dMgHAmj/g7BtF
	417lw==
X-Received: by 2002:a05:600c:1d21:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-483c992e3d8mr174526235e9.11.1772383386365;
        Sun, 01 Mar 2026 08:43:06 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfbb6d16sm158899065e9.5.2026.03.01.08.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 08:43:05 -0800 (PST)
Message-ID: <eecd6531-a7b5-4f0e-8e4d-3807f47d1f9d@gmail.com>
Date: Sun, 1 Mar 2026 16:43:03 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][Draft Proposal v4] Refactoring in order to reduce Git's
 global state
To: Tian Yuchen <a3205153416@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>, phillip.wood@dunelm.org.uk
References: <ab45758c-fbcf-42b2-96df-030eef8526c3@gmail.com>
 <b98780d7-3aa9-4838-9234-290b1d72ffd7@gmail.com>
 <5e5f07ec-72ba-46ee-812c-d6773a4bdbe7@gmail.com>
 <0a944142-7c51-4143-af00-2a5798ea68af@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <0a944142-7c51-4143-af00-2a5798ea68af@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Tian

On 27/02/2026 16:58, Tian Yuchen wrote:
> 
> 
>    3. Unit testing becomes difficult because the environment must be 
> artificially manipulated before calling functions.
> 
> Take a look at this example from environment.c:
> 
>      206 const char *get_commit_output_encoding(void)
>      207 {
>      208     return git_commit_encoding ? git_commit_encoding : "UTF-8";
>      209 }
> 
> If Git is invoked as a C library by a multi-threaded server:
> - Thread A formats a commit for Repo A (using GBK);
> - Thread B concurrently formats a commit for Repo B (using UTF-8);

The encoding config is really a user preference that lets the user 
compose commit messages in their preferred encoding while allowing git 
to store the message encoded as UTF-8. I'm struggling to see why two 
threads would be using different encodings as it implies that the user 
is using different encodings in different repositories.

Below you say

 >      Variables parsed at startup (e.g., editor_program)
 >      must not be moved to lazily parsed structs to ensure that
 >      invalid configurations can trigger early failures before
 >      execution proceeds too far, which is also for the sake of user
 >          experience.

i18n.commitEncoding is another such setting as it is currently eagerly 
parsed so I'm surprised to see it being converted to lazy parsing in 
https://lore.kernel.org/20260228190201.3684705-1-a3205153416@gmail.com

I'm afraid that the suggestion on the project webpage is not very 
helpful. Most config variables are unsuited to a conversion based on 
repository_settings, it would be better to look at the approach 
implemented in 
https://lore.kernel.org/48821a3848bef25c13038be8377ad73e7c17a924.1771258573.git.belkid98@gmail.com 
that is discussed in https://lore.kernel.org/xmqqwm1vk83a.fsf@gitster.g

Thanks

Phillip

> Then they will race to read and overwrite the exact same global
> `git_commit_encoding` pointer, which is not what we expect. Therefore,
> we have to refactor these environment variables by moving them from
> global scope into a well-defined and encapsulated context.
> 
> 
> -- Approach
> 
> The task at hand goes beyond simply repackaging the global variables 
> into the struct repository structure. Based on my recent experience 
> refactoring setup.c, I realized that libification requires careful 
> management of variable lifecycles and api boundaries:
> 
>      [ Current ]
>      Core functions --------reads-------> Global variables (via getenv)
>                                           [Thread unsafe]
> 
>      [ Target ]
>      Core functions ----passes context--> struct repository
>                                                  | owns
>                                                  v
>                                           struct repo_settings
> 
>                                          other domain-specific structs
> 
> Although the principle is simple, the scope of changes is extensive. The 
> following insights can serve as a guiding principle for it:
> 
>    1. Identify isolated environment variables currently residing in the
>       global scope. Conduct a case-by-case analysis to map each variable
>       to its most appropriate existing home based on their lifecycles:
> 
>      Variables that are only parsed when needed will be safely mapped
>      to struct repo_settings.
> 
>      Variables parsed at startup (e.g., editor_program)
>      must not be moved to lazily parsed structs to ensure that
>      invalid configurations can trigger early failures before
>      execution proceeds too far, which is also for the sake of user
>          experience.
> 
>    2. Instead of blindly passing struct repository *repo down into every
>       single low-level library function, bubbling the dependency up is
>       the true goal. External callers of the functions must be carefully
>       audited to prevent regressions.
> 
>    3. Safely remove the old global variables and macro definitions. Make
>       full use of Git's existing GitLab/GitHub CI and utilize local
>       Meson builds with AddressSanitizer enabled to ensure that the new
>       lifecycle introduces zero memory leaks.
> 
> 
> Additionally, given the anticipated high volume of commits, we must 
> ensure each patch is independent and atomic, preventing any user- 
> untraceable or unexplainable bugs from occurring in the codebase at any 
> state.
> 
> 
> AVAILABILITY
> ------------
> Fortunately, my summer vacation coincides with the GSoC work period.
> I will treat this project as my primary focus, dedicating a minimum of
> 35 hours per week. If needed, I can work a 9-to-5 schedule.
> 
> I will have a significant head start to draft RFC patches before the
> official coding period even begins. Having this buffer period allows me
> to go through the rigorous code review process within the Git community
> with greater ease.
> 
> 
> TIMELINE & MILESTONES
> ---------------------
> Considering the differences between this project and other projects on 
> the idea list, rather than hoarding massive changes, I will submit 3- 
> to-5-patch series frequently to respect reviewers' time and maintain a 
> steady velocity.
> 
> Below is the tentative schedule I have prepared for myself:
> 
> * Community Bonding (May 1 - May 25): Planning & RFC
>    - May 1 - May 7: Wrap up university finals. Discuss and finalize the
>      prioritized list of subsystems with my mentor.
>    - May 8 - May 25: Categorize the targeted global variables and map out
>      their intended destinations (e.g., repo_settings). Draft and submit
>      the initial RFC patch series.
> 
> * Phase 1 (May 26 - July 10): Foundation
>    - Weeks 1-2: Plumb the context pointer ('struct repository *repo') 
> through call chains for simple variables (e.g., boolean flags or integer 
> configs).
>    - Weeks 3-4: Audit and update external callers to use the new API.
>    - Weeks 5-6: Submit the first major refactoring patch series. Address
>      mailing list feedback and resolve merge conflicts. (Midterm 
> Evaluation)
> 
> * Phase 2 (July 11 - August 18): Complex Migration & Cleanup
>    - Weeks 7-8: Refactor higher-complexity variables (e.g., path-related 
> globals).
>    - Weeks 9-10: Compile the codebase with AddressSanitizer and run the 
> full test suite to execute strict memory leak checks.
>    - Weeks 11-12: Remove unused global macro definitions and static 
> variables. Update internal documentation and write the final GSoC report.
> 
> (The above is for reference only. Personally, I always finish tasks 
> faster than planned 😉)
> 
> 
> ~$ git checkout HEAD@{postGSoC}
> -------------------------------
> This past month since joining the Git community has been the most 
> enjoyable month of my programming journey. To quote a close friend of 
> mine (who is applying for the Neovim GSoC project):
> 
>    "Only fools chase trends; open source is the game for the brave."
> 
> The words may be blunt, but the logic holds true. This statement surely
> resonates with me (and maybe many other GSoC contributors): our passion
> for code and open-source drives us forward.
> 
> Even if I didn't make the cut, so what? ~$ git reset --hard...
> Just kidding. The Git codebase is far too interesting to abandon now.
> 
> -------------------------------------------------------------------------
> Changes since V4:
> 
>   - “Treating variables or functions differently based on their 
> lifecycle” has been added to the Approach section.
> 
>   - Fixed a typo below the diagram.
> 
> Regards,
> 
> Yuchen
> 

