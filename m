From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: builtin-clone does not fallback to copy when link fails
Date: Tue, 20 May 2008 11:28:52 -0500
Message-ID: <oguFi9b5ZAq84dsDzWpm0tpI_xzucMxL23YhxIjDS5NTdpslAnzo6w@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue May 20 18:31:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyUiy-0006Fo-6w
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 18:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761679AbYETQ3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 12:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760866AbYETQ3L
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 12:29:11 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58624 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757852AbYETQ3J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 12:29:09 -0400
Received: by mail.nrlssc.navy.mil id m4KGSrLL010016; Tue, 20 May 2008 11:28:53 -0500
X-OriginalArrivalTime: 20 May 2008 16:28:53.0365 (UTC) FILETIME=[97BCC250:01C8BA96]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82483>



When cloning with the new builtin-clone, if the src repo is not
on the same disk as the dest repo, cloning fails. This is because
hard linking does not fall back to copying like the shell version
did.

The shell version also made a distinction between defaulting to
hard linking and an explicit request to hard link. In the latter
case it would not fall back to copying, but would die.

I'll also mention that the 'use_local_hardlinks' variable in cmd_clone
is not used. It looks like there was some initial thought that this
variable would be used and then an alternative solution was found
where option_no_hardlinks was accessed directly. So use_local_hardlinks
should probably be cleaned out.

-brandon
