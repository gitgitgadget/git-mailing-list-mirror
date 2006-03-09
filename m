From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: bug?: stgit creates (unneccessary?) conflicts when pulling
Date: Thu, 9 Mar 2006 22:00:25 +0000
Message-ID: <b0943d9e0603091400o2cd0291h@mail.gmail.com>
References: <20060227204252.GA31836@diana.vm.bytemark.co.uk>
	 <20060227222600.GA11797@spearce.org> <tnx1wxmig75.fsf@arm.com>
	 <20060301145105.GB3313@spearce.org>
	 <b0943d9e0603010708l72cb14d1w@mail.gmail.com>
	 <20060301155043.GA3706@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 09 23:00:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHTBN-0008Sn-MS
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 23:00:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbWCIWA1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 17:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbWCIWA1
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 17:00:27 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:21621 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751608AbWCIWA0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 17:00:26 -0500
Received: by xproxy.gmail.com with SMTP id s11so420274wxc
        for <git@vger.kernel.org>; Thu, 09 Mar 2006 14:00:25 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Za0ra87BxJ1GLKwmdTu78gY22R058GzXQ0OeElAW2zAfejWTMckmXcbZAxBv9w4GoWD0gc8omUrGr0eBfbKUyLLezQkQm9SajpBCeV74zzdNZaOhNLSFn59kWHn3wwsDoZTMpopOdGFwmj6Yt1Rl3fdAtRMaGduyC+OhwRM5S4g=
Received: by 10.70.78.12 with SMTP id a12mr2856540wxb;
        Thu, 09 Mar 2006 14:00:25 -0800 (PST)
Received: by 10.70.31.4 with HTTP; Thu, 9 Mar 2006 14:00:25 -0800 (PST)
To: "Shawn Pearce" <spearce@spearce.org>
In-Reply-To: <20060301155043.GA3706@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17438>

On 01/03/06, Shawn Pearce <spearce@spearce.org> wrote:
> Speaking of making StGIT faster: earlier we were talking about how
> git-diff|git-apply is faster than a 3 way git-read-tree on large
> merges when there are many structural changes in the tree due to
> the smaller number of process spawns required.
>
> You might want to take a look at pg--merge-all: This is sort of based
> on git-merge-recursive, but I've gotten it down to just a handful
> of process spawns, aside from the stupidity of git-checkout-index.

Trying to implement this, I've just noticed that git-read-tree has a
--aggressive option which takes care of the file removals. Adding this
option lowered the pushing time in StGIT from ~2 min to under 2
seconds (merges between 2.6.14 and the latest kernel). There's
probably no need to deal with file removals in pg--merge-all anymore.

--
Catalin
