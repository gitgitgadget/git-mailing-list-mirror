Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC30820373
	for <e@80x24.org>; Tue, 14 Mar 2017 02:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbdCNCFE (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 22:05:04 -0400
Received: from gateway-a.fh-trier.de ([143.93.54.181]:56577 "EHLO
        gateway-a.fh-trier.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752282AbdCNCFD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 22:05:03 -0400
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Mar 2017 22:05:03 EDT
X-Virus-Scanned: by Amavisd-new + McAfee uvscan + ClamAV [Rechenzentrum
        Hochschule Trier (RZ/HT)]
Received: from localhost (ip5f5bdecf.dynamic.kabel-deutschland.de [95.91.222.207])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: politza)
        by gateway-a.fh-trier.de (Postfix) with ESMTPSA id B9CB4179ABF1
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 02:58:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=simple/simple; d=hochschule-trier.de;
        s=default; t=1489456715; bh=oR9pzOwA0yPLSfqvCxmVPBvOjuY=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=QIh3xDJuOdtZpgrEFp19XoVBnFvnJUWg3UgUkJFZOGWyvtDG3AVDBMzx+fL8Jz1s1
         k5kxi/Q7AfT7JT1tba/e8DuFDdyYKK78WqsyIer5YF5Za8WgK3A55Qv74MEbZdj6p0
         IpQ75Dvb7UTTrUK7eyFP3niKjg9e5ZjjM09sMwok=
From:   Andreas Politz <politza@hochschule-trier.de>
To:     git@vger.kernel.org
Subject: git checkout exit value and post-commit hooks
Date:   Tue, 14 Mar 2017 02:58:35 +0100
Message-ID: <87y3w8k4ac.fsf@luca>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi,

the exit value of a `git checkout' seems to depend on the exit values of
the hooks it runs. This breaks for example `git bisect', as seen in the
following example.

$ mkdir gitbug
$ cd gitbug
$ git init
$ ln -s /bin/false .git/hooks/post-commit
$ git bisect start
$ git bisect reset
fatal: invalid reference: master
Could not check out original HEAD 'master'.
Try 'git bisect reset <commit>'.

-ap
