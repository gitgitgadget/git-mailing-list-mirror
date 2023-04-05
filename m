Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7616FC76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 19:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbjDETs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 15:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbjDETsI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 15:48:08 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367273C02
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 12:48:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so38408541pjb.0
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 12:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680724082;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UoQ5sanakyDNlUQNxCTzJuXmYgcpQjtk4KEQag1kEE=;
        b=Mk1uj3aBUYi4tKF5XS2yPsSWxJpeolGvdkzxXXMOpwpiQeS/KBNhZA8GDanH5IZBHw
         +2KnvWejlUsounXW+ir5kWHfftRqjYSr1ySRoSIiEVuhOjqBpu/NS3WiHW+8qGQJLFms
         4V3+n10XKXEUYNtWd9DIf5ybH6unVIf6IH0Lp9fW1KUEwbFEVpiZmQ6Rhwv+/cFzUxIP
         SOnPBMcrFyVhFQCMGbalxuSzUdAefcv2SDRuEJIXcHY/oSn1iow71UboVJ1U0fi5x7aP
         GqZln/dZRSz1IjlgZ6eRKtpmDbXlhnKJ3VZRIxr57B2ADl2mu1+AfiPSrTdkm3eagk75
         VPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680724082;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+UoQ5sanakyDNlUQNxCTzJuXmYgcpQjtk4KEQag1kEE=;
        b=KipPf5tuoQu8F2K7cmGE12PAv/VtMzqFZ4z9hOtChSmhxk4R9s8RTdZc7F6vIyQBB9
         QvPZk7hmZFOKDU9zWRHEaW5rtLX53ud136na4vVkWaxe9PIUYCJoVIPcRQpyQCjRrUNG
         zzxvtEM5k08MRDo2VBUYdA0mPGaWfeKTfu+Aa0P45GDmBrpfHXmEAyJi9K/LELEtZqVG
         vk5Z+bkWZp+4WcShUlpcSwoTPSrO85KGBK7rW/Yn0V2bm+h8VckKuqvjQEUtChl76A0a
         xKU3AxJtNNoCaPqb00i+H5F91yPAT0uBIEz3EfE9pMfkJ66ybI0gkPQQ29mQq+ygytIJ
         dTGg==
X-Gm-Message-State: AAQBX9fRINNcxBPhX60Lu12ZZ07HE25jeZOfLTAyVAs9CN51nc9catqK
        /LjbSZv7vIlcIHFzW5Tx+IGo43ThsSI=
X-Google-Smtp-Source: AKy350bYQyf/X36sa7qdFrC4z2Spq+orsKFxiWoP0nlDr5itOo4PT0o8uoULgm03qATNRhph0LG9wQ==
X-Received: by 2002:a17:90b:3852:b0:23f:b177:9082 with SMTP id nl18-20020a17090b385200b0023fb1779082mr7471756pjb.49.1680724082149;
        Wed, 05 Apr 2023 12:48:02 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id mp7-20020a17090b190700b0023b5528b8d4sm1801500pjb.19.2023.04.05.12.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 12:48:01 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org,
        derrickstolee@github.com
Subject: Re: [PATCH v2] write-tree: integrate with sparse index
References: <20230402000117.313171-1-cheskaqiqi@gmail.com>
        <20230404003539.1578245-1-cheskaqiqi@gmail.com>
        <9d0309bd-943c-dd51-97cf-59721eda78f7@github.com>
Date:   Wed, 05 Apr 2023 12:48:01 -0700
In-Reply-To: <9d0309bd-943c-dd51-97cf-59721eda78f7@github.com> (Victoria Dye's
        message of "Wed, 5 Apr 2023 10:31:36 -0700")
Message-ID: <xmqqedoyun4e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> Shuqi Liang wrote:
>> Update 'git write-tree' to allow using the sparse-index in memory
>> without expanding to a full one.
>> 
>> The recursive algorithm for update_one() was already updated in 2de37c5
>> (cache-tree: integrate with sparse directory entries, 2021-03-03) to
>> handle sparse directory entries in the index. Hence we can just set the
>> requires-full-index to false for "write-tree".
>> 
>> The `p2000` tests demonstrate a ~96% execution time reduction for 'git
>> write-tree' using a sparse index:
>> 
>> Test                                           before  after
>> -----------------------------------------------------------------
>> 2000.78: git write-tree (full-v3)              0.34    0.33 -2.9%
>> 2000.79: git write-tree (full-v4)              0.32    0.30 -6.3%
>> 2000.80: git write-tree (sparse-v3)            0.47    0.02 -95.8%
>> 2000.81: git write-tree (sparse-v4)            0.45    0.02 -95.6%
>> 
>> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
>> ---
>> 
>> * change the position of "settings.command_requires_full_index = 0"
>
> Could you describe why you made this change? You don't need to re-roll, but
> in the future please make sure to describe the reasoning for changes like
> this in these version notes if the context can't be gathered from other
> discussions in the thread. 

The reason, I think, is because previous iteration hit a BUG() when
the command "git write-tree -h" is run outside a repository.  That
form of the help request is handled in the parse_options() machinery
without any need to have a repository or a working tree.

But prepare_repo_settings() does need to be run inside a repository,
so calling it without first checking if we are even in a repository
is asking for trouble.

I guess an alternative fix could have been to see if we are indeed
in a repository, by doing something like

	if (the_repository->gitdir) {
		prepare_repo_settings(the_repository);
		the_repository->settings.command_requires_full_index = 0;
	}

like implementations of some subcommands do.  And being explicit
that way, instead of relying on an implicit safety given by ordering
of calls, would be more maintainable in the longer haul.

