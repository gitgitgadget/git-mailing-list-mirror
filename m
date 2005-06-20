From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git-rev-list: "--bisect" flag
Date: Mon, 20 Jun 2005 20:29:56 +1000
Message-ID: <2cfc403205062003292db2b457@mail.gmail.com>
References: <Pine.LNX.4.58.0506172306210.2268@ppc970.osdl.org>
	 <Pine.LNX.4.58.0506182022130.2268@ppc970.osdl.org>
	 <Pine.LNX.4.58.0506182141400.2268@ppc970.osdl.org>
	 <2cfc403205061903155a6090db@mail.gmail.com>
	 <2cfc40320506190741409f3a5@mail.gmail.com>
	 <Pine.LNX.4.58.0506190951330.2268@ppc970.osdl.org>
	 <2cfc4032050619125537dee354@mail.gmail.com>
	 <Pine.LNX.4.58.0506192002240.2268@ppc970.osdl.org>
	 <2cfc403205061920272ee47166@mail.gmail.com>
	 <2cfc40320506192030290187af@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 12:27:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkJTs-0001Hj-B4
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 12:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVFTKbU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Jun 2005 06:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVFTKbU
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jun 2005 06:31:20 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:52389 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261152AbVFTK34 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2005 06:29:56 -0400
Received: by rproxy.gmail.com with SMTP id i8so656028rne
        for <git@vger.kernel.org>; Mon, 20 Jun 2005 03:29:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s8ehHP8SPADbRLK+rTjcAeA8aIAxDNKIyK0bPsAdzlCAgzxyXcvssZkdJFPKS81BlKB0pJF6aooswhs4Z4CbXR5XWiWCBncVpTaqfDGEk1iEtn0gz4tsaYFxCv5RQBB3qwPGMOLP7omNs/6sDvkyJW4mXFalHqZirWT8z58BieI=
Received: by 10.39.3.25 with SMTP id f25mr2118844rni;
        Mon, 20 Jun 2005 03:29:56 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Mon, 20 Jun 2005 03:29:56 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <2cfc40320506192030290187af@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/20/05, Jon Seymour <jon.seymour@gmail.com> wrote:
> > 1. count all visible nodes [ i.e. nodes that git-rev-list would print
> > ], call this value N
> > 2. at the top node inject N units of mass
> > 3. traverse the visible graph, in topological order
> > 4. at each node, send all the mass received from parents minus 1 unit
> > onto visible parents. Record how much mass you have sent downstream.
> > Keep a record of the nodes that have seen nearest to half of that
> > mass.
> 
> Correction - at each node, send all mass received from _children_
> 

This is a little too simple. It would work if the all nodes in the
visible graph were all connected to the base of an epoch. However, the
pruning behaviour of known goods effectively installs blockages into
the network and causes "backflow" which complicates things somewhat -
a plumbers nightmare!

I am exploring another variation of the idea which is even simpler.
Experimentally it seems quite similar to your average case
performance, but doesn't yet approach your low std deviations.
However, I think I know why that is, so I will, after a few games of
pool and a similar number of beers, have another crack at it.

jon.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
