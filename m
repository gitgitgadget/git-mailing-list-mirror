Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6717E1FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 19:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932200AbdBJTc0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 14:32:26 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33008 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932094AbdBJTcY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 14:32:24 -0500
Received: by mail-pg0-f68.google.com with SMTP id 194so3775416pgd.0
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 11:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fiqpnCOS9qDnL4phsHJ9SqYGfzlq2ixjaydneOifuIg=;
        b=XVrYDsJHpSTx1klalyWQqIf3u/oewS4Ne614sJq+mPAehTa4s497HfLQHiIVWMR0rB
         9fdLZ3Npg/ENPdsdUs+ClfjL77QH1eyUtvcUbLtVcoVD6Btzj/ekdfrl1vL2p668S/p+
         poNUsCCj4kbv0uyfd20SbqqIQ+uxN8kd8gHRJdmnPfswXm5aiyp6ALDUR1OpPktjK+/B
         fLVqSazVyp6THNXjHMXKTMfnLPmLz8A0v7UtwYCwNN6IK+1HnUmqzetjX7BOQHE85iQj
         NH3dhnQBZc7IWnW6jgLG/qyaC6quSI3EjiW3HLjYlujqKxJjL/y4Shmud+RRmVk3jVUP
         AbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fiqpnCOS9qDnL4phsHJ9SqYGfzlq2ixjaydneOifuIg=;
        b=dnMRZ21Xt4pGCInxxddvbezHpsNDkGkD0gh8xDJcn8OrHxg8t+NarqrrYE9OtasPwj
         V+lRsJDxjXjlcDbs75iAImEbrJg1b9t3Jx4xNmMAfMkIvjM28eYRUmSwi+nPj3+5aGtV
         sorh/vt+TZtzA6Q/uCOmmZP5ys6JAZsCWZPUV+Bj7qQFmKE43nG//OQzNX8VMOOMyj8B
         mMvZUxfxOXF/fubjAYrqdBr1dtQjGw5SzRs6i1w9Xp4WP0xbj4aod8hSt4Rjl8PujUBG
         2yl0NfeG3BjepLX96AMYnxuhE9f5PPyVhfIVnU5i5A3tBW7h65JxlbzhBgPF0COwXcmE
         idYA==
X-Gm-Message-State: AMke39kzes8jNinef1yp+zX35M0fzuDNiCk/c8BH5soMvO2jL/ygQfclDJ7LIMgknat+PA==
X-Received: by 10.98.70.194 with SMTP id o63mr12179104pfi.49.1486754623319;
        Fri, 10 Feb 2017 11:23:43 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8499:2e0a:2c80:2b60])
        by smtp.gmail.com with ESMTPSA id l12sm7151057pfj.37.2017.02.10.11.23.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 11:23:42 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/9] Store submodules in a hash, not a linked list
References: <cover.1486724698.git.mhagger@alum.mit.edu>
Date:   Fri, 10 Feb 2017 11:23:41 -0800
In-Reply-To: <cover.1486724698.git.mhagger@alum.mit.edu> (Michael Haggerty's
        message of "Fri, 10 Feb 2017 12:16:10 +0100")
Message-ID: <xmqq7f4xluiq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This is v2 of the patch series, considerably reorganized but not that
> different codewise.

Thanks.  The way the series loses "!*submodule and !submodule are
the same thing, sometimes" is easier to follow when presented in
this order, at least to me.

