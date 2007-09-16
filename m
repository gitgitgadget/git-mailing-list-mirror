From: Mike Hommey <mh@glandium.org>
Subject: Blaming diffs
Date: Sun, 16 Sep 2007 18:38:29 +0200
Organization: glandium.org
Message-ID: <20070916163829.GA6679@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 16 18:39:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWx9T-0004D6-Uf
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 18:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbXIPQjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 12:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbXIPQjN
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 12:39:13 -0400
Received: from vawad.err.no ([85.19.200.177]:54095 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303AbXIPQjM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 12:39:12 -0400
Received: from aputeaux-153-1-25-44.w82-124.abo.wanadoo.fr ([82.124.187.44] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IWx9F-0006j1-Ty
	for git@vger.kernel.org; Sun, 16 Sep 2007 18:39:09 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1IWx8f-0001jx-5Z
	for git@vger.kernel.org; Sun, 16 Sep 2007 18:38:29 +0200
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58323>

Hi,

It seems to me there is no tool to "blame diffs", i.e. something to know
what commit(s) is(are) responsible for a set of changes.

For example, the following script tries to get the set of commits
involved in the changes between $A and $B. Note it only works for text
additions. 

git diff --unified=0 $A $B | awk 'BEGIN { FS="(^(--- a/|+++ b/)|^@@ -[0-9,]+ \\+| @@)" } /^---/ || ( /^+++ b\/(.*)/ && file=="" ) { file = $2 } /^@@/ {split($2, a, /,/); a[2] = a[2] ? a[2] + a[1] - 1 : a[1]; print "git blame -l -L " a[1] "," a[2], "'$A..$B'", file }' | sh | cut -f 1 -d " " | sort -u

Has anyone tried to work on something similar yet ?

If not, as git users, what kind of output would you expect from such a
tool, and where do you think this should lie (extension to git diff, or
separate tool) ?

Cheers,

Mike
