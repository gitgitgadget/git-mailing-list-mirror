From: sean <seanlkml@sympatico.ca>
Subject: Re: Implementing branch attributes in git config
Date: Mon, 8 May 2006 20:08:26 -0400
Message-ID: <BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE>
References: <1147037659.25090.25.camel@dv>
	<Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
	<1147048587.17371.13.camel@dv>
	<Pine.LNX.4.64.0605071740550.3718@g5.osdl.org>
	<7vfyjli9vf.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
	<7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE>
	<Pine.LNX.4.64.0605081905240.6713@iabervon.org>
	<BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
	<Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 02:13:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdFrE-0004C8-3D
	for gcvg-git@gmane.org; Tue, 09 May 2006 02:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWEIANf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 20:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWEIANf
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 20:13:35 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:8392 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1750926AbWEIANe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 20:13:34 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 8 May 2006 17:13:33 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 67CE7644C28;
	Mon,  8 May 2006 20:13:32 -0400 (EDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-Id: <20060508200826.2b0f34a6.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 09 May 2006 00:13:33.0908 (UTC) FILETIME=[68E9C140:01C672FD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 9 May 2006 01:44:31 +0200 (CEST)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Hi,
> 
> On Mon, 8 May 2006, sean wrote:
> 
> > There's no good reason for git to break with traditional and common 
> > practice in this case.
> 
> It is well established common practice that ini files (and everything in 
> config resembles an ini file) have case insensitive section headers as 
> well as keys.

Not in ini files that support section headers that represent filenames
and directories.  Exactly because those things _are_ case sensitive 
and include more characters than just alnums.  But we're not just 
talking about the config file syntax we're talking about how the 
user must ultimately refer to branches with uppercase character.  
Now everytime a person wants to add a branch attribute via repo-config
they have to remember that git thinks uppercase characters should
be quoted.  Doesn't that sound ridiculous to you?

The point is that we should make the config file and the repo-config
command easy for the _users_.   Instead we're going to make them use
some crazy extra syntax because we refuse to come to terms with the
limitations of the choices we've made so far.

One option, which I don't really like and comes with its own set of 
problems, would be to do something like:

[branch1]
    streetname = "p4/BrAnCH"
[branch2]
    streetname = "origin"

And then allow reference to it from git-repo-config by either branch#
or the value of street name.  While it would take some extra coding
but at least it lives within the current restrictions for key names.

It just seems that once you have to even consider options like this,
a big red flag should be raised about some of the assumptions we've
built into the system.

Sean
