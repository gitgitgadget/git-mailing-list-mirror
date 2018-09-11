Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 083351F404
	for <e@80x24.org>; Tue, 11 Sep 2018 17:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeIKWWr (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 18:22:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42480 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeIKWWr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 18:22:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id v17-v6so26860287wrr.9
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 10:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cjBMI9qQd1LTR3gpoAROwMkXvVy7y0NrUTjf2eAgANc=;
        b=p4Ff0HrDWGyrLnAthrh4y34fryWxVeDgoI6dPcz5Nsp0JK+YQZ1d6YF55+d2d5YgwR
         rRlMxvw/DLhbWPz6326Pl0moc58GjJTPml1kfsHd0d7RkKEVBe5YBBaGtrvy8ouhr9Dd
         dGCji7xJ1rPdbHT/5+HwVrvuAcvkDNewmWW2f/KfKkuH+g4YGZuH5LpqZnL5IGNH13nM
         H9iWcnhVN4H/3X3cZtaurMI7+e/ZItxsXAYPUMDuEwDTrnZbvNxWQ3hqnT9KgXcYkY+M
         4JEqsuMki6+LfmVrOY+Di5xjBgBkvJeepY4TgWOKtpKu7VMELZlIv4Nd0jT5PrSpCvKU
         WpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cjBMI9qQd1LTR3gpoAROwMkXvVy7y0NrUTjf2eAgANc=;
        b=t2jIi4qK/HtOxz3jvtgVbJlCL0Po0guoFs+jDsq0ThiHL6nPUawh4JMN2Cmzaer1yZ
         fIbG4tHm33++9fWFYqCrSvbvL7nLjNmhZyOt1haf6Nr4z1w10DyuJclmEvsgb90uDzCJ
         ftZe4P7znUBQBo2KW8hT0PyoCKl0vHe1mS9CXZN+BygwAq0qu9i1HJgMiJAoPPsnBPSr
         BWs5Lfjx5oKOSYEIf7F6x3CooGo+lbZHbj2x4IH7JOUPLDvNGj3kW73Z7Dk+wVdJjik5
         lHi+DM3t80t9lFzRo8BxrBW5SfclRYBANS8oXY9LjGTik9WzbZQBUY7sCO93K8mM+lZC
         JPPQ==
X-Gm-Message-State: APzg51CeGZAxN83ih+L5L4/R/EjijEsw1xKkoGK08PKw4CzXfuSAb2B4
        8x+AFZV7oVeFP+71bVwJ3cA=
X-Google-Smtp-Source: ANB0Vda9dok2U87PgzlWjkqTn4nT4FhQVimMoQdGPPMkcxBMOpcG4ZDvr5c5hZD2UJEGXBNxvK3Q5A==
X-Received: by 2002:adf:ac38:: with SMTP id v53-v6mr19139433wrc.135.1536686547491;
        Tue, 11 Sep 2018 10:22:27 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 14-v6sm2651838wmp.32.2018.09.11.10.22.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 10:22:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 4/4] wt-status.c: Set the committable flag in the collect phase.
References: <20180906005329.11277-1-ischis2@cox.net>
        <xmqqworxufuv.fsf@gitster-ct.c.googlers.com>
        <1827990.xjSgEIESZI@thunderbird>
Date:   Tue, 11 Sep 2018 10:22:26 -0700
In-Reply-To: <1827990.xjSgEIESZI@thunderbird> (Stephen P. Smith's message of
        "Fri, 07 Sep 2018 16:55:41 -0700")
Message-ID: <xmqqworsosod.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Stephen P. Smith" <ischis2@cox.net> writes:

> On Friday, September 7, 2018 3:31:55 PM MST you wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>
>> The patch is mostly for illustration of the idea.
>> 
>> The result seems to compile and pass the test suite, but I haven't
>> carefully thought about what else I may be breaking with this
>> mechanical change.  For example, I noticed that both of the old
>> callsites of wt_status_get_state() have free() of a few fiedls in
>> the structure, and I kept the code as close to the original, but I
>> suspect they should not be freed there in the functions in the
>> "print" phase, but rather the caller of the "collect" and "print"
>> should be made responsible for deciding when to dispose the entire
>> wt_status (and wt_status_state as part of it).  This illustration
>> patch does not address that kind of details (yet).
>
> If we use this as a basis of a follow on patch, how do I handle credit.   You 
> obviously wrote this patch and I did not.

Often people just mention "This was based on an earlier work by ..."
at/near the end of the log message.  When the result ends up to be
very different from the earlier work, just adding "Helped-by: ..."
before your sign-off is often sufficient.

