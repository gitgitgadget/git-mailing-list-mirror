Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C299C77B75
	for <git@archiver.kernel.org>; Tue,  9 May 2023 00:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbjEIALH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 20:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjEIALG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 20:11:06 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6483049DA
        for <git@vger.kernel.org>; Mon,  8 May 2023 17:11:05 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9659443fb56so794146766b.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 17:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683591064; x=1686183064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4fOwY3C1PCRI8NKqyDsE5sYRxzZMp7gFyJ8Wt7j7V0=;
        b=pkl2OQZM6YseP25ggHgk5YOhrB7OPHruzWt2blxdc61MMlkOxRg6EDqyjjexBbdYrC
         z2cJzoSm303KfIToU6fDhe/1WlJWLbc0l0T54wFubWAvSrl3f/XR3ocWv3+Qqjl8v+Fy
         SS8bvz7reMRjPT482Za8QSi1YlVDH8K2wGa/XGn4VUPR2suWZ43MqkXOHPJXVx9eDJcu
         h8rIy6DToDn6ndEhBhrOqcSHiZOHH+4uEBz/YNH9BjBhPg6j5MeHVpUe6IR/7LcY48at
         PI1m0SM9MTO3RJuzNBUDn44YgJ0SMIyf5HZburUePlyt31iIxrQBcHN6DHazibbtlEpW
         v2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683591064; x=1686183064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4fOwY3C1PCRI8NKqyDsE5sYRxzZMp7gFyJ8Wt7j7V0=;
        b=lPP178CwTJIU8TscXxGfJ1jT8KLj3U/kL2p2GPtZUaFOrDp/xl6RQEQzINNVEwCkVJ
         ceY42BrAQ4vKhm3TzY0s02MLf0plp/8AeN2+lVgVIz8IYhLG6d101AZXXQlN50Su/FaB
         JNAlU8bclShLvUNzW4lDNshJx7M/Vg1ua89q13MU5OI7b6rhgUcUlf/MwE9HLzIFQSm1
         ja8cSfbTebhhRyw+ukh4J55U6FJvN3zyzlnT6UTvjzsZ1mmgxlLeqBsI6aa04+Vv1SQH
         vsBoGezj3fQECKReX5RYar5DD2KmmWHZrBqPNNlK3BnRZQunKynXJuBMY54rtPGBNUen
         iepA==
X-Gm-Message-State: AC+VfDz02Zc0FXd6bLNlqAttDLb8ng6CPJKfTFarwnUOcMndObTQ92gO
        HaLNlfW3qCTuZe3FYrT6Kew9aPHsKmcrNVvSBQ8=
X-Google-Smtp-Source: ACHHUZ6Yc0FxOXLUP1/rlNfIaqcHzRyU2NfzZBiuXdTLdM0JrMisn5DzT6UFKzp1KRmOwGxX1jP7QwvALLojZ0j2mrk=
X-Received: by 2002:a17:906:c14f:b0:94d:a2c2:9aeb with SMTP id
 dp15-20020a170906c14f00b0094da2c29aebmr11528136ejc.49.1683591063581; Mon, 08
 May 2023 17:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683581621.git.me@ttaylorr.com> <a39d1107c1f3e9fbd859a23aed72e63bbd394fa2.1683581621.git.me@ttaylorr.com>
In-Reply-To: <a39d1107c1f3e9fbd859a23aed72e63bbd394fa2.1683581621.git.me@ttaylorr.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Mon, 8 May 2023 17:10:52 -0700
Message-ID: <CAPx1Gvft0pXehRHpRXrinsTTSaQQkgOL8YaBgt54SHnfsFo2NQ@mail.gmail.com>
Subject: Re: [PATCH 09/15] refs/packed-backend.c: implement skip lists to
 avoid excluded pattern(s)
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I haven't read through any of this closely (don't have time for it now) but
want to mention one thing here:

On Mon, May 8, 2023 at 3:06=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote:
>   - Construct a skip list of regions by combining adjacent and
>     overlapping regions from the previous step.

You might want to add a note to the code that there is no
relationship here to the skip list data structure (see
https://en.wikipedia.org/wiki/Skip_list).

Chris
