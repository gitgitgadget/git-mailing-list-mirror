Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0497C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77CE861159
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhDHWd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 18:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhDHWd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 18:33:56 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD3DC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 15:33:44 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a25so5654830ejk.0
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 15:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=YASdWU5lbToWiLzVWmR7X6WpeDxHAGCVJCh6MSKVk9U=;
        b=uMXnEhDUIJaoNVFXjcxvlE7E6+D92Pw/1hVcmtR8P7OfgQVoXKuGjPZshIfkckSf+O
         j/42GEFkIftgCHwfcphgdl9ZClzq1AZ7rRu069hfsAPeGB5yY/nWXP+ki9pcpJBmpam0
         1z5JvZZfYTA6p/M9b1UtjE1BL/8tQChTv1rt1g1vDvIGc2np504SwRA+R5INVufEPDZv
         J4RKTdQCR4XTa2QOkkOg3Gplh61cIRIVwN/0vTlbR4OPM4XS3IP6Ddsg0u1LkCQcz3El
         Dy4tAnAemRWxvs2EkbcTJCpA/KSur8NZOMh9tiOo8h8f+Mx1Lx78mlaLjdDInVtpicXs
         o5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=YASdWU5lbToWiLzVWmR7X6WpeDxHAGCVJCh6MSKVk9U=;
        b=XCCl/Z+svwiqctZv3ieeo8EmMeeFAKHSpKIMwDmR/KWg3yb3YZ/FxoHkSL8n9BesYA
         2yppvvpWT34hqomCPPYulthhlWaXT1LBD0rDfOO2DDc5bGX1fDve1wb1L9LC9kxvc32S
         2nzNzkf6Pg+NtDJYKpr9+VuQW2QK7l2rXjlVzIiuppralKmpTxsM1PjBKToQ1uFs4U37
         9OLdC3oxnzN3en+YOzckGNkyrMLp5YuYW/kYT7rXFOYH8RR3nawAgMBZVzq7LnemLIjg
         DVzCaMOw/pj3TOzo2fyP1Ve2onCmt+BZAXa2PC5jN1kjdYGRPIEMQBmVEAZ5eJ40T22n
         DlrQ==
X-Gm-Message-State: AOAM530yWMuvoTVSCcQ/vyGA2B6Q/5mmoEKWDG6OLv0AefXLhFvN7YW8
        xn6ZCFzdMBvb8UYT8mYJhYc=
X-Google-Smtp-Source: ABdhPJzy+rqrPENmRGGLFH8c5TsM2qgkHGDtnnetcw9JbPi65qx7ErOBAJ97vata4jD7kI8t7Hgc4A==
X-Received: by 2002:a17:906:804a:: with SMTP id x10mr13324640ejw.15.1617921223466;
        Thu, 08 Apr 2021 15:33:43 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c19sm363951edu.20.2021.04.08.15.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 15:33:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v13 4/5] bugreport: add uname info
References: <20200416211807.60811-1-emilyshaffer@google.com>
 <20200416211807.60811-5-emilyshaffer@google.com>
 <87mtu8ifmj.fsf@evledraar.gmail.com> <xmqqv98wquqp.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqv98wquqp.fsf@gitster.g>
Date:   Fri, 09 Apr 2021 00:33:42 +0200
Message-ID: <87h7kgieyh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 09 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Thu, Apr 16 2020, Emily Shaffer wrote:
>>
>>> The contents of uname() can give us some insight into what sort of
>>> system the user is running on, and help us replicate their setup if need
>>> be. The domainname field is not guaranteed to be available, so don't
>>> collect it.
>>
>> Even with _GNU_SOURCE would anyone care about the domainname (the NIS/YP
>> name, not DNS) these days, as opposed to the portable POSIX "nodename"
>> field you're not including?
>>
>> In any case, I'd think it's a good idea to omit both. People tend not to
>> want to want to include their FQDN (e.g. their employer), and I can't
>> think of a reason we'd care about it for debugging git.
>>
>>> [...]
>>> +		strbuf_addf(sys_info, "%s %s %s %s\n",
>>> +			    uname_info.sysname,
>>> +			    uname_info.release,
>>> +			    uname_info.version,
>>> +			    uname_info.machine);
>>
>> Since this is completely free-form I'd think:
>>
>>     "sysname: %s\nrelease: %s\nversion: %s\nmachine: %s\nnodename: %s\nd=
omainname: %s\n",
>>
>> Or something like that would be better (after pruning out the fields we
>> don't care about).
>
> All true.
>
> By the way, what's this sudden interest in re-reviewing an age old
> topic?

The thread got bumped by SZEDER in [1] and I'd read an April date
without noticing the year, so I see this has long-since landed,
nevermind :)

1. https://lore.kernel.org/git/20200416211807.60811-2-emilyshaffer@google.c=
om/
