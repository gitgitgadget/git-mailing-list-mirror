Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EAEC433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 12:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJNMdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 08:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJNMdA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 08:33:00 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918DD18C410
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 05:32:59 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id s30so6662782eds.1
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 05:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e+tQrFusN6LT1EaHEDs3Y//PGDQ1q+qDK8RBaLcZupc=;
        b=No25Z8FyrGzpocLp73Ycyp9MYaW31exFJOLPmF7dPJdYekWuJZH+INPClTLLb6W2lJ
         MGtvqn/27kGxZi2HBDBQ1BOYIBmkcXqWQCaJa2htzrYQ5+UVJ/iiMxQBk7bOnFOTsonI
         yD/TXKINk1zM0KTvekHedJ2FlBbCfnbI+D+HM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+tQrFusN6LT1EaHEDs3Y//PGDQ1q+qDK8RBaLcZupc=;
        b=dPuUFw0alzUjqAaw5XzDmGuXX8oCqF6pDBft9Y2UBp7h6mVlin57n3urKxhgYrfJ3s
         lFqBxGkYxv53s9z7p9HL/DwEs0jNVnKFW6kH86Mz1GNl11T+LnFs0qkYt3kND+L3BBGg
         pIxo+3Ih8U2DLtYZ9cjSHuIWx2ExLdFagmD0U5sItzxa/2z0Gvq0DLP+1QaGw4h6M/gK
         rhNRoORo7mCn49QaNlPlBekl8UoROUeEyTCVwf0Twg8PJvbrSBzzGemWDknoeyrbRldZ
         5Q8y8CnFA4jjSWhayUTDoNL6qWyrzODYyrn9NEuXf5mUqVoLtXRkWgH8lAmY+0BTWxwH
         Q52A==
X-Gm-Message-State: ACrzQf3EkkAdUgkw6gbQWfHeMxTSYxdZq61qAtEiYLv93hd6oOver/0J
        QxvLvF8FqTdCKhm18/v243Uv1snX/L3TCq9TIcFFbA==
X-Google-Smtp-Source: AMsMyM54FaWjDtpRheQt3edoCJSJtfW7Pi41ZLw+fevmmsUxWGrO5NfC2o1LHPgYV4u1cxsozK7fWqmeil5F+Ov2l+E=
X-Received: by 2002:a05:6402:2706:b0:459:788a:355b with SMTP id
 y6-20020a056402270600b00459788a355bmr3977661edd.315.1665750777993; Fri, 14
 Oct 2022 05:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1381.git.1665590389045.gitgitgadget@gmail.com>
 <xmqqedvbcrnn.fsf@gitster.g> <CAPMMpoigKVzhXu1WqSrx13MP1jR0J+ajkwRVVtY_LwHYAoWeTg@mail.gmail.com>
 <xmqqsfjqbwil.fsf@gitster.g>
In-Reply-To: <xmqqsfjqbwil.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Fri, 14 Oct 2022 14:32:47 +0200
Message-ID: <CAPMMpoiwnLyqzBBubkgSpjyJQqSeEVdoZy72FAwGDbMgg9UXxg@mail.gmail.com>
Subject: Re: [PATCH] mergetool: new config guiDefault supports auto-toggling
 gui by DISPLAY
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2022 at 11:11 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Tao Klerks <tao@klerks.biz> writes:
>
> > 1. Why add an OPT_CALLBACK_F arg handler, rather than keeping a simple
> > OPT_BOOL arg type?
> > Because OPT_BOOL always overwrites with either true or false, so in
> > order to have use_gui_tool retain its "_BY_CONFIG" value in the
> > absence of an arg, the explicit arg handler function is required.
>
> That is exactly why you want to initialize the variable to something
> other than 0 or 1 (say "-1") and use that as "not explicitly
> specified from the command line" aka _BY_CONFIG value, isn't it?
>
> And once you do so, you do not need callback and you do not need
> enum.  The original "int" can take tri-state, (unspecified = -1,
> false = 0, true = 1).
>
> Am I missing something?

Heh, I guess one of us must be, and it's probably me :)

My understanding, from ad-hoc testing, is that using OPT_BOOL causes
the target variable ("use_gui_tool" in this case) to *always* be set
to either "1" or "0", regardless of whether the user sets the main
flag, the --no form of the flag, or sets nothing at all. As far as I
can tell, OPT_BOOL never leaves the original value, so it cannot be
used to track tri-state "true, false or not specified" logic. Maybe I
made a mistake somewhere, and that's not really or always how it
behaves.

I can re-test, and/or try to dig into the option parsing logic to
understand how it works - the time I tried, I got hopelessly lost and
was relieved to find that OPT_CALLBACK_F existed and seemed to be used
for exactly these kinds of use cases.
