From: Christos Trochalakis <yatiohi@ideopolis.gr>
Subject: Maintaining an html branch
Date: Tue, 25 May 2010 09:43:22 +0300
Message-ID: <AANLkTimMVn8fMVBmfNi4vR3kk3cXF2gq0Y9Ij5w3cl15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 25 09:08:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGoF8-0007CD-4B
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 09:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198Ab0EYHHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 03:07:54 -0400
Received: from poseidon.ceid.upatras.gr ([150.140.141.169]:57967 "EHLO
	poseidon.ceid.upatras.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723Ab0EYHHy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 03:07:54 -0400
X-Greylist: delayed 1469 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 May 2010 03:07:53 EDT
Received: from mail.ceid.upatras.gr (unknown [10.1.0.143])
	by poseidon.ceid.upatras.gr (Postfix) with ESMTP id 104F1EB4856
	for <git@vger.kernel.org>; Tue, 25 May 2010 09:43:23 +0300 (EEST)
Received: from localhost (europa.ceid.upatras.gr [127.0.0.1])
	by mail.ceid.upatras.gr (Postfix) with ESMTP id D34701601B3
	for <git@vger.kernel.org>; Tue, 25 May 2010 09:43:23 +0300 (EEST)
X-Virus-Scanned: amavisd-new at ceid.upatras.gr
Received: from mail.ceid.upatras.gr ([127.0.0.1])
	by localhost (europa.ceid.upatras.gr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CFi1Uoefsd2R for <git@vger.kernel.org>;
	Tue, 25 May 2010 09:43:23 +0300 (EEST)
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by mail.ceid.upatras.gr (Postfix) with ESMTP id 9550B1601B2
	for <git@vger.kernel.org>; Tue, 25 May 2010 09:43:23 +0300 (EEST)
Received: by fg-out-1718.google.com with SMTP id e12so149915fga.1
        for <git@vger.kernel.org>; Mon, 24 May 2010 23:43:22 -0700 (PDT)
Received: by 10.103.50.13 with SMTP id c13mr4877272muk.63.1274769802764; Mon, 
	24 May 2010 23:43:22 -0700 (PDT)
Received: by 10.103.193.13 with HTTP; Mon, 24 May 2010 23:43:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147673>

Hello,

I would like to maintain an html branch for my repo, containing files
under my '_site/' dir that is not version controlled.

Below is a first draft that works, but as I am not really familiar
with git plumbing, I'd appreciate any comments on a better way or
style to to write it.

#!bash
jekyll --no-auto             # build the static website on _site/ dir
rm .git/html.index
export GIT_INDEX_FILE=.git/html.index
git add -f _site
tree_id=$(git write-tree --prefix=_site/)
new_commit=$(echo "New website"|git commit-tree $tree_id -p html)
git update-ref html $new_commit
rm .git/html.index

Thanks,
Chris
