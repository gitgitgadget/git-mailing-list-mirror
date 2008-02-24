From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] show alias definitions in help
Date: Sun, 24 Feb 2008 17:16:00 -0500
Message-ID: <20080224221559.GA31309@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 23:16:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTP9F-0002gC-8y
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 23:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbYBXWQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 17:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbYBXWQE
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 17:16:04 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4537 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802AbYBXWQD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 17:16:03 -0500
Received: (qmail 2328 invoked by uid 111); 24 Feb 2008 22:16:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 24 Feb 2008 17:16:01 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Feb 2008 17:16:00 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74967>

This was requested during the freeze period, and I posted a "like this?"
patch with a promise to follow-up post-1.5.4. So here is the follow-up.

The objections to my quick patch were:

  - (Dscho) the parsing code was ugly and needed cleanup; the first
    patch refactors cmd_help to use parseopt
  - (Duy) help lookup should respect the usual "commands before alias"
    rule that we use for execution; the third patch takes this into
    account

      1/3: help: use parseopt
           This is parseopt plus general cleanup.

      2/3: make alias lookup a public, procedural function
           Another cleanup to factor out alias lookup from git.c (which
           we will also need in help now).

      help: respect aliases
           The actual patch.

 Makefile |    3 +-
 alias.c  |   22 +++++++++
 cache.h  |    2 +
 git.c    |   17 +------
 help.c   |  152 ++++++++++++++++++++++++++++++++++++--------------------------
 5 files changed, 118 insertions(+), 78 deletions(-)
 create mode 100644 alias.c
