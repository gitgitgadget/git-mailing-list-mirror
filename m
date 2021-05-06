Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574AAC433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 10:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1357661207
	for <git@archiver.kernel.org>; Thu,  6 May 2021 10:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbhEFKIZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 06:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhEFKIY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 06:08:24 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3071C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 03:07:25 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l4so7388300ejc.10
        for <git@vger.kernel.org>; Thu, 06 May 2021 03:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=DX/LK8nUpkG/vGBwZdA6p93mdAArDlMJKZaE4pqbQOk=;
        b=Gk58f6xhToXDRjPZtUSii5fjQKqUUTP8tNkFEbf/7LZC+R+57t5WooWadZC7mOxikT
         EFqqksoXTeqCQ4/tP1pJeYDLIcq+46BScGhvwD2MVHIiMUvGdaRTNHf+VHpIZoJ8fW79
         FXX9tJH/qwNJfevknzi1eyYeYY/7verWyyMLmrgL8n5LQt3HNqml4sMhPmKpYczsWPwB
         mLTX1M13TMzP+xvzmQ62f7/gqYIuM4BQwLo0hP5vkE6QitgltAfhI4uI/r2U0qgh+Q+7
         rFU5ocNsbN0SOep4pu06YYkmg6Ed91uURGH9NLZ71e0hM7Qua8Qr1tODoWeJBvChNyAb
         5EBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=DX/LK8nUpkG/vGBwZdA6p93mdAArDlMJKZaE4pqbQOk=;
        b=APbshClQbTm61lBSs86Exw6UXXRpVsd8k1CBGFBGJqUXwDyzVIWzlYOsvYNc4Y3Rf2
         VHOrMjza1X7gSYzOjVpr13NvvySN0jVq85I2c/GeE9nfDwGS/A/0AY4E6DR6wIDVzmA/
         QxkkZ/fCHLZmKoh6l1j4wMrWGFHmAXHaJ7SMnN5V+nYpA1o9n7QLs44TPVe6MNU6Bpjy
         tdEBk1diBb9e4TQagG7mqo+sv+yBH40Y+PEKtQzKmw6F6jcO99iakjAV+QgvIPz5VtFC
         BpCK+SLvU1h6jhNqoSumUC2GAhn498LHumutjo13TRn5UQhFAUjto0uUQ8m7KsEUuv6C
         2Csw==
X-Gm-Message-State: AOAM532yFsHkpg1xIJBWZksX3sxGDYknJluC74wftg1OJ/AU5P+Q+AW/
        8laSYb//1z9X8eqwGgJP2FY=
X-Google-Smtp-Source: ABdhPJwtMKo7sgNNeE9aj2hKViTFcBEFzf7H08qsweE5bT/TcckOisfEXKpkXrTV2WYYOjkW/X1WIw==
X-Received: by 2002:a17:906:f283:: with SMTP id gu3mr3502499ejb.91.1620295644613;
        Thu, 06 May 2021 03:07:24 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id qu23sm1082058ejb.1.2021.05.06.03.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 03:07:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        =?utf-8?Q?G=C3=A1bor?= Farkas <gabor.farkas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git switch/restore, still experimental?
Date:   Thu, 06 May 2021 12:05:23 +0200
References: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com>
 <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com>
 <877dkdwgfe.fsf@evledraar.gmail.com> <87sg3155dt.fsf@osv.gnss.ru>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <87sg3155dt.fsf@osv.gnss.ru>
Message-ID: <87mtt8uqec.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 05 2021, Sergey Organov wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Tue, May 04 2021, Elijah Newren wrote:
>>
>>> On Tue, May 4, 2021 at 3:36 AM G=C3=A1bor Farkas <gabor.farkas@gmail.co=
m> wrote:
>>>>
>>>> hi,
>>>>
>>>> the "git switch" and "git restore" commands were released two years
>>>> ago, but the manpage still says "THIS COMMAND IS EXPERIMENTAL. THE
>>>> BEHAVIOR MAY CHANGE.".
>>>>
>>>> i'd love to use them, but this warning gives me pause, perhaps i
>>>> should wait until it stops being experimental, i worry that it might
>>>> change in behavior unexpectedly and cause problems for me.
>>>>
>>>> considering that they were released two years ago, could the
>>>> experimental-warning be removed now?
>>>>
>>>> thanks,
>>>> gabor
>>>
>>> This probably makes sense.  The author of switch and restore isn't
>>> involved in the git project anymore.  He decided to work on other
>>> things, which was and is a big loss for us.  I think others (myself
>>> included) didn't know all the things that might have been in Duy's
>>> head that he wanted to verify were working well before marking this as
>>> good, but these two commands have generally been very well received
>>> and it has been a few years.  Personally, I'm not aware of anything
>>> that we'd need or want to change with these commands.
>>
>> I am.
>>
>
> [...]
>
>> And:
>>
>>    # Moves a branch (or -M for --force)
>>    git branch -m old new
>>
>> That last one we can't have either because "switch" squats on "-m" for
>> "--merge", which I daresay is a much more obscure use-case not deserving
>> of a short option than "rename and switch to".
>
> Isn't --merge a different (and inferior) way to achieve what we already
> have elsewhere with --autostash? Does it make sense to get rid of --merge
> here in favor of --autostash?

Probably, I haven't used the --merge option ever I think. Switching with
dirty worktrees isn't really how I work.

But to the extent that I've ever tried / run into errors with that I'd
think that an option like --merge or --autostash is mostly a result of
us being overzealous about "is_dirty() && die()" checks. E.g. rebase (at
least a while ago, still) would refuse to rebase with a dirty tree, even
though the path in question had nothing to do with paths that would be
touched by the rebase.

I suspect that much of the need for these sorts of options would go away
with those checks being smarter, but it's separate from the "should we
squat on -m" discussion...
