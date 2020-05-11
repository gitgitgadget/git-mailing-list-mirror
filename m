Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CF9C47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 06:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5D7A2075E
	for <git@archiver.kernel.org>; Mon, 11 May 2020 06:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpVzy2t+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgEKGrG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 02:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725863AbgEKGrF (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 02:47:05 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B45EC061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 23:47:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id z5so6167314ejb.3
        for <git@vger.kernel.org>; Sun, 10 May 2020 23:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J4/KmWxMlPWQHPQmDbGQe/7yM6Air5ckhLnPJRxJl5I=;
        b=gpVzy2t+P6lLfKTbAkIfGH1t4vIQJuP/hHNWERSuH1moaJN0CY6RxXW1K006g1usAd
         K5K06WSeSXHxaGnvj+FH3pF42btAo+0GAgrhBXoJV7cErcwene4Kn0MhyKkFWOHrZcJj
         ihLNEgW7hL4gG0qS6TlfFTAjNpmzixNuWsBtM9NH7oFy4VPYirlZL2szWWMH7isJtzTP
         48DBbhv6prApWS/rHIrZtO8C1QYwjqdlX8XeRNpbzAeisI0LOOcb0FFyS7wbwwnhqqW/
         hkJVn0kb2ngat7z6rrecYFdrtFtpLyC9rKmGZrEAHa0xg2mll2E4/bmkg/DlOt8FJczX
         L2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J4/KmWxMlPWQHPQmDbGQe/7yM6Air5ckhLnPJRxJl5I=;
        b=qQoCORm6LzgtCnXzDKY8fAngylOMo9B6UCdHOPtD4u/v53OWjC2vSao3TySGkWL9Fk
         d+nwb4Zy9uK8OokSGv5OF2IL/SoaDz8lcp39nRzGgdHftJf7ta35uru0RZEDNK5YGKG+
         cc7rD7OA0fs9ziD3nOeqhjGyxg3bEEusBEQiOMdLH59cC2fWYJvuub3oQvTWuIoxA4ha
         R8t/1CqPSnK3vp19YQOn9hRr4CPC9XhiX0+DkAkC0jSbo37lrno0Z/lLPwugr4SbTePI
         zOMNT28Ng1bCtHoetlDnKokcUTwsK3qYxRalu9qeuS/qHcpB3Rst/zM9g0bPups358AK
         dp6A==
X-Gm-Message-State: AGi0PuYspC4GWJ9RJQ/xYtNimeiTjRw+Z2gyszn+22WhLbBCH09T7sZG
        /RihNJ/orfCosvsFV8fMVbDh7q7hvCWGNKEBrG0=
X-Google-Smtp-Source: APiQypIgPnr+x6BUA4S09pp4sqkbLB06T6rvbtIYsxJ0uwtNSVjjbpFYaMdEhq6p4qv2vZ3YIlNJnYtNa7KJF9nAOi4=
X-Received: by 2002:a17:907:4063:: with SMTP id nl3mr12528200ejb.237.1589179624116;
 Sun, 10 May 2020 23:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD1iBxiOZ_OA4DbMF9Kx2UHL15TPygoX6x-JrDGuReG1Vw@mail.gmail.com>
 <7f4e687b-fcec-4fad-34fe-a9e7d80735bd@iee.email>
In-Reply-To: <7f4e687b-fcec-4fad-34fe-a9e7d80735bd@iee.email>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 11 May 2020 08:46:52 +0200
Message-ID: <CAP8UFD2+N_xZV3rQdG-=LE=twt8Dp39YfrQUXCnUeLew6Rh=yg@mail.gmail.com>
Subject: Re: [ANNOUNCE] GSoC 2020 Students and Projects
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Stephanie Taylor <sttaylor@google.com>,
        =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Sun, May 10, 2020 at 11:32 AM Philip Oakley <philipoakley@iee.email> wrote:

> Do we need special login's to view the proposals you linked to?
>
> I'd at least like to follow along the technical details of the
> generation number development.

Yeah, sorry about the links I sent, and thanks to Matthias, Kaartic
and Abhishek for providing better information.

Best,
Christian.
