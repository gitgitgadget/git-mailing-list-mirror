From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/8] VCS helpers
Date: Thu, 3 Sep 2009 22:13:43 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0909032213120.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 04:14:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjOJV-0002pu-NR
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 04:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756515AbZIDCNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 22:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756266AbZIDCNm
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 22:13:42 -0400
Received: from iabervon.org ([66.92.72.58]:41087 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756219AbZIDCNm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 22:13:42 -0400
Received: (qmail 2349 invoked by uid 1000); 4 Sep 2009 02:13:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Sep 2009 02:13:43 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127674>

This is the next version of the db/vcs-helper series in pu.

The first patch is new, a rework of the remote-curl build to produce
"remote-curl" and call it as a special case for the sorts of URLs that
we accept as indicating something that it now handled by this helper.

The series is rebased onto current next, with some conflicts resolved.

Two patches have been dropped: a memory leak fix for code that was
removed entirely by the first patch, and the "mark" helper capability,
which is not needed (I believe) due to the "option" fast-import command.

Daniel Barkalow (8):
  Make the "traditionally-supported" URLs a special case
  Use a clearer style to issue commands to remote helpers
  Use a function to determine whether a remote is valid
  Allow fetch to modify refs
  Allow programs to not depend on remotes having urls
  Add a config option for remotes to specify a foreign vcs
  Add support for "import" helper command
  Allow helpers to report in "list" command that the ref is unchanged

 Documentation/config.txt             |    4 +
 Documentation/git-remote-helpers.txt |   14 ++++-
 Makefile                             |   17 +-----
 builtin-clone.c                      |    6 +-
 builtin-fetch.c                      |    7 ++-
 builtin-ls-remote.c                  |    4 +-
 builtin-push.c                       |   67 +++++++++++++--------
 remote.c                             |   15 ++++-
 remote.h                             |    2 +
 transport-helper.c                   |  107 +++++++++++++++++++++++++++++-----
 transport.c                          |   23 +++++--
 transport.h                          |   43 +++++++++++++-
 12 files changed, 234 insertions(+), 75 deletions(-)
