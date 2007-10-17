From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] gitweb: speed up project listing on large work trees by limiting find depth
Date: Wed, 17 Oct 2007 01:25:14 -0400
Message-ID: <20071017052514.GW13801@spearce.org>
References: <1192592725-28143-1-git-send-email-git@vicaya.com> <20071017040028.GT13801@spearce.org> <6B74E96C-37ED-4D6A-8A98-C90B61EFA181@vicaya.com> <20071017042724.GU13801@spearce.org> <562B5254-2BE7-43DF-AB62-499458E360CC@vicaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pasky@suse.cz
To: Luke Lu <git@vicaya.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 07:25:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii1PV-0006WG-A6
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 07:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbXJQFZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 01:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753001AbXJQFZT
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 01:25:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57321 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbXJQFZS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 01:25:18 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ii1P9-0006yK-UN; Wed, 17 Oct 2007 01:25:16 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 867B120FBCB; Wed, 17 Oct 2007 01:25:14 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <562B5254-2BE7-43DF-AB62-499458E360CC@vicaya.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61333>

Luke Lu <git@vicaya.com> wrote:
> OK, let me try again :) I was using no_chdir => 1 to shorten the tr,  
> as well as saving a syscall. However the code is expecting $_ to be  
> relative elsewhere (line 1524) to check for the toplevel, so the  
> check failed for the toplevel because of no_chdir, which caused  
> substr to work on the toplevel, which is $pfxlen long. Note $pfxlen +  
> 1 passes the end of the toplevel path, hence the errors, though the  
> program still worked correctly, as $subdir is undefined in this case,  
> which would by pass the rest of the code, which is logically correct.  
> It'll probably crash, if it's written in C :)
> 
> So, I got rid of no_chdir => 1 in the new patch and uses  
> $File::Find::name directly, as otherwise I'd have to come up with a  
> messier regex for checking toplevel at line 1524.

*light dawns*.  Thank you for the explanation.

-- 
Shawn.
