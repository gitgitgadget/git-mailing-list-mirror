Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF8A3201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 21:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754064AbdBRVO0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 16:14:26 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34288 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753600AbdBRVOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 16:14:25 -0500
Received: by mail-pf0-f196.google.com with SMTP id o64so6730440pfb.1
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 13:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2c97YvaMbUe83S0mzxXNFy5HplWIH6d3qHZgvnSIRDU=;
        b=U6Nz6OXzo2H7uKLmq7RFwDRX3tiaNkX4O3rYFTwrq8XHjpkpPA6x+prZCZRUKAxL0L
         qJmDwVBUArWlUoGnseUTgAX3gZT0kWQpyYGhx05BXkWhzxPPM5OZA2vDsOs1fbpfC+oj
         jqv1Xc/ZX5NdjLHevhiMy7OrbCW1z2D30xbIcDsk9HSC3EXV5yqwe+NG1rKSjEx4VORr
         gVUldWqiB2vv3G1DVdD0WtR949XJhiYj3K4IplEEBZnsbXLt5FRdRPWbH215pLQaboti
         R7e3D/WEwyOnG5dIbEif/rPOQB2fTv8tS3Fv9btlu7vaVurq9GkC4i4Y5CVMILggSf1c
         1Otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2c97YvaMbUe83S0mzxXNFy5HplWIH6d3qHZgvnSIRDU=;
        b=Chc980uP46hSJcKDa1lWGbObW+40fucedmxyRdsb0RqKvSgIf/3//lJ7oo/QL9nfw9
         iv9V636RhAr5abI1Wu9HHsP2RruK5esj+9bvQaLMHGHSsgq3dDSd/75Ry9HNVayFLaxu
         OJruY+UP5IMnk+4HAoiSQawkyRubMqbpd0r2gea+Hid8dmQt0zdYgp0edjxJ3UdRcJc2
         dcjmVMDUvnoKzEA2lU2mYM/HtxZpch95fFRRBJN6rQMZDnNw20Gqt29j07S0MLg65yXt
         k2JE9ypUYU92gOSVmPpAWXX1/mIhMHtL7NPxZKbQKdbdfUQGieghP05tf4Msscl2cVrw
         MUHQ==
X-Gm-Message-State: AMke39mph9WMopDPJVWqB+ShELTI88gW2jj2fA4UW9W4r4b37uXM/Ubl7PDIXKEuBOtNOQ==
X-Received: by 10.84.248.11 with SMTP id p11mr20472746pll.72.1487450918893;
        Sat, 18 Feb 2017 12:48:38 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a885:1880:3813:e02])
        by smtp.gmail.com with ESMTPSA id 66sm26763654pfx.29.2017.02.18.12.48.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 18 Feb 2017 12:48:36 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 0/5] A series of performance enhancements in the memihash and name-cache area
References: <cover.1487071883.git.johannes.schindelin@gmx.de>
        <20170214220332.753i4tgclm62er4f@sigill.intra.peff.net>
        <16b1259c-4cdc-8f4d-db47-d724386a3d2b@jeffhostetler.com>
        <xmqqo9y0m45e.fsf@gitster.mtv.corp.google.com>
        <20170218062943.j2llxuuylqs2qemy@sigill.intra.peff.net>
Date:   Sat, 18 Feb 2017 12:48:35 -0800
In-Reply-To: <20170218062943.j2llxuuylqs2qemy@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 18 Feb 2017 01:29:43 -0500")
Message-ID: <xmqqk28nmdi4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Feb 17, 2017 at 09:58:21PM -0800, Junio C Hamano wrote:
>
>> Jeff Hostetler <git@jeffhostetler.com> writes:
>> 
>> > I'll try to put together a before/after perf-test to better
>> > demonstrate this.
>> 
>> I didn't pick up the series while watching these exchanges, as I
>> didn't know how quick your turnaround would be, but now a few days
>> have passed.  Just to make sure we won't forget this topic, I'll
>> pick up these 5 patches in the meantime.
>
> Yeah, to be clear my question was not an objection, but mostly
> curiosity and interest.

Yes, it was very clear that it wasn't an objection.

But the other Jeff sounded like a follow-up was to follow shortly if
not imminent so I decided to allocate my time on other topics still
only on the list first while waiting to see what happens.

