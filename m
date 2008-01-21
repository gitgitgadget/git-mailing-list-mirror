From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-commit: add a prepare-commit-msg hook
Date: Mon, 21 Jan 2008 12:46:06 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801211231480.5731@racer.site>
References: <4790BCED.4050207@gnu.org> <7vbq7ibxhh.fsf@gitster.siamese.dyndns.org> <4791C3A8.7000308@gnu.org> <alpine.LSU.1.00.0801191119050.5731@racer.site> <7vd4rw6siv.fsf@gitster.siamese.dyndns.org> <479438D1.2050107@gnu.org> <alpine.LSU.1.00.0801211101450.5731@racer.site>
 <47948C9B.7030100@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 13:46:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGw3D-0002vR-3r
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 13:46:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbYAUMqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 07:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbYAUMqW
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 07:46:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:47189 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751404AbYAUMqV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 07:46:21 -0500
Received: (qmail invoked by alias); 21 Jan 2008 12:46:20 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp027) with SMTP; 21 Jan 2008 13:46:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+BdboQq2+BsUgexyRyVr3zW5WGJXGc6w252/7wf/
	oAx6pqRgGEOAsM
X-X-Sender: gene099@racer.site
In-Reply-To: <47948C9B.7030100@gnu.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71278>

Hi,

On Mon, 21 Jan 2008, Paolo Bonzini wrote:

> > I have.  But I want to avoid a regression at any cost.  And your patch 
> > just looks to me like it could do that.
> 
> What kind of regression?

See below.

> > But it _has_ been already suggested that you could provide arguments 
> > for the existing msg-hook, which would not break anything
> 
> Sure it won't break anything, but it won't work either!  The existing 
> message hook runs after the editing session -- I want the hook to 
> introduce text that is merely a suggestion that the user can delete, or 
> a template that the user needs to customize further.

OMG you're right.  But why didn't you say so in the commit message?  
Something like "This hook complements the commit-msg hook, in that it runs 
_before_ the editor is launched".

> > since the hook does not get any argument yet, and therefore existing 
> > hooks would be unaffected.
> 
> How does adding a new hook affect existing hooks?

My impression -- even after reading your commit message -- was that it 
does almost the same as the commit-msg hook, only that it runs _in 
addition_ to it when doing a non-amend commit.

FWIW this is the first reply by you that uncovers this error of mine.

> > Also, the change would be non-intrusive, easy-to-review
> 
> Please.  That's ludicrous.
> 
> My patch is 3 lines of inserted code and 0 modified lines, checking one 
> variable that is set once in builtin-commit.c (edit_message).

Actually, after reading the commit message I was in 
"this-is-not-necessary" mode, and therefore the diffstat looked too large 
for me.

That is why I thought that a regression was looming somewhere.

And in reality, your patch should be 2 lines of code.

> The documentation says that it runs whenever the editor runs except for 
> -c, and launch_editor runs after the 3 lines of code I inserted.

Actually, reading your patch again I think it also triggers for "-c", as 
well as for "[-C|-F|-m] ... -e".

And it does not necessarily start with "an empty log message"; think of 
"--signoff".

Besides, I think that the name should be more to the point, something like 
"pre-edit-commit-msg".

Also, I should think that the hook should get some information about the 
circumstances (possibly as command line arguments), given that it is 
called in more cases than you said.

So I think the patch is not ready yet, although I finally got the _point_ 
of having yet-another hook.

> Seeing how biased you are, I don't really know why I bothered answering 
> you.

So I am biased.  And you have to convince me.  It's not that hard to 
convince me.

> > take so much time away from the bug-fixing that we want to do right 
> > now in
> 
> That's the first sensible argument that I hear.

Heh.  Then I'm happy that I put it into my mail, too!

Ciao,
Dscho
