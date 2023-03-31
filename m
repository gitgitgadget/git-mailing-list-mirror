Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDD8C761A6
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 18:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjCaSRu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 14:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjCaSRt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 14:17:49 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40ACF1C1DB
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 11:17:49 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id cv11so2638047pfb.8
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 11:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680286669;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2AVbTGMW6oyThBiwNGeZoPfX+A+GjhpIER6NtrjQegY=;
        b=HvmKRg3Dew1AyD9qgw1gAf7Hwe1AZR5uM2RbtQID/Pp1wZJQuHgsUJ9fDcTA5Fza0M
         H4sV/MTxF2NeKNRO2f7qQpDeTUwYN71evgVcuOLxCI2wTCfsV3q+ZR8PfVOTSOnAbxDl
         MHXjyh6cB9Sf6APVXeRigjfr6RpaXl7/363s29+8KoGSZaTjG3dhzGNEXGORCFKBpIRm
         p+Lf1KjolKXXX85oCiZzqJcyVrRqtJrRnyncBzgiYpMNP2woExmxB8Hl11qJojHoieKb
         JtGQPwAm98C4iyOTqcm5qyaKrz6+abgJ0sb/Iqvy3HsG2WJbWrQ16r4noq+gqreeN+Uu
         nsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680286669;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2AVbTGMW6oyThBiwNGeZoPfX+A+GjhpIER6NtrjQegY=;
        b=d+Ud54lXux/hBIiUPeurO0I2PKS+W2+hPX2+gthB1c5RsnAHngGvY0SbQ8uX1agfGr
         t1zixIlaN9spNIFwU5S9VUuCvbyhO2r8aV5JaV7qx+ETDK1AVVGfW7lJTBrQCuYIiFS5
         vMacRklnbL5AGeK0Rn1BGZCTyGMkYrfq6iyzporiO2wZqNxJnWdSanT0XL0zUcvp1s64
         VJCmOBBUc3aZLZAtPl9ONW59IMBhfK6Pe8C+INRkvGN9r1lldxPex/onH0xgqiuU9a2j
         vACdGpFuGf0HFbQPolcTkni6NITpEI7XV77LDeex5d/sUf7c86DYBDJqL2KQThFEd0Zx
         p//Q==
X-Gm-Message-State: AAQBX9fSjo/wjqvGvbfFTxVbo3crvxQt3l1Cf81VL49oML8CybuRoPW2
        iT4xGs0W7E38pBaNfv5sT+4=
X-Google-Smtp-Source: AKy350aDZp521thlBGl7+G/4ruZ54xETj6W8LOG3CN6ryHuJBsNRbglTNwAxlqXNWFMrdknddCzCSg==
X-Received: by 2002:a62:4e88:0:b0:62a:9d6f:98d9 with SMTP id c130-20020a624e88000000b0062a9d6f98d9mr24539200pfb.13.1680286668547;
        Fri, 31 Mar 2023 11:17:48 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id n5-20020aa79045000000b00589a7824703sm2076059pfo.194.2023.03.31.11.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 11:17:48 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?=C3=86?= =?utf-8?Q?var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Subject: Re: How do we review changes made with coccinelle?
References: <kl6l7cuycd3n.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqtty2hx30.fsf@gitster.g>
        <kl6lzg7sc01z.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Fri, 31 Mar 2023 11:17:48 -0700
In-Reply-To: <kl6lzg7sc01z.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Fri, 31 Mar 2023 10:17:44 -0700")
Message-ID: <xmqqedp4g4z7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> I agree, but I wonder what this means in practice when .cocci fluency is
> so low. Maybe:
>
> - We increase .cocci fluency, partly by creating our own learning
>   materials, partly by being more conscious about spreading knowledge
>   from the folks who are relatively fluent in it. We might not have to
>   do a lot to get the ball rolling either; just checking in a
>   "MyFirstCocci" would help a lot, I think.

I think it goes both ways.  Readers of course must be willing to
learn, but whoever proposes to add a .cocci patch file should be
able to explain what the rewrite rules in there are designed to do
and why.  It is pretty much the same deal as any other patches.

I'll wait and prefer to hear from others, also on points that I did
not even quote back in my message because I didn't have anything to
add myself, before digging further on points I responded to.

Thanks for starting this topic.
