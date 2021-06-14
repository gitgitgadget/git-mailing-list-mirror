Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61D1C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 12:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88909611BD
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 12:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbhFNMEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 08:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbhFNMEi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 08:04:38 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E6CC061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 05:02:20 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id og14so16273668ejc.5
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 05:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6vhKo94AIX78vNUri3gPxIaFBl26JUX8vvsw3OxfnU=;
        b=TpstgecTGu3WIcZu+FQMO4QPUuNePyZpCcdarlSFQ9zzW3yhS/53IXa1Vrtl0DNE0z
         dqeGGGm7Z+7zDYFYtY8hGWKmvk/kAOehNw7ULRUXg3UpJz+xeWLa/npVZ8GfVMP9tlgN
         2QTfiZRvr3z4JjMk/BI2faTPLZCeYNSCJzYdN32BSIqyBce63OG9pX5JC7f4tlDCJkhZ
         oaAOE3ckLVhTCEmNS6yjOeSc9bK3ghqTwaWFRVs+4X85g44W0cQzdHAuqSMmdyBrz7ao
         CzBr06TvBuhN+4NswQgqAZThd8Ab8ZdKFbCx5vOempp4bv6teQpM2ZMnrxEgnTuDVh0Q
         tNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6vhKo94AIX78vNUri3gPxIaFBl26JUX8vvsw3OxfnU=;
        b=s0OhfZ/ivqA8uc2f68NGBLzuxoHicRMl1AqnUf8X2EhLXFS18RE7bNRiPl3D0gv1/C
         qG85n4d5WnMig9b9VDqKRtky6NrmBgrpU/J8K8DxWvrXg8MK9G43wvNofcTVxCj9U7Wq
         IA1SDwP/CUZRM9vCU1Ijj5WMyQWYP6jaSoHI5jQUP7BKdXam09jH1VfHYq+ERSwTMIeN
         TsC0L7hpTpcZFypb2/Yz75X/uv13tkeHO46oPUa81mJPw5sN5+Gqi66EQjE5SmITkuvG
         ttfKnDD9JTpMWFrcRy+bgszFpdY9CB7rKwKdvjWGUYSGcx5qi2EuMRZETin45RaJEtTf
         wzAA==
X-Gm-Message-State: AOAM532k9sJt1UEMJowDl2Oi/2efRDCQPGBFyf0iXcjKXfA9wmE1iNYo
        0Xg3kf+qPvaaPwpk2ejxYRWLSniVh+4V1X11KsA=
X-Google-Smtp-Source: ABdhPJx8JqFZvNfRV7HlPEnayvU8Hdx0e1udeEWT4YwmrOlEkx6IDFwOMf3qVdDsACsDri3QIp/B9EMcjfhoGdjuG6U=
X-Received: by 2002:a17:906:7c4d:: with SMTP id g13mr15055514ejp.216.1623672138555;
 Mon, 14 Jun 2021 05:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8QHL-6-DxoRKtx5cVp_DePxtWYU4CuBweYfCG1hGZZhaA@mail.gmail.com>
 <CAP8UFD0jiZuPvO-oYXw9PmVQ56tpYc9nxUxAjPQrc2f1qwEqUQ@mail.gmail.com>
In-Reply-To: <CAP8UFD0jiZuPvO-oYXw9PmVQ56tpYc9nxUxAjPQrc2f1qwEqUQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 14 Jun 2021 14:02:07 +0200
Message-ID: <CAP8UFD3=bt3BDBPHeuj+eyB=v0mU-MKtwN7ytvSqKLswEHgJhw@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 4
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 14, 2021 at 10:02 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Sun, Jun 13, 2021 at 4:17 PM ZheNing Hu <adlternative@gmail.com> wrote:

> > Since I am a newbie to docker, I would like to know if there is any
> > way to run the Git's Github CI program remotely or locally?
>
> There are scripts in the ci/ directory, but yeah it could help if
> there was a README there.

There is a "GitHub-Travis CI hints" in Documentation/SubmittingPatches though.
