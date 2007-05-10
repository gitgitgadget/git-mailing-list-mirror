From: Junio C Hamano <junkio@cox.net>
Subject: Re: quick bare clones taking longer?
Date: Wed, 09 May 2007 17:27:41 -0700
Message-ID: <7v7irhr08y.fsf@assigned-by-dhcp.cox.net>
References: <7virb1sm6h.fsf@assigned-by-dhcp.cox.net>
	<20070509.150256.59469756.davem@davemloft.net>
	<7v3b25siwk.fsf@assigned-by-dhcp.cox.net>
	<20070509.162301.48802460.davem@davemloft.net>
	<7vy7jxr35a.fsf@assigned-by-dhcp.cox.net>
	<7vd519r10c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Thu May 10 02:27:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlwVX-0005nN-TY
	for gcvg-git@gmane.org; Thu, 10 May 2007 02:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbXEJA1n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 20:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755452AbXEJA1n
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 20:27:43 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:63504 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696AbXEJA1m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 20:27:42 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070510002742.FSQX26353.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 20:27:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xCTh1W00R1kojtg0000000; Wed, 09 May 2007 20:27:42 -0400
In-Reply-To: <7vd519r10c.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 09 May 2007 17:11:15 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46815>

Junio C Hamano <junkio@cox.net> writes:

> Junio C Hamano <junkio@cox.net> writes:
>
>> David Miller <davem@davemloft.net> writes:
>>
>>> From: Junio C Hamano <junkio@cox.net>
>>> Date: Wed, 09 May 2007 15:59:23 -0700
>>>
>>>> The above sequence is called before we create the new directory
>>>> and chdir to it.  Maybe pwd has funny behaviour (e.g. $PWD) and
>>>> we need to explicitly say /bin/pwd or somesuch...
>>>
>>> Indeed:
>>>
>>> [davem@hera ~]$ pwd
>>> /home/davem
>>> [davem@hera ~]$ cd git
>>> [davem@hera git]$ pwd
>>> /home/davem/git
>>> [davem@hera git]$ /bin/pwd
>>> /home/ftp/pub/scm/linux/kernel/git/davem
>>> [davem@hera git]$ 
>>
>> Thanks.
>
> This would fix it, but I find this kind of ugly.

Side note.  Earlier you said:

   master.kernel.org just upgraded to git-1.5.1.4 and I notice
   that doing something like this:

           git clone --bare -n -l -s ../torvalds/linux-2.6.git test-2.6.git

   is no longer an instantaneous operation, it seems to be doing a lot
   of stuff now:

But I do not see any difference between v1.5.1.3 and v1.5.1.4 in
this area.  In fact, that get_repo_base() shell function has not
changed since v0.99.
