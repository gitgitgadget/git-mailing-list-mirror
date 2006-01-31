From: Romano Giannetti <romanol@upcomillas.es>
Subject: Third newbie question: gitk --all refresh?
Date: Tue, 31 Jan 2006 17:46:48 +0100
Message-ID: <20060131164648.GA1859@pern.dea.icai.upcomillas.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
X-From: git-owner@vger.kernel.org Tue Jan 31 17:47:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3ydy-0001qG-D0
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 17:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWAaQqL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 11:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWAaQqL
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 11:46:11 -0500
Received: from cid.upco.es ([130.206.70.227]:34753 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S1751203AbWAaQqJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 11:46:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail1.upco.es (Postfix) with ESMTP id 97BD51131E9
	for <git@vger.kernel.org>; Tue, 31 Jan 2006 17:46:08 +0100 (CET)
Received: from mail1.upco.es ([127.0.0.1])
	by localhost (mail1 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 27276-06 for <git@vger.kernel.org>;
	Tue, 31 Jan 2006 17:46:07 +0100 (CET)
Received: from pern.dea.icai.upcomillas.es (pern.dea.icai.upco.es [130.206.71.186])
	by mail1.upco.es (Postfix) with ESMTP id 6C1B01131E2
	for <git@vger.kernel.org>; Tue, 31 Jan 2006 17:46:07 +0100 (CET)
Received: by pern.dea.icai.upcomillas.es (Postfix, from userid 1153)
	id DF34F102DB; Tue, 31 Jan 2006 17:46:48 +0100 (CET)
To: git@vger.kernel.org
Mail-Followup-To: Romano Giannetti <romanol@upcomillas.es>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: by amavisd-new-20030616-p7 (Debian) at upco.es
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15321>

I have a little problem: is gitk supposed to be possibly run in background
and then refresh when told? It seems to me that it can track only some
changes...  Better let git (1.0.8) speak: 

pern:~/% mkdir gitk_r
pern:~/% cd gitk_r
pern:~/gitk_r% git init-db
defaulting to local storage area
pern:~/gitk_r% echo "one" > one.txt
pern:~/gitk_r% echo "two" > two.txt
pern:~/gitk_r% git add .
pern:~/gitk_r% git commit -a -m "commit 1"
Committing initial tree efa4c546776cd5539cb54969a5e1c110b3232ee2
pern:~/gitk_r% git branch
* master
pern:~/gitk_r% git checkout -b second master
pern:~/gitk_r% git branch
  master
* second
pern:~/gitk_r% echo "three" > three.txt
pern:~/gitk_r% git add three.txt
pern:~/gitk_r% ls
one.txt  three.txt  two.txt
pern:~/gitk_r% git commit -a -m "commit second"
pern:~/gitk_r% echo "one one" >> one.txt
pern:~/gitk_r% git commit -a -m "commit on second #2"
pern:~/gitk_r% git checkout master
pern:~/gitk_r% echo "two two" >> two.txt
pern:~/gitk_r% gitk --all &
[1] 787
pern:~/gitk_r% : Now git is showing ok
pern:~/gitk_r% git pull . second
Trying really trivial in-index merge...
Wonderful.
In-index merge
 one.txt   |    1 +
 three.txt |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 three.txt
pern:~/gitk_r% : Now gitk refreshes ok

What I mean if that I select update - reread references it's all ok, I see
the merge. 

pern:~/gitk_r% git branch -d second
Deleted branch second.
pern:~/gitk_r% : Now gitk did not delete the second branch

What I mean that I can do the same update - reread references but "second"
branch stay there...

pern:~/gitk_r% : but
pern:~/gitk_r% gitk --all
pern:~/gitk_r% : this is ok

That is, the two instances of gitk --all are showing different things: the
"old" running one continue to show the old "second" branch in green.

Is this supposed to be like that? Or is "driver" (aka /me) error?

   Romano

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
http://www.dea.icai.upcomillas.es/romano/
