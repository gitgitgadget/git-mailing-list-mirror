From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH 0/6] Pack window memory limit, take 2
Date: Thu, 12 Jul 2007 07:55:46 -0500
Message-ID: <1184244952554-git-send-email-bdowning@lavos.net>
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Brian Downing <bdowning@lavos.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 14:55:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8yD5-0005M9-U4
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 14:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763641AbXGLMzv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 08:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763394AbXGLMzv
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 08:55:51 -0400
Received: from 74-134-246-243.dhcp.insightbb.com ([74.134.246.243]:57713 "EHLO
	silvara" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759493AbXGLMzu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 08:55:50 -0400
Received: by silvara (Postfix, from userid 1000)
	id 7AFED52133; Thu, 12 Jul 2007 07:55:52 -0500 (CDT)
X-Mailer: git-send-email 1.5.2.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52274>

This series has my circular buffer errors (hopefully) corrected, and
the code is a lot cleaner as a bonus.  Also, the options are now named
--window-memory and pack.windowMemory, and both can take {k,m,g} suffixes.

I split out the {k,m,g} parsing code from git_config_int into
git_parse_long and git_parse_ulong, so it can be used for command-line
arguments as well.  Hopefully these will be useful elsewhere.

Finally the documentation has been cleaned up a bit and information on
the defaults has been added.

Patches 1 and 2 are unmodified from last time.

 [PATCH 1/6] Don't try to delta if target is much smaller than source
 [PATCH 2/6] Support fetching the memory usage of a delta index
 [PATCH 3/6] Add functions for parsing integers with size suffixes
 [PATCH 4/6] Add pack-objects window memory usage limit
 [PATCH 5/6] Add --window-memory option to git-repack
 [PATCH 6/6] Add documentation for --window-memory, pack.windowMemory

 Documentation/config.txt           |    6 +++
 Documentation/git-pack-objects.txt |   11 ++++++
 Documentation/git-repack.txt       |   11 ++++++
 builtin-pack-objects.c             |   52 ++++++++++++++++++++++++++----
 cache.h                            |    3 ++
 config.c                           |   61 +++++++++++++++++++++++++++++------
 delta.h                            |    7 ++++
 diff-delta.c                       |   10 ++++++
 git-repack.sh                      |    3 +-
 9 files changed, 145 insertions(+), 19 deletions(-)

-bcd
