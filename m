Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896D6C433DB
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 17:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47DE02220B
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 17:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgL3R7G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 12:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgL3R7F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 12:59:05 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA63AC061573
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 09:58:25 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 15so19427064oix.8
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 09:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=R8Lww7Oj/2By72Xt8Vy+UY0QN91irReabSy86iUxPYY=;
        b=U34LFss7dihwn5Eb1+wDuBZizJatiFFXSGAVyjSaeh7xnV3XpO5SPtj4DWtgKb5CUe
         cPz4uELWC4IrEwUW+1xrFPeunzoLDd6qna38+t0qr5YSoztvoLwgjBjdbloX4aukSLWf
         rm7Z7XR24PHBrn93MNFT8RbzuPy08V5kom9/Zd3DdtYGUfh8zZ24Bk7qz7RMGFJBdL+R
         fe/FQ9Vij3YUk+MeknTcsTI9adByzjN5973JyF/DHDvlSmqcf/txBgskxPo1OK3tJspM
         79qMxss7GQ0stcfo9vL7viyWTnqOLcfLccGbSVllsdBRZKo/0G+xzBNjdbwJflxxcEkr
         /jhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=R8Lww7Oj/2By72Xt8Vy+UY0QN91irReabSy86iUxPYY=;
        b=Sj2+1oAJhYur2bgsDOL/QCk2u/EvewsjlSinqsVHQK4J/Ax4wDg6WtO/Q9hjg6byjo
         UEJ5OKJVwZqV3vbrdcM5GRb+Khm+83dQ4AUa3oFSzOGBif0TmKdThIQTDjWCek93CBOt
         fccmPApcubhmmmlCsqA7+fVQ6ttc9ibKnWikKiKJiytAUYyFFoN58Y8sXlLZJhUMzmMb
         d8N5FYrclZ3smIRirJPm7W3hpcZ0OkvNNnLJuVXQUMCHX5KBLHi1es6Y/cR23iEmNIjm
         l5SCXIcaHHWFCfp2EfxHYkSJxtB/w8pR2Gl3vwbP0oRyblIHMfYibx9/2mxBAm9xezSh
         EL3Q==
X-Gm-Message-State: AOAM532KKY/UbdNyvHjYWR4FQk5Jz0c7FPTi833kUSwfs7v1XAL13VuQ
        zk91sx10GcRCbD26czmQ1GE=
X-Google-Smtp-Source: ABdhPJzVOeS+ahtks28wsW4x7aOGVyS+ESyLkgRhsvQoHSnA4W21tYFF9FcGeufI+OAej5tu/QZ6Mw==
X-Received: by 2002:aca:5653:: with SMTP id k80mr5986042oib.0.1609351105119;
        Wed, 30 Dec 2020 09:58:25 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id p18sm10406571ood.48.2020.12.30.09.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 09:58:24 -0800 (PST)
Date:   Wed, 30 Dec 2020 11:58:23 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Message-ID: <5fecbfbf46fe5_8775920846@natae.notmuch>
In-Reply-To: <5fecbb6b2f9a_871cb208f6@natae.notmuch>
References: <20201229170837.297857-1-felipe.contreras@gmail.com>
 <20201229170837.297857-2-felipe.contreras@gmail.com>
 <1402dabd-089d-616a-ef79-ff1ae3fcb438@web.de>
 <5fecbb6b2f9a_871cb208f6@natae.notmuch>
Subject: Re: [PATCH v2 1/3] completion: bash: add __git_have_func helper
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> Ren=C3=A9 Scharfe wrote:
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

Actually... How about:

  declare -F -- "$1" >/dev/null 2>&1

?

-- =

Felipe Contreras=
