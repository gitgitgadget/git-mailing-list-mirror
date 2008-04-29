From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: format-patch --cc and send-mail --s-o-b-cc don't play nice
 together
Date: Tue, 29 Apr 2008 18:28:24 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804291756070.19665@iabervon.org>
References: <36ca99e90804290657k88710eer630898d837659f37@mail.gmail.com> <7v8wyw7349.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ryan Anderson <ryan@michonline.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 00:29:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqyK4-00017e-WD
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 00:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758869AbYD2W22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 18:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758680AbYD2W21
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 18:28:27 -0400
Received: from iabervon.org ([66.92.72.58]:34386 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758142AbYD2W20 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 18:28:26 -0400
Received: (qmail 28855 invoked by uid 1000); 29 Apr 2008 22:28:24 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Apr 2008 22:28:24 -0000
In-Reply-To: <7v8wyw7349.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80760>

On Tue, 29 Apr 2008, Junio C Hamano wrote:

> "Bert Wesarg" <bert.wesarg@googlemail.com> writes:
> 
> > the --cc option from format-patch adds a Cc: header to the mail where
> > multiple recipients are put into a new line, separated by commas.
> 
> I am not sure if --cc ever made sense to be given to format-patch.  It is
> not a tool to send e-mails, which send-email is.

But part of preparing patches for e-mail submission is often figuring out 
where to send them. I think the common use of format-patch is to generate 
the series, import it into some MUA (I actually append it to my "postponed 
messages" mbox for Alpine), edit the messages to add any commentary needed 
outside of the commit message, and send them, going through the user's 
normal outgoing email path. For this purpose, it makes sense to be able to 
get git to produce anything that is standard for patch submission in the 
project, so that the user doesn't have to edit them more than necessary.

I think that it would make sense for format-patch to handle 
--signed-off-by-cc itself, since this is clearly generating useful 
information for composing the email out of git's information about the 
commits.

> > Unfortunately send-mail with the --signed-off-by-cc option can't parse
> > these lines.
> 
> Isn't --signed-off-by-cc a completely unrelated feature, where it gives
> carbon copies to people who signed off the patch?  Why does the option
> need to read from existing CC: header of the material the command is told
> to send out?

It also Cc's people listed in Cc: lines in the commit message, which I'd 
guess is where it's getting confused. But it also makes sense that people 
might want to determine who to send each patch to individually, put it in 
the patch in the RFC823-compliant fashion, additionally include people in 
Signed-off-by: lines, and send the whole batch off, in which case 
send-email would need to know how to handle existing Cc: headers which may 
be wrapped.

	-Daniel
*This .sig left intentionally blank*
