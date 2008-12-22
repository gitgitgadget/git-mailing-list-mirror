From: Peter van der Does <peter@ourvirtualhome.com>
Subject: git 1.6.1-rc4 testing dependency
Date: Mon, 22 Dec 2008 11:05:44 -0500
Message-ID: <20081222110544.2003b0b3@montecarlo.grandprix.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 22 17:07:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEnJD-0006l8-4L
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 17:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbYLVQFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 11:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754801AbYLVQFs
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 11:05:48 -0500
Received: from bellona.lunarservers.com ([74.50.21.190]:33569 "EHLO
	bellona.lunarservers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754776AbYLVQFr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 11:05:47 -0500
X-Greylist: delayed 3543 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Dec 2008 11:05:47 EST
Received: from c-69-248-103-68.hsd1.nj.comcast.net ([69.248.103.68] helo=monza.grandprix.int)
	by bellona.lunarservers.com with esmtpa (Exim 4.69)
	(envelope-from <peter@ourvirtualhome.com>)
	id 1LEnHv-000787-S7
	for git@vger.kernel.org; Mon, 22 Dec 2008 08:05:47 -0800
Received: from montecarlo.grandprix.int (montecarlo.grandprix.int [192.168.1.152])
	by monza.grandprix.int (Postfix) with ESMTP id 45740102035
	for <git@vger.kernel.org>; Mon, 22 Dec 2008 11:05:44 -0500 (EST)
X-Mailer: Claws Mail 3.7.0 (GTK+ 2.14.4; i486-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bellona.lunarservers.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - ourvirtualhome.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103757>

With git 1.6.1 it it seems you need to install the locale en_US.UTF-8
otherwise it won't pass the testing during building the package. 

The locale comes in play with test:
t9129-git-svn-i18n-commitencoding.sh 
compare_svn_head_with () {
        LC_ALL=en_US.UTF-8 svn log --limit 1 `git svn info --url` | \
                sed -e 1,3d -e "/^-\{1,\}\$/d" >current &&
        test_cmp current "$1"
}

On my building machine I don't have any locales installed, making the
LC_ALL=C.
Not everybody will have this locale installed nor would they want it
installed on their machines.
Is the locale is a dependency for git svn?
Or can this test be changed? Either by not having the locale dependency
or by skipping the test completely?

I apologize if this message shows up twice.
-- 
Peter van der Does

GPG key: E77E8E98
