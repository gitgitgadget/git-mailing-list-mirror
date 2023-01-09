Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981FCC5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 17:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbjAIRXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 12:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbjAIRXh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 12:23:37 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2035D3E0F4
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 09:23:36 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bk16so8918784wrb.11
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 09:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3rvB4GxwaXyBCdymKpAWuwvefbdkKHVpQ01yeHYGlM8=;
        b=k+fuhm4YkzAbl/c1mzyGgOtNoTUf+gaH0XRuDwowGkBqwRgkppMQTAi18KcJw2JZvS
         2WIhurtzLKSlJWdzolKInyFFNBbo2LVLX1iBJR13aFhBcp/pl5/VYHj+tzFqHZB8ciGE
         PseMWp9VezMTpNk6n1QM/N4vTT9RPh0NlgMOaLT7VFVFZUVnOwVxZqaPfLbbDyjKJ+m2
         feFZmxjPj5YadTDkNmfUBTV6BocyDxLjtIB4H6lp1nLYDn7HSQoo07+7DTpuJ9zCbN0V
         e+qKOkbvkWyYgVvVXVGmNRrKQtLKhX8erZ1Q1lhocJ/hsQoYU182k7zTQtcCgfZM4toM
         sdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3rvB4GxwaXyBCdymKpAWuwvefbdkKHVpQ01yeHYGlM8=;
        b=X/GyiUi/UHzijE259ulrshFy4ZDA+50gO2KvRVRatCtZ9G0Jz4NZpl0AAJP+S/dhUE
         rA+5GFU+Kv4DgCMosL2XFjquYOdpirxU0aaMpDXVgq8SYiUAgUr+765VpN6waepb4FgE
         624F7MgRm92pKRBA4hdHhHjdsixqNYIqo0tYAL+bolxcwI2SzMKSNNzt7WIG3Jr+4xP0
         viA0lYiJiGOgXt/rnC/2eOsGjDJZaSly2nSfiUApifkXkSq23BUPI4AhHl+LicvW1esE
         pHQmWZxeObetHNXpSp7U3m0qPcy8a7DnpUXbyDlNSk6cD5QB4Sr0byLXF8F0xZ+gLy3F
         KoYw==
X-Gm-Message-State: AFqh2kpyuskP3S07Q25IYEb7AthNgUrLVg44pNnq2ikainplKPmN9wWJ
        c4XqjXDm0qUDdF02OuKAzY4=
X-Google-Smtp-Source: AMrXdXswqvd01FhU4nFbJDajKwF4934jejJfD1jyzyYZplI0hEyPGQ3f/FBKJT/7AHbSFxlc9zohvA==
X-Received: by 2002:a5d:6a88:0:b0:279:3718:57dc with SMTP id s8-20020a5d6a88000000b00279371857dcmr34300348wru.58.1673285014659;
        Mon, 09 Jan 2023 09:23:34 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id e35-20020a5d5963000000b00276d8c2332fsm10111428wri.108.2023.01.09.09.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:23:34 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pEvrx-0008rj-1d;
        Mon, 09 Jan 2023 18:23:33 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v7 0/4] worktree: Support `--orphan` when creating new
 worktrees
Date:   Mon, 09 Jan 2023 18:21:40 +0100
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
        <20221104213401.17393-1-jacobabel@nullpo.dev>
        <20221110233137.10414-1-jacobabel@nullpo.dev>
        <20221212014003.20290-1-jacobabel@nullpo.dev>
        <20221220023637.29042-1-jacobabel@nullpo.dev>
        <20221228061539.13740-1-jacobabel@nullpo.dev>
        <20230107045757.30037-1-jacobabel@nullpo.dev>
        <230109.86r0w328nu.gmgdl@evledraar.gmail.com>
        <20230109171100.6jj65aktyohtykid@phi>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230109171100.6jj65aktyohtykid@phi>
Message-ID: <230109.86ilhf1v1m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 09 2023, Jacob Abel wrote:

> On 23/01/09 01:26PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> On Sat, Jan 07 2023, Jacob Abel wrote:
>>
>> > [...]
>>
>> This round looks good to me, except for a small tiny (and new)
>> portability issue that needs fixing:
>>
>> > [...]
>>
>> Good to get rid of this.
>>
>> > [...]
>> >     ++		grep -P "fatal:( options)? .* cannot be used together" actual
>>
>> This is the new unportable code, the "-P" option is specific to GNU
>> grep, and here you're relying on the "?" syntax along with other
>> ERE-like syntax.
>>
>> It looks like the minimal fix here is to just change -P to -E, which we
>> can use, you're not using any PCRE-syntax, but just syntax that's part
>> of ERE.
>
> Understood. I have made the change and prepared a new revision already if=
 this
> is all that needs to be changed. I can submit it at any time however I was
> unsure of whether it was considered bad etiquette to submit new revisions=
 so
> close to each other.

It would be good to have that new revision soon in this case.

Generally, if you submit a series you're expected to wait to give more
comments time to trickle in.

But as a series gets more "ready" a re-roll can come sooner, e.g. in
this case where at least I'm fairly confident that this is (knock on
wood) "the last bug".

So once that version's in Junio can hopefully queue it for graduation to
next soon-ish.
