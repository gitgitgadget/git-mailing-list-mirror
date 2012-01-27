From: Mike Hommey <mh@glandium.org>
Subject: commit/from command in git-fast-import
Date: Fri, 27 Jan 2012 13:48:37 +0100
Message-ID: <20120127124837.GA24084@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 27 14:18:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rqlhd-0004b0-AK
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 14:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858Ab2A0NSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 08:18:48 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19]:43207
	"EHLO jigen.glandium.org" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754765Ab2A0NSs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jan 2012 08:18:48 -0500
X-Greylist: delayed 1807 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Jan 2012 08:18:47 EST
Received: from mh by jigen.glandium.org with local (Exim 4.77)
	(envelope-from <mh@glandium.org>)
	id 1RqlEL-0007VS-FE
	for git@vger.kernel.org; Fri, 27 Jan 2012 13:48:37 +0100
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189219>

Hi,

I'm trying to make sense of the git fast-import manual page. This is
what it reads, as of git 1.7.8.3, from Debian unstable:

  Omitting the from command in the first commit of a new branch will
  cause fast-import to create that commit with no ancestor. This
  tends to be desired only for the initial commit of a project. If
  the frontend creates all files from scratch when making a new
  branch, a merge command may be used instead of from to start the
  commit with an empty tree. Omitting the from command on existing
  branches is usually desired, as the current commit on that branch
  is automatically assumed to be the first ancestor of the new
  commit.

When I do create a commit on a given branch with a stream like:
  commit refs/heads/branch
  author ...
  committer ...
  data <<EOF
  Commit message
  EOF
  deleteall

All I get is this warning:
  warning: Not updating refs/heads/branch (new tip new_sha1
does not contain old_sha1)

And the branch only has one commit, which is the one I just created.
On the other hand, if I add a "from" instruction in the above stream,
I have the expected branch history.

Arguably, this may be related to my use of deleteall, but nothing in the
deleteall description suggests this would happen.

Is it an expected behaviour and a lack of proper documentation, or is it
a bug in git fast-import ?

Mike
