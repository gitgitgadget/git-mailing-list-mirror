From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all entries
Date: Fri, 12 Jan 2007 21:30:42 +0100
Message-ID: <20070112203042.GA8127@steel.home>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com> <Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com> <7v8xgileza.fsf@assigned-by-dhcp.cox.net> <81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com> <20070107163112.GA9336@steel.home> <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net> <20070112184839.9431ddff.vsu@altlinux.ru> <7vr6u0t87q.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergey Vlasov <vsu@altlinux.ru>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 21:31:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5T3L-0006Kn-Om
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 21:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbXALUbE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 15:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbXALUbE
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 15:31:04 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:36761 "EHLO
	mailout03.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030197AbXALUbD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jan 2007 15:31:03 -0500
Received: from fwd31.aul.t-online.de 
	by mailout03.sul.t-online.com with smtp 
	id 1H5T3A-0003A3-01; Fri, 12 Jan 2007 21:30:56 +0100
Received: from tigra.home (SrAFfwZpgeVCRpeHM+p7lXhZPQ7UPb+vuFXDb28DCtupx4-LbND5ET@[84.163.80.148]) by fwd31.sul.t-online.de
	with esmtp id 1H5T2x-0vDGu80; Fri, 12 Jan 2007 21:30:43 +0100
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 2E3D7277B6;
	Fri, 12 Jan 2007 21:30:43 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id DDB51C1E5; Fri, 12 Jan 2007 21:30:42 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr6u0t87q.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-ID: SrAFfwZpgeVCRpeHM+p7lXhZPQ7UPb+vuFXDb28DCtupx4-LbND5ET
X-TOI-MSGID: cf302c35-ce85-4d37-93ea-7fc78917fc17
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36704>

Junio C Hamano, Fri, Jan 12, 2007 19:23:37 +0100:
> > ...and it is still used here - however, after the patch *result is
> > uninitialized at this point.
> 
> Very true.  This untested patch should fix it.
> 

I had to initialize mrtree of merge() with NULL to reproduce it.
Sneaky bastard...

> We could even remove the whole printf(), which I tend to prefer.

I agree. The merges of this kind a rare in comparison to simple ones.
