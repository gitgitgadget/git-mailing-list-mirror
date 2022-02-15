Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44237C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 09:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbiBOJb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 04:31:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbiBOJb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 04:31:58 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E206AA038
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 01:31:49 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id z3-20020a170903408300b0014d891103aaso7991024plc.0
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 01:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=NLUoJfCcVYzwFJEmJtiDkNnklhpi6KEoDApmmLUeYec=;
        b=r9tGNAwHdBXAP0T9hL25X/Cklw9yhVgzDkujKmFnx31SXP777tDmEBLqJQ0yt/rSy+
         a13dO72OPrkDX15pmz0IV1CYOQCwPYAhoVmyk85lWydIaNNVN0Z/JRBqOz84lXEVNcVe
         zM+QUdG2s8pdKUx7rSUHFCxEsJnYiOcfFU5GByGwNf7kd32YK1vPk4kaVZ14nhHcbBFo
         BDEc0fizaQcl7rcDuqYOtQRunS1pjrZUQphSybE4NWTcPPF5zuAw5fWb1E7fAzNdvB+J
         8ihRBbvWZky2B4mN+GJWUBugXQvd7dk7ihqNIrKy2KZeE0HmCFDIQEn+YSmvCkaF/gD3
         DhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=NLUoJfCcVYzwFJEmJtiDkNnklhpi6KEoDApmmLUeYec=;
        b=6uoffrxkf7He4Ixsy6Ja3wI21ddkXDd7hI2bejH3AxTUZQ6HRDWlGueDF51vziZLaT
         JsINnc6Z5on+jiirPUWAaJGh5dX3fYK5es/wAa2m6Ee5Vx+WOWTHxH8HABqL4JGqLllF
         CHVY3AKEcS2yiyZ2M8jfx6lvRXQQz7ikt84LpZxcl/BkeZmCOhbIaTkT81o2uXRl5DB3
         FoH7qwWDBRwYh0OsXdWp91H/s67K/fAyxuNqF0+VUYJZEwTGh+++j1nwdiYOaIJGebmx
         2aGdr3ZfWfZWcxHjmz4mwseGpspXEnDZa1L1DdMFABvr+K9cHp8h4pdVSTZ1uq+hkEgm
         x4Cw==
X-Gm-Message-State: AOAM53224+xpi3rEtvBF0oR/O8oq7I0UNQ74M/LQ4/b7ZOEVOfvpNSLx
        AmsAsdlvuOLh+tvz3XzgD+nF5I3TJ05FMg==
X-Google-Smtp-Source: ABdhPJx/ZmXo7ondPjzPBoRHknFk+3BTCYlx+X0MJplNROPBNrRJ6iBTiM4LNxurQIZYP9TOxDJWDrQd7sXQUA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:a50f:b0:1b8:e6ad:f63c with SMTP
 id a15-20020a17090aa50f00b001b8e6adf63cmr355544pjq.1.1644917508200; Tue, 15
 Feb 2022 01:31:48 -0800 (PST)
Date:   Tue, 15 Feb 2022 17:31:32 +0800
In-Reply-To: <xmqq1r054aiw.fsf@gitster.g>
Message-Id: <kl6l35kk79xn.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
 <xmqqv8xj71mt.fsf@gitster.g> <xmqqr18770pc.fsf@gitster.g> <kl6la6et76bb.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq1r054aiw.fsf@gitster.g>
Subject: Re: [PATCH v7 00/20] submodule: convert the rest of 'update' to C
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> Hm, I haven't looked at where the conflicts are yet, but I'll get to it
>> as I'm reviewing the rest of the feedback.
>>
>> And on that note, what do you think of =C3=86var's suggestion to split o=
ff
>> the 'easy to review' and 'obvious' patches into their own preparatory
>> series? I wonder if this would make it harder or easier to manage the
>> conflicts.
>
> It depends on how small an interaction the "obvious and easy" part
> has with topics in flight.  In the best case, if there aren't any
> the preparatory series may even graduate before the other topics
> that interfere with the main part of this series becomes ready.
>
> In a worse case, what the preparatory work to lay more solid
> foundation wants to do may contradict what some of these topics in
> flight want to do.  Such semantic conflicts need to be resolved
> before the main part (and these interfering topics) can move
> forward, and with "split off", the core of the contradicting wish
> may become easier to see and what needs to be resolved may become
> clearer.
>
> So, I do not think of a way for such a split to make things harder
> for later.  Of course, the "easy to review" and "obvious" part has
> to be justifiable on its own, i.e. "a larger series wants to build
> on this foundation and for it to work this part must be done in this
> way", when the other topics wants to do the part in question
> differently, becomes a much weaker justification.  But if it is
> truly "obvious", it is unlikely that the benefit of the change
> becomes harder to justify.

Thanks for sharing your thought process. That makes sense, I'll do
that :)
