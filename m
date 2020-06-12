Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB2EC433E0
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 09:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A4F32081A
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 09:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1CLuL1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgFLJvl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 05:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgFLJvk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 05:51:40 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93868C03E96F
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 02:51:40 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q11so9095430wrp.3
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 02:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:reply-to:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=puTrB4B0/5jgBmHzeGhvz/q/b9dxHS+ISUfQ+YFfpHA=;
        b=B1CLuL1NX4qIu1dokkCRSdPA3Gd7FOuEomTvf0hAFlgUfbg9H4fRRMOh0xBjnviNRc
         ajSmBz4UZug0FhUvmA/741Z+qOSdQXuk7h6zYLP/2Xhd33tqmFHSia6hGsYXZJEzb5rm
         RLRkWpddy7rIGySZYfjmlZaIXyJErkcL3fURCWtZebmmgDgsj7l8xps/wo5mRek8PXmd
         e+Z3QeFNiHu/J2ZLPJXja4BEmX23A9AbUQaZaIYuNwmyOFcaiM87eOnb9LLkyUG8nJHS
         6tVeBJ6FDENOEIvyjHf2xYdbA4GPU8z5gFPPAJAn25EmqA1mqivYok2rRbYsEnNTy81k
         LnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:reply-to:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=puTrB4B0/5jgBmHzeGhvz/q/b9dxHS+ISUfQ+YFfpHA=;
        b=lvLjyqy22OZQo37D/iLfEjtbm7jVsQzGk587VIEtShMUcKEwp1PM+IL0MQKK1Sk7G+
         lbKTyETYiUVIu2QU6CNjBEFJDzPS4eooH/2VWSWxJDtdjD3ZowmW7/bYtKHoTvq8WyVX
         LkHFi5rctdPD+Me5RBwHY0KVKl/jEnB8vFjwNbTTcKWXi0S931M6jKOtTFmABFX1yivi
         N634utKjYreGhrQhcE9szjDsoJcThr6PZMCdAZNiM6rlMTo79RQUMMeOjDUzP2KXXqa5
         Uu/uYOycGGf11ZiUxB9XuZ0DKiZbXUcqVjwNuWK9SwRF01UTFayxmLeHD3oJ7E4x7iyx
         v8fQ==
X-Gm-Message-State: AOAM533vF1rk2UKhmeIYgQHSdQWeGs3F7V7BzdCO2Zfn+IFqPWb/q8yP
        nM4Jrpeq7ZffFo8QNNaIyJ8=
X-Google-Smtp-Source: ABdhPJzRWa0u7WHFz8JvE53mz78tME66VV25c9X+v8OtkSs2tXNTdy4qtA0SvQbgy8gbGShrodNBFA==
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr13918383wrq.222.1591955495412;
        Fri, 12 Jun 2020 02:51:35 -0700 (PDT)
Received: from [192.168.1.201] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.googlemail.com with ESMTPSA id p7sm9377474wro.26.2020.06.12.02.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 02:51:34 -0700 (PDT)
Subject: Re: [PATCH v16 02/14] Make refs_ref_exists public
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Reply-To: phillip.wood@dunelm.org.uk
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
 <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
 <a4a67ce9635197d759a12a617711764c1df16b65.1591380199.git.gitgitgadget@gmail.com>
 <9a5c0243-115e-ce50-dd80-2be4c889f4ba@gmail.com>
 <CAFQ2z_MDeiZshhmx=BjqCg7hTF04Fj7oM5dKs15qeESEPjjXEg@mail.gmail.com>
 <543c80ab-9e51-ed34-baca-70a1f8b46b2e@gmail.com>
Message-ID: <487a962b-31b3-5e7e-5f57-2fbc46af5dd0@gmail.com>
Date:   Fri, 12 Jun 2020 10:51:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <543c80ab-9e51-ed34-baca-70a1f8b46b2e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/06/2020 15:59, Phillip Wood wrote:
> On 10/06/2020 19:05, Han-Wen Nienhuys wrote:
>> On Tue, Jun 9, 2020 at 12:36 PM Phillip Wood
>> <phillip.wood123@gmail.com> wrote:
>>>
>>> On 05/06/2020 19:03, Han-Wen Nienhuys via GitGitGadget wrote:
>>>> From: Han-Wen Nienhuys <hanwen@google.com>
>>>>
>>>> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
>>>> ---
>>>>   refs.c | 2 +-
>>>>   refs.h | 2 ++
>>>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/refs.c b/refs.c
>>>> index 12908066b13..812fee47108 100644
>>>> --- a/refs.c
>>>> +++ b/refs.c
>>>> @@ -311,7 +311,7 @@ int read_ref(const char *refname, struct
>>>> object_id *oid)
>>>>        return read_ref_full(refname, RESOLVE_REF_READING, oid, NULL);
>>>>   }
>>>>
>>>> -static int refs_ref_exists(struct ref_store *refs, const char
>>>> *refname)
>>>> +int refs_ref_exists(struct ref_store *refs, const char *refname)
>>>>   {
>>>>        return !!refs_resolve_ref_unsafe(refs, refname,
>>>> RESOLVE_REF_READING, NULL, NULL);
>>>>   }
>>>
>>> It is a shame that ref_exists() does not take a struct repository. The
>>
>> I'm trying to follow the pattern that the rest of the code
>> establishes; you're right that the code isn't very consistent (the
>> fact that it uses unlink() rather than go through the ref store in the
>> first place is an indication of that). I want to avoid starting a
>> general cleanup tour of the code base, the reftable patch is hard
>> enough to pull off without.
> 
> Sure
> 
>>> The existing code is inconsistent about its repository handling - we
>>> create the refs with update_ref() which operates on the main repository
>>> but when checking their existence and deleting them we use a path which
>>> depends on the repository. I've realized now the answer to my question
>>> about using delete_ref() in my reply to the previous patch - it does not
>>> take a repository - maybe it should along with update_ref() but that
>>> might be more work than you want to do though.
>>
>> Why do they take repository arguments anyway? Is it because
>> rebase/cherry-pick supports recursion into submodules?
> 
> It was a stepping stone towards that, the git_path mechanism that is
> used to create git_path_cherry_pick_head() etc was changed to take a
> struct repository so it could support submodules without forking a
> separate process. However are still plenty of places where the sequencer
> code assumes a single repository (it calls update_ref(), delete_ref(),
> commit_tree_extended(), ...) and the two contributors who did a lot of
> that work have moved on. With that in mind perhaps we'd be better off
> just using ref_exists() and delete_ref() in this conversion. The call
> sites will be easy enough to fixup if those functions are converted to
> take a struct repository in the future and the result of this patch
> series will be nicer. I've cc'd dscho and Junio to see what they think.

In the end I put some patches together that change delete_ref(),
update_ref() and ref_exists() to take a struct repository*. I'll clean
them up and post them next week. Hopefully that will mean that this
series can then use those functions when converting unlink() etc which
will avoid having to expose a separate api for pseudo refs.

Best Wishes

Phillip


