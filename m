From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 5/6] Teach "fsck" not to follow subproject links
Date: Thu, 12 Apr 2007 12:03:13 +1200
Message-ID: <461D7741.50501@vilain.net>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org><Pi ne.LNX.4.64.0704092115020.6730@woody.linux-foundation.org><461D6432.90205@v ilain.net>  <Pine.LNX.4.64.0704111545040.6730@woody.linux-foundation.org><461D6858.4090 007@vilain.net> <Pine.LNX.4.64.0704111605210.6730@woody.linux-foundation.org> <Pine.LNX.4.63.0704111600390.28394@qynat.qvtvafvgr.pbz> <Pine.LNX.4.64.0704111646000.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: David Lang <david.lang@digitalinsight.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 02:03:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbmma-0001lv-3R
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 02:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161420AbXDLADV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 20:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161423AbXDLADV
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 20:03:21 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:57855 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161420AbXDLADU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 20:03:20 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id B5AD913A403; Thu, 12 Apr 2007 12:03:18 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 5606B13A3E1;
	Thu, 12 Apr 2007 12:03:15 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.2 (X11/20060521)
In-Reply-To: <Pine.LNX.4.64.0704111646000.6730@woody.linux-foundation.org>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44287>

Linus Torvalds wrote:
> It can be a nice space optimization, and yes, if there really is a lot of 
> shared state, it can make it much cheaper to do some of the checks, but 
> right now we have absolutely *no* way for fsck to then do the reachability 
> check, because there is no way to tell fsck where all the refs are (since 
> now the refs come in from multiple repositories!)
>   

Well, not if the refs are only gitlinks because there is no checkout.

> So the individual objects get cheaper to fsck (no need to fsck shared 
> objects over and over again), but the reachability gets much harder to 
> fsck.
>
> It's not an insurmountable problem, or even necessarily a very large one, 
> but it boils down to one very basic issue:
>
>  - nobody seems to actually *use* the shared object directory model!
>
> The thing is, with pack-files and alternates directories, a lot of the 
> original reasons for shared object directories simply don't exist..

I think that's just the chicken-and-egg problem. Once this happens I
think we'll see people aggregating all sorts of related repositories
with this feature, and possibly making much richer histories by tracking
portions of their trees as subprojects rather than just a subdirectory.

Sam.
