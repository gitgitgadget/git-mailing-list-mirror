Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A85C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 16:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242989AbiBQQOk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 11:14:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239199AbiBQQOj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 11:14:39 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF5016A5B2
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 08:14:24 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id b5-20020a631b05000000b00373bd90134dso555757pgb.22
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 08:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=LzGMXWZC9C3Q/C5PWk7+ulkDLUVbPywhb5amZtUR4CE=;
        b=b/sFsvGhuxBpj+/n3FrY5ZNF542GlDkI6c0Nvt16pIiIrHC39N54PkBgv23hESykoc
         Lb8zB3ki3ai7Lnzctg2fJBCS/tpNcygq73WxIJgEa0HEk/+kcT51sfXT/yxywIDkrnz+
         2JDz2YoDilRp2E0ahdAytY8czbE6RoIobqPLM1F+ssCvIqvgELpAzRpcriG2+mIDbjA1
         5fTB+o9mt+N3fZRbfVSNUpr5Wc4j63VY016mmJQl+N3St2p/Pm90yc8SDXxReNFQ+mo6
         trr7Jx3T+jPDDhUpbB7WaUSYTF9WPWQ+eKZwLDzXydsTs7q/IrSSL3WG+56tcujXvewc
         LK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=LzGMXWZC9C3Q/C5PWk7+ulkDLUVbPywhb5amZtUR4CE=;
        b=MMAEBomeOdTZNycSrouw/FmZ+LpWzN+z//vzK6zgvjGSTIu9o5+5RGMTr9CAks67xG
         OPR2TvL95Dbr6SQsjsWkwB7klIH7hM0HqiBUfJVHQy+o5l3L8iGc9wOlgaslvg7tDL4P
         9KUkX7D0dAjJujycH5XhDmNLG21hKNDxH5vQzP8USl6FI4uvviHcy7MVTgYJSranNESU
         dVBjr0TB34yY4Ui2CKkm6XRVy9VVqj6ZyI32sV1ndohoPnkga8D7NhW/+/06phUKrjcj
         0eYd4fCBc4yw6Rw5aU3Dl0uJY2N/ovtSoA4RnyaVXJXx/W4+C0nw8DsXQX7XIEClXPYa
         lLsw==
X-Gm-Message-State: AOAM530Aw28qvetn/MV6M0lp6r3O7Uzjk45IVsti1DhZ/KLbRX7ogaXA
        6EQsoaWvN8qIHwrXXJqsmhAY+4hgPXtCvg==
X-Google-Smtp-Source: ABdhPJw1FPMANwJ+0uXNKWABPTbdAn3QhFRdJG3OcCcNRu2AVMfdvyy2P9NCguHXhve21knsoyAn2pWCPn3XJQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:7f93:b0:1b9:ef73:b2df with SMTP
 id m19-20020a17090a7f9300b001b9ef73b2dfmr34775pjl.0.1645114463451; Thu, 17
 Feb 2022 08:14:23 -0800 (PST)
Date:   Fri, 18 Feb 2022 00:14:07 +0800
In-Reply-To: <220217.86r181j1g3.gmgdl@evledraar.gmail.com>
Message-Id: <kl6l1r015v3k.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
 <220212.868rugxhq0.gmgdl@evledraar.gmail.com> <kl6l4k4y59p4.fsf@chooglen-macbookpro.roam.corp.google.com>
 <220217.86r181j1g3.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH v7 00/20] submodule: convert the rest of 'update' to C
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Feb 17 2022, Glen Choo wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> On Thu, Feb 10 2022, Glen Choo wrote:
>>>
>>>> Atharva Raykar (6):
>>>>   submodule--helper: get remote names from any repository
>>>>   submodule--helper: refactor get_submodule_displaypath()
>>>>   submodule--helper: allow setting superprefix for init_submodule()
>>>>   submodule--helper: run update using child process struct
>>>>   builtin/submodule--helper.c: reformat designated initializers
>>>>   submodule: move core cmd_update() logic to C
>>>>
>>>> Glen Choo (11):
>>>>   submodule--helper: remove update-module-mode
>>>>   submodule--helper: reorganize code for sh to C conversion
>>>>   submodule--helper run-update-procedure: remove --suboid
>>>>   submodule--helper run-update-procedure: learn --remote
>>>>   submodule--helper: remove ensure-core-worktree
>>>>   submodule--helper update-clone: learn --init
>>>>   submodule--helper: move functions around
>>>>   submodule--helper: reduce logic in run_update_procedure()
>>>>   fixup! submodule--helper run-update-procedure: remove --suboid
>>>>   fixup! submodule--helper run-update-procedure: learn --remote
>>>>   fixup! submodule: move core cmd_update() logic to C
>>>>
>>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
>>>>   builtin/submodule--helper.c: rename option variables to "opt"
>>>>   submodule--helper: don't use bitfield indirection for parse_options(=
)
>>>>   submodule tests: test for init and update failure output
>>>
>>> I think sending a version of this with the fixups squashed in as a v8
>>> would be good, and perhaps addressing some of my comments.
>>>
>>> I don't know if my suggested split-up of "prep fixes" into another
>>> series would be a good thing to pursue overall, perhaps Junio will chim=
e
>>> in on how he'd be most comfortable in merging this down. I'd think
>>> splitting such trivial fixes into their own series be easier to review,
>>> but perhaps not.
>>
>> Combing through the patches again, I couldn't really convince myself
>> that the patch 4..9 prep fixes make sense as obvious standalone fixes,
>> except maybe:
>>
>> - patch 4 submodule--helper: run update using child process struct
>> - patch 8 submodule tests: test for init and update failure output
>> - patch 9:  087bf43aba submodule--helper: remove update-module-mode
>>
>> But, since the 'final' patch (ignoring the fixup!-s) is consuming a huge
>> chunk of the work anyway, here's an alternative patch organization with
>> the fixup!-s squashed:
>>
>> =3D Move 'easy' and 'obviously correct' code from sh->C
>> - patches 8-9   Cleanup and introduce tests
>> - patches 1-4   Refactor existing functions, which enables..
>> - patches 10-14 Move 'obviously correct' pieces of logic from sh-> C
>>
>> =3D Finalize move from sh->C
>> i.e. combine "run-update-procedure" and "update-clone" into "update"
>> - patches 5,7     Cleanup and prep
>> - patches 6,15-16 Shrinking the diff
>> - patch 17        Implement "git submodule--helper update"=20
>>
>> I'll send this if there are no objections :)
>
> Yes that sounds good, or rather, I haven't re-looked at that in detail,
> but I think if you think it makes sense we should go for it.
>
> Or rather, we should really be aiming to produce a patch series that
> makes sense in its current iteration, as opposed to optimizing for a
> diff against some ad-hoc re-roll I produced a few versions ago :)

Agreed, makes sense.

> Thanks again for working on this & picking this up. It's great to see
> progress in this area!

Thanks to you too for getting the ball rolling and lending me your
thoughts :)
