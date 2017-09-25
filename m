Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 741D420A26
	for <e@80x24.org>; Mon, 25 Sep 2017 23:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966158AbdIYXwe (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 19:52:34 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38736 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935960AbdIYXwd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 19:52:33 -0400
Received: by mail-pg0-f65.google.com with SMTP id m30so5716584pgn.5
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 16:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S5aFPU0lQUj/S3aiHx5RsPK6qcOBiEjfP8vKGIrnAxs=;
        b=gIKWk6LKVBtDx6If9wUIkRzF4j0IZwIafO4eFP45sqMnapBEEcgIVrNRWeR8Cg/Kln
         vomO4dxbi9MnRKs2EP0anz32hbZ+IL8GbSo22NhLe5KngbLuuIjgrjRTeiVj8YO9g8iV
         p92LmKTOevyBwysCV+i67jC8cvMWNp8ON+g2bl7iKY1Z72hJRpkoeWmEPKDjKZ2mhqQV
         CsdJH5PJCHJJXJzBec4VoVodKpca5gPAnFvWodEmuD4EePrcmFmvXzVAWws5E5oGaB6A
         rI0dnZ6P+sZJq8zeE7fJhLRfXjRr5nyZupLSZiyTCu9LABkCsPKObbFxUIWyYNvwDA1A
         2lcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S5aFPU0lQUj/S3aiHx5RsPK6qcOBiEjfP8vKGIrnAxs=;
        b=ZY0wONeM3tiKCNM/6Ygjo3Fmm5QbwH8OKWv74LZueEMezCnoKU/GjQYkXz+JZ1dqYy
         uSELA5CykXMXeK9iJfemhoa50mbr6BAw6v3MGF2HpS8ABQ7t+3CqVgTlM3uo6JMVjYOG
         G8DEb5qQ9ebTPX01YHfpr/I0I9eLxBl3v4oEInbzryrlPw/PVm65p0P/l0UaMo28NfsQ
         JbeJ+adfEhXd7E82cigmCHnlwRVOaecok9nHDmvyTaEGV5fNDuwBL/BVvkeLyusPKL9X
         4QcBk1GRYpbORLZSPx6Lkv3iKd1ZxFfoAsO7/PX421ACS5DUGOwkVDlHLWd9LaDusuDD
         6mGw==
X-Gm-Message-State: AHPjjUhqvM3eHSPMd/mC/KAQ1uA68MJST1PSzWlkLvevEv1Rda4wfxl5
        Y8J3Kt6GQkuI+XDZYqulF1FysK7Q
X-Google-Smtp-Source: AOwi7QCtEm0RVMxdEyPBz9U3FQonlqX3rBu+24IOhTaIeEpEWIxYFW0L5GWStTVTm1Qn6xFcLs+Wmw==
X-Received: by 10.84.242.68 with SMTP id c4mr8985502pll.292.1506383552876;
        Mon, 25 Sep 2017 16:52:32 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:b5cd:5017:828c:d0cb])
        by smtp.gmail.com with ESMTPSA id i188sm11301993pgc.63.2017.09.25.16.52.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 16:52:32 -0700 (PDT)
Date:   Mon, 25 Sep 2017 16:52:30 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/7] read_in_full: reset errno before reading
Message-ID: <20170925235230.GK27425@aiede.mtv.corp.google.com>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
 <20170925202916.4tqo4gttrsoy7kai@sigill.intra.peff.net>
 <20170925220914.GB27425@aiede.mtv.corp.google.com>
 <20170925232313.hhtqpxuzpzbnbdop@sigill.intra.peff.net>
 <20170925233316.GI27425@aiede.mtv.corp.google.com>
 <20170925233732.4lqavl56qwpfjuxy@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170925233732.4lqavl56qwpfjuxy@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Sep 25, 2017 at 04:33:16PM -0700, Jonathan Nieder wrote:
>> Jef King wrote:

>>>   errno = 0;
>>>   read_in_full(fd, buf, sizeof(buf));
>>>   if (errno)
>>> 	die_errno("oops");
[...]
>>>                          in general we frown on it for calls like
>>> read().
>>
>> Correct.  Actually more than "frown on": except for with the few calls
>> like strtoul that are advertised to work this way, POSIX does not make
>> the guarantee the above code would rely on, at all.
>>
>> So it's not just frowned upon: it's so unportable that the standard
>> calls it out as something that won't work.
>
> Is it unportable? Certainly read() is free reset errno to zero on
> success. But is it allowed to set it to another random value?
>
> I think we're getting pretty academic here, but I'm curious if you have
> a good reference.

Yes, it is allowed to set it to another random value.  It's a common
thing for implementations to do when they hit a recoverable error,
which they sometimes do (e.g. think EFAULT, EINTR, ETIMEDOUT, or an
implementation calling strtoul and getting EINVAL or ERANGE).

glibc only recently started trying to avoid this kind of behavior,
because even though the standard allows it, users hate it.

POSIX.1-2008 XSI 2.3 "Error Numbers" says

	Some functions provide the error number in a variable accessed
	through the symbol errno, defined by including the <errno.h>
	header.  The value of errno should only be examined when it is
	indicated to be valid by a function's return value.

See http://austingroupbugs.net/view.php?id=374 for an example where
someone wanted to add a new guarantee of that kind to a function.

Hope that helps,
Jonathan
