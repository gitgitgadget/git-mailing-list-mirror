From: "Anders Melchiorsen" <mail@cup.kalibalik.dk>
Subject: Re: correct git merge behavior or corner case?
Date: Mon, 20 Apr 2009 12:10:35 +0200 (CEST)
Message-ID: <41354.bFoQE3daRhY=.1240222235.squirrel@webmail.hotelhot.dk>
References: <4ac8254d0904191540j68246cd8qa36a034209d4c800@mail.gmail.com>
    <alpine.DEB.1.00.0904201148150.6955@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 20 12:21:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvqcs-0005Pa-Rl
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 12:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbZDTKTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 06:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753647AbZDTKTm
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 06:19:42 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:45869 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753225AbZDTKTl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 06:19:41 -0400
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Apr 2009 06:19:41 EDT
Received: from webmail.hotelhot.dk (web.hotelhot.dk [192.168.0.170])
	by mail.hotelhot.dk (Postfix) with ESMTP id 38E7444D8;
	Mon, 20 Apr 2009 12:10:35 +0200 (CEST)
X-Squirrel-UserHash: NQYRRTwcNktTVUlTWFZaWRRVWg==
X-Squirrel-FromHash: bFoQE3daRhY=
In-Reply-To: <alpine.DEB.1.00.0904201148150.6955@intel-tinevez-2-302>
User-Agent: SquirrelMail/1.4.13
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116960>

Johannes Schindelin wrote:

> Second, he does not state what he expects to see instead.  And for the
> love of God, I cannot see what should be wrong in the output he gets.
> Another few notches down.

I think that I managed to recreate what he is describing.


#!/bin/bash

cd $(mktemp -d repo.XXXXX)

git init

touch date
git add date
git commit -memptydate

git branch parallel

touch LICENSE
git add LICENSE
git commit -mLICENSE

git checkout parallel
date >date
git add date
git commit -mdate

git checkout master
git rm date
git commit -mnodate

git merge parallel

cat LICENSE
