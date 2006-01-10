From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: git pull on Linux/ACPI release tree
Date: Mon, 9 Jan 2006 18:50:14 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601091845160.5588@g5.osdl.org>
References: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Brown, Len" <len.brown@intel.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 03:50:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew9ag-0005U5-Sa
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 03:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWAJCu1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 21:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWAJCu0
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 21:50:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11393 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750794AbWAJCuZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2006 21:50:25 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0A2oGDZ015497
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 9 Jan 2006 18:50:16 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0A2oECq006262;
	Mon, 9 Jan 2006 18:50:14 -0800
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14397>



On Mon, 9 Jan 2006, Luben Tuikov wrote:
> 
> A very general workflow I've seen people use is more/less as
> I outlined in my previous email:
> 
>   tree A  (linus' or trunk)
>      Project B  (Tree B)
>         Project C  (Tree C, depending on stuff in Project B)
> 
> Now this could be how the "managers" see things, but development,
> could've "cloned" from Tree B and Tree C further, as is often
> customary to have a a) per user tree, or b) per bug tree.
> 
> So pull/merge/fetch/whatever follows Tree A->B->C.
> 
> It is sensible to have another tree say, called something
> like "for_linus" or "upstream" or "product" which includes
> what has accumulated in C from B and in B from A, (eq diff(C-A)).
> I.e. a "push" tree.  So that I can tell you, "hey,
> pull/fetch/merge/whatever the current verb en vogue is, from
> here to get latest xyz".
> 
> What I also wanted to mention is that Tree B undeniably
> depends on the _latest_ state of Tree A, since Project B
> uses API/behaviour of the code in Tree A, so one cannot just
> say they are independent.  Similarly for Tree C/Project C,
> is dependent on B, and dependent on A.

Note that in the case where the _latest_ state of the tre you are tracking 
really matters, then doing a "git pull" is absolutely and unquestionably 
the right thing to do. 

So if people thought that I don't want to have sub-maintainers pulling 
from my tree _at_all_, then that was a mis-communication. I don't in any 
way require a linear history, and criss-cross merges are supported 
perfectly well by git, and even encouraged in those situations.

After all, if tree B starts using features that are new to tree A, then 
the merge from A->B is required for functionality, and the synchronization 
is a fundamental part of the history of development. In that cases, the 
history complexity of the resulting tree is a result of real development 
complexity.

Now, obviously, for various reasons we want to avoid having those kinds of 
linkages as much as possible. We like to have develpment of different 
subsystems as independent as possible, not because it makes for a "more 
readable history", but because it makes it a lot easier to debug - if we 
have three independent features/development trees, they can be debugged 
independently too, while any linkages inevitably also mean that any bugs 
end up being interlinked..

		Linus
