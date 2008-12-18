From: "Mike Coleman" <tutufan@gmail.com>
Subject: Re: git-diff should not fire up $PAGER, period!
Date: Wed, 17 Dec 2008 20:18:38 -0600
Message-ID: <3c6c07c20812171818k6b6e3555ja991e20d74d8291b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 03:20:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD8Ub-0006VV-4Q
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 03:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbYLRCSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 21:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbYLRCSl
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 21:18:41 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:40973 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbYLRCSk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 21:18:40 -0500
Received: by bwz14 with SMTP id 14so766809bwz.13
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 18:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=+jXk1fbAqTsQ80Bouy8Zq+e1RFH2017+ReKL/d8XquI=;
        b=bCjQvAEo8v3QnrDjhYNuMG7psr1Gf+cALdE3LcQe98Ptw2kdOgenkBKc/4oOs6NW5l
         n5g/5k/bnMXvZyPjkiJFL1KCU2g68lImlL7nn6ZmCWU6ry2C6dFMtCfh6/ctQLQXqOxt
         eAVbKGOmGEG262gbrPYNMjNtp94MSUeDKp8ag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Hur6+shl8b3rf+ZGkoAhHwJNxIAriBvgpfoBbjvSfXya+q7aMe1X/d88g6YkGA31PZ
         p4Pg2gQJBhIgTOLGRKWOqi+p1+AuoczbOHARoXw4Ul9dsAXNlyWvaqqbB6yFLiHSQfVl
         vTQf5dDyt6B5Q+B5/BwvnGHEAaMvF22njwHu8=
Received: by 10.181.56.1 with SMTP id i1mr461769bkk.195.1229566718178;
        Wed, 17 Dec 2008 18:18:38 -0800 (PST)
Received: by 10.181.156.8 with HTTP; Wed, 17 Dec 2008 18:18:38 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103420>

It's so cold here my car wouldn't start this morning, so I feel
fortunate to have these flames to keep me warm!  :-)


I still find git-diff's unsolicited invocation of $PAGER a bit
jarring, but I also find that I like it.  It has a sort of Windows-ish
feel to it (am I straying from the true path?).  It's convenient,
though honestly "git-diff|l" would only be two extra characters.  From
a UI perspective, the oddest thing about it is that all (not, in
fact?) of the other git programs which might also produce lengthy
output *don't* invoke $PAGER--git-status particularly comes to mind.
There are a large number of Unix programs that would be more
convenient if their output was automatically paged, but I'm not sure
it'd be better if they were all changed to do this.  (The best analog
I can think of where this seems desirable is man(1).)

To me, the most important nugget from the original complaint was that
git-diff sends its error messages to stdout.  I understand why it
might be done, but I'd worry about losing the stderr diagnostic for a
command that matters.  [I've been playing around with this for a few
minutes trying to see errors going to stdout and I can't reproduce
it--I wonder if they really do.]


Regarding the emacs complaint, as an emacs user I'd say I'm not
surprised this didn't quite work right.  In the particular case of the
compilation buffer, I wonder if the solution isn't to just unset TERM,
the existence of which (together with the fact that there's a pty)
could be taken as an invitation for the subordinate process to start
doing awful raw-terminal things.  (Similar logic applies to the
DISPLAY variable.)  Like Junio, I also eschew doing terminal emulation
inside of emacs.

Good evening from the icy midwest,
Mike
