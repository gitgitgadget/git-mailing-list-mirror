Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BD6C4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 11:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbiLULgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 06:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLULgB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 06:36:01 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D72111F
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 03:36:01 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id fy4so15488662pjb.0
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 03:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHCOHgt9dz7GyNzaW5sHd74JZmMyi2q0M+cBz50rVZw=;
        b=q4Ol5PL0pNFvXttbRW3VrvhJE8F0q97ksMwT+DzuXjkAmubsi2L2oh2iu97UkT61zL
         CUYnSIID5iz1rYP8sMjq+GK0RvP57ITf5A7ocR2Yfnb+0LPQkK30JeQgUuXG1Pk7+bIs
         vyUMC/OZhznHyXn9EYK9k07/FfS7goKxu2mpF8Oj1fKMDejWoBIcDk1sxlfen8eaBVQy
         VRDJhhB6IguTKH+7ekij8OzBwwr9iQpJyEA2MzBrdvDU4itjyBtQBrpYDXkRTBCNbbw+
         xz10DQ+mvMUFcY0yCZCGlxrZuU/dTUS2c+iTn/u8/2iR/K8S92U6hKwZva525GsNEi7Y
         vXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHCOHgt9dz7GyNzaW5sHd74JZmMyi2q0M+cBz50rVZw=;
        b=FbI/cgmo+D8X96Z43YFZbnHwxKnMNeeDkl/ho9C5UmU8650MFbEwHW65RRaLEBxWXW
         3UKImJY4mC4KScxPXhadaofzzsPwaHX6y/we1USYTmvnzetXpwf+t8OU/hJ1ImpsFyrN
         7krJM2HcB2iVkyPeOboi+hUlQ4dVLPJVZgS3qKHNrNs30vBgLobH3KbgsvUOs1Snd/US
         7Gt0l9iqO7CMSJ9HXw/wjdqmN4wY38c+xnOO1hiT3Gfbi9UuJdJPxkEAyDK9q5o8XOQ6
         cNXkbgXwZwfEndgoPiCZ3XVWR0C8o37lA+dR1RMc0srvWsckYrrjLGCb4J8AUEmCjGC5
         C6cg==
X-Gm-Message-State: AFqh2kqF2GtD9R8HvzIspnQZhp4sub1A53Tmq0+j7S+wArVGw/sox2Rp
        N63yTH5hwSCTm6N28IbY/pc=
X-Google-Smtp-Source: AMrXdXuoRCiW/bMsD/HKdB569qfrDNgsGdA2gBs0Q+nv907WMo1lDg5Q9seUU8tVCxXcrEjn7yLzkg==
X-Received: by 2002:a17:902:da86:b0:189:747e:97cc with SMTP id j6-20020a170902da8600b00189747e97ccmr2165468plx.26.1671622560324;
        Wed, 21 Dec 2022 03:36:00 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902680700b0017f36638010sm19155plk.276.2022.12.21.03.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 03:35:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     sunshine@sunshineco.com, avarab@gmail.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 0/5] notes.c: introduce "--no-blank-line" option
References: <CAPig+cRcezSp4Rqt1Y9bD-FT6+7b0g9qHfbGRx65AOnw2FQXKg@mail.gmail.com>
        <20221221091650.43359-1-tenglong.tl@alibaba-inc.com>
Date:   Wed, 21 Dec 2022 20:35:59 +0900
Message-ID: <xmqqili5rnts.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> Taking a step back, perhaps think of this in terms of "separator". The
>> default behavior is to insert "\n" as a separator between notes. If
>> you add a --separator option, then users could supply their own
>> separator, such as "----\n" or, in your case, "" to suppress the blank
>> line.
>
> Your idea is an enhancement of the original one of me. I think it's a suitable
> name and I could implement it, maybe we could hear about Junio's advice of the
> naming?

Yeah, saying "separator" clarifies what that empty line is meant to
be (i.e. it is an inter-paragraph separator), and is much better
than "newline" or "blankline", I would think.

Thanks.
