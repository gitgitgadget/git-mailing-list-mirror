From: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH] Don't crash if ai_canonname comes back as null
Date: Thu, 30 Apr 2009 09:13:53 -0500
Message-ID: <E1LzX1N-0003sw-2y@jdl.com>
References: <9C355DCC-0240-4B9E-83CA-083B51C2E34C@gmail.com> <81b0412b0904291455n47f83e9ftcbdec0ff1c0ea03@mail.gmail.com> <6B7EA51D-8412-4E6A-BA7B-156FD5B755E8@gmail.com> <81b0412b0904291504k3261df5fl692d09c6c761887e@mail.gmail.com> <C2AC0D7A-3E11-4A3A-8447-5D7582547B13@gmail.com> <7v63gn59mw.fsf@gitster.siamese.dyndns.org> <A85E96CC-CF0B-40F9-9960-00485285E6ED@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Benjamin Kramer <benny.kra@googlemail.com>
To: Augie Fackler <durin42@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 16:59:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzXjY-0005w7-2h
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 16:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762224AbZD3O7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 10:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762098AbZD3O7V
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 10:59:21 -0400
Received: from jdl.com ([208.123.74.7]:51645 "EHLO jdl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755590AbZD3O7U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 10:59:20 -0400
X-Greylist: delayed 2723 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Apr 2009 10:59:20 EDT
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.69)
	(envelope-from <jdl@jdl.com>)
	id 1LzX1N-0003sw-2y; Thu, 30 Apr 2009 09:13:53 -0500
In-reply-to: <A85E96CC-CF0B-40F9-9960-00485285E6ED@gmail.com> 
Comments: In-reply-to Augie Fackler <durin42@gmail.com>
   message dated "Wed, 29 Apr 2009 18:32:02 -0500."
X-Spam-Score: -2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118021>

> 
> On Apr 29, 2009, at 6:21 PM, Junio C Hamano wrote:
> 
> > Augie Fackler <durin42@gmail.com> writes:
> >
> >> Fixes a weird bug where git-daemon was segfaulting
> >> when started by sh(1) because ai_canonname was null.
> >> ---
> >> Fixed based on feedback.
> >
> > Hmm.
> >
> > I've been waiting for feedback to a patch proposed earlier in the same
> > area, which is <49F5BA55.3060606@googlemail.com> ($gmane/117670).  How
> > does this new one relate to it?
> 
> I can't comment much on the correctness of the code - my patch was the  
> minimal change to have it not crash.
> 
> The other patch also works for me to prevent the crash, and looks like  
> it might be a little more correct in terms of having a meaningful  
> hostname.

So, I wasn't CC'ed on the referenced patch ($gmane/117670), but it
seems to me that there might be value in actually looping over the
whole list of addrinfo results exactly in the case that it does
return a null canonical name for one of its addresses?  Perhaps an
inverse call to getnameinfo() is warranted too?

Sorry, I'm just not certain here.

jdl
