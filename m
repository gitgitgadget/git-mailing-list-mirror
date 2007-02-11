From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Speeding up a null fetch
Date: Mon, 12 Feb 2007 00:49:56 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702120045320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702112332.14698.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Feb 12 00:50:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGOSH-0001P9-Bn
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 00:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932927AbXBKXt6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 18:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932929AbXBKXt6
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 18:49:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:50734 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932927AbXBKXt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 18:49:57 -0500
Received: (qmail invoked by alias); 11 Feb 2007 23:49:56 -0000
X-Provags-ID: V01U2FsdGVkX1/4SwRJ0/L4U+/6d3y18jstLOvvyWj11dhY/nXjZe
	+GcQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702112332.14698.julian@quantumfyre.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39335>

Hi,

On Sun, 11 Feb 2007, Julian Phillips wrote:

> An artifical test repository that has similar features (~25000 commits,
> ~8000 tags, ~900 branches and a 2.5Gb packfile) when running locally
> takes ~20m to clone and ~48m to fetch (with no new commits in the
> original repository - i.e. the fetch does not update anything) with a
> current code base (i.e. newer than 1.5.0-rc4).

Ouch.

I hope you packed the refs?

BTW your patch
- was not minimal (and therefore it takes longer than necessary to find 
  what you actually fixed),
- it does not show where and how the call to show-ref is avoided (I 
  eventually understand that you avoid calling update_local_ref early, but 
  you sure could have made that easier), and
- it uses Pythong.

Also, it touches a quite core part of git, which will hopefully be 
replaced by a builtin _after_ 1.5.0.

> However, this seems more band-aid than fix, and I wondered if someone 
> more familiar with the git internals could point me in the right 
> direction for a better fix, e.g. should I look at rewriting fetch in C?

Look into the "pu" branch of git. There are the beginnings of a builtin 
(written in C) fetch.

But this _will_ have to wait until after 1.5.0.

Ciao,
Dscho
