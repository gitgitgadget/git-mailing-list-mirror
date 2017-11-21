Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 817D72036D
	for <e@80x24.org>; Tue, 21 Nov 2017 22:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbdKUWrN (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 17:47:13 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:36258 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbdKUWrM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 17:47:12 -0500
Received: by mail-it0-f66.google.com with SMTP id 187so4046125iti.1
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 14:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0fz3PIsVEtwo4JzSXY6NoPiabEAGt9dbvQj1HamqIJ8=;
        b=pPECQ8qC3Hhu8HBZeqLeCp0M/J4JhcZ8+4VpjOLLA1noSYDMFFVBdPqUzSLXJupQTo
         ws1W//T+jq+wMuVxe2gIGyInQb8T8D/FErgZpNjoTHDZMo3kv9rXDAKS01gPsh2qv66Y
         BvIYTyLXzl5Ohx6lepHoWZsdCnbdK2vFsUW8ljTrH1ACRfgpA8JGeO/ekayswqqStrpm
         rDZeg28jo/vs17O4h5K+hDMLzGgIUfMOxv0DubRibPNhPdkdifovU/y76kCtnfGV7nZ/
         MDsSPt7D+z9+djE5eNRPBBR76f7Y8bDWJJzii1aZ2Rnxa5qVsMvNip2y2XXpLLPaeNNv
         r2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0fz3PIsVEtwo4JzSXY6NoPiabEAGt9dbvQj1HamqIJ8=;
        b=uJccBZC2D3pDWFzsGRZ7h2uzEu6cICVCbEc1wCosEh1mDvG+qOK4iKeL1NXNGUFWSx
         PxSSmGATaXDqCXk/QTr1HFaOnZ5ASbhTcE5QaSqo6v3nlHzKmDR9zl62FQZvsIgpoMes
         B32S5k4gNJld3o4azRoO4IPRazIoZzJ7MxldQgXKvxGDkqj+iuSJF3Y6vKuwyUaNEfBw
         pC2MZyzpJYIyP7Wk9P7NqA81vlhNp3he5ySqH0dFnI+tqd/sr8Be2nlRCYJ1p8iMJ8Ce
         GVxPYzH6SO98rLAmWV2iW1yYL4CkdaauwEdwu0+6ucn40rOHeBdw//a6Bp4OWjZMZbIV
         fbOg==
X-Gm-Message-State: AJaThX5tzwSu/pae0TEwI4F5HIB8QpUpcIEQKu0kVxDAnwviGUbVmydq
        85H+YWCfalQ97SKpceXhJd0=
X-Google-Smtp-Source: AGs4zMasVfu+V6vgA5BiukuhzSdkKrRYVh6gUUYQmm7zFmC3+2ngSxdDo+fKiw3umZPQYXvLjaMcmA==
X-Received: by 10.36.37.138 with SMTP id g132mr4420824itg.72.1511304431785;
        Tue, 21 Nov 2017 14:47:11 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id o1sm1188170ite.2.2017.11.21.14.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Nov 2017 14:47:11 -0800 (PST)
Date:   Tue, 21 Nov 2017 14:47:09 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] recursive submodules: detach HEAD from new state
Message-ID: <20171121224709.GJ3429@aiede.mtv.corp.google.com>
References: <20170724173601.19921-1-sbeller@google.com>
 <20170724180312.GE13924@aiede.mtv.corp.google.com>
 <xmqq8tjdcyf1.fsf@gitster.mtv.corp.google.com>
 <xmqqr2x5bhk7.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZdoktBRBuNxVk-zehZR3Z-egEPG81KQ9WqHTEtrm+5uw@mail.gmail.com>
 <20171121223449.GI3429@aiede.mtv.corp.google.com>
 <CAGZ79kZxD4r0J+uZCuBStkZq1mqPSTaOdkpyOmPXjdLLr6rkOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZxD4r0J+uZCuBStkZq1mqPSTaOdkpyOmPXjdLLr6rkOQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:
> On Tue, Nov 21, 2017 at 2:34 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Stefan, do you know what thread I should look at to find the current
>> state of this patch?  I've had it applied locally for a long time.
>
> It was "Undecided" for some time, then Junio kicked it back to pu, expecting a
> reroll[1]. The "send out a plan" that was referenced is found in [2]
> describing 6 plans for the future of submodules. The approach in [3]
> which is different on the implementation level, but very similar on
> the UX level sounds best currently.  I'll coordinate with JTan to
> come up with patches for that.
>
> [1] https://public-inbox.org/git/CAGZ79kYUZv0g+3OEMrbT26A7mSLJzeS-yf5Knr-CnARHqVB=aQ@mail.gmail.com/
> [2] https://public-inbox.org/git/20171109001007.11894-1-sbeller@google.com/
> [3] https://public-inbox.org/git/20171108172945.33c42a0e91b4ac494217b788@google.com/

Thanks.  That thread appears to be about a long-term plan; what is the
short-term plan?

E.g. is there any additional documentation that should be added to the
patch that detaches?

Or should it go in as-is?

Thanks,
Jonathan
