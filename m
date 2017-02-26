Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30DA020254
	for <e@80x24.org>; Sun, 26 Feb 2017 18:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbdBZSXQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Feb 2017 13:23:16 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33093 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751299AbdBZSXN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2017 13:23:13 -0500
Received: by mail-pf0-f195.google.com with SMTP id p185so3038261pfb.0
        for <git@vger.kernel.org>; Sun, 26 Feb 2017 10:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qLhSgWWnei4GifGsZzra3IjHnPEX2Wrzx8/Foz1192I=;
        b=iWZKVvRQBXoez4aMxSP6fwAhet2Np8HDLfISoLSLxD4V6CsSJOLgzHvQo0nUtk2BMP
         uzIxw/2jmtna6cNIFDN/WwzBiThV9mnZBajabVesc7opkvTALrzJTHzc3dogVZJkLYzK
         Y7bis8d4AzU1td8q2F5NNAxOCuswMwaq8+MmPeoyG2/d/ccBmzX3NDBh8xovgZysO2NV
         qsyjXUPl4E+XzH1qSAfejcYaFMFtvd6maWC/aet0BH7FTuj3xzfazwOZ4p58gfO6ZfsY
         mfeDWNnQe3yfKHm1dVQ0V5Zt6VHI9zeTU32065bF0CNWrCBJ4wbgFVXNA4Ct4r/Z6FVi
         Sndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qLhSgWWnei4GifGsZzra3IjHnPEX2Wrzx8/Foz1192I=;
        b=ec2+KaPzjmMp9uN8E36F+SzMpu9I0jv+1cY80eLKo/SYcNIZB9mg+77MToBWH4cdof
         zfHEcdumNGX345lw1igguSHJrhvtOxZfy+5Q2Z2FHk/a+/Xy1bg8hVio4ed3GyEyknv0
         5UWc45EFNk4CiUB3dywsUXTMl6+PlWKdrD+EyiF6V0u+6tzFBaEOjAkP7aCZZhTHxhIk
         orjcgcJbFulGcEsJ7BYLpN/LSX+x1XMPq1uRJfNFjjhP9Hw0baSjztkSL6pS8pSfD1yh
         HcJPqGfwt7WT2bBORiLjxuhUbTqETV7U1p60/R2i8iuIgtoWhgAZSeHmBdSs0ghEWWPp
         tciQ==
X-Gm-Message-State: AMke39lydj4aaJqoeTrFGpMCv0OycFY4JmyFFKRW4vZ5BUI2kdQK6juKDtvTVqT8OjT43w==
X-Received: by 10.99.51.76 with SMTP id z73mr16413825pgz.137.1488133376085;
        Sun, 26 Feb 2017 10:22:56 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2939:e4:e178:8ba9])
        by smtp.gmail.com with ESMTPSA id c2sm25854619pfl.61.2017.02.26.10.22.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 26 Feb 2017 10:22:55 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99b?= =?utf-8?Q?ski?= <jnareb@gmail.com>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org
Subject: Re: SHA1 collisions found
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
        <9cedbfa5-4095-15d8-639c-0e3b9b98d6b9@gmail.com>
        <20170224230604.nt37uw5y3uehukfd@sigill.intra.peff.net>
        <D74A82FF-BF00-481F-9B2A-4AF8EF3D062F@gmail.com>
        <20170226004657.zowlojdzqrrcalsm@sigill.intra.peff.net>
Date:   Sun, 26 Feb 2017 10:22:54 -0800
In-Reply-To: <20170226004657.zowlojdzqrrcalsm@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 25 Feb 2017 19:46:57 -0500")
Message-ID: <xmqqzih8yfpd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Feb 25, 2017 at 11:35:27PM +0100, Lars Schneider wrote:
> ...
>> That's a good idea! I wonder if it would make sense to setup an 
>> additional job in TravisCI that patches every Git version with some hash 
>> collisions and then runs special tests.
>
> I think it would be interesting to see the results under various
> scenarios. I don't know that it would be all that interesting from an
> ongoing CI perspective.

I had the same thought.  

I view such a test as a very good validation while we are finishing
up the introduction of new hash and the update to the codepaths that
need to handle both hashes, so I'd expect such a test to be a good
validation measure.  But once that work is concluded, I do not know
if tests in ongoing basis is all that interesting.
