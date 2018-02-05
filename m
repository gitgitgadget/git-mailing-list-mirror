Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E38121F404
	for <e@80x24.org>; Mon,  5 Feb 2018 20:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbeBEUB3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 15:01:29 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32956 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbeBEUB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 15:01:28 -0500
Received: by mail-wr0-f193.google.com with SMTP id s5so30941932wra.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 12:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4n/gQ2N6PuNIaK/tXoQWdQTKDqKctJO/xvRYOvl1p3c=;
        b=rIaZtPO4eD0ReYOAcEET12bJm3KrUGH4u+qwX+MiyTwSdt7L2beKY+g9bvC0PlkqUv
         mGHd+JnB7fQ1cu5FPAzzvv2+L6X9nacUrDj9wkq59ypYu9boIspWGb/aJiAec+WhhE6v
         BKG+GLyqJe40GkUmEUyy4qgONGhOmBYwJ+3teh47TjX/D+oMPFoAgISxZXK/HCPLZ2yu
         1bSIiB2M1/h+R2z1zyUhf0wIH/Wln+y+23XQ3qghA6pUJNTURJXDRLARWmPxVLK4RToT
         rMR32Bk7eumW0AXyXORA++BHwnQy2r2kKCoOW5GBNwuSwSA0yO1Z2LGMiN1oHnAQAgOq
         +pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4n/gQ2N6PuNIaK/tXoQWdQTKDqKctJO/xvRYOvl1p3c=;
        b=B0GL+aovI3YFbvCWWMQ7o7XoZRWF1m53MJK3XFUJ9/O5IeQiR5gF7jqgslh3LE8zGe
         VfUelGm1hGXQ31rcXXDm38FpotH+CthF+ywl/4J1/5XNhcE3KwZaqZGZvovHnAejk3Jb
         xUkuDPa6TGQgRJhBaAlMG+YIgS5VX0kReNVrZL5n0OeYVBH3LNN9otE1QCUVEdv9CT5l
         vWSfseKXfYdXEcQUmd1a6tkTYPVnQGcYRDD2UBNC0rR3aYDHmMUigS1r7mH0Je3xYTik
         PgZpKmCESiuT2Ft2zxfgXdcnfzggahr9D8tJ6TCYmfhty9uiJwyLAD2vD3Tjp9HFdWAk
         Ysbg==
X-Gm-Message-State: APf1xPB6ec/FKcKfCs5/RMHC3TBXR/ddOs16OYp0hWLhssqZ3RU6zd9y
        M+JWJSScqlYZiRIGc8oIxOo=
X-Google-Smtp-Source: AH8x227q8RnKMqckiiBoNU/qcQYUyFfKgV4Sl22+w5Tmc0byqVM9vC15XsGESSg/HyXLHpwbndvA/w==
X-Received: by 10.223.196.154 with SMTP id m26mr3081wrf.56.1517860886345;
        Mon, 05 Feb 2018 12:01:26 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 198sm14262807wmo.36.2018.02.05.12.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 12:01:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 17/31] merge-recursive: add a new hashmap for storing directory renames
References: <20180130232533.25846-1-newren@gmail.com>
        <20180130232533.25846-18-newren@gmail.com>
        <CAGZ79kYcmq9JyD4smH1Vdm5YOFXRXjhYhhHYjNV=Z7mxz2UVGw@mail.gmail.com>
        <CABPp-BGc0F5023yY1wRb3Gy+oXdbHAibkHYr35+zE=OnT2bQmQ@mail.gmail.com>
        <911da66d-d6f3-2366-b2ae-4741ec9ff6d6@kdbg.org>
Date:   Mon, 05 Feb 2018 12:01:24 -0800
In-Reply-To: <911da66d-d6f3-2366-b2ae-4741ec9ff6d6@kdbg.org> (Johannes Sixt's
        message of "Sun, 4 Feb 2018 09:54:38 +0100")
Message-ID: <xmqqpo5j9pez.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 03.02.2018 um 22:34 schrieb Elijah Newren:
>>  If anyone can find an
>> example of a real world open source repository (linux, webkit, git,
>> etc.) with a merge where n is greater than about 10, I'll be
>> surprised.
>
> git rev-list --parents --merges master |
>  grep " .* .* .* .* .* .* .* .* .* .* "

Twinkle twinkle little stars? ;-)

rev-list can take --min-parents=10 option for a thing like this.  In
fact, --merges is implemented in terms of that option.

