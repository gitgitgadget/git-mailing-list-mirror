Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F32E1F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 13:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbcG3N65 (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 09:58:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36483 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbcG3N6z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 09:58:55 -0400
Received: by mail-wm0-f68.google.com with SMTP id x83so19468483wma.3
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 06:58:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=A8OsqFO8ICMG3Muo4D2DrS5RMJYBHogqQkM1l+QsDxQ=;
        b=emB82JMhncsm/9XAlDG7mLa4Ew5Pa+ObeC4U4QpuClfoJQAU7QschZnyA+rsTuuFuB
         16lYHRa2OKmHDpVY6fgNwk0ImrE25pwPUOtkjM/7OU08rb6DCtWiaoVm2iAFewl3VnKf
         NXXFbch5wkr0NOA1Iutfz4TgLkXjefspbfXsuXX87XMIeIEar0v4UdhvMutqh9x2yd70
         XpDPJsyrNhtjGIAiswWYoqlYDvu4z7FaBbQIkGpNbv+cRr72fCRH1rKOXbguQdvtQsSL
         +COCVgI0bIuz5itTcwUufPb+tv1I0ItDxiVzq+odUIAOzN4eT5qvnpuQnxrthJidbVV3
         Lxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=A8OsqFO8ICMG3Muo4D2DrS5RMJYBHogqQkM1l+QsDxQ=;
        b=AzFNXI+dgL6R45VD72MKAYw6NEFylIsJChnh4EQf7vqfUj+5HjL6ot0ONo80cgohOJ
         WmoTMhOReUwrjV+lxbPlDLpgMK1EdvsKatjtFcv2Wnp7sStT3gKE3etQLs8twRTn4T85
         9i0dZgCMUtJiJIgZ2xYds7MHhTTkIkq8UTuWSJ4Sqbyw3eIkArzu6ekUX7nDN5Y62Ojh
         d2IY9Y0mZBMT0+5c7Z6UzYR1zjRjkKzbkg4gKWNbxpAJ1+zJHtoRfymFqMXTZLqPiihW
         zHibTXzaPyN2pHjCF5w9FDcDLhliA5RAq7bgJ35zCUuDbx4qxrqlnCOBS3ObsdmgMW4q
         dR6g==
X-Gm-Message-State: AEkoousrIhmTuyEtfSJcSq3jzobgT9O/ekBQ3Vxj7IM8BnktbtYTsjAw2gFrN3+pxPdBwA==
X-Received: by 10.28.210.5 with SMTP id j5mr51018558wmg.67.1469887134348;
        Sat, 30 Jul 2016 06:58:54 -0700 (PDT)
Received: from [192.168.1.26] (dax57.neoplus.adsl.tpnet.pl. [83.23.23.57])
        by smtp.googlemail.com with ESMTPSA id m62sm7883335wmm.24.2016.07.30.06.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jul 2016 06:58:53 -0700 (PDT)
Subject: Re: [PATCH v3 05/10] pack-protocol: fix maximum pkt-line size
To:	larsxschneider@gmail.com, git@vger.kernel.org
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160729233801.82844-6-larsxschneider@gmail.com>
Cc:	gitster@pobox.com, tboegi@web.de, mlbright@gmail.com, e@80x24.org,
	peff@peff.net
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <cb6721b8-2a6a-deb1-2fc7-59399d118cec@gmail.com>
Date:	Sat, 30 Jul 2016 15:58:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160729233801.82844-6-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 30.07.2016 o 01:37, larsxschneider@gmail.com pisze:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> According to LARGE_PACKET_MAX in pkt-line.h the maximal lenght of a
> pkt-line packet is 65520 bytes. The pkt-line header takes 4 bytes and
> therefore the pkt-line data component must not exceed 65516 bytes.

s/lenght/length/

Is it maximum length of pkt-line packet, or maximum length of data
that can be send in a packet?

With 4 hex digits, maximal length if pkt-line packet (together
with length) is ffff_16, that is 2^16-1 = 65535.  Where does the
number 65520 comes from?

> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  Documentation/technical/protocol-common.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/technical/protocol-common.txt b/Documentation/technical/protocol-common.txt
> index bf30167..ecedb34 100644
> --- a/Documentation/technical/protocol-common.txt
> +++ b/Documentation/technical/protocol-common.txt
> @@ -67,9 +67,9 @@ with non-binary data the same whether or not they contain the trailing
>  LF (stripping the LF if present, and not complaining when it is
>  missing).
>  
> -The maximum length of a pkt-line's data component is 65520 bytes.
> -Implementations MUST NOT send pkt-line whose length exceeds 65524
> -(65520 bytes of payload + 4 bytes of length data).
> +The maximum length of a pkt-line's data component is 65516 bytes.
> +Implementations MUST NOT send pkt-line whose length exceeds 65520
> +(65516 bytes of payload + 4 bytes of length data).
>  
>  Implementations SHOULD NOT send an empty pkt-line ("0004").
>  
> 

