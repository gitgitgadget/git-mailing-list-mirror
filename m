From: Jeff King <peff@peff.net>
Subject: Re: Truncating and cleaning a imported git repositary to make it
	more usable
Date: Fri, 28 Mar 2008 14:08:49 -0400
Message-ID: <20080328180848.GA8299@coredump.intra.peff.net>
References: <1206707716.9819.15.camel@malory> <32541b130803280550u2ed23b5auc84bf935d5344e84@mail.gmail.com> <b2cdc9f30803280852y4f160bb2tda1e688ddf7213e7@mail.gmail.com> <b2cdc9f30803280903w4a6e3a6l9e33fd188af9995a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 19:09:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfJ1J-0007sd-NA
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 19:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755546AbYC1SIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 14:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755052AbYC1SIw
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 14:08:52 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1289 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754717AbYC1SIw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 14:08:52 -0400
Received: (qmail 26104 invoked by uid 111); 28 Mar 2008 18:08:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 28 Mar 2008 14:08:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Mar 2008 14:08:49 -0400
Content-Disposition: inline
In-Reply-To: <b2cdc9f30803280903w4a6e3a6l9e33fd188af9995a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78431>

On Fri, Mar 28, 2008 at 04:03:18PM +0000, Alex Bennee wrote:

> >  ajb@pitcairn:/export/git/fresh.git$ git-filter-branch --tree-filter
> >  'rm -rf big_dira big_dirb' dev-branch
> >  warning: refname 'dev-branch' is ambiguous.
> >  Which ref do you want to rewrite?

You have two refs called dev-branch. Probably both a tag and a branch
(i.e., refs/heads/dev-branch and refs/tags/dev-branch). You can
disambiguate by saying "heads/dev-branch").

> Ignore me. Not sure why but:
> 
> git-checkout dev-branch
> git-filter-branch --tree-filter  'rm -rf big_dira big_dirb' HEAD

git-checkout prefers branches to tags[1], so there is no ambiguity. It
puts the full refname (refs/heads/dev-branch) into your HEAD, so there
is no ambiguity when saying "HEAD".

[1] Actually, the upcoming builtin-checkout no longer behaves this way,
and will complain about the ambiguity.

-Peff
