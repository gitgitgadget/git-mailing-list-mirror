Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AF4C433F5
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 15:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353824AbiDSPfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 11:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiDSPfT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 11:35:19 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63951834D
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 08:32:35 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id d9so15980295vsh.10
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 08:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BfHWPbzTjbjQtC2PV+LJVXfYT5Y1p5ZpbxKDM9UkroU=;
        b=Z2Ov8FtLIx1Pyu/rjlEywqoTgEBUkq74XUEJhQKyonF0wS3hzs1nGNQ1CK4A29Elik
         Js6ZmO8UhjQW2H4X8nHiXpNQhXapALXK3qFjDJr8Vx0/MgSbUfkERb3a16jZgdsxLbOp
         AM4i04IWYJ4Ci4uhDxKL9fKe/qoFzeuVB2JF7PZdwDfTt1tH8MIIucgWF/LHAzRQpYf3
         tBjPQPqnsYwjtqMkeN2Kz806JbUbp0++ASaL2NbcHur3E9swqzxRE33ho0nu8ZrduB0I
         NdNoLpCUT08DIDBssGXtTU1Ai2e38a1gMymPuV4PMIj60dA0kax9QDv+jllaX4dYZ3uM
         +C0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BfHWPbzTjbjQtC2PV+LJVXfYT5Y1p5ZpbxKDM9UkroU=;
        b=WE3MMzVIZWZ4tRRoZZRY2+NdqMx12n65VY3O8GWSsZsidzTYMM2eh5LLhgqitd5wet
         pgW9pH+i6gVVA0G+ZyV/Gj6asm2jXpyLk6WMK5IhuE3s3pA9vbiRXhtI1WjO6pPTBRI2
         KL8Mxhu84n6SPrTvh2AtXmvpcYBO75tIswsvijpLGawwEDvn9vQIekjtR7udbq0XXn2c
         oYG6bflrHhXwk7kA0tVtfKZ0u2tQCNHg/oPDRme1PzxDtj3yM37HdZRjle2aI2977jnr
         ppOHfSFZ/U/2egGLj1Gbw8N2d/fU3tZAjDHriE7+gAGnHcDeqFiUsW10A3MqAmld2qCl
         qWmQ==
X-Gm-Message-State: AOAM5320zLWbE8Pr8cjy+Ou52Yb8KgK5aRcGsBh42AD5Dw2Yb45JlWgS
        YlxSGYY8Jwwn4/OEqUW238gzIexgytkJ1ggRSSXgse4WCcg=
X-Google-Smtp-Source: ABdhPJxeDWIeMSs7Wlozbo0x2oGl953NY+K2hTMlU5EhF/5ccU78B9LxhwOzkcuwH0PlR8xaynHNzkwQ1zS+hjspNgg=
X-Received: by 2002:a67:f842:0:b0:32a:492e:332e with SMTP id
 b2-20020a67f842000000b0032a492e332emr4427758vsp.47.1650382355057; Tue, 19 Apr
 2022 08:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpojjs4sjKdN6DAJFSwERdjq9XQgi35CcqkXu7HijadHa1Q@mail.gmail.com>
 <f87a549f-540e-d0f3-470c-178c2fa141a5@iee.email> <xmqqczhe1jgp.fsf@gitster.g>
 <ba1ea459-5981-5972-36e6-913eb19c34b4@iee.email> <xmqq35iaz6n3.fsf@gitster.g>
In-Reply-To: <xmqq35iaz6n3.fsf@gitster.g>
From:   Martin von Zweigbergk <martinvonz@gmail.com>
Date:   Tue, 19 Apr 2022 08:32:23 -0700
Message-ID: <CANiSa6hEJMWPyfZ_KqgHcKXhMdT7doTnxkK7GZzf-QBh6DhATg@mail.gmail.com>
Subject: Re: Current state / standard advice for rebasing merges without
 information loss/re-entry?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 19, 2022 at 6:57 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Philip Oakley <philipoakley@iee.email> writes:
>
> > So, essentially, it's talking a small part of the rerere-train at each
> > step in the replay, so that it's more focussed.
>
> That reminds me of one topic.

And it reminds me of a discussion about first-class conflicts vs
rerere I had recently [1] (Philip's email hasn't been delivered to me
yet). As I wrote there, I think most of rerere's use cases can be
fulfilled by first-class conflicts. I understand that it would be a
huge project (much more than appropriate for GSoC :)) to add such
support to Git. I just want to make sure the project is aware of the
idea.

[1] https://github.com/martinvonz/jj/issues/175#issuecomment-1079831788
