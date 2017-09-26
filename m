Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF8E4202A5
	for <e@80x24.org>; Tue, 26 Sep 2017 00:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936562AbdIZAQG (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 20:16:06 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33613 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935704AbdIZAQF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 20:16:05 -0400
Received: by mail-pg0-f66.google.com with SMTP id i130so5741263pgc.0
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 17:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JXu9Njn2qd3VW3N06Ng7R4Zy6/QCrQ5q550YZXFnZ6k=;
        b=H2l2HN4eO/ya9lQZ0a1IdQWT6/uyUwIUCh89WAJRkO5O6Q6E05toavHWPRKySPra1X
         bJUS+EOcx8O+cWXwRRSrJQwWs66iPZ/I+B5cXFlMLMSPqlFDfJ2xTUfOBe16axn/QtY6
         v6dL/RmK6yTcZmuypGJF4CWaklGVxJrAINTjVkl/285EgkQj0hw5Nd/wiUGfYkCpoGum
         MymkNw+0VIK//81P/tCwo9lP9aFq/tfo6+fQwUFYm/tfoy74sIoOctQg8qgmUcXNCbgu
         bGVgvYYhRwQO+1M5wbK+XYaMGdjPlmP+sm3QPfrGYSXQMg5iiE6OPA8xJeR97Yt+h/vd
         bolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JXu9Njn2qd3VW3N06Ng7R4Zy6/QCrQ5q550YZXFnZ6k=;
        b=O6IN6w10viITdjZ7zGQ4B+uBZUl7qBi8cA08+oOta5Ri8/dc4HMEBfVEgiagNzMEWe
         BEesUant2Nr1//HKbXVaT4/K836M3GNQjlOt86AZTN6+rxcLry4kJgJHdssSRHI93E3G
         ZtyANqmAHMZfkvt0ntkf7JfuIjLncfKFcD55fiZxliyj96YvjKCRqWkKcr0GBRFMFRb1
         OyfYaHW4zAx+KAk3ELZEtYdYxXKz8MdrPYcDF7KuUfciyAJCFVwUcf310n4S6z8awndp
         zB0DFZfysahg2UZ9x0JvqByHymBRoJfjlD5djOMy9RGE7TU0Stct4Cd7YG03o7bCKp3Q
         tFpw==
X-Gm-Message-State: AHPjjUgvXKPZnMHtmnEgwJt9qg8+IYQntarJJ5TZ0dYdKfJM3Omo6nvN
        KWOKBmYE9zP4ORwLJmOCKJo=
X-Google-Smtp-Source: AOwi7QAR2Qnc0K2lXANvS15Q7/ZLJaudYHbT4i8Ssv3uD/z22RX7bPxD5NIWtscsuUgrVEICR/DRPQ==
X-Received: by 10.84.133.161 with SMTP id f30mr9296177plf.270.1506384965028;
        Mon, 25 Sep 2017 17:16:05 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:b5cd:5017:828c:d0cb])
        by smtp.gmail.com with ESMTPSA id b63sm14187680pga.27.2017.09.25.17.16.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 17:16:04 -0700 (PDT)
Date:   Mon, 25 Sep 2017 17:16:02 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 3/7] read_in_full: reset errno before reading
Message-ID: <20170926001602.GO27425@aiede.mtv.corp.google.com>
References: <20170925202916.4tqo4gttrsoy7kai@sigill.intra.peff.net>
 <20170925220914.GB27425@aiede.mtv.corp.google.com>
 <20170925232313.hhtqpxuzpzbnbdop@sigill.intra.peff.net>
 <20170925233316.GI27425@aiede.mtv.corp.google.com>
 <20170925233732.4lqavl56qwpfjuxy@sigill.intra.peff.net>
 <20170925234541.l6qcislhfwtnxf5m@sigill.intra.peff.net>
 <20170925235510.GL27425@aiede.mtv.corp.google.com>
 <20170926000117.y3solltovyueq3zc@sigill.intra.peff.net>
 <CAGZ79kZwc8bNWJfH_36soy75EpyHAMbJGhQd4rV5f-0RMjiwHQ@mail.gmail.com>
 <20170926000913.6x7qhj2vw73tldxe@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170926000913.6x7qhj2vw73tldxe@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 08:09:13PM -0400, Jeff King wrote:
> On Mon, Sep 25, 2017 at 05:06:58PM -0700, Stefan Beller wrote:

>> After reading this discussion from the sideline, maybe
>>
>>   ENODATA         No message is available on the STREAM head read
>> queue (POSIX.1)
>>
>> is not too bad after all. Or
>>
>>   ESPIPE          Invalid seek (POSIX.1)
>>
>> Technically we do not seek, but one could imagine we'd seek there
>> to read?
>
> ENODATA is not too bad. On my glibc system it yields "No data available"
> from strerror(), which is at least comprehensible.
>
> We're still left with the question of whether it is defined everywhere
> (and what to fallback to when it isn't).

So,

#ifndef EUNDERFLOW
#ifdef ENODATA
#define ENODATA EUNDERFLOW
#else
#define ENODATA ESPIPE
#endif
#endif

?  Windows has ESPIPE, and I'm not sure what other non-POSIX platform we
need to worry about.

Thanks,
Jonathan
