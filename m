Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92A1820248
	for <e@80x24.org>; Sat, 23 Feb 2019 15:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfBWPL5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 10:11:57 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:52560 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfBWPL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 10:11:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cB7yytWI1vGp7t9/qdkEttxYJJVbAsDPdDqu9ulu4jw=; b=SpiGovKsAHGJfRndftwfm24NSu
        Npkv98hEu3tgAnNnJpVNbpq/RwbLR+0+6S12HomBP0eRTocjDL7XNVOoh0I8Co8mS4Z8vt0b8nwqV
        nU8CSDctHmAwX+zgrsksazu9xJbeMkJ4HBvfqijnhgsWLyiQOLpnkn1vTNnsYNjAo4VAh/kqO+z6z
        7kJuOVOaEgKfqzoJMLnV4YxPAUSeHhvKsr5Y4QEkgryfTcE8UQ+KOBWiGJTelg8iDwK3+8Yf8i6+B
        eyS8h0NqQSXooztvZjSAhYy4WbLgK5JTu/Lnydu9TVVkLPYtCk7wSyLbEXtgIIM0xcVipJdnDuIuJ
        nvaQIyog==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:33362 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1gxYy1-00GHGI-Si
        for git@vger.kernel.org; Sat, 23 Feb 2019 10:11:55 -0500
Date:   Sat, 23 Feb 2019 10:11:53 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: does "git clean" deliberately ignore "core.excludesFile"?
Message-ID: <alpine.LFD.2.21.1902231008530.28936@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1552689970-1550934714=:28936"
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1552689970-1550934714=:28936
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT


  not sure why i never noticed this before, but the "-x" option for
"git clean" reads:

 -x
     Don¢t use the standard ignore rules read from .gitignore
     (per directory) and $GIT_DIR/info/exclude, but do still use
     the ignore rules given with -e options. This allows
     removing all untracked files, including build products.
     This can be used (possibly in conjunction with git reset)
     to create a pristine working directory to test a clean
     build.

  but i see no mention of whether the file specified by
core.excludesFile is taken into account, and perusing the source code
doesn't seem to show that command checking that config option.

  am i misreading something? and if not, is there a reason git clean
does not consult core.excludesFile?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
--8323328-1552689970-1550934714=:28936--
