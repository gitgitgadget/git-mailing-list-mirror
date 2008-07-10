From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git protocol specification
Date: Thu, 10 Jul 2008 02:32:55 +0000
Message-ID: <20080710023255.GA8061@spearce.org>
References: <48750231.4020805@rubyisawesome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Tom Werner <pubsub@rubyisawesome.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 04:33:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGlyk-0002WL-6G
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 04:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350AbYGJCc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 22:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752879AbYGJCc4
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 22:32:56 -0400
Received: from george.spearce.org ([209.20.77.23]:41759 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbYGJCcz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 22:32:55 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 25CAD381FC; Thu, 10 Jul 2008 02:32:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48750231.4020805@rubyisawesome.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87932>

Tom Werner <pubsub@rubyisawesome.com> wrote:
> I'm working on a flexible Erlang replacement for git-daemon and would  
> like to know if there is a specification available for the protocol that  
> git-upload-pack and git-receive-pack use. I've reverse engineered it but  
> have come across some points that seem inconsistent. Before I dig into  
> the C code in earnest I wanted to see if there's anything like spec  
> document for the system. Thanks!

I'm curious, are you planning on implementing git-upload-pack and
git-receive-pack in Erlang as well?  Or are you just doing the
git-daemon frontend and spawn the C git binaries as port processes?

git-receive-pack isn't too much trouble, the protocol on the server
side without the tell-me-more is fairly simple to implement, once
you have something like index-pack or unpack-objects implemented.
But that is somewhat non-trivial to do.

git-upload-pack is much more complex on the server side as you
must actually create the packfile, which means you also need to
compute the set of objects the client is missing, as well as tell
the client when you have enough "have" lines in order to compute
the smallest reasonable pack possible for the data transfer.

I know Erlang is really good at protocol handling and binary
formatting/parsing, but I don't know if you have a good git object
navigation library available to you in Erlang.  Its been years
since I last worked with it, or was involved in its community...  ;-)

-- 
Shawn.
