From: David Lee <davidomundo@gmail.com>
Subject: Re: Separate default remotes for pulling and pushing
Date: Mon, 9 May 2011 01:34:22 -0700
Message-ID: <D0FA0C3F-8DA8-4607-A0A6-F9AFAB3EC3CE@gmail.com>
References: <1FDDE878-C81A-4318-836B-7F8BED51A981@gmail.com> <BANLkTinJDUa7sXjKHo81bG7KbnspxZ88oA@mail.gmail.com> <20110509081708.GA5871@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 09 10:34:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJLvM-0000mo-Dr
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 10:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353Ab1EIIe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 04:34:27 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61856 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850Ab1EIIe0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 04:34:26 -0400
Received: by pvg12 with SMTP id 12so2253908pvg.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 01:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:mime-version:content-type:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to:x-mailer;
        bh=BO+EtKtJx1iZHqYZ5LV2vIrWZT+puFlxshzhQ+TCtGI=;
        b=gGYTLSVxUhpBJ88feBdYRB7fzVW1VLBK7vLz/1Q9jseYpnjanu52fb2TcgwQzYqzmV
         UhAMTqrfBdjWLOtnjYuIsqjUOyHtgRm/tXahbRKhyqati03o1XOjDwQvm3zJVFhKP0fJ
         S4WZvoyPoaGo4C4XDku5THLe4woTKxS7GFUzc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=L/gNl4RUzytmLFBa0cHhSkAOtZc0iPX106oH5usYJtEBJkB9tS6ux5PI3p9n1TIAro
         XzW1sZ53KsQ8iasdy/vr/D9dNgSOaf9in11nL0NyK3/CwMJyocJ3yXlJjKIUJgOZoOrR
         iGDZEjYuS7k4MmEu7zgPAu/W9tPLIH2rkiwXw=
Received: by 10.142.148.17 with SMTP id v17mr3410579wfd.409.1304930065760;
        Mon, 09 May 2011 01:34:25 -0700 (PDT)
Received: from [192.168.111.253] (c-24-130-22-226.hsd1.ca.comcast.net [24.130.22.226])
        by mx.google.com with ESMTPS id z10sm7851392wfj.3.2011.05.09.01.34.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2011 01:34:25 -0700 (PDT)
In-Reply-To: <20110509081708.GA5871@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173209>

Hey Jeff,

Thanks for the super write-up.

> That probably doesn't quite do what David wants. It's useful when the
> URL for pushing and pulling a particular repository are different.
> 
> But if I understand it correctly, David has two _separate_ repositories.
> And using remote.*.pushurl for that has some unwanted side effects,
> because the tracking ref namespace (i.e., "remotes/origin/*") is shared
> by both, even though their refs may not be at the same position.
> 
> For example, when pushing "refs/heads/master" to the remote, git will
> update "refs/remotes/origin/master" to the pushed value. But that ref is
> supposed to reflect the value of the last fetch from his "original"
> repository, and now it doesn't. The ref value will flip back and forth
> between what's in the two repositories as he pushes and fetches.

I was actually using Sverre's recommendation with virtually no problems except for what you mention: the ref value flips back and forth.

>  4. Decentralized, you're a developer that publishes work via git. You
>     call the upstream maintainer "origin", so fetches are convenient
>     (and git does this for you at clone, after all). But pushing, even
>     though you probably always push to the same central, does not have
>     a convenient shorthand.

By "push to the same central", I assume you mean "push to the same mirror of origin".

> 
>     This is David's case (and mine, and I suspect some other git
>     developers who do enough work that they want to make it publicly
>     available via git, or even just have backups). It's also encouraged
>     by sites like github, where you might clone the upstream's
>     repository, but then pushes your changes up to a personal "fork"
>     to let others see and merge them.
> 
> So I think part of the reason we don't have such an option is that cases
> 1-3 are so common. But it would be a nice convenience for people in case
> 4.

I think github is making option 4 the dominant use case. In fact, in our workplace we have a similar workflow set up, where we pull from a central origin, but push to individual mirrors from where commits are reviewed, tested, and merged unto origin.

--David