Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7937FC7EE29
	for <git@archiver.kernel.org>; Fri,  9 Jun 2023 23:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjFIXTH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jun 2023 19:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjFIXTG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2023 19:19:06 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E7D2D74
        for <git@vger.kernel.org>; Fri,  9 Jun 2023 16:19:05 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-25667878a53so779892a91.3
        for <git@vger.kernel.org>; Fri, 09 Jun 2023 16:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686352745; x=1688944745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QtGOTNdgNxaafHDAUjJy1DMTs7/cP3cc3/EwUJHHIm8=;
        b=wKaCgA4wzVik79/G3qv3r61JvWNtV+cgAa8c/fWHX/rbKt04Or3j/oIm9TokObWLcu
         KsDbp2jO87m9ZI9xUBtPZd+ys5bJ+hb58VUqbMmmeUowSCN+xHryHTiHiERjtBsc/mKT
         NCBfX/aeg2LPzVIII/71FdBt8XXJyyh5nO3AweI2Tl0mBXbcdOok0CUtPPXiJZtY88Yi
         rGqjEG7xC0d7IT7lAZvnaZ5WOVGZlF8SW7T26og3HnZ3qCOSg+1pm/C32jdQkw+SX7VY
         lHZI4fpCa/6Gz4jQzPv8DCl82F45EqcZ2kHqkGiyRy7RXRzi53mer1BtgZf2THPQZPwI
         KYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686352745; x=1688944745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtGOTNdgNxaafHDAUjJy1DMTs7/cP3cc3/EwUJHHIm8=;
        b=Gl4i0678wSU2ax2GVtJPkFR73JnM1Qh42GYmffz0uMILkC4+lr/mSPdRqhVSwsk9b3
         UpGaFylR6/YufBIwU0Uh+Gn1HryrIXbPXFWRCfzFLOHIM8mpk+FEOkH657tXfr/YDlsu
         g0UPQgzc2YsWN7VzMfTMyw2nIfZBcX5hvVaIsZC0tdbsfFw+z9lTw+1kDDxgtY2xBoW0
         t+ABQmpDMerEfxFFvZF6nreu89BfF53/+FTvDbtAqywY7xgP2fp3sSqzbzeJrGK01rTD
         8xTbh0kHKPuG+eGzkppRyo9ham7gBGrRNJask11LWndHyPN+VPS6KbHT3QCGITfuEeo3
         nPgw==
X-Gm-Message-State: AC+VfDzeRbyF2EF+Sahhf0KL0Ol8g1vlYWCmvb8o/g+wegBz80yT7KFC
        KTEWZwXRu0iVjzkc2/Ret/C4WiI9JLWuEA==
X-Google-Smtp-Source: ACHHUZ4IKcNxaN/ggzVN1vmhxK7Co7+6mdxWmKorV90wcMrNPYYp8g+AHt/58/z5fMsIuAoDJMzEp0QykGxocg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:90a:c711:b0:244:9147:ee20 with SMTP
 id o17-20020a17090ac71100b002449147ee20mr562285pjt.0.1686352744698; Fri, 09
 Jun 2023 16:19:04 -0700 (PDT)
Date:   Fri, 09 Jun 2023 16:19:02 -0700
In-Reply-To: <1ca04355-8faf-e7f9-051f-a6a568ff99c5@gmail.com>
Mime-Version: 1.0
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
 <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com> <6834e37066e7877646fc7c37aa79704d14381251.1685472133.git.gitgitgadget@gmail.com>
 <6faf1b17-a1ca-0c22-2e43-aee121c4e36a@gmail.com> <kl6l4jnr17am.fsf@chooglen-macbookpro.roam.corp.google.com>
 <4de362b4-dcce-3b5a-0011-73dc7dec79c3@gmail.com> <kl6lv8g5zu9v.fsf@chooglen-macbookpro.roam.corp.google.com>
 <1ca04355-8faf-e7f9-051f-a6a568ff99c5@gmail.com>
Message-ID: <kl6l3530gr6h.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 03/14] (RFC-only) config: add kvi arg to config_fn_t
From:   Glen Choo <chooglen@google.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        phillip.wood@dunelm.org.uk,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason" 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 02/06/2023 17:46, Glen Choo wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>> As an aside, I think we'd also want a couple of helpers for matching
>>> keys so we can just write kvi_match_key(kvi, "user.name") or
>>> kvi_skip_key_prefix(kvi, "core.", &p) rather than having to extract the
>>> key name first.
>> 
>> Yes, and that would also abstract over implementation details like
>> matching keys using strcasecmp() and not strcmp(). For reasons like
>> this, I think your proposal paves the way for a harder-to-misuse API.
>> 
>> I still have some nagging, probably irrational fear that consolidating
>> all of the config_fn_t args is trickier to manage than adding a single
>> key_value_info arg. It definitely *sounds* trickier, but I can't really
>> think of a real downside.
>>
>> Maybe I just have to try it and send the result for others to consider.
>
> That's probably the best way to see if it is an improvement - you can 
> always blame me if it turns out not to be! Hopefully it isn't too much 
> work to add enough api to be able to convert a couple of config_fn_t 
> functions to see how it pans out.
>
I was preparing a reroll that incorporated some of the suggestions here,
but when I was done, I didn't really feel like it was better (or at the
very least, worth the extra churn) compared to the original approach.

The 3 versions I was comparing are:

1. Adding a new "struct config_context" arg to config_fn_t that only
  contains a .kvi member. This is basically the approach in v1 and v2
  (adding an extra args) but wrapping it in a "struct config_context" so
  that we can grow it later.

2. Stuffing "key" and "value" into "struct key_value_info" and removing
  "key" and "value" from config_fn_t.

3. Creating a "struct config_context" that contains "key", "value" and
  "struct key_value_info" as separate members, and removing
  "key" and "value" from config_fn_t.

I didn't try using opaque getters - I think that's nice to have, but
isn't crucial to this series and introduces a lot of churn.

I've uploaded an implementation of option 3. [1]. The result is quite
ugly in some places. In particular, config callbacks are used to calling
other config callbacks with slightly different args (e.g. massaging the
"key" but keeping the "value" the same, see patches 3,5/14 for
examples.), so to make this work, I ended up creating a new
"config_context", copying over the relevant members, then changing the
members that need to be different. I didn't pursue the refactor to its
end state (e.g. some of the CLI config machinery in the earlier patches
and git_config_int()/ functions that end in die_bad_number() in later
patches, take "key", "value", "key_value_info" as separate args instead
of a single "config_context" arg) so I haven't reaped all of the
benefits, but I thought the range-diff was getting churny enough that I
wasn't interested in pursuing the idea further.

I toyed with option 2 for a bit. Unsurprisingly, it requires even more
copying of members, though in some ways, it's better than option 3
because callers only have to initialize one "struct key_value_info"
instead of "struct key_value_info" _and_ "struct config_context".
However, it requires reworking the machinery quite a lot because
"key_value_info" is currently used _just_ for config source information,
and there are several cases where we need to propagate the config source
information separately from the key/value (e.g. the configsets store
"key" in a hashmap key, "value" in a string_list_item.string, and
"key_value_info" in a string_list_item.util). I'm convinced that this is
better interface-wise than option 3, but the required effort is high
enough that I don't think we should do this unless we see a real need
for it.

With that in mind, I'm tempted to continue with option 1 for now, but
let me know if I'm missing something.

[1] https://github.com/git/git/compare/master...chooglen:git:config/no-global-combined-kv-context?expand=1
