Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C1E21F453
	for <e@80x24.org>; Thu,  1 Nov 2018 23:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbeKBI74 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 04:59:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38192 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbeKBI7z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 04:59:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id d10-v6so205110wrs.5
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 16:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/4prLZUQcLWbvZHf4Pz08GT53wirxh4L31gT83JPlTk=;
        b=Fa7LrCi7KFD0aGNda2WdsLgU1Z2u/PmHs2AuI902ksmWE/6aX44KNYGonjjw/NTka5
         QGtgIYsPpUBdXxSpbvKD6wt7Soy5f1+ir784nnN4oq8aYsBbuDZRTecx66dJnWEAvNfv
         TlEOHKrwQzFit9QY7n/xXiSm+yo2JIc6KrUFnNu195nSygqZWPwGzpRhuSueuIPHRpp+
         L1bW48J8dY0FbyxCxTeoWz749WL1niSDzhHACXflipM5hm4UtjNpO0rk5MxucaCm3ew/
         oJ9xXzF798OkZNMOq+LikOvTpqzLP0r50JpAmwKV0a+e75o5i14ItLDudx6l5uGC0dq1
         aWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/4prLZUQcLWbvZHf4Pz08GT53wirxh4L31gT83JPlTk=;
        b=HHcg9LkiR0mAiqM6wX02NoDp8IW6aTWZPIZ1yP7bekFqS5ZPrNc59U+WyvqYS1knJF
         QXHOtjkp8raoxVUQHX7RtBmEk4+Uy7tPYUA9KqoE9l9hY25GOeEzcHH/OCcnrnSGugBV
         GZUxmC/yuqIf7/aKk1MD0Pwn6EJyjVC2I0Sq75o1ua0NPraaw3TnDqL1C/MSHFRBgR64
         mHnSeG1T2oKPEp+FjpIEuXXJhgHx1lqxUNDgNyWvh/p4UZ1U1HGcIXlZiJqBaIhub3u0
         FRqWQ6qUSL0UO5z0UFmN3cz0klSQdYHyF3G0zgfWR37MVN/3WDILRQzXu7Tm4pL8jEuY
         /z3g==
X-Gm-Message-State: AGRZ1gJd0zeCoeIKPDjFHXsm09F8OWri1FlODic5Xve0Xh8jYkBQDmyC
        5IL3/uD+ARcYz4/xhmzVUDE=
X-Google-Smtp-Source: AJdET5erdoKCCqPs7yZpeDe4toQVbBPYDkmNstnv6+E9ssYUbcMiuxrW0PEcbcc1vVK1Nq1YzM1j7g==
X-Received: by 2002:adf:f68e:: with SMTP id v14-v6mr7556960wrp.261.1541116486253;
        Thu, 01 Nov 2018 16:54:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f9-v6sm4401458wmb.8.2018.11.01.16.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 16:54:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v4 0/7] Use generation numbers for --topo-order
References: <pull.25.v3.git.gitgitgadget@gmail.com>
        <pull.25.v4.git.gitgitgadget@gmail.com>
        <xmqqpnvptlta.fsf@gitster-ct.c.googlers.com>
        <9ffd8ecd-5595-ad19-cfe1-a268e3fa1bd3@gmail.com>
Date:   Fri, 02 Nov 2018 08:54:44 +0900
In-Reply-To: <9ffd8ecd-5595-ad19-cfe1-a268e3fa1bd3@gmail.com> (Derrick
        Stolee's message of "Thu, 1 Nov 2018 09:49:22 -0400")
Message-ID: <xmqqva5gs69n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> Review discussions seem to have petered out.  Would we merge this to
>> 'next' and start cooking, perhaps for the remainder of this cycle?
>
> Thanks, but I've just sent a v5 responding to Jakub's feedback on v4. [1]
>
> I'd be happy to let it sit in next until you feel it has cooked long
> enough. I'm available to respond to feedback in the form of new
> topics.

OK.  I'm quite happy to see this round of review helped greatly by
Jakub, by the way.

THanks, both.
