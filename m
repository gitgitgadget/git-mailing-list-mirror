Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3869D1FAE2
	for <e@80x24.org>; Tue, 20 Feb 2018 18:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752444AbeBTSAI (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 13:00:08 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42700 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeBTSAH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 13:00:07 -0500
Received: by mail-wr0-f194.google.com with SMTP id k9so16898883wre.9
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 10:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Q1LF+RZ0AUOnc6/PYVQMb5OsOo5AjMzAsFQXs/0PYw4=;
        b=WKDYOWcpdPFFsHe47FZ4O3gcEG3ytpEtMC5B1XQKAn+xei4CikOq8i456bls65Eq6d
         S9SMK+QF+/uSgCyJMeC9AeLT/ivNIzro4abkKi+uZne3nMny/Sz2jlbFcWwDJQdIgRiA
         OF+tbWTuB8e40GDILWE1GhMBSkBoD2oqr6/WfdvoQ3+yTAqsTc5Lyd/F82uRDyyM1ex9
         NcJ9xpK2c6i/oU6Oh9FuNNHv4Fj62iKCo161N3DTJD6e7jkcBiVwYTGksQnXzQqsARPO
         U5azK+ewbGXzGTP1GeGM4hOolSQObf9UPWxxVP64z7lIJ463NnRrunmqWBrHXjrwAplh
         IwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Q1LF+RZ0AUOnc6/PYVQMb5OsOo5AjMzAsFQXs/0PYw4=;
        b=D+C8O3po4MTKB4ACpDuq6/G8uret/CEGTgqYUiBY+kW7DkWJKkRjL/lwy1VMCeo8gC
         EwxsVY9Jlt7Y7ZtDDgkBfHXkVDhulKe6jsCW1mxUoJQND1HiIUuGjHGHw9lFDGwFL9oY
         VBoc3+8S1GxH4dBNb7aDFVB/5pt2HdSb1Yu3voalewufCUySB4UHKO7P03RyTbw2Hn0g
         ZVbHvoFFs5CUfbOeFBKDCVFjIBL1bOQ762j4ua4m0E+UEE7wB5GckhDQotO+nrpeHd3l
         /+rrN2Pbifv/fqR3lj5hCHQSTpPwx/YnarzQVqwM323xmum7M7gpRVaeODe8Y95uCeX0
         hPow==
X-Gm-Message-State: APf1xPDuYVv3pICF2fnH8NTEsaan5aSYtea1xAd6wB90dzx/015+QIMn
        gQp0bKxDCihhi4zP2S/iNiU=
X-Google-Smtp-Source: AH8x227urVnkULGzb38ROwpu1/+XYOTSOhV6H6FPuBLgeBtA1mI33ioEkQLyNRDe8GT277obzMsfKA==
X-Received: by 10.223.160.56 with SMTP id k53mr439587wrk.5.1519149605656;
        Tue, 20 Feb 2018 10:00:05 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o16sm11391343wro.55.2018.02.20.10.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 10:00:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Gustavo Chaves <gustavo@gnustavo.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Why git-revert doesn't invoke the pre-commit and the commit-msg hooks?
References: <CAPx58qqv84+i0JbdsVzFqWB=bRDecWHxss8frD4=nWOsFj-NPg@mail.gmail.com>
        <CAPx58qoS-J+yJ_J4QOOnKyG=EOrT5J=UoCrXfXxEijq4Z2Z_3w@mail.gmail.com>
        <7ff6079d-5834-3bbd-781b-a2fc0659e7e5@talktalk.net>
Date:   Tue, 20 Feb 2018 10:00:03 -0800
In-Reply-To: <7ff6079d-5834-3bbd-781b-a2fc0659e7e5@talktalk.net> (Phillip
        Wood's message of "Tue, 20 Feb 2018 10:28:55 +0000")
Message-ID: <xmqqfu5v4k4c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> ... I'm worried though that
> someone out there is scripting with a non-interactive editor which may
> break if we start verifying the message ...

This is a very valid concern.  Making sure that 'revert' pays
attention to the --verify option when given from the command line,
without changing the default or anything else, would satisfy
everybody's wish, I would think.  It won't bother existing users,
and in addition will now give an option to people to selectively run
pre-whatever hook when they choose to.

I am not sure if we should be running pre-commit/commit-msg for
revert.  The message and the effect of revert is quite distinct from
the ordinary commit, and it is very likely that people would want to
treat them differently.  It would make more sense (if we were to add
an option to run any hook we currently do not run to the command) to
run pre-revert/revert-msg hooks instead, and then people who happen
to want to do the same thing in these hooks what they do for
ordinary commits can just call their pre-commit/commit-msg hooks
from there, perhaps.
