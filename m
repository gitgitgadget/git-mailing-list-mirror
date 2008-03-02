From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git rebase -s ours
Date: Sat, 1 Mar 2008 20:05:27 -0500
Message-ID: <20080302010527.GB22843@coredump.intra.peff.net>
References: <20080301111716.GA3263@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Mar 02 02:06:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVceV-0002YR-Ip
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 02:06:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbYCBBFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 20:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbYCBBFb
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 20:05:31 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3561 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbYCBBFa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 20:05:30 -0500
Received: (qmail 12640 invoked by uid 111); 2 Mar 2008 01:05:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 01 Mar 2008 20:05:28 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Mar 2008 20:05:27 -0500
Content-Disposition: inline
In-Reply-To: <20080301111716.GA3263@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75711>

On Sat, Mar 01, 2008 at 12:17:16PM +0100, Mike Hommey wrote:

> What do you think git rebase -s ours should be considering as "ours"?
> If I'm not mistaken, at the moment, "ours" stands for "upstream", which
> is kind of confusing...

Sort of. It actually works as "what is in the working tree is fine" so
it ends up not applying _any_ commits. In other words,

  git rebase --strategy=ours upstream

is equivalent to

  git reset --hard upstream

So I think the current behavior is nonsensical, and I assume nobody uses
it.

OTOH, what exactly are you trying to accomplish? If you have "ours" mean
"always take the rebased content", then aren't you stomping on original
commits? You might mean something like "do a regular 3-way merge, and
for every textual conflict, choose the rebased content". That at least
makes some sense, but I suspect it will produce uncompilable results in
most cases.

What I am getting at is: what 'ours' should mean in a rebase depends on
how it can usefully be used in a workflow. Do you have a workflow in
mind?

-Peff
