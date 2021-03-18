Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932FCC433E6
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 13:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4071864F1B
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 13:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhCRNjF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 09:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhCRNiu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 09:38:50 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F3FC06174A
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 06:38:50 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id t5so3165854qvs.5
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 06:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PfZfipJUn8r1MWTEfZ4n7urWAUOOgNm36jrZZnRc/wU=;
        b=mAYfKWah//yVnneKSuqvuN9xjPL+J2m/HAp+XZ+K/0GyvZ6UnYsovk2I7b0y5M+of/
         JOleP/oQvbw54NfyzU6A5gHmAkpYbg9RqZRT7qrWg4CqIUQYQns5AxKehdO3IvkoF2QC
         ORXuJbECqcVDmG2ekgO3xtVNNlLK7m8y0kCqhetp91oQ3L3Lx8/WCQfvl9UYmGI+e+of
         DuVmfQACT9nvN1/ILmI1/5NKYF7SliNpLjetn9s62ow9N2fqsum+Tm7eMdCyZ9gRaXy9
         ToNtjwWycDLb6HLSuoENEclfBAVoannzqhu7C/Yt1UymYqNKFipvcgHSWna1xGhi4Amp
         M2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PfZfipJUn8r1MWTEfZ4n7urWAUOOgNm36jrZZnRc/wU=;
        b=KhQJMoZtnOurMAGEkfRZCCZrUb/kAzR2/xdevYXdaoF3mnQx8qtkvXN843kioLPTtd
         oCldr0jwC/xtcwCmiaSdI1mhdyW8jrW7zCy92yfSuuPd5qB/gQnlh+UJR5KsWa0BnPFs
         R/znO22xeE8R8KhY9X70Nx6D6uyPw8eSeGv1JnxTcBP3CNrb8O9BGFzwRstt/sijNpio
         qhJuVXpmJl6tbXeRYTrlk4a7c3GALDlK0ZTKshR5KsQqsZBfbutKcntOeT0xBQavzvO+
         HjtVOY8ZPoG4RLr9G4UrZB9WyL0qu8MIKTbc1KPlni0rEg8+ZNoDvKezP0R9+ZY0fRpn
         QJ5Q==
X-Gm-Message-State: AOAM530BmJx1RtYEkr8wMm+G3ep2+WdLJ3Vx6W1Lmfjq9ddnlqnr/5BT
        Scl7vb9AFgqIV9MOM65DTxXpQFBsEWqzETUn
X-Google-Smtp-Source: ABdhPJw56u1weLoEJ3A+SYTvIjEqMitvTR/57ERyHopZL9jjuwBrxx4LMGO59tIWO0h/2eF6tRwvWQ==
X-Received: by 2002:a05:6214:18d2:: with SMTP id cy18mr4358618qvb.50.1616074729096;
        Thu, 18 Mar 2021 06:38:49 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:1571:3cc6:32d1:78e8? ([2600:1700:e72:80a0:1571:3cc6:32d1:78e8])
        by smtp.gmail.com with ESMTPSA id 90sm1437091qtc.86.2021.03.18.06.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 06:38:48 -0700 (PDT)
Subject: Re: [PATCH v3 11/20] sparse-index: convert from full to sparse
From:   Derrick Stolee <stolee@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        pclouds@gmail.com, jrnieder@gmail.com,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
 <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
 <e41b14e03ebb143c874cc276adcbc36059f0c64e.1615912983.git.gitgitgadget@gmail.com>
 <87wnu5zyif.fsf@evledraar.gmail.com>
 <1de9bc8a-b0fd-596a-3ae2-2e055b37534b@gmail.com>
Message-ID: <70fe8d2e-d648-a064-bd8a-9e0b813980a0@gmail.com>
Date:   Thu, 18 Mar 2021 09:38:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1de9bc8a-b0fd-596a-3ae2-2e055b37534b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/17/2021 3:55 PM, Derrick Stolee wrote:
> On 3/17/2021 9:43 AM, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Tue, Mar 16 2021, Derrick Stolee via GitGitGadget wrote:
>>> @@ -251,6 +251,8 @@ static inline unsigned int create_ce_mode(unsigned int mode)
>>>  {
>>>  	if (S_ISLNK(mode))
>>>  		return S_IFLNK;
>>> +	if (mode == S_IFDIR)
>>> +		return S_IFDIR;
>>
>> Does this actually need to be mode == S_IFDIR v.s. S_ISDIR(mode)? Those
>> aren't the same thing...
>>
>>>  	if (S_ISDIR(mode) || S_ISGITLINK(mode))
>>>  		return S_IFGITLINK;
>>
>> ...and if it can be S_ISDIR(mode) then this becomes just
>> S_ISGITLINK(mode), but losing the "if" there makes me suspect that some
>> dir == submodule heuristic is being broken somewhere..
>  
> I have a vague recollection that I did that at one point, and
> it didn't work. However, using the simpler
> 
> 	if (S_ISDIR(mode))
> 		return S_IFDIR;
> 	if (S_ISGITLINK(mode))
> 		return S_IFGITLINK;
> 
> passes all of my tests.

I'm not sure why it was passing yesterday (maybe I was in the
wrong worktree) but I _do_ get failures, such as this one in t2105:

expecting success of 2105.4 'add gitlink to relative .git file': 
        git update-index --add -- sub2

+ git update-index --add -- sub2
warning: index entry is a directory, but not sparse (00000000)
error: Could not read 50e526bb426771f6036ad3a8b0c81d511d91fc2a
BUG: read-cache.c:324: unsupported ce_mode: 40000
Aborted (core dumped)
error: last command exited with $?=134
not ok 4 - add gitlink to relative .git file
#
#               git update-index --add -- sub2
#

In this case, the mode that is specified is equal to 040775,
so we need to use the permission bits outside of __S_IFMT
(0170000) to determine if this is a sparse directory or a
submodule entry. Submodules will never be sparse, so
permissions matter. Sparse directories never actually exist,
so permissions don't matter.

Playing around with it, I still only see the exact equality
as working for me.

I can, however, use this format for these if statements:

	if (S_ISSPARSEDIR(mode))
		return S_IFDIR;
	if (S_ISDIR(mode) || S_ISGITLINK(mode))
		return S_IFGITLINK;

The S_ISSPARSEDIR macro expands to the exact equality.

Now, if we intended to make this work differently, then a
change would be required to construct_sparse_dir_entry()
in sparse-index.c:

static struct cache_entry *construct_sparse_dir_entry(
				struct index_state *istate,
				const char *sparse_dir,
				struct cache_tree *tree)
{
	struct cache_entry *de;

	de = make_cache_entry(istate, S_IFDIR, &tree->oid, sparse_dir, 0, 0);

	de->ce_flags |= CE_SKIP_WORKTREE;
	return de;
}

For instance, we could at this point assign de->ce_mode to
be S_IFDIR directly. It seems like the wrong place to do that
to me, but I'm open to suggestions.

Thanks,
-Stolee
