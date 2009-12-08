From: Yann Dirson <ydirson@linagora.com>
Subject: [BUG] Bad msysgit/egit interaction over dotfiles
Date: Tue, 8 Dec 2009 14:28:57 +0100
Message-ID: <20091208132857.GB5425@linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT ml <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 08 14:29:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI07k-0002pD-Lx
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 14:29:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729AbZLHN2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 08:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754710AbZLHN2w
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 08:28:52 -0500
Received: from [194.206.158.221] ([194.206.158.221]:35980 "EHLO
	cyann.linagora.lan" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754709AbZLHN2w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 08:28:52 -0500
Received: from yann by cyann.linagora.lan with local (Exim 4.69)
	(envelope-from <yann@linagora.com>)
	id 1NI07d-00020A-HH
	for git@vger.kernel.org; Tue, 08 Dec 2009 14:28:57 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134866>

Some devs here started to use egit on windows, and since egit is not
complete yet, occasionally^Wregularly use msysgit for
rebase/stash/you-name-it.

This revealed a strange problem that took some time figuring out,
where eclipse refused to write to .classpath or .project, just saying
"could not write", while other apps had no problem editing the same
files.

In the end, the problem is that the dotfiles had the "hidden" bit set,
and that for some reason eclipse does not allow to write to hidden
files - and that the one (re)setting the "hidden" bit over and over
again is msysgit, whenever it checkouts such a dotfile - surely to
emulate the unix behaviour of hiding dotfiles by default.

I'm not sure who's at fault here - namely, I can't see any valid
reason for eclipse to refuse such writes, but I am not sure it is a
good reason for msysgit would set the hidden bit either.  In either
case, even if only for the short term, I think msysgit should ensure
that this bit does not get set (possibly circumventing any magic msys
would do behind its back).

Best regards,
-- 
Yann
