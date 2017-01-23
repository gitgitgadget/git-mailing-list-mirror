Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A620B20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 13:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750718AbdAWNM6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 08:12:58 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:40562 "EHLO mx0.elegosoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750761AbdAWNM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 08:12:57 -0500
Received: from localhost (x4e3406a1.dyn.telefonica.de [78.52.6.161])
        by mx0.elegosoft.com (Postfix) with ESMTPSA id EF9F616C831;
        Mon, 23 Jan 2017 14:06:52 +0100 (CET)
From:   Patrick Steinhardt <patrick.steinhardt@elego.de>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>,
        Patrick Steinhardt <patrick.steinhardt@elego.de>
Subject: [PATCH v1 0/2] urlmatch: allow regexp-based matches
Date:   Mon, 23 Jan 2017 14:06:33 +0100
Message-Id: <20170123130635.29577-1-patrick.steinhardt@elego.de>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Short disclaimer: this patch results from work for a client at my
day job at elego Software Solutions GmbH. As such, I'm using my
work mail address and added a new mailmap entry. I wasn't exactly
certain if the mailmap entry should've been created in a separate
commit series, as it has nothing to do with the actual topic --
I can re-send it separately if requested.

This patch is mostly a request for comments. The use case is to
be able to configure an HTTP proxy for all subdomains of a
certain domain where there are hundreds of subdomains. The most
flexible way I could imagine was by using regular expressions for
the matching, which is how I implemented it for now. So users can
now create a configuration key like
`http.?http://.*\\.example\\.com.*` to apply settings for all
subdomains of `example.com`.

I tried to make this feature as backwards-compatible as it can be
by having the '?' prefix. Older clients will barf when trying to
normalize the URL as '?' is not in the set of allowed characters
for a URL, and for newer clients there will be no change in
behavior for previously configured `http.<url>.*` keys.

Regards
Patrick Steinhardt

Patrick Steinhardt (2):
  mailmap: add Patrick Steinhardt's work address
  urlmatch: allow regex-based URL matching

 .mailmap                 |  1 +
 Documentation/config.txt |  6 ++++-
 t/t1300-repo-config.sh   | 31 ++++++++++++++++++++++++++
 urlmatch.c               | 57 ++++++++++++++++++++++++++++++++++++++----------
 4 files changed, 82 insertions(+), 13 deletions(-)

-- 
2.11.0

