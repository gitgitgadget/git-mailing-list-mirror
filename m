Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A99C433EF
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 03:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiFXDjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 23:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiFXDjM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 23:39:12 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CBE63AA
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 20:39:07 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id f63-20020a623842000000b005252a15e64aso675506pfa.2
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 20:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=O5OXF2QKAQLeW5iwxX3X16foXSIk1jDSRHT4Six/1T0=;
        b=aMfC+PFENuRO6iuNOBhUU8Qupb3r174RDNIhxuhQiBal9VdJXIgy0ogfEHqAjmKgXS
         RDsWhEiy7TgUUfzO9EJCk4z+pcKXKUJDnLe6vE8wLipF53vCjOGFbUVxyqpQbJtglZgw
         zsnKBReOFS/6foZUfNDVgih9mMi9BDk3cIyX62U4hGl50CqNDpupwAWRmC1K56vDYOrA
         Cs5oj5wD/BNgmhdfGNUciWcXm0g7AwJ0WaueMWjTRp3Ca+ZTrEvCd9PofKMVxU9Rq1WN
         +xeXRDk/HtQ8T+CiudDbLXPb9DDh8ik9IhE3BL5aqAG3ZAlybq5bRCOzWisWUx7mXjkS
         IbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=O5OXF2QKAQLeW5iwxX3X16foXSIk1jDSRHT4Six/1T0=;
        b=5oxs9BdqMhTfgtvbLDnPEgkXhV83IOMEIiV3sl/T52psJrpCE54xYBoSPt2ZED9H8W
         52Uf4fFUs/ApPYeIC5v7ZVqosdRQy1i+YqoC9JglU9dhT31S/fkSXsR/Kf1WIUPkou1Z
         6sXcrQQXdW5nQLg9rR4S8L7pLc3EOjWDrQ0NUObc/E8kcGwW9BtSuthUlcolD26jCg3P
         B7xG5Tqr7xCzAmKrhdpRGEr3DkPSxIWJF7tsKiWJmv2RpztOOFOLEHIFNp/BIjt57T/S
         Ovq7qYiFRvOlzURAHybBRLQEmyxqJea99AMaFy0gY8p3wAdriXt2p2qOVFyV/YB8Dkqt
         HgAQ==
X-Gm-Message-State: AJIora/RaxeKfXWLRPpf2Z2OLJ8WcJHEoP/Uv4MxSBLFHgJozIKOvEvA
        NClqRejLDL1ctP5pQlRO/Hu6hKdA1SHL1Q==
X-Google-Smtp-Source: AGRyM1sMjuZ5xNeARre/z4ZBqO8axXwHhMUU91HiuI+UGGvFeG+v6tX6UFo1MW5vthYT9nDBDgWXn37HCe7HcA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr130887pje.0.1656041946736; Thu, 23 Jun
 2022 20:39:06 -0700 (PDT)
Date:   Thu, 23 Jun 2022 20:39:05 -0700
In-Reply-To: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
Message-Id: <kl6lh74aivc6.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
Subject: Re: [PATCH v3 00/12] submodule: make "git submodule--helper" behave
 like "git submodule"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> These are preparatory changes to make "git submodule--helper"'s
> behavior align with that of "git submodule". The next step after this
> is to get rid of git-submodule.sh entirely, and make "git submodule" a
> built-in.
>
> The last two patches here are post-cleanup of related submodule code
> that isn't strictly necessary, but good to do. Similarly this starts
> with the removal of some dead code in the area.
>
> The goal is to make these changes as small as possible, and as
> obviously correct as possible. This will help to make the meaty
> changes that follow easier to review.

Thanks for taking this up! I have some lingering confusion over the
behavior described in 02/12's commit message, but I am quite convinced
that 02/12 is good - the check that it removes is not needed for
correctness and it doesn't make much sense as safeguard for developers
[1].

Nearly everything else is very obviously correct, and I've
double-checked most of the assertions in the commit messages as well. So
I'm happy to give this my reviewed-by.

  Reviewed-by: Glen Choo <chooglen@google.com>

[1] https://lore.kernel.org/git/kl6ltu8ci7r5.fsf@chooglen-macbookpro.roam.c=
orp.google.com
