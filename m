Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF2BD2023D
	for <e@80x24.org>; Wed,  1 Mar 2017 16:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752864AbdCAQRo (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 11:17:44 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35827 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753190AbdCAQRg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 11:17:36 -0500
Received: by mail-qk0-f173.google.com with SMTP id u188so77885265qkc.2
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 08:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=wD5IM9UzRF5G0mSYWa0MdAdh+kskMZGYl2lunRqPuDI=;
        b=MMgLAJy8XN9fXMVYPzuUeWAmt2C0KKQbW/2w/4HWXAP4/RitW6R7MqidkfCtGcO8hv
         98tfN9xeGRkBf6mC6NhQX1SK4SZmGg3eOD9gblGrI3eJadAvrwO3RJx7aw+Zmx2EXZ7M
         vyGX/VDNr8/JQm7Ae/llM8bCstbbKTbmenARDlMC+teGD2xWizASu7qpw4KWFJnJX3WK
         zjtXqZMHYB/L9XTxqrTcpr/7AXwNMpVIWrB5DhwqZCtXXjvZzrJM9FWnno54X1DXugs7
         bX/9/M/ueBUDXm4Z/6Ni9ECnAmkOyPjV8v064IW8xKK7cYjyKWbaxOpDZp295Us1C+BA
         Y5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=wD5IM9UzRF5G0mSYWa0MdAdh+kskMZGYl2lunRqPuDI=;
        b=tNzIRVxqjSzMkYKvnyEoP3uffzFoCa6tYHB7IRwS4Th8CYDoMpPK8/LBdxE2M9PvE5
         V61GY3lfHT6mIFaZdH4qnt+5N11+btaPVcehOBHoxwFPS2p5NTLEqxWOADMSGDa8gK+r
         BgVbQNLMiBg5HTubY1fnCe/6NlJIXaA3z+FCn4ikxJetMFy+nCVgjZREruzoDJnxRaZU
         sDN7sTcz+yqvxn4UkovVapj7C4rsZz3yaYv4t5ZBJh58AwuQ6voOjmlBkpt9E2Vr5FUn
         QihyD6oQkpRsdHsxYTyFTvYMDxDSzg0BB57wLsnsisIzKlpOITUD7IZXGiX3CZEH3+kR
         cdqQ==
X-Gm-Message-State: AMke39n9Etp378b5qReYPOTWKpvvLbZ8gDPDsXt7Tq1hgkqTSY5lYlm7/iLX1lJcBHf00WuQp6oL46oTG/WPkA==
X-Received: by 10.55.31.170 with SMTP id n42mr11195904qkh.181.1488385055354;
 Wed, 01 Mar 2017 08:17:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.178.20 with HTTP; Wed, 1 Mar 2017 08:17:14 -0800 (PST)
In-Reply-To: <CAPc5daWXafzN0dpyd+kdHcLU_YSmZpiNz_i2rXn_2hbMN-9Xww@mail.gmail.com>
References: <4d2a1852-8c84-2869-78ad-3c863f6dcaf7@gmail.com> <CAPc5daWXafzN0dpyd+kdHcLU_YSmZpiNz_i2rXn_2hbMN-9Xww@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Wed, 1 Mar 2017 08:17:14 -0800
X-Google-Sender-Auth: BOKP09OsipZVzj4sWeI_yuzDwNU
Message-ID: <CAPc5daU0dKXPxOjoM4Er_QxbHgLXqSPDeo_Sxc+d0aBMe837gQ@mail.gmail.com>
Subject: Re: Delta compression not so effective
To:     Marius Storm-Olsen <mstormo@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2017 at 8:06 AM, Junio C Hamano <gitster@pobox.com> wrote:

> Just a hunch. s/F/f/ perhaps?  "-F" does not allow Git to recover from poor

Nah, sorry for the noise. Between -F and -f there shouldn't be any difference.
