From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation: do not advertise --all in git-pull(1)
Date: Thu, 7 Jan 2010 17:09:33 +0100
Message-ID: <a6112d286c5deeb4cc2ccfb1a90ff384440c1341.1262880109.git.trast@student.ethz.ch>
References: <hi2mu8ob@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Zing <zing@fastmail.fm>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 07 17:10:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSuw1-0007uA-Dn
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 17:10:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205Ab0AGQJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 11:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191Ab0AGQJ5
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 11:09:57 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:9588 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753189Ab0AGQJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 11:09:56 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.213.0; Thu, 7 Jan
 2010 17:09:56 +0100
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Thu, 7 Jan
 2010 17:09:33 +0100
X-Mailer: git-send-email 1.6.6.202.gdf32a
In-Reply-To: <hi2mu8ob@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136353>

Since 9c4a036 (Teach the --all option to 'git fetch', 2009-11-09), we
document git-fetch's option --all in fetch-options.txt.  However, that
file is also included by git-pull.txt, where the option makes no
sense.

Wrap the option with ifdef so that it does not appear on the git-pull
manpage.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Zing <zing@fastmail.fm> wrote:
> In 1.6.6, if I do:
> 
> $ git pull --all
> Fetching origin
> Fetching gnome
> You asked to pull from the remote '--all', but did not specify
> a branch. Because this is not the default configured remote
> for your current branch, you must specify a branch on the command line.

This one fixes the documentation problem, but I think there's a deeper
misunderstanding.  What did you hope to do with 'git pull --all'?  I
suspect most people on this list would take it to mean "fetch all
branches from all remotes, and merge them into HEAD".  I cannot
imagine a use-case where that would make any sense.  (And it wouldn't
work, because the current implementation of 'git fetch --all' leaves
only the last remote's branches in FETCH_HEAD.)

>From earlier discussions on the non-intuitiveness of git-pull, I kind
of suspect you wanted to fetch all remotes, and then "update" all
local branches that track some remote with their corresponding
remote-tracking branches.  In which case the question is: why do you
use local branches if you have them "blindly" track the upstream?


 Documentation/fetch-options.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index ab6419f..6271615 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -1,5 +1,7 @@
+ifndef::git-pull[]
 --all::
 	Fetch all remotes.
+endif::git-pull[]
 
 -a::
 --append::
-- 
1.6.6.202.gdf32a
