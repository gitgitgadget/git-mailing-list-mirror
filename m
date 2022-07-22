Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F47C433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 16:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiGVQsW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 12:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiGVQsV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 12:48:21 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FFD8F537
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 09:48:21 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31e619dcbbaso42758547b3.14
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 09:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=wyCZTvi6F5VYRkOn7qHDNOB5CiiHzxS9CpMMvaMhTp8=;
        b=PYYlmTjkLstH7rUOHHUH2BvGntQJPkru0XCVsYZh0JngYys8yc+XLu0DZ5msGf7Ymg
         XijEza8WUr5/C/qbnyOfv1Hdv6/SgKz+ambzrxtyW8KbdVkzCyx6kstdcG1sec4B2ZlK
         JzJ+b7DfLt9j24Hf5T5PZfWghALRWPs5pZnYJ5ajDgpnuAH9RO9kuZR8MCgBeYILdgmr
         wWdGyFMS9gFUxvueiIy83qmjTx9Ah13d42HN6ngBV1FPEXPPlDsAXKsisXsACZFH04wv
         elh3yUT9xbwXO+5S0+gdYkE3D+vRhDpz2xD/uFNfhvc5Aq3Vw3hARgDMZctEiKypYVqH
         pZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=wyCZTvi6F5VYRkOn7qHDNOB5CiiHzxS9CpMMvaMhTp8=;
        b=7ANWYzC5qqZbjFYMkZ1CRqkTMngdWbUhp7Plpodyf1uR1vXnyRrYux2fBy6VeUgOzp
         qpi9MJlZrpqMdhRAd8iKTmFR5vOOeiy7ZwTCxQJ++VUPNgPxSKBoxqivKd4IF34hQ9Bk
         W7OF4aLZ8KPGREtR9FoBJMHNRHtynE82CNw6MIieSgE1ydhF6dQ7IIz2z/1a7BN2fJ8N
         q7m6lfLjcPxQ0cz7IGZYOGtfb9QOL5RBQYfe6khCt8H+k0TrCIxOScnyxvsHdbdWxCR8
         VkUWQke+KkerQgGlOHvvceS8/Tz5ceOQRuiB9yOz/V+WmzWk88rwjmESSc8lBODAb8Kv
         fz8w==
X-Gm-Message-State: AJIora8m+y6BUKjIOFQ8a9fMFyHJYAXpeZ84YmTuppQBLg7xR1ypCFLx
        +4QMgs7nKq078XidebESxOVeqa+Lr8cfxQ==
X-Google-Smtp-Source: AGRyM1t9966nE8ALcKwPz5fyLdcYyP428LU3/1f5dQpuHC9swUadNgKVbfkfMGDolvoOabhufUwWrO66HWVgTw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a0d:cb54:0:b0:31e:69de:5b68 with SMTP id
 n81-20020a0dcb54000000b0031e69de5b68mr588223ywd.254.1658508500273; Fri, 22
 Jul 2022 09:48:20 -0700 (PDT)
Date:   Fri, 22 Jul 2022 09:48:18 -0700
In-Reply-To: <220722.86y1wlqmqr.gmgdl@evledraar.gmail.com>
Message-Id: <kl6l8rolt7ot.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
 <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
 <patch-v3-02.26-32e4ae7ead5-20220721T191249Z-avarab@gmail.com>
 <xmqqlesmf9or.fsf@gitster.g> <220722.86y1wlqmqr.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH v3 02/26] submodule--helper: stop conflating "sb" in clone_submodule()
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Jul 21 2022, Junio C Hamano wrote:
>
>>> +static int clone_submodule(struct module_clone_data *clone_data)
>>> +{
>>> +	char *p;
>>> +	char *sm_gitdir =3D clone_submodule_sm_gitdir(clone_data->name);
>>> +	char *sm_alternate =3D NULL, *error_strategy =3D NULL;
>>> +	struct child_process cp =3D CHILD_PROCESS_INIT;
>>> =20
>>>  	if (!is_absolute_path(clone_data->path)) {
>>> +		struct strbuf sb =3D STRBUF_INIT;
>>> +
>>>  		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
>>>  		clone_data->path =3D strbuf_detach(&sb, NULL);
>>
>> This looks like a roundabout way to say xstrfmt().
>
> Yes, I can fix this and others while I'm at it, but a lot of things like
> that in this code are funny uses of APIs that we could improve.
>
> I think it's probably best to just leave these for now.

Yes, this series is already pretty long. For reviewability, perhaps we
could to keep this one focused on "leaks fixes" and leave the style
fixes and refactoring for another series (which might include things
like [1]). As a bonus, with this series in place, we'll know that our
refactoring won't introduce more leaks :)

[1] https://lore.kernel.org/git/kl6lbktitf6e.fsf@chooglen-macbookpro.roam.c=
orp.google.com

> But I also don't mind adding another commit to this already large series
> to search/replace the relevant strbuf_detach() with xstrfmt()....
>
> Just let me know...
