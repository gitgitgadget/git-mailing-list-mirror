Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7485CC61DA3
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 20:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjBUUVy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 15:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBUUVx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 15:21:53 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618162BF27
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 12:21:51 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id p5so2963779pgh.11
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 12:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mylz+mNF48ZV0w7bNv+YSKY6AztcM0b4q7MZjE8vlH4=;
        b=fyx2EpCz/yqDtNXZGODfi6WJQAabTPPzKVXDQnhvighjXgKXyJwa1XSa3IHPWc8QNi
         nINI4CbPypNvtBvZ4begg6FjoRQne5SY9GbBGjtYIv/tkW3OnREhbAYP2cBwpAbKoV9R
         xv7jQbDMoQnBGT9WPAt1LfXEa0Fp3xa8nlpHYoXTDU8vZ3kD51Vq4nbdGiN/D2aVbO6y
         4rV21vO2q+45VFE/zo0+r1OUF7DHqrk8DM6LIFJIFlF8259jkrj97shyUhhtLNs/ANRM
         reyIbv+khQMiYVTNgHtE619sirJlxGtx2j/sMkIPpabMiQVzMzEZ+AjmShd3tWb0Vjc9
         +V7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mylz+mNF48ZV0w7bNv+YSKY6AztcM0b4q7MZjE8vlH4=;
        b=Jmiz8Tv8INjjA6e3IvZqaouvK6Kr3HXmgcEhfzbgRe3oddv9C3xbDRtV7hRf7KRxOx
         y/rhndYAi04ZszL4oGpyd912gfkxfGHUQUjHWHN5LMDEx5H+P8kZ8updjoXHRC7NW6/a
         Ctqoqfw1i1aSufuOpFeb+nn0qb8E2iD97WiTH5k5ITAiEGbQNmHVlbh3O6fUP7qB+WfN
         Pm1HYOfMvennaDPnVauXwAU+DYvQoPjfJH8WXiluFwyhKWjpHgN84GqY+g2q5JmK5L76
         aUKsvWeAkmUF0MI0JV5Bml1UFdjHyFJZWAgKkuVk6sW3YHoPj5aeXgfnf6gm8pWlovd0
         LViA==
X-Gm-Message-State: AO0yUKWBIDELRoWQomCuP86VQGZ9XKuVxG/yPikRYB/0JFpjW3xTvFPy
        YGKenBY9Ju3YT2Jsm2UbUvPmxTf5p8o=
X-Google-Smtp-Source: AK7set/Tw7QTvxbbhGCSO1Z5Pcr7IzRIWQv7KxJZ2V0r+THDriufoHiJxa6wqkBDmTB/k+InOGhfGA==
X-Received: by 2002:a62:64c7:0:b0:5aa:6597:507b with SMTP id y190-20020a6264c7000000b005aa6597507bmr7927685pfb.12.1677010911389;
        Tue, 21 Feb 2023 12:21:51 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id a21-20020aa78655000000b005a54a978c1bsm655750pfo.7.2023.02.21.12.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:21:50 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Vivan Garg <v.garg.work@gmail.com>
Cc:     Victoria Dye <vdye@github.com>, Vivan Garg <gvivan6@gmail.com>,
        git@vger.kernel.org, christian.couder@gmail.com,
        hariom18599@gmail.com
Subject: Re: [GSOC][PATCH] t4121: modernize test style
References: <20230220235121.34375-1-gvivan6@gmail.com>
        <38cb184d-e47a-2129-a93e-16ffd2afe67a@github.com>
        <CADupsJNPVm13iSv84SXpqtP8Dhm_-htPTr59yPs_J=aQzs2FwQ@mail.gmail.com>
Date:   Tue, 21 Feb 2023 12:21:50 -0800
In-Reply-To: <CADupsJNPVm13iSv84SXpqtP8Dhm_-htPTr59yPs_J=aQzs2FwQ@mail.gmail.com>
        (Vivan Garg's message of "Tue, 21 Feb 2023 12:48:54 -0700")
Message-ID: <xmqq8rgqeplt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vivan Garg <v.garg.work@gmail.com> writes:

> I'm not sure what you mean by "next re-roll," are you referring to v2? But
> then you said it was fine in this patch, so I'm confused. If I am going to be
> sending a v2, couldn't I just revert the last commit and add this change to the
> same commit?

I am not Victoria, but I think

 * You had two (or more) changes in your patch.

 * She found one of them is good.

 * The other one(s) were found lacking.

When a patch is reviewed and found to be lacking (as a whole), and
if you agree with the issues pointed out by the review(s), you'd
redo the patch (with either "commit --amend" for a single patch, or
"rebase -i" for a series with multiple patches), and produce v2, as
if v1 never happened.  The act of doing so is colloquially called
"to reroll".

Documentation/MyFirstContribution.txt::[[now-what]] may have more
details.

Thanks.
