Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FB641F404
	for <e@80x24.org>; Mon, 26 Mar 2018 04:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750787AbeCZEsQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 00:48:16 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:50277 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeCZEsP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 00:48:15 -0400
Received: by mail-wm0-f48.google.com with SMTP id i75so12770977wmf.0
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 21:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=q97wyXFP3OD/ewj68cxcPV9Ap5mC98Qle65POUTONk8=;
        b=Q4/Qjp7nx72UBYgVR7zFALTA/DhJrD7iW8mXnJ4HUuyhxUzzAXmxLgsRq1T+k/u5AR
         Cq544/diHqU8w4udCOXhOnSD2B5MqLpsazpMNtamcOIPaJaHkMuHV12ujNHSCP7SHMPV
         B5i+uXw/KVkHdn1vFNlqO6DaRu7pzkVJZkVQ55aFJBFpf1AhqCTLvezouqRDiRknn1iV
         hfwJ3Vj0X0Q2bj4NEu5ypnRN+Odu9XGmv9UK5EDuPng5rUjlj9pNOHEMIyGbtyJYtEbR
         q/R+zDC41NnYXbypU+lrr0r6S6TFfAXXbjKTL5dUHyjnsbAj6sX9wvAtRPlxEjEolLQG
         gccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=q97wyXFP3OD/ewj68cxcPV9Ap5mC98Qle65POUTONk8=;
        b=qOIqCOea42UAN/d/lBuU13TKBu4VusUjgrZ18OU7Kl5QfcoeFK3rTJfUFvXXPCZC5r
         kH21QqfctTrmYblTKpZvDwsjG4xr5pr1St0lZUpv2bwO95eQ1VdWY2G5enMSS5W1y2QF
         A5wtx5C5QAWUyql/Nlnh6VW9uQFzb542KuG0/af2ctaEw2mtjgRbAywKSU11ajpJbk3N
         czYAXTdDN5fpPxi+Ri/vm0eyecJbVv+NW+iR/yCm9zwnXmakfzWTG4N9GPLeUcaaHe13
         qX1qRkvHftN0X7zuRuMobne23KmpY5qgq8vn9blJD784S6hCTvSRmX3/TYhNcehIkG3G
         atbA==
X-Gm-Message-State: AElRT7E0r6Jz8JqqWwAqFyJI4ggxt/H3xS6x0P9cHCGTiKXU2HgbVE6z
        cs45BeYrxSTwMWKfOD+40wMk+RDk
X-Google-Smtp-Source: AIpwx4+BGnRqC4jBbe+XL4quy1f61m2UMOlIyRIkSKsdyC29v9ocwqPXNRVVK1no05iW/TB0akrdPw==
X-Received: by 10.28.192.13 with SMTP id q13mr381237wmf.138.1522039693938;
        Sun, 25 Mar 2018 21:48:13 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w18sm11411746wra.25.2018.03.25.21.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 21:48:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 00/10] Hash-independent tests (part 1)
References: <20180325192055.841459-1-sandals@crustytoothpaste.net>
        <CAPig+cR==SNfGdhwqPdvW75fUxXg-VSQ5Tz_OR7Sy_c0L94axQ@mail.gmail.com>
Date:   Sun, 25 Mar 2018 21:48:12 -0700
In-Reply-To: <CAPig+cR==SNfGdhwqPdvW75fUxXg-VSQ5Tz_OR7Sy_c0L94axQ@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 25 Mar 2018 22:10:21 -0400")
Message-ID: <xmqq8tafe92r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> What's the plan for oddball cases such as 66ae9a57b8 (t3404: rebase
> -i: demonstrate short SHA-1 collision, 2013-08-23) which depend
> implicitly upon SHA-1 without actually hardcoding any hashes? The test
> added by 66ae9a57b8, for instance, won't start failing in the face of
> NewHash, but it also won't be testing anything meaningful.
>
> Should such tests be dropped altogether? Should they be marked with a
> 'SHA1' predicate or be annotated with a comment as being
> SHA-1-specific? Something else?

Ideally, the existing one be annotated with prereq SHA1, and also
duplicated with a tweak to cause the same kind of (half-)collision
under the NewHash and be annotated with prereq NewHash.

It's a different matter how feasible it is to attain such an ideal,
though.  t1512 was fun to write, but it was quite a lot of work to
come up with bunch of blobs, trees and commits whose object names
share the common prefix 0{10}.

