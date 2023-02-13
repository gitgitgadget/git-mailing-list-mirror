Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6BBC636D4
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 19:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjBMTD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 14:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjBMTDL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 14:03:11 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3FF2279F
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 11:02:45 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id e17so5661296plg.12
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 11:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpoO+Lqe0jZFXTs6WNf0L8Gz+S/e7tzURRw1ZmcdDE8=;
        b=UT6hjzXvvwxBwIfKwFkxG6/9y3xFPBVYEYifkOf0CXifLqO66SSKqIqNfUJ8QD8Nd6
         ESVsyhTM7mE2eNN2VTTKgwy0LPYGB7ytOcljD9qinsavqm+4LxPmxMjvOqO0Hx2492wx
         PMXt2avTl3HP1LS1r8z98JaRDNIBiBZtwy3eRQ2358io1PkxdYoowfMwYHOg7QKoxcsf
         PQXkfdZLxKmAuQK5MhO+id3nD9Wkw+Wk7uo3lh1wIcFcEwYYE0ajtd1MeR039jXKs2gH
         EvvbMn9S4eHa1TuLD4bvG5H/TGo/LHDb66hrdsEuFVl1alUCQQxPQ1Z5kQmk1Bgk9AfM
         eiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jpoO+Lqe0jZFXTs6WNf0L8Gz+S/e7tzURRw1ZmcdDE8=;
        b=jeWhugXXVi3WyAbg6WGEfYnnhr2tFPpsI3ypNb8e0ojU+Nh1tMBL/N6+xLs1dibtuc
         AHTPVXD7mXELk5gNJbdRZTSz3lF2JE1ZyH/Kq8C+fTpKNLciRO8995WkCgh8K2N+UWk/
         4YjL5OLGusVYwOpOn5TzcfYtRX/yBwFHgpLspAugOoW4vyLU+0ucoeKugnOVsWulf/mc
         X+CQN4iICzPZjzf7jNyTJ8t+rNVNYY3lFQkCm7Yn9Io+ee83uGhLdM3VPR2/c+aWoAqx
         DKOcbGHegV0/cZQ9SRzDJvAB6/qFAR+Aua2AVtxQW/cS6uQcaRiNZ4n0NjWLzX2oZ9gi
         qymA==
X-Gm-Message-State: AO0yUKWwZhiFJJOfPQRTcdXwfeSltBgj+/21NFzAba21qvU1s+DqcOb/
        CrYvBCL4yW/UPxq5eIDkMeE=
X-Google-Smtp-Source: AK7set9cCrlRUBM78Wi3h3xT54xW0qxkEq0kVAA9Q1gNWi2rC2/P5Mq+OrpmsKiLp93UuXNCe6RRJw==
X-Received: by 2002:a05:6a21:9998:b0:bf:d9f0:aa3c with SMTP id ve24-20020a056a21999800b000bfd9f0aa3cmr33323467pzb.16.1676314963368;
        Mon, 13 Feb 2023 11:02:43 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id l16-20020a62be10000000b00580cc63dce8sm8271503pff.77.2023.02.13.11.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 11:02:42 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 1/3] test-ctype: test isascii
References: <06da58d6-6aae-7b1d-6ce6-f07d27f05d97@web.de>
        <21f316ab-714a-58f6-a8d2-466d738b4ed3@web.de>
        <xmqqr0uwdlvh.fsf@gitster.g>
        <70f4042a-df30-26e5-55bd-b349cc02c416@web.de>
        <xmqqttzqcjyj.fsf@gitster.g>
        <93793a00-da6a-81b4-348f-cd7b946bb9eb@web.de>
Date:   Mon, 13 Feb 2023 11:02:42 -0800
In-Reply-To: <93793a00-da6a-81b4-348f-cd7b946bb9eb@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 13 Feb 2023 19:37:15 +0100")
Message-ID: <xmqq3579crsd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

>> Yes, that does make sense but it is orthogonal to what sane_ctype
>> wants to address, I would think.
>
> Currently we can only use one or the other variant because our sane
> versions use the same names as the locale-aware ones.  Full overlap
> instead of orthogonality.

Ah, that is true but slightly complicated.  As long as the caller of
walks the string byte-by-byte and calls ispunct() in each iteration,
I do not think any "locale aware ispunct()" do much good to us.

Once callers are made locale aware, I am not sure they would still
want to call the isfoo() functions that have been know to be very
much byte-oriented.

Thanks.


