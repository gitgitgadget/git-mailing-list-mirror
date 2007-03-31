From: Theodore Tso <tytso@mit.edu>
Subject: Re: Pruning objects from history?
Date: Sat, 31 Mar 2007 09:11:34 -0400
Message-ID: <20070331131134.GC25539@thunk.org>
References: <460DC0F7.1070607@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 15:11:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXdMs-0001x4-UZ
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 15:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbXCaNLk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 09:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752388AbXCaNLk
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 09:11:40 -0400
Received: from thunk.org ([69.25.196.29]:56725 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782AbXCaNLj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 09:11:39 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HXdSq-0003qI-7Y; Sat, 31 Mar 2007 09:17:52 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HXdMk-0006LW-BT; Sat, 31 Mar 2007 09:11:34 -0400
Content-Disposition: inline
In-Reply-To: <460DC0F7.1070607@midwinter.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43554>

On Fri, Mar 30, 2007 at 07:01:27PM -0700, Steven Grimm wrote:
> I've imported the full history of a large project from Subversion using 
> the latest git-svn. The resulting repo is huge, and I believe it's due 
> in large part to a series of big tar.gz files that got checked into the 
> Subversion repository by mistake early in the project's history. They 
> were subsequently removed from svn, but of course git-svn grabs them and 
> puts them in my local history.
> 
> Is there any way to excise those files? They are of no interest to us 
> now -- they were data files for a third-party application we ended up 
> not using -- and they're making git look bad in the disk usage department.
> 
> I believe this has been asked before in the context of removing 
> copyrighted content from public repositories. However, I have a twist 
> that may make it easier: nobody else has cloned this repository yet. I 
> am free to rewrite history with no risk of messing up any downstream 
> repositories, and I don't have to worry about propagating the deletions 
> out to anyone. I just don't know how to do it (assuming it's doable at all.)

It's painful to rewrite history, since you end up needing to rewrite
every single commit after the point where you've tampered with time to
fix up the parent commit ID.

Are you planning on doing a one-shot import, or are you hoping to be
able to do bidirectional gatewaying between svn and git?  If you want
to do the latter, rewriting history is going to be very painful if you
want the bidirectional gateway to work afterwards.

If you just want to do a one-way import, it's probably going to be
much easier to modify whatever importer you use to not import the big
files in the first place.

						- Ted
