From: "ZHANG, Le" <r0bertz@gentoo.org>
Subject: [PATCH v4 0/4] add --recode-patch parameter to mailinfo and am
Date: Mon, 29 Nov 2010 03:10:13 +0800
Message-ID: <1290971417-4474-1-git-send-email-r0bertz@gentoo.org>
Cc: "ZHANG, Le" <r0bertz@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 28 20:10:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMmdw-00012S-CR
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 20:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991Ab0K1TK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Nov 2010 14:10:29 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57955 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866Ab0K1TK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Nov 2010 14:10:28 -0500
Received: by pwj3 with SMTP id 3so638058pwj.19
        for <git@vger.kernel.org>; Sun, 28 Nov 2010 11:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=9Gx5/6Nv8PphfoFcTi1wWgbQ7F3KxzSIVgmde3PXQxQ=;
        b=tEQjNmCLxbBy29Y34j1afw1EesjmSO+oXf/rrqdpYa899Vn3oaFfi6HmR3DDKsS/tg
         pWAEtEw9VJeK8kxaiLUV02ll3tJWR2EBJHZ9iwXuQ8qrH2jpgCdsqUeUyLrnBeVSwLhH
         plIFG1b7J37jcp/VdMDWn++4UtgSZ0HebNOgM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=QxkalitkpUSpubLfXQjnvJodr8pmGkW7S7X6qA0mkzWuCaqPs0XcMANE2FSdovfY/E
         u83WTRqNgNZdrBFQcnfACDP53mx9Fw9BYNmrEJ8w58GEPrc0JXxBLR378b1gE/p6xDLG
         Xgh8F+s+YUfqFVGq7QZZFM1BL8ZY3ZyrYx8xM=
Received: by 10.142.241.14 with SMTP id o14mr3052088wfh.262.1290971428356;
        Sun, 28 Nov 2010 11:10:28 -0800 (PST)
Received: from localhost ([183.37.0.219])
        by mx.google.com with ESMTPS id w22sm6314012wfd.7.2010.11.28.11.10.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Nov 2010 11:10:27 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.344.gb3680.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162345>

I have a translation project which uses UTF-8 as charset.
So the patch must be encoded in UTF-8, not just the commit msg etc.
And we use google group as our mailing list.

Recently, mails saved from gmail are encoded using local charset if all the
characters in the patch are in that specific local charset even if the orignal
mail is in UTF-8. This seems smart but it caused inconvenience for
our project.

Since we have no control on what google will do, so I took another way,
i.e. add this option to git-mailinfo. I hope this could benefit others as
well.

Changelog:

v4 -> v3:
* Added a target_charset parameter to convert_to_utf8() in mailinfo.c.
* Introduced a new config varible: i18n.patchencoding, which will be used solely
  by --recode-patch parameter.

v2 -> v3:
* Removed 'const' type qualifier from handle_patch()'s parameter
* Fixed typos in commit msg

v1 -> v2:
* Clarified how -u/--encoding is handled in git-mailinfo's documentation


ZHANG, Le (4):
  mailinfo.c: convert_to_utf8(): added a target_charset parameter
  i18n.patchencoding: introduce a new config variable
  git mailinfo: added a --recode-patch parameter
  git am: added a --recode-patch parameter

 Documentation/git-am.txt       |    4 ++++
 Documentation/git-mailinfo.txt |    6 +++++-
 builtin/mailinfo.c             |   27 +++++++++++++++++----------
 cache.h                        |    1 +
 config.c                       |    3 +++
 environment.c                  |    1 +
 git-am.sh                      |   13 +++++++++++--
 7 files changed, 42 insertions(+), 13 deletions(-)

-- 
1.7.3.2.344.gb3680.dirty
