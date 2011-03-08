From: Adam Monsen <haircut@gmail.com>
Subject: [PATCH v6] diff format documentation: clarify --cc and -c
Date: Tue,  8 Mar 2011 13:03:56 -0800
Message-ID: <1299618236-17933-1-git-send-email-haircut@gmail.com>
References: <7vmxl5e6ur.fsf@alter.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>, Junio Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Adam Monsen <haircut@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 08 22:04:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px44r-0006nv-6m
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 22:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756737Ab1CHVEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 16:04:14 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52102 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756477Ab1CHVEL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 16:04:11 -0500
Received: by pwi15 with SMTP id 15so32004pwi.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 13:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=TZY+56b7IxQ5KiB+FHCOf2PzhluK25kMlCnZ7wdgwyA=;
        b=u1FAOeChQKQe19NGu+885iy7hKvanklUZgZyiOJ/eFXb6gHDOJLsxEo3tjRYYme67k
         PTK83HkGJthyzOvcGgSqiObuglKHql7WpK97bamLThhIAUbvmrOnysBGvRaG7iIcqU+D
         LsMfXNlHsNp06z5z4Kr1UR9FMLAnQGTpHQP4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ti0Ro4r0BDJszidhDmBKu5d4fJimpsIEVI+VCMx0lu6WSgm/u4AnqI3lxA4C9hDeV1
         ubzaw76JL3xijeQbcwUValh5TCKegcH8F2r6jprRqXprLDadSNOgAGpQYQtf3H/SHP6b
         uJhy96/5zXkIzXdjiGd5TWUqvg7dlCzq6hYEk=
Received: by 10.142.203.21 with SMTP id a21mr4763420wfg.144.1299618249610;
        Tue, 08 Mar 2011 13:04:09 -0800 (PST)
Received: from localhost.localdomain (c-67-183-136-182.hsd1.wa.comcast.net [67.183.136.182])
        by mx.google.com with ESMTPS id w32sm1463666wfh.7.2011.03.08.13.04.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Mar 2011 13:04:08 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vmxl5e6ur.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168694>

The description was unclear if -c or --cc was the default (--cc is for
some commands), and incorrectly implied that the default applies to
all diff generating commands.

Most importantly, "log" does not default to "--cc" (it defaults to
"--no-merges") and "log -p" obeys the user's wish to see non-combined
format.  Only "diff" (during merge and three-blob comparison) and
"show" use --cc as the default.

The genesis of this patch was me getting frustrated trying to find
changes hidden in conflict resolutions of a merge commit. Jeff King
proposed a documentation fix. I made it into a patch, and worked on it
with Junio. See the thread "frustrated forensics: hard to find diff
that undid a fix" on the git mailing list:

  http://thread.gmane.org/gmane.comp.version-control.git/168481

For more historical information about viewing merge conflict
resolutions, see this post by Linus from 2008:

  http://article.gmane.org/gmane.comp.version-control.git/89415

Signed-off-by: Adam Monsen <haircut@gmail.com>
---

Please ignore v5. I forgot to include links to mailing list archives
in that version.

 Documentation/diff-generate-patch.txt |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 3ac2bea..c57460c 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -74,10 +74,13 @@ separate lines indicate the old and the new mode.
 combined diff format
 --------------------
 
-"git-diff-tree", "git-diff-files" and "git-diff" can take '-c' or
-'--cc' option to produce 'combined diff'.  For showing a merge commit
-with "git log -p", this is the default format; you can force showing
-full diff with the '-m' option.
+Any diff-generating command can take the `-c` or `--cc` option to
+produce a 'combined diff' when showing a merge. This is the default
+format when showing merges with linkgit:git-diff[1] or
+linkgit:git-show[1]. Note also that you can give the `-m' option to any
+of these commands to force generation of diffs with individual parents
+of a merge.
+
 A 'combined diff' format looks like this:
 
 ------------
-- 
1.7.2.3
