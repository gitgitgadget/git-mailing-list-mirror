From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Mon, 9 Sep 2013 16:04:39 -0400
Message-ID: <20130909200438.GD14021@sigill.intra.peff.net>
References: <20130904092527.GB22348@sigill.intra.peff.net>
 <CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
 <20130908041805.GB14019@sigill.intra.peff.net>
 <CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
 <20130908044329.GA15087@sigill.intra.peff.net>
 <CAMP44s3kow9dooPzK6iD8p2LAgt1mtFuaNsVhkJHrqe4D+8xLQ@mail.gmail.com>
 <20130908052107.GA15610@sigill.intra.peff.net>
 <CAMP44s3U2rJsqTj4cAOpY1ntum53bEy2cP5XRNaMu5vwnYVoww@mail.gmail.com>
 <20130908065420.GI14019@sigill.intra.peff.net>
 <20130908100351.GI2582@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Sep 09 22:04:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ7hV-0007lM-M5
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 22:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755085Ab3IIUEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 16:04:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:57568 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752571Ab3IIUEl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 16:04:41 -0400
Received: (qmail 22861 invoked by uid 102); 9 Sep 2013 20:04:41 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Sep 2013 15:04:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Sep 2013 16:04:39 -0400
Content-Disposition: inline
In-Reply-To: <20130908100351.GI2582@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234368>

On Sun, Sep 08, 2013 at 11:03:52AM +0100, John Keeping wrote:

> > I know those are all balanced by some advantages of rebasing, but I also
> > think they are things that can be troublesome for a user who does not
> > fully grok the rebase process. I'm just wondering if we should mention
> > both, but steer people towards merging as the safer alternative (you
> > might have ugly history, but you are less likely to create a mess with
> > duplicate commits or badly-resolved conflicts).
> 
> The really correct thing to do here is to encourage a feature branch
> workflow, but in my experience people are happier to walk through a
> rebase than to switch over to feature branches completely.
> 
> An alternative pull mode would be:
> 
>     git reset --keep @{u} &&
>     git merge @{-1}
> 
> which gets a sensible history shape without any of your disadvantages
> above.  But that didn't go anywhere last time it came up [1] [2].

FWIW, that approach makes some sense to me. De-coupling for a moment the
idea of "what is the default" from "what are the options", it seems like
doing a reverse-merge would be a good option to have in the toolbox.

It would also have other uses beyond "git pull". For example, in
development of GitHub itself, we use topic branches. But before merging
them to master, we often test-deploy the topic to the live site. Before
doing so, you have to merge the topic with the latest master to make
sure you are not un-deploying anybody else's recently graduated topics.

You can do so by creating a temporary merge branch and deploying that,
or you can simply merge master back into the topic. We generally choose
the latter, because it leaves any conflict resolution in an obvious
place (and doesn't need repeating).

-Peff
