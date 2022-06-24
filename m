Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FDCC43334
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 08:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiFXI07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 04:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiFXI05 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 04:26:57 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D587F766A0
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 01:26:56 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso5085226pjg.1
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 01:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=l4m4oKH50yH1jv+VM0uhsHqYAyPJDVgApLEH4uisGMs=;
        b=jYWlKFh7iNzIltb7RSbF+vYTO5jzZ7e//itzeRlSXZ92yAT2CiSpW0IPk8AMbTF7az
         2cFACYbGEyt7/d9n+60LNv72m3X7NsIQyZWO1G2tUw3Bou6k3p7lGVmQNxfIKciKMeFy
         DyYQfcaNYsa7IOJ57Slql1KeMW6Aje/jGyCs6gXZznwtMErClCN3iQGcGUoLCzlPrINP
         qeSMm1uVHmxs73Biejo3o5lrqQdb36OKWdB2MbIgD7gfUIzr4nxyWSYiko4Y5KUkMisp
         7PbYtVi0/FsIn1hJJs79mV4LeN+BxLCZX4GInMP5KebgE4mPfzwRT4iPM0ubCJFdPQ3u
         lAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l4m4oKH50yH1jv+VM0uhsHqYAyPJDVgApLEH4uisGMs=;
        b=I2W22fORPotSaOde4qFDIyt7xyk/DKODBZtTb2LAra5XkADKfdG86ls7chMTVvBUMu
         98qj3ZYyGQXliQW21XTObilvM0YqrJtJjqzSlCnTuPp0mycPL1/TKvDliWXz4ipMurKM
         +3TzZgRt5fvGG3CiC988TJGTLdO6F78I0jWxetDvdB5328zumzQinbW5CL2LHzqzAmIU
         3Nq6964fJ8bwI28BQlhlFeXaj7bVy1sZ0ksQVukaS3B+BeH3mFGJ9FRet48XGRfaowdt
         NoOzrLKg6ayTh0QoGNPEaAqQN6b3FTAiQRIbV3NqkllrQ6OLvVv92SlvziOK62Yg7RQD
         Lnsg==
X-Gm-Message-State: AJIora9WpjLN19LiU8/PT4OZHKC8xYfvJTlaUT/pTdpdf//m1fbhfhx+
        A8UgJ5ft4eKPO8I9lzVLJdCrgyzQbILKUA==
X-Google-Smtp-Source: AGRyM1u15bGYxdEY6/hl2w85vuFr4jv3W3GT2/Ly/vkEPxcsbXN1CceqBOfPRqbh3lZ29MqAZdX6Qw==
X-Received: by 2002:a17:90b:1bce:b0:1ec:d80f:2acc with SMTP id oa14-20020a17090b1bce00b001ecd80f2accmr2702804pjb.154.1656059216330;
        Fri, 24 Jun 2022 01:26:56 -0700 (PDT)
Received: from [127.0.0.1] ([45.138.210.17])
        by smtp.gmail.com with ESMTPSA id v187-20020a6261c4000000b005255f5d8f9fsm1047216pfb.112.2022.06.24.01.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 01:26:55 -0700 (PDT)
Message-ID: <668d7a5f-7c1c-92ca-3db8-62f9bdca3006@gmail.com>
Date:   Fri, 24 Jun 2022 16:26:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [WIP v3 0/7] mv: fix out-of-cone file/directory move logic
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Cc:     Victoria Dye <vdye@github.com>, git@vger.kernel.org,
        newren@gmail.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220619032549.156335-1-shaoxuan.yuan02@gmail.com>
 <d3aa35e4-5bad-2bbb-2a25-d82064d6ec81@github.com>
 <553ea547-9641-eb95-a474-db046fdc05dc@github.com>
 <xmqqr13f1het.fsf@gitster.g>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <xmqqr13f1het.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 6/24/2022 12:19 AM, Junio C Hamano wrote:
 > Derrick Stolee <derrickstolee@github.com> writes:
 >
 >> On 6/21/2022 7:30 PM, Victoria Dye wrote:
 >>> Shaoxuan Yuan wrote:
 >>>> But I think it worth discuss if we should implement in-cone to
 >>>> out-of-cone move, since it will be nice (naturally) to have it 
working.
 >>>>
 >>>> However, I noticed this from the mv man page:
 >>>>
 >>>> "In the second form, the last argument has to be an existing 
directory;
 >>>> the given sources will be moved into this directory."
 >>>>
 >>>> I think trying to move out-of-cone, the last argument has to be an 
non-existent
 >>>> directory? I'm a bit confused: should we update some of mv basic 
logic to
 >>>> accomplish this?
 >>>>
 >>>
 >>> I suspect this requirement is related to the POSIX 'mv' [1] (and
 >>> corresponding 'rename()', used in 'git mv'), which also requires 
that the
 >>> destination directory exists. I personally don't think this requirement
 >>> needs to apply to 'git mv' at all, but note that changing the 
behavior would
 >>> require first creating the necessary directories before calling 
'rename()'.
 >>>
 >>> As a more conservative solution, you could do the parent directory 
creation
 >>> *only* in the case of moving to a sparse contents-only directory (using
 >>> something like the 'check_dir_in_index()' function you introduced to
 >>> identify).
 >>>
 >>> I'm also interested in hearing what others have to say, especially 
regarding
 >>> historical context/use cases of 'git mv'.
 >>>
 >>> [1] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/mv.html
 >>
 >> I wanted to reply here to maybe get more attention on this point.
 >>
 >> My personal opinion is that `git mv` should move to the location 
requested,
 >> even if it requires adding parent directories. Changing that 
behavior might
 >> need to come as its own topic, before doing the 
in-cone-to-out-of-cone work.
 >> Knowing if this behavior can change (or must stay the same) informs 
how that
 >> sparse case will work.
 >
 > When a particular checkout excludes directory, say, Documentation/,
 > from its cone of interest, we may not have that directory in the
 > working tree.  In such a scenario, if you did
 >
 >     $ git mv new.txt Documentation/technical/
 >
 > the index may not even know if "Documentation/" (which most likely
 > is represented as a sparse "tree entry in the index") has the
 > "technical" subdirectory in it, so it may have to expand it
 > on-demand.  I do not have an objection against making it easier for
 > users to do this.
 >
 > As part of its implementation, you may have to do an equivalent of
 > "mkdir -p Documentation/technical/" before you can even materialize
 > the "new.txt" file in the directory.  I do not think that breaks the
 > parallel to POSIX "mv" in that case, as Documentation/technical/ is
 > *NOT* really a destination directory that does not exist.
 > Conceptually, the directory (and all the directories in the full
 > tree) exists---it is just the sparse-checkout is hiding it from the
 > view.
 >
 > A corollary to the above is what should happen when you did
 >
 >     $ git mv new.txt Documentation/no-such-directory/
 >
 > i.e. you try to do a move that would fail even if you weren't using
 > the sparse-checkout feature.  I think that *SHOULD* fail, if we
 > wanted to be parallel to what POSIX "mv" does.
 >
 > Thanks.

Agree.

Thanks & Regards,
Shaoxuan

