From: Sam Hocevar <sam@zoy.org>
Subject: git-p4 workflow suggestions?
Date: Mon, 9 Mar 2009 15:21:08 +0100
Message-ID: <20090309142108.GK12880@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 15:22:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LggNP-0005bC-Vg
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 15:22:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbZCIOVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 10:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbZCIOVP
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 10:21:15 -0400
Received: from poulet.zoy.org ([80.65.228.129]:46445 "EHLO poulet.zoy.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbZCIOVO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 10:21:14 -0400
Received: by poulet.zoy.org (Postfix, from userid 1000)
	id 7A6D512046A; Mon,  9 Mar 2009 15:21:08 +0100 (CET)
Content-Disposition: inline
Mail-Copies-To: never
X-No-CC: I read mailing-lists; do not CC me on replies.
X-Snort: uid=0(root) gid=0(root)
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112697>

   Dear list,

   I have modified git and git-p4 to a point where they are usable in
my work environment. I am now faced with a new problem: Perforce's
composite workspaces. They allow you to "mount" parts of the repo onto
other directories, even nonempty ones.

   Take the following example repository, where a "framework" project
contains an example subdirectory with build files and other directories,
and a "project1" project contains subdirectories that are meant to
replace the ones in "example":

   //work/framework/example/src/
                           /include/
			   /Makefile
			   /...
   //work/project1/src/
                  /include/

   Using the Perforce client, one can reorganise the workspace
so that project1/src/ transparently replaces the contents of
framework/example/src/ (same for */include). All the work is then done
in the framework/ local checkout, but commits may also affect project1/.

   I could not find a way to do the same with git and git-p4. My main
requirements are the following:

   - preserve the atomicity of commits affecting both project1/src and
   project1/include (having to commit from a different directory due to
   symlink hacks is acceptable to me, even if not terribly practical)

   - have git-p4 rebase work without requiring tedious merges

   - *if possible* (but not a strong requirement), preserve the
   atomicity of commits affecting both framework/ and project1/.

   If anyone ever ran into the problem, I'd like to hear from their
experience. Or maybe someone will have suggestions based on similar
requirements.

Cheers,
-- 
Sam.
