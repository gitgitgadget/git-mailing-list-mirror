Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE058C7618E
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 14:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjCQOTX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 10:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjCQOTW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 10:19:22 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D31449D5
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 07:19:00 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id f18so6683893lfa.3
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 07:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679062738;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v/OHT66jH98OH27AWEG+mVNW8U/gCuOVh/yiOID0fnk=;
        b=SCHwl6kwP8LVBwAIQw8dHeV5u0h4c40I1l1MRscxqvxUiCdYR/lDyDKiJ1JvpUiXCA
         TetILULxY1nmBACX0x8SUhSrDR5+PVD1ijAoBK+87bt62OBpf4j1dcWskIlSEK0Djt/9
         MBYSQQk9OHbrnpDx58JRnHaywv58tF9YDFMVCbA0v95o190l10/NPQiiYCHZbKNtaoDw
         w8ixVTW4jlVALz/KGOYkvuBcA/e2uTW0vR/X7xgwp7qLlI4vxpyeB4DicNgIr0U3dGej
         dsolSNlLKdcQsJVHf4Lc04LlPXiODiDC+dFu4j1K/uMyDBFEANrebV2i8S+Jf4H3SEye
         4boA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679062738;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/OHT66jH98OH27AWEG+mVNW8U/gCuOVh/yiOID0fnk=;
        b=0Q3oJKhJzbSD+ipwJ3dNc7ysZW0uPfe+lN8K9oBA4vZEHX3oB0bdzDL16mocDw7l5K
         IITEHWW60FlpLmq5KZ8gj1fq8j7/ArHjknwTLjHmT3zRMU+AMXUWPtxhVM/IhdMDHf3H
         anAMWdlEsmcDjWeN+1aNrGgINBeJPnmdfef8z+kM25V6GHmtfdvWdIPtr1NH6iofGAix
         M8QQSMSWQ3sP25d2sFKXD5eXNwgk4r2fzQrnh1qUj5JzB3AX/PNG23jdi3xz1NNiQHVA
         xOq0XG8An0D8yVITbGJ5hp2sKvWQARZmSDZdFYK3xyK//gpGgobLXFyByd1vtQ1a0X8t
         inPA==
X-Gm-Message-State: AO0yUKVpZdcOmRrzrvERvSg6kBIezl962aRV5xr7lpm7p2971aTjOksE
        MLK9MQdkoUAsXUs56z1yBRKh1wQrL+dCEw==
X-Google-Smtp-Source: AK7set93ILvPnE8AGdZOOXcA5DXu69nZUaT1wo1z+I/6lHkEhEgDaOggU9KUOcgP40qQFJfDlx5QAA==
X-Received: by 2002:a19:ac03:0:b0:4db:387f:a3af with SMTP id g3-20020a19ac03000000b004db387fa3afmr4456302lfc.4.1679062737883;
        Fri, 17 Mar 2023 07:18:57 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f13-20020a19ae0d000000b004d291dcee7fsm409942lfc.55.2023.03.17.07.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 07:18:56 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: so/diff-merges-more (was Re: What's cooking in git.git (Feb
 2023, #01; Thu, 2))
References: <xmqqr0v7o0pp.fsf@gitster.g> <871qn5pyez.fsf@osv.gnss.ru>
        <kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com>
        <87wn4tej2f.fsf@osv.gnss.ru>
        <kl6lh6v43s4g.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqr0u7ku3j.fsf@gitster.g> <87wn3zqefx.fsf@osv.gnss.ru>
        <kl6lzg8pcygl.fsf@chooglen-macbookpro.roam.corp.google.com>
        <878rg8j2vg.fsf@osv.gnss.ru> <xmqqzg8ozbuh.fsf@gitster.g>
        <87jzzqzy20.fsf@osv.gnss.ru> <xmqqzg8mrgc8.fsf@gitster.g>
        <874jquxc67.fsf@osv.gnss.ru>
        <kl6lh6uthlc3.fsf@chooglen-macbookpro.roam.corp.google.com>
        <878rg5vgvc.fsf@osv.gnss.ru> <xmqqjzzo46tv.fsf@gitster.g>
Date:   Fri, 17 Mar 2023 17:18:56 +0300
In-Reply-To: <xmqqjzzo46tv.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        10 Mar 2023 13:47:24 -0800")
Message-ID: <874jqj31gv.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> 1. The fact that -m does not imply -p is a mistake. There is no any
>>    reasons this exact behavior could be useful. As such, it does not
>>    make sense to support this exact behavior in --diff-merges. So the
>>    reject of --diff-merges=[no-]hide.
>>
>> 2. This mistake is too dangerous to fix due to subtle compatibility
>>    problems, so we can't just fix -m behavior. Thus the reject of my
>>    earlier patch "let -m imply -p".
>>
>> 3. Moving behavior change under option is not worth it, as nobody
>>    presumably needs this fixed -m behavior anyway (at least among 2
>>    persons that are actually opposing the changes). So the reject
>>    of "add diffMerges-m-imply-p configuration option" patch.
>>
>> 4. Staring in the face inconsistency between -m and the rest
>>    of short diff-merge options is not significant enough to reconsider
>>    any of the above rejects.
>
> I do not quite understand the last one (#4),

Well, -m does not imply -p, whereas the rest of diff-merges options
(-c/--cc/--remerge-diff) do imply -p. This is what half of this
lengthy discussion was about.

> own 4., it would be that introducing --diff-merges={kind} may have
> been a mistake.  It would have been fine and better to just let
> users choose from whatever set of options we support, i.e. (-c,
> --cc, --remerge-diff, -m -p, -m --raw, ...).
>
> IOW, perhaps deprecate --diff-merges={kind} and eventually remove
> it, if we could.

Why? Unlike -m vs -c they are at least self-consistent and besides allow
to get the output that those short options do not.

> We've been fine without it and we'll be fine without it. Unfortunately
> it may be a bit too late for that, but it certainly is much younger
> than "-m".

I, for one, was never fine with what Git does to show diff for merges.
Then, taking into account that introducing of --diff-merges was not
my idea in the first place, there should be at least two of us here
who were not fine.

It's fine with me that --cc is everything you need, but what I need is
rather diff to the first parent, and I had a hope to finally get -m to
do it, aiming both for consistency and convenience. My 2 attempts
performed in different ways both failed, so, being tired of it likely
even more than you do, I digress.

Thanks,
-- Sergey Organov
