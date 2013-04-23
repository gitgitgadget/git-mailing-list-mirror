From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Tue, 23 Apr 2013 21:59:43 +0530
Message-ID: <CALkWK0mACae7VEe2M-UXhmnU9PUDxu1Ph5HSXb7S4fOGecsFrw@mail.gmail.com>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
 <87ppxmogdv.fsf@linux-k42r.v.cablecom.net> <CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com>
 <87wqruk2pj.fsf@linux-k42r.v.cablecom.net> <CALkWK0mUH2m5zJ4MwPWC85CsZZ=2RODumLvsF9q3rLj-+d7vBw@mail.gmail.com>
 <CALkWK0n5gaz3A7kHT6+5z3YkYdpgU5p6Pv4heMbLzikTbROwkA@mail.gmail.com>
 <CALkWK0k0LbAnkhAAqdeAvBnCig_HO+bT+WiQuQQ3Fgc=FzFtRw@mail.gmail.com>
 <87zjwqpebl.fsf@hexa.v.cablecom.net> <vpqr4i2z35n.fsf@grenoble-inp.fr>
 <7vmwsqns4p.fsf@alter.siamese.dyndns.org> <CALkWK0mO0L4YrZFGmzWkiO4V18p-ydKyjVOe4vJ2H-d7Kz+qOw@mail.gmail.com>
 <7vehe2m88a.fsf@alter.siamese.dyndns.org> <CALkWK0noVfRoXAH75r4yBijXSHD5yusLcKgGC=8bjOW6=qCMng@mail.gmail.com>
 <7vobd5jktd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 18:30:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUg6v-0004qK-6d
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 18:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379Ab3DWQaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 12:30:24 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:62077 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756483Ab3DWQaX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 12:30:23 -0400
Received: by mail-ie0-f182.google.com with SMTP id bn7so891947ieb.41
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 09:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=nW44MQsbctt3vT5YIVqC/WPHpivZymwrLKk2j3ebAT4=;
        b=s0ykxaraYtUm93xvEKNmw6MvVXBsZbHf9Bx6JGEwKAAlbVhAuCdVMyRkuYS5KW3gTE
         eHUOFAtv6kUzOCISTObKlZDm7LToVaqkprQbwnq5LJ3Z99E+bfwc9FhfmK6o1FwMwv0j
         HToWp/UewYkWtMNheMpC0Ic37qHf45L46G+T7USeItRW6VxtZ7bqXXcSac3ma3YcuaN/
         uuOLX2GGOyE1q/6IIeoLBv8G5NYdVYMWHs07SrWBzKQztn6QG98cFwyyrt69a7OtWMAh
         mnGUOqdXBcjoXROZ1PWBAaCY+/eMzt/glXxH72nC5kAC1YqDhmXO2H+X57PjoPMNp5Mz
         jA8Q==
X-Received: by 10.50.117.3 with SMTP id ka3mr23815414igb.107.1366734623336;
 Tue, 23 Apr 2013 09:30:23 -0700 (PDT)
Received: by 10.64.63.48 with HTTP; Tue, 23 Apr 2013 09:29:43 -0700 (PDT)
In-Reply-To: <7vobd5jktd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222186>

Junio C Hamano wrote:
> If you need the history context (i.e. M, M^1, M^2) around it to
> interpret that additional information, isn't it essentially the same
> as storing renames in the merge commit M?

There's one big difference.

The point is that for any kind of repository composition, you're going
to have to store tree renames at some level if you want to be able to
move the submodule around in the tree.  In the current submodule
system, you could say that you're storing tree renames in a blob
(submodule.<name>.path in .gitmodules).  Ofcourse, the difference is
that the other side of the tree entry is completely opaque to the
superproject (and I think we can do better than that now).  You should
use heuristics for all other kinds of renames, but I'm arguing that
repository composition is a special case that needs more thought.

You shouldn't be against storing renames in principle, because we
already do that in a way.  What you should be against is storing
renames in a way that will lock up the repository if a different path
is taken to the same state.

What I'm proposing is an optional field to speed up (and make more
reliable) rename detection in a very specific case.  I'm not putting
the information in a commit because that will lock up our repository:
If there are two different commits representing the same tree, but one
contains bind lines and the other doesn't, we've done something
seriously wrong: rebase and merge are screwed.  In my case, if there
are two perfectly identical trees except that one contains auxiliary
information, nothing goes wrong: the tree without the auxiliary
information will just be a little slower and can't support DWIM git
operations.

> Not very impressed, at least not yet.

Please bear with me.  I really think the repository composition
problem is worth solving.
