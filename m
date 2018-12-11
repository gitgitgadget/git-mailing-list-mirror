Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0913220A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 12:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbeLKMuy (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 07:50:54 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:53644 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbeLKMux (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 07:50:53 -0500
Received: by mail-wm1-f51.google.com with SMTP id y1so2073420wmi.3
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 04:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2NwMfFuZbZqHcUkGNWzgLrCDLer++2ocYYW7vVvELRY=;
        b=nVshVHpzaGRvZoXDro1xPfom9ZR5XrcManOLJvXYRtfMS5EUgWXVkiRCLGFwkWA90T
         NT9OLupMYo1Tf3dIx/AqjanlqDHNuwPebiKsB4vpQfbsrWopH2iGc79iF/HZiXESRgsb
         xSvHsWCFrMjwRfYdyyUhsmnZuRhL/4jd9DoIqq2vdtPwB/sm1TA4bAozBxNVE3nrDxcP
         f6qmNylAApzfyntaUBTaUiM8Da33oIdQD/Fk+5DQhvfn2kTCmWPk5y1SRZQMrbiVr/+v
         XTkuGXzoYS7CLspsW8G+iVhto0sDIbHO3t2L3/LlIKUM0+eYLATOxYoxqMFTJbioS47+
         KrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2NwMfFuZbZqHcUkGNWzgLrCDLer++2ocYYW7vVvELRY=;
        b=LXiwChElBEvPFkUcFgsZkFjuFzoRej4ff2iMrCINYJJZwEOz87/Jt9aygauvZ+hR0P
         Pwm1Ra2FVNh4cLYrLTYMasWJorU5VOi2J6JETt30kIrcaIEZjZfv14XsHHt2sLhxXTmm
         LtXdYwuNH3GQ/lwOB3yCGQCXsPkKAlI2u83IHkeZ6KLGTL+Mg9oxA8AEHvebGdi9LjGL
         3MG9l6szoheTEDvtI/55laCk8oGKEbErbi475JUWRhd29PRqlmE/jgPnDvpzcM7GWfmn
         Ycawgyp98FduLbEPduVZJoNNV/Z108BVyzhEikwkbJRfzkRo1HfsNqXxHLbRu7MrkWAq
         rceQ==
X-Gm-Message-State: AA+aEWZsaLSglszetuWmRrU9wKNREMT954LhJ5BfohJnw5YZDI25dmfi
        cS1iwzmNZDAz5NozNJGNIJ3plo8yPa8=
X-Google-Smtp-Source: AFSGD/WsN5e5/1o6aROgZZmhttEwsC+Uv5GXBxjdBvJ+/eYCBW4vCUU8Rhp4SqoHq7gYHIHBQnyelA==
X-Received: by 2002:a1c:5506:: with SMTP id j6mr2379472wmb.44.1544532651587;
        Tue, 11 Dec 2018 04:50:51 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f192sm1777534wmd.12.2018.12.11.04.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 04:50:50 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        John Passaro <john.a.passaro@gmail.com>
Subject: Re: [PATCH] run-command: report exec failure
References: <xmqqd0q8liow.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1812111327460.43@tvgsbejvaqbjf.bet>
Date:   Tue, 11 Dec 2018 21:50:50 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1812111327460.43@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 11 Dec 2018 13:31:01 +0100 (STD)")
Message-ID: <xmqqsgz4jkgl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This breaks on Windows (on Windows, the error message says "cannot spawn", see

Thanks for a quick feedback.  Let's update to look for the pathname
of the command, as Peff suggested earlier.
