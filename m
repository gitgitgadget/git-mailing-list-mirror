Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE39C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 10:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbiBQKWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 05:22:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239111AbiBQKWP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 05:22:15 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97B327CF8
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 02:22:00 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b13so8844115edn.0
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 02:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=++1naDTcAwSjqjwitN7Hq9AsulTuSqjfeCjn2TMEHtk=;
        b=NNhAqjn6zveZEydlQ/emMF2hm9+jvhwx500+M3QPXN/EZ2jniTWenhLmXFv9JR76Te
         qeD39cpnExpIC4I4pw40Eg2EEb1TuUC25zE4d6Q2Hb6bKKMF2Cop/Cg+AMeYdspuXIYq
         1Xl9MVGgsNOTqu4RXT/Urg4nMCggqRSUI/ycs/S55cp+i5vrQdorW+lF0vUiG/gRSnMC
         mCihyEpvf0EZWD/iDey3RE1NAu4jKKN34lrIeaCbVn3tNRT0J8BJmz9vDDwwFbnmFaTG
         TFCLPc+mJNZluj7R1Kdc20HgKsNfGMSqMsHvHuFY2sXIP5BvbsLrkv/6AlVcKkKOdqj6
         qQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=++1naDTcAwSjqjwitN7Hq9AsulTuSqjfeCjn2TMEHtk=;
        b=Hk7+KOugB6sklfqP2BgRrq4r1U1/llNaBpCKjFBOSMHvEWTS+dJhPGbPvTUKIVr6AS
         +PV6+DIK3FjZidouw7+xW4wTFT0bc0+3NJZCdmdZ3Vj4ISX1q5BlXJ8sdnghMHSAREZC
         aCoUpAny461BtIpWOBWGQ+cYaYx7oLc5NcO/lWOKCVMUFn0BooAS+4RY4nUDjraP5rwF
         0QAJRUdNjvDQcU/5zs1qDJAflm9eyPQenUV3gFNZoq4Lb+AVKIrqE5RJtYRBMQra4UWI
         ZCyDGyFEYOnAdgvhpsXefNuq5n7fUtu7iF5uoutP2aX+4d4vmo2SysY0zQZ9n6JBE/wx
         Hr3Q==
X-Gm-Message-State: AOAM533Og8SdYHUUlqAVLuTQb+DiyLIs0MX9eJl5EZnym5ZmeNcZTYDU
        FlGT6k5mKqU57C0tZkC5XFNXP7HvvrNF0w==
X-Google-Smtp-Source: ABdhPJxgNtOp3h2qcFCiCF+lFdUB8rhj5EWcrEKb0Z5AiVW8JerOv/QvNpu1db/W/tXi7iUVZi7UHQ==
X-Received: by 2002:a05:6402:2344:b0:3fd:be28:f435 with SMTP id r4-20020a056402234400b003fdbe28f435mr1804545eda.377.1645093319157;
        Thu, 17 Feb 2022 02:21:59 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q19sm1020154ejm.74.2022.02.17.02.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 02:21:58 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nKdvC-003iHZ-1P;
        Thu, 17 Feb 2022 11:21:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Merlin (they/them) via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "Merlin (they/them)" <merlinpatt+githubgit@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] docs: update coding guidelines to be more inclusive
Date:   Thu, 17 Feb 2022 11:02:11 +0100
References: <pull.1070.git.git.1645029267415.gitgitgadget@gmail.com>
 <xmqq4k4ycvgb.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq4k4ycvgb.fsf@gitster.g>
Message-ID: <220217.86a6epiyii.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 16 2022, Junio C Hamano wrote:

> "Merlin (they/them) via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>>     These changes make this documentation more inclusive.
>
> I am not sure about this claim, though.
>
>>      * Using "male" and "female" as examples of gender is unnecessary.
>
> It feels somewhat more excluding for those of us who are non-native
> speakers to use a heavier-weight word "gender".  After all, it warns
> against writing "he", "him", "she" or "her"---the reason why we warn
> against the first two is because the author has to implicitly assume
> the person in question is "male".  Similarly the latter two needs to
> assume "female".  These two words, "male" and "female", are both
> easier to understand to even non-native speakers like us, and at the
> same time quite in line with the suggestion being offered.
>
> Maybe the motivation behind this change is a misunderstanding that
> somehow the original of what this patch touches says that "male" and
> "female" are the only two possible values of "gender", but I cannot
> read it that way even when I squint my eyes.

Isn't that exactly what it's saying? I.e. for the purposes of the
English used in our documentation there's two grammatical genders "he
ran the program", "she ran the program" and gender-neutral "it/they ran
the program".

>>      * The use of "it" shouldn't be used to refer to people even in an
>>        example of what not to use. People are never "it"s.
>
> People are never "it", but I do not think that is relevant.  Reading
> the original of what this patch touches, the subject is either a
> person or a program, and for program, referring to "it" would be
> perfectly sensible, no?

Yes, as the person who wrote this originally (in
https://lore.kernel.org/git/87a6nz2fda.fsf@evledraar.gmail.com/) that's
what I was going for. It's referring to describing a program as "it".

>>      * There's no need to specify a person or group of people that learned
>>        "they" is only plural.
>
> Again, this change assumes/requires too much knowledge of the
> language, which is more excluding for non-natives who may think
> there is only one kind of the English language taught everywhere in
> the world uniformly unless told explicitly.  If you are familiar,
> there may be "no need", but does it actively hurt those of you who
> are familiar if the explanation gives such an example?  Removing it
> may actively hurt those who did learn English as a second language.
>
> So, I can applaud for the desire to be inclusive, but I am not sure
> if the patch succeeds in doing so.

Per what I noted the last time this was discussed I think that we should
mostly drop this section entirely in favor of some guidelines describing
how to actually write the docs that we do write, not what not to do in
the rare/nonexistent cases of using grammatical genders:

    https://lore.kernel.org/git/87pmwt1dz3.fsf@evledraar.gmail.com/

brian's follow-up provides a good example of what we try to aim for:

    https://lore.kernel.org/git/YMKTARn368Qzsqc2@camp.crustytoothpaste.net/

The thing that's uninclusive here is asking non-native speakers of
English who are trying to contribute to this project to grasp some
fairly advanced linguistic concepts.

I think it's fair to say that the use of "they" as a personal pronoun is
fairly new/novel English language as it's commonly understood. I.e. if
you talk to any person who's not a native-level speaker of English it's
a fair assumption that their introductory textbook didn't cover it.

As noted in those old threads I'm entirely sympathetic to the goal of
avoiding gendered language if it's a thing that matters for some
readers, which clearly it does[1].

It just demonstrably isn't relevant to our documentation in practice, so
this whole advice ends up being a bridge to nowhere. It's comparable to
us carrying C++ coding guide lines in-tree.

1. To be fair, I do find it a bit odd, but then again I'm a non-native
   speaker, and I'm unable to refer to even the monitor, keyboard and
   laptop I'm using to type this in my in my native language without
   assigning the three (different!) genders.

   I can assure the concerned native English speakers that by all
   accounts Iceland's got a rather good track record when it comes to
   gender equlity despite that :)
