Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5C6C7618A
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 21:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCSViy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 17:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCSViw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 17:38:52 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73897CA3D
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 14:38:50 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id o44so3715991qvo.4
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 14:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679261929;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=NZGi9G/cdwN79zK2grhEWZKWDB+5izvb+0xgzlydYrM=;
        b=SvHKl8dBv3Ir7XVVPBaj++uIbqAS25tcBDlzw1fWadB7uQSMxBFOsbFumXOVAwX8Ar
         ag1aOqrciNKh3uka4jQ9UTAMC1Bn8AXonls2nj22GtgjMBiicw+ZhvniAF3yCAzMa6BD
         F8s+b5MpdycYNBPa5C6zkowECyUvxbESb6pB4BvoEnVtqLjASHP691rowLQUfubCemhI
         AL5L/QRAeW8S0nu530tExUIKW5KXG7IwcNpqQ7j1wkls99ZAe3imtAuMhHG7zUS+sxS5
         JjCRuOtztk8UEqJ9uUPbMuwmG/+UzHc4pebGWqJGmR4FZf+KXd56+ZISyZCdI9sJ2gmS
         Eliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679261929;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZGi9G/cdwN79zK2grhEWZKWDB+5izvb+0xgzlydYrM=;
        b=Zz0jjmgi6WGSKl6HfJn9lQbY1IQgsebu5D2IpVuwdkLm3OAR3176jYhTUYZ2h2wVZE
         aWSLqKpkd2cvoTU+76BoWkiBYgBWbHIhaBmNTrTo6BxGuscV49r1PkNKeh58Ai6Is1Eb
         LA0b62mcKttRW3Pq5r5crZp+OQ6r3QhZhWMQXATdj84iRbIs01f6YW3kpgIf96RzNc1i
         MHgVB5Z1so5WhI+59dY8GkCrf9RIIdb1PR0beiKdI0n354+hNVph8jLuygqPOlfTavPM
         AuBE03bHuszKxwNLBfvOgZmGGOS/5r4C11OnYf4SLsn7utlNtzs7cvKepjMBCW/OybfD
         NUyA==
X-Gm-Message-State: AO0yUKUXLvaWsR3h68nPTreT+f+Jx1eOt3sLSkMlFRf9cVeN+Usv4aA6
        7SFry3H+k5d8mODvLpJvsnEZBHRSWJA=
X-Google-Smtp-Source: AK7set/cxR0/eAjzleskHhfSoQu2RD9gL5LADxWDLN0bUHMihppM9YQuQCwt+QYvbb1B8/1y+Au8+A==
X-Received: by 2002:ad4:5961:0:b0:57d:747b:1f7 with SMTP id eq1-20020ad45961000000b0057d747b01f7mr22213329qvb.1.1679261929455;
        Sun, 19 Mar 2023 14:38:49 -0700 (PDT)
Received: from epic96565.epic.com (097-091-065-227.res.spectrum.com. [97.91.65.227])
        by smtp.gmail.com with ESMTPSA id d185-20020a37b4c2000000b007425ef4cbc2sm6059011qkf.100.2023.03.19.14.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 14:38:49 -0700 (PDT)
References: <pull.1471.git.git.1679153586903.gitgitgadget@gmail.com>
 <CAPig+cQ+__c0CVspBgVxcGrzj8AnJJKKaQr-ofT4oLS-C-bQtw@mail.gmail.com>
User-agent: mu4e 1.9.22; emacs 30.0.50
From:   Sean Allred <allred.sean@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Sean Allred via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Subject: Re: [PATCH] Document the output format of ls-remote
Date:   Sun, 19 Mar 2023 16:36:24 -0500
In-reply-to: <CAPig+cQ+__c0CVspBgVxcGrzj8AnJJKKaQr-ofT4oLS-C-bQtw@mail.gmail.com>
Message-ID: <m0ttyg8lqw.fsf@epic96565.epic.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Eric Sunshine <sunshine@sunshineco.com> writes:
>> +The output is in the format: '<SHA-1 ID>' '<tab>' '<reference>'.
>
> The angle brackets in the '<foo>' notation indicate a placeholder,
> however, in the output, TAB is literal, it is never replaced with
> something else. So, to be more accurate and less confusing, we should
> instead say:
>
>     The output is in the format: '<SHA-1 ID>' 'TAB' '<reference>'.
>
> I understand that you copied '<tab>' from git-show-ref.txt, but we
> don't need to replicate that mistake.

I too found that odd. I took inspiration from git-rev-parse.txt for the
next iteration. I've pushed that to my branch (which you can fetch if
interested), but I'll wait another day or two for more review before
resubmitting. (I took the liberty of fixing git-show-ref.txt as well.)

> Moreover, these days, we support hash algorithms beyond merely SHA-1,
> so the first placeholder should probably talk about object-ID instead:
>
>     The output is in the format: '<OID>' 'TAB' '<reference>'.

Good call; I've made this update and it will be included in the next
iteration.

--
Sean Allred
