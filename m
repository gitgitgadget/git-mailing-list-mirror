From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Sun, 7 Apr 2013 19:59:05 +0100
Message-ID: <20130407185905.GK2222@serenity.lan>
References: <7vr4im7m1y.fsf@alter.siamese.dyndns.org>
 <CALkWK0=jrO9MQotB+anAn-5YtG1RBTLWEnGL5=K4wy=yi7E-CQ@mail.gmail.com>
 <20130407161209.GG2222@serenity.lan>
 <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
 <20130407170201.GH2222@serenity.lan>
 <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
 <20130407175210.GI2222@serenity.lan>
 <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan>
 <5161BC33.8060707@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Apr 07 20:59:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOuoC-00084m-H8
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 20:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934290Ab3DGS7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 14:59:16 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:60111 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934285Ab3DGS7P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 14:59:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 792D66064AA;
	Sun,  7 Apr 2013 19:59:15 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mgwABrb5J4iH; Sun,  7 Apr 2013 19:59:15 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id D3B736064E0;
	Sun,  7 Apr 2013 19:59:07 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <5161BC33.8060707@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220360>

On Sun, Apr 07, 2013 at 08:34:27PM +0200, Jens Lehmann wrote:
> The whole feature list is full of red herrings like this which
> have nothing to do with the advantages of a new object, but talk
> about UI issues which are easy to solve in both worlds.

With the clarifications Ram's provided in this thread, I think there are
also some important regressions in functionality in his proposal (at
least as it currently stands), particularly losing the .gitconfig
overrides.

The only proposed change that seems to me to be impossible with the
current .gitmodules approach is the "submodule in a non-initialized
submodule" feature, but I've never seen anyone ask for that and it seems
likely to open a whole can of worms where the behaviour is likely to
vary with $PWD.  The current hierarchical approach provides sensible
encapsulation of repositories and is simple to understand: once you're
in a repository nothing above its root directory affects you.

It doesn't seem to me that "it's harder than I'd like to add a feature I
want" is a good reason to subject all users of submodules to a lot of
pain migrating to some new implementation that doesn't work the way
they're used to and which will mean they have to deal with complaints
when people using an older version of Git can't clone their repository
(and I doubt we want this mailing list to be flooded with such
complaints either).
