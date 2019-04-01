Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF5D620248
	for <e@80x24.org>; Mon,  1 Apr 2019 10:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfDAKqF (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 06:46:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35752 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDAKqE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 06:46:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so10798337wmd.0
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 03:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=29ONbGJgwUloBdy76rVlDHNiaSt5KQVBoXOYZAnovRQ=;
        b=SBs8f7iQCzf1DGttEb3LIpuB57oE2gsvYYoVZeyIT3uKLUOYQbSuzppF4O1Y6SNNcD
         SwLVrRzDANg9hUWMKah9WdvyhAZX4njx5xvpCawZjMHm6YhdovWlPyTlmNBEugMqvAgM
         ghTaZAcriYoCXg6j64nVJxZS/n9qAIC+jza/W/2bTHBjASRn1/pJlVJ4ij8cfi2+uNos
         Zu+jMHkqNmaP6YI78oUea/3ERzXFkyyo5aSqLucPCFCy4e6XzimSUvXyGsYp7QwEcdQA
         2CYn+FSpwDE16/QnrIl2k3bD8vVbb407tWj2PJGORfvn8MjOa2hn8DWr8r54p/IM1DFo
         J0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=29ONbGJgwUloBdy76rVlDHNiaSt5KQVBoXOYZAnovRQ=;
        b=cc98b63L4OuL0AyX8V0Ga2W8jt/Pq8C8BQKHxGGktTGKofNnnzwxpEVVKM2XadgJpg
         eux6hCTDOdB0iAbSVVvrT0ilJJnBKq30hBlfGBM1PoM8JkITjC1NbfqG2QrRErJZqfm0
         YczEY8CrTi03I+y3EsOJsbGUvE6LM/dcKbU3OZpl+5Nqe5cl6zfFYVpHKCBvE8rp6ft0
         8Q03V9OFiCvxgJPaWOOx782syOdDRFAWgiPbvI9JoVycmQw7KMT2PBXRnIhH63ZmraTr
         w5bhGN6MumgWEv48j7JiPt26INdJr54NpXNtrB87PYq7xk0sTFv5nJjzJJbmXYAh+rYx
         B5qQ==
X-Gm-Message-State: APjAAAWpjDXvy2iYhLpnhsQtlla0Ac88a+SPia5B1fgSvaMJOkTt8qbH
        eadDrIEZXgMUxa4e/fupS/qGQrplNuw=
X-Google-Smtp-Source: APXvYqyd8TtUlVgX1wPyKEEjLQk1dOHIi1ZE07IG418CL24WdaHgEJYUqkX2FuIs+gagSY4YxpWyvQ==
X-Received: by 2002:a1c:40d6:: with SMTP id n205mr12074298wma.140.1554115562702;
        Mon, 01 Apr 2019 03:46:02 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id 13sm10543229wmf.23.2019.04.01.03.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:46:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] rebase: teach rebase --keep-base
References: <cover.1553354374.git.liu.denton@gmail.com>
        <20190328221745.GA3941@dev-l>
        <nycvar.QRO.7.76.6.1903291643060.41@tvgsbejvaqbjf.bet>
Date:   Mon, 01 Apr 2019 19:46:01 +0900
Message-ID: <xmqq1s2mvw9i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Denton,
>
> On Thu, 28 Mar 2019, Denton Liu wrote:
>
>> A common scenario is if a user is working on a topic branch and they
>> wish to make some changes to intermediate commits or autosquash, they
>> would run something such as
>>
>> 	git rebase -i --onto master... master
> ...
> I wonder, however, whether it makes sense to introduce a shorter, sweeter
> way to do this:
>
> 		git rebase -i master...

I agree that this is very tempting, as it mimicks "git checkout
master...".  But as Denton responds, it is not quite the same, so...
