Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D96361F45F
	for <e@80x24.org>; Tue,  7 May 2019 01:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfEGB6X (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 21:58:23 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43711 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEGB6W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 21:58:22 -0400
Received: by mail-qt1-f193.google.com with SMTP id r3so7386452qtp.10
        for <git@vger.kernel.org>; Mon, 06 May 2019 18:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KWF9RxPGL+ZqMuj4ZWzGkH/3eSoPs06Zw3YtxVaItNE=;
        b=OQ/tRcJ1kwTQN9aRa2UAfMeOIH7mH4gaj22SpGnQ4kT1+uPDRniPI8IKSDQYYLOJBB
         tMBvfnusasHGHzIVIb5mw0eAg8gSxHGDwTEpgWAu9dYHwWqGbhlrEYc4c79zs+T+O8MI
         SvD7G65hSCIL4nN1icYMnwCANvVFCMnB4ZChjDABYoJHLo5TOzwFllmwhxfmKcNgfC3I
         RmISBtawRKQxib2Pl+eDcaH+29IVRbYqRqZLNHi41WfYQzywx4l0dw3DGlqOBlC9oCA7
         T9huN3xtRHlhWhZQXELR0uBH1KJQw3bdvWDogo0ZQ7/Bh4D6eSP+9vA49wFMIHbUvntf
         5rgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KWF9RxPGL+ZqMuj4ZWzGkH/3eSoPs06Zw3YtxVaItNE=;
        b=CzIBr+rmm22muhJXIIoB0Q3Tdzc9m+ndZf5BLJfEzNSwLxSXvsQd5cJUcseWy/J5wf
         G9Ek/tLLT8yXCgVuW1oQebNAiHxKPrD46Qnupu3/TTjLApisVU4FeMM3vFu+vQ41+/H0
         gTcHipM5n1zSFuYzrvi1HaQxG4alyIB5RWMJdWsyF9+rymWbME/bQPxbG01bhda6CM6m
         KVQTjGbcvg6F6Pls3j4qY0C+qmUb1R17BaWfcg0+Dzq9v/nMyEzqeZq6i+0UDxWxP/bj
         8qHWKrwJQqBZrgQeK3utyMFVaC/alZ6bcYj8V0xF/ld25mEYhWTMIeGebe+4FbO5XJ/s
         Fb2w==
X-Gm-Message-State: APjAAAX940MXpxqh+M7B02qDYka0QZLpGiwTZl3rq9hiSglZfDGoopao
        cLyevM6FKWJ4auKeYHnfxRk=
X-Google-Smtp-Source: APXvYqx1nSR47gok6YZiwZU5hyUiSIz+lyMyMdjYvJR0EDmJUCy4Ayb7CGvf9m9IAJM0iHhsiBEZqQ==
X-Received: by 2002:ac8:2392:: with SMTP id q18mr23948591qtq.299.1557194302073;
        Mon, 06 May 2019 18:58:22 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id i23sm9315447qtc.18.2019.05.06.18.58.21
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 18:58:21 -0700 (PDT)
Subject: Re: [PATCH] commit-graph: fix memory leak
To:     Emily Shaffer <emilyshaffer@google.com>,
        Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
References: <f4ab2a50873b2fd91926d7401f784479504d1b10.1557178485.git.steadmon@google.com>
 <20190506215831.GB85211@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <56cd0368-1011-f06a-770c-f62b138e8627@gmail.com>
Date:   Mon, 6 May 2019 21:58:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190506215831.GB85211@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/6/2019 5:58 PM, Emily Shaffer wrote:
> Hi,
> 
> This change looks good to me, and like good evidence for the benefits of
> automated tooling :)

Same here! Keep up the great work here.

-Stolee
