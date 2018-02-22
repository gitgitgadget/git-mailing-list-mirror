Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B79871F404
	for <e@80x24.org>; Thu, 22 Feb 2018 18:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933675AbeBVST4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 13:19:56 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38008 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933504AbeBVSTz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 13:19:55 -0500
Received: by mail-wm0-f67.google.com with SMTP id z9so128065wmb.3
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 10:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gU+4xZtoo3AviGtozdO/9YjFdLlBwDKAkOlUxd0lL+U=;
        b=LgxxRTMckwYghhtOT6H9p2uMLANT70xUB8IYUp0Anbe2rzptmQ9MvIq2hEoVrVTeKi
         o/8Gp0AE9V9iCTEBXx90jsjFL9nsuHV4mcFDlRU5PBtEQ5gveuuL6pILt/wnAnKEL1pr
         8bOqbyhLo8vR4k0b4V4EtCEe25XHVdIgN0dYWSdV/qgK2tfSBGTuzHsz7WspI82L9Q59
         +RA6o8lWYHy8hKYjUgg9xcapjbJ+Bx511DcV+szJVEyO5y5hO3CweY8nes+riyFq6NLa
         l+NdgrhfEf7qcI8IEMoP/Yin7a3bxJJ0TTf/YBeyougF+va6nN2R6HKjp1b6yUqDoU1/
         HmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gU+4xZtoo3AviGtozdO/9YjFdLlBwDKAkOlUxd0lL+U=;
        b=Q5Ckzj1ZnRPtInwx8GhsinYB18UqFid8Y1PUOSE8IQHMGElF6nssCKVgS3fqtJltyI
         tGpAoOqwTorP8sBSxxhZeGykhjwLSk9VqVnQY7enRyrCHJD3Bztnl+qrxLSmdf7dcYB6
         dLo92B5ejhilsAga7DJomCAtarHjHGqi6/gk0sqDWmVi1woha4N8e+oYUEm+CTdFz39N
         /FC/9g7saVqUw+6cp4B3ZbphvUc5DCQvnIqr/ms36Kv36itnnDHc2CgVXETRutYCv75c
         hdaL1vLULSwE/qdH5/uV/kTd1W21cv26yLzAgxx1N8eSaybvVvE0IcrVEI0Gn7/9eHOM
         b6uQ==
X-Gm-Message-State: APf1xPCMpDsRxLFMkRrqbdUDgye92562mjF/yNbx9DSP+Mp13bqtSeai
        4BuDZFF72kmrtEHHK4aFyz8Svc/j
X-Google-Smtp-Source: AG47ELvrEN3zy7EyeAqFONc59UjLUZtRZsDgUKIznJn0QLKKCqJI7uphZ6wpNazieSYdCmr5EUlfZA==
X-Received: by 10.28.130.72 with SMTP id e69mr90691wmd.50.1519323592451;
        Thu, 22 Feb 2018 10:19:52 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q186sm30646wmb.33.2018.02.22.10.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 10:19:51 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 06/42] completion: use __gitcomp_builtin in _git_am
References: <20180131110547.20577-1-pclouds@gmail.com>
        <20180209110221.27224-1-pclouds@gmail.com>
        <20180209110221.27224-7-pclouds@gmail.com>
        <CAM0VKjmFEyr4qHdc1qfW0M_RZ7cM9bCfsn-M4Rapzt6CPhZE1g@mail.gmail.com>
        <CACsJy8CWdJJigQSEjGuhoH1URGY8=YSAHiqhaGBZK7Zr8GZUGg@mail.gmail.com>
Date:   Thu, 22 Feb 2018 10:19:51 -0800
In-Reply-To: <CACsJy8CWdJJigQSEjGuhoH1URGY8=YSAHiqhaGBZK7Zr8GZUGg@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 22 Feb 2018 16:13:51 +0700")
Message-ID: <xmqqsh9sx4xk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Now that you mention it, the only command that completes
> --rerere-autoupdate is git-merge. Since this is "auto" I don't think
> people want to type manually.

Sorry, but I do not quite get the connection between "since this is
'auto'" and the rest of the sentence.  Is it just it is so lengthy
that people do not want to type and are likely to use completion?

> Maybe I should separate these changes
> _and_ remove --rerere-autoupdate from _git_merge() too? At least that
> it will be consistent that way.

Hmmmm.  Why not complete this option?  Is it because the current
completion script does not and we are trying to preserve the
behaviour?  I do not have a strong opinion either way, but just
trying to understand the reasoning behind the choice.

>>> diff --git a/rerere.h b/rerere.h
>>> index c2961feaaa..5e5a312e4c 100644
>>> --- a/rerere.h
>>> +++ b/rerere.h
>>> @@ -37,6 +37,7 @@ extern void rerere_clear(struct string_list *);
>>>  extern void rerere_gc(struct string_list *);
>>>
>>>  #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
>>> -       N_("update the index with reused conflict resolution if possible"))
>>> +       N_("update the index with reused conflict resolution if possible"), \
>>> +       PARSE_OPT_NOCOMPLETE)
>>>
>>>  #endif
>>> --
>>> 2.16.1.207.gedba492059
>>>
