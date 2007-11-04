From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Make gitk use --early-output
Date: Sun, 04 Nov 2007 19:28:39 +0100
Message-ID: <85fxzlrhk8.fsf@lola.goethe.zz>
References: <18221.2285.259487.655684@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 19:28:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IokCd-0001K6-RY
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 19:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803AbXKDS1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 13:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753657AbXKDS1a
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 13:27:30 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:40432 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393AbXKDS13 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 13:27:29 -0500
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1IokBx-00006n-Ms; Sun, 04 Nov 2007 13:27:25 -0500
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id B13E71C464E3; Sun,  4 Nov 2007 19:28:39 +0100 (CET)
In-Reply-To: <18221.2285.259487.655684@cargo.ozlabs.ibm.com> (Paul Mackerras's
	message of "Sun, 4 Nov 2007 10:49:01 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63425>

Paul Mackerras <paulus@samba.org> writes:

> This makes gitk use the --early-output flag on the git log command.
>
> When gitk sees the "Final output:" line from git log, it goes into a
> mode where it basically just checks that it is getting the commits
> again in the same order as before.  If they are, well and good; if
> not, it truncates its internal list at the point of difference and
> proceeds to read in the commits in the new order from there on, and
> re-does the graph layout if necessary.
>
> This gives a much more immediate feel to the startup; gitk shows its
> window with the first screenful of commits displayed very quickly this
> way.

This is not strictly related with the patch: would it be possible to let
gitk just stall reading from git-rev-list if it has rendered enough
content on-screen?  The behavior I have with gitk on enormous
repositories now is that it starts up reasonably fast and nice and then
proceeds to suck up all memory in the background.

Particularly annoying is that closing its window appears to work, but
wish will still proceed sucking up all the pending git-rev-list output
and allocating memory for it before it will actually exit.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
