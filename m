From: Werner LEMBERG <wl@gnu.org>
Subject: serious problem with `git format-patch' & `git am'
Date: Wed, 25 Feb 2009 23:03:52 +0100 (CET)
Message-ID: <20090225.230352.177616203.wl@gnu.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: keithp@keithp.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 23:06:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcRsl-0001c2-9f
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 23:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759360AbZBYWEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 17:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758766AbZBYWEG
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 17:04:06 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:56126 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758643AbZBYWEF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 17:04:05 -0500
Received: from localhost (77.118.133.164.wireless.dyn.drei.com [77.118.133.164])
	by mrelayeu.kundenserver.de (node=mrelayeu4) with ESMTP (Nemesis)
	id 0ML21M-1LcRrC0K6J-0005iZ; Wed, 25 Feb 2009 23:04:01 +0100
X-Mailer: Mew version 6.2.50 on Emacs 22.3.1 / Mule 5.0 (SAKAKI)
X-Provags-ID: V01U2FsdGVkX1/SzgTreTco9spjY6S3xrBwNII8E1kfuiAUqzL
 95UVAJUsv3KiHnKdJYYiGXzu+nKD/Y4qElQtwE0LluriOBqxDU
 YJaRemwr05Y4sNJ7q7eMg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111504>


[both version 1.6.0.2 and git from 2009-01-24]

Folks,


I'm going to convert the FreeType CVS repository to git, using Keith
Packard's `parsecvs'.  It sometimes happens that there are git entries
titled

  *** empty log message ***

I want to massage the git repository before publishing it, replacing
those entries with something more meaningful.

The last time I tested this (using git 1.5.something, I no longer
remember the exact version) I did the following:

  . git format-patch <start>..HEAD
    git reset --hard <start>

  . Edit the `Subject:' field in the created *.patch files where
    necessary.

  . git am --whitespace=nowarn *.patch

Unfortunately, this no longer works as before, and since I can't find
a hint in the docs about this change I wonder whether it is a bug.

With git 1.5.something, if the first paragraph of the commit message
(as output by parsecvs) looks like this

   foo foo foo foo
   bar bar bar bar
   baz baz baz baz

it is emitted exactly as-is (after `git format-patch' & `git am');
gitk shows `foo foo foo foo' as the first line.  However, git version
1.6.0.2 and the current git both convert newlines to spaces in the
first paragraph!  I now get

  foo foo foo foo bar bar bar bar baz baz baz baz

as the beginning of the commit message which is VERY bad since
CVS-style entries often have a long first paragraph, causing
ugly-looking, overlong lines.

In case this is an intended change I ask you urgently to provide an
option to get back the old behaviour of `git format-patch' & `git am'.


    Werner
