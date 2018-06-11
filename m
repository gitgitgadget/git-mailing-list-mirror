Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 477851F403
	for <e@80x24.org>; Mon, 11 Jun 2018 17:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933340AbeFKRpC (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 13:45:02 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:42319 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932647AbeFKRpA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 13:45:00 -0400
Received: by mail-wr0-f173.google.com with SMTP id w10-v6so21289456wrk.9
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 10:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=rXCpO9QIH3IGul/4fpfcM5vnLx9Y3qe2TOl+TXVmYWM=;
        b=YX1W41cg+xcm8zjfkRyGOXwn/kklRZMSqa2dgOZW4qrNC6o0dGrK3UDsdF3kdDk+I2
         bMbNzn6v7BvqkVM52tzFTbVLptBIavdWyvRWdH84QqeKXtFudBZHeub2FwB1AMwqDMyl
         LehKymCUE2m7xMU72YOkshf4/JoWbbyeTs2KLoEbDjpKC6tg/TEEuftfhE5viwvV+RLG
         zfRdCKI0CU3f0Ax/T74LMFcopWBUY4fjLoDdXhkWahqDpgkZPZ/nGZKyHt3nOz3xuKbi
         WaqWDhSYaLDxQ1456u7yFRyPqYcaiJwRPV4pWRyWD73Z4kF2cU/pkZ18vFmgFj/sMD4x
         9lIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=rXCpO9QIH3IGul/4fpfcM5vnLx9Y3qe2TOl+TXVmYWM=;
        b=BkElTUZ7tgc5SBvgXxOoggWuRjag7R5DozM5M1EyxXZkE5gNRXnOl+b6jTabKesgmf
         y5wSH2gb8012WXI9ymbaYUbpU1jUC6GMDcuPN+XyHji+V3JH5PccBo2Qm1yFTYnyXEK/
         ypwMHJiFCgk69UIP0Z1cZf14LgxyJn1R/KVi74ztGAFYDSLF+0QaFpjwPE0B5Tz4m+M8
         YaQ0KjGArXgvmggQr4z+ChhW0uzgqyJ/+dAgNNiHHQtazmyR4tiyc9eo3U21nUiSjzVJ
         EEtsRprIZBD0LXscOWsvODOQTeqM8sFYyOzMBxgPZOGbLtXZxI678ANVuG4czg3d9F9+
         KBFg==
X-Gm-Message-State: APt69E3+FxrhLb+ntOwzX9+3+DNGjdpQoqTmyFrP94MRLwk5eKBg2/uC
        A5OD+T4pDgdOeEjwvnK2NPU=
X-Google-Smtp-Source: ADUXVKJF8r7j1Szx+RXj/Dd8yPTz6RYkdI6zivPCPBEQU21XBG2k7rtsI0ypd+e45w6VLtaEAr7Upg==
X-Received: by 2002:adf:aadd:: with SMTP id i29-v6mr93615wrc.149.1528739099307;
        Mon, 11 Jun 2018 10:44:59 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s132-v6sm7512365wmf.5.2018.06.11.10.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 10:44:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: RFC: rebase inconsistency in 2.18 -- course of action?
In-Reply-To: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
        (Elijah Newren's message of "Wed, 6 Jun 2018 21:58:50 -0700")
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Mon, 11 Jun 2018 10:44:57 -0700
Message-ID: <xmqq4li9cj52.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> In short, while interactive-based and merge-based rebases handle
> directory rename detection fine, am-based rebases do not.  This
> inconsistency may frustrate or surprise users.

FWIW, I actually do not quite think it is universally a good idea to
infer that I would have added the path X/F I added to my branch at
Y/F instead if I were on vacation while somebody else first moved
other paths X/A, X/B, etc. to Y/A, Y/B, etc., and I would even
imagine that I would be frustrated if my X/F, which the somebody
else wasn't even aware of, were moved to Y/F without even telling
me.  So in that sense, doing such extra and unasked-for "moves"
during a rebase may be a bug, not a feature.

In any case, I think I'll have to delay -rc2 by a few days to catch
up, so I won't be looking at any topic (including this one) that is
not about 2.18-rc regressions for a few days.  Please do not get
upset if people with RFC patches do not hear from me until the
final.

Thanks.
