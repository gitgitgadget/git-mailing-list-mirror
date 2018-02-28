Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AE5F1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 17:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933984AbeB1R7q (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 12:59:46 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38483 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933693AbeB1R7m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 12:59:42 -0500
Received: by mail-wr0-f195.google.com with SMTP id n7so3372610wrn.5
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 09:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sXgiNL+wCM+JTlGaQFXKdBaF7JLHggB+p0rCFrGG/K4=;
        b=OqbIpVEK+s6bhGmh95urTjMWMFyHpTVXS/C7kbNPy5WHG7nxMWRKSse4vdggeZlEuJ
         RfmKHIS2FkymGXK/6Ya2uCxhofHRbMHVELL+b0ZVk4QqSjAWzBIQpkmqSZ5MGPsfntmg
         HkdM1TpTrxf8CuQHQ2QdTYgeOE3nqY7hHxVQ7CD7PMHwkwpdxaAQs58Z/jX+7c4feap6
         eFjMaFAo4TPwGz9EEe/6nVRG6wM7+9KstEKBG5dGdvTfEpqXXPFNJna14PRhcuWUeJ0Z
         CpXchUxpao59UI9H5wDdgpv0cvB4Ex9IVF2Ck2vVvNGFuo3jMHaXS0n1ODpFhaUB/apb
         blCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sXgiNL+wCM+JTlGaQFXKdBaF7JLHggB+p0rCFrGG/K4=;
        b=KWUAKz6THh7r12awgndjFD97D6aQTYaZQRtvUke0iwdhUAWUxrPX4nHrd5jZqG89NR
         Z6fUn2a0lPifFkKoOB5rPQAxMBejEkJNGZtlgnKs0qQU41KKJNXPR4kWLWCYNY3FJWLY
         RYZ488a6wcpgYpLyI+ueRkNsehn+1PWSdiw4vkrJXmshFzFcjO37+cZ0cuet4Reqi9yt
         yqpitRsHjIkxlY/iNSr+U/58xyFQZdFdBMcHmKlQpMjTheyxwK0EGN5Oy2tnfwea16mX
         Xh8GJ34UctAApyVLL2Gpfx3YTCYESYpCHcAsa6BlS440dPe/6X7l8DE2f2zo8qRFt+Dp
         KZZQ==
X-Gm-Message-State: APf1xPB9uHyHUjYcPOijPNxHJ+zVrcA+2oBYGPYMHPMtzg8EPagbjLeQ
        Mlvu9X4pswEa9AvomcI1pFE=
X-Google-Smtp-Source: AH8x226ZJ9DQkZTp9I8IVPRi0YPBqxmAc67uDvAiienZehs23YkSBV8HsMmlSVyz5DxRiENMB0TWbQ==
X-Received: by 10.223.184.88 with SMTP id u24mr16026823wrf.3.1519840781525;
        Wed, 28 Feb 2018 09:59:41 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x17sm2432728wrg.32.2018.02.28.09.59.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 09:59:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/11] Moving global state into the repository object (part 2)
References: <20180228010608.215505-1-sbeller@google.com>
        <20180228021530.GA20625@duynguyen.dek-tpc.internal>
Date:   Wed, 28 Feb 2018 09:59:40 -0800
In-Reply-To: <20180228021530.GA20625@duynguyen.dek-tpc.internal> (Duy Nguyen's
        message of "Wed, 28 Feb 2018 09:15:30 +0700")
Message-ID: <xmqqy3jdknar.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Looking at the full-series diff though, it makes me wonder if we
> should keep prepare_packed_git() private (i.e. how we initialize the
> object store, packfile included, is a private matter). How about
> something like this on top?

Yup, that looks cleaner.
