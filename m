From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Ebenlendr?= <ebik@ucw.cz>
Subject: git-svn.perl: Fix glob matching on svn paths
Date: Sat,  9 Oct 2010 11:07:15 +0200
Message-ID: <1286615236-29732-1-git-send-email-ebik@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Oct 09 11:21:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4VcG-0001Hm-SD
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 11:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757221Ab0JIJVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 05:21:06 -0400
Received: from drak.ucw.cz ([212.71.128.78]:36064 "EHLO drak.ucw.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753753Ab0JIJVF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 05:21:05 -0400
Received: from Chewbacca.cub (localhost [127.0.0.1])
	by drak.ucw.cz (Postfix) with ESMTP id 02F922B;
	Sat,  9 Oct 2010 11:07:33 +0200 (CEST)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158578>

Hello,

I tried to convert our repositories to git. Our repositories have only
branches (no tags, and no branch is so special to be called trunk).
The directory of each individual branch live in the root of the
repository (i.e., not in directory 'branches' as in standard layout).

I init the repository by: git svn init path_to_repo -b *
This triggers first bogus match in match_globs(): the pattern matches an
empty string - the place before first slash in any path.

We have created some branch names just by adding some suffix to another
branch name. Imagine branch "devel" and "devel2". Then there is bogus
match on path '/devel2' as it outputs 'devel'.

Patch in the next email fixes both these problems.
