From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] mailinfo: Remove only one set of square brackets
Date: Tue, 30 Jun 2009 01:33:34 -0400
Message-ID: <20090630053333.GD29643@sigio.peff.net>
References: <4A488F07.10002@op5.se> <1246269351-26929-1-git-send-email-ae@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Jun 30 07:32:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLVww-0006LB-M0
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 07:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbZF3Fbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 01:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754161AbZF3Fbl
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 01:31:41 -0400
Received: from peff.net ([208.65.91.99]:57130 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753055AbZF3Fbl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 01:31:41 -0400
Received: (qmail 29703 invoked by uid 1000); 30 Jun 2009 05:33:34 -0000
Content-Disposition: inline
In-Reply-To: <1246269351-26929-1-git-send-email-ae@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122489>

On Mon, Jun 29, 2009 at 11:55:51AM +0200, Andreas Ericsson wrote:

> git-format-patch prepends patches with a [PATCH x/n] prefix, but
> mailinfo used to remove any number of square-bracket pairs and
> the content between them. This prevents one from using a commit
> subject like this:
> 
>   [ and ] must be allowed as input
> 
> Removing the square bracket pair from this rather clumsily
> constructed subject line loses important information, so we must
> take care not to.
> 
> This patch causes the subject stripping to stop after it has
> encountered one pair of square brackets.

I think this is a definite improvement, though I would be much more
convinced that the does the right thing if there were some tests. :)

> One possible downside of this patch is that the patch-handling
> programs will now fail at removing author-added square-brackets
> to be removed, such as
> 
>   [RFC][PATCH x/n]
> 
> However, since format-patch only adds one set of square brackets,
> this behaviour is quite easily undesrstood and defended while the
> previous behaviour is not.

Agreed. And I think Junio raised a good point elsewhere: there are
certain formatting conventions that are part of format-patch output. So
I think we do need to address "this subject munging is totally idiot
proof and will always reproduce the input patch text exactly". But
rather "is this a sane and useful way to do the munging?". And I think
it is a useful convention.

This is a user-visible change that might impact people's workflows (if
only slightly), though, so it should probably get a good mention in the
release notes.

-Peff
