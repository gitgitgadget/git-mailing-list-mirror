From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Problem with a push
Date: Tue, 12 Jun 2007 11:01:52 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706121055090.14121@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0706111632050.4406@www.mintpixels.com>
 <alpine.LFD.0.98.0706111556160.14121@woody.linux-foundation.org>
 <200706121007.17044.andyparkins@gmail.com>
 <alpine.LFD.0.98.0706120800430.14121@woody.linux-foundation.org>
 <7vk5u9hzv9.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	plexq@plexq.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 20:02:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyAh6-0006wI-Er
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 20:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015AbXFLSCP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 14:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754816AbXFLSCP
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 14:02:15 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52183 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754631AbXFLSCO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2007 14:02:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5CI1wJm005950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Jun 2007 11:01:59 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5CI1qmP017483;
	Tue, 12 Jun 2007 11:01:53 -0700
In-Reply-To: <7vk5u9hzv9.fsf@assigned-by-dhcp.pobox.com>
X-Spam-Status: No, hits=-2.681 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49982>



On Tue, 12 Jun 2007, Junio C Hamano wrote:
> 
> I think what we might want to do around this area are:
> 
>  - Don't change anything, if the command line says refspec, or
>    the remote has push refspec specified.
> 
>  - When doing 'matching refs', do it only under refs/heads/.

I think these both are "obviously good".

>  - Ship with a receive-pack hook that attempts a 3-way merge
>    update when the currently checked out branch is updated.

Well, if it wasn't a fast-forward, then the user did a push with "git push 
-f", which implies _replacing_ the currently checked out branch.

So by three-way, I assume you mean the "git checkout -m" behaviour, and a 
fast-forward. What about a non-fast-forward (ie "git push -f"?) Should 
that imply "git checkout -f" semantics on the receiving side? That would 
kind of be sensible.

		Linus
