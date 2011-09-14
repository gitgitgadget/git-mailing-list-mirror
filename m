From: Sam Vilain <sam@vilain.net>
Subject: Re: [Survey] Signed push
Date: Tue, 13 Sep 2011 18:03:14 -0700
Message-ID: <4E6FFD52.7050907@vilain.net>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org> <4E6FF5D9.3080709@vilain.net> <CAJo=hJt-n0Xn85g7-7eEgxZhsBu8wd843dvvbaJgdYSx3t4Xug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 14 03:04:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3dtg-0007uV-0x
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 03:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175Ab1INBDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 21:03:20 -0400
Received: from uk.vilain.net ([92.48.122.123]:57011 "EHLO uk.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753044Ab1INBDT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 21:03:19 -0400
Received: by uk.vilain.net (Postfix, from userid 1001)
	id D4116824D; Wed, 14 Sep 2011 02:03:18 +0100 (BST)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on uk.vilain.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [192.168.112.205] (unknown [64.125.143.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uk.vilain.net (Postfix) with ESMTPSA id 53D81820E;
	Wed, 14 Sep 2011 02:03:16 +0100 (BST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <CAJo=hJt-n0Xn85g7-7eEgxZhsBu8wd843dvvbaJgdYSx3t4Xug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181333>

On 9/13/11 5:39 PM, Shawn Pearce wrote:
> >  If the push certificate also has the previous commit IDs for the changed
> >  refs, then you actually have an audit log.  Otherwise, it does not certify
> >  the commit range they pushed.
> Is that necessary? The range they are certifying is that commit, and
> its entire ancestry. If the pusher doesn't trust his ancestry, why is
> he working with it? Similar to an annotated tag. I make a signed
> annotated tag, I am asserting that revision and its ancestry is
> something I like as far as a project build goes. You don't need the
> old revision to realize I like this commit.

Perhaps because they didn't notice what happened.  Someone else pushed 
to the server without a signed push somehow, and then they pulled, 
pushed ... and now as far as you know, those commits are certified like 
any other.  Having this extra information, not much information, will 
help figure out what happens in this sort of situation.

>> This is an important prerequisite for a fully distributed, peer to peer git.
>>   For this case it would also need something to distinguish which repository
>> is to be updated; such as a canonical repository URL (or list of URLs), or
>> just a short project name.  A P2P protocol can then know projects as (KEYID,
>> projectname).
> Why do we need a project name? Most Git based projects are uniquely
> identified by the set of root commits they have. Why? Because most
> root commits were created by different people, at different times,
> with different commit messages, and different initial trees, resulting
> in a unique commit SHA-1 for that root commit. Projects with more than
> one root commit also disambiguate themselves from other projects that
> maybe contain one of those roots (e.g. git.git vs. gitk).
>
> If you wanted to identify a project on a P2P network, I think you
> would want to do it based off the root commits, not some random name
> people came up with and might try to publish forgeries under.
>

Yes, this is true, but it also makes it a lot harder to figure out if 
two projects are from the same real project, or whether they just shared 
some history.  In general, git repositories are partitioned by URL or 
project, and so this makes a soft case for a distributed system to 
partition itself by URL or project also.

Sam
