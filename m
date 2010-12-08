From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: diff for deleted file only, when changed to directory
Date: Wed, 8 Dec 2010 09:12:33 +0100
Message-ID: <AANLkTimXOKC_9TJU1foNkTqPHouFPouzZw3XU_9Za=na@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 08 09:12:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQF8h-0007nK-R0
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 09:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194Ab0LHIMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 03:12:34 -0500
Received: from mail-iw0-f172.google.com ([209.85.214.172]:39869 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335Ab0LHIMe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 03:12:34 -0500
Received: by iwn40 with SMTP id 40so1229803iwn.3
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 00:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=9UPcqpATZtmwxhgdeAaBPm7Prj/B7CGv8OMqeybTCBo=;
        b=ekyzGVapDHSflwbFXIgfVbBAuDrZihsHXLFpfrnlg9mUC+eYjFedgSaDb/x3M/bxTa
         +tZXuCeHcPkkp+ELwfqn4n3WlmCn/bQBnxulX4venN51m4exuDY356Zgxh6fOt7p6iRJ
         ppb5Y0DMJaYNPV9bz+f68wY8ELOjmB77G95c0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=wlaaeDkRP1tzi7LtuW8nG74uiNjjNlA+G67ybk49JCtLwbsS8VaR3yS7Pn/S3asOm+
         4FWzP7KbbemNv9+YBF5uqByPtuzAxrniuoksTPxIsxN0dyEM6P4ad+purJvjkiSvzyl+
         hbc2bPYYzCOX0uehOGX4qtu82B2G+g6eVvMfY=
Received: by 10.42.217.195 with SMTP id hn3mr60465icb.157.1291795953327; Wed,
 08 Dec 2010 00:12:33 -0800 (PST)
Received: by 10.42.172.193 with HTTP; Wed, 8 Dec 2010 00:12:33 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163175>

Hi,

when I stage a file deletion (named foo) and than add a new file
(named foo/bar) in a directory with  the name of deleted file. git
diff --cached -- foo shows me the diff for both the file foo and file
foo/bar.

Here is a recipe:

echo foo >f
git add f
git commit -mfoo
git rm f
mkdir f
echo bar >f/0
git add f/0
git diff -- f
git diff --cached -- f

gives me this:

diff --git c/f i/f
deleted file mode 100644
index 257cc56..0000000
--- c/f
+++ /dev/null
@@ -1 +0,0 @@
-foo
diff --git c/f/0 i/f/0
new file mode 100644
index 0000000..5716ca5
--- /dev/null
+++ i/f/0
@@ -0,0 +1 @@
+bar

For the other case, when I stage a symlink under the name foo, I can
understand that git diff shows me two diffs. But for the case
file->directory, I would like to see only the deleted diff, not
recursing into the directory.

Bert
