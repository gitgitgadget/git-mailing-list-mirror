Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B33EC1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 03:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeDQD3h (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 23:29:37 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46398 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751793AbeDQD3g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 23:29:36 -0400
Received: by mail-wr0-f195.google.com with SMTP id d1so31296003wrj.13
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 20:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BEoNbrn08R+P0AywhswR4gUYDFLWykHvkdWqAw1ppbI=;
        b=aTUGyrDul9srRyJ/h3r2J2QOImX4fNNJFMDMms/3w4JgPIGKrs7JAJ7S55Ga3dHTlU
         ly7JWigQ3NGGxIgUBJaMasTtBwiVCWNQ6bmy8ZMtKmCOwN+XSDRmAEK0Bf4SyvZ/W1/k
         SLp5uSJAW02ZPwuVLAcjXhUYKsxP1X7aiESHbY+4YiEatBmZDnh6zlVvf4BJerQ1RB2Q
         RH/9u5RVx53SP+CmajYh20n3wq3jPDldH1qtgY+3SOC/FBaA8v7edQ+IgAsN7FpSGyqO
         NG7OK4udlpGXSdEGZJp88YzcIyyFQltidDX+uQlLqfNtjcaHEu8i2hmgEQ9rjv/SjLRf
         a/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BEoNbrn08R+P0AywhswR4gUYDFLWykHvkdWqAw1ppbI=;
        b=dKoeW5v54SxZvZFmOwSd6HssJU6xs++BZANH9isLV7q0GjyYCLnJYaMAoklUE+Q9bG
         uX1eUGVLPZ51eUQf0dZhtm9jJ24CYIs+jbMzi9c6KJHCXGgImL3wnbPwuNeVxRpubxyJ
         HNBoYxs1NAspp67cIcussfuRlDhli6SjKFFwu0yjpnZTpRwih0QhNl17LHmwxr4/jJKd
         cvi3KFw8T9fyYeJ8aYGO4tfIE12kVmPFQBxN850iq6Ahwl6fMyxICJxG+Gc0V8AucpC+
         4OMMj6qCEaD5RZteeqx4Y8fXOsy0GjUJ/JGdTCBRrPXIEYfldHL+OZxHbv1L/lTGMD1G
         8r7g==
X-Gm-Message-State: ALQs6tAtgc8stVns1CIJCLLGqt/xLQQFQpTYnm7uWiI7V/SOo7xIoO3I
        E5gtnJENYSMcdrfovTM0hco=
X-Google-Smtp-Source: AIpwx49/MEy7Q6D8rgLPL9UvUJUGFMiDpXFB6Q+ZwLpW2+g3UOUKqBJuHod+Em0rHH8j/qnuk86Hsw==
X-Received: by 10.223.164.150 with SMTP id g22mr225426wrb.53.1523935775115;
        Mon, 16 Apr 2018 20:29:35 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t8sm10004423wmc.20.2018.04.16.20.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Apr 2018 20:29:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH 2/2] builtin/blame: highlight recently changed lines
References: <20180416220955.46163-1-sbeller@google.com>
        <20180416220955.46163-3-sbeller@google.com>
Date:   Tue, 17 Apr 2018 12:29:33 +0900
In-Reply-To: <20180416220955.46163-3-sbeller@google.com> (Stefan Beller's
        message of "Mon, 16 Apr 2018 15:09:55 -0700")
Message-ID: <xmqqbmeiv7c2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems that this

$ git -c color.blame.repeatedlines=cyan blame --heated-lines builtin/blame.c

refuses to run.

Would it work if the configuration is in .git/config instead, or
would it forever disable --heated-lines once somebody choses to use
--color-lines feature by default by configuring it in?
