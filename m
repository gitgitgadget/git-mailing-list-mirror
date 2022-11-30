Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3D9C4167B
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 01:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiK3B1Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 20:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiK3B1O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 20:27:14 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA23B45A28
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 17:27:13 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso501320pjt.0
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 17:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHK/Ehy3umCD8ylpkVTW/Wnu+I5d5D/ExETY+NOfjIE=;
        b=qxUoTrhCLnMy6m7s+UgDdPAc5Q27hN21gL9HlTCTuJjJJ2sb2ct1W0ll+aXbiUNGYV
         L8KyNyw6Dk9nBGYWCbt8RCrmxBLjbClHLjba9uvUZuJKR0iuOeXlqWONB3z8Z+vZ+nUc
         76zOC9ULf1iB24bodP8nAlLU82+GiOWKURJSflCvWHdj3FI/Zu+udffOkLPdBzebcgoH
         LjuYyvFHIN/2t3kc4j6v0e83guCQd9PWd8u9lb/Th1dsoHOUm31sBq6deHCAtug8SXGG
         gVcORw8KprQrJJIdgvfCorDDie6kAs7T4vyS6fs0QFQFwrTJ5MbZT4TLKvPOc0oRL/Aj
         g/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHK/Ehy3umCD8ylpkVTW/Wnu+I5d5D/ExETY+NOfjIE=;
        b=2B7eDyPm0LOkw+zt9aVNZnl0q5BGj7SjoL1ic2/DwqLXiGHY3KKDGh5ijKPBNO1GDq
         nB1rRh7XnW2MsJKFTiNAP3C0sNP0OALIKtnoDAiRAAezVaAMGnrdxhKFC1sWFLKrckhT
         pVD+EllfCGXwpoSuRASGzh4jHpWZcKRc6Sykmikbj/BQstyz4RKPclDOAkinAHTv5SOM
         PBciMsFIlOQpqS3OVOva8Fv9wX4fuS1wnWQHemR6vMJSQdlCA1mm2Uc+Od6s21+I2Nli
         veDr/Bqil2tzRM/ouoCj2CYs/5T/GW0yaCh0NDvh3JZwrkuh6mNR+90KdNoxS410rlU4
         W3XA==
X-Gm-Message-State: ANoB5pnVPrQVWrMo4XNiofoAeVoSTnCZt9ZuUPSrJKA5unIbC5fNnp49
        YP1ML+bNJ23wJcJ203Wa5iM=
X-Google-Smtp-Source: AA0mqf51KcO326dtN9T9VQDWeOp3Trh3BOGajlJ0lQn4TNBtS+Ds9b7o3dZYQXAQZWjV0zFfkcDaAg==
X-Received: by 2002:a17:902:7402:b0:189:579e:4ef9 with SMTP id g2-20020a170902740200b00189579e4ef9mr30243378pll.86.1669771633198;
        Tue, 29 Nov 2022 17:27:13 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902bd8300b0018689e2c9dfsm11486366pls.153.2022.11.29.17.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 17:27:12 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Paul Smith <psmith@gnu.org>
Subject: Re: [PATCH v2 0/4] Makefiles: GNU make 4.4 fixes
References: <20221127224251.2508200-1-psmith@gnu.org>
        <cover-v2-0.4-00000000000-20221129T140159Z-avarab@gmail.com>
Date:   Wed, 30 Nov 2022 10:27:11 +0900
In-Reply-To: <cover-v2-0.4-00000000000-20221129T140159Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 29 Nov
 2022 15:09:13
        +0100")
Message-ID: <xmqqr0xl1bbk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> GNU Make 4.4 was released just about a month ago[1], this series picks
> up & amends a change from Paul Smith (the GNU make maintainer), and
> then fixes another bug in our Makefiles as a result of a
> backwards-incompatible change in how $(MAKEFLAGS) works in 4.4.
>
> Junio: I think this is worth considering for merging down in the rc
> peried.

"in the rc period" -> "before -rc1".

Yes I was planning to merge down Paul's topic which was very much
minimum and obvious.  I do not think "while at it, make it less
