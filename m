Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65DB21F404
	for <e@80x24.org>; Fri, 30 Mar 2018 22:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbeC3WIs (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 18:08:48 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:51049 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752384AbeC3WIp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 18:08:45 -0400
Received: by mail-wm0-f54.google.com with SMTP id l201so17259863wmg.0
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 15:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=033hdvCux+diTK7QLMX5JkJ01s2yYjAGoU7LNswNipU=;
        b=EpkoJhed6F0WREcL2rFaXlrWTIjNvqpYRl0cY4RdBRNUmVwiU2Czxj6VBZG4ut4cSY
         4EEqurzel5Fz3lXbqwXIBIbW2nTAe5KFV58L1FR8ENAbhTaRySbRPpWcvwYKlUUDOx0+
         TdWX/bIiixCWr9pdToKxpip/HpFGfM93XUR54XTRTS+HAIYBzNL3LgzgV8zeLbogUGeE
         uhPzJm5+7u3L4YaxFulbITne2AiePbCm2Xvbe++ISE6+Z57dKImBaNPqQ+B3NQeO28g6
         qrkVNX/ExgO2BJAVGT3yEFwH2KkqUzIBUk9yD47HErc/WjZYDu30x0kCnA06fT3jFAdb
         0Q1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=033hdvCux+diTK7QLMX5JkJ01s2yYjAGoU7LNswNipU=;
        b=qHwSCgMXygdckYAXzeIgyRLz8t9J+m0jN/Z52w0c2E6H16RsyjRBMxS7UCMaKXDztw
         KDsyMA2SzVKl3k9Ixgrok0HL/lAwWRQHLuFFSyrGXX8J/ii3JdksU/ddTyJBRbmFcgH5
         mT98w4MXmiO/pKmUlPi0cgZXIiabbJq4iTFoA4iexANO7mwxY/DV/v7gDvNv0URXU2Ll
         7WL3/3ljN2ULcT56BGo10QltdpumrGk6FoaquI4wvtXPamPf9f62IQoT8InlD2QjoeyP
         AgepmrWTdoYWuzgyihpA21gNzNOq170kKqVdp8Q3U8vqX/Q5IaihZ1ueAX8EoHQ+4W8j
         6Z9A==
X-Gm-Message-State: AElRT7F25fzyHxDcZ9tKuJ33WIEmjBB6kf4bnBMkOLQKoBsWO1/Ljq0c
        a7nd9xobEZZTHUu08bWynK9SPB47
X-Google-Smtp-Source: AIpwx4+0fq0RDGSeVDOu/ytbOKs0WLKi5PrgGgtB67AtcOu1cMC4CI5egaPuXmQdOBCuKrw8ZL4CUw==
X-Received: by 10.28.237.19 with SMTP id l19mr3074205wmh.157.1522447724012;
        Fri, 30 Mar 2018 15:08:44 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z12sm7581378wrg.20.2018.03.30.15.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 15:08:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Pratik Karki <predatoramigo@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [GSoC][PATCH v5] test: avoid pipes in git related commands for test
References: <CAPig+cS3GjYo+5C_W6WqzK3RP=W+918E6Cz=FSvHky6EWCEZPA@mail.gmail.com>
        <20180327173137.5970-1-predatoramigo@gmail.com>
        <CAPig+cSykgDMO-CMc0O5g5ke7D3VSKoaQdNLQDHfu8oTWTDS6w@mail.gmail.com>
Date:   Fri, 30 Mar 2018 15:08:43 -0700
In-Reply-To: <CAPig+cSykgDMO-CMc0O5g5ke7D3VSKoaQdNLQDHfu8oTWTDS6w@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 30 Mar 2018 17:45:13 -0400")
Message-ID: <xmqqmuyp1aj8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Mar 27, 2018 at 1:31 PM, Pratik Karki <predatoramigo@gmail.com> wrote:
>> Avoid using pipes downstream of Git commands since the exit codes
>> of commands upstream of pipes get swallowed, thus potentially
>> hiding failure of those commands. Instead, capture Git command
>> output to a file and apply the downstream command(s) to that file.
>>
>>
>> Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
>
> Unnecessary double blank line above sign-off.

"git am" would automatically trigger stripspace, which would eat the
extra blank line from that two-blank-line block.

> Aside from that minor hiccup (which Junio fixed when queuing), this
> iteration addresses all my review comments[1] from the previous round
> and does not seem to introduce any new issues.

Thanks for a review.
