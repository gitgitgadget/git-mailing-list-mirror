Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E29F1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 21:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752690AbdBMVSn (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 16:18:43 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:35150 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbdBMVSm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 16:18:42 -0500
Received: by mail-ot0-f194.google.com with SMTP id 65so13620203otq.2
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 13:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9t+9JmcROLNfQBdFiR1Gc7CSd+XHZ0a5LmQzS0MzuaU=;
        b=boUpbs0h8zNnnyMppNsUndC4kDrNkWOySFK+qmdcNilCWOsoaTymo/joCDHkq0YmvG
         mIPFaA/BAAZdnUaOovLk1NFcKTjmoEe01+9u/TA4hOkhOuuQjA1Q6g30e3r5xZ0lhrxS
         Jwx4/SztfUpVhb+bLUu45bixOdA3ZVuEWNPqktMhafoLyxwDDP0t17NtNZLhg4s8E098
         Uv95LfqoWgE0NMk+oQ9PGptDQzlX7+cuGXDo5xgSiEMV7rAwVotiFwvSY+TieRbLFqhh
         uT4qrSvKfk52PcTMMBBCT50/219xk7yeMkUbfxyozbEuxQylzheEEUdPwCkolBbMkZNx
         Wbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9t+9JmcROLNfQBdFiR1Gc7CSd+XHZ0a5LmQzS0MzuaU=;
        b=ixbrvHzXxr6V3kQuGaVMYEpIxxouNZ1CkVjjuQPKBnxy2pvDo3CszoW5ARP0fvz63n
         0qDFKSnLKUQasw2AJTGPzz8VbVjdX7Z/QR+0kL6SMNbM0XAziPXzrI6VFR1Ss5m8pzz+
         L5P2BBacvITnNEh6hoet98VWPpMM/lzZSA4h6Rn75jTp++2cp3mvlwIYVDcp0xOetbiF
         JIlQXeQnx6XDiLNqCXKcmXATcVik5sssBHqhkIROqxjNgp9yhMax67FlclhN9YibEPmD
         4cHzQixdHkUiAUV5gYCezdCG3WZMq9GqnO0+loYztgtStUaziTgGvimfQgt0ebjzGsd4
         1mCw==
X-Gm-Message-State: AMke39mdteNoq0KaDazC3ybQ7OcG2tbzdS3ovkThrZgShB69NUnRQ353UIbDZ7kqCRgxeA==
X-Received: by 10.98.72.88 with SMTP id v85mr28088308pfa.54.1487020721795;
        Mon, 13 Feb 2017 13:18:41 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d0e0:42a7:601f:5154])
        by smtp.gmail.com with ESMTPSA id n8sm22813514pgc.16.2017.02.13.13.18.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 13:18:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     hIpPy <hippy2981@gmail.com>, git@vger.kernel.org
Subject: Re: Incorrect pipe for git log graph when using --name-status option
References: <CAM_JFCwYAKCWrHqCtcwid27V1HvhuSmp4QpbNpgyMzrzWUNYog@mail.gmail.com>
        <xmqqa89pevw0.fsf@gitster.mtv.corp.google.com>
        <CAM_JFCwN+o54mJ1XJ3rSKnXgPx3wt_i=fd8ZSGpcL-fSegQ=Ow@mail.gmail.com>
        <20170213211653.x3huwmzprvmm3yxj@sigill.intra.peff.net>
Date:   Mon, 13 Feb 2017 13:18:40 -0800
In-Reply-To: <20170213211653.x3huwmzprvmm3yxj@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 13 Feb 2017 16:16:53 -0500")
Message-ID: <xmqq37fhdc27.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think the problem is specifically related to the "terminator" versus
> "separator" semantics. Try:
>
>   git log --graph --name-status --pretty=format:%h
>
> versus:
>
>   git log --graph --name-status --pretty=tformat:%h
>
> The latter works fine. The problem seems to happen with all diff
> formats, so I think the issue is that git is not aggressive enough about
> inserting the newline at the right spot when using separator mode.

I guess that is one of the reasons why we made --format=%h a synonym
to --pretty=tformat:%h and not --pretty=format:%h ;-)
