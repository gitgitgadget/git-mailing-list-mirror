Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 572962047F
	for <e@80x24.org>; Tue, 19 Sep 2017 14:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbdISOiO (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 10:38:14 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:54924 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdISOiN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 10:38:13 -0400
Received: by mail-pf0-f175.google.com with SMTP id d187so75396pfg.11
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+aiIg5YRJfvNPyA0jtIM6fJ1fVGXpeUD8KoP5SPLAoo=;
        b=NklUKw7FmV1izkdoXiQiimRJz+Cj0TZdzyZTio7Wsrp3a1P6EFM//9yL5aNXMmbjRv
         znigsHaUQ2dOSOO/cet54VmkT6HuNjzw9jPS2EO+UbFjK/eV2EOFy0zuPwMMkT8O4XIm
         YRHWHphJFs+0ijhBWyOaUpFfSgm80IA4vZ+aQF5dCtHCUfiQzpQFsbXQjbVNESZ0BJjk
         482wsYR7tkX0uFqihJoe7/4X9BTOjm0AHYr9d6nYl7omNt4Zti1NfrN5OSrisUK59reG
         DoZCOWFKLpnaU2hUGfxi2bLlo/1yECWFhhHI9uOucf1S47bUSdCDT06Jp7dp2liL0Vs6
         Dy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+aiIg5YRJfvNPyA0jtIM6fJ1fVGXpeUD8KoP5SPLAoo=;
        b=SaVGRntWISGQ7rxi00w9FGV3HjCSqh975F+W+AXq05bSEzHXYTGx9uHEY5JoBlMhNg
         0MAl8CjFIi8DsosCXff+ZQnRFL2qSXq2tu8epVMiQ/8fP8l+8u1qaO+8j1JURuRP/szY
         sfnouLQRH1yN4yBf1yCrUOYjDvKdPCzpkRsoA/YLFHohLiR+SqPEXjKQzEestLboC4l9
         m3jgpW5V6V+Xb539zP5agF3s8oFTftv21DoMFIG4vWkENHx4kEeUS4ZJ01FyJlGJ7mbp
         dtjcM4Ncxl2PtHnh3BV7lUAu7282G7T7lZzveAjDTXV3/U/Ts4kq0R869xxZzzN2lP1v
         1IUA==
X-Gm-Message-State: AHPjjUhlMap5G4z0x5vU9H30BcvHcvF97Fkd4Gnsf+AN1blvviUX4ZS0
        Gsf6wYWGMEk2FXRLbNAHDlnrfpXF
X-Google-Smtp-Source: AOwi7QAR4wuP+lNTYSE+DRxYShDMgNS30ctWpe6k9jfQKz5s5gINEDzJikxC4aNiW7RCSfom3Oy1aA==
X-Received: by 10.101.78.201 with SMTP id w9mr1608370pgq.24.1505831892819;
        Tue, 19 Sep 2017 07:38:12 -0700 (PDT)
Received: from [10.4.2.238] ([14.102.72.146])
        by smtp.gmail.com with ESMTPSA id x124sm781532pfx.56.2017.09.19.07.38.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Sep 2017 07:38:12 -0700 (PDT)
Subject: Re: [PATCH] for_each_string_list_item(): behave correctly for empty
 list
To:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
References: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
 <20170915184323.GU27425@aiede.mtv.corp.google.com>
 <b8951886-feab-a87a-9683-3c155cfa98a8@alum.mit.edu>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <b03c7b09-853f-a2ed-f73e-7d946c90cedb@gmail.com>
Date:   Tue, 19 Sep 2017 20:08:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <b8951886-feab-a87a-9683-3c155cfa98a8@alum.mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Saturday 16 September 2017 09:36 AM, Michael Haggerty wrote:
>> Does the following alternate fix work?  I think I prefer it because
>> it doesn't require introducing a new global. [...]
>>   #define for_each_string_list_item(item,list) \
>> -	for (item = (list)->items; item < (list)->items + (list)->nr; ++item)
>> +	for (item = (list)->items; \
>> +	     (list)->items && item < (list)->items + (list)->nr; \
>> +	     ++item)
> This is the possibility that I was referring to as "add[ing] overhead to
> each iteration of the loop". I'd rather not add an extra test-and-branch
> to every iteration of a loop in which `list->items` is *not* NULL, which
> your solution appears to do. Or are compilers routinely able to optimize
> the check out?

It seems at least 'gcc' is able to optimize this out even with a -O1
and 'clang' optimizes this out with a -O2. Taking a sneak peek at
the 'Makefile' shows that our default is -O2.

For a proof, see https://godbolt.org/g/CPt73L

---
Kaartic
