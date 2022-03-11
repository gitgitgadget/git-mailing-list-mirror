Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321C3C433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 09:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244915AbiCKJCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 04:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244643AbiCKJCp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 04:02:45 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BCF1BB727
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 01:01:42 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id kk16so6519681qvb.5
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 01:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JXJpSFJ5Wa7Eat7fNWzTVcYKXqL2xpd74dFuomC69yA=;
        b=IRqbfIjVQjcAAmHsCuk8T737vL/CBKZuHKRWr5LnG62cBLoQG5kxvje9CrAuy1LHXw
         YRO1b4cx6VE19yR6NIVMqu4l9s7BMxiCMVBccvrtRicnzH5C15WMmGBBXjKEhLnOdG47
         AkJPnN9rDMQC/NIiJm/1gSE9CEu/rawxFcDvSMRUW/6Za5b1NpnB8OkwOfm9Mt1ptNeB
         Xf6AVDsPSJrZD4dbLbfxVP7P+CZDVk1WK6czL/tdgnl1yflJNBCOuiZI8HTXKxXMA20Z
         UviTLFs1TmbzEicsgMMTC4afRdFXftEFdKqvwXNxv4UpBrqNjr3pTwKnu1Mouoc3n87U
         8gsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=JXJpSFJ5Wa7Eat7fNWzTVcYKXqL2xpd74dFuomC69yA=;
        b=zhInv+33eBlFl4qFk6ztXzfD0Gi3eZk2EB3gliA9z8/sXHj+lKk3EKgspWoFvuMDVR
         tYxii59tEIljtIglZlYVx4qt0v9dgKmFhnswKzI5onpWOipJy3u7GhcKqb11g1osX48P
         XTofC+7ITIoUBEcAfirUm1ipjc971l2NNGTuAxVvM8e+JrJcrJrhZrSL4RqLsCv3V9qc
         ShWk4yutd0mvQHjR0GnJZHm0B6nwCWcDSGUGy9lWMt1+hdC/gK17GDJoxsStaIjIV/Tw
         Q+yxHomBdrmGJwUoIMAGuRMvBZjSoPEEKmGgfDpd7P3BXJTm53tUWuOfaD4vSXsWvXW8
         Ot5w==
X-Gm-Message-State: AOAM532gROm07pAQTPP+U4ClNy2NddPLVjq2tbZQRbTphDjEfknI63dP
        +CXynAQzVIQjdUWumFbhzdc=
X-Google-Smtp-Source: ABdhPJxYws3/B0VgNlQpuIptO1z6lDRygp2yzbsFoHwKEkRb6yXmGGuYviRy4NiGaVVM3LqIr9MM8g==
X-Received: by 2002:a05:6214:27cb:b0:435:b960:f615 with SMTP id ge11-20020a05621427cb00b00435b960f615mr6790183qvb.7.1646989301879;
        Fri, 11 Mar 2022 01:01:41 -0800 (PST)
Received: from ?IPv6:2003:f6:ef00:8400:3d36:58a:667a:1da9? (p200300f6ef0084003d36058a667a1da9.dip0.t-ipconnect.de. [2003:f6:ef00:8400:3d36:58a:667a:1da9])
        by smtp.gmail.com with ESMTPSA id f14-20020a05620a12ee00b00508b2c61482sm3518174qkl.25.2022.03.11.01.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 01:01:41 -0800 (PST)
Message-ID: <91437bbc5700596e48fd7d22acb253acdcf628b9.camel@gmail.com>
Subject: Re: git notes question
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Erik Cervin Edin <erik@cervined.in>, git@vger.kernel.org
Date:   Fri, 11 Mar 2022 10:02:15 +0100
In-Reply-To: <xmqqlexhg0fy.fsf@gitster.g>
References: <ea67407120aa710f81af048d22be09281ac28107.camel@gmail.com>
         <CA+JQ7M-dkV_AGJ8+4C6HcCN1sQgBtyfYbgUbnQQmYz9So3WwQQ@mail.gmail.com>
         <d204419925e7a4486d9a66a8a0f807a77be6d1b7.camel@gmail.com>
         <xmqqee3bm2b8.fsf@gitster.g>
         <f5be5b264f30f689546db3883b4b64c88ba00cb3.camel@gmail.com>
         <xmqqlexhg0fy.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2022-03-10 at 09:52 -0800, Junio C Hamano wrote:
> Nuno Sá <noname.nuno@gmail.com> writes:
> 
> > > Well, this time it was "Notes:" label, but the next person who
> > > wants to see a deviation from the canned "email" format would
> > > want a
> > > deviation different from yours.  Perhaps they want a different
> > > way
> > 
> > I'm surely missing something but I'm not sure this is specific to
> > the
> > email format? It's just that git-notes by default will always
> > either
> > append the "Notes:" or "Notes (<refname>):" independent of the
> > predefined format you use. The only way to stop it from doing that
> > is,
> > apparently, by using your own --format=<template>...
> > ...
> > What I was asking was just if there was a way to not use these
> > default
> > strings. I don't think this would open all kind of deviations.
> 
> Not limited to the email format.  "git log" will always prefix
> "Author: " before the commit author name, "Date: " date with extra
> paddingbefore the author, indents the log message by 4 spaces, adds
> "Notes (refname):" before notes, and indentation is given before the
> contents of the notes.  There are many things, other than the
> presence of the "Notes" label, that people may want to customize in
> the output from the commands in the "git log" family, including "git
> format-patch".
> 

Alright... Now I got it. There's already lot of things that 'git log'
and friends print by default that there's no reason to give special
treatment to "Notes:". That would indeed open the box for all kind of
request.

Having a way to mimic email (or others) template in --format would
indeed be nice though :).

- Nuno Sá
> 

