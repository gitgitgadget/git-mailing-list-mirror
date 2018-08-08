Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55159208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 16:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbeHHSWE (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 14:22:04 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:45884 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbeHHSWE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 14:22:04 -0400
Received: by mail-wr1-f48.google.com with SMTP id f12-v6so2456986wrv.12
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 09:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lYkZ+aHbZYcrgniAcS47QmnZKZmtSu2O1CX/WF67kXM=;
        b=Q5382elG8tt9jcqyd1XWvoTT22uJK4cMqFqnxuWBW/BGx5SvXkCEqq5o2p/pUu4t4e
         9Lip+OtkigyblDBLN1MyTFYQl7lAR18BvYsyJC6sSCB4UJNKKqelUYWM2ayaAzcSITxH
         gDJQL2G/pwGeIfsJQji19h1Uqas3jhE72vDuHe9sd5LGhVDZ1+R96T/a9ON/4Y5K7laQ
         jamoHgT5CwMM0Z6js823Cwe01n9AiU6A/dQBbm1ODMPUTO+tmHbo33yssVmdioLSm+UY
         AMPm8ahlJAKBfP3sLS48dnbHYz9y2cRzwhbA+/3Fv6W4hF0nrSrvHp21S+5d6xoFuf+4
         gJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lYkZ+aHbZYcrgniAcS47QmnZKZmtSu2O1CX/WF67kXM=;
        b=B1qDJ3oxbXLqaUeiU4mqWc9nApizqhxtsSRkTwcdz+P1trr9CLQnOi9/FiYu+VZW4z
         +zqeevDJz2z9C0h4vlHiH7MpYJmUv+PwhcrMd2l8/XybeVR/CjKTOL0ze/8QJjCRt3zt
         3TT+4k5bUnszMVE9qk4cf7AaR67VCauAt9A26UM611ensaRznYM+bBPam8VsqhOh5SRf
         8OGJSPwkQLxjEh90uMv+6/EHeA46Tug0b6ZBsl0hFUbMPmhOcrOSXm6n82d2bY9jBIZy
         /p6pmyXRmgNTwMm3nK+0cgYEYnhtKrQPmr2AP6vhgFLUikqlU+OtKKUbtJRMWzRXQUXG
         5LIg==
X-Gm-Message-State: AOUpUlFCmXkGB01H/4G6VTX55AwbcSjzsAm0WHEeGcwn27lGo/kA1oze
        Ik5zlbypCWJM7DmR819JqKk=
X-Google-Smtp-Source: AA+uWPzSvG+iICSOW0vkc3fwGLNX+8DKsnBoCgCMtuJHA5Zd5Lq/Kh/M58iKicLIlR2rJxM6daaQ/g==
X-Received: by 2002:adf:82f0:: with SMTP id 103-v6mr2243132wrc.131.1533744104234;
        Wed, 08 Aug 2018 09:01:44 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m207-v6sm7284044wma.31.2018.08.08.09.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 09:01:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 2/2] sequencer: fix quoting in write_author_script
References: <20180731073331.40007-1-sunshine@sunshineco.com>
        <20180807093452.22524-1-phillip.wood@talktalk.net>
        <20180807093452.22524-3-phillip.wood@talktalk.net>
        <CAPig+cQkY1_qDu=fdbA0gVPH88B47bM5BpgbYY8ivsj1Y0QHTw@mail.gmail.com>
        <753b860e-c922-fd70-9d2d-0581976a6f37@talktalk.net>
        <CAPig+cQdH+Xiunej1E6EnA6btFzZJTPo27cFY_UdaFZF7J7t-w@mail.gmail.com>
Date:   Wed, 08 Aug 2018 09:01:43 -0700
In-Reply-To: <CAPig+cQdH+Xiunej1E6EnA6btFzZJTPo27cFY_UdaFZF7J7t-w@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 8 Aug 2018 04:43:43 -0400")
Message-ID: <xmqqr2j8j194.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> What does concern me is that read_env_script() doesn't seem to care
> about such a malformed file; it doesn't do any validation at all.
> Contrast that with read_author_ident() which is pretty strict about
> the content it expects to find in the file. So, it might make sense to
> upgrade read_env_script() to do some sort of validation on each line
> (though that shouldn't be in this patch, and doesn't even need to be
> in this series).

I do not think it is within the scope of these bugfix patches, but I
tend to agree that in the longer term it would be a good idea to
unify these two helpers that read exactly the same file stored at
rebase_path_author_script(), and make the result stricter, rather
than tightening two helpers independently.

