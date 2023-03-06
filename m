Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C0AC61DA4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 17:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjCFRT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 12:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjCFRT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 12:19:27 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8561C7DAB
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 09:19:08 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id n6so11197529plf.5
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 09:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678123142;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1unFvd3kOZT1a411n1BynC0vClZB+p6wgQLShOXpyfs=;
        b=fJ76ZufgTLFYM3nlXicNdTCweVXN+7XrYcWldqzgXDQEPZMjYGqBQ8k3nzVvsHcXrz
         R8y7X4gKIoyg9Qnda+hq5MvRObfjgQO2D7LSUqy4x+DhhXrHBqE10pbDsKiML6jGL+Ir
         PFVfuKHkqMZyxYUh7Wu+dT///5hQPkss+WRg3COK2hHeBJby5nKNbFlYW36smXcLPggN
         jkoHsVxAjCnHfPidzWlQCYVOktbDqFmnTrqlGKG5ZpTMqUKma2Lx0G3y71KzsefG8p83
         GK5+iaaaPIWxtky92WWlMo6TXqthzBUsg5e6K+WNjiZocEu6EU8mdrruyyCjgcASpjdh
         KQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678123142;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1unFvd3kOZT1a411n1BynC0vClZB+p6wgQLShOXpyfs=;
        b=l7ddZ727PNb0tGoJDVrchIbHqzi2Z0RdXav1MmEE95aUQ0VJNGzD/ALC+g7agxDRAl
         YGpuPs0pwGeVEAfmct+pgdRemXghpCna/neXsYfcitPckL0hcMbPtZx1AXlvBadIJBZi
         ag8XjAhG887UUsuo6XicS4l3WoGowMOCts579mEHqFeUw3CdmsUrMNixyCD29LZ7OX/w
         PeTKw32Uh0n6EU1tZn/8OT6D5oeHQ9JWAsuZgPflPDPTSaTV/j8pUhkbhA9EoDH2+GcO
         GcMFIJUJrTHCs5FuLqJvfjcdTZmGvpZ8PTDW326gdy5g2fI0zbKPjELqa3m9JwFuK3Ca
         WsmQ==
X-Gm-Message-State: AO0yUKVrvItalAGxXuy70Bm4gCWVJJG2eHWswnh/aUEKSNg6naHjCPbS
        +5+0GmOQpwF3I2qCAPtdRLSKupscdPE=
X-Google-Smtp-Source: AK7set+Xg/asDU40rAbeTobtwVuSAavxfuCGTXw0KLJqw7FQRtQX8/MsvyJxR2bl9y6vOBB9yWLVLA==
X-Received: by 2002:a17:90b:3882:b0:22c:1e06:26ec with SMTP id mu2-20020a17090b388200b0022c1e0626ecmr12016950pjb.44.1678123141564;
        Mon, 06 Mar 2023 09:19:01 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id x65-20020a17090a6c4700b0022bf4d0f912sm7906533pjj.22.2023.03.06.09.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 09:19:01 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, chooglen@google.com,
        calvinwan@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v6 0/3] rebase: document, clean up, and introduce a
 config option for --rebase-merges
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
        <20230305050709.68736-1-alexhenrie24@gmail.com>
        <87ilff2xsl.fsf@osv.gnss.ru>
        <CAMMLpeSowxoJgPOt84Dos8BVKU=y=M+Ph0xaGe6UTxwwE5zsXQ@mail.gmail.com>
        <87ttyyn71f.fsf@osv.gnss.ru>
Date:   Mon, 06 Mar 2023 09:19:00 -0800
In-Reply-To: <87ttyyn71f.fsf@osv.gnss.ru> (Sergey Organov's message of "Mon,
        06 Mar 2023 01:54:20 +0300")
Message-ID: <xmqqh6uxbxx7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>> I am curious as to why you say that flags with optional arguments are
>> considered bad practice.
>
> As far as I can tell, the core problem with such options is that generic
> options parsing code can't tell if in "--option value" "value" is an
> argument to "--option", or separate argument, that in turn may lead to
> very surprising behaviors and bugs.

Another one and half reasons are

 * Can there be two or more such options used on a single command
   line?  Unless we limit the command line and say "such an option
   can appear only at the end of options and without any non option
   arguments" (the latter is what you said above), we'd end up with
   a system that cannot be explained to casual users.

 * What about short-form of option?  Is "-abc" asking for three
   options "-a", "-b", and "-c"?  Or is it "-a" option that takes
   optional argument "bc"?

There are some advices we give in "git help cli" to our users, which
we shouldn't have to have given if we rejected flags with optional
arguments in our commands.

Thanks.



    
