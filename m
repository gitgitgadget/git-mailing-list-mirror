Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45872C76195
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 16:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjCVQsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 12:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjCVQsj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 12:48:39 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9A739B93
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:48:38 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id le6so19806154plb.12
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679503718;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ecpsrc9JHHR8sXiJ6j6VIJCOEayxuCmp4FS6Ks7Pvo=;
        b=LZz8b5+XEjgYvkRfjTaPjBEKFUIv8c2lzpYfxoHPhXEY48HjFIJc/eBxvqDhg9Rgeu
         8yVvTCaySiCvjeL8zHAiPNIWAlx4AYqJiRyZCEhCGHouf8Jar3K+WaXmpBxcaUCcY3Dc
         h+0hVEK5SUw3R+oPtpQfSFFrF/QAGSE1/2gDzMT6muUxElVOk7N//Lvv6R3rePDHdCIH
         EorJoN2nnz5aEMPDJPe172bkvZossj39gP7wOydVUluuYpFPvO29QtFR50cuosRCSaOQ
         YGU/AhyF606a8WBZKXAaOJf8rpM0yHAPdiHXZJ+ziW723rl8y1v74BwETB3JwwwnLnli
         zCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679503718;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9ecpsrc9JHHR8sXiJ6j6VIJCOEayxuCmp4FS6Ks7Pvo=;
        b=79alNONnNCIlLvkiPbqL3IjE0o03N3Fr++Leq12mNibWrNYXD/hWMJGwHyR93EYp8J
         DURp9XI5Zv8gWL+c+DlPrLJdwhvcdLrXXIS7EEoNGiP0Ik5Sdb9seZ6gWvUjpZO7vRNa
         usTHox5X1knMjSiV7w7w7CJcIBjywTIykQ6xPG2KfnO1Yj4mRF9TAW6YDHm/2S10idV5
         HVAq5TYd7Nn734vRta8zB0fMQVIEvRvBabRZXyfkhIOULqVjhpl4D8irywN4XxoKEaTd
         hQgRpEV6REzD01x30lf0J70UTKUVpDQj69SwCm2IjzjZaX34O90g7jVV+W9JKjOKMzl3
         DcBQ==
X-Gm-Message-State: AO0yUKUA6EVFv6FceSSlBmrXYpJrW1YroxefZNmrycxy+xEnnC3u5A1K
        B2PZKwNAkTlRZoxrIf9t+2IzhFyuyio=
X-Google-Smtp-Source: AK7set/MulU0hUw7I1rl89TICDt/y6SKH1HfBGXAUnKJoEkiObVgYxhC+zCM0NmxXMqHI+SXKrLgSg==
X-Received: by 2002:a17:90b:38c3:b0:23c:6713:45b3 with SMTP id nn3-20020a17090b38c300b0023c671345b3mr4512734pjb.7.1679503717678;
        Wed, 22 Mar 2023 09:48:37 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id d61-20020a17090a6f4300b0023a84911df2sm9926133pjk.7.2023.03.22.09.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:48:36 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Subject: Re: [PATCH v2 2/2] Document the output format of ls-remote
References: <pull.1471.git.git.1679153586903.gitgitgadget@gmail.com>
        <pull.1471.v2.git.git.1679478573.gitgitgadget@gmail.com>
        <44e79f0d69c86e3cf4363aaa10acda91bfa3e9ee.1679478573.git.gitgitgadget@gmail.com>
Date:   Wed, 22 Mar 2023 09:48:36 -0700
In-Reply-To: <44e79f0d69c86e3cf4363aaa10acda91bfa3e9ee.1679478573.git.gitgitgadget@gmail.com>
        (Sean Allred via GitGitGadget's message of "Wed, 22 Mar 2023 09:49:33
        +0000")
Message-ID: <xmqqy1noenq3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sean Allred via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +OUTPUT
> +------
> +
> +The output is in the format:
> +
> +------------
> +<OID> TAB <reference name> LF
> +------------

It seems that

$ git grep -i '<OID>' Documentation/

everybody spell the object identifer as "<oid>" in lowercase.  TAB
and LF are better left uppercase.

$ git grep -i '<ref' Documentation/

says that we never say <reference name>.  Almost everybody would say
<ref> here (and that curiously is what glossary-content.txt has---it
feels a bit funny to have "ref" not "reference" there, as the former
looks as if it were an informal abbreviation of the latter, but
'ref' seems to be the offical name of that thing).

The documentation for "show-branch" uses many <reference>s in the
description, which should be updated to match what its SYNOPSIS
section uses, which is <ref>.

> +For example,
> +
> +----
> +$ git ls-remote
> +950264636c68591989456e3ba0a5442f93152c1a	refs/heads/main
> +73876f4861cd3d187a4682290ab75c9dccadbc56	refs/heads/maint
> +d9ab777d41f92a8c1684c91cfb02053d7dd1046b	refs/heads/next
> +74a0ffe000da036ce4ca843d991a7c6b8c246a08	refs/heads/seen
> +860bc4360c4fcba0fe2df942984d87f8467af3df	refs/heads/todo
> +d4ca2e3147b409459955613c152220f4db848ee1	refs/tags/v2.40.0
> +8810a79228a149a9773bf9c75f381fca27a6a80e	refs/tags/v2.40.0-rc0
> +f899c182d0bffb6e915da7c8db9be202b144c098	refs/tags/v2.40.0-rc1
> +6bed3304b2b2f1cf440ca3050b57a7cf3a3fe687	refs/tags/v2.40.0-rc2
> +----

Do we really need 9 lines of output to help readers understand the
output?  I somehow feel that it would not add any clarity for the
readers to add more, when we already have 2 of the same kind in the
list, and it smells even more excessive to give more than 3 of the
same kind.

Oh, isn't it even worse?  I see an EXAMPLE section that gives a
similar looking output.  Do we need to add one more in a separate
section?

What is curious about your "example" is that usually the first entry
we see in the "ls-remote" output is for HEAD.  Another curiousity
that is shared between yours and the existing examples is that
annotated tags should show their peeled representation, but the
examples are not showing (I suspect that existing ones were
documented way before we show peeled tags).  For reference, the
output of running the command against my kernel.org repository
starts like so:

    $ git ls-remote ko
    27d43aaaf50ef0ae014b88bba294f93658016a2e        HEAD
    27d43aaaf50ef0ae014b88bba294f93658016a2e        refs/heads/main
    73876f4861cd3d187a4682290ab75c9dccadbc56        refs/heads/maint
    27d43aaaf50ef0ae014b88bba294f93658016a2e        refs/heads/master
    c903bb7e22f8f86da64de537e5768ab0ca886f4b        refs/heads/next
    29b7b507b4e8ff04bf912512bb466ea39805b9e5        refs/heads/seen
    860bc4360c4fcba0fe2df942984d87f8467af3df        refs/heads/todo
    d5aef6e4d58cfe1549adef5b436f3ace984e8c86        refs/tags/gitgui-0.10.0
    3d654be48f65545c4d3e35f5d3bbed5489820930        refs/tags/gitgui-0.10.0^{}
    33682a5e98adfd8ba4ce0e21363c443bd273eb77        refs/tags/gitgui-0.10.1
    729ffa50f75a025935623bfc58d0932c65f7de2f        refs/tags/gitgui-0.10.1^{}
    ...

So,

 * correct <OID> and <reference name> in the format description.

 * describe that <ref> in the output may be followed by ^{} to
   show peeled representation of the preceding tag.

 * update existing examples to show peeled tags.

are what I found missing in this patch.

Thanks for working on improving this documentation page.
