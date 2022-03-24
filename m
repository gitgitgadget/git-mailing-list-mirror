Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1264BC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 17:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345597AbiCXRC7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 13:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352103AbiCXRCv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 13:02:51 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC6CB0A71
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 10:01:18 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id j15so10410852eje.9
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 10:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=4Rimf7gHL8NkdUF0z42LD9dqAg7XoH8QHigDQLA4h/U=;
        b=LeiZiduKHSzosyDc+oxfFYN7LcEfTTiLSeBuQJzaOkVawId5B7DHZHEXxfCFvA4nP9
         Sy41guOcfqPv3vdO5v0HDOnwfvXkMbbmPuY+xw77ngvLMOMrNz6fGdYme1QAcnNBrLhL
         LC4AmKNYp0jNfRk86bijFjpX/z8GBeUiF4H1ICe8+UhNbosJUs3cwuhiCkWaZH+up1D9
         8RGzoveeURnDTE6Elbpvk4aG25pPxyd15vadRLgGtG+0wT/BRwtEJN6lfCr0QUzRo/TG
         4ZaMycEHdlftbezEXZUsptlGOHA6Mskk4WV/iLgEAx7RxFeWVgI4TNNEBcr1prkBAq0x
         MTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=4Rimf7gHL8NkdUF0z42LD9dqAg7XoH8QHigDQLA4h/U=;
        b=YaB2hlMsK6ihrw1ZYZYxzTV4KWhOAdbbfsARVzZwMPAfz8xZwOSzTv9o0ELJH/VW4X
         hC7DZjajhQDMLl3MTSQa1FOIrQM6fzNxzIBUdx5pRyI1iz40oLiWnQGhZRhmDuTkwBar
         yuj2p2VDWKGS8OSZ5AYqk6SsglQN5qTTaeJMK0gEHTV6964f/tr7Evk/tDl1QP8Ll+HB
         eAZXTz9Xta3sk7EbjsKz9QqDyLjtga+SsMW1jUA00c5nbrHQxhOJInNeds8ZZlhifZS8
         1mSfcywXB5gEhRGAIa0rjyuPVlKBsswS2EsBJBfx1eW2BpZZpZciEyUuP9slP6IOXf/H
         c06A==
X-Gm-Message-State: AOAM530/SSJRZWUNL8qQl5kHeB8ZwpNXNB49G83hPz8epj0KXZ2qkAGb
        87CDdTVe2ykGc9VEG8+cssY=
X-Google-Smtp-Source: ABdhPJwAn74k2WZLVHfZRPcndkNBliSYSwfRaprrnCF+7DqVPCV8rHS4ismUSnk7Gnluwy1LsGHsIg==
X-Received: by 2002:a17:907:2d93:b0:6db:ab5e:7e0b with SMTP id gt19-20020a1709072d9300b006dbab5e7e0bmr6735781ejc.262.1648141276786;
        Thu, 24 Mar 2022 10:01:16 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sb31-20020a1709076d9f00b006ceb969822esm1319322ejc.76.2022.03.24.10.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 10:01:14 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nXQpl-001jEd-D8;
        Thu, 24 Mar 2022 18:01:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 04/27] format-patch: don't leak "extra_headers" or
 "ref_message_ids"
Date:   Thu, 24 Mar 2022 17:59:49 +0100
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
 <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
 <patch-v2-04.27-64a76629e23-20220323T203149Z-avarab@gmail.com>
 <xmqqfsn8m0la.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <xmqqfsn8m0la.fsf@gitster.g>
Message-ID: <220324.86lewzmgiu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 23 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Fix two memory leaks in "struct rev_info" by freeing that memory in
>> cmd_format_patch(). These two are unusual special-cases in being in
>> the "struct rev_info", but not being "owned" by the code in
>> revision.c. I.e. they're members of the struct so that this code in
>> "builtin/log.c" can pass information code in log-tree.c.
>
> Hmph, if we are eventually adding a new API function to clear a
> rev-info structure, shouldn't these members be released there
> instead, I wonder.
>
> This is the only user of this member, so it does not matter too much
> either way, though.

Ideally, but in practice "struct rev_info" is both before and after this
change a mixed bag of stuff it "owns" and stuff that others "hand over"
to it, sometimes permanently, and sometimes just to hold on for a bit.

So it can't really free() everything in the struct, at least witohut
some larger refactorings, which I'm trying to avoid here.

The "diffopt" at the end is another such case, which is left for another
follow-up.

But for now is it OK if we keep this as-is?
