From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: .gittattributes handling has deficiencies
Date: Mon, 22 Oct 2007 11:29:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710221125350.25221@racer.site>
References: <1192956535617-git-send-email-prohaska@zib.de>
 <Pine.LNX.4.64.0710210204580.4818@asgard> <20071022050111.GL14735@spearce.org>
 <565E1D52-59C4-4EB8-AA81-FF94F346FE61@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, david@lang.hm,
	git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 12:30:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjuYT-0006S7-2P
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 12:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbXJVKaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 06:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbXJVKaZ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 06:30:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:38403 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750807AbXJVKaY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 06:30:24 -0400
Received: (qmail invoked by alias); 22 Oct 2007 10:30:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp032) with SMTP; 22 Oct 2007 12:30:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19KZfcY6ulKxdp2ygTNeuQn36DlSf6Q8keKoevHYI
	CLDK+jRFmcque2
X-X-Sender: gene099@racer.site
In-Reply-To: <565E1D52-59C4-4EB8-AA81-FF94F346FE61@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61980>

Hi,

On Mon, 22 Oct 2007, Steffen Prohaska wrote:

> .gitattributes is first looked for in the working directory, and if not 
> there, .gitattributes is read from the index.

Of course we could change that to do it the other way round.  But this 
would contradict expectations when you edit .gitattributes and then 
checkout single files without having git-add'ed .gitattributes first.

The biggest problem in your setup, however, is not if .gitattributes is 
read from the index or the working directory.  The biggest problem is that 
files are not touched when their contents have not changed.

IOW if you have .gitattributes in the to-be-checked-out branch which say 
that README is crlf, and in the current branch it is not, and README's 
_contents_ are identical in both branches, a "git checkout 
<that-other-branch>" will not rewrite README, and consequently not change 
the working copy to crlf.

Ciao,
Dscho
