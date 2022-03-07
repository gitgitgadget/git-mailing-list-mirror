Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB6CC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 06:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbiCGGSC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 01:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbiCGGR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 01:17:56 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DA15F269
        for <git@vger.kernel.org>; Sun,  6 Mar 2022 22:17:03 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id kt27so29660560ejb.0
        for <git@vger.kernel.org>; Sun, 06 Mar 2022 22:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g7WJx9LyZisgNSy/thfwMmy0ddk2fKfXExBAKU63cSQ=;
        b=SOrYF7b7uJ6dcpAmw+HW/9I/5zaCACjYVzi75kJ+DyAGNOJ/pIxAjTgNbsUt7X/DKb
         x1mQU9xIgasSXFPZurS22WAfV5p230H3YGA56heNaTpfa7KG2exg1JfQrIm2A5EcOUbz
         EADfX8K3Zm47Wwq9jHYYjeCjMAN7YsEvqMs6QWojSEwAqesVZ3ci0N6i8tPcb1xWk7/p
         jshEAzBeWUEK0cyAGbFgto6mVU2a5LE2a1J2MWTNS/4iTPKfItAAL7HF587MN0qsVEUv
         8DEkzmHLX3XfLPFvtPgRfBJ+kKTq1EbWe+VmWPwSYFhn/fjWDVO/PsbwJTtJHS3m2Xka
         wm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g7WJx9LyZisgNSy/thfwMmy0ddk2fKfXExBAKU63cSQ=;
        b=iBbyABHdk8KK8w0YQsqwCRMVdSVILgggGjY0kl3Q0kUHTIpFHf8V/aQVEx18qwDuIn
         qsb2/sk8IIy+m9RCyZNMV0e6pTgD7LJ/VZYoizQ8aAaglzMOn62C9nNSBbtkPMr4eDUH
         aC83YaCNtOhRmi9B2Amzc6t2/FlVWd/HG2hDgIvyGn5c33Gj2gwbrRpWjagHQy7d2CpQ
         uwKpADSNUgsdSY6O2kjipXQ9oJazmdGXlJFn2tuFHUqWL41uOUrYtSp9x2DFpdKnJ61Z
         3abC911X0qbaWsAuG06c5bGyAL6Xy2x6R3x/J5JUP31bz7X2IjXn04nDYx0kK74Ouraf
         UL6A==
X-Gm-Message-State: AOAM533hBsUusV3pz4ixamOvQros2olrUu1WrzKwTIv0260ehareiZzn
        7yGyOGnf5XWPP+7nNsfiNgvCi/JqwksT8ozfTD7la/vFc29ppQ==
X-Google-Smtp-Source: ABdhPJzmXHy1uMuLMgTjx/10JJSiSIUyux5YO9/b5By9UJexoivTgY/UxwwajgoFGbv21Z/wXmzIpRjGHeG5wsoviog=
X-Received: by 2002:a17:906:4ad9:b0:6cf:93f:f77e with SMTP id
 u25-20020a1709064ad900b006cf093ff77emr8016771ejt.558.1646633821841; Sun, 06
 Mar 2022 22:17:01 -0800 (PST)
MIME-Version: 1.0
References: <CAPMMpoiTJAuadBEOPWOVa-kguSXMDvAhvD22B63QwYpu=H7xEw@mail.gmail.com>
 <220303.868rtr42mg.gmgdl@evledraar.gmail.com> <kl6l4k4ek73o.fsf@chooglen-macbookpro.roam.corp.google.com>
 <220306.86lexm3lvr.gmgdl@evledraar.gmail.com>
In-Reply-To: <220306.86lexm3lvr.gmgdl@evledraar.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 7 Mar 2022 07:16:49 +0100
Message-ID: <CAPMMpojkNuO6f8Q6qZL=gkJzBi2Rr5qZd+qs7ZXD9Syz5214Vw@mail.gmail.com>
Subject: Re: What does it mean to have multiple upstream tracking branches?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Glen Choo <chooglen@google.com>, git <git@vger.kernel.org>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 6, 2022 at 8:46 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> What I'm asking about is that Tao Klerks notes upthread:
>
>     Now we support multiple entries being added as a perpetuation of an
>     existing branch's setup - but what does it *mean*?
>
> As far as I can tell this isn't the case, but I only dug into it a bit
> (I instrumented the relevant tests to start dying if there were multiple
> "merge" entries).
>
> So I couldn't find what if anything changed here recently, but I'm not
> saying it didn't, just asking for a clarification. I.e. I didn't find
> how "what should we do with this config, if any" had to do with "Josh
> Steadman's[sic] recent work on --track=3Dinherit" (re "[sic]": it's
> "Steadmon" :).

Sorry - the code that handles branch merge entry creation during new
branch creation was modified by Josh (my apologies for the surname
mistype) as part of the "--track=3Dinherit" work. The previous existing
functionality only ever dealt with one tracking branch to be created,
but the *concept* of inheritance had to deal with "what if there is
more than one to inherit".
