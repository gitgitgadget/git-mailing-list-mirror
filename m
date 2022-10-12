Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5696C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 06:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJLGpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 02:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiJLGpa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 02:45:30 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0A740E06
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 23:45:27 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id f23so15404227plr.6
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 23:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wFZLcei4iOXBbaWcwL1FFEbyTcXs9JN5n3tyIw1Astc=;
        b=RGQSrnrjEyntCBsaoLJPsJUwrPreVNn+B4ncgVIu+LmOENJ/+N+qHt6ligqttCWsOI
         1KhOCOByTl8xzDetN6wi8Ni+ido4xmJfsU7QbOsgunOD0uwHV8ENneJ4/pofEZ7ZkbxZ
         lZULwlNS5UOy51DwuTxq3iD4brXZzudu9LYPTQHZUqT1ut9xwXqpVMvZXXYufrrNXVQp
         qpEhxFN8Ddij9gMnal+fneiWYyapILUY+EXmfDv/iOW7lHKjFp26qOUYhiDbax5elAmB
         ARi0qVo44ywwE0/VgdMVMCKtB44KdNm4k4QJMrBWdnVkjNO3nrEw3gxAdN9xvSJERZXD
         Hczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFZLcei4iOXBbaWcwL1FFEbyTcXs9JN5n3tyIw1Astc=;
        b=gi+YgUDtbqBKDG46czF0OycfaAZLsY5FVccSXHqVyL+gNuNU9Uy+Nh9APStZzgjFOI
         MZ4NNzg+duXiWWAuEd421gCXkamMy1gl79BcelQcK9JrKP4Sdb70gMdsfKLXNKbJyXjf
         iXqLAdmmEFODdyshWah9T5tHB9Nf6D84x366N0PVv9y/Iv88qmPz0dDkwAHY4e1kB3oP
         rjfSVERcmNg0gZF2hwnD1y/XyjtFlmkOWXzjJyAnhthesJAemS8EsVAMzS4Au6glIEqW
         /QFqP8uHCyBh4eIRoIurqASaybOrntlLiYGUGK9NujdAIgD3BsFoIoP0qV/rZYcfQTds
         iNrg==
X-Gm-Message-State: ACrzQf0OhbEqHkSijc83wn5uXgtN7h26jUKWglZEYFGSWcAettOM3BXC
        E9lba5FeQo+NujjZCV7Mb9I=
X-Google-Smtp-Source: AMsMyM7rO59Qcvxic1NlQu7yrzGEKg22BMHyO1u8T5r7foc1MLk74joWQggyGz5R7i3A6GglL9jASQ==
X-Received: by 2002:a17:90b:1d83:b0:20d:7e1e:fa51 with SMTP id pf3-20020a17090b1d8300b0020d7e1efa51mr3364843pjb.131.1665557127111;
        Tue, 11 Oct 2022 23:45:27 -0700 (PDT)
Received: from localhost ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id l23-20020a17090a599700b0020d6b514b38sm661428pji.55.2022.10.11.23.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 23:45:26 -0700 (PDT)
Date:   Wed, 12 Oct 2022 13:45:23 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Luna Jernberg <droidbittin@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Hariom verma <hariom18599@gmail.com>
Subject: Re: [Outreachy] internship contribution
Message-ID: <Y0Zig4XUePPhMaA3@danh.dev>
References: <CAP8UFD1o5qxSvbV05DK_J=zbU=D_+HS0Q2ufEFSQVaBoWw_7Ow@mail.gmail.com>
 <CA+PPyiF5KK6p7rv57YL_wsDO+WPifoRp1oe0F-6mo5NxLAwDWw@mail.gmail.com>
 <CAP8UFD26PY-53vZNZJzCRNiqaVB4fd=AvBtVuvMQP9p8Oqj82Q@mail.gmail.com>
 <9fcfc8b0-772d-08c3-595b-5a5a139d7ecd@github.com>
 <CADo9pHgcfwV53ooyM8Dh5jVO2rxO-tUHeLovd7HYLdTSOkNtyA@mail.gmail.com>
 <CA+PPyiH8EPWpTuOJg1hSthFP1xBxurjN7J0J00g6xvFi_vbcYw@mail.gmail.com>
 <ae8a98d9-eec1-cdcd-67a3-695aaca7f5ae@github.com>
 <CA+PPyiFC0mjvY494AVZMB952Ux-TPyA-Uetu1xQ6FiHA_vaRaA@mail.gmail.com>
 <CA+PPyiEms=f7=rXkvfmaazNkxKS1-VA-XJZOrhieQEut8f7QWA@mail.gmail.com>
 <xmqqleplmz3n.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqleplmz3n.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-10-11 21:42:52-0700, Junio C Hamano <gitster@pobox.com> wrote:
> NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com> writes:
> 
> > Hi team, I am reading through "My first contribution"
> > when I run make all doc, I get the following;
> >
> > SUBDIR git-gui
> >     SUBDIR gitk-git
> >     SUBDIR templates
> > make -C Documentation all
> > make[1]: Entering directory '/mnt/c/Users/USER/documents/git/Documentation'
> > make[2]: Entering directory '/mnt/c/Users/USER/documents/git'
> > make[2]: 'GIT-VERSION-FILE' is up to date.
> > make[2]: Leaving directory '/mnt/c/Users/USER/documents/git'
> >     XMLTO git-version.1
> > /bin/sh: 1: xmlto: not found
> > make[1]: *** [Makefile:355: git-version.1] Error 127
> > make[1]: Leaving directory '/mnt/c/Users/USER/documents/git/Documentation'
> > make: *** [Makefile:2720: doc] Error 2
> >
> > How should I go about it?
> 
> Googling "xmlto: not found", the first result is
> 
>     https://command-not-found.com/xmlto
> 
> The page lists how to get and install it for various platforms, and
> WSL/Windows should be included there.
> 
> I believe "My first contribution" recommends to first read the
> top-level INSTALL before continuing (and if not, it should be
> updated to).  Simpler things first---building and installing the
> vanilla source code without any of your changes should be simpler
> and you should become confident in doing that, before you start
> modifying anything. Otherwise, when you encounter a problem, you
> would not be able to tell if you broke it with your change, or your
> basic set-up is not complete (e.g. missing necessary tools like
> xmlto) and unable to build and install from even vanilla set of
> sources.

Maybe he is on Windows and using Git-for-Windows SDK? I'm not sure
what's included there, but I can imagine that man-pages is useless
on Windows, they would prefer html docs instead. Perhaps, they want:

	make all && make -C Documentation html

When building only html, xmlto is not necessary to be installed.

-- 
Danh
