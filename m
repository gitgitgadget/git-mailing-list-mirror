Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28267202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 17:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbdGMR6r (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 13:58:47 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32875 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdGMR6q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 13:58:46 -0400
Received: by mail-pg0-f65.google.com with SMTP id u62so7734350pgb.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 10:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=j1aO+d3xAS4DOpS9dB1vRaPp1errQMhFIEigxkejsMA=;
        b=PyVntkr7h39icuzg2Zaa79+xMKuoIfYJ4bTgCQdTdlaH/xiqPoqzmEk1kL4ryyVuBF
         DOv0uX7am2cKGyZM81DtOpUjOkuXH9pfRe0Ul3zYDspgGOrnxeT1LNmaGbqp/r3hMBie
         3eVgR3XCH5+JB2NqaYoUwOn11XKjp3FjLvqfaYEBF2UxChK0z3dOrhgEAxoQsyKqfszp
         3x47xWEGdMZMs7fhGre3mwavIlkeV0aRxDyTvE8caRiPFnNoSm06OyZPaOlVC0dW1cwB
         70hRd+ryj3dPnj8edk/Ucn5nteucah1oNiKQEuXq4SZcIzy+zeHaXk8JKokT7sEf8/Ai
         hPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=j1aO+d3xAS4DOpS9dB1vRaPp1errQMhFIEigxkejsMA=;
        b=cZQw3WZl9qyM+9bEVJUxS3JJ5vg24Cb+hDyKmJYhSuPdD15/teSgY4PtQ3bTxcR50i
         RO478B2W4Cq6MRHLllSGu2iL0i+6Kgtq03fxHiAiV+/xFusQvHKvQrqJcTtacHyDzrAj
         YGEBcjNt3zmN7bzfOXWZWb1K3RbgtTzarrVPJTS5b7CVHtFSM9kfgjF0wFOriyUcAvgo
         IMoqObgYnsuGfXCNnMGCIeszVHPssLbrN4UXZkpQfWGmMrIMJN7eR6E7ikwGHcZtELpK
         ogzw/h6rLVRk3IAZXRbNMGhxJdmuzMgo/uOqKYxGOD4UGRZIfT+6yW7em91S8AIEuasN
         EPYg==
X-Gm-Message-State: AIVw113Zgfrd9t3lDWplXiwxQN7VxupBZw19K34DV39bEtxl84/22mG8
        SdOy9cXL0QhRyw==
X-Received: by 10.84.160.226 with SMTP id v31mr11276063plg.91.1499968725505;
        Thu, 13 Jul 2017 10:58:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id s9sm13697752pfe.67.2017.07.13.10.58.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 10:58:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org, me@ikke.info
Subject: Re: [PATCH] commit & merge: modularize the empty message validator
References: <20170706044640.GA11020@alpha.vpn.ikke.info>
        <20170711141254.7747-1-kaarticsivaraam91196@gmail.com>
        <xmqq8tju3eqp.fsf@gitster.mtv.corp.google.com>
        <1499950837.2427.1.camel@gmail.com>
Date:   Thu, 13 Jul 2017 10:58:43 -0700
In-Reply-To: <1499950837.2427.1.camel@gmail.com> (Kaartic Sivaraam's message
        of "Thu, 13 Jul 2017 18:30:37 +0530")
Message-ID: <xmqqr2xkxlpo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> Sometimes I abort an commit from from the editor by providing an empty
> commit message. Then I came to know that 'git commit' considers commit
> messages with just signed-off-by lines as an empty message. I tried to
> take advantage of that. I once tried to abort a merge by just removing
> the "Merge ..." line and leaving the "Signed-off" line and was
> surprised to see the merge happen instead of an abort. The rest is
> history. :)

I think many people know about and do use the "delete all lines"
(i.e. ":1,$d" in vi, or \M-< \C-SPC \M-> \C-w in Emacs) to abort out
of a commit or a merge.  I just do not think it is likely for them
to leave Sign-off lines and remove everything else, which is more
work than to delete everything, hence my reaction.

