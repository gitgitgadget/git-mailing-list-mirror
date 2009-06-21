From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 2/2] rebase -i: use config file format to save author
 information
Date: Sun, 21 Jun 2009 02:51:53 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0906210244510.2147@iabervon.org>
References: <20090621050846.3554.31660.chriscool@tuxfamily.org> <7vprcyt7fk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 21 08:52:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIGuH-0005UL-4u
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 08:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341AbZFUGvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 02:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753293AbZFUGvv
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 02:51:51 -0400
Received: from iabervon.org ([66.92.72.58]:38608 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753238AbZFUGvv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 02:51:51 -0400
Received: (qmail 28428 invoked by uid 1000); 21 Jun 2009 06:51:53 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Jun 2009 06:51:53 -0000
In-Reply-To: <7vprcyt7fk.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121968>

On Sat, 20 Jun 2009, Junio C Hamano wrote:

> Christian Couder <chriscool@tuxfamily.org> writes:
> 
> > This is better than saving in a shell script, because it will make
> > it much easier to port "rebase -i" to C.
> 
> Hmph.
> 
> We used to parse a commit object in one go into variables, and I would
> have imagined that a rewrite in C will read a commit object to get the
> author information in variables in-core, without having to write any
> temporary file.
> 
> But with your patch, it starts to use a temporary file, and forces the C
> rewrite to do the same.  It closes the door for a more efficient rewrite.
> 
> Why is this a good change?

It was always using a temporary file; it just used to use a temporary file 
that was a shell script fragment and needed to be read with "eval". It 
can't be done entirely in core because it may be determined before a 
conflict and only used when run with --continue after the user resolves 
the conflict.

	-Daniel
*This .sig left intentionally blank*
