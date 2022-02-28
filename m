Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58099C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 13:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbiB1Ns1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 08:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiB1Ns0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 08:48:26 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1401EC72
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 05:47:47 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id f8so5532255edf.10
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 05:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=wobL1E9PuJJoukGQWm7tOiNkHm0SzZZcP1PfxEtl/eM=;
        b=c7tObQxxtNnzwC5R2PHYrF6wBdjt5aAwsQ96fGxgnqjCJmTq+9em2T7Bcw8tMLDfEj
         mO1ZEDo4Wv1MxMqwcxctZxV3knWxvAVOzeiGvb9yJAC6BtUReQIU/vlMh0ghT4i7iphx
         2aTSZb1yg/ut3Lc4CmsMJMh6adO8qWDt420Jn1gJmpKmZnXX3v89olBFKxTPbt5v5d9a
         rgJ0eqZiEuJcdZ4Q4h14AILehK8mZmfA61r3ijpkXjXS/LVDQg/ZZG8+iaipcCu8hNLE
         yYJdKCh2dCmZxWKbW7Iq03AaeMda3fOFVMfTie3NA3QghoErd37jnn47U7PPyJo6+gyy
         zTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=wobL1E9PuJJoukGQWm7tOiNkHm0SzZZcP1PfxEtl/eM=;
        b=VhmW8k11IT68QCZkXreas99novWWR5KTHzrMCc+G2C4iXGkkxOV/9w9t5W9xR1XD5d
         splt4/BWpw733+mnk8oTqFx1YhIHADbL0U4s/90PsKNMSVu1ppS59zdPqUvn1oKvde6K
         EMU5Wciza8D5dzuAJpwjY2Wz/qCK95rt09EQwyUaYThFO5ETt2QITvI884DQKoP27YPr
         LPyODasFix5ogbABlIO4kEp30dZbzSD9/h3uUJ4Jl4urZHJzs64DDXRbeoWJt3JfWRhu
         TNAz7CUrw9oLyE/45+UnrhIssuGgycrlzPRRA/eo5FMnH8ToyxFxuYX5esOz6Ovay4Ve
         WJXg==
X-Gm-Message-State: AOAM532HjjjiXezWPTiW+aPILRpJLOwetzCcpNmza99DRfvWNt+RcA0z
        I2KH2n6Lfd+ePls3N1G4TiI=
X-Google-Smtp-Source: ABdhPJxF+AYx38sMtJSvfVlfmu6iooMPwH8Zpa8NTTpL+biChqI50rejP3Pm9dBxZVybVOtTAvqXXQ==
X-Received: by 2002:a05:6402:3593:b0:412:53e6:431 with SMTP id y19-20020a056402359300b0041253e60431mr19590990edc.8.1646056065901;
        Mon, 28 Feb 2022 05:47:45 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906008a00b006cef3a1f6c3sm4348049ejc.185.2022.02.28.05.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 05:47:45 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOgNM-001NF7-TX;
        Mon, 28 Feb 2022 14:47:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2022, #07; Fri, 25)
Date:   Mon, 28 Feb 2022 14:42:18 +0100
References: <xmqqee3q73e1.fsf@gitster.g>
 <CAPMMpojgTcp7qGmpK0vm8_WTOaSJ6r=NBa3sEO0EC7XRBF_dXg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAPMMpojgTcp7qGmpK0vm8_WTOaSJ6r=NBa3sEO0EC7XRBF_dXg@mail.gmail.com>
Message-ID: <220228.8635k35chr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 28 2022, Tao Klerks wrote:

> My apologies if this is not the right forum for commenting on these summaries;
>
> for tk/untracked-cache-with-uall, I believe the current description is
> misleading:
>
>> The untracked cache system does not work well when the setting of
>> status.showuntrackedfiles is 'normal' and not 'all', which has been
>> updated.
>
> It's almost exactly backwards, in that the case where untracked cache
> gets bypassed is when you specify "all". The "what we do" section is
> also slightly overambitious as the fix is limited to improving
> performance / supporting the cache when runtime flags are consistent
> with configuration, which will improve a couple cases, worsen one
> specific and (I believe) rare case, and not change most.
>
> If I could reword, it would look something like this:
>
>  The untracked cache system is bypassed when a command runs
>  with the "showuntrackedfiles" flag set to "all" via config or arguments,
>  because untracked cache content of "normal" is incompatible with
>  "all" and vice versa.
>  Instead use it whenever runtime flags are consistent with
>  configuration, so that frequent users of "-uall" can get consistent
>  performance by setting status.showuntrackedfiles config to "all".
>
> This is quite verbose, but I can't figure out how to condense the concept
> further.

Perhaps something like this:
    
    The performance of the "untracked cache" feature has been improved in
    common cases where "--untracked-files=<mode>" and
    "status.showUntrackedFiles" were combined. This change benefits Windows
    users using it in conjuction with the "fsmonitor feature in particular.

Perhaps adding:
    
    There's an obscure case where the performance is now worse, but it's
    thought not to matter.
    
I guess al of that is somewhat equivalent to an even less verbose:

    The untracked cache is [mostly] fasterer, don't worry your pretty little head
    about the details.

:)

I.e. it's trying to avoid going into all the details.
