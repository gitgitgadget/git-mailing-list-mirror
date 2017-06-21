Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E189A20401
	for <e@80x24.org>; Wed, 21 Jun 2017 20:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbdFUU1A (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 16:27:00 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35434 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbdFUU07 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 16:26:59 -0400
Received: by mail-pf0-f195.google.com with SMTP id s66so32702841pfs.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 13:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=W7QkKSURKLNLiZFVBYMG1tHSpThKVGsl6zkVf+eMpmQ=;
        b=V2zTG4ip0/k9yrZoMJt9CfuC7tQ6iwtYMCwORcZKFJepn6+lm+feee1HwQNtHNlQtL
         jZ2p1ZT7YcZ1bP8YKdrCYDJBfxyJXQyhFHnWD8JHzFZxtyDONQGJYxd0Cc1wPdro49WC
         4ymhDkYS6dH3iQWOxZHd1u3y8BaytHo6HNb7qx7NRX+M8KfYoKqZjPgJDneg3tq2zBc0
         W5Q6YKodXZ6kt0cAL6aAISUhqmNlJGp5vwetvoq0y91ksMeWdtWp4WMYvt3zx6CTEsl4
         uES5kh8iRYKITBReT0NYc4AdzM9vG4O/MSWk2x0/EwPP39lOR6h7aIg4ezb2YaOSI+Sd
         nf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=W7QkKSURKLNLiZFVBYMG1tHSpThKVGsl6zkVf+eMpmQ=;
        b=NWHisEtPuOZ6h3N+M4NdNI+gi3HsJSCtEazfPtzLcp4uja9U3a6+QBaIlaa6ERbgHJ
         Oq+TrKKFoxIfWaf02+xKehVpOVrarZ7YJKcwplDD3eUf5zkAmXvrM9yxdBRSAPVhhmac
         cgTUSQhICekNjcfr21ZHl9Tdajkh6uacAaEl91JV1PvK7PTCoQTHMNeIZwg+RmXhkLuQ
         mzcB2ixoVTT1rJgx5WkZlORE4QaFAJwdpOmvx3+9br1PYplY5DBjf6hpRuB17InP0ANO
         iq9pk4ymlOR83Q+EmNYDMGlN2PD7+k7+nZMz3QP8NSY2SYXmfAv7nvpUIgvlhkdMXe3b
         Fq0g==
X-Gm-Message-State: AKS2vOz+5aHe9djEAGNtSM6f3nQePqv8uCOisUpff82ENhVdp1ATF6VR
        nyTctiHLaitg/Q==
X-Received: by 10.98.87.29 with SMTP id l29mr3217423pfb.3.1498076819041;
        Wed, 21 Jun 2017 13:26:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id n9sm20426766pgf.50.2017.06.21.13.26.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 13:26:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 04/26] diff.c: introduce emit_diff_symbol
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
        <20170620024816.20021-1-sbeller@google.com>
        <20170620024816.20021-5-sbeller@google.com>
        <xmqq7f05p1z7.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYUpJxX-wBU=ALPgJwVaA8h_iJRtAu3T7p4J7qmy=U4dg@mail.gmail.com>
Date:   Wed, 21 Jun 2017 13:26:57 -0700
In-Reply-To: <CAGZ79kYUpJxX-wBU=ALPgJwVaA8h_iJRtAu3T7p4J7qmy=U4dg@mail.gmail.com>
        (Stefan Beller's message of "Wed, 21 Jun 2017 12:46:09 -0700")
Message-ID: <xmqqefudnl2m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This will be painful though as the next ~20 patches
> add more symbols mostly at the end.

> , maybe I need
> to restructure that such that the last symbol stays the same
> throughout the series. Thanks for that thought.

Yes, this mostly-no-op one added in the first patch can be kept
always at the end.

