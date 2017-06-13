Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A595B1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 17:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbdFMRT6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 13:19:58 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34472 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751822AbdFMRT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 13:19:57 -0400
Received: by mail-pg0-f67.google.com with SMTP id v14so19937201pgn.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 10:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qpS0Vfkold1pvToWR3troRgMaINeQthFVFsvZe6FKkQ=;
        b=uh+iDQ77jSknZhVeNUv9ru0ssr+eio2n4sTypJ8RlSbTBCafrcJLosXe90Lc1bvQJI
         mVccnbZmtX0aoHhtsZC61xgs8D93zNI5yYsXqQ2CmN9zIM9y2hH9h+k0wrsbQqn5S34U
         0n1rq+tBrsabMbOF6EIqR9fQxii2dfriKVc/uUpxZikWIhDexFICSczPO3ZpLZG9kybw
         9CPGV+uIC4GNiFjH6E6DDhN51YD4zxC9UF08ed0E9Ng9MG7riciCrs590d88tLR44YjG
         RdGB9rtrfZk0C/qXDrRDQSZAY3Rxfj5KPad/nTor74WoZQnXyT85kzLWGllJo567Kt9L
         UcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qpS0Vfkold1pvToWR3troRgMaINeQthFVFsvZe6FKkQ=;
        b=okZ8zWV8ic908vT2dzHuWJMHdWdNi6czkHHOrB+VB4+p8OTb4gntEy+40/Sl54MhmY
         dJH47h8+ioxm7Emd1jdmmPEEyTygjTzmOAtd4q6sv8wr1a4I80E93KNCz+xKah1wEtQ+
         352k8omWQSL9NQgNZn1t4/l/Zsd+fqNZgoN3IYZi8qgkyYdE7S7Bo2dTY6jQ1XL8biXQ
         U12TKPJIwzIIsDgiscGYN7ITAqxeJ670vmLygdE1XYdLniGbVG1IdkmEYXmqoOu/myuH
         KkGAgQkrELhPQXCn1QCrOYEfGpC4kD7GHmGRFVV/p3UcaLH7oxY3AIgsppDIBvUR/ssn
         CrAQ==
X-Gm-Message-State: AKS2vOzdRCDp1Lx7+XmGluDwpMh/DYhWnAxXgJR/ho91KngHQd/Cvm0n
        3j/9ksbBq7gu0A==
X-Received: by 10.99.97.207 with SMTP id v198mr653939pgb.260.1497374397154;
        Tue, 13 Jun 2017 10:19:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id g78sm24764813pfb.122.2017.06.13.10.19.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 10:19:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC/PATCH] builtin/blame: darken redundant line information
References: <20170613023151.9688-1-sbeller@google.com>
        <xmqqvanz9afq.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYR+qh1X-dQixdpDbcr5z-DJ2mkdncaVn_8y90kNco9tw@mail.gmail.com>
        <xmqqa85b9626.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYV8Ngis=ux50Zs1r5XOBUJ=hw2=8BEkNqk7PiGamX0AA@mail.gmail.com>
Date:   Tue, 13 Jun 2017 10:19:55 -0700
In-Reply-To: <CAGZ79kYV8Ngis=ux50Zs1r5XOBUJ=hw2=8BEkNqk7PiGamX0AA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 13 Jun 2017 10:13:43 -0700")
Message-ID: <xmqqo9tr7qkk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Here is what currently happens:
>
>>
>>          context
>>         -B              dim  oldMoved
>>         -B              dim  oldMoved
>>         -B              highlight oldMovedAlternative
>>         -A              highlight oldMovedAlternative
>>         -A              dim  oldMoved
>>         -A              dim  oldMoved
>>          context
>>         +A              dim  newMoved
>>         +A              dim  newMoved
>>         +A              highlight  newMovedAlternative
>>         +B              highlight  newMovedAlternative
>>         +B              dim  newMoved
>>         +B              dim  newMoved
>>          context
>>
>
> So the there is only one "highlight" color in each block.
> There is no separate hightligh-for-ending-block and
> highlight-for-new-block respectively.

I think the adjacentbounds mode is simply broken if that is the
design.

In the above simplified case, you can get away with only a single
"highlight" color, but you cannot tell where the boundaries are when
three or more lines are shuffled, no?
