Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB2C51FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 21:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932336AbcLBVqb (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 16:46:31 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34571 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751972AbcLBVqa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 16:46:30 -0500
Received: by mail-pf0-f181.google.com with SMTP id c4so54563022pfb.1
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 13:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XTWGgYwlk7GVEIFMuls/uH8sy89yUKg8ACyQajb64ig=;
        b=FUm3Ngdgm3N01rj3ZCUQt+ajcZH1x5PzAZS6DoemWrBdw1zR1pE7K4ekc/x2+lno4e
         hDcL1/bwEs2MHfQ19bSNKM1P20mmVxeuusZPkayUQbTUA+L+z+4muMxtfb+lGxZc0sTw
         dSg1LrRUUwatAGy4lU8G7wc/tQiXC0QvWy8kN3FWPlolNIy+7rNoE9N+YjohIOTfVgbG
         PEFS+wBHSnE8Snbccqw4MIouAO8DxN45nR10rRk0hpYzkin4CGox3BKRDwn5mL8CBpST
         9t2ebwC0uiFoLi8OQivW194e7Xfow3hlrnumLdZYKQ7+IHd0uSjgUGJYtCUlGYxkx1en
         9EFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XTWGgYwlk7GVEIFMuls/uH8sy89yUKg8ACyQajb64ig=;
        b=Wb6b23EkHWrxdQccGRhomd2cSJ4GrVUElOsZQka9Dm60z1SwpRjRNIvYDKxPyVKHkG
         oIU/mD2WrjdH1Q99t7EcV6rRxuWwa56XfLMdPRyqp0AvMiGQiLv6wR3psZbp2k5uP7xH
         ldOxNyA5jWHq7y3gidLpiXKKBa4Z9GeBko4RB/ZJyBSlYZZEqnPgQ79zmQnBF9fFyhAD
         OK6StmufsGWuXf7ffZsjKsWU/bmsQ3LXYCjYRAbqnTzhB9AOkHGCA9D0tLrUcGYi2QxY
         3C16u8NRgm0cVnF35tG9eod0kHnUYUYucS3rTILJcc1aZ5vHSsIYsPG/BBJVY9jOUCBt
         5q9Q==
X-Gm-Message-State: AKaTC01OL6bDZWueC5abdkjm06+91ONQ4/kPZUbDDNFOk1LyfP6NxKi+pwjXtHGYgia5QSxy
X-Received: by 10.84.129.100 with SMTP id 91mr99049653plb.73.1480715165781;
        Fri, 02 Dec 2016 13:46:05 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:217c:34ba:fcf8:d822])
        by smtp.gmail.com with ESMTPSA id g63sm9868407pfd.60.2016.12.02.13.46.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 13:46:04 -0800 (PST)
Date:   Fri, 2 Dec 2016 13:46:03 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6 1/6] submodules: add helper functions to determine
 presence of submodules
Message-ID: <20161202214603.GD117792@google.com>
References: <20161201205444.GG54082@google.com>
 <20161201205944.2py2ijranq4g2wap@sigill.intra.peff.net>
 <CAGZ79kaqzssfN_bRQYpqC9HsKmyQZNCQcs+T5ke95Sf-C5PaRQ@mail.gmail.com>
 <20161201215934.g7dt5ioekmx6ssii@sigill.intra.peff.net>
 <20161202183622.GB117792@google.com>
 <CA+P7+xpoO=ieRyQb8r8Xz12nN10f53LKeVMgAO8XPdSwvG7fuA@mail.gmail.com>
 <20161202184944.GC117792@google.com>
 <CA+P7+xoi_UNSv-dKVFWf7T4o3uBtGa0wR6=nnYX+kjzLAmw6ug@mail.gmail.com>
 <CAGZ79kYPpc0=NAJaNPW+8faszOPAkq=b3m-EopY5A8oFwh+9=g@mail.gmail.com>
 <CA+P7+xpJ1=TiWq60wO4ftA-Y6SHAkdbLk=srbTQQsB=D1ZGkrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+P7+xpJ1=TiWq60wO4ftA-Y6SHAkdbLk=srbTQQsB=D1ZGkrw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/02, Jacob Keller wrote:
> On Fri, Dec 2, 2016 at 11:28 AM, Stefan Beller <sbeller@google.com> wrote:
> > On Fri, Dec 2, 2016 at 11:20 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> >>>
> >>> So is there a reason why the library function realpath() can't be used?
> >>> From a cursory look at its man page it seems to do the symlink
> >>> resolution.
> >>>
> >>> --
> >>> Brandon Williams
> >>
> >> I believe it uses the same method and thus wouldn't actually resolve
> >> the issue. But I'm not really 100% sure on this.
> >>
> >> Thanks,
> >> Jake
> >
> > I just reviewed 2 libc implementations (glibc and an Android libc) and
> > both of them
> > do not use chdir internally, but use readlink and compose the path 'manually'
> > c.f. http://osxr.org:8080/glibc/source/stdlib/canonicalize.c?v=glibc-2.13
> 
> Interesting. Would this be portable to Windows, though?

Perhaps.  It looks like the only crazy thing it does is use readlink,
which our real_path function is already doing.  I don't think we could
drop in their implementation though since there are other things that it
does that aren't portable to windows (like determining if a path is
absolute or not).  Rather their implementation gives me some hope that
it is possible to resolve the real path without using chdir.

-- 
Brandon Williams
