Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6199B20986
	for <e@80x24.org>; Fri,  7 Oct 2016 15:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753050AbcJGP4Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 11:56:16 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36672 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753182AbcJGP4P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 11:56:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id 123so3576326wmb.3
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 08:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=OvyCsMCdfIBkeKekoeqKPO4u2JhnelGjsesj9YNS8Zk=;
        b=DNMU6eVE/X3EQJjPKKVqSIgc3lUbvKhfVgUjUG2dmj/jkCmOUNMfxUcdbtIDT6CLfG
         Q6iuFK6C7muJlhl0+2wmh4N7TmLTLk+kCiJOrEnRGZD/7ltCSBGIzTBFYk9A1t5Iuvat
         4QXJhGv/oOqhcEFJUYjBvR34L2mUIEF0+AhSp58psvhpLDuAJggPIWup92uct3i5A9mi
         u386yrzoPxCSkY+OamzXcWx3ApfAK8cjtf1rGs+8CO/qMYh6BarPG2jIWt7aTdq0K4Eu
         Qin92jlgsNNU7Q0R/Ni2E6FafCcFbJt1OE2o2T6HR7/IsMqZP7mSek3qIOqVdjAPDro7
         6m9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=OvyCsMCdfIBkeKekoeqKPO4u2JhnelGjsesj9YNS8Zk=;
        b=COGY93pZyXlYWO99Tq3+nEBO/j1UUjr0SI3K9qqwSH/VlfQLfeo2f4jlmZf0LCo9ZF
         bryo8tr0c1YprVI+lWV4ZmtHZO0f1OFbDz+ObYBA7goUYYGnN6h4SgAgdyaxNg3+R0k/
         mYVYqcrdVibulBffbzKCATulZtZSmwelbfOgp+J67KRAmpauJI2u042Td4lLK6XL87/V
         vaFbdQIx6er2aXAmeQkmGmv+Kjl787trtacv5mPPiAsvIcKmePBtjgye4hyxU7trw+LT
         MFqniIs8prRxRafF0vAf0kqZtQSkVmmt/NbXY/X9bmXqG54vC9ybpdn/TlHJvQ90SvFS
         B7CQ==
X-Gm-Message-State: AA6/9RlITW1327lt4Um1LHJZjoZcCrDzA60WoBvlANpHYeK0dVM1eXW+/eQsGhQilQ/L3Q==
X-Received: by 10.28.52.2 with SMTP id b2mr20453396wma.72.1475855744373;
        Fri, 07 Oct 2016 08:55:44 -0700 (PDT)
Received: from [192.168.1.26] (afc148.neoplus.adsl.tpnet.pl. [83.25.132.148])
        by smtp.googlemail.com with ESMTPSA id p13sm3647054wmd.1.2016.10.07.08.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Oct 2016 08:55:43 -0700 (PDT)
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20161006114124.4966-1-pclouds@gmail.com>
 <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610071319520.35196@virtualbox>
 <e1b432bc-97b4-15be-aa44-71921c64cd15@gmail.com>
 <alpine.DEB.2.20.1610071616390.35196@virtualbox>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <f41a1371-7771-1960-27e0-cba0ee5b1461@gmail.com>
Date:   Fri, 7 Oct 2016 17:55:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1610071616390.35196@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 07.10.2016 o 16:19, Johannes Schindelin pisze: 
> On Fri, 7 Oct 2016, Jakub Narębski wrote:

>> Note that we would have to teach git completion about new syntax;
>> or new configuration variable if we go that route.
> 
> Why would we? Git's completion does not expand aliases, it only completes
> the aliases' names, not their values.

Because Git completion finds out which _options_ and _arguments_
to complete for an alias based on its expansion.

Yes, this is nice bit of trickery...
-- 
Jakub Narębski

