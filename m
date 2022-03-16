Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FD5C433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 22:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiCPWi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 18:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiCPWiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 18:38:25 -0400
Received: from mail-ot1-x349.google.com (mail-ot1-x349.google.com [IPv6:2607:f8b0:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF08A3897
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 15:37:10 -0700 (PDT)
Received: by mail-ot1-x349.google.com with SMTP id y7-20020a0568302a0700b005c965381211so1897683otu.6
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 15:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=b3tcYMKudtoVFOJ8WJ+WU4ACp9LGtiySU+3XQK04ius=;
        b=swRSrUtxQFXrqqBZxJR0liamWAh/WTg0HX24VjqFBnhbnuvO1hZSOKyqQKmL8FVQww
         l+RT0HSNdjEF9Ey40JnlEMWc8ctISCQVN701JtVEwoEGixG3BxXFicl+2rNHwlGSdEHs
         P/1PsarKN/IaVeCcHvepBAYER1tEnKHr3Gu/EEK1Eq2mgEzJH0nibOykRKUslBwYfWcF
         TmbMVi0gj7JjfeF2tTzxHLa5dgR/DMBQlp9/0Bo0/qEu/yglMNaLHJKNJ/vdFzUUBLrQ
         jghYVWPfav2s+cxrwWOD+v4CKHdn6FEzqlEwWUbpOOGjy8eNqARLxfsMl0RybmH0ikwE
         v4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b3tcYMKudtoVFOJ8WJ+WU4ACp9LGtiySU+3XQK04ius=;
        b=YD5u/WWZOvdUxg/l+GXf2n3SyDDmTHdvYT2cO6p3XYxgNhRhkCrfrabjhPRWkyNWmc
         NVdC46XO85osMP+wviXLamOccib+TNK4vH7knw5c0UEW6rlLx4iFcYcSY0dt5e/CAuRj
         cL1rq0jAefaL5NtNtOA+8tVqNTAf4D/rt4QOONBZQMw3Sm0U+2rAZa/TRbWGapHLH2s+
         e8dQTZDwvvHXYZWrm9uFYkk+DsmDf/mioNgTiPbnB+Wnon12Vd5P6YXVgOkD9GcI7Q4N
         +Sg2koV0dbXpOhZKF9ZaepX+G3d0IluBeaUorRKH/xJXjiAtQHFrqilHfdQfiRRUz5Tr
         7taQ==
X-Gm-Message-State: AOAM533XYDzB6ev5KbYdGPznBAR/d+UMnTMHLMW35hMZBwhixs9mqUOl
        sAlPkuzuJlL34S0uiosmsJu0Udm0Yp28WQ==
X-Google-Smtp-Source: ABdhPJxUbrCD8HYEcvNIcHYLQXLOe5VzoAAEbzaz8zt/T/JnphFztCvg0TZR1M+ie6rjmk5xQXv/gT6KewBxsg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6870:590:b0:d7:b0:7412 with SMTP id
 m16-20020a056870059000b000d700b07412mr4193285oap.115.1647470229997; Wed, 16
 Mar 2022 15:37:09 -0700 (PDT)
Date:   Wed, 16 Mar 2022 15:37:07 -0700
In-Reply-To: <xmqqfsnhk0x7.fsf@gitster.g>
Message-Id: <kl6l7d8tle24.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220304005757.70107-1-chooglen@google.com> <20220308001433.94995-1-chooglen@google.com>
 <xmqqr17dp8s9.fsf@gitster.g> <kl6lh7885mm3.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqfsnrkkhd.fsf@gitster.g> <kl6l5yom6h4j.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq4k46nae4.fsf@gitster.g> <kl6lzgly4vz3.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6la6dplfts.fsf@chooglen-macbookpro.roam.corp.google.com> <xmqqfsnhk0x7.fsf@gitster.g>
Subject: Re: [PATCH v5 00/10] fetch --recurse-submodules: fetch unpopulated submodules
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> Glen Choo <chooglen@google.com> writes:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> Glen Choo <chooglen@google.com> writes:
>>>>
>>>>> To clarify, does this opinion of "don't use config values that aren't
>>>>> copied into .git/config" extend to in-tree .gitmodules? Prior to this
>>>>> series, we always read the in-tree .gitmodules to get the config - the
>>>>> user does not need to copy the settings to .git/config, but we don't
>>>>> pick a commit to read .gitmodules from.
>>>>
>>>> I think we do, but I also think it was a huge mistake to allow
>>>> repository data to directly affect the behaviour of local checkout.
>>>
>>> I'm inclined to agree.
>>>
>>>> Fixing that is most likely outside the scope of this series, though.
>>>
>>> Agree. Thanks!
>>
>> I thought that this would have been the end of the discussion, but after
>> reading <xmqqa6dpllmc.fsf@gitster.g>, I guess I had the wrong impression
>> (oops).
>>
>> If I am reading everything correctly, we both agree that it's not
>> good to read _any_ config values from .gitmodules (even if it's
>> in-tree), and that we should clean it up outside of this topic. So for
>> this topic to be merged into 'next', is it enough to say that I will fix
>> this behavior in a follow up topic?
>
> At least we should remember that is something to be fixed.  It may
> not be you personally who addresses that issue, though ;-)

Perhaps squashing in a NEEDSWORK comment into [PATCH v5 09/10] will
suffice? I can also resend this series if preferred.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----

diff --git a/submodule.c b/submodule.c
index 6e6b2d04e4..93c78a4dc3 100644
--- a/submodule.c
+++ b/submodule.c
@@ -795,6 +795,21 @@ static const char *default_name_or_path(const char *path_or_name)
  * superproject commit that points to the submodule, but this is
  * arbitrary - we can choose any (super_oid, path) that matches the
  * submodule's name.
+ *
+ * NEEDSWORK: Storing an arbitrary commit is undesirable because we can't
+ * guarantee that we're reading the commit that the user would expect. A better
+ * scheme would be to just fetch a submodule by its name. This requires two
+ * steps:
+ * - Create a function that behaves like repo_submodule_init(), but accepts a
+ *   submodule name instead of treeish_name and path. This should be easy
+ *   because repo_submodule_init() internally uses the submodule's name.
+ *
+ * - Replace most instances of 'struct submodule' (which is the .gitmodules
+ *   config) with just the submodule name. This is OK because we expect
+ *   submodule settings to be stored in .git/config (via "git submodule init"),
+ *   not .gitmodules. This also lets us delete get_non_gitmodules_submodule(),
+ *   which constructs a bogus 'struct submodule' for the sake of giving a
+ *   placeholder name to a gitlink.
  */
 struct changed_submodule_data {
 	/*
