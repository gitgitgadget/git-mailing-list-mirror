Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6677ECAAA1
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 21:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiIBV3P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 17:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiIBV3M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 17:29:12 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A20DE926B
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 14:29:12 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y29so3156157pfq.0
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 14:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=d9q6jKlgjXwgXwG1kpu7uPRiywipf2VkfuINgBON850=;
        b=Lovha6sEN6jHwUEnIbBnZZUAwM3EQwD9o+GMs4VZmsDnYKzM0NbzBz9IrrAvgzApML
         o+iy1TTgh50oyxG6k7CEPLfefBaRN2hDZG3TXPxOKJIM62z1dreZj6pWZzrkDeWn1ERx
         VeOp0TCvcgw4NztShxkD8MmRKWICIAO0H5yeA4TmSH/CrqVSsBlm7sPkcPd7enmzeBtR
         d4x2//SnSofx4oUDhbvK0QR+nizE3UK4uO34BBklYJ6W1ePaeFG0hUI+A/BRK7Sek8Nf
         GG+QJGHjS2ty6FD0ecQeJ++sMNPduCgznNV14cOFwp08hJ+/bJkBUFsCsXTru/zzk77S
         ZJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=d9q6jKlgjXwgXwG1kpu7uPRiywipf2VkfuINgBON850=;
        b=QEgoKCis374SFRRLGEk+/s4BHVZ+6sDx6w6WjdQjdz6L68o6h2RjLUQI7tLBDVYCeq
         gIvFGW0FasulyhsFDH54sf5bWbwiU1WGm2tY83DqpR0h/tBRef2/DvusaipBR9DMkB3K
         cMyq/p2Z/arYHS/tMU63wZLylNx1gg7DEQ1NJWBwEXjro7LD+e/ztObkM9GNBdCJyNuM
         FZjp3NalKm+iurk2cfjWLqFaGLk40uRy4QxDGVg/kZktk0KPiUlDjkdy+VCB5i0uX4tF
         RJWpUbQfiLV3vbBbO8A5dx+BqGhmAH0WEtxyWtVQWeViCCbaeqjlvVjK1BecXeOiLp/w
         boDQ==
X-Gm-Message-State: ACgBeo0htR1UUHvwgl4g3QOymhelQbR2UpvLkamqs7g7vkZzAISVUUId
        ruRgqKsKTiSxsCsOSGW8f8cixAxC+HY=
X-Google-Smtp-Source: AA6agR66xzb+dDgrdmzCzFt2gMpd49lEq23661JuBqZx0xYjde5uTBMIcXV/YN5WJRxgctN5B66Q+w==
X-Received: by 2002:a63:24c:0:b0:430:7ec9:c6d3 with SMTP id 73-20020a63024c000000b004307ec9c6d3mr8040643pgc.334.1662154151888;
        Fri, 02 Sep 2022 14:29:11 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a19-20020a63cd53000000b0042a3d9a1275sm1892725pgj.16.2022.09.02.14.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 14:29:11 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        git@vger.kernel.org, ingy@ingy.net
Subject: Re: [PATCH] rev-parse --parseopt: detect missing opt-spec
References: <xmqq5yi5aghf.fsf@gitster.g>
        <20220902175902.22346-1-oystwa@gmail.com>
        <20220902210025.GA1839@szeder.dev>
Date:   Fri, 02 Sep 2022 14:29:11 -0700
In-Reply-To: <20220902210025.GA1839@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Fri, 2 Sep 2022 23:00:25 +0200")
Message-ID: <xmqqedwt79eg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> NO_OPENSSL=1 NO_PERL_MAKEMAKER=1 sometimes helps building older
> versions on modern setups, and, FWIW, Ubuntu 16.04 can build both
> today's Git and v1.6.0 (my goto version when I want to check
> historical behavior) even with OPENSSL.

Thanks for a good piece of advice.
