Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1CE41F453
	for <e@80x24.org>; Wed,  7 Nov 2018 01:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388940AbeKGKth (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 05:49:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46004 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388065AbeKGKth (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 05:49:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id k15-v6so12650702wre.12
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 17:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yDS4xqL3naIkEb2eH4QzrebGjk98Eo5WUvHwIb9rogk=;
        b=ptGtTw7m3Lts8OyIu92p/ao/9oU09cUXYULBDHqTjGU34O5IGrTz3fqeBujtRZcIyu
         EbizxaAs3hdIqOnFVG4cyudvjmdBlHYMO2Re1va+JimD1WIibA+gkkkvkBxmgGzc8u+z
         1hQmXdjSpLOjJ8VkcJpj1F/i2UTP5JQMoGlGFrbVY2BVjFoN3/w+rqqScuK4qC4KJnul
         a33mIl0OJUMHdJXI4uQERP5ryjkcJgBCw54WAwy/zTiU/xTMV9wMgvbZ98rCrFGjbGvP
         GIfU9PSN6WPmzzX9/0S2ZUOp9LJfxnZ2BC/5VKQ6Anlj4EMBBmacDp6N6HE/fvAw49CX
         56Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yDS4xqL3naIkEb2eH4QzrebGjk98Eo5WUvHwIb9rogk=;
        b=hF313F8KVbIHCJy1XSw/vCx71Ag0u7eF6/BzO4uGcxJr09gwB95JqYqb095R0Kzu1n
         dRBM2ME4uWyjtIWEaqZT6et6eviJCYfIGOzn/GycHw/IaLQbq4eQd/gNjpOqopHedaZX
         AWRC3nh/ZTH2ykAQj+Na+vrf5NmzgaAVRs8fIUtxNdEM9sBNMQ+Qpothi7DYaMyJpD33
         lm2iZWlZT1s0bVNdRdyQ/EBVYvLVEkzjvcogxBS83TNyBVFZt3yCsb96nbnr1toKrKmW
         YYwLGa/dY3dhn/WP4zACAEJWJ+WqtWZ7B33vOI5iLT8+uhmBGzzk6DVF/kTxvHKNbtnP
         ehYg==
X-Gm-Message-State: AGRZ1gLtbQ7G4PJonSuxtKp8ZVI89GBtNEqCrG5D4h8Bi8xkuqRL2iLG
        B4brXXuxrYdj2oJoYl2Qyqo=
X-Google-Smtp-Source: AJdET5deIx4QGxxQsltVEO3QWqpeerF4B4fp+okt77x9tIOB+XKiEPc+3AvrClHMv1AwOUDZeP0D/g==
X-Received: by 2002:a5d:5487:: with SMTP id h7-v6mr14818474wrv.80.1541553691029;
        Tue, 06 Nov 2018 17:21:31 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y131-v6sm2706676wmc.16.2018.11.06.17.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 17:21:30 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
References: <pull.66.git.gitgitgadget@gmail.com>
        <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
        <9174a750-3498-c2fc-d7fa-29c1926c95fc@ramsayjones.plus.com>
Date:   Wed, 07 Nov 2018 10:21:29 +0900
In-Reply-To: <9174a750-3498-c2fc-d7fa-29c1926c95fc@ramsayjones.plus.com>
        (Ramsay Jones's message of "Tue, 6 Nov 2018 15:54:47 +0000")
Message-ID: <xmqqo9b1d6na.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 06/11/2018 14:53, Johannes Schindelin via GitGitGadget wrote:
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> 
>> On Windows, an absolute POSIX path needs to be turned into a Windows
>> one.
>> 
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>  path.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/path.c b/path.c
>> index 34f0f98349..a72abf0e1f 100644
>> --- a/path.c
>> +++ b/path.c
>> @@ -11,6 +11,7 @@
>>  #include "path.h"
>>  #include "packfile.h"
>>  #include "object-store.h"
>> +#include "exec-cmd.h"
>>  
>>  static int get_st_mode_bits(const char *path, int *mode)
>>  {
>> @@ -709,6 +710,10 @@ char *expand_user_path(const char *path, int real_home)
>>  
>>  	if (path == NULL)
>>  		goto return_null;
>> +#ifdef __MINGW32__
>> +	if (path[0] == '/')
>> +		return system_path(path + 1);
>> +#endif
>
> Hmm, this doesn't quite fit with the intended use of this
> function! ;-) (even on windows!)
>
> I haven't looked very deeply, but doesn't this affect all
> absolute paths in the config read by git_config_pathname(),
> along with all 'included config' files?

I think so.  I have not thought things through to say if replacing a
"full path in the current drive" with system_path() is a sensible
thing to do in the first place, but I am getting the impression from
review comments that it probably is not.

> I am pretty sure that I would not want the absolute paths
> in my config file(s) magically 'moved' depending on whether
> git has been compiled with 'runtime prefix' support or not!

In any case, the helper is about expanding ~/foo and ~who/foo to
absolute paths, without touching other paths, so it is a wrong
function to implement it in, even if the motivation were sensible.
