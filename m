Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A06AA1F462
	for <e@80x24.org>; Mon, 17 Jun 2019 19:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfFQTNe (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 15:13:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38704 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbfFQTNd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 15:13:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so555267wmj.3
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 12:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z5JoGXWJOh+UZGiVSm+R4q/fxsazshdqPYugjeEVh4s=;
        b=R8DmgAhD+V90Ae1glSXyowWUgwGoBgMuf4ZUeFma0VRj2rzDn5tImvgCEWmXaQuDL8
         xTxMc5agDtsngspwXizyUnadzisiTTcI+iN5pDspFsR3eqxGGcUt+b2QChdm+cYyDg6c
         4IrkeFTDU4z/x/B0eseNXSMtQn/oPsFdj7fKHGq/2pbjIwA68LHbSkcN/dgM67eIr82z
         ddWS7Ax0lvRpqQR2ijxrERwZPuKI82CuIeoHKai4NJi9xqRLifxAA4ik39nTa56ZJax1
         /v7VWzfoF6C93kvaYgBiRxxtHPndnT+vGyDm6NMwBOBKZVg17vb0pK5rPDXT6X2U6B5i
         B58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z5JoGXWJOh+UZGiVSm+R4q/fxsazshdqPYugjeEVh4s=;
        b=rreRni4kDnhCFDU50u9+MkH66rqqRLE3HBw6MVoPMGKV0nx/Rfkbp1Nd/y2F/8qLRQ
         3WVl7etEFLF5oCaLHj0uYVo+ngy6qvbE5BSo7FW1i/AgBsRLUvlPLw5CU24v4qb4UQOI
         0afFkEaI46dbAgO80+jm94zVCssUj0Xq3Vp9sjp77ODE7atQUTL4H3ovVLpQyCPVHNZh
         r3mibTp0pwUSDqX+K6BPxa1o2asmkm6MRFGpc8TRjX2Io38EDmiL/A58UreV071LDL1Q
         ciyPw9TmtCuPSHLe0N0EuWHdBdtLauC7eXnAslAwRe7bDxh8OdEZj2X4/VJYB7rROqef
         nfZQ==
X-Gm-Message-State: APjAAAXpEBQWI44f0NMGI/IDZ03sPRy4QEivDzNUQ7btNT1md9e5KuVR
        Hbbjh+LE6Q9TPr+h3od19WY=
X-Google-Smtp-Source: APXvYqyZQUVQvumofmxhaOa+cegAYW6e2lFaX8OsQM7CS0E0nxw/accphOxpCO3RCHtSUdnK8LYPyA==
X-Received: by 2002:a1c:2d5:: with SMTP id 204mr104665wmc.175.1560798812050;
        Mon, 17 Jun 2019 12:13:32 -0700 (PDT)
Received: from szeder.dev (x4db66496.dyn.telefonica.de. [77.182.100.150])
        by smtp.gmail.com with ESMTPSA id r2sm269040wma.26.2019.06.17.12.13.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 12:13:31 -0700 (PDT)
Date:   Mon, 17 Jun 2019 21:13:28 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matthieu Moy <Matthieu.Moy@imag.fr>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rebase: fix garbled progress display with '-x'
Message-ID: <20190617191328.GL31952@szeder.dev>
References: <20190430142556.20921-1-szeder.dev@gmail.com>
 <20190611130320.18499-1-szeder.dev@gmail.com>
 <20190611130320.18499-4-szeder.dev@gmail.com>
 <xmqq36kflv0f.fsf@gitster-ct.c.googlers.com>
 <20190611211151.GG4012@szeder.dev>
 <nycvar.QRO.7.76.6.1906122056570.789@QRFXGBC-DHN364S.ybpnyqbznva>
 <20190612194106.GJ4012@szeder.dev>
 <nycvar.QRO.7.76.6.1906141356140.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1906141356140.44@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 14, 2019 at 08:42:29PM +0200, Johannes Schindelin wrote:

> The `SHELL` thing here is important, as t/t3404-rebase-interactive.sh sets
> this to the empty value explicitly:
> 
> https://github.com/git/git/blob/v2.22.0/t/t3404-rebase-interactive.sh#L63-L68

Hmm, hang on for a sec.  Why does it set SHELL to empty?

So t3404 sets SHELL to the empty value since cd035b1cef
(rebase -i: add exec command to launch a shell command, 2010-08-10),
and the in-test comment highlighted on the above link says:

  # "exec" commands are run with the user shell by default, but this may
  # be non-POSIX. For example, if SHELL=zsh then ">file" doesn't work
  # to create a file. Unsetting SHELL avoids such non-portable behavior
  # in tests. It must be exported for it to take effect where needed.
  SHELL=

Furthermore, the corresponding documentation added in cd035b1cef
says the following:

  The "exec" command launches the command in a shell (the one specified
  in `$SHELL`, or the default shell if `$SHELL` is not set)

IOW if SHELL is not set/empty, then it will run the default '/bin/sh',
but who knows what it might be, there's no guarantee that it's a sane
POSIX shell.  That's why we have "Define SHELL_PATH to a POSIX shell
if your /bin/sh is broken." very near to the top of our Makefile.

So while setting SHELL to the empty value might indeed avoid
non-portable behavior when the user in general prefers a non-POSIX
shell, it wouldn't help if '/bin/sh' is broken.  For that it should be
set to $SHELL_PATH (or perhaps $TEST_SHELL_PATH nowadays...).

Though cd035b1cef is now close to 9 years old, plenty of time for
somebody to run into this issue in the wild and speak up...

