From: Guido Stevens <guido.stevens@cosent.net>
Subject: Re: git-svn breakage on repository rename
Date: Sun, 06 Dec 2009 17:24:36 +0100
Organization: Cosent   -:-   s h a r i n g   m a k e s   s e n s e
Message-ID: <4B1BDAC4.9070305@cosent.net>
References: <4B197078.6050203@cosent.net> <20091205222251.GA2120@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, George Kuk <George.Kuk@nottingham.ac.uk>,
	clark.alex@gmail.com, wichert@wiggy.net, admins@lists.plone.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Dec 06 17:46:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHKFT-0003lg-QH
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 17:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756722AbZLFQqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 11:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756601AbZLFQqC
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 11:46:02 -0500
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:60069 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755824AbZLFQqB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 11:46:01 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 8FE823A086
	for <git@vger.kernel.org>; Sun,  6 Dec 2009 17:25:05 +0100 (CET)
Received: from [192.168.178.23] (isis-torproxy.xs4all.nl [80.101.174.248])
	by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 38E09225173;
	Sun,  6 Dec 2009 17:17:23 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <20091205222251.GA2120@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134678>

Eric, thanks!

Plone admins: I can now confirm it was not a svn corruption. Adding the 
"--no-follow-parent" switch to git svn clone makes it possible to check 
out the Plone svn into git -- at least the commits since the rename.

That one might be relevant for anybody who wants to contribute to the 
Plone code base from a git-centered workflow.

Thanks everybody for helping to solve this problem! I can now integrate 
the analysis of Products.CMFPlone into the overall Plone ecosystem 
analysis, and it would have been very awkward not to be able to do that 
because of this renaming issue. Again: thanks.

:*CU#

Eric Wong wrote:
> Guido Stevens <guido.stevens@cosent.net> wrote:
>> ----------------------------------------------------
>> To reconstruct this error:
>> ----------------------------------------------------
>>
>> $ git svn init https://svn-mirror.plone.org/svn/plone/Plone/trunk Plone
>> $ cd Plone
>> $ git svn fetch
> 
> Since Plone appears to use a standard trunk/branches/tags layout
> recommended by SVN developers, can you try this instead?:
> 
>   git svn clone -s http://svn-mirror.plone.org/svn/plone/Plone

That one breaks completely, silently.

> 
> If you don't care about branches/tags at all, you can also try
> 
>   git svn clone --no-follow-parent \
>     https://svn-mirror.plone.org/svn/plone/Plone/trunk Plone

Yep, that one does the trick.

It does what it says though: it stops at the rename boundary 
22715->22716. Luckily I can do other checkouts on the other names that 
this package has had and complete my analysis anyway.

:*CU#
-- 
***   Guido A.J. Stevens        ***   tel: +31.43.3618933    ***
***   guido.stevens@cosent.nl   ***   Postbus 619            ***
***   http://www.cosent.nl      ***   6200 AP  Maastricht    ***

             s h a r i n g    m a k e s    s e n s e

	
