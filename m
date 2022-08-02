Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8D2C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 22:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbiHBWXB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 18:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiHBWXA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 18:23:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF4346D86
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 15:22:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bk11so9599167wrb.10
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 15:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc;
        bh=eRuOoqLWeTnA7YWQmq5TOIPMBHW8UZmp75kyTYOGLdI=;
        b=mtuLQl9TYnYcP9e5mmZCc7LxHBR5RV1rStZpFGoYyEqHFNwbP/LRIheGtxo0RgzByt
         ldPNBQDL8CurQbfoaykoQiGvMbUjaUR+gRh2+ToOdnlUfYvuK/W+WcgdtvYrIi3RMbKG
         Si9ZpH9B22nRBskK0Vmv05X6hDHl7T0mAuad960UvMC56alqix8jQSFGXgqDQL0CiZUy
         bUeB5h/eS9pTOgwufYJtklOHoU3bjQiokJpd88KdES+kTZ9kfHKvlUrEx/nDhbJPms/y
         pbttyt9xd3NmeHAUy6Bd9b0jZ8VI8DWyRg4APomfaCLtnerls/gp7iDaCrLvCRPlsyrP
         prHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=eRuOoqLWeTnA7YWQmq5TOIPMBHW8UZmp75kyTYOGLdI=;
        b=K0e7wvwBNp4PpQB4voInTIxt2lvZlxoe75DE7hMlrtDH9AEYdciVzu8W5Gv2mtKhhb
         XUOYNIfIfpyItEittIfH4228uoUVT8Ar59WTSGsoUqWPsb62ObsNKWgDynyFg6zrdvFF
         k+G1NuHFlXEp4rwVN6ft2yfa6HRzo709HGmM4Zu/Fbzlk2zicnNyFzTS8LMYTkBjkdzm
         mWdcDK+enR78ZCjqlESK15qoYzHQunK+hA4TdeWLtY6dabQ7LXZGYojpynfLQaB4I7Vh
         dgvUVpibyuWjF7ejU0RIFSr84aLNaUglvzg2sfn37S5oFQFAAAsUPLbrDA/sRBcDsKTY
         Xs6A==
X-Gm-Message-State: ACgBeo0oCF86P/qJOWovLes3V4rXmsjRqilK8Gee9dvCPkitvaMMs4r3
        GTO24NAMNlTw1G1+9V9FvC8=
X-Google-Smtp-Source: AA6agR6IPODt1NUIF46pp986fKwHu0W66G2sfsQ+D33LcSqd4cBV0joU5MC/+Z/i5XiQ+T6KZJQqoQ==
X-Received: by 2002:a05:6000:1acd:b0:220:62c2:bc29 with SMTP id i13-20020a0560001acd00b0022062c2bc29mr7538757wry.620.1659478977780;
        Tue, 02 Aug 2022 15:22:57 -0700 (PDT)
Received: from ?IPV6:2a02:842a:806d:3300::b3d? (2a02-842a-806d-3300-0000-0000-0000-0b3d.rev.sfr.net. [2a02:842a:806d:3300::b3d])
        by smtp.gmail.com with ESMTPSA id t13-20020adfe44d000000b0021e2fccea97sm16458281wrm.64.2022.08.02.15.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 15:22:57 -0700 (PDT)
Message-ID: <2a7040a4-20ce-495d-4182-089c6c08fbd6@gmail.com>
Date:   Wed, 3 Aug 2022 00:22:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   =?UTF-8?Q?Th=c3=a9o_Maillart?= <tmaillart@gmail.com>
Subject: Re: [PATCH] rebase: introduce allow-inline-reword option
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Th=c3=a9o_MAILLART_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1228.git.git.1659422389830.gitgitgadget@gmail.com>
 <xmqqles6is9s.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqles6is9s.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 8/2/22 17:23, Junio C Hamano wrote:
> "Théo MAILLART via GitGitGadget"<gitgitgadget@gmail.com>  writes:
>
>> This new option (false by default) for interactive rebase allows users
>> to modify the subject of a commit directly in the todo list, when they
>> select the "reword" action.
>> If the option is enabled, "reword" is selected and the subject has not
>> changed, then the default behaviour is used.
>> It also introduces a test for this specific option, and a related
>> function (set_inline_reword_editor) in the lib-rebase.sh to use a
>> simpler custom fake editor to be able to modify the message part of the
>> lines in a todo list (in the most simple cases).
>>
>> Signed-off-by: Théo Maillart<tmaillart@gmail.com>
>> ---
>>      [RFC] rebase: reword: new feature change the subject in the todo list
> It is not clear if you meant this as a final submission or an RFC
> but I'll take it as an RFC for now.
>
> A handful of things come to my mind.
>
>   * Would this want to be a new variant of "reword" that you would
>     write into the todo list file, instead of a command line option
>     that says "every 'reword' I write in the todo list file means
>     something different now"?
>
>   * Is there a plausible UI that allows inline editing of a commit
>     log message that is more than one line long?  Should there be?
>
>   * Under "inline" mode, when a "reword" is requested for a commit
>     that has more than one line of log message, what should happen?
>     Should the updated title become the ONLY content of the log of
>     the updated commit?  Should it be an error, because it is clearly
>     an information-losing operation?  Would it make sense to turn the
>     "inline" reword into normal reword automatically for a commit
>     with more than one line of log message?
>
>   * If we choose to special case a commit with more than one line of
>     message in order to prevent the 'inline' mode from losing
>     valuable information in the original commits, what role should
>     trailer lines play when we decide if a commit has only one line
>     of message?  For example, if a lazy "title only" commit has no
>     body message but a sign-off and other trailers like helped-by,
>     would it make sense to keep the trailers intact and only replace
>     the title, still in inline mode?

I agree, taking care of more than the commit subject only does
not look like an easy task, and I'm probably not the right person
to do this in a reasonable amount of time.

>
> Here is an alternative design that may be conceptually cleaner.
>
>   * We do not introduce a new option at all.  "reword" means "open
>     the editor and you can edit the whole thing" as always.
>
>   * We introduce "retitle" that can be used instead of "reword".
>
>     The line for a commit originally shows "pick" followed by an
>     abbreviated commit object name followed by its title, and the
>     body of the message and the trailer is hidden.  If you change
>     "pick" to "retitle" and edit the shown title, then the original
>     log message from the commit is read as a whole, its title line is
>     replaced with what "retitle" line has, and the result is used as
>     the updated log message.
>
> That way, those who write more than one line of commit log message
> can still use the feature without having to worry about losing
> information when the only thing they want to fix is a typo in the
> title, and those who write only one line of commit log message do
> not have to pass the new "--inline" option at all.  They can use
> 'retitle' instead of 'reword'.
>
> Hmm?
>
So, if I understand your suggestion correctly, we can say that,
most of the logic is implemented in this patch, but I should move
the "inline" logic from the "reword" to a new action "retitle".
If it is ok with you, I will look into that, and get back with a new
patch.
The only thing that seems unfortunate to me is that we will have
a hard time finding a meaningful short name for this new action in
the todo list, as "r" is for "rename".

