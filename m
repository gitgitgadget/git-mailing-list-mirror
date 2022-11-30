Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B87EC352A1
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 03:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiK3Dxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 22:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiK3Dxi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 22:53:38 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F856286C7
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 19:53:38 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o5-20020a17090a678500b00218cd5a21c9so702147pjj.4
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 19:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQd+XwiwkqJIlVK0jZ40zxLZrfIDRM9OA/gDAPtFfMc=;
        b=AHzoP88RmJ3EZtkrAWT3mDZM3o6fNvARTiIi8IPwp+D3KpcsHc17Xf/9oK28SDUXTW
         pV6QMp6rWiEWpCjLJPv2a9chTQAhavVmj/6caP7xlxUgkXtT4VdeOoYIQBZpUEYBt3uR
         z0p7fjRfsjhJJk+7qZ7WMsbTtr+lrkjMkCKqS/W9xY3Xvm3YnvEDzBhV75wd1OfqF/6Y
         ecEuOZxrPuteNg3keE/g6+jXMmM2gql8tjcmj19ZT7U48AJKH9BTC7FZL35hH4DKrpOX
         /pgxZ/RLmPqYmCCf70FXf1FVI63Vy80esbrizvmtVcledIQNULw5v6lj5KG2ItVTYXQ3
         krDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OQd+XwiwkqJIlVK0jZ40zxLZrfIDRM9OA/gDAPtFfMc=;
        b=Jw2hWfE3xgKRsN4eIvEBJ0cbTIi+qynWoRNpZQ7po3mD0W9K9fcuJkFEd2DuRhdHhP
         R67c48vV6SwFS1Nh1yTaBu4IvcjjSJUKsJAhSRzUkGPv67358yRygcLbZSyiXQ4B7DMD
         TkaaEaLF+BUkoSjOxbRRvHUikB3t6dgCKwiBYfMhs3gKQqJ+CYvTyrFZM1ZURXDZjAxD
         /fVJg1Evaa5Jto46zqegPVtEUS+Wd9mmZv7PAf7vq/tW8hFugCnGPbwMKB4J9HYTDWVY
         wG/hY1OK4TK6n9pLLR0x4xlhc8mqU8T6U8sXYHaRdVWxjiyc8L5sgPg4+eW0Niov+awM
         Q3xQ==
X-Gm-Message-State: ANoB5pkmqlWtkkzciQmErU2Qca67dJGIiHRlGWRmzzUd5DV5YO6jYCwp
        xfPPtwaC8udgLX2nM7rWm+w=
X-Google-Smtp-Source: AA0mqf5+6KAfKazBU1L4J4ppqSlQMaVWaCc0YC965i/OFucatd2kAy/Yp6k5TdhRyr7ocGmZPiC/sA==
X-Received: by 2002:a17:902:a616:b0:189:46b1:fe0b with SMTP id u22-20020a170902a61600b0018946b1fe0bmr33920904plq.117.1669780417467;
        Tue, 29 Nov 2022 19:53:37 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090276ca00b001894881842dsm98645plt.151.2022.11.29.19.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 19:53:36 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git-packagers@googlegroups.com, git@vger.kernel.org, lwn@lwn.net
Subject: Re: What's cooking in git.git (Nov 2022, #07; Tue, 29)
References: <xmqqr0xum8tn.fsf@gitster.g>
        <20221129130841.82302-1-tenglong.tl@alibaba-inc.com>
Date:   Wed, 30 Nov 2022 12:53:36 +0900
In-Reply-To: <20221129130841.82302-1-tenglong.tl@alibaba-inc.com> (Teng Long's
        message of "Tue, 29 Nov 2022 21:08:41 +0800")
Message-ID: <xmqqa64914jj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

>> * tl/pack-bitmap-absolute-paths (2022-11-29) 4 commits
>>  - pack-bitmap.c: trace bitmap ignore logs when midx-bitmap is found
>>  - pack-bitmap.c: break out of the bitmap loop early if not tracing
>>   (merged to 'next' on 2022-11-14 at 34eb0ea05a)
>
> Will the two commits which merged to 'next' on 2022-11-14 at 34eb0ea05a
> be taken into 2.39.0-rc0 (or v2.39.0 is frozen already)? 

2.39-rc0 was a preview of topics that were already done at that
point about a week ago.  A topic that is not in -rc0 may hit the
release, but it depends on how urgent the "fix" is, I would say.
Unless there is a good reason not to, any topic should spend at
least a week to cook in 'next' before graduating, and because there
typically is about a week between -rc0 and -rc1, anything outside
'next' when -rc0 was tagged is not likely to have spent a week in
'next' when -rc1 is done.

We could graduate the early bits separately, but is it so urgent a
fix to get them in?

I spent a few dozens of minutes to re-read these two patches, and
while I do not think they are so complex and risky, I did not see
anything in them to give them such an urgency (for that matter, I
am not sure if they are even necessary, especially the one that
loses information from the logs).

Thanks.


