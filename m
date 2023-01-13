Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B23C3DA78
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 18:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjAMSDr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 13:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjAMSCW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 13:02:22 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0DE1007C
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 09:56:53 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id f3so15499750pgc.2
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 09:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7SksxRXmcVbcbR8IfNTE/V9j3TLChV7C5qFUmtqCQG8=;
        b=HHbkEWDQmP1gxVhJgVZj9kijcQKphTjNxC02eu0ZH/JgsE6pleZgPf3XM1Oaqgu11J
         wlJItwd6hXLTPzrmfGQlX2CQNthWI7XrJxfeeyTRsdZg0W1AEz8f6Cf2IcDm4RY8lZcu
         mdXT7CAd6SsG+sZHFTthJv8mcZaNqn2pAXe6RdsXzfdiw6YUXMtMNEvRZyM9hTrvxtzB
         Eu2QtHxlYKf+vo4DkPaSotrPEUjMy01KgswgWAbrnH2EXj6ck/ysO3SJxYwLEU3ph6Sf
         tAuhHfCMhaD4aGuNEXxqkHTObyBevm+d7EOvzkzMWhFpBmlSENxZz112vhsOtx2ysq5V
         MVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7SksxRXmcVbcbR8IfNTE/V9j3TLChV7C5qFUmtqCQG8=;
        b=xznx4akoFTG+dPns8FvIg6e360oXMUzYeaFP2tYB2z0gPYiN36XJAEqXh2VgcHwiis
         TQSmBOM1xIsTHhU9Pn8nEAUs9PvXJU6ItMDKZz95OMegzYtXNurUNgolb3th8mupG2ZJ
         s3A6zT4idqV+MR2xZZEgGv18Ky69EJKp/6Y1BcNMCkqkEY4zZ3VMRoKvRr6UW3Ot9E1F
         zG4fPMe1tosMfQD458FhgNd87LQPMOgEFPRsXrU0DJwmAVnjNUUkjVp1L51ncL29kUoz
         pSTlS8jwLEytGnqnzH4Z2oE544bqhXMKxP93M3ykkYgaCYv4QOAa10E4Zin/YKaLISd0
         y7Jg==
X-Gm-Message-State: AFqh2kopUNQNKbGMCUGiIuwVMHOLyzU8GyrhuWRJHA3Ccc5LqbN+Uczg
        MfDFjS0kNaNHZZlIE4gOvt8=
X-Google-Smtp-Source: AMrXdXuKMWJwB7sh/E4EoIqgIWqkqXB6k6w57ZnZwZcIn6xB5zf1ZNT2k6lwATDuMXYtunpl94VsLg==
X-Received: by 2002:a05:6a00:4188:b0:573:487d:e852 with SMTP id ca8-20020a056a00418800b00573487de852mr12240185pfb.4.1673632612702;
        Fri, 13 Jan 2023 09:56:52 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y186-20020a6232c3000000b00571cdbd0771sm13928486pfy.102.2023.01.13.09.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 09:56:52 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Erik Cervin Edin <erik@cervined.in>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 0/5] Documentation: updates and a correction around
 'ORIG_HEAD'
References: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
        <pull.1456.v2.git.1673356521.gitgitgadget@gmail.com>
        <ba20039c-19a3-96da-c938-89af67bca791@dunelm.org.uk>
Date:   Fri, 13 Jan 2023 09:56:52 -0800
In-Reply-To: <ba20039c-19a3-96da-c938-89af67bca791@dunelm.org.uk> (Phillip
        Wood's message of "Tue, 10 Jan 2023 20:06:40 +0000")
Message-ID: <xmqqk01q48t7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Philippe
>
> On 10/01/2023 13:15, Philippe Blain via GitGitGadget wrote:
>>   * added a link to the mailing list thread in the commit message of 5/5.
>> v1: Documentation: updates and a correction around 'ORIG_HEAD'
>> This series' initial motivation was to clear up a confusion that
>> arose in
>> [1] where it was noticed that 'ORIG_HEAD' is not guaranteed to point to the
>> original branch tip at the end of the rebase if 'git reset' is used during
>> the rebase.
>> Patch 5/5 adds a note to 'git rebase's documentation to make that
>> explicit.
>> When taking a look at the existing documentation mentioning 'ORIG_HEAD', I
>> also found an error in an example (patch 1/5), other small inconsistencies
>> (patch 2-3/5), and a potential improvement (patch 4/5).
>
> Thanks for doing this, I think the adding a note to the rebase
> documentation is a good idea given the confusion that's been
> reported. The patches all look great to me apart from patch 4 where I
> share Junio's concerns about the readability and maintenance burden of
> the list of commands. I was surprised to learn that merge also sets
> ORIG_HEAD, thanks for being so thorough.

Thanks for reviewing, and thanks for writing, the patch.  Let's
queue and merge it to 'next'.

