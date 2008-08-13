From: "David Neu" <david@davidneu.com>
Subject: git-filter-branch behavior
Date: Wed, 13 Aug 2008 12:14:20 -0400
Message-ID: <e0b44a890808130914oced739cy2aaf54aebfcfcbce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 18:15:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTJ0P-0005y8-NI
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 18:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbYHMQOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 12:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbYHMQOW
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 12:14:22 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:64230 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbYHMQOV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 12:14:21 -0400
Received: by yx-out-2324.google.com with SMTP id 8so34993yxm.1
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 09:14:20 -0700 (PDT)
Received: by 10.115.91.11 with SMTP id t11mr31921wal.41.1218644060194;
        Wed, 13 Aug 2008 09:14:20 -0700 (PDT)
Received: by 10.70.53.6 with HTTP; Wed, 13 Aug 2008 09:14:20 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92236>

All,

Running

git-filter-branch --tree-filter 'rm -rf subdir/' -- --all

as shown below seems to leave empty commits
corresponding to subdir/ in the tree.  Is this the expected
behavior?  If so is there a command to remove the empty
commits?  Using git-rebase -i to edit the commit history
works, but is a bit tedious on a large tree.

Many thanks!

Cheers,
David

***** ***** ***** ***** *****

mkdir test-filter-branch
cd test-filter-branch

echo 'base1' > base.txt
mkdir subdir
echo 'sub1' > subdir/sub.txt
git-init
git-add .
git-commit -a -m "Commit 1"

echo 'base2' >> base.txt
git-commit -a -m "Commit 2"

echo 'sub3' > subdir/sub.txt
git-commit -a -m "Commit 3"

echo 'base4' >> base.txt
echo 'sub4' > subdir/sub.txt
git-commit -a -m "Commit 4"

git-filter-branch --tree-filter 'rm -rf subdir/' -- --all

gitk &
