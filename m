From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Is anybody actually using git-cherry.sh?
Date: Fri, 23 Jun 2006 18:22:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606231818140.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Jun 23 18:23:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtoQ6-0001vM-Qw
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 18:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbWFWQWH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 12:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751744AbWFWQWH
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 12:22:07 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:25833 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751738AbWFWQWG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 12:22:06 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 3B2952220
	for <git@vger.kernel.org>; Fri, 23 Jun 2006 18:22:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 2FA34221F
	for <git@vger.kernel.org>; Fri, 23 Jun 2006 18:22:05 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 151E021DC
	for <git@vger.kernel.org>; Fri, 23 Jun 2006 18:22:05 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22430>

Hi,

from git-cherry.sh:

-- snip --
for c in $inup
do
        git-diff-tree -p $c
done | git-patch-id |
while read id name
do
        echo $name >>$patch/$id
done
-- snap --

AFAICS this _must_ be broken. git-diff-tree -p <ent> does not emit 
"diff-tree <sha1>", and neither "commit <sha1>" lines. So this code would 
yield just one file, treating all diffs as one huge diff. A quick fix 
would be this change (without the patch I sent out earlier):

+	echo "diff-tree $c"
 	git-diff-tree -p $c

Am I wrong?

Ciao,
Dscho
