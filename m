From: Junio C Hamano <junkio@cox.net>
Subject: Re: Implementing branch attributes in git config
Date: Sun, 07 May 2006 19:29:50 -0700
Message-ID: <7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net>
References: <1147037659.25090.25.camel@dv>
	<Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
	<1147048587.17371.13.camel@dv>
	<Pine.LNX.4.64.0605071740550.3718@g5.osdl.org>
	<7vfyjli9vf.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 04:30:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcvVp-0005DA-DJ
	for gcvg-git@gmane.org; Mon, 08 May 2006 04:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWEHC3w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 22:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWEHC3w
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 22:29:52 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:16799 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932254AbWEHC3v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 22:29:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060508022951.OGCB17501.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 7 May 2006 22:29:51 -0400
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Sun, 7 May 2006 21:34:45 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19751>

sean <seanlkml@sympatico.ca> writes:

> On Sun, 07 May 2006 18:27:32 -0700
> Junio C Hamano <junkio@cox.net> wrote:
>
>
>> How about keeping the default syntax as it is (tokens are case
>> insensitive and alnums only, dot separates tokens into
>> sections), and when a token that violates that rule needs to be
>> spelled out, require quoting, so:
>> 
>> 	branch.foo	BranCh.FoO	branch.FOO
>  
>> are the same (section "branch.foo"),
>
> Doesn't that mean you have to then prohibit creating mixed
> case branches with "git branch" and "git checkout -b" ?

Not at all.  Whatever Porcelain that runs repo-config to record
the branch name needs to spell that branch name with proper
quoting, like:

>> 	branch."js/fmt.patch"	or   "branch.js/fmt.patch"        
>> 
>> and the URL variable for that section is
>> 
>> 	$ git repo-config '"branch.js/fmt.patch".url'
>
> How about transforming slashes into dots?  so the above would 
> be:
>
>    [branch.js.fmt.patch]

I _do_ want to keep my slashes intact and also dots; mangling
them is not very nice to me X-<.
