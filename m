From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] commit notes workflow
Date: Sun, 27 Feb 2011 15:31:50 +0100
Message-ID: <4D6A6056.20201@drmicha.warpmail.net>
References: <20110225133056.GA1026@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 27 15:30:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pthe1-0006Om-5S
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 15:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071Ab1B0Oak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 09:30:40 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44280 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751984Ab1B0Oak (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Feb 2011 09:30:40 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 20044207A1;
	Sun, 27 Feb 2011 09:30:39 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Sun, 27 Feb 2011 09:30:39 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=/3X8v7khTunKBx2+yZJotSECBmk=; b=TPyC0UVU7GNX3tNzjwIwQsWnE5Md8RPIb/RYoktGOMdVSGHwqpdPm8Ugv6oVdydawlOvFnGbRwowe36jKeHnM5CErkXXkbL1aTiGwPbz4qVbqETuDQOw5QG9x2rXqcjKvj/KbuBRxea1+DKBH+Tx1m9ZngYNAgbskzormbGp97A=
X-Sasl-enc: oxb4wKD3D8HC9xncB9wLpXobKp8MbxPXf623bSPn/bUF 1298817038
Received: from localhost.localdomain (p5485925B.dip0.t-ipconnect.de [84.133.146.91])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7B5E5407C4B;
	Sun, 27 Feb 2011 09:30:38 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <20110225133056.GA1026@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168032>

Jeff King venit, vidit, dixit 25.02.2011 14:30:
> I was revising a long-ish series today, and I have been wanting to start
> using "git notes" to store information on what's changed between
> versions (which will eventually go after the "---" in format-patch).
> 
> So my workflow was something like:
> 
>   1. git rebase -i, mark one or more commits for edit
> 
>   2. For each commit we stop at:
> 
>      a. Tweak the tree either with enhancements, or to resolve
>         conflicts from tweaks to earlier patches.
> 
>      b. commit --amend, tweak commit message is needed
> 
>      c. git notes add, mention changes
> 
>      d. git rebase --continue
> 
> Two things annoyed me:
> 
>   1. Editing the commit message and notes separately felt awkward. They
>      are conceptually part of the same task to me.
> 
>   2. In the conflict case, there is no opportunity to run "git notes
>      add" because you fix up commits and directly run "rebase
>      --continue".
> 
> So my solution was that "git commit" should be able to embed and extract
> notes from the commit message itself. The patch below implements "git
> commit --notes", which does two things:
> 
>   1. If we are amending, it populates the commit message not just with
>      the existing message, but also with a "---" divider and any notes on
>      the commit.
> 
>   2. After editing the commit message, it looks for the "---" divider
>      and puts everything after it into a commit note (whether or not it
>      put in a divider in step (1), so you can add new notes, too).
> 
> So your commit template looks like:
> 
>   subject
> 
>   commit message body
>   ---
>   notes data
> 
>   # usual template stuff
> 
> I'm curious what people think. Do others find this useful? Does it seem
> harmful?

I can haz tis wiz "format-patch --notes-behind-triple-dash"?

Michael
