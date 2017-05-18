Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D3F2201A7
	for <e@80x24.org>; Thu, 18 May 2017 00:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753218AbdERASi (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 20:18:38 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33195 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753107AbdERASh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 20:18:37 -0400
Received: by mail-pg0-f41.google.com with SMTP id u187so14343021pgb.0
        for <git@vger.kernel.org>; Wed, 17 May 2017 17:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AyiJo/TXhRHcfZvZelc1c4vipmXQ6195jMj4xG/LU0c=;
        b=C3rR+/bEVXvHHaV7iu6iVVppxp1Lmm20Rd7RmduV7Q6KuxS0/pUk5e8zYWxtzyiguV
         swYHC+69gPE8SAwNa5bvjq+PGE/QP8yw/3mjvdD3TSTmHAXPUIeqm+Gt8D3FVfctZyCX
         zjzVruJRvM0LSnzJqaEHrDaq7Z896ldZ1YxboHDoOnRQuIrkeQGScmD1vYu0ZcQCs4v3
         Cs1Msl3ETC0aWA8Nupun/ZZFFo/Kt8OLuMJDvNip7CmINeBY3D3ngoisNxxekzI0dEDm
         Tm3vG7WK8wOEwCIDSbaV6ZhFupCDQdYpYwXEFUPEN/WVuatDv55qnbqdd3y6NCyJeVaE
         Vnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AyiJo/TXhRHcfZvZelc1c4vipmXQ6195jMj4xG/LU0c=;
        b=CBlXA1HXcKoNG5cTJYaH4U6Z1vK7H1JFOv91PGnlRklnxJNw4hRrXE+0BGl4607TCd
         MBsNTo5fOIoJML08CoUw0Y5yNDStU5TpwyOY3IgAs7biL7rvpqeRtXRP7Ckfc7RD6U4q
         m//AOxd18quopY+mdJ6SqH+kNsvFlkm2XmX8vVbVUyyQ1KVap6Og8noaTYbYES/i2TZR
         SvXZVol3IqEnlHYXgwRo/fOE8UnhoEpFahFyFt7KHt9M0fhdHthu57fS0eIJIryJ2urQ
         pSLAn2XYs1WR8AD0ySXGlRzMA4rBrbVirrXWeA0Ya82c329GMQXP3Trl2DSKryx9At9J
         fnQw==
X-Gm-Message-State: AODbwcD8UxC9XZKONYgJ8UunMpkmyvDawlmHBVOQm0NqpDDPIPyGoTL/
        pDDL8Wig5F68nELA
X-Received: by 10.99.116.7 with SMTP id p7mr1315272pgc.162.1495066716971;
        Wed, 17 May 2017 17:18:36 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:1838:1185:c4dc:8c8d])
        by smtp.gmail.com with ESMTPSA id k79sm5823899pfj.6.2017.05.17.17.18.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 17:18:36 -0700 (PDT)
Date:   Wed, 17 May 2017 17:18:34 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 10/23] files_ref_store: put the packed files lock
 directly in this struct
Message-ID: <20170518001834.GG185461@google.com>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <dd7637060bac1a27e03563edc82649812dcf897c.1495014840.git.mhagger@alum.mit.edu>
 <20170517131753.rditx62clmkrdmeq@sigill.intra.peff.net>
 <CAGZ79kbdQ-MqYKH-L9unqEAPUtgQxNv6ANJERKSEQCADjgmm1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbdQ-MqYKH-L9unqEAPUtgQxNv6ANJERKSEQCADjgmm1w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/17, Stefan Beller wrote:
> On Wed, May 17, 2017 at 6:17 AM, Jeff King <peff@peff.net> wrote:
> > On Wed, May 17, 2017 at 02:05:33PM +0200, Michael Haggerty wrote:
> >
> >> Instead of using a global `lock_file` instance for the main
> >> "packed-refs" file and using a pointer in `files_ref_store` to keep
> >> track of whether it is locked, embed the `lock_file` instance directly
> >> in the `files_ref_store` struct and use the new
> >> `is_lock_file_locked()` function to keep track of whether it is
> >> locked. This keeps related data together and makes the main reference
> >> store less of a special case.
> >
> > This made me wonder how we handle the locking for ref_stores besides the
> > main one (e.g., for submodules). The lockfile structs have to remain
> > valid for the length of the program. Previously those stores could have
> > xcalloc()'d a lockfile and just leaked it. Now they'll need to xcalloc()
> > and leak their whole structs.
> 
> +cc Brandon, who is eager to go down that road.

I'm probably too eager haha.  But I still think its something to slowly
work towards.

> 
> > I suspect the answer is "we don't ever lock anything except the main ref
> > store because that is the only one we write to", so it doesn't matter
> > anyway.
> >
> > -Peff
> 
> 
> > @@ -102,7 +98,7 @@ static void clear_packed_ref_cache(struct files_ref_store *refs)
> >        if (refs->packed) {
> >                struct packed_ref_cache *packed_refs = refs->packed;
> >
> > -               if (refs->packlock)
> > +               if (is_lock_file_locked(&refs->packlock))
> >                        die("internal error: packed-ref cache cleared while locked");
> 
> I think the error message needs adjustment here as well? Maybe
> 
>      die("internal error: packed refs locked in cleanup");
> 
> Thanks,
> Stefan

-- 
Brandon Williams
