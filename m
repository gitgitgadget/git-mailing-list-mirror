Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D9D41F404
	for <e@80x24.org>; Thu,  1 Mar 2018 20:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161616AbeCAUa6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 15:30:58 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35853 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161584AbeCAUa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 15:30:57 -0500
Received: by mail-wm0-f41.google.com with SMTP id 188so14582137wme.1
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 12:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=i/Xxe3/1Di8kt7GP+bLtJnkcQ4dCY8VXyhbrxsS/7Ss=;
        b=rtWxQuaH8n4hDlJYsAqKwIOmIlTHpcjuozlwiSqHAptcgPjto50cr4sqgnHKOQIUrO
         uaRxViupVSu5Wi6f1K34I56Nz3eZ0eBtYbH266xjSQ4n1wcZdbS1gtsIny+YGPTfF+yv
         5THBg64KiVbwlXPJaemoeErT6DbWosRCA8Vf3Kxzy/MHPSOSHW3RGCKOn4wdiKBFyb0L
         tFPr+hA6MDNA1Eho4VwORa7+zJZVIvAlcfQCFTJgsbckD6TagOM05wWlzY6mhOfpZLvn
         R8Kak3HLzVPwwSSvX4CbO11az+HoVkUuc/YWPkiyyJ6IaZ8XSffq1+v06lb+NWxcyc77
         9fVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=i/Xxe3/1Di8kt7GP+bLtJnkcQ4dCY8VXyhbrxsS/7Ss=;
        b=UoSPCswlQld6QUxVAVF+QUf/6TtNFoz67SVKh7KUTIJuKS79xudZDXpcS99j8fQSqP
         N0/uO3WgfXeRSaRKf9f772obwZfqSc3u9YUtWNZZoFJG7YlGGJs/7MzCDsQYxu9VArKh
         5x+Xr1IPwzZ91kj0ncdrtL21RkbnLFeVCyMLmmdvX2PNlVEV9g7IRHaC0i7qONZEx0eM
         DRlAUcT5VmpP/s2i/spH+nJGOTyChsADL3k9rYyQSYcolRlDKcgi57p0xhPZl8EOwrIW
         7YxqM/PEPgsq/7uOXDoVthMetqpQjkhUKvRBdyowT3n99OJZtH4+2x89f77IVRdZFpr2
         aYng==
X-Gm-Message-State: APf1xPC1ARRfwsbUb6Tq9IszfOA66wL4FuR5PKctcIvw7TRPsa5ps7yW
        68LdCtbpMj99s6OGJtfs+x4Uq3Pd
X-Google-Smtp-Source: AG47ELsloCQBWiCNykjTcnwNNTpV5r4bSs1FvTS2oh7Tr5FXiaHbM46vvmbvGUEF0BR8ojqhTK4NDg==
X-Received: by 10.28.66.130 with SMTP id k2mr2622722wmi.15.1519936256020;
        Thu, 01 Mar 2018 12:30:56 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s26sm41730wrb.10.2018.03.01.12.30.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 12:30:55 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 9/9] add -p: don't rely on apply's '--recount' option
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
        <20180301105103.24268-1-phillip.wood@talktalk.net>
        <20180301105103.24268-10-phillip.wood@talktalk.net>
Date:   Thu, 01 Mar 2018 12:30:54 -0800
In-Reply-To: <20180301105103.24268-10-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Thu, 1 Mar 2018 10:51:03 +0000")
Message-ID: <xmqqo9k7fsht.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Now that add -p counts patches properly it should be possible to turn
> off the '--recount' option when invoking 'git apply'

Sounds good ;-)
