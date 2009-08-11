From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: bug with .git file and aliases
Date: Tue, 11 Aug 2009 12:04:06 +0200
Message-ID: <4A814216.20708@drmicha.warpmail.net>
References: <7f9d599f0907200654q2e068e6aq3051c122f6596053@mail.gmail.com> <20090720152117.GB5347@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Geoffrey Irving <irving@naml.us>, git@vger.kernel.org,
	Lars Hjemli <hjemli@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 11 14:46:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaqkP-0004ns-MD
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190AbZHKMqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 08:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753064AbZHKMqU
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 08:46:20 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:38915 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753974AbZHKMqS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 08:46:18 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2D7D512568;
	Tue, 11 Aug 2009 06:04:22 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 11 Aug 2009 06:04:22 -0400
X-Sasl-enc: l+008v2fLJ4M/YsqWACXEk2T+GtMib7eeMWSgusS0PHJ 1249985061
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E7C285DD0;
	Tue, 11 Aug 2009 06:04:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.3pre) Gecko/20090811 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <20090720152117.GB5347@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125544>

Jeff King venit, vidit, dixit 20.07.2009 17:21:
> On Mon, Jul 20, 2009 at 09:54:12AM -0400, Geoffrey Irving wrote:
> 
>> git 1.6.3.3 has a bug related to .git file support and aliases.
>> Specifically, if you make an alias for status and call it from a
>> subdirectory, git status chdirs into the true .git dir but then
>> chdir's back to the wrong place in order to run the lstats for status.
>>  The result is that git status thinks all files have disappeared.
> 
> Yeah, this is a known problem. The problem is that the 'git' wrapper
> sets up the environment only partially when running aliases, and then
> the resulting command ends up confused about where the worktree is. I
> really don't remember the specifics, but you can probably find some
> discussion in the list archives.  Fixing it, IIRC, required some
> refactoring of the setup code (which I had hoped to get to at some
> point, but I am way behind on my git todo list).
> 
> Hmm. Poking around a bit, this seems related, but I don't know why I
> never followed up:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/72792
> 
> -Peff

...because it was up to the brave git-on-win folks to decide whether
setenv() on win would be rewritten to not use putenv() when the value is
"". J&J, has anything happened on the front or is it likely to? (I'm
sorry I can't offer help, only moral support...)

Jeff's patch from Feb. 08 still applies more or less cleanly (with
obvious adjustments) and makes the relevant tests pass (on Linux).

Michael
