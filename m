Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63D4D1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 19:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbeGJTqs (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 15:46:48 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:56316 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732205AbeGJTqr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 15:46:47 -0400
Received: from homiemail-a21.g.dreamhost.com (sub3.mail.dreamhost.com [69.163.253.7])
        by hapkido.dreamhost.com (Postfix) with ESMTP id 99DC68A9E9
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 12:46:16 -0700 (PDT)
Received: from homiemail-a21.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a21.g.dreamhost.com (Postfix) with ESMTP id 189E91C0065
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 12:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:date:content-type:mime-version:
        content-transfer-encoding; s=novalis.org; bh=fP1EC315hpcXMroUAQl
        h2IzljwU=; b=V4qYquGwlcxsFiUYwy0om8PanGbCsFn/xjco8/UJLTsVr/IyxIc
        qOvAgJAyovaH9+cYhJJ/LptiaCV22aIJv6b4QP1PKJlvPTIcrQ06/4Q7gSqyyVI8
        xAbKTCEW2IHlHn58vsU0XDj4g0ViOCp5PDwbFdHSGybyRs13Pr4CkPHU=
Received: from corey (unknown [38.27.161.17])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a21.g.dreamhost.com (Postfix) with ESMTPSA id CDFD11C0064
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 12:46:15 -0700 (PDT)
Message-ID: <1531251974.28120.90.camel@novalis.org>
Subject: git log --shortstat doesn't respect -c (but --stat does)
From:   David Turner <novalis@novalis.org>
To:     Git Mailing List <git@vger.kernel.org>
Date:   Tue, 10 Jul 2018 15:46:14 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This seems inconsistent:

$ git log --oneline --stat 91ccfb85176 -c
91ccfb8517 Merge branch 'sb/diff-color-move'

 diff.c                     | 28 +++++++++++++++-------------
 t/t4015-diff-whitespace.sh |  9 +++++++++
 2 files changed, 24 insertions(+), 13 deletions(-)
d1114d87c7 Merge branch 'js/rebase-i-final'

 sequencer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
...

$ git log --oneline --shortstat 91ccfb85176 -c
91ccfb8517 Merge branch 'sb/diff-color-move'

d1114d87c7 Merge branch 'js/rebase-i-final'

4339c9f2df Merge branch 'jc/doc-checkout'
...

Especially since the manual for log -- shortstat says:

--shortstat
   Output only the last line of the --stat format containing total
   number of modified files, as well as number of added and deleted
   lines.

