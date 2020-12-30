Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72406C433E0
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 18:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1F32220B
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 18:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgL3SKO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 13:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgL3SKO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 13:10:14 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB33C061573
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 10:09:33 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id q205so19408845oig.13
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 10:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=mOaNZr4N0uxfWUmPvlkPAoJprrbGx9mgoujRoTET70I=;
        b=OxRhl3boHFgAeAebjm2442FxpLQPTiq/gvh95I2Lfx7TSK2JnKliWX2mPPVyboi/Zd
         vwwX9GqJivIoAi0J5vMLtDmhBK3FwPT9SuCsBZ8sMPZZZigXpXnxlQsS8N9OLEuRGE93
         TV0iKqfEyvR47vK4ku2VnNjwdhWiOUc3YrfxN/Ent4qCXBSl9zuP/KAiFyIGy5v4aW1X
         wIyL84LzT1iVK7ziXw81rzj4+UW84DiJzN5i60VdvMFS7Qmdqeiunzm9zD7eLaHXuwgn
         k55bKsi2qMnvXxG/Bx+iSTRxsM0V5NgAMfEpz1K389hrzHiz4iN3mfUdOEPm8Alqc7OL
         jjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=mOaNZr4N0uxfWUmPvlkPAoJprrbGx9mgoujRoTET70I=;
        b=Q8qN8AreDTr+mVjIZH+iOBXW9RugPbahaS7NMN20yxD9dbLRDnWiZjm4Hq6JwQIyOn
         I6pSgcQRDhqfNTSePHJ08h7eQsiRUxSlPoxdT6LR4tkjxpwWGaU6UrSzjECYMTMmOho0
         Ee1jKsxw7RZrFk2ew/+hsIQ+iTt/BwOHNxs3HQRDFCMFx3QEf1kvvJrA1tRRuGIib1/o
         7338Z+PXCxRo9/n9xcHKMPstbqVPTyjG1LdqMH5UELuUQ03lRj0PLof/DPnx/YnpTcDV
         nKPf7JR0XJVcuIiJY8khGjsqaxBOqMseYMwVjbqnIMKY0kzSWpWlWjTfdqzm/q85ng+V
         wm6A==
X-Gm-Message-State: AOAM530CXQuKGT1BNFAoqVI4GfrJ+EjpuZoL3iCPg3v32yvUmFlrjznN
        5F4YlfKe53g+FfwPV56oSS4=
X-Google-Smtp-Source: ABdhPJwliGQ86KaKdpUQHY8aRgEe9MnhoQfz0d5zn2QkDcp14p5onoyIhLtHuukO6BzOPghReAUCjQ==
X-Received: by 2002:aca:4257:: with SMTP id p84mr5776984oia.68.1609351773059;
        Wed, 30 Dec 2020 10:09:33 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id j126sm10538003oib.13.2020.12.30.10.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 10:09:32 -0800 (PST)
Date:   Wed, 30 Dec 2020 12:09:31 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>,
        =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Message-ID: <5fecc25b369f9_879c52083c@natae.notmuch>
In-Reply-To: <20201230180008.GL8396@szeder.dev>
References: <20201229170837.297857-1-felipe.contreras@gmail.com>
 <20201229170837.297857-2-felipe.contreras@gmail.com>
 <1402dabd-089d-616a-ef79-ff1ae3fcb438@web.de>
 <20201230180008.GL8396@szeder.dev>
Subject: Re: [PATCH v2 1/3] completion: bash: add __git_have_func helper
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor wrote:
> On Wed, Dec 30, 2020 at 06:17:52PM +0100, Ren=C3=A9 Scharfe wrote:
> > > +__git_have_func () {
> > > +	declare -f $1 >/dev/null 2>/dev/null
> =

> > And then I wondered why use declare -f, which prints the function's
> > body, when there is -F, which just prints the function's name.  And w=
hy
> > repeat /dev/null when redirecting stderr when the more shorter 2>&1
> > would do the same?  None of hat was introduced by you patch, of cours=
e.
> > Anyway, this seems to work for me:
> > =

> > 	__git_have_func () {
> > 		case "$1" in
> > 		-*) return 1 ;;
> > 		esac
> > 		declare -F "$1" >/dev/null 2>&1
> > 	}
> =

> The Bash completion script should be usable from Zsh as well, and Zsh
> only supports 'declare -f' but not '-F', see 06f44c3cc5 (completion:
> make compatible with zsh, 2010-09-06).  The Zsh version included in
> the 16.04 based LTS setup that I have at hand doesn't yet seem to have
> a (for us) usable 'declare -F' yet.

Ahh. Good catch.

  declare -f -- "$1" >/dev/null 2>&1

Then.

-- =

Felipe Contreras=
