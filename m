From: Alastair McGowan-Douglas <altreus@altre.us>
Subject: git status -u is mildly astonishing
Date: Thu, 17 Sep 2015 10:44:30 +0100
Organization: OpusVL
Message-ID: <20150917104430.5dd73ae1@dev-05>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 12:28:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcWQI-0008Mj-9f
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 12:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbbIQK2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 06:28:09 -0400
Received: from msa.mail.opusvl.net ([82.211.96.143]:55298 "EHLO
	msa.mail.opusvl.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbbIQK2I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 06:28:08 -0400
X-Greylist: delayed 2610 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2015 06:28:08 EDT
Received: from [213.131.188.212] (helo=smtp.rug-01.opusvl.net)
	by msa.mail.opusvl.net with esmtp (Exim 4.69)
	(envelope-from <altreus@altre.us>)
	id 1ZcVRo-0000oL-JN
	for git@vger.kernel.org; Thu, 17 Sep 2015 10:25:44 +0100
Received: from dev-05.rug-01.opusvl.net ([10.10.4.104]:38917 helo=dev-05)
	by smtp.rug-01.opusvl.net with esmtp (Exim 4.71)
	(envelope-from <altreus@altre.us>)
	id 1ZcVjx-0004kJ-RW
	for git@vger.kernel.org; Thu, 17 Sep 2015 10:44:30 +0100
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
X-SA-Exim-Connect-IP: 10.10.4.104
X-SA-Exim-Mail-From: altreus@altre.us
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	spamd-01.rug-01.opusvl.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	URIBL_BLOCKED autolearn=ham version=3.3.2
X-SA-Exim-Version: 4.2.1 (built Mon, 22 Mar 2010 06:26:47 +0000)
X-SA-Exim-Scanned: Yes (on smtp.rug-01.opusvl.net)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278105>

Hi list,

Today I found what I thought was a bug in git status:

https://paste.fedoraproject.org/268333/42480833/

It seemed that the argument to -u was being ignored. It turns out that
'no' was not actually being considered an argument to -u in the first
place.

The documentation supports this:

       -u[<mode>], --untracked-files[=<mode>]
           Show untracked files.

There is no space here, but it is not obvious that it is *important*
that there is no space here.

The usage string implies that -- is used to disambiguate path specs
from option arguments

    git status [<options>...] [--] [<pathspec>...]

Therefore I would argue that -u is behaving differently from other
arguments (especially when considered across all git subcommands) by
only accepting its argument when not separated by a space. This at
least should be explicitly documented, but, preferably, should be
consistent with other arguments and use the -- token as the separator.

-Altreus
