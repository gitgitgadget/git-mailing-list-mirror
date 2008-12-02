From: Scott Chacon <schacon@gmail.com>
Subject: [PATCH] Add a built-in alias for 'stage' to the 'add' command
Date: Mon, 1 Dec 2008 22:14:55 -0800
Message-ID: <20081202061455.GA48848@agadorsparticus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Dec 02 07:16:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7OYU-0005i1-1r
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 07:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbYLBGPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 01:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbYLBGPA
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 01:15:00 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:27632 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbYLBGO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 01:14:59 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2821012rvb.1
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 22:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=ISIm7J09UyHw6vKGrif9Giy4hdJMDlB1xLKGVttXF/I=;
        b=u3afMyfS5vBzLFz6QdoEsvlxO8aTSWQctTgThnxfENu4LsNLbsAge8od9pv9O3Yt9a
         c4yvT3e+B232ARvTrDgx465QANCU5bKaTvLMJAPnvinwsEyq32QSbgt1iV1vguMmkEr/
         o434aQln9/sntsrTr6AFiyiUCnt8k4SCF7BPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=EJAUTuYkoxgULMqUtbAmE6A+4BCiHjJ/7jZZksTXtUGtQ3IjNOxTBqA2+IUIBQ3TWl
         L4DgIiFo2nodnEU1/KseUUyjmRn4nlvjINSPo4fYN0WY9DdhTv89t2VZeNqIqyDKdBzO
         9W+uAq5DyHPAMyh7Atch9kUVxIBINbtZRqQA4=
Received: by 10.141.53.4 with SMTP id f4mr5608852rvk.155.1228198498794;
        Mon, 01 Dec 2008 22:14:58 -0800 (PST)
Received: from @ (adsl-76-254-71-52.dsl.pltn13.sbcglobal.net [76.254.71.52])
        by mx.google.com with ESMTPS id k37sm13457820rvb.1.2008.12.01.22.14.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 22:14:57 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102123>

This comes from conversation at the GitTogether where we thought it would
be helpful to be able to teach people to 'stage' files because it tends
to cause confusion when told that they have to keep 'add'ing them.

This continues the movement to start referring to the index as a
staging area (eg: the --staged alias to 'git diff'). Also adds a
doc file for 'git stage' that basically points to the docs for
'git add'.

Signed-off-by: Scott Chacon <schacon@gmail.com>
---

I changed the tense of a few things in the commit message and modified 
the help file to be simpler.

 Documentation/git-stage.txt |   19 +++++++++++++++++++
 git.c                       |    1 +
 2 files changed, 20 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-stage.txt

diff --git a/Documentation/git-stage.txt b/Documentation/git-stage.txt
new file mode 100644
index 0000000..7f251a5
--- /dev/null
+++ b/Documentation/git-stage.txt
@@ -0,0 +1,19 @@
+git-stage(1)
+==============
+
+NAME
+----
+git-stage - Add file contents to the staging area
+
+
+SYNOPSIS
+--------
+[verse]
+'git stage' args...
+
+
+DESCRIPTION
+-----------
+
+This is a synonym for linkgit:git-add[1].  Please refer to the
+documentation of that command.
diff --git a/git.c b/git.c
index 89feb0b..9e5813c 100644
--- a/git.c
+++ b/git.c
@@ -266,6 +266,7 @@ static void handle_internal_command(int argc, const char **argv)
 	const char *cmd = argv[0];
 	static struct cmd_struct commands[] = {
 		{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+		{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "annotate", cmd_annotate, RUN_SETUP },
 		{ "apply", cmd_apply },
 		{ "archive", cmd_archive },
-- 
1.6.0.8.gc9c8
