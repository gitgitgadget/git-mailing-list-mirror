Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EEC51FAE2
	for <e@80x24.org>; Tue, 27 Feb 2018 06:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbeB0GVd (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 01:21:33 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:50708 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbeB0GVc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 01:21:32 -0500
Received: by mail-it0-f65.google.com with SMTP id a75so13800578itd.0
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 22:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RNJl3tjz/kvgou5gc8JCEEIVPNL08BmhYZyVXEY8Dbo=;
        b=jRfuK0Nqz6IkdEEVhsUvm2UKspT+tUjbwlOxT+xveRPtNizBN8jXkJu5G4Eg2LLG6V
         G99VNZV5hrP4AbxoxAvnrAuaXtZDg3dzOfDar3Y2TO4awpOgnutv+wdsFxJSsj7YIJCr
         HJ7Eigk8+p5qPn6ULdhNdCQg3ZTO+z2B5CDYWor8r4vdLGqURX80iXGn4Py1ZAuOBT/i
         60/SF3vdbq8Hwt5tZlPji1wwM/iBAohjgIxQVsMqH7lbqSxdR24PbHxmxoG+BV7rWJMQ
         aikLSKKlmcWZIsZ6tLUyeAWgF2Oaj0zgm9UUjJ9jI5DqrJztEsmMW7nSZKjTKoa9Vuf1
         Lrbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RNJl3tjz/kvgou5gc8JCEEIVPNL08BmhYZyVXEY8Dbo=;
        b=GvHemqRxDJhlK5HSJqNqvIARxABC6N5SioSufCSXq8kfSNkScsvDb7NQLOgV/BYCU/
         8jRglpTJTdaVNKhmpIaE6qpcmpKdGW0kS2q5ZlG7g3n9syRfPyc5374zaG16JxFPROWT
         LgvrahCJiy53pTlDeLCsbQ/f7cnfEiuHAohuaKoU9go2AQ+ysvIt22sj0kU/j9bbckXt
         lE+a8WNI5xPXcb144uJ4XEINvijUz2c62/InY+lACqeWdmLNhGu6NezRebdri5yl+fFl
         eAoeWgvX8N9QgvO0XqAvSbmak0b5lFUIH7WsdtpvdbTyf+5UnEZRYnqU63oszMBxL8Q9
         5t4Q==
X-Gm-Message-State: APf1xPCL4VbRAmBRzIVPMLp4BcxXjXGyfRgmpm7sRIEQ0sKKgGdrbC/W
        bqXHBtMvHAvfD9dltxcVnEo=
X-Google-Smtp-Source: AG47ELt5hUbpouPIa8CH2ep7wR3uywLk00IJTmBXoih82wC8FA3ejcZ/yTmKbuVQb1TU/yxiBaY48A==
X-Received: by 10.36.77.143 with SMTP id l137mr14679517itb.118.1519712491885;
        Mon, 26 Feb 2018 22:21:31 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 27sm5096547iog.17.2018.02.26.22.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Feb 2018 22:21:30 -0800 (PST)
Date:   Mon, 26 Feb 2018 22:21:28 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        stolee@gmail.com, git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 14/35] connect: request remote refs using v2
Message-ID: <20180227062128.GG65699@aiede.svl.corp.google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-15-bmwill@google.com>
 <20180221145411.35b2ea84747518a499276bdd@google.com>
 <20180222181922.GD185096@google.com>
 <20180222182657.GE19035@sigill.intra.peff.net>
 <20180222112533.0d7c6023fb8e4098efedfe31@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222112533.0d7c6023fb8e4098efedfe31@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:
> On Thu, 22 Feb 2018 13:26:58 -0500
> Jeff King <peff@peff.net> wrote:

>> I agree that it shouldn't matter much here. But if the name argv_array
>> is standing in the way of using it, I think we should consider giving it
>> a more general name. I picked that not to evoke "this must be arguments"
>> but "this is terminated by a single NULL".
[...]
> This sounds reasonable - I withdraw my comment about using struct
> string_list.

Marking with #leftoverbits as a reminder to think about what such a
more general name would be (or what kind of docs to put in
argv-array.h) and make it so the next time I do a search for that
keyword.

Thanks,
Jonathan
