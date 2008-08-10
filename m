From: Anand Kumria <wildfire@progsoc.org>
Subject: [PATCH 00/12] Allow users to access Perforce repositories requiring authentication
Date: Sun, 10 Aug 2008 19:26:23 +0100
Message-ID: <1218392795-4084-1-git-send-email-wildfire@progsoc.org>
Cc: simon@lst.de, Anand Kumria <wildfire@progsoc.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 20:47:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSFwk-0005uj-AN
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 20:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbYHJSqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 14:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752707AbYHJSqQ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 14:46:16 -0400
Received: from 133.105.233.220.exetel.com.au ([220.233.105.133]:41052 "EHLO
	giskard.kumria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbYHJSqP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 14:46:15 -0400
Received: from caliban.kumria.com ([203.7.227.146] helo=eve.kumria.com)
	by giskard.kumria.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <anand@eve.kumria.com>)
	id 1KSFiL-00021w-S8; Mon, 11 Aug 2008 04:32:29 +1000
Received: from anand by eve.kumria.com with local (Exim 4.69)
	(envelope-from <anand@eve.kumria.com>)
	id 1KSFch-000156-Ha; Sun, 10 Aug 2008 19:26:35 +0100
X-Mailer: git-send-email 1.5.6.3
X-Spam-Score: -2.1
X-Spam-Score-Int: -20
X-Spam-Bar: --
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91872>

Hi,

This series of patches refactors a few function calls into git-p4
so that they all go via the same function to build up the command
line.

It also then allows users to specify any particular user / password
required to access their Perforce repository (plus a few other parameters).

I have specifically tested this agains the public Zimbra repository and
it works for me fine. Any feedback would be welcomed.

Thanks,
Anand

Anand Kumria (12):
  Create a specific version of the read_pipe_lines command for p4
    invocations
  Utilise the new 'p4_read_pipe_lines' command
  Have a command that specifically invokes 'p4' (via system)
  Utilise the new 'p4_system' function.
  Add a single command that will be used to construct the 'p4' command
  If we are in verbose mode, output what we are about to run (or
    return)
  Switch to using 'p4_build_cmd'
  If the user has configured various parameters, use them.
  Consistently use 'git-p4' for the configuration entries
  Move git-p4.syncFromOrigin into a configuration parameters section
  Put some documentation in about the parameters that have been added
  Put in the two other configuration elements found in the source

 contrib/fast-import/git-p4     |   71 ++++++++++++++++++++++++++++++++-------
 contrib/fast-import/git-p4.txt |   68 +++++++++++++++++++++++++++++++-------
 2 files changed, 114 insertions(+), 25 deletions(-)
