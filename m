From: David Jeske <davidj@gmail.com>
Subject: Re: ephemeral-branches instead of detached-head?
Date: Mon, 12 Aug 2013 05:14:42 -0700
Message-ID: <CA+CP9O7--HXQdZXH9MJEh0VqdwpYqb052KYrvZqYhbfajpPG0A@mail.gmail.com>
References: <CA+CP9O6on2NXo6o4_0NoULnT8sgUD3pvvkFZvCTM5xKb38qOeA@mail.gmail.com>
 <7veh9z1gym.fsf@alter.siamese.dyndns.org> <CA+CP9O5fhyQrn3SboafocWJjaAywJHC0T-bw+AXk_8RX53hJ6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 14:15:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8r23-0006xZ-Nd
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 14:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819Ab3HLMP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 08:15:26 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:35262 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425Ab3HLMPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 08:15:25 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so4816790oag.40
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 05:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=humQCX1H5GZYDoqj51zg3nFEtSV/pYTXWG8fW6CvuwA=;
        b=ZNMoqPp9eVtfFlt20cFltyRznzJRgdTcVFdTPgJ+34antLn0451B++cTqUnBXVUqqz
         VVXThtUaZFXjwtW42TcZ71sWzdWSc91OMOGQw6P13bAnneMLSXnP1k5crOfBL0UHGiXf
         brLU0MDOoHwzvMJ8k3Y2yI37xZgKbglxvdm1rWnjH7q7ayoc/O5ttfxPgUKRa1Q5rfvM
         McbFuzup+x+IpFoR1EqDOZxgZtGphoCHbt5Ob5OMRzhpqC3RH7GVgUhA0RO9XBsT/eos
         HSaxcR/LVpbaAlNoFt2xYsCP0m5Rio+DlxBoHrD/STBHQx+Dv+FhxjpDp0P8p9HzURvB
         Atfw==
X-Received: by 10.182.230.135 with SMTP id sy7mr10451153obc.24.1376309722931;
 Mon, 12 Aug 2013 05:15:22 -0700 (PDT)
Received: by 10.60.120.65 with HTTP; Mon, 12 Aug 2013 05:14:42 -0700 (PDT)
In-Reply-To: <CA+CP9O5fhyQrn3SboafocWJjaAywJHC0T-bw+AXk_8RX53hJ6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232185>

@Junio - to put the issue in the context of your previous comments on
the topic... way back when you made a comment about warnings during
commits to detached heads..

http://git.661346.n2.nabble.com/RFC-Detached-HEAD-reminder-on-commit-td834710.html#a834959

> If we _really_ don't want newbies to shoot themselves in the foot, we
> probably can issue a loud warning when they detach there HEAD.
> Oh, wait,... we already do that.


The reason this rationale doesn't ring true for me, is that it is
*very* common for me to checkout a detached-head and there is nothing
odd or dangerous about it. I do this when using checkout to move
around the history to inspect, build, and test different revisions. As
a result, it's very easy to just start ignoring this (usually
meaningless) message.

The dangerous situation only occurs when something is committed onto a
detached-head, and at this point there is no warning. The "# Not
currently on any branch" message that appears during "git status"
easily blends in with boilerplate text there.

IMO, the current warning during checkout of a detached-head is
misplaced. It should be removed, and instead there should only be a
warning after detached-head commit, since this is the only time there
is a danger of losing something.

With my proposed "ephemeral branch" concept, there is no warning
necessary in either case, since any check-ins left dangling would get
names in the branch space you could see and take a look at. If that
dangling head was temporary and was named or rebased, the ephemeral
branch name would disappear automatically, leaving the expert-user
with no warnings and no annoyance, while the novice user with a simple
tool to help them not lose track of changes they made.
