Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7076C433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 07:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 274F522267
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 07:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YS5oNpj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732288AbgJIHsp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 03:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730467AbgJIHso (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 03:48:44 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB864C0613D2
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 00:48:42 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id e2so8879969wme.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2020 00:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NPazIjOleca3MlPlk7O4g/lav9Bqy0pibQY050zPbs0=;
        b=YS5oNpj6ab8JMThmN5f/wDTdBgik9f4mVdwdOMWzmR8BLS35xird8a0yFNsLe/eGz+
         xGfZlMrSqtUEINejOJUxR8mPPUwjUJgakQUDI98xobhlhwP6liG+bagmZ5VuXed0k7uc
         Pg1j0VIPYbpk0ITfW97Jp5a0AgfUFnH1ztE1td5i/qfZD/H66uI5N4Fl76jsTRuwbujO
         UATUxhxwD7ibsNC6KXOp5pVW5xaXef+dI+TclCAM9jouusk+XL80ffRoG4uPXJV/xknR
         +1PFwPB4AZeYPAJ2ziIyJFyLX4MmdWlQTK5Z85uGpsE86XD9JFsHLYayUNUeIWmroDfH
         acyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPazIjOleca3MlPlk7O4g/lav9Bqy0pibQY050zPbs0=;
        b=tnIBkhrZcJ9ypjTT1PE9Mo5YHMHxi99FBD0BYF9VR9NalSrRRyC9MTquFsh24JfYN/
         9BKhfH3lWrbBEJFk7GV8TeuG6jEsWDOjT1hsZGQYi08FzYk3Mmg+UpWxYf665b7iuu6b
         X5Da7RbYabFoNcoGl0fhtbq2sGnYoI4f18qP0qj9kAPbqLM1HN7bsBuIktcv16iW766s
         GZiGagEmpXbIkNjM3FHz5Nd6gRYX4Vbl8sezTNh7e85u9UnG37HAVvlnLn3UnzFP2sl3
         iEGEIv9id5Iv7jaSPGdBO1axXTtE9ScgkTBUlaTEsDL7qSlrTswQVythIcFLnk1krs57
         14WA==
X-Gm-Message-State: AOAM530L24WNEgEUPENjkLgkx20+g9vcQzcOpTss4K2WiMyM+nXDQH1L
        wrEqzTs/IX0bnmn4g01J2NKbAtrlQ7WvtOooANP1yWV+XLRrng==
X-Google-Smtp-Source: ABdhPJzyZPE6FYb1EqDDu+opGughwOt5KTiW+ZLwpm//8l53YI2z2B1BUmjkuioYhNhVCJTiwM7OxQRihuDJV9jp25s=
X-Received: by 2002:a1c:9910:: with SMTP id b16mr12069304wme.64.1602229721533;
 Fri, 09 Oct 2020 00:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAGxm6oXSaKoTR3btKRV4bMYUsc3-oKeWSfzrWKkCXgrRorAEAQ@mail.gmail.com>
 <20201009002541.GB2415320@google.com>
In-Reply-To: <20201009002541.GB2415320@google.com>
From:   Amanda Shafack <shafack.likhene@gmail.com>
Date:   Fri, 9 Oct 2020 08:47:06 +0100
Message-ID: <CAGxm6oU+cn7=St=1VjP1L9VZutdM2k1ui9=FsLxak8yg_-YCQg@mail.gmail.com>
Subject: Re: Introduction - An Outreachy 2020 Applicant
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the details, Jonathan.
I'll get right on it


On Fri, Oct 9, 2020 at 1:25 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> +wireshark-dev@wireshark.org
> Hi Amanda,
>
> Amanda Shafack wrote:
>
> > I am Amanda Shafack, an Outreachy 2020 applicant who wishes to
> > contribute to the "Add Git protocol support to Wireshark" project.
> >
> > In addition, I have some experience coding in C and I hope to enhance
> > my skill set by contributing to this project.
> >
> > I am currently going through the project description and contribution
> > guidelines.
>
> Welcome!
>
> Since this project would involve Git (for Git protocol) and Wireshark
> (where the dissector goes), we're comfortable working with you on
> contributions to both Git and Wireshark during the application[1]
> period.
>
> https://gitlab.com/wireshark/wireshark/-/wikis/Development/ has some
> pointers on getting started with Wireshark development.  I'm cc-ing
> the wireshark developers list in case they have suggestions for an
> approachable "first patch" idea to get used to that project's
> contribution flow.
>
> It's also a good idea to build and run wireshark and see if anything
> strikes your eye as something you'd be interested in seeing work
> differently.
>
> For Git we have some suggestions for microprojects at
> https://git.github.io/Outreachy-21-Microprojects/
>
> Thanks for writing, and I look forward to working with you.  These are
> two open source projects that I love and I hope you enjoy working with
> them, too. :)
>
> Sincerely,
> Jonathan
>
> [1] https://www.outreachy.org/apply/



-- 

Cheers!

Amanda  Shafack
