From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] Try harder to find a remote when on a detached HEAD or
	non-tracking branch.
Date: Wed, 20 Jun 2012 19:42:35 +0200
Message-ID: <20120620174213.GA2500@book.hvoigt.net>
References: <1340038866-24552-1-git-send-email-marcnarc@xiplink.com> <7vaa004j9f.fsf@alter.siamese.dyndns.org> <4FDFA030.7080408@xiplink.com> <7vmx402rru.fsf@alter.siamese.dyndns.org> <4FE08797.50509@xiplink.com> <7vipen191a.fsf@alter.siamese.dyndns.org> <20120619193114.GA461@book.hvoigt.net> <4FE0F262.9050404@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 19:42:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShOvY-00042X-9r
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 19:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373Ab2FTRmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 13:42:44 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.99]:35861 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177Ab2FTRmn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 13:42:43 -0400
Received: from [77.20.33.80] (helo=localhost)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1ShOvM-00027j-Ar; Wed, 20 Jun 2012 19:42:36 +0200
Content-Disposition: inline
In-Reply-To: <4FE0F262.9050404@xiplink.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200304>

Hi,

On Tue, Jun 19, 2012 at 05:42:58PM -0400, Marc Branchaud wrote:
> On 12-06-19 03:31 PM, Heiko Voigt wrote:
> > Using the first configured remote as a fallback also sounds quite
> > arbitrary to me. Your current HEAD might have nothing to do with that
> > remote.
> 
> Sure, but if it doesn't specify a remote then why not?  (Instead of "first
> configured remote" think "remote used in the initial clone command".)

Returning the "remote used in the initial clone" sounds ok to me as
well but that does not have to be the same as "first remote git config
--list returns".

> > Before falling back to origin how about guessing the remote from the
> > first branch thats contained in HEAD?
> >
> > To me that sounds quite natural. The first branch could be ambiguous so
> > we would have to come up with some ordering. Maybe a depth search and
> > first parents first? Or a breadth first search with younger generations
> > first and then first parents first?
> 
> This sounds much harder to explain to a user than "the remote you used when
> you cloned the repo".

Well I think "it uses the remote of the branch that you based your work
on" is not hard to explain. What's harder is the implementation.

> > Would that work for your use case Marc?
> 
> Maybe, but it seems much more complicated than necessary.

Git is a tool used in very different workflows so a change needs to be
quite generic. Make it as simple as possible but *no simpler*. I think
your patch is currently not respecting the "no simpler".

Cheers Heiko
