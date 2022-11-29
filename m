Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B132C43217
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 00:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbiK2AS4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 19:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbiK2ASy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 19:18:54 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A14F2FC14
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 16:18:53 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id w129so12126055pfb.5
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 16:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sY0vKkGxtshVh4ZmMHU8YVCabXJelMBujhbfvP+c4m8=;
        b=X2ksO3TDDzmZuy9FWK5cgqwFV73geqanRoZDsCLHo70H0fhroGSczqnPkkXdhIQwEI
         weHd1ExrIyTIbpm4RFUVi/aU2Xcq3Yo/rfOurtTE1JGTm9FBXx3+Q0oM60zVu+uRAGkU
         SYi1M4nt2LWV/ITRolmb7Zm6z/GDICgNa3TpYqUUFKihBACLvdqW2H+HeuFCFh/GsWaS
         94zWiXNIuN5M/IURN6/FkQMDwPITyUuuG5vM5pcWZ/TJENUkqqc04m/YSrTg0dqcE1px
         srYrhD4hCAXMQzVPHIDwxnOevuxZTD9Oqdym3atuaGThgQ0L3QtFgm9sw8pBRaPgD4r0
         6erw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sY0vKkGxtshVh4ZmMHU8YVCabXJelMBujhbfvP+c4m8=;
        b=YlK7dDTDoBKXUZYbF3KAQDXY6y8cOuO+f33KBj62HE3js0QEGd+RYxbVRCTHTkzR0j
         pZCsb/S1y2IWV9lj6+mD2qtOp2nT0V28GFlFOhHM5P9RYqzC3kNaunBCTjm3iuSw+NV5
         k7YgkG2zxpIwtW8lKJE3ApGdtqmmc1BBxlRnc5w9m1oVNJvOfMsAsM9xQyGqjxy+7gFh
         +dbOGrzARaL2Kfdl85PBZCNoCYiikwx07KJ2CCdk7kz8DKXGJXROTS7jWLVTKJxo4OJF
         t/ZG8VbiAIGuK/iHZ9ccAAslBBa0xn9/gSKxn7vtKo/ncfz3pNMLWJw/DTK8sOJnEAyS
         7BaA==
X-Gm-Message-State: ANoB5plNw6SwcaiQnUABT6SO19V00nUsYqRWbZJwSxhI8/SRnxHGfrd7
        B3p0R5rDtj3K7diA0vE/T63VicBngvqdFg==
X-Google-Smtp-Source: AA0mqf6n3K5ta5jLouq7nPwCow+/mbcGvpUN3VK09JqLm+j74q7yc3eqbZMd/W2274YWvbWu3mjbsw==
X-Received: by 2002:aa7:9882:0:b0:574:7931:98a3 with SMTP id r2-20020aa79882000000b00574793198a3mr25421375pfl.17.1669681132700;
        Mon, 28 Nov 2022 16:18:52 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a14-20020a65640e000000b00477bfac06b7sm7325773pgv.34.2022.11.28.16.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 16:18:52 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Subject: Re: [PATCH v4] pretty-formats: add hard truncation, without
 ellipsis, options
References: <20221102120853.2013-1-philipoakley@iee.email>
        <20221112143616.1429-1-philipoakley@iee.email>
        <xmqqfsedywli.fsf@gitster.g>
        <d80d1b97-b0c0-148b-afb7-f5210366e463@iee.email>
        <xmqqedtvu7py.fsf@gitster.g>
        <7a6c3d32-4494-e209-9877-e8784f0c3502@iee.email>
        <xmqq7czjecfr.fsf@gitster.g>
        <f0923db4-7bfe-86d2-7539-c9ebed62fa4f@iee.email>
        <xmqq35a5cnhq.fsf@gitster.g>
        <b7b84dde-a723-0773-279f-c04c7f35cb7f@iee.email>
Date:   Tue, 29 Nov 2022 09:18:51 +0900
In-Reply-To: <b7b84dde-a723-0773-279f-c04c7f35cb7f@iee.email> (Philip Oakley's
        message of "Mon, 28 Nov 2022 13:39:52 +0000")
Message-ID: <xmqqedtm62ac.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

>> If the given display space is 5 columns, the desirable behaviour for
>> trunk and ltrunk is still clear.  Instead of consuming two dots, we
>> could use a single dot as the filler.  As I said, I suspect that the
>> implementation of trunk and ltrunc does this correctly, though.
>
> I believe there is a possible solution that, if we detect a column
> over-run, then we can go back and replace the current two column double
> dot with a narrow U+2026 Horizontal ellipsis, to regain the needed column.

It would work, too.  As "trunc" and "ltrunc" (and "mtrunc") are
about "truncate and show the filler to indicate some letters in the
original are not shown, and make the result exactly N columns", it
can use a narrower filler than the originally specified and use the
alloted space.

>> My worry is it is not clear what Trunk and Ltrunk should do in that
>> case.  There is no way to fit a substring of [1][2][3][4] into 5
>> columns without any filler.
> For this case where the final code point overruns, my solution
> could/would be to use the Vertical ellipsis U+22EE "⋮" to re-write that
> final character (though the Unicode Replacement Character "�" could be
> used, but that's ugly)

That would be "trunc" not "Trunc", wouldn't it?  If the capital
letter verions are "hard truncate" without filler, it fundamentally
cannot be done to fill 5 display spaces only with letters each of
which take 2 display spaces.

I am not saying that there is an impossible situation to handle and
"hard truncate" primitives should not be invented.  I just want us
to specify (and document) what happens in such a case, so that it no
longer is an "impossible" situation (we can say "odd/leftover
columns are filled with minimum number of SP to make the result N
display spaces", for example).  And not calling it "hard truncate"
might be a good place to start, as it won't be "hard truncate" with
such a padding.
