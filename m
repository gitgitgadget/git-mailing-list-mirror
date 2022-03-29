Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA90C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 11:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbiC2L2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 07:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbiC2L2C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 07:28:02 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32851C7F35
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 04:26:19 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x34so20293886ede.8
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 04:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yMom/YRLKFKXTR1QRR/814EWTWXGV4C/whibz/v+GrI=;
        b=R1entaqMot5Cp+07dBL8r1KLIC3V+Gq3JetwNQgiVA9ECDWa9Z3BGcZIkNBmIin6+R
         FUFKK8KlR6VS0sPTDisrlJeXHajuoN+PpMgfmMOFgyStZoxr+Iibj7wqlJc0DcPvff6F
         fNI9kuFqomQZSiiKeqy6QRhEio0QGULap0QHF4is9NtoJZ5+Uf9CODU1nfzJNn17hn5g
         npVJ8R+sni89IZfheQv9Xl/1FKTF4QwGedE05+2mQ6Nq7lPXTpGVoK/addFR9M2tOtHV
         23QPNrxxzoe37JbO3wpEijz846qJ7Yny/RaiBvrXs6JpvXSbvkUKvxB6NVKUFfZDUa/m
         W99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yMom/YRLKFKXTR1QRR/814EWTWXGV4C/whibz/v+GrI=;
        b=BfBej0YKjaTuF/JanHeVPfb0+MCuxAOH4ihsLZThgbJQ8x8E43tqF2HAtb+6vBRCFL
         BKaJOhM2kdl88istyx+AjX17ric+g8uYqssWDsq33uO8lcEh3Ij5T3GyKH/b5vJaweXu
         ZReq0nwpstWanM6nWTBvDLecQ/2tTm89y9XOtGeO7fdiJ8F5eBfTtEYgYt29gP5SkNR0
         K/jUNihLeiryCc+du0AoxzO/K1LXIdVB0R3sZUUes13okoj6hgojtsBM2vDMC9t2RfQ3
         LZBJRkJG0OxEl3vnruzAd4ocd1In6fg1wpK4bRMboDZxG7Ez3rWzgADB76zX7/73RCfj
         dsnQ==
X-Gm-Message-State: AOAM53194n+0GEv0HsosD/RSsREDysqHkXvgV/umgcnQW5FReNB7uDZH
        SMhpYXjqbrEtVsw8dXsrTewyLaD1QHfBKczS+Imiag==
X-Google-Smtp-Source: ABdhPJwIDYPF6SXDhEF99xqp1v2tPlibF2bvxE17Tyz5T/PIXL/OzLs6U/PpXAaW1nUtpiTSrB/JOJrqQIAt321eR/4=
X-Received: by 2002:aa7:cd81:0:b0:410:d64e:aa31 with SMTP id
 x1-20020aa7cd81000000b00410d64eaa31mr3944226edv.167.1648553178296; Tue, 29
 Mar 2022 04:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1183.v2.git.1647940686394.gitgitgadget@gmail.com>
 <pull.1183.v3.git.1648450268285.gitgitgadget@gmail.com> <xmqqwnge2ghe.fsf@gitster.g>
 <kl6l7d8et314.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqilry2dq7.fsf@gitster.g> <CAPMMpojYJ9sB7nbAAt1b_yH0Um1O-+TpSRYXTkZ6aDHobhS59A@mail.gmail.com>
 <xmqqo81p256z.fsf@gitster.g>
In-Reply-To: <xmqqo81p256z.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 29 Mar 2022 13:26:04 +0200
Message-ID: <CAPMMpogK_e8Z3QobtJTnrzY=MynF0kqbZJEv=cZgWzwUodQx=A@mail.gmail.com>
Subject: Re: [PATCH v3] tracking branches: add advice to ambiguous refspec error
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OK, I

On Mon, Mar 28, 2022 at 10:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Small things accumulate.
>

OK. I've tried combining Junio's "only do something when needed" case
statement with Glen's "co-locate advice-related string manipulations"
proposal, and I believe this disqualifies and obviates the need for passing
around any new "are we going to be issuing advice" flag.
