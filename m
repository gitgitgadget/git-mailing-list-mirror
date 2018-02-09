Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B82291F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeBILEa (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:04:30 -0500
Received: from mail-wr0-f173.google.com ([209.85.128.173]:41679 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752126AbeBILE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:04:28 -0500
Received: by mail-wr0-f173.google.com with SMTP id u60so5073871wrb.8
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=huBnYP9rzDtQhS30b2NKdTvstUISsMjRFQduLYSGefs=;
        b=Yp7lm1+yFg0mJaZCrXw9upYW9qKKYHJkEIeqrKmwmWttNrqliCZ6SHzyfLShP076wW
         9k6t46Le/g2NfVHea1MlH35y8fJXlZKAbKHDdHF06j+s2jUFgkFQPDeICA/q+33Ds61p
         LOztjttQmnGxcxk94qWmd+JbdtwUa1hkabFdIHh4gWmN8rakgUB61JC8AY5gPMqrP0pz
         v+IdE2RXBnVobE3VpNEhFILYFybQJe8UpR3uRlPAzRwV3w8+YyoJXgmXBg/X9UjfzkXG
         3g/Vv8YAxvDVkSsuFhUQsuyF2z1Ea6EsYO5WYX0QRUlBety2WWubdAHzTkBwzPG0BXL/
         WFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=huBnYP9rzDtQhS30b2NKdTvstUISsMjRFQduLYSGefs=;
        b=cOxFDIi9TcXOInZDTmYVLUMvvYp4ATZayX3KhdtpVBNbErSUUUb7eoBGMN/IPmlj7a
         PYrOpG881iNYTNiiTjut7nEdt/sK1OXCZpsCM4w2JkZS8dRAtvPzVt0E9Ed6yJpxg8dU
         ZXbFSanKmc5Lv7m1WV6ehPn4GGav4lfhHMoYVU8mybgOfmff4meGZj9fEnRnw4RBLwmE
         TDDlXV+GIbsGpEq0vbqOYzzopnuVW9bHO3Er0IeBpG9AV1sQ/cur8quiGJWUK1dQ1/3H
         YqayxdZPJgAo/6CzWAy7nI51gDGzKb1PzOP66kSS5ZHXFjTGTIznTeZlS5EcMFFfkMq5
         XRzQ==
X-Gm-Message-State: APf1xPDxSt0/sv+H0bwoGWC3a5gVN7PUl8/t1BrKuIugWflmniU1N63t
        4AKJAI9zbuEuUvlYNPQ77m0=
X-Google-Smtp-Source: AH8x226QgAZkZXT5FBp0/zeJ0FciaHTXbq1dIe0vSlUsMJisPhKobDPPgDvVU0L0zr1tQujUHokePg==
X-Received: by 10.223.186.67 with SMTP id t3mr1888137wrg.201.1518174267460;
        Fri, 09 Feb 2018 03:04:27 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id h194sm4653386wma.8.2018.02.09.03.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 03:04:26 -0800 (PST)
Date:   Fri, 9 Feb 2018 11:04:38 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/3] worktree: teach "add" to check out existing
 branches
Message-ID: <20180209110437.GF2130@hank>
References: <20180121120208.12760-1-t.gummerer@gmail.com>
 <20180204221305.28300-1-t.gummerer@gmail.com>
 <20180204221305.28300-4-t.gummerer@gmail.com>
 <20180205021833.GB17847@duynguyen.dek-tpc.internal>
 <20180205202332.GE2130@hank>
 <CACsJy8BEKYqW+Ne_WY2RBaSbb9OKcjREtrawStj=eJsVsia_Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8BEKYqW+Ne_WY2RBaSbb9OKcjREtrawStj=eJsVsia_Jw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/06, Duy Nguyen wrote:
> On Tue, Feb 6, 2018 at 3:23 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > On 02/05, Duy Nguyen wrote:
> >> On Sun, Feb 04, 2018 at 10:13:05PM +0000, Thomas Gummerer wrote:
> >> > -   if (opts->new_branch)
> >> > +   if (opts->checkout_existing_branch)
> >> > +           fprintf(stderr, _(", checking out existing branch '%s'"),
> >> > +                   refname);
> >> > +   else if (opts->new_branch)
> >> >             fprintf(stderr, _(", creating new branch '%s'"), opts->new_branch);
> >>
> >> I wonder if "creating branch" and "checkout out branch" are enough.
> >
> > I thought printing the branch name might be a good idea just to show
> > more clearly what the dwim did.
> 
> No no printing branch name is definitely a good idea, especially when
> I think of one thing and type another. I shortened my example phrases
> too much. It should have been "creating branch %s" and "checkout out
> branch %s"

Ah sorry I misunderstood.  Yeah I think that makes sense then :)

> -- 
> Duy
