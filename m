From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] To make GIT-VERSION-FILE, search for git more widely
Date: Thu, 07 May 2009 11:02:18 +0200
Message-ID: <4A02A39A.3000407@drmicha.warpmail.net>
References: <1241684666-18956-1-git-send-email-matthias.andree@gmx.de> <7vws8te2ht.fsf@alter.siamese.dyndns.org> <4A02A008.30800@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthias Andree <matthias.andree@gmx.de>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 07 11:02:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1zUw-0005Mn-C9
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 11:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916AbZEGJC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 05:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754412AbZEGJC2
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 05:02:28 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:40069 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751966AbZEGJC1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2009 05:02:27 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 450E43409F8;
	Thu,  7 May 2009 05:02:27 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 07 May 2009 05:02:27 -0400
X-Sasl-enc: j1e2LDj0GPXN36qSSHbut/H7/BkKTcOlFBzuAH10c72r 1241686946
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 423A23BB38;
	Thu,  7 May 2009 05:02:26 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090506 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <4A02A008.30800@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118452>

Johannes Sixt venit, vidit, dixit 07.05.2009 10:47:
> Junio C Hamano schrieb:
>> Matthias Andree <matthias.andree@gmx.de> writes:
>>
>>> Problem: when git is installed into /usr/local/bin, running 'sudo make
>>> install' won't find git in $PATH (because sudo strips PATH, for instance
>>> on openSUSE 11.1, and doesn't include /usr/local/whatever).
>>
>> That sounds like a bug/misfeature in sudo (which I do not use) to me.
> 
> sudo resets the environment, in particular also PATH. Why would this be a bug?
> 
> Current distros set env_reset in /etc/soduers for a reason. Not that I
> know the reason in detail, but I won't claim that I'm more clever with
> regards to security issues than distro packagers; so I trust that if they
> do it, then it makes sense.
> 
> -- Hannes

sudo's behaviour is fine, but the OP's is not: doing "sudo make install"
amounts to building git as root, unless you have done a make as non-root
before. If you have done that make then GIT-VERSION-FILE will be
up-to-date, and GIT-VERSION-GEN will not even be called by "make install".

So I think the proposed patch would encourage wrong behaviour. (also,
the commit message mixes up ...-GEN and ...-FILE)

Michael
