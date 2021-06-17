Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C2BC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 21:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0491860FF1
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 21:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFQVtG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 17:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhFQVtG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 17:49:06 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C91C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 14:46:58 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id m137so8153777oig.6
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 14:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=atK9L0JBv3EYsAdcdQZXNBC69CM7CZapxWYJx41lTkQ=;
        b=sGv3xl2c9F0bSe4WnLHdItmgSh5+BTEGh+zQifutwZD03arAiRSCE8QnBVLw9TQPW7
         K3V4k0oJyAaG0OU29YOM5HGgd8g9jvTiAnXJ7DyXkECVAE1R6Z+usGO/zQiYZ3krKasd
         n9Hs0L4gesPVefo1AkXiGTTAbyvH9PT3r+Gm8iukmUMChmiUm3lt5XeB+pYJ0RinuGuR
         isRhD53KDSFd9zji18S8FSmn3X7+KIar9xcCFBHCQvrp8K/IjsJkW+554xOVTaVNWK0I
         q1A9ml1oiC2ZxddYg8TTFCQBa8/cs0kyAeevArDHNmPzDGjIhAk37sPXDxK35eUZRZDP
         /Ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=atK9L0JBv3EYsAdcdQZXNBC69CM7CZapxWYJx41lTkQ=;
        b=aJTtK+8u7LGd+uhOjb063lcD4t5kUJtlXfkdKq0oSZBzbfiCh4c7xbdlQBgCtvoBhM
         aeMiLz7a91E1LuMLWkQlLKaLkq4buClzZgeUs9QiiiQwLaCYW78PRxY21PcFLC0UuuZw
         FU+WT3Zz7Bc9/vfk8NWLZMzrzV+bGyATXMWJU0UrkBhbCTSs9b+ft3AYDV/JrsW1ctdS
         j31yXDuE7xFcZDFA4baLKq7DLENvkQXs9owXlkCb+zmpc7MYYGt5qMLdzxsab34dFNqO
         vHNVTBjUryh6hhy0UNb/oeDmu1pRhS9op69j981bAS5fzRTshH7ZjqEc7YeNafZK5Iue
         k8dA==
X-Gm-Message-State: AOAM533lhq4YTwFlSFagT8aNwRrMn4dv6p53bk1l66Gxg4p4IYwKJO3Z
        /HPui9ZdgsLeMArykSelNQ0=
X-Google-Smtp-Source: ABdhPJwv5Ga7Oei36L9PFTLCrm708orDSOW4h3qLhwGdC3ORTUizJgTkebmT+EUrTO8IuAcEUKJPDA==
X-Received: by 2002:aca:30d1:: with SMTP id w200mr4820993oiw.16.1623966417433;
        Thu, 17 Jun 2021 14:46:57 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id y66sm1399520ooa.48.2021.06.17.14.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:46:57 -0700 (PDT)
Date:   Thu, 17 Jun 2021 16:46:55 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60cbc2cfde385_12992083@natae.notmuch>
In-Reply-To: <cover-0.4-0000000000-20210617T105245Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210614T171626Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210617T105245Z-avarab@gmail.com>
Subject: RE: [PATCH v2 0/4] show-branch: add missing tests, trivial color
 output change
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> This v2 doesn't change any of the code (see range-diff), but better
> explains the change per Michael J Gruber's feedback in
> https://lore.kernel.org/git/162374905722.40525.516266574605586007.git@g=
rubix.eu/
> =

> There's also a trivial grammar fix, s/add/odd/g.
> =

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
>   show-branch tests: rename the one "show-branch" test file
>   show-branch tests: modernize test code
>   show-branch: don't <COLOR></RESET> for space characters
>   show-branch tests: add missing tests

All these look good to me (I would prefer patch #2 to be split into
multiple patches, but that's not a deal-breaker).

Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>

-- =

Felipe Contreras=
