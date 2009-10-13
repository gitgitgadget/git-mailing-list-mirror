From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v2 07/16] remote-helpers: Fetch more than one ref
	in a batch
Date: Tue, 13 Oct 2009 11:05:52 -0700
Message-ID: <20091013180552.GW9261@spearce.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org> <1255400715-10508-8-git-send-email-spearce@spearce.org> <alpine.LNX.2.00.0910122326130.32515@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 20:24:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxm2r-0006Ju-B9
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 20:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760824AbZJMSGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 14:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760822AbZJMSGa
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 14:06:30 -0400
Received: from george.spearce.org ([209.20.77.23]:53253 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760600AbZJMSG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 14:06:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D4A5D381FE; Tue, 13 Oct 2009 18:05:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0910122326130.32515@iabervon.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130173>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Mon, 12 Oct 2009, Shawn O. Pearce wrote:
> > Some network protocols (e.g. native git://) are able to fetch more
> > than one ref at a time and reduce the overall transfer cost by
> > combining the requests into a single exchange.  Instead of feeding
> > each fetch request one at a time to the helper, feed all of them
> > at once so the helper can decide whether or not it should batch them.
> > 
> > Because 'fetch' was already released in 1.6.5 we introduce the new
> > fetch-multiple capability/command to signal that the helper wants
> > to use batch oriented approach to fetching refs.
> 
> In 1.6.5, there's no way to call a helper other than git-remote-curl, and 
> no way to call git-remote-curl unless 1.6.5 was built with it. So I think 
> the protocol is not set in stone quite yet. It's documentated for being an 
> API, and it's supposed to be that, but it's not quite there in this 
> version.

I originally had this change as just redefining "fetch" to be batch
oriented and requiring a blank line to terminate the batch group,
but reconsidered when 1.6.5 shipped and I realized this code was
in 1.6.5.

But, yea, you are right, with no way to invoke anything except
remote-curl there really isn't that much of a problem if we change
the protocol.

-- 
Shawn.
