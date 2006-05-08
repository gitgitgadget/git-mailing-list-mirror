From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Implementing branch attributes in git config
Date: Mon, 8 May 2006 19:20:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605081905240.6713@iabervon.org>
References: <1147037659.25090.25.camel@dv> <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
 <1147048587.17371.13.camel@dv> <Pine.LNX.4.64.0605071740550.3718@g5.osdl.org>
 <7vfyjli9vf.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
 <7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 01:19:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdF12-0002fZ-9w
	for gcvg-git@gmane.org; Tue, 09 May 2006 01:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWEHXTj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 19:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWEHXTi
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 19:19:38 -0400
Received: from iabervon.org ([66.92.72.58]:4622 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750842AbWEHXTi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 May 2006 19:19:38 -0400
Received: (qmail 30824 invoked by uid 1000); 8 May 2006 19:20:20 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 May 2006 19:20:20 -0400
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19780>

On Sun, 7 May 2006, sean wrote:

> On Sun, 07 May 2006 19:29:50 -0700
> Junio C Hamano <junkio@cox.net> wrote:
> 
> 
> > Not at all.  Whatever Porcelain that runs repo-config to record
> > the branch name needs to spell that branch name with proper
> > quoting, like:
> 
> Okay.  It just seems nuts to require quoting because you happen
> to use an uppercase character.  People are used to quoting 
> special characters like * and $, not uppercase letters.

You could tell people always to use:

 [branch."name"]

even if the branch name is all lowercase anyway. They could even use:

 [Branch."MyMixedCaseBranch"]

Then when you refer to something case-sensitive with the possibility of 
funny characters, you put it in quotes, regardless of what it is.

For that matter, we could retain the quotes when we parse the file, and 
reject [branch.master] for lacking the quotes, so that people who are only 
exposed to branch names all in lowercase letters don't get habits that 
will fail when they have a v2.6.16.x branch.

I don't think that people are likely to use older versions of git on the 
same repository they've used newer versions on. (Clones of it, sure, but 
that doesn't matter here.) But we should, in any case, make the code 
ignore sections or lines with syntax errors, under the assumption that 
they're a later extension and possibly legal but not anything the code 
could be interested in getting from a parser that doesn't support them.

	-Daniel
*This .sig left intentionally blank*
