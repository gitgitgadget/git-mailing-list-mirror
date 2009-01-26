From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Common ancestor in merge diffs?
Date: Mon, 26 Jan 2009 11:05:12 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901261100200.5284@localhost.localdomain>
References: <alpine.LNX.1.00.0901261318030.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jan 26 20:12:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRWo1-00069v-PP
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 20:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565AbZAZTFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 14:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408AbZAZTFt
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 14:05:49 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57505 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751854AbZAZTFs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jan 2009 14:05:48 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0QJ5CiW004118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 26 Jan 2009 11:05:13 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0QJ5CIh030808;
	Mon, 26 Jan 2009 11:05:12 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LNX.1.00.0901261318030.19665@iabervon.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.461 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107250>



On Mon, 26 Jan 2009, Daniel Barkalow wrote:
>
> I was just doing an annoying merge (I'd reorganized code while other 
> people made changes to it), and I kept having the problem that it was hard 
> to figure out what each side had done. Is there some way to ask git for 
> the diffs between the common ancestor (which is unique in my case, so it's 
> actually useful) and each of the sides of the merge? Ideally, it would 
> give essentially the converse of the --cc diff: first column is -stage 1 
> +stage 2; second column is -stage 1 +stage 3.

Have you tried "gitk --merge [filename]"?

That's usually even more useful - because it doesn't just give a diff, it 
gives the actual commits that caused the conflict. That way you see what 
both sides of a merge tried to do.. It's what I do when encountering 
conflicts on the kernel (where I'm usually not the author of _either_ side 
of the code that causes a conflict), and it really is very powerful.

That said, finding the diffs from the common case is pretty trivial too. 
Just do

	git diff MERGE_HEAD...HEAD [filename]

and you'll get the diff from the common case to the HEAD, and if you 
switch them around, you'll get the diff from the common commit to the 
MERGE_HEAD. Note the _three_ dots.

			Linus
