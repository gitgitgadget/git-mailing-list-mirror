From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/3 v2] Improve your performance with our patch
Date: Tue, 28 Jul 2009 02:08:46 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0907280131230.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 08:09:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVfs0-0004gk-JH
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 08:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934AbZG1GI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 02:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752775AbZG1GIx
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 02:08:53 -0400
Received: from iabervon.org ([66.92.72.58]:58958 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751866AbZG1GIv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 02:08:51 -0400
Received: (qmail 4132 invoked by uid 1000); 28 Jul 2009 06:08:46 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Jul 2009 06:08:46 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124212>

Ever since I saw spam to the kernel mailing list with that subject, I've 
wanted to title a suitable patch series that. This series makes executing 
the git startup code a whole lot faster on distros where libcurl has all 
the possible features, by not linking the regular programs against it.

I have in the works a series to implement my foreign-scm series as an 
extension to this series, mainly adding handling for the ways that 
importing content is different from simply getting it from a remote 
repository.

Daniel Barkalow (2):
  Add support for external programs for handling native fetches
  Use an external program to implement fetching with curl

Linus Torvalds (1):
  git-http-fetch: not a builtin

 Documentation/git-shim.txt           |   37 +++++++++
 Makefile                             |   12 ++-
 git.c                                |    3 -
 builtin-http-fetch.c => http-fetch.c |    5 +-
 shim-curl.c                          |  132 +++++++++++++++++++++++++++++++
 transport-shim.c                     |  142 ++++++++++++++++++++++++++++++++++
 transport.c                          |  136 +--------------------------------
 transport.h                          |    3 +
 8 files changed, 328 insertions(+), 142 deletions(-)
 create mode 100644 Documentation/git-shim.txt
 rename builtin-http-fetch.c => http-fetch.c (95%)
 create mode 100644 shim-curl.c
 create mode 100644 transport-shim.c
