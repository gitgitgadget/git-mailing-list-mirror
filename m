From: Yann Dirson <ydirson@altern.org>
Subject: Getting gitk to display all refs but stgit logs
Date: Mon, 8 Jan 2007 22:32:59 +0100
Message-ID: <20070108213259.GB17093@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jan 08 22:33:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H427T-00085j-PW
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 22:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbXAHVdX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 16:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbXAHVdX
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 16:33:23 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:34559 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750864AbXAHVdW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 16:33:22 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id F23627CF1
	for <git@vger.kernel.org>; Mon,  8 Jan 2007 22:33:19 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id B9E411F0A3; Mon,  8 Jan 2007 22:32:59 +0100 (CET)
To: GIT list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36281>

Since v0.11, StGIT creates references to keep a hand on patch logs.
This has the unfortunate side-effect that "gitk --all" suddenly shows
all those very annoying, and soon becomes unusable on
repositories for which was very convenient.

I guess it would be acceptable to have stgit itself launch gitk with
the correct options.

The only way I could find to suppress these refs from the display is
to find the refs ourselves and pipe them to gitk using --stdin:

 find .git/refs/ -type f -not -name '*.log' -printf '%P\n'|gitk --stdin

Unfortunately, requesting an update from gitk then behaves as if
nothing had been given on command-line (obviously it is passing
--stdin to git-rev-list without repeating the data).

We could do slightly better by enclosing the find in backquotes on the
gitk command-line, but that would still hide new refs to git-rev-list
when updating the graph.

Is there a better way already, or should we work on something specific
here ?  A possible solution I think of could be to call something like:

 gitk --stdin-command="find .git/refs/ -type f -not -name '*.log' -printf '%P\n'"

Best regards,
-- 
Yann.
