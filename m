From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: RFC: New diff-delta.c implementation
Date: Sat, 22 Apr 2006 13:36:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604221333470.23166@alien.or.mcafeemobile.com>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 22 22:36:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXOpx-0003S1-UF
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 22:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWDVUgL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 16:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWDVUgL
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 16:36:11 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:38306 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1751162AbWDVUgK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Apr 2006 16:36:10 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.dev.mdolabs.com with [XMail 1.23 ESMTP Server]
	id <S1CB7DC> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Sat, 22 Apr 2006 13:36:08 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Geert Bosch <bosch@adacore.com>
In-Reply-To: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19054>

On Fri, 21 Apr 2006, Geert Bosch wrote:

> I wrote a new binary differencing algorithm that is both faster
> and generates smaller deltas than the current implementation.
> The format is compatible with that used by patch-delta, so
> it should be easy to integrate.
>
> Originally, I wrote this for the GDIFF format, see 
> http://www.w3.org/TR/NOTE-gdiff-19970901.
> The adaptation for GIT format was relatively simple, but is not thoroughly 
> tested.
> The code is not derived from libxdiff, but uses the rabin_slide function 
> written
> by David Mazieres (dm@uun.org). Also the tables are generated using his code.
> Finally, this was developed on Darwin, and not a Linux system, so some 
> changes may be needed.
>
> Initial testing seems quite positive, take for example git-1.2.5.tar vs 
> git-1.2.6.tar
> on my PowerBook (both with -O2 -DNDEBUG):
>
> current: 2.281s, patch size 36563
> new    : 0.109s, patch size 16199
>
> Please feel free to play around with this code, and give feedback.
> Keep in mind this wasn't originally written for GIT, and C is not
> my native language, so don't mind my formatting etc.

Geert, I saw you're using a shift of 55 bits, that gives an degree of the 
root polynomial of 63, that is not prime. Where did you get the root 
polynomial, and why you did not chose 61 as degree of the root?
Just curious ...



- Davide
