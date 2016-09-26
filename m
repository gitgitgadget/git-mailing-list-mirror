Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,URI_HEX shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B5FF207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 19:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966560AbcIZTc7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 15:32:59 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:57459 "EHLO
        homiemail-a19.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966506AbcIZTc6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Sep 2016 15:32:58 -0400
Received: from homiemail-a19.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a19.g.dreamhost.com (Postfix) with ESMTP id 9D4A2604076;
        Mon, 26 Sep 2016 12:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=from:to:cc
        :subject:date:message-id; s=novalis.org; bh=9ldfWcdRVA1ek8mxYyhe
        3yK4x4g=; b=kzkdKCPoiuexnaZ7EX41x3G1hpttGT1LDWyTybUtOjrIEuyEqXwU
        ABN5XvUNZjaNb1/LA+7YSQ7nPq/tIeioTvV0QX/PJfPjtMbriW3zIHotvYFblUh+
        j+gVvS2qAkXhP2UTUkVR7Ne7xyfShRjWoZNa5f/qLIDZ82i14Ax5ikc=
Received: from localhost.localdomain (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a19.g.dreamhost.com (Postfix) with ESMTPSA id 1EDE1604061;
        Mon, 26 Sep 2016 12:32:57 -0700 (PDT)
From:   David Turner <novalis@novalis.org>
To:     git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu
Cc:     David Turner <novalis@novalis.org>
Subject: [PATCH 0/2] tree-walk improvements
Date:   Mon, 26 Sep 2016 15:32:43 -0400
Message-Id: <1474918365-10937-1-git-send-email-novalis@novalis.org>
X-Mailer: git-send-email 2.8.0.rc4.22.g8ae061a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first patch is a re-roll of Peff's patch from 2014 -- here's
the archive message:

http://git.661346.n2.nabble.com/PATCH-tree-walk-be-more-specific-about-corrupt-tree-errors-td7603558.html

Not sure why this wasn't applied then, but I thought it looked pretty
good, so I added a few tests.

Hopefully the encoding works correctly on these patches. If not, you
can fetch from
https://github.com/novalis/git/
on branch dturner/bad-trees

Email address note 1: my employer wants me to use my company address,
but not my company computer, for patches I write on work time.  This
means that I'm going to continue corresponding from
novalis@novalis.org, but will send patches with the @twosigma.com
address in the author line.

Email address note 2: I'm not subscribed to the mailing list these
days, so please CC me (at novalis@novalis.org) on replies.

David Turner (1):
  fsck: handle bad trees like other errors

Jeff King (1):
  tree-walk: be more specific about corrupt tree errors

 fsck.c                                             |  18 +++--
 t/t1007-hash-object.sh                             |  15 +++-
 t/t1007/tree-with-empty-filename                   | Bin 0 -> 28 bytes
 t/t1007/tree-with-malformed-mode                   | Bin 0 -> 39 bytes
 t/t1450-fsck.sh                                    |  17 ++++-
 .../307e300745b82417cc1a903f875c7d22e45ef907       |   4 +
 .../f506a346749bb96f52d8605ffba9fb93d46b5ffd       | Bin 0 -> 45 bytes
 tree-walk.c                                        |  83 ++++++++++++++++++---
 tree-walk.h                                        |   8 ++
 9 files changed, 125 insertions(+), 20 deletions(-)
 create mode 100644 t/t1007/tree-with-empty-filename
 create mode 100644 t/t1007/tree-with-malformed-mode
 create mode 100644 t/t1450/bad-objects/307e300745b82417cc1a903f875c7d22e45ef907
 create mode 100644 t/t1450/bad-objects/f506a346749bb96f52d8605ffba9fb93d46b5ffd

-- 
2.8.0.rc4.22.g8ae061a

