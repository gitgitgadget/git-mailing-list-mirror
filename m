From: Jeff King <peff@peff.net>
Subject: Re: Git Large Object Support Proposal
Date: Fri, 20 Mar 2009 00:46:09 -0400
Message-ID: <20090320044609.GC27160@coredump.intra.peff.net>
References: <d411cc4a0903191514n1e524ebava5895d708a2927c4@mail.gmail.com> <7veiwt6t6a.fsf@gitster.siamese.dyndns.org> <d411cc4a0903191618x503db946n62d3132eece69175@mail.gmail.com> <7vzlfh5b7y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 05:47:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkWe5-0003NA-9R
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 05:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbZCTEqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 00:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbZCTEqT
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 00:46:19 -0400
Received: from peff.net ([208.65.91.99]:57724 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703AbZCTEqS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 00:46:18 -0400
Received: (qmail 6621 invoked by uid 107); 20 Mar 2009 04:46:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 20 Mar 2009 00:46:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2009 00:46:09 -0400
Content-Disposition: inline
In-Reply-To: <7vzlfh5b7y.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113894>

On Thu, Mar 19, 2009 at 04:44:49PM -0700, Junio C Hamano wrote:

> Aha, that sounds like you can just maintain a set of out-of-tree symbolic
> links that you keep track of, and let other people (e.g. rsync) deal with
> the complexity of managing that side of the world.
> 
> And I think you can start experimenting it without any change to the core
> datastructures.  In your single-page web site in which its sole html file
> embeds an mpeg movie, you keep track of these two things in git:
> 
> 	porn-of-the-day.html
>         porn-of-the-day.mpg -> ../media/6066f5ae75ec.mpg
> 
> and any time you want to feed a new movie, you update the symlink to a
> different one that lives outside the source-controlled tree, while
> arranging the link target to be updated out-of-band.

I have a repo like this (not porn, but large files :) ) and I use a
similar solution. Instead of large blobs, I have stub files containing a
URL, and the make process pulls them as necessary. It works pretty well
in practice. I don't bother with naming the files by sha-1 but instead
give them human-readable names, since in my case they are generally
immutable (i.e., one a name is assigned, the content doesn't change).

-Peff
