From: Ferry Huberts <mailings@hupie.com>
Subject: [CGit] [PATCH 0/6] Communicate the repo name to the filter scripts
Date: Thu, 17 Feb 2011 22:11:03 +0100
Message-ID: <1297977069-21884-1-git-send-email-mailings@hupie.com>
Cc: hjemli@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 17 22:11:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqB8O-0007Wi-NL
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 22:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758002Ab1BQVLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 16:11:12 -0500
Received: from 82-197-206-98.dsl.cambrium.nl ([82.197.206.98]:57490 "EHLO
	mail.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753282Ab1BQVLK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 16:11:10 -0500
Received: from paul.internal.hupie.com (paul.internal.Hupie.com [192.168.180.1])
	by mail.internal.Hupie.com (Postfix) with ESMTP id 582FC58C997;
	Thu, 17 Feb 2011 22:11:09 +0100 (CET)
X-Mailer: git-send-email 1.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167116>

From: Ferry Huberts <ferry.huberts@pelagic.nl>

This patch series fixes two bugs and communicates the repo name
to the filter scripts.

I have a server setup in which each repo has a trac instance and
for the commit filter I really need to known with which repo I'm
dealing in order to be able to resolve the #123 ticket numbers
into hyperlinks into the correct trac instance.

Patch 0001 fixes a memory leak and can be applied regardless of the other
           patches
Patch 0002 makes sure that all arguments for the filter are correctly initialised
           so that the argv[] list is always terminated with a NULL pointer,
           which is currently not the case for the source filter.
The other patches implement my desired functionality.


Ferry Huberts (6):
  source_filter: fix a memory leak
  new_filter: correctly initialise all arguments for a new filter
  new_filter: determine extra_args from filter type
  source_filter: also communicate the repo name to the filter
  commit_filter: also communicate the repo name to the filter
  about_filter: also communicate the repo name to the filter

 cgit.c                         |   41 +++++++++++++++++++++++++++++++--------
 filters/commit-links.sh        |    2 +
 filters/syntax-highlighting.sh |    1 +
 ui-commit.c                    |    5 +++-
 ui-repolist.c                  |    5 +++-
 ui-summary.c                   |    5 +++-
 ui-tree.c                      |    4 +++
 7 files changed, 51 insertions(+), 12 deletions(-)

-- 
1.7.4
