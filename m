Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AC771FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 19:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752617AbcLITXV (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 14:23:21 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36141 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbcLITXT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 14:23:19 -0500
Received: by mail-pf0-f169.google.com with SMTP id 189so4768059pfz.3
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 11:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EVyv5qW4Xz7IyNG99X5YG/Jck786aQElr6q/bCieG/s=;
        b=Gqe7Frf/THOJGu8WuCcLg5kcafowl8FhB+xllDeqnrr+aiTXj3id/0Dces1NnJ0mzr
         K50l5/SavOayiYLO4WIa4ZGa1qGdKQcq81E+pMxfYBRm/GngY6rshSZsjr27pWDijOsV
         eAazq8N8d1JMTy4Gpmoobc5chizBZ0vW0HzUtEOkHLnO5vdQ/3FlIOk6iYluQaTa/BTk
         +v8qeqTdwEXqmA2www4w4ZRYGldYNApq15RD2YlhuWCK74ldo9TzoU6mH+uvAzalFPeX
         Tc03SfEM5qw3RI5i9lc74QN8mB8hYt4Zf8B0suYk0nY4bnIdLNjJg4Viq1tFbuYPiyu3
         xEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EVyv5qW4Xz7IyNG99X5YG/Jck786aQElr6q/bCieG/s=;
        b=PJSbKBoLV2M9anhqhyfxlas8PuZBYFjZjyLg/ehD7BZbE4A0V+vhyykXS5FSfhWUow
         72OxtDbx1EtzSHff4pWjV0OD35VbTT0Q69IDyj1Q0tmYJr7bnRgVfO22sE5u1eWLKpdR
         cd7PyNzaDGkWiy+rmWlYiHcj0l4ZM6S36kzU3sSO9EHkik1SvWFuoXMoqIl3LYw7ccfd
         akML2+UcMqGwuFJ5QbWm4D0ntAHsih3a9gGmroLRO10E86vP8meN7uCxvdFieM1T95Zp
         RVEeyD4+nEyr7nMEGePayMDanm60afYaBK8EwHTWogmIrhZUsDFFfD6o4/ZzDAhR3HOg
         YRgQ==
X-Gm-Message-State: AKaTC01PjWIVX3larUH+mu7x4C1kvj538vQZk7B8efRkXi+ThjMMz21RneKg9YzGRKiY41Nu
X-Received: by 10.84.218.5 with SMTP id q5mr163052818pli.136.1481311398871;
        Fri, 09 Dec 2016 11:23:18 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b541:bdf2:ef3a:110f])
        by smtp.gmail.com with ESMTPSA id a66sm59288201pfa.64.2016.12.09.11.23.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Dec 2016 11:23:17 -0800 (PST)
Date:   Fri, 9 Dec 2016 11:23:16 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/17] dir: convert create_simplify to use the pathspec
 struct interface
Message-ID: <20161209192316.GB88637@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481061106-117775-3-git-send-email-bmwill@google.com>
 <CACsJy8AX09pxkyUkLU905v1MpXocLzV5bK0APuNmMUNb50Lavg@mail.gmail.com>
 <20161208000357.GJ116201@google.com>
 <CACsJy8DtUwnOjBV49navkfgqPzEsNuX2LVaeVU=Ap2PWLpGFdA@mail.gmail.com>
 <20161208181957.GP116201@google.com>
 <CACsJy8Cc6hE1Rbqjrc93xDMc0UUm0yMh0A-fyu3dfJ2G1jhENQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8Cc6hE1Rbqjrc93xDMc0UUm0yMh0A-fyu3dfJ2G1jhENQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/09, Duy Nguyen wrote:
> On Fri, Dec 9, 2016 at 1:19 AM, Brandon Williams <bmwill@google.com> wrote:
> > On 12/08, Duy Nguyen wrote:
> >> On Thu, Dec 8, 2016 at 7:03 AM, Brandon Williams <bmwill@google.com> wrote:
> >> > On 12/07, Duy Nguyen wrote:
> >> >> On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
> >> >> > Convert 'create_simplify()' to use the pathspec struct interface from
> >> >> > using the '_raw' entry in the pathspec.
> >> >>
> >> >> It would be even better to kill this create_simplify() and let
> >> >> simplify_away() handle struct pathspec directly.
> >> >>
> >> >> There is a bug in this code, that might have been found if we
> >> >> simpify_away() handled pathspec directly: the memcmp() in
> >> >> simplify_away() will not play well with :(icase) magic. My bad. If
> >> >> :(icase) is used, the easiest/safe way is simplify nothing. Later on
> >> >> maybe we can teach simplify_away() to do strncasecmp instead. We could
> >> >> ignore exclude patterns there too (although not excluding is not a
> >> >> bug).
> >> >
> >> > So are you implying that the simplify struct needs to be killed?  That
> >> > way the pathspec struct itself is being passed around instead?
> >>
> >> Yes. simplify struct was a thing when pathspec was an array of char *.
> >> At this point I think it can retire (when we have time to retire it)
> >
> > Alright, then for now I can leave this change as is and have a follow up
> > series that kills the simplify struct.
> 
> Do let me know if you decide to drop it, so I can put it back in my backlog.

K will do

-- 
Brandon Williams
