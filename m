Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2C5C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 09:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiBPJrZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 04:47:25 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiBPJrY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 04:47:24 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E7D644D
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 01:47:11 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id f17so2946406edd.2
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 01:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=6xazYCk/JJsBV3mfX3G/aLobGHIdeLkF7XFb9NMDpfY=;
        b=YBns3FaO35BJmSBckKxlV+U3qIqZspryYXKV9lgJtOKEf9uyPmi3JxBKnYMBRwIp7k
         RdOGvoP1fpxDNGGXk7ND+N8v6XQtYaUi8Av/0dd50p2zNlN0saEZgmoVCL3WFaf4D9aH
         fBF04lZx0mcsxlpsReOBcpIvZ1LxzN/KHqkO+6iWnFAmMRKc7B73Q71s6N1LGKBZGwwy
         IOWW64x6Mx52kXcNPiBxKhR1Ar2PRmlGwuFHGf0Vov7Tr4A98KQmqp5B4czLoqZsekrb
         Zv36yiwwl5nrVx6glf8PlK3HLpGSHOiRSdG43czzGPowSJjDkqnqJ67446IY0gTP3Cbk
         sP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=6xazYCk/JJsBV3mfX3G/aLobGHIdeLkF7XFb9NMDpfY=;
        b=XC7N4RZlIiIMwW/GHXppPiguMyosbifm81OWWpmW6mHUjgFdo5gulaWX5qoAWjVyXI
         peRUl6hToxs6hg6uROBgjieGO2o9grAPLjAAKWFKF9/atYNfKRvRrZhK5hFjpkVMiU/o
         NwlGH1PNnUyJtzhpCVwKGw6ZmhDq8Jse+LqXVNIgAJaouLMmxlNu6XiGcmu5w6Wy+ZPM
         z+kbEcvhagqbeLFpTE8XQ1LHx/zQmM4cjRZMCK1YaGOOzR8SQNtXsavlM0z4ad0aLpAk
         nUjyJcled/qrV0W65uw69R/G46W6RJISy22WFTxfXEOtVrjs5/pY0aik/b8SHaTFwEgM
         ibDA==
X-Gm-Message-State: AOAM531x3UFuKVgDs3x6+FIFzRVZwVnDez6ajdYZytuR8ctavFHRi8Td
        Qb9hkuaGxSGwKSVHbda/ZXnwab2N+uL8OQ==
X-Google-Smtp-Source: ABdhPJz52FdhffI/+g4uybG4ijmpCNJGFOqXvs4TpAjFsOEN+InX3uxIBjWzniZ4q1x3Xe5d3Odf2A==
X-Received: by 2002:aa7:c852:0:b0:3f1:ae2c:30d7 with SMTP id g18-20020aa7c852000000b003f1ae2c30d7mr2008115edt.382.1645004829872;
        Wed, 16 Feb 2022 01:47:09 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g8sm7845415ejt.26.2022.02.16.01.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 01:47:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nKGtw-003Abv-Mx;
        Wed, 16 Feb 2022 10:47:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: en/present-despite-skipped (Was: Re: What's cooking in git.git
 (Feb 2022, #04; Tue, 15))
Date:   Wed, 16 Feb 2022 10:44:45 +0100
References: <xmqqk0dwyrcv.fsf@gitster.g>
 <CABPp-BFOw48k0M3U+fef1J57wHt2uq4hbKo-vnjAj56nYY6m2Q@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CABPp-BFOw48k0M3U+fef1J57wHt2uq4hbKo-vnjAj56nYY6m2Q@mail.gmail.com>
Message-ID: <220216.867d9vuorn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 15 2022, Elijah Newren wrote:

> On Tue, Feb 15, 2022 at 12:01 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * en/present-despite-skipped (2022-01-14) 6 commits
>>  - Accelerate clear_skip_worktree_from_present_files() by caching
>>  - Update documentation related to sparsity and the skip-worktree bit
>>  - repo_read_index: clear SKIP_WORKTREE bit from files present in worktree
>>  - unpack-trees: fix accidental loss of user changes
>>  - t1011: add testcase demonstrating accidental loss of user modifications
>>  - Merge branch 'vd/sparse-clean-etc' into en/present-despite-skipped
>>  (this branch uses vd/sparse-clean-etc.)
>>
>>  In sparse-checkouts, files mis-marked as missing from the working tree
>>  could lead to later problems.  Such files were hard to discover, and
>>  harder to correct.  Automatically detecting and correcting the marking
>>  of such files has been added to avoid these problems.
>>
>>  Will merge to 'next'?
>>  cf. <20220204081336.3194538-1-newren@gmail.com>
>>  source: <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>
>
> Is there anything specific you're looking for here?
>
> I think it's ready, as I said two weeks ago in the link you provided
> above.  All reviewer feedback was addressed to reviewers' satisfaction
> over a month ago, so I'm not sure what else to do here...

FWIW I gave it some light reading just now & left some comments on it.

I don't think any of them should be blocking on it being merged down to
"next", but perhaps some of them suggest worthwhile follow-ups. In
particular the suggested documentation changes & the behavior/error
checking around the lstat() and index iteration in the new path_found().

