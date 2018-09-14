Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AA571F42B
	for <e@80x24.org>; Fri, 14 Sep 2018 17:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbeINXD3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 19:03:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55123 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbeINXD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 19:03:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id c14-v6so2786321wmb.4
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 10:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MByyOMUCtGhmaP9Z9cIocpHByRcVY1bdbdZvMyhi20o=;
        b=YaVSLTvtzMyPHQISDzeq2+RgcnE+ICGc0ukg74QBBcGV9VfCovUJI49ja1XJ80MPDe
         qoh8bzlzPA53dQL6i6BmcpNL6iTIB+b1duyrKNS2ajlblGe0TOzoPjPhKZzKV54dg75C
         s9kvY2/fOUHQh+yom6mkGMxyyMntHuhTJOAtAeSA0wahCVFfHdfdsrOPp8f5hpC9ACqr
         7D18ECkG/lh4/+03gxstG34pxDlIGU4qZ/4NXiYc0826Sctp8tZ/UY1nezRNApnGB59E
         Ivp7A+2htRNc1laV/uMX8Z8A7Zu/w//w5yRzonb1iN3cN9Ks2Uc4NiFb507L4DpnfAy4
         4bYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MByyOMUCtGhmaP9Z9cIocpHByRcVY1bdbdZvMyhi20o=;
        b=AJbMc1RJwuJ+L/EdL9Q9kBfNFptyXbT/aA6Ja1zMkqNha5FDJ3OBdfKD4RxFxHU9vI
         6GNJHbN+caagGH9Zq2CGGRp0memwc2ntQhdgFQNnh+m4kht1Ym73gAuqzWBF4e89FB70
         MKjm50Rt064MLcGg28qLcBjhbTDJfYpJqwpcFaRQa9b7LNJIXJALzDFEl2X/6y0Dhd5/
         tDRw77xQRTN6wBZiGcJUQqFLDP78ZsYtfX0sSYQ+ffhkSkdMLr62yzpAWtVLyoaVWNin
         3TU95kn0zSQfBC12yLvVpgrkKbDa0ai3DvWE1ZKGJt1BqwdsDLNsTUjwVzT+4DlFtHYO
         7MLQ==
X-Gm-Message-State: APzg51B9+rbi1Rzfo+NS+X/NaWDQiTWd/VWXIvORuLIRxI7QV0dQRdwx
        IYlcCKkxanppXiBvxJ2hiH8=
X-Google-Smtp-Source: ANB0VdaEK2KDjTcO4cyc8KjnfPZCM//A47CGQ/zwIhCWwNpt15ng7TrCzmhSftSczT/x0/WoriZqWg==
X-Received: by 2002:a1c:9616:: with SMTP id y22-v6mr3357476wmd.72.1536947275162;
        Fri, 14 Sep 2018 10:47:55 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h8-v6sm8326491wre.15.2018.09.14.10.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 10:47:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     sbeller@google.com, git@vger.kernel.org, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: Re: [PATCH v8 7/7] list-objects-filter: implement filter tree:0
References: <cover.1533854545.git.matvore@google.com>
        <cover.1536885967.git.matvore@google.com>
        <edba3791caf8bacc2f722f7874369f6776ecffe0.1536885967.git.matvore@google.com>
        <xmqqr2hwasgv.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 14 Sep 2018 10:47:53 -0700
In-Reply-To: <xmqqr2hwasgv.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 14 Sep 2018 10:39:44 -0700")
Message-ID: <xmqqmuskas3a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
>> index bbbe7537d..8eeb85fbc 100755
>> --- a/t/t5616-partial-clone.sh
>> +++ b/t/t5616-partial-clone.sh
>> ...
>
> Break line after pipe "|", not before, and lose the backslash.  You
> do not need to over-indent the command on the downstream of the
> pipe, i.e.
>
> 	awk ... |
> 	xargs -n1 git -C ... &&
>
> Same comment applies elsewhere in this patch, not limited to this file.
>
>> +	sort fetched_types -u >unique_types.observed &&
>
> Make it a habit not to add dashed options after real arguments, i.e.
>
> 	sort -u fetched_types
>
>> +	echo commit >unique_types.expected &&
>> +	test_cmp unique_types.observed unique_types.expected &&
>
> Always compare "expect" with "actual", not in the reverse order, i.e.
>
> 	test_cmp expect actual
>
> not
>
> 	test_cmp actual expect
>
> This is important because test_cmp reports failures by showing you
> an output of "diff expect actual" and from "sh t5616-part*.sh -v"
> you can see what additional/excess things were produced by the test
> over what is expected, prefixed with "+", and what your code failed
> to produce are shown prefixed with "-".

I notice that patches to other files like 6112 in this series also
spread the above mistakes from existing lines.  Please do not view
what you see in these two test scripts before you start touching as
a good example to follow---rather, treat them as antipattern X-<.
5616 is not as bad as 6112, but they both need to be cleaned up.

We could alternatively do a post clean-up, but ideally we should
first have a clean-up patch before this series to co.

Thanks.
