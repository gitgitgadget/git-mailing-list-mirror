Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860C1C4332F
	for <git@archiver.kernel.org>; Mon, 23 May 2022 10:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbiEWKbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 06:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbiEWKbf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 06:31:35 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE668CC7
        for <git@vger.kernel.org>; Mon, 23 May 2022 03:31:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id p26so18504596eds.5
        for <git@vger.kernel.org>; Mon, 23 May 2022 03:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=G7mtyZpeIIT4lMPXa9qJ4UOUP7avYtqYhPn35yIiiEU=;
        b=KtI7fN+f6q1R6Zp/u/Efrmyyg4zbCHUAIbtCPX0f1ADoutOLFff9hzrYLIxDXnoUGO
         xtEX/cNW/u6Vl7afX8bK7T5fj8rGGmjQeLA1OQ/J5UC/c9VZF+awEW4WggMt5UV/inux
         B3XLUF+0GiWEOM+ByO+xLs6OiD8Yhg5676SA7Eqm2W6IajC3UqIXnza9ICiQEQsqJ+Dk
         Zol2NNl0de1HWfXzhf0AmBd04RBTbEi8OBH7GtfNW0xR+mB3niW2qoFcTLTWBPi2XPmw
         XJ5CENtFgaoM7ov2lZtxAbl8FSfTtz3y6QSqPijtbSJb4x48nRBAGrYqExpGg4YfB0VS
         gumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=G7mtyZpeIIT4lMPXa9qJ4UOUP7avYtqYhPn35yIiiEU=;
        b=nO1uVNR3S+k5QHizI9CvQBnKP6b5Z1DU9mBdmRTi4OaPle5UKSBxF34+U/tx0tEqK6
         LXlfB7lPp9rpngYj5U9szua74/Z3HtdyITilSp+A07r/HmZaJqgePH324DUjyZxGOj6r
         oCT9G3lED6hp5fPHL7Ka1Xt93ylIrZeSww19eH7I0mBL86J2j1DqVNYPvatQwiTe4FHp
         f6+Lm+JMBhXUAeyW7J02N2ixZEg1u1xszx3z0P15cfncMl1yS8028izUoTimp1yhJlGW
         F9N7qumorEUbcBuZsQ7OQKz32iajKP1jKbxiZyfnrxJBmDJysts333R+O8oVm0TxT/R0
         xzFg==
X-Gm-Message-State: AOAM5332PmDmsNJKwCuad8P1nrbbVmUpF6n0eEKo3XLInFx9Evqq2Le1
        Q63VeZ8kQt9jqd4SStYKWvo4xKtiyo0=
X-Google-Smtp-Source: ABdhPJyVANEAiar5GsxbYXL4i80mPi6gbAER+wELWD8lj0j3V1tAFBoSOlsqITfEugrI1Iv5wGqqjQ==
X-Received: by 2002:a50:fd87:0:b0:42a:bbf4:b992 with SMTP id o7-20020a50fd87000000b0042abbf4b992mr23597251edt.212.1653301891716;
        Mon, 23 May 2022 03:31:31 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id jp10-20020a170906f74a00b006feec47dae9sm723377ejb.157.2022.05.23.03.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 03:31:30 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nt5LV-002tJU-Tv;
        Mon, 23 May 2022 12:31:29 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 00/15] Finish converting git bisect into a built-in
Date:   Mon, 23 May 2022 12:22:52 +0200
References: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
 <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
 <a6e77222-6a95-992a-892c-7361d5568784@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <a6e77222-6a95-992a-892c-7361d5568784@gmail.com>
Message-ID: <220523.865ylwzgji.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, May 22 2022, Bagas Sanjaya wrote:

> On 5/21/22 21:48, Johannes Schindelin via GitGitGadget wrote:
>>  * When a bogus command is provided, we now error out instead of trying to
>>    start a git bisect run.
>
> Ah! git bisect now behave like other shell commands where bogus
> command is given, instead of "accidentally" start the bisection.
>
> BTW, do the current version of git bisect exhibit that accidental
> behavior?

No, this is a fix for a bug introduced in an earlier version of this
topic, but the more general issue remains. See
https://lore.kernel.org/git/220521.86zgjazuy4.gmgdl@evledraar.gmail.com/

Rather than a surgical fix for a specific issue I noted, with the
initial report being:
https://lore.kernel.org/git/220223.86v8x56g7g.gmgdl@evledraar.gmail.com/

This topic could really use some confidence building by adding new "git
bisect" tests. I.e. let's have tests for what exit codes etc. we emit on
various valid and invalid "git bisect" usage.

We clearly don't have that since the proposed v2 would have introduced a
regression, and this v3 would also have done that in other cases (while
fixing the one specific case of "-h").
