From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 00:34:27 +0200
Message-ID: <20080910223427.GB22739@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <20080909211355.GB10544@machine.or.cz> <20080909225603.GA7459@cuci.nl> <20080910122118.GI21071@mit.edu> <20080910141630.GB7397@cuci.nl> <20080910151015.GA8869@coredump.intra.peff.net> <20080910215045.GA22739@cuci.nl> <20080910215410.GA24432@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@MIT.EDU>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 11 00:35:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdYHg-0005xu-Us
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 00:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbYIJWe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 18:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbYIJWe3
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 18:34:29 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:60931 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbYIJWe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 18:34:28 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 853015465; Thu, 11 Sep 2008 00:34:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080910215410.GA24432@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95562>

Jeff King wrote:
>On Wed, Sep 10, 2008 at 11:50:45PM +0200, Stephen R. van den Berg wrote:
>> >There was a proposal at some point for a "notes" feature which would
>> >allow after-the-fact annotation of commits. I don't recall the exact
>> >details, but I think it stored its information as a git tree of blobs.
>> >You could choose whether or not to transfer the notes based on
>> >transferring a ref pointing to the notes tree.

>> The idea is nice, but if we were to use it to store the origin link
>> information, the following happens:
>> - Origin link information is rare.

>I think you are misunderstanding what I meant by "git tree" here. It is
>literally a git tree object, so you don't ask the filesystem at all. You
>are looking up within the single object file. If it's a miss, you know
>after seeing that object. If not, then you dereference the blob object
>that contains the notes.

I see.  Indeed.  That's a lot better.
Did the binary search inside tree objects ever get implemented?

It is unclear why the latest commit notes proposal didn't make it,
though I admit that storing the origin link information in there seems
feasible.

The downsides when doing that are:
- The lookup cost is small, but still noticable, since it is sometimes
  done on every commit; using the in-commit origin headerfield solves
  this at negligible cost.
- The origin information is no longer cryptographically protected (under
  certain circumstances this could be considered an advantage and a
  disadvantage at the same time).
-- 
Sincerely,
           Stephen R. van den Berg.

"Am I paying for this abuse or is it extra?"
