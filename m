Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39477C4332F
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 23:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiKTXvf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 18:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKTXve (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 18:51:34 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE9B2228D
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 15:51:33 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id p141so7571915iod.6
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 15:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aXaEWDAdD84oMWfcLspzn4VQoyis4CPCDUubXKON3qI=;
        b=mN4V0tIlxWpgE3i//eo6aFSTbKfK3423sG2X1UhhYPV0/mZv1AeKYeDthQ3FSpWGyo
         EZXnLDriaNTwY5wNwRWtDAmLPjj/q0cPVW5Tv5veZGxIQ8D3tZf4lvcy2ygRZ5fQzZ5T
         +X1TyBJNw9ABN3pHFBDSaXb0z20sOfU3L475FYzoUJgcHJf9Du+KuAJTPKB2QKC2So2/
         yfdzP+qO1ZmZprRJ+Ye8mTKI3sfdABQ8G2wIAOpO0y9DdRi/rGSdT1iSdyhJ6mP4NrOk
         9KfYcpE9MNyNdVUjx8wWe8wdVG8mVJDdHDqoeIqdNLfZbbwML2tIKDWy6urNkPk4Yzlj
         ERmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXaEWDAdD84oMWfcLspzn4VQoyis4CPCDUubXKON3qI=;
        b=C6RvXkN5xkmxVvTOLthXZu4lPNLoQYV5INH0qulJXV92uY5JcAyh+aep/miwwXcaFy
         za2E+1pQkJsHQtGYgY/++vmd/gyWJ9G7+1iT3JCTXn7pTlH1REMHX0Eclrg+dBOAZ20v
         SMzKf2MA1lMVc81o9f3U4fwQbZLsgvVGtyqFthBe9C34e4YLBvyqjvPszNmRuHDqJsCI
         twDupVQmnI6OFQU84khLE3mhA+kG4fUBIeoPqxi19g/YidxB8yNzoH3SAipHPVu4Dn7x
         0YF1u2qQdfWgDQAm+nyEu+s09XcZHSLx6iXMPAB3ODsVxAVmzQuvz3mcMj4lLB1gfbvN
         oLqA==
X-Gm-Message-State: ANoB5pnPm1umyQ47wDsRAeYB6NyOVE9LsW/5O356gjyraGtJyRbxhpGP
        b7R3T3Fs6X8RFwmxr7k6S/mkrDkl368v9Q==
X-Google-Smtp-Source: AA0mqf4MQzn3zIEpdyVVFZ6zw4mv0cj1Gm4HRyE7uUmwfDo2JfFt9RSp0tYiPB1v72eh0GDWfyIdxw==
X-Received: by 2002:a6b:b713:0:b0:6dd:e6c7:ad36 with SMTP id h19-20020a6bb713000000b006dde6c7ad36mr1738729iof.7.1668988292787;
        Sun, 20 Nov 2022 15:51:32 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w184-20020a025dc1000000b00356744215f6sm3744928jaa.47.2022.11.20.15.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 15:51:32 -0800 (PST)
Date:   Sun, 20 Nov 2022 18:51:30 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2022, #04; Fri, 18)
Message-ID: <Y3q9gmRS1Kcu3wdW@nand.local>
References: <Y3g95OYdwzq2OP3z@nand.local>
 <xmqq7czpjo60.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7czpjo60.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 20, 2022 at 01:45:11PM -0800, Junio C Hamano wrote:
> My immediate goal for the coming few days before tagging -rc0 is to
> catch up with topics you have collected and described here, become
> familiar enough to be able to tell which ones in 'next' are for the
> upcoming release.

Welcome back :-). Since I am now offline-ish, hopefully the descriptions
in the latest "What's Cooking" report are sufficient to familiarize you
with the topics in-flight.

But if you need/want a clarification on any of them, don't hesitate to
ask.

> Thanks again for taking good care of the project.

It was my pleasure.

Thanks,
Taylor
