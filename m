Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17CC91F461
	for <e@80x24.org>; Sun, 30 Jun 2019 10:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfF3KDT (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jun 2019 06:03:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50385 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfF3KDT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jun 2019 06:03:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id n9so1092440wmi.0
        for <git@vger.kernel.org>; Sun, 30 Jun 2019 03:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n8erTNA4W11a8hQxfkM8/sBwXNl4SwhmLIFJymEZXBw=;
        b=dq+SQEjEj4me2cIzXN18SQtjgTAQjS2zjZKKXM8y0FizHdR8kOrMQAp+b+bugK8JNj
         iYHMrI49B7uYVv2ThAeBGfzuYhkBHuUiaBAfiUdjIglVHIXDKHXhuD/ltbLdybJMDFlZ
         XuE6RBh1t87/Fh1fGeTL+UADZYExahoXew/HF3ReEsGAkYPLGzZDIEAdtkT1QhddUA/q
         6l5pWN4KBiF90pOnLc/qTtLMurqnpJ72LeABrsJED3ER5fYEureMjuVDfTjIVv+vPjNn
         c2UB2cD81dHoOJYFoMRq/WcMgAfTrbHyjeYnwPxcqF1ZX7AgkKPKWo30V50RD5/41QvC
         Qq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=n8erTNA4W11a8hQxfkM8/sBwXNl4SwhmLIFJymEZXBw=;
        b=q7WaKl1W/swBsLNWh2jAl++7HEc6ijLUl9maEmbMLskkfGtKZloVv06MqrNiKi4PMe
         s5QrLq5/sDyO9rZQZwm5SAQQ3jwFosRra+czS/e7qDx0Ppcc8aoKcy9bd8OZkoK6FybD
         92JrzvZDYErmbIG58no1r8ZxDA9nor27wtGE1+dAZ2yyhpivQTXgVFK+B54ZFyscjQC9
         ze/Sjo56XJc8m2+WbDYdnTKExcvJYYShkZHjdi1dS8RkuzjwaMe/vEUh9gdrSyztY5An
         W3DCeveY2OlEwwkgErBLL2yziJ61MAv3mbW8vvCdaufnrlc9/v/S1+eOqniI00KY/H+E
         OLQA==
X-Gm-Message-State: APjAAAVy0k/B6tCdiNFQ7ULiMNg1nloeQD6g6uSk5sictI+CdLG0igx5
        jIpkfBW+JTEGWu/Qerw6/xs=
X-Google-Smtp-Source: APXvYqwK7ncc4KroJfZ3UFUrMpPz7SILHLg8zwea/3SCk5aFqPLL5t/QF7SOhKRqrDA0Zu8wi2glAQ==
X-Received: by 2002:a1c:18a:: with SMTP id 132mr13527221wmb.15.1561888997134;
        Sun, 30 Jun 2019 03:03:17 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id u2sm15042715wmc.3.2019.06.30.03.03.15
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jun 2019 03:03:16 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/1] Let rebase.reschedulefailedexec only affect
 interactive rebases
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Vas Sudanagunta <vas@commonkarma.org>
References: <pull.253.git.gitgitgadget@gmail.com>
 <fab124da41858b849ae74dfb1fe403bb834870f1.1561623167.git.gitgitgadget@gmail.com>
 <xmqqzhm2ang5.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1906281342280.44@tvgsbejvaqbjf.bet>
 <e332eb5f-0818-763c-9de0-889644446a35@gmail.com>
 <xmqq4l498irq.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <70648c5b-00ff-d7aa-f1f7-8bb7bf663829@gmail.com>
Date:   Sun, 30 Jun 2019 11:03:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <xmqq4l498irq.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/06/2019 23:08, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>>> I wonder if users understand that '-x' is "an interctive rebase".
>>>> The documentation can read both ways, and one of these may want to
>>>> be clarified.
>>>>
>>>> 	-x <cmd>, --exec <cmd>
>>>> 	...
>>>> 	This uses the --interactive machinery internally, but it can
>>>> 	be run without an explicit --interactive.
>>>>
>>>> Is it saying that use of interactive machinery is an impelementation
>>>> detail the users should not concern themselves (in which case, the
>>>> message given to "die()" above is misleading---not a new problem
>>>> with this patch, though)?  Is it saying "-x" makes it plenty clear
>>>> that the user wants interactive behaviour, so the users do not need
>>>> to spell out --interactive in order to ask for it (in which case,
>>>> "die()" message is fine, but "... internally, but ..." is
>>>> misleading)?
>>>
>>> Hmm. What would you think about:
>>>
>>>     		die(_("--reschedule-failed-exec requires --exec or --interactive"));
> 
> I was leaning towards admitting that the use of the interactive
> machinery in "-x" is not merely an implementation detail and fixing
> the documentation, leaving the die() message in the patch as-is.

I'd really like to try and hide that as much as possible from users - 
it's just confusing. (though sometimes we can't)
> But ...
> 
>> I was wondering about requiring --exec with --reschedule-failed-exec
>> rather than checking is_interactive() as that would be easier to
>> understand.
> 
> ... I find this a reasonable way to think about the issue.  The
> option only matters when we are doing "--exec".  And the usual
> convenience measure we'd use, i.e. with --reschedule-failed-exec we
> consider that we are implicitly in --exec mode, would not work
> because there is no default "command" to be executed.
 >
>> One potential problem is if someone has an alias that
>> always sets --reschedule-failed-exec but does not always add --exec to
>> the command line.
> 
> Such a use case would be hitting this die() already without this
> topic, wouldn't it?  In which case we can say there is no "someone"
> with such an alias.

It depends what else the alias includes, if it also includes 
-i/-k/-r/--signoff then it wont have been dying but will if we start 
requiring --exec and they don't set that.

Best Wishes

Phillip
