Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFB9B20986
	for <e@80x24.org>; Fri,  7 Oct 2016 18:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932276AbcJGSpH (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 14:45:07 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34704 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932132AbcJGSpH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 14:45:07 -0400
Received: by mail-pf0-f175.google.com with SMTP id e6so27142665pfk.1
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 11:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OtwEzwM3i3HrVLEIoiMiPlYbViN0RXaF1eTSDyW+Ivs=;
        b=C6aH/0r9LEXAGS5K87/bsprrwVyQPRmk66yTUVCuHMpEjHRKFljmYbfYPR4b8Wx0NK
         EwycSMuP1O+wXQFkKtle6XAAkxNU8VLp7c+8Ct92wrXK7UOs8J2fmA0XbXy1Rv+jd+wG
         ZZnAyu6Dz1IpWoVvKfDAxKqf7l0nrKR7H/0NTn+r8Yw2lGmEOIyDyWDSaFL4+zXjSSdS
         ASHy4yWRwaHDtJ2Yqg/UeEBl9qUJ9bJdbgf+6/XLL89V11n01feMXWidxGW8wL0NgTmV
         zQxe8yKVspprGFeKI5z8klhi3zlUfvHg8wcb+bGguSQR3IsA6o1YrcncCHI04LkcO/gr
         vP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OtwEzwM3i3HrVLEIoiMiPlYbViN0RXaF1eTSDyW+Ivs=;
        b=V4hXlkfndPEbTDdto0Nrt59Ucsj6Q/ll4wUYF1PoYN3DXat0t5Cec/BUlRQE99+gb7
         4Hp3vQwUAckaBl/eV10hR1Y6K/d12HsoLfCPyjpCtixsI5Mq14aS4kMc0V1pF3Y1Ijya
         s+66Kwt3931rUAdc7rEzvkIM5+GTWOvT6JeSnkHO2wT4C3QTUHnXCprmksTzcq4bQbgQ
         ov2pLqS8XN3dheufAVHxUmiacMY3DQIk+SWiUldLhNa6ri8Dqhubx5SPSgW/Sx9jOVp3
         Zkj/QNkrbsBlLYxzYbK84VRfEWf16wsyf5FfhUpxe2clIdzvrQTs38dJ1sDGju3ocKwY
         n1sQ==
X-Gm-Message-State: AA6/9RnKcL8nmXTLMaM6Fs6SSecVS1JPC7UcVhMWghhMoDVDBgEJxKvUq+lvBUKMS7FoRTAb
X-Received: by 10.98.64.10 with SMTP id n10mr29498604pfa.96.1475865906190;
        Fri, 07 Oct 2016 11:45:06 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:d8ba:60ae:e84d:86d4])
        by smtp.gmail.com with ESMTPSA id h65sm15772929pfg.15.2016.10.07.11.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Oct 2016 11:45:05 -0700 (PDT)
Date:   Fri, 7 Oct 2016 11:45:03 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 0/4] recursive support for ls-files
Message-ID: <20161007184503.GA16132@google.com>
References: <1475185723-36871-1-git-send-email-bmwill@google.com>
 <20161007181851.15063-1-bmwill@google.com>
 <CAGZ79kacgsPg-dzx7JRyhA2bq9JMb2Cyg9PjWbnKi9ZMTPw7RQ@mail.gmail.com>
 <CAGZ79kZo-hL5-rCdw2VA5ce+xpizbGUdkS8ddb6eMC8qQoRSVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZo-hL5-rCdw2VA5ce+xpizbGUdkS8ddb6eMC8qQoRSVw@mail.gmail.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/07, Stefan Beller wrote:
> On Fri, Oct 7, 2016 at 11:34 AM, Stefan Beller <sbeller@google.com> wrote:
> > On Fri, Oct 7, 2016 at 11:18 AM, Brandon Williams <bmwill@google.com> wrote:
> >> Few minor fixes pointed out Stefan
> >
> 
> The series itself looks good though. :)
> 
> Thanks,
> Stefan

Thanks! And I'll keep that in mind for the future.  Still lots to learn
about contributing to the project.

-- 
Brandon Williams
