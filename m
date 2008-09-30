From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH, resent] fix openssl headers conflicting with custom
	SHA1 implementations
Date: Tue, 30 Sep 2008 13:51:22 -0700
Message-ID: <20080930205122.GO21310@spearce.org>
References: <alpine.LFD.2.00.0809301621091.3635@xanadu.home> <20080930203928.GN21310@spearce.org> <alpine.LFD.2.00.0809301645340.3635@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Sep 30 22:52:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkmCw-000421-9U
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 22:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071AbYI3UvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 16:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752944AbYI3UvX
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 16:51:23 -0400
Received: from george.spearce.org ([209.20.77.23]:46204 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbYI3UvX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 16:51:23 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8EDD63835F; Tue, 30 Sep 2008 20:51:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0809301645340.3635@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97161>

Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 30 Sep 2008, Shawn O. Pearce wrote:
> > Nicolas Pitre <nico@cam.org> wrote:
> > > On ARM I have the following compilation errors:
> > ...
> > > This is a bit ugly but given the rat nest of system includes we have I 
> > > don't know how to solve this any better.
> > 
> > Hmm.  On Linux x86 with your change:
> > 
> > In file included from imap-send.c:32:
> > cache.h: In function 'create_ce_mode':
> > cache.h:186: error: 'S_IFLNK' undeclared (first use in this function)
> > 
> > I think that last hunk which moved the openssl includes to be before
> > cache.h is the problem.
> 
> With that, my build on ARM bombs out with:
> 
>     CC imap-send.o
> In file included from /usr/include/openssl/kssl.h:71,
>                  from /usr/include/openssl/ssl.h:191,
>                  from imap-send.c:30:
> /usr/include/ctype.h:102: error: expected expression before ']' token

*sigh*

Yea, its a bit ugly due to the rats nest of system includes.
Right now I don't see how we can include your patch, it breaks a
major platform for us.  But obviously my "fix" is also bogus and
won't get ARM working again.

Any other ideas we can try?  'cause I don't have any right now.  :-|

-- 
Shawn.
