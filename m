Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54F7C05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 21:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjBFVgG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 16:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBFVgE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 16:36:04 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112A9193E9
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 13:36:03 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id mf7so38202770ejc.6
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 13:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tt9uXmVuhIdHgic8BRfu98E9yhrIBciSWATt3alLviA=;
        b=R3JtON3wN0EY8V7xYHicTKORgADUL4joXjXsV0/GNq23NMdw+ev4j/uxYmSR/Vu10D
         19Tx51tr61e4LUMojowA8dF3TXqN/soN4loGpB++lScQMUo4Ih01YRXJFP0zeAMx0k49
         I02d5u/3I9UOqTdPGnfXn+JE0aqQRvfnv6RSJHlMCnywMZOpsVTchfxmgWutfPV7CBkw
         oXBdz4cUaMz7w/6PboEmlSbGcBT7CHwHpVRpsaFXBnEgwULtMrAmbLAZV2smXpedeGQH
         ujEA7TwZQTF5WlUhUWpXbY7QTKgFibl1i2lKBKzkE4aTnXbCxEqqt8VAOvQRWVODvdYs
         WEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tt9uXmVuhIdHgic8BRfu98E9yhrIBciSWATt3alLviA=;
        b=Hmy4ZT32OARBcl3AtTxq7fpvov82TV8jiI0hYMkwQQT8Dv04IjzgzdKwgc29mCxv63
         n+8nYGWWuviWU5akIvSKZCYRywofqsC6zGLWpu7UCEGfAcOIT2gkujVtp6M2hEMDaBVG
         GaoV9itRlVnQGELsc3xfmbdLr745fALGx+vcaH0NOSzVyOKvk/+opYBi+fnUwAIEiyt3
         tdT8Oykla4jXlOX1CXfWHhiJjX/IGl/AEeI3tXyiiuJWoldSvSygP3fZyRVfocaEcPs8
         Xvc4FbqHqTologr1VoBolUGJis12gix/lM8B3qge6LpcIvMMbe2N7JfapHZ+DtlLzTfO
         bheQ==
X-Gm-Message-State: AO0yUKWZuHoGuMaNdfEdYPcOo5nvKhT2uzhonshscwY3POAawqpZxf0X
        OwR/FOlx/B6CdzpNekU36pNyhkVNGlKmtw==
X-Google-Smtp-Source: AK7set+IgSyhyxys5mkxJzqW8S3AVSJ5g8MHVVi/yluraxkFMN83EcGWvLN5KNYu3UEhpEkwBVb/Jg==
X-Received: by 2002:a17:906:595a:b0:88c:f7f6:bf59 with SMTP id g26-20020a170906595a00b0088cf7f6bf59mr867927ejr.17.1675719361121;
        Mon, 06 Feb 2023 13:36:01 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id es26-20020a056402381a00b00488117821ffsm5628542edb.31.2023.02.06.13.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:36:00 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2023, #01; Thu, 2)
References: <xmqqr0v7o0pp.fsf@gitster.g> <871qn5pyez.fsf@osv.gnss.ru>
        <xmqqedr28wwb.fsf@gitster.g>
Date:   Tue, 07 Feb 2023 00:35:59 +0300
In-Reply-To: <xmqqedr28wwb.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        06 Feb 2023 10:35:32 -0800")
Message-ID: <87357ischs.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>
>>> * so/diff-merges-more (2022-12-18) 5 commits
>>>  - diff-merges: improve --diff-merges documentation
>>>  - diff-merges: issue warning on lone '-m' option
>>>  - diff-merges: support list of values for --diff-merges
>>>  - diff-merges: implement log.diffMerges-m-imply-p config
>>>  - diff-merges: implement [no-]hide option and log.diffMergesHide config
>>>
>>>  Assorted updates to "--diff-merges=X" option.
>>>
>>>  May want to discard.  Breaking compatibility does not seem worth it.
>>>  source: <20221217132955.108542-1-sorganov@gmail.com>
>>
>> Hi Junio,
>>
>> This does not break any compatibility, as far as me and I believe
>> reviewers of these series are aware.
>
> The last paragraphs in the review two months ago still describe what
> this series does fairly accurately, I think.
>
>     These patches do look like a good approach to solve the first point
>     among the "two problems" in the previous round. Thanks for working
>     on it.
>
>     IIRC, the previous round (why is this round marked as v1, by the
>     way?) was reviewed by some folks, so lets wait to hear from them
>     how this round does better.
>
>     Unfortunately, I do not think of any "solution" that would avoid
>     breaking folks, if its end goal is to flip the default, either by
>     hardcoding or with a configuration variable.  IOW, the other one
>     among the "two problems" in the previous round sounds unsolvable.
>     We should question if it was really an "issue" worth "resolving",
>     though.

Well, we may end up flipping or not flipping the default (even though
I'd prefer we indeed do), the series are still valid either way, as they
allow *me* (or anybody else who prefers more useful '-m' behavior) to
flip the switch for myself, locally.

Also, the only patch that got some resistance from reviewers has been
removed from the series, so I don't see anything left that'd prevent
this from being merged.

From my POV the only remotely questionable patch is:

- diff-merges: issue warning on lone '-m' option

and I hereby agree to remove it if it feels wrong to you.

Let me state it cleanly: once these are accepted, I'll turn
log.diffMerges-m-imply-p on for myself, and will suggest it to others
who already asked about '-m' inconsistency, or will ask in the future.

Thanks,
-- Sergey Organov
