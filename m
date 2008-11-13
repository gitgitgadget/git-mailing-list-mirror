From: "Anders Melchiorsen" <mail@cup.kalibalik.dk>
Subject: Re: [BUG] fatal error during merge
Date: Fri, 14 Nov 2008 00:34:03 +0100 (CET)
Message-ID: <48332.N1gUGH5fRhE=.1226619243.squirrel@webmail.hotelhot.dk>
References: <53328.bFoQE3daRhY=.1226568134.squirrel@webmail.hotelhot.dk>
    <2008-11-13-14-23-19+trackit+sam@rfc1149.net>
    <20081113140323.GA10267@neumann>
    <2008-11-13-15-26-33+trackit+sam@rfc1149.net>
    <20081113145325.GD29274@neumann>
    <57814.N1gUGH5fRhE=.1226596012.squirrel@webmail.hotelhot.dk>
    <20081113180931.GE29274@neumann>
    <20081113230932.GA8552@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	"Samuel Tardieu" <sam@rfc1149.net>, git@vger.kernel.org,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 00:35:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0lib-0003Uq-GR
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 00:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbYKMXeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 18:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbYKMXeE
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 18:34:04 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:47812 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374AbYKMXeC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 18:34:02 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 554EB14068;
	Fri, 14 Nov 2008 00:34:03 +0100 (CET)
Received: from webmail.hotelhot.dk (mail.hotelhot.dk [192.168.0.190])
	by mail.hotelhot.dk (Postfix) with ESMTP id 13E0214062;
	Fri, 14 Nov 2008 00:34:03 +0100 (CET)
X-Squirrel-UserHash: NQYRRTwcNktTVUlTWFZaWRRVWg==
X-Squirrel-FromHash: N1gUGH5fRhE=
In-Reply-To: <20081113230932.GA8552@blimp.localdomain>
User-Agent: SquirrelMail/1.4.13
X-Priority: 3 (Normal)
Importance: Normal
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100927>

Alex Riesen wrote:

> Well, the case is a bit unfair: all files have the same SHA-1!

Here is an updated test, where all files have different SHA-1. It still
fails.

Your patch got rid of the errors and it commits the merged tree. But the
working tree is not updated correctly, so the moved file disappears.


Cheers,
Anders.


mkdir am-merge-fail
cd am-merge-fail
git init

mkdir before
yes | head -n100 >before/100
touch after
git add before/100 after
git commit -minitial
git branch parallel

git rm before/100 after
mkdir after
yes | head -n99 >after/99
git add after/99
git commit -mmove

git checkout parallel
echo "Just to cause a non-ff" >other
git add other
git commit -mparallel

git merge master
