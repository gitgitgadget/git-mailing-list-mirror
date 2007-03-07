From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-bundle: fix pack generation.
Date: Wed, 7 Mar 2007 23:35:06 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703072330200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45ECEB40.4000907@gmail.com>  <7vejo2stlw.fsf@assigned-by-dhcp.cox.net>
 <45EE1242.8080405@gmail.com>  <7vhcsxkb8n.fsf@assigned-by-dhcp.cox.net>
 <45EE2ECA.60403@gmail.com>  <Pine.LNX.4.63.0703070419410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
  <45EE36A1.30001@gmail.com>  <Pine.LNX.4.63.0703070504140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <30e4a070703070834s3dd5bdd7x2e1639aa2979d1cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 23:35:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP4j4-0000LV-NX
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 23:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992677AbXCGWfK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 17:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992680AbXCGWfK
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 17:35:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:53710 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992677AbXCGWfI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 17:35:08 -0500
Received: (qmail invoked by alias); 07 Mar 2007 22:35:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 07 Mar 2007 23:35:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/1ubV69uT1nZWC2DKMcKiS3aOG45QEDHTZS9NiU4
	vNECClrl8Lm9Sy
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <30e4a070703070834s3dd5bdd7x2e1639aa2979d1cf@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41698>

Hi,

On Wed, 7 Mar 2007, Mark Levedahl wrote:

> On 3/6/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > > git-bundle create test.bdl HEAD --since=1.day.ago ==>> pack with 
> > > 1531 objects
> > 
> > Did you test with "--since=1.day.ago HEAD", i.e. with the correct 
> > order? I know you'd like the options to be interminglable, but "HEAD" 
> > really is not an option, but an argument.
> 
> Changing the order of arguments makes no difference, same result either 
> way.

We don't do thin packs. Should we? I guess that 

	$ git ls-tree -r HEAD | wc

results in something close to 1500 in that repo. Which basically means 
that the 1531 objects (including trees and the commit) sounds correct.

Of course, we _could_ make the packs thin, but the disadvantage would be 
that we can never decide at a later stage to allow shallow fetches from 
that bundle.

The advantage of the thin packs would be that the bundles would be much 
smaller.

Ciao,
Dscho
