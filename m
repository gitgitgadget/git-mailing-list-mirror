Return-Path: <SRS0=e9fP=54=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11883C2BB85
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 22:12:40 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1866206E9
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 22:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hFbfyVQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1866206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=git-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgDLWMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 18:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbgDLWMS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 18:12:18 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537BEC0A88B5
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 15:12:18 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5FDF55A366;
        Sun, 12 Apr 2020 18:12:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9UbhVA9yJyrj08isQhexhsk+zUw=; b=hFbfyV
        Q39aK8ez5G8ujegd8tB68mCQtqzI8Jxhs5iS9S0pfZTTn4QlJH15FVNoYIOvY1VH
        il/bSOwkqCUaUu8VS5PBLw3/iYdTQ1KqGELOslQtzJWBrOdzgLE4gTqLmD3SvqZK
        +bYP9q+N2i7XLpkD1GapiwV2OyGPxj709t5pA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jbhJSVasx+/9xJ7MWAswF9b4GVqTPOdq
        BoP9D2FXqjsfA2jbGImVR6jEp1+2e+0EVDYxez8DL8H9By0gwXo35Wozl5W3ueG/
        +v28VjHQeqwLAePiyONi+8CYPgpMKM8QojSS4V0dqsdlm3e5onReZtkNWm+0pEUO
        xh6FGrdv1Os=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 57B915A365;
        Sun, 12 Apr 2020 18:12:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DBB135A364;
        Sun, 12 Apr 2020 18:12:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/5] ci/lib: allow running in GitHub Actions
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
        <d9227c87a7bb2872f6a69f48f6a4988f08545d8a.1585658913.git.gitgitgadget@gmail.com>
        <20200403084654.GK2224@szeder.dev>
        <nycvar.QRO.7.76.6.2004042207410.46@tvgsbejvaqbjf.bet>
        <20200410153131.GM2224@szeder.dev>
        <xmqq7dynjgx7.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2004122339290.46@tvgsbejvaqbjf.bet>
Date:   Sun, 12 Apr 2020 15:12:16 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2004122339290.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sun, 12 Apr 2020 23:42:21 +0200 (CEST)")
Message-ID: <xmqqimi4cq0v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB87FCDE-7D0A-11EA-AA3B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> As to the "It works as expected", this is in a Bash:
>
> 	$ test "$CI_OS_NAME" = macos && CI_OS_NAME=osx
>
> 	$ echo $?
> 	1
>
> Yes, it works, but in the common case, it exits with an error (that we
> ignore, unless run with `sh -e ...`).
>
> Just making sure that we're talking about the same expectation here.

My expectation is that "set -e" won't prevent anything that comes
after "make sure we set CI_OS_NAME to osx on macos but do not do so
on other platforms" we see above from running.  In other words, with
a script like this:

    $ cat >X <<\EOF
    #!/bin/sh
    set -x -e
    CI_OS_NAME=linux

    echo different
    test "$CI_OS_NAME" = macos && CI_OS_NAME=OSX

    CI_OS_NAME=macos
    echo same
    test "$CI_OS_NAME" = macos && CI_OS_NAME=OSX

    echo both passed

    false

    echo at the very end
    EOF

I would expect all "echo" would execute, except for the last one
that is not reached because of the "false", which is the first
"2.9.3 list" whose last "2.9.2 pipeline"[*1*] yields a non-zero
status, would stop the execution.  Two 'test' before && may yield
success or failure and they may control whether the assignment to
CI_OS_NAME is done or skipped, but I expect that they do not affect
how "set -e" behaves.

    $ bash X
    + CI_OS_NAME=linux
    + echo different
    different
    + test linux = macos
    + CI_OS_NAME=macos
    + echo same
    same
    + test macos = macos
    + CI_OS_NAME=OSX
    + echo both passed
    both passed
    + false

    $ dash X
    + CI_OS_NAME=linux
    + echo different
    different
    + test linux = macos
    + CI_OS_NAME=macos
    + echo same
    same
    + test macos = macos
    + CI_OS_NAME=OSX
    + echo both passed
    both passed
    + false


[Footnote]

*1* these two words are from the shell grammar
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09
