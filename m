Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1504520248
	for <e@80x24.org>; Thu, 14 Mar 2019 02:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfCNCfZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 22:35:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50753 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfCNCfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 22:35:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id x7so1282742wmj.0
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 19:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=PKvtTa73z5xkb02pp5h0imtq7AVe9JC1txSrZnzPhv4=;
        b=Utmix/SocXIrL+jOVS5pCqaAM7L/3Ya0jg1oI+Jfby/vC+NNoUvnk1GIxPRzG+bhzZ
         p3pFwVZNIXNURCoLcW/MWyZgbA9gvLxqC90O0ZOd5jkU5OLY/j03z0RMtF4XCSYWQ0dE
         SzqYQjLntxW5bfpgZmP6o/yHePBSUVIhnxL2tiR2d1jLgG0HDbuLSinlJtB9q7laGo4E
         6TRvf58UC+IWeNmVP/ar0I1IP8G+6G5bwPCqV6sTknil88cNPcegi61PE28aELGwTVxv
         xFQvMe8scV3F1bgJymqLPXZa4gtLJEWpUtGvyknIFGpj2YFgNImmzkblrPfZShC3wAKJ
         3twA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=PKvtTa73z5xkb02pp5h0imtq7AVe9JC1txSrZnzPhv4=;
        b=tauEn/+jRV+Fg/myjxFEtLmG3OuWgKoH659qQJG8n0R1m+D5IjytN2/zdSj3eGRxnP
         b26zrywKUzBBfKVyexe+rvH7O7eF3SZT3NWYoZZuLSZqv5vrmHS0q1/xlwNlxAs9ui4g
         jQpblHouMy9v+pcw7dqmr6SkQ65/fV87K6KzSlSP4ZEcA6GnrMsZRZ/mdwt/zANv+LlD
         TEREYNIYMybtf5oHPO/X5/zWxWwBEgR/L8ic4fRUwf5iiNNFhcxb/aqtL0lZlzBg39op
         dgM5d3upwr+qOAVU/kGKtM1jC4XiIBFUQ+QfpYlg23Xcq4rDc+nMjpDb5Kw39UqaiMI7
         TOaw==
X-Gm-Message-State: APjAAAX7bj5SHqgjpdmY7U3K80BlDyYD6JFXRc/b4E3Ft7Q8zvCZ8yRy
        v3yKQT21X6OxUuad3SdcsBnXoSDzZGQ=
X-Google-Smtp-Source: APXvYqzGsdNsoJ/xEAIyGTmaUPnJicYnGqhnT66dQ6V5Bo71lJCnOHlPMX6vkSObh7/ABmwuHDKbTw==
X-Received: by 2002:a1c:700e:: with SMTP id l14mr99840wmc.132.1552530923144;
        Wed, 13 Mar 2019 19:35:23 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z14sm10954683wrh.29.2019.03.13.19.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 19:35:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 02/11] t/lib-git-daemon: make sure to kill the 'git-daemon' process
References: <20190313122419.2210-1-szeder.dev@gmail.com>
        <20190313122419.2210-3-szeder.dev@gmail.com>
Date:   Thu, 14 Mar 2019 11:35:22 +0900
In-Reply-To: <20190313122419.2210-3-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Wed, 13 Mar 2019 13:24:10 +0100")
Message-ID: <xmqqpnqub2tx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> After 'start_git_daemon' starts 'git daemon' (note the space in the
> middle) in the background, it saves the background process' PID, so
> the daemon can be stopped at the end of the test script.  However,
> 'git-daemon' is not a builtin but a dashed external command, which
> means that the dashless 'git daemon' executes the dashed 'git-daemon'
> command, and, consequently, the PID recorded is not the PID of the
> "real" daemon process, but that of the main 'git' wrapper.

Hmph.  execv_dashed_external() does not quite execv() but uses
run_command() and waits, which is the source of this issue.  It
feels almost possible to work it around by actually exec'ing,
though.

	/*
	 * If we fail because the command is not found, it is
	 * OK to return. Otherwise, we just pass along the status code,
	 * or our usual generic code if we were not even able to exec
	 * the program.
	 */
	status = run_command(&cmd);
	if (status >= 0)
		exit(status);
	else if (errno != ENOENT)
		exit(128);

would become

	... prepare args from cmd ...
	execv(...);
	if (errno != ENOENT)
		exit(128);

and if exec succeeds, the whole process will exit with the status of
dashed command, failing to exec for reasons other than ENOENT will
exit with 128 and ENOENT will continue returning.

> Now, if a
> test script involving 'git daemon' is interrupted by ctrl-C, then only
> the main 'git' process is stopped, but the real daemon process tends
> to survive somehow, and keeps on running in the background
> indefinitely, keeping the daemon's port to itself, and thus preventing
> subsequent runs of the same test script.
>
> Work this around by running 'git daemon' with the '--pidfile=...'
> option to save the PID of the real daemon process, and kill that
> process in 'stop_git_daemon' as well.

OK, so for the purpose of waiting and monitoring, we still use the
pid of the git potty that is running and waiting for the daemon, but
we'll send another signal to kill the daemon off.  Makes sense.
