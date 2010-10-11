From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 5/4] Documentation: flesh out diff --no-index description
Date: Mon, 11 Oct 2010 11:07:18 -0500
Message-ID: <20101011160718.GF25842@burratino>
References: <20101011150342.292ad725@chalon.bertin.fr>
 <AANLkTinqPiGf1nbo0oOvDD5edgLBdO8xZfjGeFC4q0MU@mail.gmail.com>
 <20101011161721.35940919@chalon.bertin.fr>
 <20101011160224.GA25842@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>, git@vger.kernel.org
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Mon Oct 11 18:10:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5KxV-0005t5-Ac
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 18:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327Ab0JKQKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 12:10:36 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53355 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754959Ab0JKQKf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 12:10:35 -0400
Received: by ywi6 with SMTP id 6so685228ywi.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 09:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=KR4kAhdzHoSDZcI+UV9DPyrXpH/lJUzluF/WBFrTJ30=;
        b=ql6Y3oW3aIdbbiBSjRlCEDgrHQ0f478g3vbxw0iXEAogAiiPqqCguK5/qx9SpxSCFn
         MKPySUq6gRQM2rOsUalaAn/Ac3UtjL4sXF3FGXjqHK7cw8Y0YDgp73gHReV7jaOhPhQ6
         7riwhGC3xViLgxtrLkbNNErEKkzyTCGntOh2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Z6eo5jkLm/d2D4Gh0ij8wiXib7DZ8q4P92tASe/24WHklCMMv/XSlorhI21y12Re8v
         Yxd3ngfak6AM4e7//1HabJ8LBKMgR8NcDhitR2n5Zm3+ZhOdY8xgVxTVtom+2IsTXZfd
         nPs3mX5/KZgWKOCNNv/JhkMUDv1UBZLV64Fkc=
Received: by 10.236.102.132 with SMTP id d4mr12102311yhg.45.1286813434290;
        Mon, 11 Oct 2010 09:10:34 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id g25sm4470514yhc.39.2010.10.11.09.10.33
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 09:10:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011160224.GA25842@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158775>

Explain what diff --no-index is used for in more detail.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-diff.txt |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index dd1fb32..6700e8c 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -25,7 +25,7 @@ tree and the index file, or the index file and the working tree.
 +
 If exactly two paths are given and at least one points outside
 the current repository, 'git diff' will compare the two files /
-directories. This behavior can be forced by --no-index.
+directories (see --no-index below).
 
 'git diff' [--options] --cached [<commit>] [--] [<path>...]::
 
@@ -62,11 +62,24 @@ directories. This behavior can be forced by --no-index.
 	"git diff $(git-merge-base A B) B".  You can omit any one
 	of <commit>, which has the same effect as using HEAD instead.
 
+'git diff' [--options] --no-index [--] <path> <path>::
+
+	In this form, 'git diff' will compare a pair of files or
+	directories that are not necessarily being managed by git.
+	The tracked content of files in the index and the object
+	database are ignored.
++
+In other words, this form allows 'git diff' to be used as a
+traditional 'diff' command (plus the familiar extras like --check,
+color, pagination, automatic use of -r, --stat/--name-status,
+--pickaxe, --binary, copy/rename detection, -Oorderfile, and
+--patience).
+
 Just in case if you are doing something exotic, it should be
 noted that all of the <commit> in the above description, except
-in the last two forms that use ".." notations, can be any
-<tree>.  The third form ('git diff <commit> <commit>') can also
-be used to compare two <blob> objects.
+in the two forms that use ".." notations, can be any <tree>.
+The third form ('git diff <commit> <commit>') can also be used
+to compare two <blob> objects.
 
 For a more complete list of ways to spell <commit>, see
 "SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
-- 
1.7.2.3
