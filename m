Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D314E1F855
	for <e@80x24.org>; Mon,  1 Aug 2016 12:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388AbcHAMXd (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 08:23:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34328 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306AbcHAMXb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2016 08:23:31 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so25956496wma.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2016 05:23:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=exG3Y6MY7qC69EFwzmKk/uKvbdGiyv/ggWIW8hxMXMM=;
        b=nKlKYACfCcHC2c6iLSeMXGSRXoNdpsSvYYSTfF6y1LSJI6bm2PMHJpzfa/Yyhi43a/
         KbrVvXm4bXqVTNmZBNzrpC1hXfOQ1rqpMOOxcGxet7H8j7jIqSfV7Djur829adSmwJhY
         l3AFIlAjtIXrO+7w5wY/JHENsk4WTek/TJFtmuzF6vNI9gx4/5h+zl3DGtj27NUBFvfL
         XI2aId/OM4Fj/0SYYXQKlQoq6eol2Ps6TTX/fHv8Hb9bmF6ObPz5aU69UCHss+aFThsd
         FLS0ng/ipUIwB0pxjjEdPaLDhKxCye7SHuaKRa4XKxnERgYF5p35Iq/4vsyCD//STqGc
         CXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=exG3Y6MY7qC69EFwzmKk/uKvbdGiyv/ggWIW8hxMXMM=;
        b=mIFss16C/NuHH/wJceolB/fPhj6ga+po/k+JESEq2T3fTQ6qlL+MNtJ3vAGrTByOJM
         RoLQutWWBT9hIywLNZ5EVTaPZiUqj1Xj/9+JJj5eBGuGIt6uWADCq4fB4ezWc9+d8U08
         qjZ4UeH61f92G7K7dmqpIzFXHqIStugEhOXKpvHxWZg95qE6vNhfKUjzbKudgwGXuXRy
         Lp6Osui18EQ804h8oIt87K7lkiOdE+rKIhoN+x9pRWhLKZPTG1aFFXWrzAc32TDHaAhz
         8geJ/jbMp628LMgiHpYx9Qa/e9iT6TqBWx6pXPLgjP7rWopHowcB2m6iFG4owG5lrFH1
         ewvg==
X-Gm-Message-State: AEkoouv56vrYVw00FSHmQN1QMCLiGkzY3Fvo0bbTsaBnzdFDL3Ykr39DVbOac/MEvXWVOw==
X-Received: by 10.28.109.214 with SMTP id b83mr55433853wmi.19.1470054202514;
        Mon, 01 Aug 2016 05:23:22 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id e65sm16912855wmg.3.2016.08.01.05.23.20
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Aug 2016 05:23:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 05/10] pack-protocol: fix maximum pkt-line size
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <cb6721b8-2a6a-deb1-2fc7-59399d118cec@gmail.com>
Date:	Mon, 1 Aug 2016 14:23:19 +0200
Cc:	git@vger.kernel.org, gitster@pobox.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net
Content-Transfer-Encoding: 8BIT
Message-Id: <B8F75E2C-2E85-4E91-B51F-90C3BF238072@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/> <20160729233801.82844-1-larsxschneider@gmail.com> <20160729233801.82844-6-larsxschneider@gmail.com> <cb6721b8-2a6a-deb1-2fc7-59399d118cec@gmail.com>
To:	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 30 Jul 2016, at 15:58, Jakub Narębski <jnareb@gmail.com> wrote:
> 
> W dniu 30.07.2016 o 01:37, larsxschneider@gmail.com pisze:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> According to LARGE_PACKET_MAX in pkt-line.h the maximal lenght of a
>> pkt-line packet is 65520 bytes. The pkt-line header takes 4 bytes and
>> therefore the pkt-line data component must not exceed 65516 bytes.
> 
> s/lenght/length/

Thanks!


> Is it maximum length of pkt-line packet, or maximum length of data
> that can be send in a packet?

65520 is the maximum length of a pkt-line.


> With 4 hex digits, maximal length if pkt-line packet (together
> with length) is ffff_16, that is 2^16-1 = 65535.  Where does the
> number 65520 comes from?

Historic reasons, I guess? However, it won't be changed. See response
from Peff here:
http://public-inbox.org/git/20160726134257.GB19277%40sigill.intra.peff.net/


> 
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> Documentation/technical/protocol-common.txt | 6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/Documentation/technical/protocol-common.txt b/Documentation/technical/protocol-common.txt
>> index bf30167..ecedb34 100644
>> --- a/Documentation/technical/protocol-common.txt
>> +++ b/Documentation/technical/protocol-common.txt
>> @@ -67,9 +67,9 @@ with non-binary data the same whether or not they contain the trailing
>> LF (stripping the LF if present, and not complaining when it is
>> missing).
>> 
>> -The maximum length of a pkt-line's data component is 65520 bytes.
>> -Implementations MUST NOT send pkt-line whose length exceeds 65524
>> -(65520 bytes of payload + 4 bytes of length data).
>> +The maximum length of a pkt-line's data component is 65516 bytes.
>> +Implementations MUST NOT send pkt-line whose length exceeds 65520
>> +(65516 bytes of payload + 4 bytes of length data).
>> 
>> Implementations SHOULD NOT send an empty pkt-line ("0004").
>> 
>> 
> 

