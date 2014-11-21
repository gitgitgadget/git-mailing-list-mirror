From: Patrick Schleizer <patrick-mailinglists@whonix.org>
Subject: Re: How safe are signed git tags? Only as safe as SHA-1 or somehow
 safer?
Date: Fri, 21 Nov 2014 23:01:26 +0000
Message-ID: <546FC446.50101@whonix.org>
References: <5468C33E.2080108@whonix.org> <20141117212657.GC15880@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, whonix-devel@whonix.org, mikegerwitz@gnu.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 22 00:01:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrxCt-00081f-Ot
	for gcvg-git-2@plane.gmane.org; Sat, 22 Nov 2014 00:01:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbaKUXBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 18:01:35 -0500
Received: from whonix.org ([92.243.7.197]:58398 "EHLO whonix.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097AbaKUXBf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2014 18:01:35 -0500
Received: from 127.0.0.1 (unknown [37.157.195.83])
	by whonix.org (Postfix) with ESMTPSA id 208D25F7B;
	Sat, 22 Nov 2014 00:01:30 +0100 (CET)
In-Reply-To: <20141117212657.GC15880@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git developers!

Jeff King wrote:
> On Sun, Nov 16, 2014 at 03:31:10PM +0000, Patrick Schleizer wrote:
> 
>> How safe are signed git tags? Especially because git uses SHA-1. There
>> is contradictory information around.
>>
>> So if one verifies a git tag (`git tag -v tagname`), then `checksout`s
>> the tag, and checks that `git status` reports no untracked/modified
>> files, without further manually auditing the code, how secure is this
>> actually? Is it only as safe as SHA-1?
> 
> Yes, it is only as "safe as SHA-1" in the sense that you have GPG-signed
> only a SHA-1 hash. If somebody can find a collision with a hash you have
> signed, they can substitute the colliding data for the data you signed.
> 
> Of course, "safe as SHA-1" and "find a collision" are vague. If
> pre-image attacks are feasible (i.e., given already-published SHA-1, I
> can find a different input with the same SHA-1), then attacks are
> trivial. But when people talk about attacks on SHA-1, they are usually
> referring to finding a collision between two new pieces of data. You can
> also use that in an attack, but it's much less straightforward
> (basically, you need to get somebody to sign one of the colliding pieces
> of data and then replace it with the other).

Sounds pretty sad. Isn't this a security issue that should be fixed?

Rather than discussing how feasible collisions in SHA-1 are... Attacks
on SHA-1 are only getting worse, no? Since the Snowden revelations we
know that powerful adversaries that are working on such things and would
use such weaknesses to exploit users.

Dear git developers, could you please make a long story short? Change to
some stronger hash algorithm? (sha256, sha512, or so?) Or provide an
option for that?

> And of course there is the question of getting the colliding data to the
> victim. Git does collision checks whenever a remote (e.g., from a "git
> fetch") gives us data that we already have. So you could poison new
> cloners with bad data, but you could not convince a repository with the
> existing "good" half of the collision to fetch the "evil" half.

Poison git cloners with bad data is exactly my point here. Because
sometimes I am a cloner of my own code - cloning it on a separate
machine - then verify it using gpg - but don't check it any further. In
such cases, I'd prefer if security wouldn't depend on SHA-1.

Cheers,
Patrick
