Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65570C64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 19:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjCHT2B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 14:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHT17 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 14:27:59 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DF2212B
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 11:27:54 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id x11so14161568pln.12
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 11:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678303674;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RzcASvaiZq/lM6gLLdJTNryQ2ty1opHbEKOGlp2kZ8U=;
        b=mVQkOSz2F5uydF1dcTjAl+eDit6Y2YE7W6+SF0jKUzIhhRKssB9AV3uhW75lp2OTeI
         u+7e+DCjCuP4/yafKuhUvst5dw3FVWMnMgNTQE2lYuC2PoXn1knmTbE4ahjjieqCVUKz
         lpzB9UWPk0dNgRKcW/HcJZ4gDqr5QsG7udmAGrIBPfKSxhxSE1FfN4btwzC5YGjXrpyD
         GoA8TFUttiM4L8qjNGk9XfI+hMJeFmJgaZv6VhsbVZ4IE2dhT/8RVLp85a9NPaI3XFCY
         +PwmkZIfXrCH/8f2T1871xsIAJkQDmIeJSrmwDRAKJz8JynPDtEU04C6v7zGkLaOL9z4
         PzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678303674;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RzcASvaiZq/lM6gLLdJTNryQ2ty1opHbEKOGlp2kZ8U=;
        b=UZuYzBvIIhZgrCPLSPh8FBYUPwpwSuJvdSIZlFPyffs069+MdWX/OjR9dcqkzRA2qH
         b9ncHxb2lyYJzIsmxxwaLLeW4VDFTmHIY/37bbi218LWkMYR4/Pm6jrWYUvtQnWkcuub
         1Dyoudhq/odSwYCurfgvMa4wXrNZgDKsMa9viik9A5NzEnQFRrZ4FZlFX+NZrbCmXpXu
         nbpQYS7wuQOrnYN1InM0BynMyU1gbxFlI+OnY/32Z5ygkkuBnVqufyuORUX1l1YSZGKo
         0/9FBWZY0q6i/SD+CjANXhBheXNnv/wzGrcJAmGHZiw1VTdgFtEJC3hy5az3tGjQH2oW
         x2FQ==
X-Gm-Message-State: AO0yUKWByEITqKrZuNPbOTfuKXf2zySOft5eG/evTdlDbgf0WioN7BcS
        0F1jn8i+4qip0DxLD7hgzjI=
X-Google-Smtp-Source: AK7set8wqPi/moqxZjJ2k7U55+dXTIKDb68DXxOGZKRrr7szXdDruhlhV2fwlh9+F32kd6Pc/TNJoQ==
X-Received: by 2002:a17:903:2290:b0:19a:c65d:f90 with SMTP id b16-20020a170903229000b0019ac65d0f90mr24242297plh.44.1678303673845;
        Wed, 08 Mar 2023 11:27:53 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id ks16-20020a170903085000b0019a8530c063sm10114840plb.102.2023.03.08.11.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 11:27:53 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "William Sprent via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        William Sprent <williams@unity3d.com>
Subject: Re: [PATCH 1/2] builtin/sparse-checkout: remove NEED_WORK_TREE flag
References: <pull.1488.git.1678283349.gitgitgadget@gmail.com>
        <4b231e9beb43e4fac6457b9bf86e4c1db39c4238.1678283349.git.gitgitgadget@gmail.com>
        <xmqqmt4nt8k3.fsf@gitster.g>
Date:   Wed, 08 Mar 2023 11:27:53 -0800
In-Reply-To: <xmqqmt4nt8k3.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        08 Mar 2023 10:14:04 -0800")
Message-ID: <xmqqilfbt552.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> But you did not find a place the feature you wanted to add with
> [2/2] would fit better, perhaps, in which case, somebody else may be
> able to suggest an alternative in their reviews of that step,
> hopefully.

... oh, or perhaps the list would reach a consensus that mixing a
subcommand that does not require a working tree is not all that bad,
which I am personally OK with, too.  I didn't at all mean to say:
"this shouldn't be a subcommand there, do it somewhere else".

Thanks.
