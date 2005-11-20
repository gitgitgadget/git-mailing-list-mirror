From: Yaacov Akiba Slama <ya@slamail.org>
Subject: Simple proxy test (was Re: What's in master tonight)
Date: Sun, 20 Nov 2005 16:28:38 +0200
Message-ID: <43808816.4050501@slamail.org>
References: <7v7jb31zm2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 15:30:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdqBu-0001Yk-BH
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 15:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbVKTO2u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 09:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbVKTO2u
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 09:28:50 -0500
Received: from [195.140.142.33] ([195.140.142.33]:34018 "EHLO
	c1-033.cyaris.net") by vger.kernel.org with ESMTP id S1751232AbVKTO2u
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 09:28:50 -0500
Received: from localhost ([127.0.33.1] helo=localhost.localdomain)
	by c1-033.cyaris.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1EdqBM-00015O-QR; Sun, 20 Nov 2005 15:28:47 +0100
Received: from [127.0.0.1] (helo=[127.0.0.1])
	by localhost.localdomain with esmtp (Exim 4.54)
	id 1EdqBK-0007Oz-SJ; Sun, 20 Nov 2005 16:28:38 +0200
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jb31zm2.fsf@assigned-by-dhcp.cox.net>
X-Spam-Score: -2.8 (--)
X-Spam-Report: Spam detection software, running on the system "c1-033.cyaris.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Junio C Hamano wrote: >proxy for git:// transport: > >
	I do not have any pending issues on this patch, and I > think it is
	ready to go in when somebody, preferably > other than the original
	author, says it is useful and > does not break things. > I tested the
	proxy code from a place when the git:// port is blocked. [...] 
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12383>

Junio C Hamano wrote:

>proxy for git:// transport:
>
>	I do not have any pending issues on this patch, and I
>	think it is ready to go in when somebody, preferably
>	other than the original author, says it is useful and
>	does not break things.
>
I tested the proxy code from a place when the git:// port is blocked.

1) I made a ssh socks tunel (ssh -D 2080 a-remote-server).
2) I compiled connect.c from 
http://zippo.taiyo.co.jp/~gotoh/ssh/connect.html
3) I created a simple script called myproxy:

#!/bin/sh

/path/to/connect -S localhost:2080 $@

4) GIT_PROXY_COMMAND=/path/to/myproxy
cg-clone git://git.kernel.org/pub/scm/git/git.git git2 worked perfectly

4bis)
% cat .git/config
[core]
gitproxy = /path/to/myproxy for kernel.org

cg update worked perfectly.

--yas
