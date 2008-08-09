From: Pieter de Bie <pieter@frim.nl>
Subject: Re: [PATCH] checkout --track: make up a sensible branch name if '-b' was omitted
Date: Sat, 9 Aug 2008 23:44:49 +0200
Message-ID: <A6E466C6-C3B5-40EB-940C-516CF4D02ADF@frim.nl>
References: <alpine.DEB.1.00.0808091559460.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vtzdu6nb7.fsf@gitster.siamese.dyndns.org> <7vvdya55ur.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0808092302520.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vsktd51wg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 00:18:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRwlQ-0007VL-QE
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 00:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbYHIWRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 18:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752359AbYHIWRS
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 18:17:18 -0400
Received: from frim.nl ([87.230.85.232]:49393 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752288AbYHIWRS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Aug 2008 18:17:18 -0400
X-Greylist: delayed 1935 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Aug 2008 18:17:17 EDT
Received: from ip63-33-210-87.adsl2.static.versatel.nl ([87.210.33.63] helo=[192.168.1.244])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pieter@frim.nl>)
	id 1KRwF7-0001aq-2n; Sat, 09 Aug 2008 23:44:57 +0200
In-Reply-To: <7vsktd51wg.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91789>


On Aug 9, 2008, at 11:11 PM, Junio C Hamano wrote:

>>> (1) You may not necessarily are used to --track, but may still  
>>> want this
>>>    done.  It might not be a bad idea to associate this "local  
>>> dwimming"
>>>    to creation of a new branch.  In other words, all of these:
>>>
>>>    $ git checkout -b origin/next
>>
>> This cannot be dwimmed, as it literally means "start a new branch  
>> called
>> 'origin/next' from HEAD".
>
> Right.  Forget this part.

This is too bad. I often see people make mistakes like

	git checkout -b origin/master
or
	git checkout -b origin/master origin/master

which should be

	git checkout -b origin/master master

I think both forms should at least be an error if the remote branch  
"origin/master" already exists, as then suddenly they aren't reachable  
anymore by using "origin/master".

Changing the behaviour to mean "git checkout -b origin/master master"  
will change the meaning, but who uses -b with an existing remote  
branch anyway? I think the current behaviour leads to more confusion  
in every case and should at least error out ("Error: creating a local  
repository with the same name as the remote is not allowed") or do  
what it's meant to do, which is create a local repository with the  
trailing part.

Just my .02,

- Pieter
