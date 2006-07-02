From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: A note on merging conflicts..
Date: Sat, 1 Jul 2006 17:08:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607011704060.12404@g5.osdl.org>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
 <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
 <20060701150926.GA25800@lsrfire.ath.cx> <20060701180125.GA27550@fieldses.org>
 <Pine.LNX.4.64.0607011115500.12404@g5.osdl.org> <Pine.LNX.4.64.0607011754370.9789@iabervon.org>
 <Pine.LNX.4.64.0607011552170.12404@g5.osdl.org> <Pine.LNX.4.64.0607011905030.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 02:09:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwpWR-0003Uj-LF
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 02:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbWGBAJI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 20:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWGBAJH
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 20:09:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52900 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750937AbWGBAJG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jul 2006 20:09:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6208tnW024196
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 1 Jul 2006 17:08:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6208sFi016848;
	Sat, 1 Jul 2006 17:08:54 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0607011905030.9789@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23089>



On Sat, 1 Jul 2006, Daniel Barkalow wrote:
> 
> But that wouldn't actually affect b...c, because we don't actually care 
> that 'e' is the correct merge-base and 'g' is not, because "b c ^e ^g" is 
> the same as "b c ^e".

You're right - in ths case we don't care about a minimal base commit set 
at all, it's fine to have too many.

I think your patch to do the LEFT/RIGHT thing in git-rev-list internally, 
instead of generating it as part of the command line, looks fine in 
theory. 

Except I think you need to set "revs->limited" for that case too (normally 
it gets set by "handle_commit()", and only if there is an UNINTERESTING 
commit: we'd need to add code to set it for LEFT/RIGHT commits too.

		Linus
