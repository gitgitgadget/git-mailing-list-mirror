From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: A shortcoming of the git repo format
Date: Wed, 27 Apr 2005 13:56:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504271352110.18901@ppc970.osdl.org>
References: <426F2671.1080105@zytor.com> <Pine.LNX.4.58.0504270820370.18901@ppc970.osdl.org>
 <426FD3EE.5000404@zytor.com> <Pine.LNX.4.58.0504271154470.18901@ppc970.osdl.org>
 <426FF8C4.8080809@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 22:50:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQtTO-0000B9-4Z
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 22:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVD0Uyy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 16:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVD0Uyy
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 16:54:54 -0400
Received: from fire.osdl.org ([65.172.181.4]:53985 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261985AbVD0Uyv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 16:54:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3RKsos4014283
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Apr 2005 13:54:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3RKsnhQ008521;
	Wed, 27 Apr 2005 13:54:49 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <426FF8C4.8080809@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 27 Apr 2005, H. Peter Anvin wrote:
> 
> I know that.  However, is that going to be true for all versions of the 
> repository format over all time?  If so, the repository format is brittle.

I agree, it's brittle by design, exactly because I think it's very 
important not to allow any variations.

HOWEVER, that's where "convert-cache" comes in. Any one particular format 
may be brittle, but if we accept that, and just say "we can upgrade by 
converting the cache", then we should be ok. IOW, we can change from one 
brittle format with 160-bit SHA1 names to _another_ brittle format with 
256-bit SHA1 (or other) names.

> My point was that with a syntactic delimiter, one can write a tool that 
> doesn't necessarily know everything about every tag, including future 
> tags which may not have been invented when the tool was written.

Now, I kind of agree with that, but not on a "object level".

But exactly because the object level is "brittle by design", and because I 
the way to fix that is convert-cache (which may do _big_ changes to the 
format), I really don't think that the objects should ever be looked at 
except with very precise tools.

But when it comes to "higher-level information", I agree with you 100%.

For example, this _is_ actually why I wanted pasky to change the format of 
"git log" (now cg-log). Exactly so that the output of that isn't brittle, 
it now prepends spaces to the free-form part.

		Linus
