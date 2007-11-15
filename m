From: Wincent Colaiuta <win@wincent.com>
Subject: [BUG] t9101 (master) busted on Leopard
Date: Thu, 15 Nov 2007 14:46:14 +0100
Message-ID: <D68F81D3-5833-460B-BC7A-98C7E1D8B3E4@wincent.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 14:46:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isf3D-0002yW-W5
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 14:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755113AbXKONqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 08:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754341AbXKONqR
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 08:46:17 -0500
Received: from wincent.com ([72.3.236.74]:39612 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178AbXKONqR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 08:46:17 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAFDkFsA020263
	for <git@vger.kernel.org>; Thu, 15 Nov 2007 07:46:16 -0600
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65121>

Was just running the test suite against the master branch and saw that  
t9101 is currently failing on Leopard, and a review with git-bisect  
indicates that it has been ever since it was first introduced (in  
commit 15153451). Not sure if this problem is Leopard-specific or not  
as I only have one machine.

This is the specific test that's failing:

* FAIL 25: test propget
git-svn propget svn:ignore . | cmp - prop.expect &&
cd deeply &&
git-svn propget svn:ignore . | cmp - ../prop.expect &&
git-svn propget svn:entry:committed-rev nested/directory/.keep 	  |  
cmp - ../prop2.expect &&
git-svn propget svn:ignore .. | cmp - ../prop.expect &&
git-svn propget svn:ignore nested/ | cmp - ../prop.expect &&
git-svn propget svn:ignore ./nested | cmp - ../prop.expect &&
git-svn propget svn:ignore .././deeply/nested | cmp - ../prop.expect

The problem is that the for line:

git-svn propget svn:entry:committed-rev nested/directory/.keep

The test expects the "8", but it actually yields "7".

I'm not a git-svn user myself, but if there's anything I can do to  
help diagnose this problem further on Leopard please let me know.

Cheers,
Wincent
