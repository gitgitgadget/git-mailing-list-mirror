Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12B9C1F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 21:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfJYV5S (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 17:57:18 -0400
Received: from zinan.dashjr.org ([192.3.11.21]:37102 "EHLO zinan.dashjr.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfJYV5R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 17:57:17 -0400
X-Greylist: delayed 468 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Oct 2019 17:57:17 EDT
Received: from [2001:470:5:265:a45d:823b:2d27:961c] (unknown [IPv6:2001:470:5:265:a45d:823b:2d27:961c])
        (Authenticated sender: luke-jr)
        by zinan.dashjr.org (Postfix) with ESMTPSA id 0761438A0D6D
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 21:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dashjr.org; s=zinan;
        t=1572040168; bh=G+pYlTEDPzl/ACmOGwErvtg1o6ircJWOnsCkw4gqjJk=;
        h=From:To:Subject:Date;
        b=AqSEtH1fk3LFdfP3i3hDPjePX4jCRQnowuYI4rJoWje+EwUD4cfLRqSFwpJ0LWAKO
         DeXhXRXFFWhLw2JLXLSYRjsjjTD8ByBWGmgXO9kwcAUi3s3tG46+EVluxRqXIQFb7Q
         WEZm4YvKvhxnUyoCCGe5iDEu3z0/V2IodFdWEWYE=
X-Hashcash: 1:25:191025:git@vger.kernel.org::lQOoOl0pDI+aEult:wDbU
From:   Luke Dashjr <luke@dashjr.org>
To:     git@vger.kernel.org
Subject: GIT_COMMITTER_* and reflog
Date:   Fri, 25 Oct 2019 21:49:22 +0000
User-Agent: KMail/1.9.10
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201910252149.23787.luke@dashjr.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It appears the reflog currently allows its log data (name and date) to be 
overridden by the GIT_COMMITTER_* environment variables. At least for my 
workflow, this kinda breaks the reflog (as I regularly set GIT_COMMITTER_DATE 
to produce deterministic commit objects).

Is there a need to support this override for the reflog?
Is there any reason it can't be changed to use GIT_REFLOG_* instead?

Note that the reflog does NOT pull the name/date from the commit object 
itself, but rather calls git_committer_info() to get a new name/date for 
reflog purposes. So it does not appear to be intentionally designed to use 
the commit's date.

Thanks for your thoughts,

Luke

P.S. If the reflog date can be made useful like this, maybe I will finish a 
minor patch to add reflog-date to the pretty formatting format so it can be 
viewed nicely... ;)
