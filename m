From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Untracked working tree files
Date: Wed, 15 Oct 2008 13:30:47 -0700
Message-ID: <20081015133047.e31537b0.akpm@linux-foundation.org>
References: <20081015115654.fb34438f.akpm@linux-foundation.org>
	<alpine.DEB.1.10.0810151208100.7808@asgard.lang.hm>
	<alpine.DEB.1.10.0810151211580.7808@asgard.lang.hm>
	<alpine.LFD.2.00.0810151219120.3288@nehalem.linux-foundation.org>
	<20081015124949.b657a8db.akpm@linux-foundation.org>
	<alpine.LFD.2.00.0810151256410.3288@nehalem.linux-foundation.org>
	<alpine.LFD.2.00.0810151311210.3288@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: david@lang.hm, git@vger.kernel.org, gitster@pobox.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 15 22:33:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqD32-0000dq-Ov
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 22:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbYJOUbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 16:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753643AbYJOUbg
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 16:31:36 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36916 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753513AbYJOUbf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2008 16:31:35 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9FKUme9009121
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 15 Oct 2008 13:30:49 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m9FKUl1I000827;
	Wed, 15 Oct 2008 13:30:47 -0700
In-Reply-To: <alpine.LFD.2.00.0810151311210.3288@nehalem.linux-foundation.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-Spam-Status: No, hits=-2.869 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98322>

On Wed, 15 Oct 2008 13:23:50 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Wed, 15 Oct 2008, Linus Torvalds wrote:
> > 
> >  - a merge goes south with a data conflict, and since it's all automated, 
> >    you just want to throw it away.
> 
> Actually, with your filename, I suspect the conflict would be not a real 
> file content, but more of a "delete" conflicting with a modification to 
> that file. IOW, I'm guessing that the thing you hit with 
> arch/x86/kernel/apic.c was that some branch you pulled:
> 
>  - created that file
> 
>  - deleted arch/x86/kernel/apic_[32|64].c
> 
>  - the old file got marked as a rename source for the new apic.c and 
>    there was a data conflict when trying to apply the changes.
> 
> as a result, your working tree would have that "apic.c" file in it, but 
> with conflict markers, and marked as unmerged.

That sounds likely.  I suspect things were especially bad today because
I accidentally pulled four-week-old linux-next, which had over 500
rejects in it.
