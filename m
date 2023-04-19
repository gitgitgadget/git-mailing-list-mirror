Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B638C6FD18
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 17:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjDSREH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 13:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjDSREE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 13:04:04 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F357EC5
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 10:04:01 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2a8c28158e2so23781351fa.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 10:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681923840; x=1684515840;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C1KDQt6YQC+kwK1+gP+0PaCnvdjS0ppqdlV1/W3mbcY=;
        b=Qbq0wMzLgkLagarw4rJ/1qodgqD6f8lnvOW7TzOtkSMh7OsbosMot5j8yrTdbZ/OI0
         /Vx7JX/oQF2oc0vdrDyM5kCzauO8CihOjpJLTO3/kpyz+SS9qMR2A4s51xJH0SKjWGmd
         jcKzyF8InAVxi/y+utCYpm0B9f8WNQGN1O0+1WCN/T0YLooUakFxnP56XD1AEW2zhyYJ
         WW+1Fg3N6vLd9MP+xAqwMwIMjqwugUaQLiN5ojj/jcfqf3eCiddOnrAZPYN0dq1LAhHy
         YhGAJ2JTGpl/PZ3gTpTfO/fI6/J/zYaIfNKsh0ABby7E9AQXmCRKQCMaIC57wN+lnoYZ
         rA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681923840; x=1684515840;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C1KDQt6YQC+kwK1+gP+0PaCnvdjS0ppqdlV1/W3mbcY=;
        b=CGDrb+f53/93joIFPBKgCXuQpQNfbLCG3EyfVtbUATRIdcFkC+b4EakUJ9e54SjPeQ
         COuueu6cT5Q3rlzum0yE/Vm9GC6oXEm+1rlhy8S8Se51hDEqNzd9+9zuBMaBk9fWMFKy
         RPKd+o9QoL0liXKv36X8GXbriKq/Zqy86RmjY7ksU+Z+9l9nCccECDO0KjwK/DY+iVvT
         FMwJnJJVdZbuh12SDtuLksHv8mg9FYMARf3GnwEss5DZUDNPahrU4KCGRzZSwJTLM8gx
         jH3odSszvw0GXxQ/A6wdoALtUdQ9L9qJ5lD8DN6l+0j+v4Ux0jWSfdXF768jGvKRzn0t
         Xn8Q==
X-Gm-Message-State: AAQBX9dn3UuSPx25Z/R/UL4Ob/rGN6NgRN9+jcfTvvEu1S5KBvSBAPZq
        qHhm3yaG24r5tIR27VxmCKUVoCnoI24=
X-Google-Smtp-Source: AKy350YERxjLgEuP2dYVsiERh/QxRmwG6so84jRvQORyth4aMEdzIGADon8qv9E5AtegOOCUa0iHIQ==
X-Received: by 2002:ac2:546c:0:b0:4db:1bee:c with SMTP id e12-20020ac2546c000000b004db1bee000cmr4024804lfn.44.1681923839586;
        Wed, 19 Apr 2023 10:03:59 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t7-20020ac25487000000b004e84d64ab51sm2743678lfk.58.2023.04.19.10.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 10:03:59 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     Cem =?utf-8?B?R8O8bmRvxJ9kdQ==?= <cscallsign@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git rebase no longer defaults to upstream after force push
References: <CA+JQ7M_KuDXBaVTzVwLTx+R4-6-3TOuUOpcchkS26iiosc85Hg@mail.gmail.com>
        <CAGrwipO7odTbuKgwDmU+3hY0pEeTdjxx-_9=oufUdBzyQ_eRvQ@mail.gmail.com>
        <CA+JQ7M_XP6fjdut10ry9db9M3pEhp3-+zToJ93gnbHo-4p_8uQ@mail.gmail.com>
Date:   Wed, 19 Apr 2023 20:03:58 +0300
In-Reply-To: <CA+JQ7M_XP6fjdut10ry9db9M3pEhp3-+zToJ93gnbHo-4p_8uQ@mail.gmail.com>
        (Erik Cervin Edin's message of "Wed, 19 Apr 2023 17:43:10 +0200")
Message-ID: <87ttxbztvl.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Erik Cervin Edin <erik@cervined.in> writes:

> On Tue, Apr 18, 2023 at 5:54 PM Cem Gündoğdu <cscallsign@gmail.com> wrote:
>> > If <upstream> is not specified, [...] and the --fork-point option is assumed.
>>
>> The --fork-point option does this:
>>
>> > Use reflog to find a better common ancestor between <upstream> and
>> > <branch> when calculating which commits have been introduced by
>> > <branch>.
>>
>> Since the parent of a is still in the reflog of origin/a, it is not
>> being rebased (the rationale being that the commit *was* in origin/a
>> at some point). If you want to disable this behavior, add
>> --no-fork-point option:
>
> Yes. That's it, thank you for pointing out --fork-point. That's indeed
> what's causing the unexpected behavior.
>
> Do you happen to know when such behavior is desirable? I'm tempted to
> change the default to --no-fork-point but usually when something is
> default there's a valid reason.. 🤔

$ git help merge-base

has a thorough discussion of --fork-point that might be helpful.

As far as I understand, it helps to DWYM when remote branch has been
rewound, and causes nasty confusion when it fires unintentionally. 

-- Sergey
