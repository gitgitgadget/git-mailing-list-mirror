From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH 0/2] Custom low-level merge driver support.
Date: Wed, 18 Apr 2007 13:09:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704181304220.2806@qynat.qvtvafvgr.pbz>
References: <11768880622402-git-send-email-junkio@cox.net><Pine.LNX.4.64.070
 4181247410.12094@racer.site>  <20070418153445.GC12888@admingilde.org><alpine.LFD.0.98.0704180910120.2828@
 woody.linux-foundation.org><7vslaxhamd.fsf@assigned-by-dhcp.cox.net> 
 <alpine.LFD.0.98.0704181136360.2828@woody.linux-foundation.org><7vzm55fqyv.
 fsf@assigned-by-dhcp.cox.net>  <alpine.LFD.0.98.0704181246160.2828@woody.linux-foundation.org><7vk5w9fnjx.
 fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0704181330050.2828@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Waitz <tali@admingilde.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 22:43:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeGzV-0000MN-Un
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 22:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992669AbXDRUmv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 16:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992663AbXDRUmv
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 16:42:51 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:44067 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S2992654AbXDRUmd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 16:42:33 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Wed, 18 Apr 2007 13:42:33 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Wed, 18 Apr 2007 13:42:06 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <alpine.LFD.0.98.0704181330050.2828@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44943>

On Wed, 18 Apr 2007, Linus Torvalds wrote:

> On Wed, 18 Apr 2007, Junio C Hamano wrote:
>>
> So maybe each strategy could have "sub-strategies" for other file types.
>
> Ie something like
>
> 	[merge "ours"]
> 		name = pick our own version
> 		driver = /bin/true
> 		symlinks = /bin/true
>
> ie we'd use tyhe "driver" name for regular files, and the "symlinks" name
> for symlinks and if no "symlinks" entry exists, we error it out as a
> conflict?

this is starting to sound odd here.

we have .gitattributes define file types and what merge to use on those types

then we have this section define different merges to use on different file 
types.

I think that we would be better off defining a way for the existing type 
definitions to include the 'it's a symlink' type of info (and then deal with the 
merges from there) instead of spreading the tyep info among different sections.

I could see other applications careing if the thing being handed to it is a 
directory, or a named pipe, etc and wanting different rules for them (obviously 
this wouldn't be relavent for C source, but I think I could see it for other 
things)

I coudl also see having one external program that can handle the different types 
of files and/or merges. rather than having a different line for each would it 
make sense to add another variable that could be handed to the merge program 
that would tell it what sort of merge to do?

David Lang
