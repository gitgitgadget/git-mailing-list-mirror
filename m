From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: [BUG] git clean -X skips a directory containing only ignored
 files
Date: Wed, 01 Feb 2012 13:18:50 +0100
Message-ID: <4F292DAA.1000107@elegosoft.com>
References: <CA+yLL67J-7U9z7HVvq5wTc1g4_UCtqYfEyqdt7XR5zDqvQN5NA@mail.gmail.com> <4F2814D7.8030504@sohovfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Paul Berry <stereotype441@gmail.com>, git@vger.kernel.org
To: Andrew Wong <andrew.w@sohovfx.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 13:20:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsZB7-0001Sc-TJ
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 13:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521Ab2BAMUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 07:20:05 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:50691 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753370Ab2BAMUE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 07:20:04 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 4A1AEDE853;
	Wed,  1 Feb 2012 13:20:03 +0100 (CET)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XTajWayBkWKG; Wed,  1 Feb 2012 13:20:03 +0100 (CET)
Received: from [10.10.10.197] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id D1CFFDE84D;
	Wed,  1 Feb 2012 13:20:02 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:9.0) Gecko/20111224 Thunderbird/9.0.1
In-Reply-To: <4F2814D7.8030504@sohovfx.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189508>

On 01/31/2012 05:20 PM, Andrew Wong wrote:
> I think there were a bit of discussions on this issues just while ago too:
> http://thread.gmane.org/gmane.comp.version-control.git/188605

Thanks, missed that.

Below a patch with an update for Documentation/git-clean.txt - I'm not sure
if the issue should be described more accurate.?

-- >8 --

Subject: [PATCH] Documentation: tell about "git clean -Xd" bug

"git clean -Xd" doesn't work as expected (delete all ignored files and
untracked directories), because Git's dir subsystem is skipping
directories which both aren't explicitly ignored and don't hold any
tracked files.

Tell about this limitation in BUGS.

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---
 Documentation/git-clean.txt |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 79fb984..888c07d 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -29,7 +29,8 @@ OPTIONS
 	Remove untracked directories in addition to untracked files.
 	If an untracked directory is managed by a different git
 	repository, it is not removed by default.  Use -f option twice
-	if you really want to remove such a directory.
+	if you really want to remove such a directory.  Also see BUGS
+	below.
 
 -f::
 --force::
@@ -63,6 +64,11 @@ OPTIONS
 	Remove only files ignored by git.  This may be useful to rebuild
 	everything from scratch, but keep manually created files.
 
+BUGS
+----
+'git-clean -Xd' doesn't work as expected for directories which don't hold
+any tracked files and aren't explicitly ignored either.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
1.7.9.174.g356eff6
