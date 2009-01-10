From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH v2] make diff --color-words customizable
Date: Sat, 10 Jan 2009 09:53:56 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0901100950230.21891@alien.or.mcafeemobile.com>
References: <87wsd48wam.fsf@iki.fi> <gk8usj$slh$1@ger.gmane.org> <alpine.DEB.1.00.0901101237050.30769@pacific.mpi-cbg.de> <200901101436.48149.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 18:56:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLi3Z-0000Fl-Ln
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 18:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbZAJRyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 12:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752543AbZAJRyF
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 12:54:05 -0500
Received: from x35.xmailserver.org ([64.71.152.41]:58269 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbZAJRyE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 12:54:04 -0500
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.26 ESMTP Server]
	id <S2C5C57> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Sat, 10 Jan 2009 12:54:01 -0500
X-X-Sender: davide@alien.or.mcafeemobile.com
In-Reply-To: <200901101436.48149.jnareb@gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105134>

On Sat, 10 Jan 2009, Jakub Narebski wrote:

> On Sat, 10 Jan 2009, Johannes Schindelin wrote:
> > On Sat, 10 Jan 2009, Jakub Narebski wrote:
> > > Thomas Rast wrote:
> > > 
> > > > --color-words works (and always worked) by splitting words onto one
> > > > line each, and using the normal line-diff machinery to get a word
> > > > diff. 
> > > 
> > > Cannot we generalize diff machinery / use underlying LCS diff engine
> > > instead of going through line diff?
> > 
> > What do you think we're doing?  libxdiff is pretty hardcoded to newlines.  
> > That's why we're substituting non-word characters with newlines.
> 
> Isn't Meyers algorithm used by libxdiff based on LCS, largest common
> subsequence, and doesn't it generate from the mathematical point of
> view "diff" between two sequences (two arrays) which just happen to
> be lines? It is a bit strange that libxdiff doesn't export its low
> level algorithm...

The core doesn't know anything about lines. Only pre-processing (setting 
up the hash by tokenizing the input) and post-processing (adding '\n' to 
the end of each token), knows about newlines. Memory consumption would 
increase significantly though, since there is a per-token cost, and a 
word-based diff will create more of them WRT the same input.


- Davide
