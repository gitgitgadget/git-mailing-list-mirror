Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD4611F453
	for <e@80x24.org>; Fri,  3 May 2019 15:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfECPKU (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 11:10:20 -0400
Received: from forward104j.mail.yandex.net ([5.45.198.247]:52265 "EHLO
        forward104j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726514AbfECPKU (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 May 2019 11:10:20 -0400
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 May 2019 11:10:19 EDT
Received: from mxback4j.mail.yandex.net (mxback4j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10d])
        by forward104j.mail.yandex.net (Yandex) with ESMTP id 22F3C4A19AC
        for <git@vger.kernel.org>; Fri,  3 May 2019 18:04:18 +0300 (MSK)
Received: from smtp4j.mail.yandex.net (smtp4j.mail.yandex.net [2a02:6b8:0:1619::15:6])
        by mxback4j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 14VZZQy1U2-4Im8c932;
        Fri, 03 May 2019 18:04:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1556895858;
        bh=kDFs6aOZaY1TrWCJznU0RWNPxuAcZymRri7E32psAdU=;
        h=To:Subject:From:Date:Message-Id;
        b=fJhw8DcjQ7T4ypplAefOPuJZ066dOEgGYnQXCIXjDm4eI6D4Ol2IlA+JFGqHq1gkO
         sCxmGblrpHSzTE08IOwsrLpVwZnwq7DoapP7f7y1zbxK1SZTiKYMVhH/TlyJYdE1+F
         YbX5LgTqDONER5FMUrCQGNcigCyukI6oVMA915/4=
Authentication-Results: mxback4j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by smtp4j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id RC8LxzeoeU-4HeSZ0t2;
        Fri, 03 May 2019 18:04:17 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Fri, 03 May 2019 18:04:15 +0300
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
Subject: [RFE] Allow for "interactive"-like actions in non-interactive rebase
To:     Git List <git@vger.kernel.org>
Message-Id: <1556895855.30374.0@yandex.ru>
X-Mailer: geary/emphasize-participated-in~g736c62cb
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Interactive rebase (i.e. for example "git rebase -i HEAD~10") is used=20
most often to apply an action to a single commit, e.g. "rename",=20
"edit", "fixup", etc=85

As result, people keep coming up with custom scripts and aliases for=20
every distinct action.

Instead, it would be nice to have native support in git to start=20
"rebase" for a given commit, and pass the "interactive action" to use=20
on that commit. Examples:

$ git rebase -i HEAD~10 --action edit
$ git rebase -i HEAD~10 --action rename
$ git rebase -i HEAD~10 --action fixup

=

