From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-fetch per-repository speed issues
Date: Tue, 4 Jul 2006 12:22:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607041219540.12404@g5.osdl.org>
References: <1151949764.4723.51.camel@neko.keithp.com> <e8e28j$v8v$1@sea.gmane.org>
 <7vk66tgt6n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, jnareb@gmail.com
X-From: git-owner@vger.kernel.org Tue Jul 04 21:22:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxqTR-0004e8-Oq
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 21:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWGDTWO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 15:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWGDTWO
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 15:22:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21420 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751091AbWGDTWO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 15:22:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k64JM7nW029394
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 4 Jul 2006 12:22:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k64JM5Z8011877;
	Tue, 4 Jul 2006 12:22:07 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk66tgt6n.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23309>



On Tue, 4 Jul 2006, Junio C Hamano wrote:
> 
> I had an impression, though the report does not talk about this
> specific detail, that the extra time we are paying is because
> the "git pull" test is done without suppressing the final
> diffstat phase.

I'm pretty sure that was the reason for the particular hg issue. Looking 
at the "clone" times, the problem is almost certainly not the actual 
pulling.

The diffstat generation is often the largest part of a git merge. It's 
gotten cheaper since the hg benchmarks were done (I think they were done 
back before the integrated diff generation, so they also have the overhead 
of executing a lot of external GNU diff processes), but it's still not 
"cheap".

But I have to say that the diffstat at least for me is absolutely 
invaluable.

			Linus
