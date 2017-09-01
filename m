Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 420801F4DD
	for <e@80x24.org>; Fri,  1 Sep 2017 23:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752616AbdIAXue (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Sep 2017 19:50:34 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33945 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752605AbdIAXud (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2017 19:50:33 -0400
Received: by mail-pg0-f47.google.com with SMTP id t193so4466961pgc.1
        for <git@vger.kernel.org>; Fri, 01 Sep 2017 16:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=reHZB1HAUPtI2wY074vpHT4TZU0Z+psJ3Gz4n0MiwfE=;
        b=L5ia0qWMhDgybWYDIlw8CeYIO+WCNmdmq0omR6kC0ruD31BHCPB67Jzy3srWgWTvXo
         BvHrBaL1KVz+4jKsbwy9CNxrzgjyXw5Z3W9PLnOnvheHb8EE97etLVgrFx18MVkH4x0l
         83ycH5U1GJxbpjx3qDKMsG79IhAOFhFyhuHVaVxB/xtDlMw84VKC61aVETkw4zoSyQ74
         HrBD44btIgCatoB+jnP7de88L5ZYc1wqDJwYYOTeAMBrI1LG/iPIyqicJ9M85oZLhR5V
         YFOuj0AvHbIwiySWSHcxtFtNFlD4ToRIFfVGnwoadPqj1rDxMElHTQVDH5GXighijoAo
         N6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=reHZB1HAUPtI2wY074vpHT4TZU0Z+psJ3Gz4n0MiwfE=;
        b=Rd1hLpUdTifO2lB5/so5Q7bkKiu6eyh2ioEXcK0S8aPfHdOds5uUTgEKotCIZuriTU
         TffxcFmw++DnxQwd5X94i3rTLKqG/cJd2OCG7JWIgVPtAqP3fHWx3N50FvQHbLXoHZoq
         mVTtqBxmZHwcuNK7LuZTC2dxjNmRplMnqCucw1yAFW13l/oITeJ69+re7kPTAIDIQ52l
         LvyyxPwZPL//N7fphxThaW5i99zV4Mz+k7I3Wn3MNsf4HeL9x3sjd6F6pNlO8Ama0VDP
         kcg0JqxmZwVLCR9mA0laYuEzo5Ph7w8M4cbsR+GdsTGhNq4mpO6chI934HiL1tyYpZ8v
         7Sdw==
X-Gm-Message-State: AHPjjUja4mRytkrUhL0/SEKxVq1pmPuc2017ndYE+4DXvWfGkLeJCKhM
        DK9hr6E+TYDmFA==
X-Google-Smtp-Source: ADKCNb5VSgfUo1J8xJRir4sKXu1bi73aAdH0RPWBDrZoBb4SYKfHcInnVDsQq3i0d6dvN81LJC+bBw==
X-Received: by 10.98.85.71 with SMTP id j68mr4079021pfb.165.1504309832776;
        Fri, 01 Sep 2017 16:50:32 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c8a:d1f4:a5bc:2c5f])
        by smtp.gmail.com with ESMTPSA id c14sm1622343pfm.151.2017.09.01.16.50.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 01 Sep 2017 16:50:32 -0700 (PDT)
Date:   Fri, 1 Sep 2017 16:50:30 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, martin.agren@gmail.com,
        git@vger.kernel.org, jeffhost@microsoft.com, gitster@pobox.com,
        peff@peff.net
Subject: Re: [PATCH] hashmap: add API to disable item counting when threaded
Message-ID: <20170901235030.GD143138@aiede.mtv.corp.google.com>
References: <adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com>
 <20170830185922.10107-1-git@jeffhostetler.com>
 <20170830185922.10107-2-git@jeffhostetler.com>
 <alpine.DEB.2.21.1.1709020109520.4132@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1709020109520.4132@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin wrote:
> On Wed, 30 Aug 2017, Jeff Hostetler wrote:

>> This is to address concerns raised by ThreadSanitizer on the mailing
>> list about threaded unprotected R/W access to map.size with my previous
>> "disallow rehash" change (0607e10009ee4e37cb49b4cec8d28a9dda1656a4).

Nice!

What does the message from TSan look like?  (The full message doesn't
need to go in the commit message, but a snippet can help.)  How can I
reproduce it?


>> See:
>> https://public-inbox.org/git/adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com/
>>
>> Add API to hashmap to disable item counting and to disable automatic
>> rehashing.  Also include APIs to re-enable item counting and automatica
>> rehashing.
>>
>> When item counting is disabled, the map.size field is invalid.  So to
>> prevent accidents, the field has been renamed and an accessor function
>> hashmap_get_size() has been added.  All direct references to this field
>> have been been updated.  And the name of the field changed to
>> map.private_size to communicate thie.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>
> The Git contribution process forces me to point out lines longer than 80
> columns. I wish there was already an automated tool to fix that, but we
> (as in "the core Git developers") have not yet managed to agree on one. So
> I'll have to ask you to identify and fix them manually.

I *think* (but am not sure) that there is an implied bug report in this
comment, but I am not sure what that bug report is and how I can help
with it!  If you have a link to an issue tracker, thread, wiki page, or
other pointer where I can learn more, then that might help me.

Have you experimented with the patches in Junio's branch
bw/git-clang-format?

[...]
>> +	/* TODO Consider counting them and returning that. */
>
> I'd rather not. If counting is disabled, it is disabled.
>
>> +	die("hashmap_get_size: size not set");
>
> Before anybody can ask for this message to be wrapped in _(...) to be
> translateable, let me suggest instead to add the prefix "BUG: ".

Nowadays (since v2.13.2~26^2~3, 2017-05-12), there is a BUG() function
that you can use in place of die():

	BUG("hashmap_get_size: size not set");

Thanks and hope that helps,
Jonathan
