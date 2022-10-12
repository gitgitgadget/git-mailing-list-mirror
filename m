Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93BAC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 15:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiJLPLA convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 12 Oct 2022 11:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJLPK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 11:10:58 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158A021B0
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 08:10:58 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id s30so24931679eds.1
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 08:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYdcLKfBDTP6v/TOJ5Of9pmRW2RZTJokAhRd7MDjmMY=;
        b=GY/UFOx5QuM/4I4w/t99hMU8FrantgWy6Tfo93t4emhE6p3uZugJ+vPSVQpDXlPHQu
         nDL3GuS2wbH/UFaY9AceqWdt5+Cx+2w/W+BQ0bKtTzjLbs/xyqbjTctnlbZx1bIXqWEh
         ZuFjB+bvE7Ve3Mc2CaoT4Sgjl/XIbOaZ8GC2TbG0PWDa7f3Jf7QH1Hk4dwOOPlQJZ3Al
         QcUNluNrOgRQq+rWsWjGrQ6Dtn2qwy+LDoyojqMYC8zOX/tc3/LdFaGSO3Puzmc57KaN
         habDUQXpWe2MuNSO5eOYoZNBYfvtY79bnwoAdPPhdkjyBpZA7UKwav49aB1DU6/PJ4Gy
         G7Zg==
X-Gm-Message-State: ACrzQf2zkEVlSQCo8ZAD+vnAcjFgD3BHiY5hblmvD/jcEpYYnN4XWl2H
        6MMeetVZ6ZkN0g7qup0WejbbExREYUnNAjgRXbJw+9/G
X-Google-Smtp-Source: AMsMyM7fXB21Rz0H8pqx1G8vu2ow+NlxP1XMERegw1DKim6XGcugV/aEbmoJCYiXx1559qFw/GK+o0uDCkd14i1QKNg=
X-Received: by 2002:a05:6402:35d4:b0:459:348d:a7ac with SMTP id
 z20-20020a05640235d400b00459348da7acmr28729083edc.149.1665587456539; Wed, 12
 Oct 2022 08:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <CA+JQ7M-CN0UnHQDDDVz0kPcU1AcoL9+WFOeR8eiw_B=Yiyc-CA@mail.gmail.com>
 <221012.86mta1mmli.gmgdl@evledraar.gmail.com>
In-Reply-To: <221012.86mta1mmli.gmgdl@evledraar.gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Wed, 12 Oct 2022 17:10:46 +0200
Message-ID: <CA+JQ7M-y9d=c3GbpAs+Y4qtimtVs9oQ6BU1YL8nmFmF=rZxKag@mail.gmail.com>
Subject: Re: [BUG] git fetch fetches tags matching negative refspec
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2022 at 11:13 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> I.e. it got stuff you asked for, but also tags pointing at the main
> history, --no-tags will stop that, at which point you can *also* fetch
> tags, just with the refspec.
I tried but
  git fetch --no-tags
with negative refspec did not fetch any tags.
  git fetch --tags
does.

I'm going to set
  git config remote.origin.tagopt --tags
and then that's going to do what I want.

Thank you for pointing me in the right direction and giving clarity.

> I haven't had time to try this, but I believe this isn't a bug, it's
> just that you didn't supply --no-tags.
I guess then everything works as expected but maybe the documentation
regarding this could be improved.
