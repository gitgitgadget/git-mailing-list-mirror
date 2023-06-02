Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38E2C7EE29
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 17:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbjFBRXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 13:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbjFBRXm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 13:23:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56791A2
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 10:23:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba8cf175f5bso8044942276.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 10:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685726621; x=1688318621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sxlTPBsND0c5NThbFLK7eDjuLQQbTctJ5NASQWir43c=;
        b=tb3lWoISe6ESOjXnJJ/WPtbhlfuq5+kT0K8WdBWJM1uPprY6ViwT/3mPimOYAsC0yb
         KP0u2Jqa8YwHcad1mtSL9sE2S7CXeobWvGke15PP6eBucuDItLEIxz//lGbZoEhE418E
         uoJ1pWzpW++Xl6d5w4KjMC6nkZxx45jEPoZb+lGvg5nyD+pFJ+r9S+B9YS+403qmKm1z
         Cif4tpJlux8V9MfX7KxHBIRe4hMtxFh5NrexMuthXm5PEIPMXWu2CXMtKQRRksBjLw7/
         /HTHv8UgmFphaTzz1D6LGt55fhntoO21h64aVbPZPXQn/dRvyF05VwjBVRJTzvKXhpSi
         kimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685726621; x=1688318621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sxlTPBsND0c5NThbFLK7eDjuLQQbTctJ5NASQWir43c=;
        b=HGLV/ef8IhicpJR9cWQv3agD67etsPe/QdUN1yqp+3JjZCWnUpHoNInGj4mJooK2aI
         L6PJkBHkuqu77NY2vARdbEKSCbMxF3646KwIXV1A3iPSMevSHGn8EVRcJUew8jd9eiZO
         Rw6fjCb7Y/Xh1+ckVhamyjwRMgZC/fX+ISRog/Uym1QmhpBHtc/bUYwc3sdpiEgcz62D
         ZqUlhmdF6SzqO8I5imHLvsgaISPPeImvBhLBdNfM0dv2G7nNl7KfHvP0z/ImNpZcCRJj
         WeNX00pz0nCofJwzw+Lw5q0HWf+LoFMzFYfxdvWYyBszWdsvAXUeatqWIFS1RtkzrIgT
         ewiQ==
X-Gm-Message-State: AC+VfDw5NL/LSw392QeYXhLkgrIfL4xnPWvWPTiMM0VbeS1HPhewPq7q
        S+dp2n4cH9tXHFCoDXakqp9mMoCOZ5h48g==
X-Google-Smtp-Source: ACHHUZ6u+zd/In7Q5X5VYXJboHHEuNW5eDJxzvIkBod7by7CDxTk+5i8BPWv1++H7HhYymRHSo+dheHuCQwLeA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:6d56:0:b0:bb1:d903:eae9 with SMTP id
 i83-20020a256d56000000b00bb1d903eae9mr1925533ybc.2.1685726620856; Fri, 02 Jun
 2023 10:23:40 -0700 (PDT)
Date:   Fri, 02 Jun 2023 10:23:39 -0700
In-Reply-To: <20230601234829.432150-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20230601234829.432150-1-jonathantanmy@google.com>
Message-ID: <kl6lpm6dzskk.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 11/14] config: pass kvi to die_bad_number()
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> Outside of config.c, config callbacks now need to pass "kvi" to any of
>> the git_config_<type>() functions that parse a config string into a
>> number type. Included is a .cocci patch to make that refactor. In cases
>> where "kvi" would never be used, pass NULL, e.g.:
>> 
>> - In config.c, when we are parsing a boolean instead of a number
>> - In builtin/config.c, when calling normalize_value() before setting
>>   config to something the user gave us.
>
> In these cases, could we synthesize a kvi instead of using NULL? I
> believe there are already code paths that use an UNKNOWN scope - these
> seem similar to that.

Okay, that sounds reasonable. This has echoes of Philip Wood's
suggestion (elsewhere in the thread) of combining all of the config_fn_t
args into a single struct, which means we can no longer use NULL as the
default.
