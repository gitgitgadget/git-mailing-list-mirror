Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32FC31F453
	for <e@80x24.org>; Mon, 24 Sep 2018 21:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeIYDGi (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 23:06:38 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:54330 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbeIYDGi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 23:06:38 -0400
Received: by mail-wm1-f47.google.com with SMTP id c14-v6so11135035wmb.4
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 14:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7MXymcOqzZQLhdcgg//FVj2OsedvwkdyKjv3T9I8Q6Q=;
        b=HDgD8N2mBxOqEw0IXopYwlJMcCLTOvfZrBQ1MIz6guq91FAeYjkIxxB+g5opKulz/Y
         84nNkpdgnMvdLGSfxhbO8nCkbu2KjdFP4L2Y2U1/80+n7I4bTA0RfzsKFk3jVFAn1QG7
         56MK5PJLziGn6GYoVJA9d6d1TnQ+/5InIkLu6BXvj21vF5J8PCw4aZcOkS0k3WiLNXM6
         yLEp3vyWEY/X1NvqzSvTHviMyLeA3fiUp4gthg2HLaV5B0pRaffjaR2xhouJ0Q0mntK9
         sncnZzZjdI0gUNnfebturqBphLq/odAemtFWICp8k4MsFIG0YYmw23whNn4i5wC6UyrH
         tEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7MXymcOqzZQLhdcgg//FVj2OsedvwkdyKjv3T9I8Q6Q=;
        b=C11BYSEul2tmsYoACNBoMp5gKCndur+IQxmvot78qSCxnOzia/VxtrI1q2lEL6LGIl
         6snNg2LYYL/TXHbrZsziCNMpO7arLJiJhtyBoaJ4bHTw5sN6BR2SlQhqPGTNZHkC5+g3
         f4213tXaDydv1kWB5PLEVfJXc81oOgf4YwB3xsSneMyJCktep4/G4JQtgX1STKE1auCY
         uKwlZP/UwIvt69zrJhb1vDnYdJOGRpeFU/v4oQYL10jvqHu3rO7wb5EyGboLvGohWjIW
         VsOuwK/W11vyRUmwAdS49JpqiilUig3k+6LyK+gAlXL/LU5B8E1XnZfRb947KEpLb4Cr
         RXTg==
X-Gm-Message-State: ABuFfojCW0qigbNk+nPza3fobWhQKeEOZTURdmVgIwfG54917PwVomKn
        ZteO4S0m8mGvLV96bml/x0k=
X-Google-Smtp-Source: ACcGV62j4RTGZARuOpeKRrMoND9DTuIc30sOXmGgaHgCCvwYPdHKRpAvwujRMlfIilkO1+tqoQm+IA==
X-Received: by 2002:a1c:970c:: with SMTP id z12-v6mr121270wmd.20.1537822951580;
        Mon, 24 Sep 2018 14:02:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b74-v6sm203037wma.8.2018.09.24.14.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 14:02:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephen Smith <ischis2@cox.net>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 4/4] wt-status.c: Set the committable flag in the collect phase.
References: <20180906005329.11277-1-ischis2@cox.net>
        <xmqqworxufuv.fsf@gitster-ct.c.googlers.com>
        <2295579.U4Xb9QnJqG@thunderbird>
Date:   Mon, 24 Sep 2018 14:02:30 -0700
In-Reply-To: <2295579.U4Xb9QnJqG@thunderbird> (Stephen Smith's message of
        "Sun, 23 Sep 2018 20:15:16 -0700")
Message-ID: <xmqqzhw6r4m1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephen Smith <ischis2@cox.net> writes:

> I can see three solutions and could support any of the three:
> 1) Move the free calls to run_status() and cmd_status().
> 2) Move the calls calls to wt_status_print since that is the last function 
> from wt_status.c that is called befor the structure goes out of scope in  
> run_status() and cmd_status().
> 3) Add a new wt_collect*() function to free the variables. This would have an 
> advantage that the free calls could be grouped in on place and not done in to 
> functions.  A second advantage is that the free calls would be located where 
> the pointers are initialized.  
>
> Personally I like solutions 1 and 3 over 2.
> What do others think?

I think freeing at the top level caller (i.e. #1) once it finished
using the information collected would make the most sense---it
initiated the collection, then fed the collected info to shower, and
now it knows it is done with the pieces of memory it used to make
these two parts communicate with each other.

And for keeping multiple "pieces of memory" as a unit, introducing a
helper is a good technique (i.e. #3); but I view that mostly as an
implementation detail of #1.

Thanks.

