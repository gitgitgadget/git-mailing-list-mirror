Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEF7C20282
	for <e@80x24.org>; Thu, 22 Jun 2017 10:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbdFVK1A (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 06:27:00 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:11543 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752916AbdFVK07 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 06:26:59 -0400
Received: from lindisfarne.localdomain ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id NzK5dhmIPxR4bNzKDdWEVE; Thu, 22 Jun 2017 11:26:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1498127217; bh=Bz8bkeJeFWEedlhBicS/diI1Y+ZkMbRt5KOX+/hNYBw=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=XeOfbpFIw6mvw+RICQL+tt/oNYxDd9JnioBimft4EqPSiXk4vQ3VvLObpldG20ASI
         S9lpCV4r9ME3UnfJ80yKc4PrnpA7UGbNRWo9mgmoKzGH5jBhJxKlfcx8d09PTZH0D1
         LJp8+LAcuExoa1n0v6gD0JBuEQdMS/DxSKZsD7cM=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=evINK-nbAAAA:8 a=hykUG8VhdtKBKJxG7PsA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 0/5] Move unquote_path() from git-add--interactive.perl to Git.pm
Date:   Thu, 22 Jun 2017 11:26:17 +0100
Message-Id: <20170622102622.26147-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfA6j/+2/PLenFsa9udF0sdgVZuvFO8SbhSxyqi77LZ7IanJWlwvQ+yzeSQszh//bji1738BQJgZ84ZxVLmYRfhEm/BxUwg30eWP377s9qgVtGICh+FEL
 /xaBsntlKEI2967TiOx1HITVfkul+qheP42u606llbq+lzXjH5V3gA7MHc7HBt5G+H9QbVslX3Sgw/tnbllRG9Fl9iwcFpkHv15pIy3SwLwqpAoBP1nPyo2u
 mDomPdUSwQI6c+hM/FTt3Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

I'm using this in some scripts and it would be more convenient to have
it available from Git.pm rather than copying and pasting it each time
I need it. I think it should be useful to other people using Git.pm as
well. It is not uncommon to get a quoted path back from a command that
needs to be passed on the commandline of another command. While one
can use -z in many cases, that leaves the problem of having to quote
the path when printing it in error messages etc.

Phillip Wood (5):
  Git.pm Add unquote_path()
  Git::unquote_path() Handle '\a'
  Git::unquote_path() throw an exception on bad path
  Add tests for Git::unquote_path()
  git-add--interactive.perl: Use unquote_path() from Git.pm

 git-add--interactive.perl | 43 +------------------------------------
 perl/Git.pm               | 54 ++++++++++++++++++++++++++++++++++++++++++++++-
 t/t9700/test.pl           |  7 ++++++
 3 files changed, 61 insertions(+), 43 deletions(-)

-- 
2.13.0

