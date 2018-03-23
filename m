Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 159B11F404
	for <e@80x24.org>; Fri, 23 Mar 2018 18:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeCWS2k (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 14:28:40 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38168 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbeCWS2j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 14:28:39 -0400
Received: by mail-pf0-f195.google.com with SMTP id d26so5043236pfn.5
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 11:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mfySkvzKfeDoEiPsI98nYxpfPdteBtx3Qc2jJq/xL0Q=;
        b=YNwrtYKCSazL5q9c4D2f3euOkHkK6b5aLvT+W3w2Ub9i1o0nsSXI/apEkDv/6iy1y9
         /RiidwDxT+zYlYRz7AyEKGS/PtvexOlBy0lr22gCFF9lrlI58SynpkuaOrdZQSKAwaP7
         KXg8fEq3sIJykuGv3Fir5/JS/Pg+LqZQq2sJhm+8Q1cm/g/8lMx7m6y6/7A5bFKOrrVE
         guVOfGogPp3GAXATtcjxlrwzhPzcfD/ufeCJsWL1p0cOMwkBU5YdWOpCjeyfl06UBRsl
         s8HKNSG42qwg9Ap4Q22hHapJigE8fKssIhXgOmjE1ZslPxpB9AseT+zS5/D9wpbZ2v7P
         7I2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mfySkvzKfeDoEiPsI98nYxpfPdteBtx3Qc2jJq/xL0Q=;
        b=YJFSXms2UICOD8d3VnM7VTUlpog/sdHBiFtdRh0NIERzqkkRiQUs9IIfB4XMukOdaJ
         RiBcrGDySNUCEkQC1UEH6coiGXVou2AJGabiTUkhWX7GU53oZOB5JMBl+kyNbD6f7Mt3
         izmK7VIMyNAniT61obtJTJxGw+/yBi92rYv8RKo3UH1NsUCjBWenJh4OfND38Wir9DTf
         vDUgBk8ma0LTXCUIOwM6UOn0aOsL14c+Mhx7g06Cy2Idc05j3SpE7kATPTTFK5z3Y0ye
         G+ChAtyxhVE4PzKItXKk5xf7HP6zfls+yDPOGjunL055IQr8AjhCXBVX64WjvggXaNUe
         goxw==
X-Gm-Message-State: AElRT7GQ/JUZrl63l8pQ06mVV9sQip5Zf9PACR0lXFjvrSl1uHuRljSL
        DE/mSApBbIxoXaAkQbw6eLDdHw==
X-Google-Smtp-Source: AG47ELv4n6o1kEJ04prRcUOjDKi4QM+FdD5xC3l5CkxeI/r5d9Ibd8m0duyyoxliYqEJaE4YUc2wGw==
X-Received: by 10.98.41.134 with SMTP id p128mr25021535pfp.120.1521829718215;
        Fri, 23 Mar 2018 11:28:38 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id a82sm15151680pfj.153.2018.03.23.11.28.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 11:28:37 -0700 (PDT)
Date:   Fri, 23 Mar 2018 11:28:36 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 10/44] object-store: move packed_git and packed_git_mru
 to object store
Message-ID: <20180323182836.GA243756@google.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
 <20180303113637.26518-11-pclouds@gmail.com>
 <20180321221842.GH18406@google.com>
 <CACsJy8As=iDtLm6GGxbeHB=VDUvOgefrSpBduY=Kq1O3D2x1Tg@mail.gmail.com>
 <CACsJy8BcHdvUn5VPc9+mzE1SpvsJG-P2iUW=jg2VD5YhU4kVJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8BcHdvUn5VPc9+mzE1SpvsJG-P2iUW=jg2VD5YhU4kVJg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/23, Duy Nguyen wrote:
> On Fri, Mar 23, 2018 at 6:03 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Wed, Mar 21, 2018 at 11:18 PM, Brandon Williams <bmwill@google.com> wrote:
> >> You're marking packed_git
> >> as "private"...well C has no notion of private vs public fields in a
> >> struct so it might be difficult to keep that convention, it also took me
> >> a second to realize that it was only in the scope of packfile.c where it
> >> was ok to reference it directly.  Maybe it'll be ok?  If we really
> >> wanted something to be private we'd need it to be an opaque type
> >> instead, which may be out of the scope of this code refactor.
> >
> > It's true C syntax does not support private/public scoping, but it
> > does not mean we must avoid that. Python has "private convention" with
> > the underscore prefix, no special support from the language either.
> > Yes having compiler support to enforce scoping is nice, but I think we
> > can still live without it (Go devs live fine without "const"
> > arguments, e.g.)
> >
> > So I'm going to make it clearer that these fields are not supposed to
> > be accessed outside packfile.c
> 
> I'm not counting out the making these fields completely opaque of
> course. And with your suggestion of not embedding raw_object_store to
> repository, that's actually possible to do. But I'm still not doing it
> now :) The series is getting long and extending its scope will drag it
> even longer (in terms of both time and number of patches)

Oh of course. I'm a big proponent of taking small steps, so definitely
avoid scope creep and hopefully this series can land quicker so we have
a better base to work with to make some of those other improvements if
we still want to down the road.

-- 
Brandon Williams
