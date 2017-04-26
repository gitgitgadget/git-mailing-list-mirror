Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAED1207E4
	for <e@80x24.org>; Wed, 26 Apr 2017 03:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1434802AbdDZDpm (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 23:45:42 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33671 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1433167AbdDZDpj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 23:45:39 -0400
Received: by mail-pf0-f171.google.com with SMTP id a188so35597770pfa.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 20:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=FK8/2Cg5M6hEYhu9O2jX0fIn73fFhyo6FdB+Bb7IHvU=;
        b=csaqc6FTiOUTSuNH2VUa/O8ErqX8KYrA2YiOKeudOsCAxL79v3bTaHfHObuLT6+ruL
         bhOZxirmircEBsnU2vgTLaAoGqHqdDLj8cIsyqerwtqSlcmB1GP0OerM4R+Dy0D6oflB
         Je0x91ikJkZBYp3gvs4FcPG2Px/CjSOiTPNc42u/IbrMKmYC8yxAomyKS4ktzoc3YSg8
         7HIE3ZoCaPlrdmWZ8Y0+UKExKeEySStnADhxQLJcirvXcS8lUruSZaFxcIoJewek/Tlx
         h8d9jCTdEpA4nC44vAFtN5+zI/0FX8gsZjt4gecyroZaeQLgxd9iy+DH5qUwvMkf3R3t
         Ix1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=FK8/2Cg5M6hEYhu9O2jX0fIn73fFhyo6FdB+Bb7IHvU=;
        b=bF3fO99ZoZLNCoLuNvue4coNpyJ8k6KYbAXvCEtWqip1OXlj9DXcZjMelgcDtn4JeA
         60lLH3cdM/kbnd8MU4/vySdgDKIyYhd0Sf31u1+ADT01bqbiHQc1gOKGrYAHrbpD1CZZ
         3pDTvINCzC0P2a5I2kSQx4+K4SVQ7hH9DMW8koraYjsLVJ+ZJ1Dk9TpztE3/6Q7DKd74
         +geyid57WAug/342Cq+7lB9pGS2d7LyPPEefh6ASFUl5Q/ePmCxu37fvVHCy1Io05GxZ
         B8mGyaDr/rSZVjaY+cs67KbMhqo+aVvhd4Z5cA3CpC2a4Ez+V62VPKERIX9YvpqdlcdS
         Taow==
X-Gm-Message-State: AN3rC/5NmdaEyVnvuFRbVvovpkxhJ5P3BHBM2R1ERdait1WREJl+BbhG
        D7x2ibRskDCqLA==
X-Received: by 10.98.29.86 with SMTP id d83mr31208544pfd.68.1493178339203;
        Tue, 25 Apr 2017 20:45:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3179:d004:20b:b383])
        by smtp.gmail.com with ESMTPSA id y78sm38875914pff.107.2017.04.25.20.45.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 20:45:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 8/9] Use uintmax_t for timestamps
References: <cover.1492721487.git.johannes.schindelin@gmx.de>
        <cover.1492771484.git.johannes.schindelin@gmx.de>
        <b59a414793492786937e910f6cd588b8e1751b4b.1492771484.git.johannes.schindelin@gmx.de>
        <xmqqinlu1o8u.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1704241226440.3480@virtualbox>
        <xmqqr30hw31s.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1704252208520.3480@virtualbox>
        <xmqqvapsszoo.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 25 Apr 2017 20:45:37 -0700
In-Reply-To: <xmqqvapsszoo.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 25 Apr 2017 18:52:23 -0700")
Message-ID: <xmqqtw5bsufy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> In any case, it is a question unrelated to the work I performed in this
>> patch series: the raison d'être of these patches is to allow timestamps to
>> refer to dates that are currently insanely far in the future.
>
> Yes, but the job of the maintainer is to prevent narrow-focused
> individual contributors from throwing us into a hole we cannot dig
> out of by closing the door for plausible future enhancements.

Having said that, IIRC, this series does not tighten the existing
code to specifically check for integer wrap-around anyway, so in a
sense, users who use a timestamp that is in an insanely distant
future is already accepting the risk of getting broken in the
future, so my answer to the question I asked is "it would be extra
nice to future-proof people's data, but not doing anything is
probably OK---at least we is not making things worse."

