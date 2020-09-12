Return-Path: <SRS0=gF6X=CV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E76C433E2
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 20:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16D0F2087C
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 20:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgILUvo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Sep 2020 16:51:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58456 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725880AbgILUvm (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 Sep 2020 16:51:42 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BC48060489;
        Sat, 12 Sep 2020 20:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1599943901;
        bh=O8HiUP9HEDnyH75zhN3KrLAeLe0e9ZIXkX2rRiiZb5o=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QQbKEOJVmIxPjiTBls6/M2lB2mPMo2mUKJo2MdFwMlsiP5EkV+h0mgwk9UFxRPLcv
         1QkF2xeKVltAlcIYNkHv3UjxgNduwHGsTgDK7DaTaoKAGf/eQBtdvCXdbvYsl9Twmk
         QJba7YdS2a7njIJ/EG4l4XTRN5maYXVeSuX87R+5DLryTY7qqAPtT1MQUbZM07AE2Z
         9g3LdsA7mQF/kHU9rWu9Y9tSgS34NL8Oe9+EF66n4xNnC57vONR93wfSvawgViNTjA
         wQJlS/srcxqgO23J90vc/yO1mXpbXSnz3tdPZnyiyWpgt2D7rQFMrjwmsWpl/1xftf
         jW/2anvtUFHE1lmj/zmX3HmcIo1yJsppGbJUPFmNNtzefiCO64VozVGesKohkOLT+Z
         +E4t2nCqlcYTVwFBmWKA/MWBwAcWpeMdzFVR58aJ/oUoEqspixauFGGWbJMsE/NMiU
         ZMxJYbT0HiWcNtt/Bkowk9SUFfUXF43hyy5IZpEq5UCEuHWRII0
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH 0/3] FAQ entries for merges and modified files
Date:   Sat, 12 Sep 2020 20:48:21 +0000
Message-Id: <20200912204824.2824106-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series introduces a few new FAQ entries on various topics.

The first describes why squash merging doesn't work for long-running
branches.  This is confusing for a lot of folks, including some pretty
advanced developers, so it seems worth documenting.

The second explains why reverts are not applied on merge if the change
has been cherry-picked to both sides.  We have documentation on this
already in git-merge(1), but here we also advise using a rebase instead.
I still see folks confused by this, so hopefully making it a little more
visible (with a little more explanation) will be helpful.

The third departs from the topic of merges to discuss modified files.  I
frequently see folks with perpetually modified files for one of two
reasons: case-sensitivity problems and problems where someone failed to
run the smudge or clean filter.  In fact, we saw one of those problems
recently on the list.  The FAQ entry explains how to handle both
situations and provides suggestions to prevent the former from happening
again.

I've answered all of these questions recently (some multiple times), so
I figured I'd document this so that folks can hopefully discover more of
this themselves and solve their problems more quickly.

brian m. carlson (3):
  docs: explain why squash merges are broken with long-running branches
  docs: explain why reverts are not always applied on merge
  docs: explain how to deal with files that are always modified

 Documentation/gitfaq.txt | 85 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

