From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-gc: by default use safer "-A" option to repack when
 not --prune'ing
Date: Thu, 11 Oct 2007 01:49:44 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710110149100.4174@racer.site>
References: <470D6509.5020607@nrlssc.navy.mil> <Pine.LNX.4.64.0710110106160.4174@racer.site>
 <Pine.LNX.4.64.0710101918060.30020@torch.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Oct 11 02:50:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfmFi-00010W-Lq
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 02:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757039AbXJKAuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 20:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757051AbXJKAuF
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 20:50:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:48154 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751022AbXJKAuE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 20:50:04 -0400
Received: (qmail invoked by alias); 11 Oct 2007 00:50:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 11 Oct 2007 02:50:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX193lxkr4Td3B7s8HiCMljj5RPilMzlNdhDZwmYC0J
	kk4COJ3IOXzeeI
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0710101918060.30020@torch.nrlssc.navy.mil>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60575>

Hi,

On Wed, 10 Oct 2007, Brandon Casey wrote:

> On Thu, 11 Oct 2007, Johannes Schindelin wrote:
> 
> > > @@ -211,6 +205,16 @@ int cmd_gc(int argc, const char **argv, const char
> > > *prefix)
> > >  		prune = 0;
> > >  		if (!need_to_gc())
> > >  			return 0;
> > > +	} else {
> > > +		/*
> > > +		 * Use safer (for shared repos) "-A" option to
> > > +		 * repack when not pruning. Auto-gc makes its
> > > +                 * own decision.
> > > +		 */
> > > +		if (prune)
> > > +			append_option(argv_repack, "-a", MAX_ADD);
> > > +		else
> > > +			append_option(argv_repack, "-A", MAX_ADD);
> > >  	}
> > > 
> > >  	if (pack_refs && run_command_v_opt(argv_pack_refs, RUN_GIT_CMD))
> > 
> > To use the append_option() function, you need to make sure that the 
> > argv has enough space, so I suggest adding another NULL to 
> > argv_repack[].  This is enough, since you only ever add one option.  
> > But you should mention it somewhere, probably above the definition of 
> > argv_repack[].
> 
> Shouldn't argv_repack have space for MAX_ADD (10) items?

Ouch... I overlooked that.  So please strike this objection.

Thanks,
Dscho
