Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E13AF1F453
	for <e@80x24.org>; Fri, 15 Feb 2019 18:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbfBOSHN (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 13:07:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36547 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfBOSHN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 13:07:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id o17so11304206wrw.3
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 10:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wuvuT1LtHjAZEYd4if0t/Vy0yvgaqogrpSg2vnSzJDg=;
        b=fCf+fxINFjVx0joweFQrfJ9AZta7GsxMBASwZ2Q0H/lNua9HFirofHlynO00C2uaKT
         pFkY7hRSX+qifrsid1dWH4cPhq/kEKIpdzGAjzBVGbhI3VnMdLx+6OxU2KgUlEB+xaaC
         d1ZHZY/u+XLF85evVJ2tI03ttySexlBfAa6DZZfhE4Uv/STeobk0Zb1alkfsm3k85S9p
         DpRYkzMR/koycrkHrCdTvXATRsvnvvHf2roFXfu1CwdZtL2l7zSn8risLVu1HSkPHoY1
         RChh8W6+sDe5Mt/Wn03Zepqm082RKCaDNuZCsvM99tXTzsOW2+LcZBUSenIjaVbQaiea
         MT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wuvuT1LtHjAZEYd4if0t/Vy0yvgaqogrpSg2vnSzJDg=;
        b=oWKCSLEzDy6ixaShoNkPyjDSgA0OJQLjshGaQs5lf52c89KDyDjnqdK5auj7g5EJYQ
         x7qo8I6EyV8N1jAyteJnGt2JzuWD5nF/IVroU7go5aSfAIGpjxT8hwlEDRSME+rurCJH
         ZLfvFX54QZNtMCDA119aReU1SBAvTYfmz91dg5xyV8DLZ/ZKSfOhAsAhnCfXqPQU0Cf/
         IXMmhydvBF1p/V+6kHufbyFcFfLoc6FsyGGL2Xf6LooRuALsfLJWxVjzOL1ORrRI0Iav
         vdjuSJahXq96Su2stz4BP+so+UbuSSqvwFCCyiFVvBsT6PEyFr+V4ivfIHRlch7BHFHc
         1iaA==
X-Gm-Message-State: AHQUAuaYRsGDCYq2ZXdSUTw0DyKwCruJPA/Pi5WuLxeSlLqoQ9v1jGdk
        uKMt495viGhBXLxZHBoTbiA=
X-Google-Smtp-Source: AHgI3IaZZaiuBchVc/0Qc0oMnZD+RXUh0k2997ydW+zeFs2tgAknWuep0aNcHBaFa+9PSOV1PvsOeQ==
X-Received: by 2002:adf:dd12:: with SMTP id a18mr7302813wrm.4.1550253637806;
        Fri, 15 Feb 2019 10:00:37 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i10sm12685034wrx.54.2019.02.15.10.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 10:00:36 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Max Kirillov'" <max@max630.net>, <git@vger.kernel.org>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t5562: do not depend on /dev/zero
References: <20190209185930.5256-4-randall.s.becker@rogers.com>
        <20190215164237.12250-1-max@max630.net>
        <001601d4c551$d0f24c30$72d6e490$@nexbridge.com>
Date:   Fri, 15 Feb 2019 10:00:36 -0800
In-Reply-To: <001601d4c551$d0f24c30$72d6e490$@nexbridge.com> (Randall
        S. Becker's message of "Fri, 15 Feb 2019 12:13:42 -0500")
Message-ID: <xmqqsgwp53uj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> FTR, this particular subtest is not the one that is hanging. This subtest
> passes on NonStop with any and all (now) 4 solutions that have been floating
> around.

One thing I'd like to know more is if this test passes on NonStop
with this patch, i.e. /dev/zero replaced with /dev/null.

Thanks.
