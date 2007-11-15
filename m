From: Wincent Colaiuta <win@wincent.com>
Subject: [BUG] t7004 (master) busted on Leopard
Date: Thu, 15 Nov 2007 14:38:57 +0100
Message-ID: <17E3F66C-4644-4B64-817C-88062727A2D9@wincent.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 14:39:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsewV-0000OV-A6
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 14:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756077AbXKONjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 08:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757244AbXKONjD
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 08:39:03 -0500
Received: from wincent.com ([72.3.236.74]:39601 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753520AbXKONjB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 08:39:01 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAFDcxTl020134
	for <git@vger.kernel.org>; Thu, 15 Nov 2007 07:39:00 -0600
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65120>

Commit 4d8b1dc850 added a couple of tests to t7004, and my testing  
reveals that this one has been broken on Leopard since then:

* FAIL 83: message in editor has initial comment
GIT_EDITOR=cat git tag -a initial-comment > actual || true &&
test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0

(Not sure whether this affects other platforms, or versions of Mac OS  
X prior to Leopard, as I only have one machine here.)

The problem is the version of sed that ships with Leopard fails to  
match the initial comment with this syntax:

sed -n "/^\(#\|\$\)/p" actual

An alternative that works is:

sed -n "/^[#\$]/p" actual

Can someone with knowledge of sed compatibility across multiple  
platforms suggest an alternative which will work on a wider range of  
systems?

Cheers,
Wincent
