Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB25EB64DD
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 06:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjHGGfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 02:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjHGGfp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 02:35:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E8A1730
        for <git@vger.kernel.org>; Sun,  6 Aug 2023 23:35:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-cf4cb742715so4493135276.2
        for <git@vger.kernel.org>; Sun, 06 Aug 2023 23:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691390140; x=1691994940;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gHD+WWJeZMGKpgTGBnJfiDlGsSSyPHI7ZUAiADNCRWM=;
        b=hdStfkg6dbCRANANihaCvmErgRlE05BLo5btE7gfqSZ/RHsHBJXIPGAGgTEJz89xss
         4fjsnIdCWiElzkBHR6KI5ja7WzEJP9nzsYlACpK//ExmNvj+lq1uANnv0cdTIMTrIv9F
         2TiP2E5QbZuXOoZ3cl8Le2ifu3K9okNuKSzCCmBGntYXAx90Qzp8Xl+CEs5iZGAlUFT+
         AUE2cV766/wqciEyBwI5JbL+kdlzAhnFt02KCcRu2DF0pOG5treheEi1IUnK+RGlOoG4
         YX0kfslZfmKgUeaPIt9jOKsJBBa8imwVKpB8jJyeehwIYBINyUP3MKd0L9000E5fxRh6
         uHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691390140; x=1691994940;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gHD+WWJeZMGKpgTGBnJfiDlGsSSyPHI7ZUAiADNCRWM=;
        b=GHCFzlIxgboIm78n6lI3MapX6zNN9AAthWHc6QB4QGGLlyExulKI/fs73LSQINyWSp
         LJP0YldzCl2p+5E/VJHdm+xHVhNamL2secsluTmtP6Bf3MC+uEte8C3vMRy+2hCPNlYN
         5aJq1QQd9BSYdYX58wtzhpWEnAw4SQMoq35UcF0pKRN9AoNzen/hu8OVr3SeodNdQg9M
         QALIYrQ0YJKr7XvHxdzwv8l1ALK6cFi/yZ8mO5X3OKkYC2caO5td78/rXS/ihGCWx2vT
         B7GWM9++xP9xksU2Q/CKJ8/b8wUFKaN+6vn5K/HbMCD2bawilrp3NQkgafQJPQ01h94w
         MNJw==
X-Gm-Message-State: AOJu0Yzuzpm53KUzlFfoI5e2onJjPecLK7MlE2N0tp59v0aXPgVmAP4f
        waZQgk9clMzZCqjwZ8ZinKURFzZ0y80=
X-Google-Smtp-Source: AGHT+IGjFIOrOsZuweSwXHVUh8qYcVFsLWMjkeeIVHGxt8I6KfpFMIseoTyTunuZrF1y5Ks+l/ydv5TRjiE=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:4a7:b0:d11:3c58:2068 with SMTP id
 r7-20020a05690204a700b00d113c582068mr48429ybs.2.1691390140649; Sun, 06 Aug
 2023 23:35:40 -0700 (PDT)
Date:   Sun, 06 Aug 2023 23:35:38 -0700
In-Reply-To: <owlyfs4vbeus.fsf@fine.c.googlers.com>
Mime-Version: 1.0
References: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
 <6b427b4b1e82b1f01640f1f49fe8d1c2fd02111e.1691210737.git.gitgitgadget@gmail.com>
 <xmqqjzu7irhw.fsf@gitster.g> <owlyfs4vbeus.fsf@fine.c.googlers.com>
Message-ID: <owly7cq7bbr9.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 3/5] trailer: add tests to check defaulting behavior with
 --no-* flags
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> @@ -114,8 +114,10 @@ OPTIONS
>>>  	Specify where all new trailers will be added.  A setting
>>>  	provided with '--where' overrides all configuration variables
>>
>> Obviously this is not a new issue, but "all configuration variables"
>> is misleading (the same comment applies to the description of the
>> "--[no-]if-exists" and the "--[no-]if-missing" options).
>
> Agreed.
>
>> If I am reading the code correctly, --where=3Dvalue overrides the
>> trailer.where variable and nothing else, and --no-where stops the
>> overriding of the trailer.where variable.  Ditto for the other two
>> with their relevant configuration variables.
>
> That is also my understanding. Will update to remove the "all" wording.

Hmph, actually it also overrides any applicable "trailer.<token>.where"
configurations (these <token>-specific configurations override the
"trailer.where" configuration where applicable). Still, the "all
configuration variables" wording should be updated, probably like this:

    =E2=80=BA  Specify where all new trailers will be added.  A setting
    =E2=80=BA  provided with '--where' overrides the `trailer.where` and an=
y
    =E2=80=BA  applicable `trailer.<token>.where` configuration variables
    =E2=80=BA  and applies to all '--trailer' options until the next occurr=
ence of
    =E2=80=BA  '--where' or '--no-where'.
