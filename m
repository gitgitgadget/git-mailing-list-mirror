From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@lavabit.com>
Subject: Re: [PATCH] git-send-pack: don't consider branch lagging behind as  errors.
Date: Sat, 21 Jun 2008 07:14:40 +0900
Message-ID: <20080621071440.6117@nanako3.lavabit.com>
References: <7vhcbpuvfb.fsf@gitster.siamese.dyndns.org>
	<1213872715-11182-1-git-send-email-madcoder@debian.org>
	<20080619133747.GA31209@sigill.intra.peff.net>
	<20080619135159.GA19560@artemis.madism.org>
	<20080619151110.GA31654@sigill.intra.peff.net>
	<20080619162801.GA2468@artemis.madism.org>
	<7vhcbpuvfb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Pierre Habouzit <madcoder@debian.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 00:16:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9ouL-0001V0-G3
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 00:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbYFTWPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 18:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753876AbYFTWPa
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 18:15:30 -0400
Received: from karen.lavabit.com ([72.249.41.33]:39377 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753859AbYFTWP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 18:15:29 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 0E21EC7AFA;
	Fri, 20 Jun 2008 17:15:19 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 3HSEIXFX20HJ; Fri, 20 Jun 2008 17:15:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=GGQ562VrjeYVnTXUdW44xLpqxNVzKTsyGN9H8vZv+ZqApAPbaiyuhcG7d848fHXMz9/C234AhKLhUE1B/iIgDsAvAMgGsZcOYGmO5GKnL/wv1E2YCNcy5r1u3ndXNAntx3/GA0sm9OWWpUYVB2RvPIk89wXqNp27yezwAUqlCuc=;
  h=From:Subject:To:Cc:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Quoting Junio C Hamano <gitster@pobox.com>;
In-Reply-To: <7vhcbpuvfb.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85679>

Quoting Junio C Hamano <gitster@pobox.com>:

> The issue of "many refs in the repo but I work only on a few" has already
> been resolved by being able to say "I push only the current branch" in the
> previous thread, I think, but I am too busy to go back to re-study the
> history, so could you kindly do that for us?

I almost agreed with Pierre before I read your response, but as
always you are right.  If the only thing I know is that my
current branch is ready to be pushed and I do not know if other
branches are, I do not have to push all branches (I am not sure
how exactly it works. Do we push all the branches, or do we push
branches that exist on both sides?).  Pushing the one I want to
push is the right thing to do, and I can easily say it.

> You might argue that the case where you are truly behind _could_ be
> ignored and pretend as if the user did not even _ask_ to push it (hence,
> return success without doing anything to that branch), but I am not
> convinced even that is a good idea.

But I think that is a reasonable new feature and is close to
what Pierre is asking for.  He wants to be able to push "all
except for the ones that he does not want to push", wants
git to guess which ones are the ones he does not, and wants to
make the logic of guessing to consider stale ones are unwanted.

But I do agree with you that it is wrong to replace existing
"push all" with such a new feature.  When people want to push
all, they do want to push all and see the command report error
when some branches are not updated.  Even though I think what
Pierre wants to have may be a reasonable new feature, it should
not break "push all" for people who rely on the existing
behavior.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
