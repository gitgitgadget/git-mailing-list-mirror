From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] git-remote: support remotes with a dot in the name
Date: Wed, 21 Feb 2007 05:21:11 -0500
Message-ID: <20070221102111.GB19825@thunk.org>
References: <20070221050336.26431.46485.stgit@dv.roinet.com> <7vwt2ct79x.fsf@assigned-by-dhcp.cox.net> <20070221004631.q4npyww808k88s0o@webmail.spamcop.net> <7vfy90t4mo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 21 11:21:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJobA-0007JZ-2q
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 11:21:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbXBUKVR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 05:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932771AbXBUKVR
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 05:21:17 -0500
Received: from thunk.org ([69.25.196.29]:55171 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932270AbXBUKVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 05:21:16 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HJogN-0008MD-O3; Wed, 21 Feb 2007 05:26:43 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HJob1-0006tJ-89; Wed, 21 Feb 2007 05:21:11 -0500
Content-Disposition: inline
In-Reply-To: <7vfy90t4mo.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40292>

On Tue, Feb 20, 2007 at 10:18:55PM -0800, Junio C Hamano wrote:
> Do you mean:
> 
> 	[remote "wireless-2.6.url"]
> 		url = wire.less:/repo/sito/ry.git
>         	fetch = +refs/heads/*:refs/remotes/wireless-2.6.url/*

Or even more likely:

	[remote "stable-2.6.19"]
		url = git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.19.y.git
		fetch = +refs/heads/*:refs/remotes/stable-2.6.19/*

> If so I think my replacement would match it.  It will be
> returned from "git config --get-regexp '^remote\.'"  like this:
> 
> remote.wireless-2.6.url.url wire.less:/repo/sito/ry.git
> remote.wireless-2.6.url.fetch +refs/heads/*:refs/remotes/wireless-2.6.url/*
> 
> and in:
> 
>  	/^remote\.(\S+?)\.([^.\s]+)\s+(.*)$/
> 
> $1 would match shortest non-whitespace sequence after "remote.",
> $2 would match longuest non-dot, non-whitespace sequence before
> a sequence of whitespaces, and
> $3 would match everything after that sequence of whitespaces.
> 
> So, $1 = "wireless-2.6.url", $2 = "url", $3 = "wire.less:/repo/sito/ry.git"
> or $1 = "wireless-2.6.url", $2 = "fetch", $3 = "+refs/heads/...."
> 
> But my Perl is rusty, so please double check it.

Yep, looks good to me.

						- Ted
