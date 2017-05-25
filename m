Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 180A620A04
	for <e@80x24.org>; Thu, 25 May 2017 23:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030462AbdEYX2M (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 19:28:12 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32824 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965050AbdEYX2L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 19:28:11 -0400
Received: by mail-pf0-f194.google.com with SMTP id f27so42022886pfe.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 16:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=t0yeGNu8yloFjF7oHnJmsVtdwvfQmS71JIGyCkMJCf0=;
        b=AG4gtcl4/7EHdIZNzfmzuabhkFd6HvkuIR04UVy4P/8DK8wwIaXtBS82QK7IjUd/41
         BJwwndV87uoz6v8UBFcjuMIDtwOWJOBk3krkKOtSojjrPPSiIrgpNhbEF40Fnn1j9S5d
         2UfdNw+vnpqUsMJFe0rzQc7+vx9bplPsKa3eNx3ulpZPQ6eVYDS09uGZiwuFLaAC2/Xe
         4+lUmcFONcyraWJNSz/jYp5BsttXCTeN14KHNE/fj1FyEZCzAmmNhkz3zsPHpUVY9IRs
         hvf7A7zqwErq0E4n5v+z2iAC6RQYVadxf0LS7eyqpVRQtFrnnA2Kh/SlxGWV2LX89A1O
         wb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=t0yeGNu8yloFjF7oHnJmsVtdwvfQmS71JIGyCkMJCf0=;
        b=IGqzmrb5EKtrnjyd/qz67geOGhD7OIRwhR1wHCIR9M4rpn+S0Pr6E58zoNUl3wVQOG
         oF1pMMM4cMLEQ3I68tn+xHWzn40Wxv6c/2cvfx5mqrB+n5tZPR/RAE3nlVQhR5HcSvhV
         Z48dbA02vd4oj2l02J7URADaRnm0E7xgi4o+z2tm/qAD2bva6dc6hz6JlNNrZFvqMSda
         aU90Jkvtr51NthBf7/Y1oRRMR8FtQO5SL+a645J2rBq3l7fdz5IiBtUmH/EmgOeCEjXq
         lfCIVXUsIKnbvn8r65nx9wzimKciz4QGn9I3XZ/U9HeFBFRozIgXWp+2wIMwj2RGD3iB
         /BTw==
X-Gm-Message-State: AODbwcBq0wi/gKZKoHp445D1v/YU0+nSC2h3JkU9Vwx/mFWegh+HmSQ/
        Nzw+Q8qnD01cIA==
X-Received: by 10.99.37.198 with SMTP id l189mr48857404pgl.102.1495754890500;
        Thu, 25 May 2017 16:28:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id x5sm15004540pfi.94.2017.05.25.16.28.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 May 2017 16:28:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.org>,
        =?utf-8?Q?F=C3=A9lix?= Saparelli <felix@passcod.name>,
        git@vger.kernel.org
Subject: Re: [Non-Bug] cloning a repository with a default MASTER branch tries to check out the master branch
References: <CACQm2Y1QtKD3M6weNhGrAQSLV8hLF4pKcpHDD7iUc78aWrt6Cw@mail.gmail.com>
        <xmqqa864mea3.fsf@gitster.mtv.corp.google.com>
        <76BD8B6A1511438B8CCB79C616F3BC5B@PhilipOakley>
        <20170524141947.2gguzcvyu6lch373@sigill.intra.peff.net>
        <xmqqshjtg1kh.fsf@gitster.mtv.corp.google.com>
        <xmqqa861fx34.fsf@gitster.mtv.corp.google.com>
        <20170525155924.hk5jskennph6tta3@sigill.intra.peff.net>
        <20170525191115.tqd6zlj5mxqls4wp@sigill.intra.peff.net>
Date:   Fri, 26 May 2017 08:28:09 +0900
In-Reply-To: <20170525191115.tqd6zlj5mxqls4wp@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 25 May 2017 15:11:15 -0400")
Message-ID: <xmqqy3tkcy9i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I dunno. I was thinking there might be a quick tweak, but I'm wondering
> if this arcane case is worth the restructuring we'd have to do to
> support it. It only comes up when you've moved the server repo's HEAD to
> an unborn branch _and_ you have other refs (since otherwise we don't
> even send capabilities at all!).

Thanks for digging.  You made me to start doubting it is worth
doing, too.
