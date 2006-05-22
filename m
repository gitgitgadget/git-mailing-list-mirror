From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: irc usage..
Date: Mon, 22 May 2006 13:33:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605221328210.3697@g5.osdl.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org> 
 <446FA262.7080900@gentoo.org>  <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org>
  <Pine.LNX.4.64.0605212053590.3697@g5.osdl.org>  <44713BE4.9040505@gentoo.org>
  <Pine.LNX.4.64.0605212132570.3697@g5.osdl.org> 
 <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com> 
 <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org> 
 <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com> 
 <44720C66.6040304@gentoo.org> <46a038f90605221241x58ffa2a4o26159d38d86a8092@mail.gmail.com>
 <Pine.LNX.4.64.0605221256090.3697@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Donnie Berkholz <spyderous@gentoo.org>,
	Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 22 22:33:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiH5v-0000A9-4x
	for gcvg-git@gmane.org; Mon, 22 May 2006 22:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWEVUdg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 16:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWEVUdg
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 16:33:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53957 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751169AbWEVUdg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 16:33:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4MKX2tH027677
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 22 May 2006 13:33:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4MKX1BT012601;
	Mon, 22 May 2006 13:33:02 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0605221256090.3697@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20532>



On Mon, 22 May 2006, Linus Torvalds wrote:
> 
> Of course, the CVS part is probably a big overhead, so it might not help 
> much (I would not be surprised at all if a number of the fork/exec/exit 
> things are due to the CVS server starting RCS or something, not due to 
> git-cvsimport itself)

Ahh. stracing the CVS server seems to imply that it forks off a subprocess 
for every command. It doesn't actually execute any external program, but 
just does a fork + muck around in the ,v files + exit.

Maybe one of the changes in the 1.12.x versions is to not do that, which 
might explain why Donnie seems to see much better performance, but also 
sees all the memory leakage?

		Linus
