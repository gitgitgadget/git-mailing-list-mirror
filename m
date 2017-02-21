Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B04E7201B3
	for <e@80x24.org>; Tue, 21 Feb 2017 06:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbdBUGJQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 01:09:16 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35345 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbdBUGIV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 01:08:21 -0500
Received: by mail-pg0-f66.google.com with SMTP id 1so9271050pgz.2
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 22:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ee1FCpWIRX4VsoOXjH3DL9gXhAFtRCq9qrgaz6RvDSI=;
        b=Ap/Dwwt0GnZtCAGvO0LVA8C0gEPCLxirUD41SMohimT5Xc0JqMjpV57ym1zPug0mCv
         t0wo8izo9+zBsoehUAg66yOAv45oP+cmB2zZg1Dp0k9FWIJ30dLK8LqzyxLU2k0YnBPi
         5J7WvPAmjCkdxTA8pzgLZ/CEo+vDloY8KU/wQzkhGudZjJ70Ma5l80Vr+acGK7hGqugj
         pWKiXcSU8GDoD6rEGqjDi1c/E1HgU1km+LiFkbl6+0EFy+QqAfb362Bi1Ct1APXE0YhX
         mN0T/ths7m6C8asqShQ1Y1yc9coVysOj6qQKpWOzriumnEA8/NgbZulnt26Sa6TgVmTN
         AnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ee1FCpWIRX4VsoOXjH3DL9gXhAFtRCq9qrgaz6RvDSI=;
        b=F/eHX9uoor8snFX6S9OO2/wYu4dfPB+dIA0qoCK83GzRGYN6vwW5gPqQJna3dYVrfJ
         o7SUt2douYIxAZzVBjgW8tNOkKJb6uhz5POlPFLL4De7n7zuvF9oiTInbv9XCLQawLxy
         Vpsm1ZYFlp7LtXwzhx/z9xeWJnxAPN4yo2clOdTePcs8+GiZU90DFLcl9Pp8rrMf0nbY
         XkFIhRM26hF9naeQXvG5MI9AQeyfByzSPthHxSREA6MfQiOMRrXoTym/kibCvhTTYNYd
         oqM9mOS4GiYG+mNm6tNdnI8HFiGTPItBPOpla7UOVTAaS/KGfNa0wXKWGNUeL8WNB3T1
         M+PA==
X-Gm-Message-State: AMke39kVTs1hczGJhm7CNXi8R/1dekzpbFH8mZfYoi7CejHBHqqKy0f2mH472YGkd6PQ7g==
X-Received: by 10.99.105.8 with SMTP id e8mr31966275pgc.217.1487657300677;
        Mon, 20 Feb 2017 22:08:20 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:71d2:895f:c7:4f5e])
        by smtp.gmail.com with ESMTPSA id 129sm38313925pgj.59.2017.02.20.22.08.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Feb 2017 22:08:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Sokolov\, Konstantin" <konstantin.sokolov.ext@siemens.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Inconsistent results of git blame --porcelain when detecting copies from other files
References: <71BF70CE41AEE741896AF3A5450D86F11F4268FF@DEFTHW99EH3MSX.ww902.siemens.net>
        <xmqqd1ecim8a.fsf@gitster.mtv.corp.google.com>
        <20170220221540.6vemjdvyvwonpqyt@sigill.intra.peff.net>
Date:   Mon, 20 Feb 2017 22:08:19 -0800
In-Reply-To: <20170220221540.6vemjdvyvwonpqyt@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 20 Feb 2017 17:15:40 -0500")
Message-ID: <xmqqzihggjos.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The simplest way (IMHO) to parse --porcelain output is:
>
>   - maintain a mapping of commit sha1s to the commit's details
>
>   - whenever you see a "<sha1> <line_nr> <orig_nr> [<size-of-hunk>]"
>     line, any key-value fields which follow impact _only_ that sha1, and
>     you should update the details for that map entry
>
>   - when you see the actual tab-indented line content, you have gotten
>     all of the key-value updates for that sha1. You can now safely do
>     what you like with the line entry.

Yup, that was how the output was meant to be read.  At least in the
mind of the person who designed the output format ;-)

