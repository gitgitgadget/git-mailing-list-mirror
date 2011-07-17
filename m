From: Mike Shal <marfey@gmail.com>
Subject: git show-branch --topics and merge commits
Date: Sun, 17 Jul 2011 19:56:26 -0400
Message-ID: <CA+6x0LWXz-SpnZjdiV3UKJzUz3+0LiMOsbZHTn2gJ+v6bPGndA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 01:56:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QibCL-00006Y-0l
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 01:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756382Ab1GQX42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jul 2011 19:56:28 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47750 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756341Ab1GQX41 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 19:56:27 -0400
Received: by vws1 with SMTP id 1so1835470vws.19
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 16:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=DDsf15xZ7bCCRurohmP7cuDJK5nfkELByYHHuB7FU3o=;
        b=jUsveS06j6wXsoUygEqZVTtHsyUfYY7rTzMEbCpV3ToN+1VtaFtFNRFISAizLX5gTk
         n5CxoX0YCRzIDJX+Rn+TXI/gfjc91RG4xlV8lttgP6cL5V2FJKrrnoREkQ7cZt5ZrLlC
         Mal57ol1gruknsXvQJdwBfGzs729ZjLlsUZTk=
Received: by 10.52.117.234 with SMTP id kh10mr561324vdb.42.1310946986861; Sun,
 17 Jul 2011 16:56:26 -0700 (PDT)
Received: by 10.52.188.102 with HTTP; Sun, 17 Jul 2011 16:56:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177325>

Hello,

I'm trying to use 'git show-branch --topics' to list the commits on a
branch that are not yet in master. Normally this works fine, but after
merging master up to newbranch, it comes up blank (I would expect to
still see commits on newbranch that aren't on master). Eg, with a
history like so:

$ git log --graph --oneline
*   94968cf Merge branch 'master' into newbranch
|\
| * 223c001 more text
* | 13766bd new
|/
* ad878b4 ok

(newbranch on the left, master on the right)

I get the following output from git show-branch:

$ git show-branch --topics master newbranch
! [master] more text
 * [newbranch] Merge branch 'master' into newbranch
--
 - [newbranch] Merge branch 'master' into newbranch
+* [master] more text

I would expect to see the 'new' commit here, since it hasn't been
merged to master. The man page for git-show-branch says this should be
equivalent to 'git rev-list ^master newbranch', but when I run that I
get the expected output:

$ git rev-list ^master newbranch
94968cf2753b97481434f0813271659e08811177
13766bdc28df3841e25c43b53748e37f73fadb9f

So rev-list shows my merge commit and the 'new' commit, but
show-branch --topics doesn't show 'new'. Is this the expected
behavior? If so, what is the best way to get a list of changes on a
topic branch that periodically has had the master branch merged into
it?

Thanks,
-Mike
