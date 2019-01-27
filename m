Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F4B81F453
	for <e@80x24.org>; Sun, 27 Jan 2019 23:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfA0XUw (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 18:20:52 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:33826 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfA0XUv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 18:20:51 -0500
Received: by mail-wr1-f46.google.com with SMTP id f7so16141102wrp.1
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 15:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WGnlEzTNZen1bHX46aLUTYa7IA0jY1W1k+q16MCnaE4=;
        b=WlUAYuqcBHHKintx4PRoD9VUhU0YjODK2dEoFJspKfhwYTUFoxPt3LqfRty909UZqA
         4UX+aDixDyy0wqSBtthr76a5gHmxtNEZDUtMDw1Z2gl6qWMb06qmPWYsdUvPfTo9jP+P
         0CXZyIW6kKe0L+UWYSR8f4f0fQibxdsHa1kQMNdSsd6uV76JWibhVco8tF8mEYDdr76z
         4rw7tn1zLlcE7LpjayrVS8C+7va2d6TEG4zzV2iLlJ/3WbgjSsi9+M5CtfL1uV7nfT/J
         hxoLupyMoVeBL+cgKIcpcJD7L6eB8v8RSjdL8figtDRVfjepZFW9khCJvmoUEuW9pUE8
         TLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WGnlEzTNZen1bHX46aLUTYa7IA0jY1W1k+q16MCnaE4=;
        b=AuavpruGoNvrrQw5hjjSQp8ptxPB124R+GmCyL290mAdywspRZgZR5RfUZoDjAPdmK
         rORTwP2/nZU21JyTlUkZidgIhWkKkG1NTzO3STJoBaSmvFL9mIe9fC5ZCzTIOCAEifZM
         mqscyOT2Pvgj16kok5g5/DQ9N6nwGGBp/7NQYAlYg44wIe7aupbt2FQyu6y5jYn+hHu8
         X4DqJdtdzppzwBsbnYMA08picQPY1sJIoT1gCu1zsxp1DkxOAKR0Xu5nagLoFVLHdpSJ
         z68dWNLZ64J2+nsuSGD0MGUzAhrzAZyJbTBgL8NjnbD6uql0RmsNP5tGnzYS4ZY8AOIt
         NbVA==
X-Gm-Message-State: AJcUukf5sjDLwo+4gyVlhJgDYgMQwB09R5Uw81+MTk+ADToo51IDxuaH
        R/Wi+5gf67M9Or1gS33xDGw=
X-Google-Smtp-Source: ALg8bN5rf2uUHv8vHlg5McoZhSFFCjaj6Gzca+65q0qblvEg/p/+7YSn/d8SnVkdMFcgG+zV9RIjJg==
X-Received: by 2002:a5d:46cd:: with SMTP id g13mr20193055wrs.49.1548631249800;
        Sun, 27 Jan 2019 15:20:49 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m4sm106083149wmi.3.2019.01.27.15.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 15:20:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 03/21] ci/lib.sh: encapsulate Travis-specific things
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
        <2d0b62f1862d5fce3ac0d7b813399f560600917d.1548254412.git.gitgitgadget@gmail.com>
        <xmqqzhrr54h0.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1901261916340.45@tvgsbejvaqbjf.bet>
Date:   Sun, 27 Jan 2019 15:20:48 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1901261916340.45@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sat, 26 Jan 2019 19:37:40 +0100 (STD)")
Message-ID: <xmqqlg35elgv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> No, not really. Actually, not at all.
>
>> It would be, under this new arrangement of the code, most natural for
>> Those who want to use gnu-time to arrange it to be somehow added to
>> $BREW_INSTALL_PACKAGES, no?
>
> The purpose of BREW_INSTALL_PACKAGES is to list the packages necessary to
> build Git and run its test suite, and the only reason why this is no
> longer a hard-coded list of packages is that it depends on the CI platform
> (or more concretely, on the available macOS agents of said CI platform)
> which packages need to be installed to do so.
>
> The gnu-time package is not such a package, and it is unlikely to be
> dependent on the particular CI you want to use.

Those who want to do perf tests in the current setup would need to
install gnu-time because the current setup is only Travis, whose
macOS agent does not have it preinstalled.  Other CI platforms'
macOS agents may already have it, they may not want to get an error
by trying to install it there.  I am not sure how that is different
from the situation for gettext etc.?





