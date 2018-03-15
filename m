Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A87251F404
	for <e@80x24.org>; Thu, 15 Mar 2018 18:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbeCOShv (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 14:37:51 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50716 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeCOSht (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 14:37:49 -0400
Received: by mail-wm0-f66.google.com with SMTP id w128so12363143wmw.0
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VCveUB17Dw+OyC1meAGS21utnIaUQxViw/Mg9rYx3UQ=;
        b=Z33sEC6b9hzGXcdu5tWHFhj5vbV9x0UNF/GLOeWQtVjzMAxidY7Nwqse6Rx4Ao0h0s
         ElbWFeINQ9ix27lL9UU0SSGMTVA81zj1tTizprqxIcEiL4BkPYfnL3Y3D3GsbCKbFwCD
         AfAJTz6lUdnzAdQpXn0R2E7/h2mQt3t2pQEn0b1P2LpvO8rFxwGCBFT5hjQkyd5RmQEq
         7t+jt69kTXxW9kUVDQj4XVnauZYWOVJ6Tiqmi5H0itAZx8gGhA/jd5TuqbwU73BaWtg7
         hNqFgaoLmVhwiZLobRlMnsUeSnx2cab/0MSCwF9ufJTUzXdIjgO1lDg4f8W+bXnvgQoh
         /DpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VCveUB17Dw+OyC1meAGS21utnIaUQxViw/Mg9rYx3UQ=;
        b=PblgDawJ6Z6JkivOSRd/JRgI7VpOjZAfpcgqcvPYzVmEydGVfOOyLp880uLNxj3Zbw
         fuwEIu85OJHzPGW0uoU5mMmeExTSoRJsi1WhcEB7VpN3yZ0QkgVKTPYtSBfN+P7R1zXG
         7BdSH6DxXx3p1A9LshNgHercWtXuBnGbNdCHhIg1QheumNEWXAss+nuDckxgxnFH1G7b
         KCOHCs0Afv/8FnXLQpaucbJu5cVtCf6O3fUhtqWQKaSoRm6+bxbQjT+uDAb5SELMw0Et
         Zyv9OaVhEXv9K55F+Zr3S04cjZowpi5wKLK865y++tpKGRFS1EgePI8laZRqTQeTaG0t
         D9Wg==
X-Gm-Message-State: AElRT7FKAK4gvsWPCzjf/35v77BOH0SCxPUckZsQ6xumCIEEYSf2ZfOB
        jiynrmHOAgwg4/yV3Bx+Qy4=
X-Google-Smtp-Source: AG47ELvcBImf9z2QS6Zx/ZHzdanazpwOVcTKtb4eLVigldqAcNcY0es+NnJSj8BR2o4B7qnIQyJHuA==
X-Received: by 10.28.151.5 with SMTP id z5mr5726753wmd.28.1521139067621;
        Thu, 15 Mar 2018 11:37:47 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m3sm5054587wri.25.2018.03.15.11.37.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Mar 2018 11:37:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH v5 01/35] pkt-line: introduce packet_read_with_status
References: <20180314183213.223440-1-bmwill@google.com>
        <20180314183213.223440-2-bmwill@google.com>
        <xmqq1sgmz6j0.fsf@gitster-ct.c.googlers.com>
        <20180315172848.GB174336@google.com>
Date:   Thu, 15 Mar 2018 11:37:44 -0700
In-Reply-To: <20180315172848.GB174336@google.com> (Brandon Williams's message
        of "Thu, 15 Mar 2018 10:28:48 -0700")
Message-ID: <xmqq7eqd5gnb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> EOF was -1 and NORMAL was 0 in the previous round; do we need to
>> read through all the invocations of functions that return this type
>> and make sure there is no "while (such_a_function())" that used to see
>> if we read NORMAL that is left un-updated?
>>  ...
>> Will replace.  Thanks.
>
> A reviewer in the previous round found that it was unnecessary to have
> EOF start at -1, so per their comments I got rid of that.

Yes, I am aware of that exchange, and after vetting the callers I
think it is "unnecessary" for EOF to be negative and NORMAL to be 0
with the current code (iow, any value can be used for these enums as
long as they are distinct).

But that is different matter.  If having negative EOF and/or zero
NORMAL helps readability of the resulting code, then even if it is
not "necessary" for EOF to be negative, it would still be "better".

