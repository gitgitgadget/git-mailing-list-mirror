From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Handling renames.
Date: Thu, 14 Apr 2005 18:23:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504141758310.30848-100000@iabervon.org>
References: <1113501260.27227.26.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, James Bottomley <James.Bottomley@SteelEye.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 00:20:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMCgn-0007In-4r
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 00:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVDNWXQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 18:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVDNWXQ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 18:23:16 -0400
Received: from iabervon.org ([66.92.72.58]:21764 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261582AbVDNWXM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 18:23:12 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DMCkA-000289-00; Thu, 14 Apr 2005 18:23:26 -0400
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1113501260.27227.26.camel@hades.cambridge.redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 14 Apr 2005, David Woodhouse wrote:

> Opinions? Dissent? We'd probably need to escape the filenames in some
> way -- handwave over that for now.

I personally think renames are a minor thing that doesn't happen
much. What actually happens, in my opinion, is that some chunk of a file
is moved to a different, possibly new, file. If this is supported (as
something that the SCM notices), then a rename is just a special case
where the moved chunk is a whole file.

I think that it should be possible to identify and tag "big
enough" deletions and insertions, and compare them to find moves, where a
further change may be applied in the middle if two chunks are "very
similar" but not the same.

On the other hand, I think that the SCM will need to cache its
understanding of what a commit did in order to give reasonable
performance for operations like "annotate", and it may be advantegous to
distribute things from this cache, since the committer might want to tell
the system something that it didn't guess.

At some point, I'm going to argue for core support for "back pointers",
where a file can be created which is "about" some other file(s), and
someone looking for files "about" a particular file can find them without
searching the entire database. I think this will turn out to be important
for a variety of cases where some later participant wants to say something
about an existing file without changing the content of the file.

	-Daniel
*This .sig left intentionally blank*

