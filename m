Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F89820401
	for <e@80x24.org>; Wed, 21 Jun 2017 21:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbdFUVzM (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 17:55:12 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34708 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbdFUVzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 17:55:09 -0400
Received: by mail-pg0-f52.google.com with SMTP id e187so30103435pgc.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 14:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9OsoP+n45SnHlyQQsrxktRhtuK5tQq3KXIwqG7wVEnU=;
        b=efQpVG7WyBDsFfZgTY3E5Y+tIZDXnNDMn5t5HAL81y4zmxeEEw7+AKzF/dsOi757dv
         c8tI9kwpijP7J0xSuD379vMEKAMhywUAHhgZGZUAh3MwVjQMhEciQAZ3WhFn/c6EAnAZ
         rmHlu9zmH1KjDbu7DGgAeCC8aCLqAwBKAnz+BN7WYcf6E7zg5pK6yIvLeI1cl1G0I6vs
         wracNBc3pzB6xh1/pW+3lHmKDXNzLRrEhN69GTFi77QIUmkbSqG7nOVuSe2CQ0tbj5n5
         8O1gHBVOIOMyXN1knUT0Fqs9tZBciiylSWJiUdRJ18JACNV86KQsn//eaKpuxf2pDlzL
         hjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9OsoP+n45SnHlyQQsrxktRhtuK5tQq3KXIwqG7wVEnU=;
        b=gixdVs35/9/vBtDH6ETdd26pR1cQavHmAP4lb6GReQ3at/65p/8b8HRfZvi1OJOnmu
         bvp+RAXOLp/iekDLE6w1Q0sbI5x02FqkKtmC0DuZkB6s27rKHsLbkDmnoSzSxT1Y6CRg
         rebDSvlTeoWPszotmDkTEpwp5JUxMPUOha6g09iTK/eIHSoyZD+Ey7oRdZHarIgHI2R4
         IVFUphQV4OTlzu6DHHef8y4b6nngfeH4NPrDWC1OA3HnVVrQBWuoW/cOvc8RYWdRNVPJ
         FY83LXbzJA2uxMTk4e1Te7oFMsYLvbPyndYRTcV4rpgLJ3gB6VMzLWU/mfBPhANdhlET
         Vi9A==
X-Gm-Message-State: AKS2vOw3QekoSXWzl8ToRxtS7A4MyR1kOObwbZPEk31oWYyPrswmSoGP
        oF6e8VzZC2pd1VRvGIOgag==
X-Received: by 10.84.174.1 with SMTP id q1mr43829477plb.8.1498082102938;
        Wed, 21 Jun 2017 14:55:02 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:d052:1af5:b2b3:bc81])
        by smtp.gmail.com with ESMTPSA id 66sm35116732pfm.82.2017.06.21.14.55.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 14:55:01 -0700 (PDT)
Date:   Wed, 21 Jun 2017 14:55:00 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 04/26] diff.c: introduce emit_diff_symbol
Message-ID: <20170621215500.GG53348@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com>
 <20170620024816.20021-5-sbeller@google.com>
 <xmqq7f05p1z7.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYUpJxX-wBU=ALPgJwVaA8h_iJRtAu3T7p4J7qmy=U4dg@mail.gmail.com>
 <20170621214551.GE53348@google.com>
 <xmqqlgolm2jk.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlgolm2jk.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/21, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > I don't think this is strictly enforced.  If you look at grep.h:197 the
> > enum 'grep_source_type' has a trailing comma.
> 
> OK, so we now know that at least since e1327023 ("grep: refactor the
> concept of "grep source" into an object", 2012-02-02) we haven't
> heard from anybody whose compiler fails to grok this.
> 
> Perhaps we should start pushing for C99 features?

Yeah for a second I thought I introduced the trailing comma when i added
recursion to grep...but you're right, looking at blame shows that the
trailing comma has been there for much longer.

And I'm all for moving to C99 :)

-- 
Brandon Williams
