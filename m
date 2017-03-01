Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C656B2023D
	for <e@80x24.org>; Wed,  1 Mar 2017 12:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbdCAMCt (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 07:02:49 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36157 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752543AbdCAMBW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 07:01:22 -0500
Received: by mail-oi0-f52.google.com with SMTP id f192so21018206oic.3
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 04:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XvpBl0q+hNRyW1iYBXiaDcitz3O8/8x6cGzHzcJX4+A=;
        b=SdePGvtoydVUd/TmGib9NrhaG1Q/e0dPtphOj79S2hh3mYbUwVCCGe5CtCR17oOygG
         oRhwBpkN1GCzpzGjpG9qW8km/XUC9s7lWiB0HuCzbHwClbSd2SSfHrghySrkb1PF/DZr
         rkQoVcCtDEJckEId6NK7rfu8zCVKtI1giB8+yAJ2zjBIX51/RYiIVQWMjfwlyZVdIQzk
         UuNc7QB9GmLWYppk9dLP+wJCh/lSBMjKaQKjRkRwulufZ2MCjkWxbGUPpTUanSPAmTYx
         gh3L//fXoDuzu+bzSQhDy+OElhXdoxUu6UJ7/KaSdHpYs9+qTqCJ8nwoVQJVN4a5kwxJ
         6iaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XvpBl0q+hNRyW1iYBXiaDcitz3O8/8x6cGzHzcJX4+A=;
        b=mwW12JG6re8e3UQKFSQknBrBiewUe993wOqJ0+hgFGs3KtU0Fdt7Vj49fFOxZgwOeS
         S5c/hDtnWjYidIX5aXZ1FsDE23zlJC3b334W0UhdutROjvRbT1SdvFfOoS2KDRumXzp6
         HaOu1tGBgPw/gegKW09V9c3GV+hU2qjAoTzMB/mKHZKLzEekuWJKAvHA/97npQzC5eoE
         n0am/jGsNUK0lO9QA/+fHXONyeeTYXUXxyv1HpZpHU5ODWfJWMwWRta8JX61Ef05h6+y
         7zVFwYYc+rQwiF84wGqYXqzJGKWChwvJWaCX+9pqArNSMHFAiOn8lsI1NNESULe2ELRo
         aFnQ==
X-Gm-Message-State: AMke39lNBgY9Mte0tD8VZb28OomnsgPpvZ4sFHA5Kx/GCOkwjlh2JUXJr/LSM96nit2707m/FeFA0oCvA7QlUA==
X-Received: by 10.202.207.134 with SMTP id f128mr4127489oig.55.1488369681052;
 Wed, 01 Mar 2017 04:01:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Wed, 1 Mar 2017 04:00:50 -0800 (PST)
In-Reply-To: <92ff53b6-8a85-9be8-e14f-18eb1fcaf732@alum.mit.edu>
References: <20170218133303.3682-1-pclouds@gmail.com> <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-13-pclouds@gmail.com> <92ff53b6-8a85-9be8-e14f-18eb1fcaf732@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 1 Mar 2017 19:00:50 +0700
Message-ID: <CACsJy8BvKvo8_bRHH++dp53DaPbDVkKU0EUQC7ofYvBo+Tec0Q@mail.gmail.com>
Subject: Re: [PATCH v5 12/24] refs.c: kill register_ref_store(), add register_submodule_ref_store()
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2017 at 1:03 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>  struct ref_store *get_ref_store(const char *submodule)
>>  {
>>       struct strbuf submodule_sb = STRBUF_INIT;
>> @@ -1480,6 +1479,9 @@ struct ref_store *get_ref_store(const char *submodule)
>>       if (is_nonbare_repository_dir(&submodule_sb))
>>               refs = ref_store_init(submodule);
>>       strbuf_release(&submodule_sb);
>> +
>> +     if (refs)
>
> I think `refs` should always be non-NULL here for the same reason.

That's true if is_nonbar_repo... returns true. If it's false (e.g.
uninitialized submodule) then refs remains NULL from before (I didn't
know about this until I hit a segfault in rev-list in another series)
-- 
Duy
