From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] sha1_to_hex: properly terminate the SHA1
Date: Thu, 22 Dec 2005 12:51:59 -0800
Message-ID: <7voe38j1n4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0512221854550.20025@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Dec 22 21:52:10 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpXPy-0005k8-9D
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 21:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbVLVUwD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 15:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965191AbVLVUwD
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 15:52:03 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:41147 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S965184AbVLVUwB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 15:52:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051222205030.VFBG17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Dec 2005 15:50:30 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512221854550.20025@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 22 Dec 2005 18:55:59 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13969>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> sha1_to_hex() returns a pointer to a static buffer. Some of its users
> modify that buffer by appending a newline character. Other users rely
> on the fact that you can call
>
> 	printf("%s", sha1_to_hex(sha1));
>
> Just to be on the safe side, terminate the SHA1 in sha1_to_hex().

Good catch, thanks.  The worst one is:

diff.c:727:		memcpy(one_sha1, sha1_to_hex(one->sha1), 41);
