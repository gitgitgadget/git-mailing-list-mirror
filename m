From: Tommy Thorn <tommy-git@thorn.ws>
Subject: Bug in .gitignore handling
Date: Wed, 26 Mar 2008 13:01:58 -0700
Message-ID: <47EAABB6.30803@thorn.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 21:03:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jebpf-0007aW-K1
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 21:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755284AbYCZUCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 16:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754730AbYCZUCF
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 16:02:05 -0400
Received: from server204.webhostingpad.com ([69.65.0.218]:57522 "EHLO
	server204.webhostingpad.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753982AbYCZUCE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2008 16:02:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=thorn.ws;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir;
	b=Rg4c44IWWjZubcblxbVOaBTkdxgEugccaGlh9ji+7Z+SSDfPZyICx7/zrXvd8Sscaz1g7aOKcuSB64FCrRettPsPEWIm9t7QcnAJm3vVrb2UwA7+1rNaT9WumIwRQ28j;
Received: from [216.228.112.21] (helo=dhcp-172-16-169-183.nvidia.com)
	by server204.webhostingpad.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <tommy-git@thorn.ws>)
	id 1Jebom-0008KD-2d
	for git@vger.kernel.org; Wed, 26 Mar 2008 15:01:52 -0500
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server204.webhostingpad.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - thorn.ws
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78303>

For reasons too upsetting to explain, I have to keep a collection of 
symlinks inside my tree but outside of git's control, such as

mydir/foo -> ../otherdir/foo

To stop git clean from removing it, I added "foo" to .gitignore

The problem is that I foo appears in build paths inside the tree that I 
would like git clean to pick up, however the pattern "foo" is applied 
generally and matches stuff like

mydir/mousetrap/foo/objs

According to the man page, I should be able to change .gitignore to 
"foo/" to stop it from looking recursively, but that doesn't work, as 
now git clean -n -f -d wants to remove mydir/foo but not mydir/foo/objs

My desperate attempts "./foo" and "^foo" also didn't work. Please note 
that this is a vastly simplified version of the real problem, so I can't 
just use "!mousetrap/foo".

It seems "foo/" _should_ work even though foo isn't a directory.

Thanks
Tommy
