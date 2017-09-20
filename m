Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0736320A28
	for <e@80x24.org>; Wed, 20 Sep 2017 17:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbdITRbj (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 13:31:39 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:47050 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbdITRbi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 13:31:38 -0400
Received: by mail-pg0-f44.google.com with SMTP id i130so2062129pgc.3
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 10:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DQ93ir3piaa1jCiVLXHu6Fg+VP5bJMluWdtGMrtghV8=;
        b=cuywLlCIAjdsdR8p1NVvW59WFj5jojX2dF98wEYVoXqitrAz7r5lzEPKEOdZDyNxLY
         kZXj3xraJLBu2tmbDk1Pvry9JEGO7XE5D57KhwEJP1OIwJjmOdE11UDz9ZPJIwi3KjJd
         UeJgLZEzbI3e3iXtY+23UPgoyyJBzBuxJBh5uw/Pns+GnjR0jQtPFk10Fmf3QMEOWm6t
         Ydwh4q7t4hEgiQu5NXQ2et7eQ673RbrOMP54Iv0CJDlVCoLFKNqjBFTKJGjniOxq8O4z
         1ERZsQeEoQK28trUDhMUwC4Uh2ZY0byT1Ta7b3/IzPCWN2rShHAuZyLzFC+82ZWiDG3c
         SoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DQ93ir3piaa1jCiVLXHu6Fg+VP5bJMluWdtGMrtghV8=;
        b=eqmiTk1P3VzPgeIVq7cN7rtIfZVPHDNjpEbWEYTRAnu1Xl69MVfZGiPw/X1WkGfQaA
         TDSpfuAD8jz5D0dtpMebO3h/GwpsxiXpp6Q59QgeyQyCnSBdJ435QAVdPonskcdkgdav
         OUFjHaCxgOM0l5llgBwKknR5fHMGyzMbcV/9F+8sfjonv5Z9Y9vhqa0g9cXw4oW/FVpR
         e833nEK6J86MrznsaGYjENwQFUKhYUEmRfdSm145xMwZQxXnmZCYl5jV81j587bcgh6q
         LYWti4FniPd8yz2ahINTRFFsn8Wz5Q/QwyhdHR28m16SIRjayV7yHqo/Pv+7khz37aON
         JbRA==
X-Gm-Message-State: AHPjjUgZCa5t2oXLTpffCWPhLCJEnLP3Wrt95eOoFn6uUb1ZlXzSdojv
        hmbj8VXq0kakf+sKT1z8WaVF0DMV
X-Google-Smtp-Source: AOwi7QBlLhSy6ZplXdVK1hXTj5q1hC84O7G+bX+J9bQGJiuDwWL+zKQRJytFT0XTXDrM8sa6IXjENA==
X-Received: by 10.84.176.65 with SMTP id u59mr2835902plb.278.1505928698046;
        Wed, 20 Sep 2017 10:31:38 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:da9:ac38:cdcf:de91])
        by smtp.gmail.com with ESMTPSA id r90sm9537384pfb.183.2017.09.20.10.31.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 20 Sep 2017 10:31:36 -0700 (PDT)
Date:   Wed, 20 Sep 2017 10:31:34 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] for_each_string_list_item: avoid undefined behavior
 for empty list
Message-ID: <20170920173134.GZ27425@aiede.mtv.corp.google.com>
References: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
 <20170915184323.GU27425@aiede.mtv.corp.google.com>
 <b8951886-feab-a87a-9683-3c155cfa98a8@alum.mit.edu>
 <b03c7b09-853f-a2ed-f73e-7d946c90cedb@gmail.com>
 <20170920023008.GB126984@aiede.mtv.corp.google.com>
 <xmqqd16mowig.fsf@gitster.mtv.corp.google.com>
 <20170920052705.GC126984@aiede.mtv.corp.google.com>
 <87vakd2v22.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vakd2v22.fsf@linux-m68k.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab wrote:
> On Sep 19 2017, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> B. #define for_each_string_list_item(item, list) \
>> 	if (list->items) \
>> 		for (item = ...; ...; ... )
>>
>>    This breaks a caller like
>> 	if (foo)
>> 		for_each_string_list_item(item, list)
>> 			...
>> 	else
>> 		...
>>
>>    making it a non-starter.
>
> That can be fixed with a dangling else.

I believe the fix you're referring to is option C, from the same email
you are replying to.  If not, please correct me.

Thanks,
Jonathan
