From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH 1/2] Replace memset(0) with static initialization
	where possible
Date: Thu, 9 Oct 2008 12:17:27 -0700
Message-ID: <20081009191727.GY8203@spearce.org>
References: <NveF6_7LIvvEmRZEvLeTO5lw7EzzmOQkz1WGEMYGSFKDWqSwAeLwBw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Oct 09 21:18:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko123-00032P-Hr
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 21:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbYJITR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 15:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752701AbYJITR2
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 15:17:28 -0400
Received: from george.spearce.org ([209.20.77.23]:46673 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbYJITR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 15:17:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B52613835F; Thu,  9 Oct 2008 19:17:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <NveF6_7LIvvEmRZEvLeTO5lw7EzzmOQkz1WGEMYGSFKDWqSwAeLwBw@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97877>

Brandon Casey <casey@nrlssc.navy.mil> wrote:
> Is there interest in a patch like this?

I think this is not a worthwhile change.
 
> "Possible" benefits:
> 
>   1) more concise, so it improves readability in most cases

I'm not sure.

Maybe I'm just too used to reading memset(&foo, 0, sizeof(foo)),
but {{0},} seems very difficult to read.

>   2) gives compiler more flexibility when optimizing

Shouldn't a good C compiler notice something like a memset and inline
it when possible?  They already can inline strlen on a constant.

> Drawbacks:
> 
>   1) many lines touched for no functional change

That's a pretty big drawback.

What happens when a struct gets a struct as its first member?
Do all the {0,} inits for it have to change to {{0,},} ?

-- 
Shawn.
