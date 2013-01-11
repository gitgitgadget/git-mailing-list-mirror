From: Jeff King <peff@peff.net>
Subject: Re: git send-email should not allow 'y' for in-reply-to
Date: Fri, 11 Jan 2013 11:47:30 -0500
Message-ID: <20130111164730.GA7921@sigill.intra.peff.net>
References: <y>
 <1357885869-20815-1-git-send-email-cyliu@suse.com>
 <50EFD066.60501@redhat.com>
 <50F0402A.1000108@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, libvir-list@redhat.com
To: Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 17:47:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tthlp-0007Z5-PE
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 17:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666Ab3AKQrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 11:47:33 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57427 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753324Ab3AKQrd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 11:47:33 -0500
Received: (qmail 20883 invoked by uid 107); 11 Jan 2013 16:48:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Jan 2013 11:48:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jan 2013 11:47:30 -0500
Content-Disposition: inline
In-Reply-To: <50F0402A.1000108@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213226>

On Fri, Jan 11, 2013 at 09:39:06AM -0700, Eric Blake wrote:

> > Please don't answer "y" when git send email shows the following prompt:
> > 
> > "Message-ID to be used as In-Reply-To for the first email?"
> > 
> > you should respond with a message ID there. Unfortunately we have a
> > growing thread that contains submissions with this mistake.
> 
> Anyone willing to patch upstream 'git send-email' to reject a simple 'y'
> rather than blindly sending a bad messageID for the in-reply-to field,
> to help future users avoid this mistake?  Obviously, it won't help until
> the patch eventually percolates into distros, so it would be a few more
> months before we see the benefits, but down the road it will prevent
> confusing threads.

What version of git? Commit 51bbccf is in v1.7.12.1 and higher, and
says:

  $ git show 51bbccf
  commit 51bbccfd1b4a9e2807413022c56ab05c835164fb
  Author: Junio C Hamano <gitster@pobox.com>
  Date:   Tue Aug 14 15:15:53 2012 -0700

  send-email: validate & reconfirm interactive responses

  People answer 'y' to "Who should the emails appear to be from?"  and
  'n' to "Message-ID to be used as In-Reply-To for the first email?"
  for some unknown reason.  While it is possible that your local
  username really is "y" and you are sending the mail to your local
  colleagues, it is possible, and some might even say it is likely,
  that it is a user error.

  Fortunately, our interactive prompter already has input validation
  mechanism built-in.  Enhance it so that we can optionally reconfirm
  and allow the user to pass an input that does not validate, and
  "softly" require input to the sender, in-reply-to, and recipient to
  contain "@" and "." in this order, which would catch most cases of
  mistakes.

-Peff
