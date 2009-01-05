From: "Anders Melchiorsen" <mail@cup.kalibalik.dk>
Subject: [BUG] unable to checkout branch with a clean worktree
Date: Mon, 5 Jan 2009 16:42:48 +0100 (CET)
Message-ID: <35079.bFoQE3daRhY=.1231170168.squirrel@webmail.hotelhot.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 05 16:45:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJrdb-0000k6-Bv
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 16:45:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394AbZAEPno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 10:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754223AbZAEPno
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 10:43:44 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:38890 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754059AbZAEPnn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 10:43:43 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 09FF9308D4
	for <git@vger.kernel.org>; Mon,  5 Jan 2009 16:42:49 +0100 (CET)
Received: from webmail.hotelhot.dk (mail.hotelhot.dk [192.168.0.190])
	by mail.hotelhot.dk (Postfix) with ESMTP id D50D23012A
	for <git@vger.kernel.org>; Mon,  5 Jan 2009 16:42:48 +0100 (CET)
X-Squirrel-UserHash: NQYRRTwcNktTVUlTWFZaWRRVWg==
X-Squirrel-FromHash: bFoQE3daRhY=
User-Agent: SquirrelMail/1.4.13
X-Priority: 3 (Normal)
Importance: Normal
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104579>

Git v1.6.1: The final checkout fails with an error about merge conflicts.
However, the worktree is clean, and I am not trying to do a merge.

Is this a known issue? If so, what is the particular issue that we should
avoid?


Regards,
Anders.


cd $(mktemp -d repo.XXXXXX)
git init

echo init >start
git add start
git commit -m A

git branch parallel

mkdir a b
echo x >a/one
echo y >a/two
echo z >b/three
git add .
git commit -m B

git checkout parallel
mkdir -p a/one a/two b
echo xx >a/one/cat
echo yy >a/two/cow
echo zz >b/unrelated
git add .
git commit -m C

# This fails:
git checkout master
