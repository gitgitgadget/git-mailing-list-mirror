Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 010211F404
	for <e@80x24.org>; Mon, 26 Mar 2018 22:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbeCZWVK (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 18:21:10 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43972 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbeCZWVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 18:21:09 -0400
Received: by mail-pg0-f67.google.com with SMTP id i124so458455pgc.10
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 15:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JjZ/CecI2Ba6N2Mj+O9MuZLxdjaaEsomOLbCHFjz2fc=;
        b=RVDimERjLGAcxBASATs6voGatXlkWFFukIlC2Akw2FSkev34sCKsbdalmTk6k3/tEC
         kt3l4Ls5oviWuZg0r1j/QW2vuyqXeslj0TGj3NtrW/+yxr8uw54kYY9j2kDaOHPwo4Y0
         o3TJx3GMwtK0Disp9wW/mbS7Yq09AFAZhGBeCuY4bz91gU+BkKPwUAyFvqVcKzGd7Ruw
         M03OQo4lXmk/agq4iRPnjDl2FAHqylbJBBTbDV4GzwK+WwXN9ehKqmb8wp0JuCMa2B7+
         rr8VGwtIjcIvLy9bSsujEqwrN7cnbGY5hgdUfm9Trk8l+rykdkCMvLRZ57O8ksVcUQtN
         aWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JjZ/CecI2Ba6N2Mj+O9MuZLxdjaaEsomOLbCHFjz2fc=;
        b=rEWT4wGgyGJ7meO8aXjYqiLxH5DzGrk7TQ6fINFlwA2pUErBgkTjuEiJ9PL/Pelmmd
         bIXOi99DLbE8ZaUue6D8aXDb8S+BExOCVm2v+MPju2EdBUE1DMtF+THlbb4a+eafDqk9
         5On6RKRWgqckxTbii0H81/Re+KxBOVHwstyjeqWuYAFWtp1GZlvIoSnBNBvfxb9V9f4P
         fLgzIxPgeYyeeCbOseJ8yNLLDoi63iHLTzbhrsRZb+Hr6k4TZEHDhFOBKdqkdMsAA+By
         hRaJK7+oq6E+R9d0btYO4Dl7gtYCXL5K2cMD500Q+e2kpPwGK+X6pjx5l3nCje7ayH97
         1J4A==
X-Gm-Message-State: AElRT7Ft0Wnyoembn4s5xO9rC5kh0BxHGUKq1rYK9H0H0gpA0tfWEEH2
        E7EDTejab/anrJxT6do2IFs=
X-Google-Smtp-Source: AG47ELtmZkDSKZK63s/1DEFtqgtbhhnfCe+o7WgQFOfGsN0MPhhPea8iJwYSxy2AeXK/bSYAqvpCsg==
X-Received: by 10.98.19.85 with SMTP id b82mr18373217pfj.236.1522102869039;
        Mon, 26 Mar 2018 15:21:09 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b6sm32979227pfm.160.2018.03.26.15.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 15:21:08 -0700 (PDT)
Date:   Mon, 26 Mar 2018 15:21:06 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        kostix@bswap.ru, clime@redhat.com, git <git@vger.kernel.org>
Subject: Re: get commit ID from a tree object ID
Message-ID: <20180326222106.GC21735@aiede.svl.corp.google.com>
References: <CANT8FXR3pMgbwVWmwssDYhgv6eMFw4+Uz5xARGwFVVU1cMVmWw@mail.gmail.com>
 <20180317130128.mr2sfsrncykkubwo@tigra>
 <20180317161819.GB25113@sigill.intra.peff.net>
 <xmqqwoyay48n.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kZU39B42BeOxrUDxT6Nca0=Yd+O0TEgu6_HvK3O=b2KhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZU39B42BeOxrUDxT6Nca0=Yd+O0TEgu6_HvK3O=b2KhQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:
> On Sat, Mar 17, 2018 at 10:57 AM Junio C Hamano <gitster@pobox.com> wrote:
>> Jeff King <peff@peff.net> writes:

>>> If you want to dig further, you can use the diff machinery to show which
>>> commit introduced a particular tree, like:
>>>
>>>   git rev-list --all |
>>>   git diff-tree --stdin --pretty=raw --raw -t -r |
>>>   less +/$desired_tree
>>>
>>> That "less" will find the mentioned tree, and then you'll have to
>>> manually read the commit. It would be possible to do it mechanically
>>> with a short perl script, but I'll leave that as an exercise for the
>>> reader.
>
>> Before Stefan jumps in ;-) I wonder if a recently materialized
>> "find-object" option to the diff family can be used here as a
>> sugar-coated way.
>
> I am late to jump in, but testing the 'git log --find-object'
> seems to have issues with trees named by sha1 here,
> but the named tree via <commit>:<path> still seems to work.

Experimenting a little more, I wondered if "-t" wasn't being passed
by default:

  $ git --oneline log -t --find-object=$(git rev-parse HEAD~30:Documentation/technical)
  $

No, that's not it.  Could it have to do with merges?

  $ git log --oneline -m --first-parent --find-object=$(git rev-parse HEAD~30:Documentation/technical)
  df6cfe8c30 Merge branch 'debian-experimental' into google3
  f86d5fd2e4 Merge branch 'debian-experimental' into google3

Yes.

That doesn't explain why <commit>:<path> worked for you, though. :)

Thanks,
Jonathan
