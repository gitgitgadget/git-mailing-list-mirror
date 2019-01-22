Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4E721F453
	for <e@80x24.org>; Tue, 22 Jan 2019 18:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfAVSmq (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 13:42:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45289 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfAVSmq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 13:42:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so28542141wrr.12
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 10:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=f23gWvuQvSqyIc/g4L9k0b/DyBB+x8T30M+vGJOa+QY=;
        b=fitiuXx3tBGpkt7WkFIG9U44N0lVOC1fu4jSAyHQesUf0hk9nuOCSqe7ykAVKX5w7K
         r9ykyCaVag8d98j1Ukgkk2kuhZeWNjE0ZQc5yrit2eZBoEbZQIl6SjYpuIoYwDMWBctW
         O/joQyYQSdng7ZeodxRPQ+JtOu9heA/1aED2VRQeNLSzFwxmdZqgieikdzqVdsY0HkeE
         Q86mkOHCMMDuBtlupb2ofdRG35VwTCkGmKuN9UbN2uXf1WCwnlHeGziDBVacDQVsU4iO
         dcpvyzjdpCY3uTKk2qTNw/2N0r5cqFicn6MESQnggO2S1r/i5BIeTB0IBaGuKL6CbCH7
         h9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=f23gWvuQvSqyIc/g4L9k0b/DyBB+x8T30M+vGJOa+QY=;
        b=SrZZ3v0Jdc+VvH7N/5Cn39nvuAzz+LnTPuHFfzUac1C9pYrTGaAYIfxaQST9IXeWEo
         WNYQ1hX/Ghl1ZB5Bz0COBpeVCNdY6K3pjsig8LYnwN7Xx/X6XsuxJ13IRj48+AO4v+8V
         5qqyMjo+7stpcwGd3qQcmvWlbX46R5ExX7ZAG1xkD9QGjBqMybz0abyRx3itx/fs3BMn
         NVEZbdNjmGfszLqdVBW7dDcHHlBMN8BzWAVpPgymQK3rBQv+edfAe4PIdS9tTYz0nLJc
         Mdzdlmlm6452qlARAj358O3r0slVqEp2cml+XPwcbAZa26FDo5NqlOSrRIz+EoLFDuMt
         IesQ==
X-Gm-Message-State: AJcUukdPvx7dMQaarTLvI6MYFxXUS6veJ0C+QfjmUIqviopuZ41DbT8u
        d0G1uhgarzIabCEAkuEkulk=
X-Google-Smtp-Source: ALg8bN5FL9LrFwo1QYfGQSL+4Z3SfCmPtZbibuaFG+kx3q++x/Q/YM9FKxUQYEJJWq2frVOOWZ3ncA==
X-Received: by 2002:adf:b190:: with SMTP id q16mr33983075wra.95.1548182564418;
        Tue, 22 Jan 2019 10:42:44 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t70sm84027860wmd.36.2019.01.22.10.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 10:42:43 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        asottile@umich.edu, benpeart@microsoft.com, pclouds@gmail.com
Subject: Re: [PATCH v2 2/2] checkout: fix regression in checkout -b on intitial checkout
References: <20190118185558.17688-1-peartben@gmail.com>
        <20190121195008.8700-1-peartben@gmail.com>
        <20190121195008.8700-3-peartben@gmail.com>
        <nycvar.QRO.7.76.6.1901221529210.41@tvgsbejvaqbjf.bet>
Date:   Tue, 22 Jan 2019 10:42:43 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1901221529210.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 22 Jan 2019 15:35:21 +0100 (STD)")
Message-ID: <xmqq8szch6u4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I also looked at the implementation of `file_exists()` and found that it
> uses `lstat()`. Peff, you introduced this (using `stat()`) in c91f0d92efb3
> (git-commit.sh: convert run_status to a C builtin, 2006-09-08), could you
> enlighten me why you chose `stat()` over `access()` (the latter seems more
> light-weight to me)? Also, Junio, you changed it to use `lstat()` in
> a50f9fc5feb0 (file_exists(): dangling symlinks do exist, 2007-11-18), do
> you think we can/should use `access()` instead?

Given that the whole point of a50f9fc5 ("file_exists(): dangling
symlinks do exist", 2007-11-18) is to make sure that we say "it
exists" for a symbolic link that does not point anywhere, and that
access(2) dereferences a symbolic link, changing it to use access(2)
would change the meaning of the file_exists() function.  So I do not
think we _should_ use access(2).

I however do not know if we _can_ use access(2).  It takes auditing
the current callers and see if they truly care about knowing that a
dangling symbolic link exists to determine if it is safe to do so.
If none of them does, and if we do not have an immediate plan to add
a new one that does, then we obviously can use it, but even in that
case we'd need a comment in *.h to warn about it.

