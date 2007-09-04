From: Andreas Ericsson <ae@op5.se>
Subject: Re: Calculating tree nodes
Date: Tue, 04 Sep 2007 07:55:45 +0200
Message-ID: <46DCF361.2090402@op5.se>
References: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com>	 <20070904025153.GS18160@spearce.org>	 <9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>	 <e1dab3980709032119r381f7a91ia84ba09039c21be1@mail.gmail.com> <9e4733910709032252x1fe6f436wdd13bcb1a6f76636@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Tweed <david.tweed@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 07:55:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISROD-0003Ey-VV
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 07:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbXIDFzt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 01:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbXIDFzt
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 01:55:49 -0400
Received: from mail.op5.se ([193.201.96.20]:46335 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511AbXIDFzs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 01:55:48 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 81A30194410;
	Tue,  4 Sep 2007 07:55:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dfpj3SAe5mW4; Tue,  4 Sep 2007 07:55:47 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id D3C1A1943AE;
	Tue,  4 Sep 2007 07:55:46 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <9e4733910709032252x1fe6f436wdd13bcb1a6f76636@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57529>

Jon Smirl wrote:
> On 9/4/07, David Tweed <david.tweed@gmail.com> wrote:
>> On 9/4/07, Jon Smirl <jonsmirl@gmail.com> wrote:
>>> Git has picked up the hierarchical storage scheme since it was built
>>> on a hierarchical file system.
>> FWIW my memory is that initial git used path-to-blob lists (as you're
>> describing but without delta-ing) and tree nodes were added after a
>> couple of weeks, the motivation _at the time_ being they were a
>> natural way to dramatically reduce the size of repos.
>>
>> One of the nice things about tree nodes is that for doing a diff
>> between versions you can, to overwhelming probability, decide
>> equality/inequality of two arbitrarily deep and complicated subtrees
>> by comparing 40 characters, regardless of how remote and convoluted
>> their common ancestry. With delta chains don't you end up having to
>> trace back to a common "entry" in the history? (Of course, I don't
>> know how packs affect this - presumably there's some delta chasing to
>> get to the bare objects as well.)
> 
> While it is a 40 character compare, how many disk accesses were needed
> to get those two SHAs into memory?
> 

One more than there would have been to read only the commit, and one more
per level of recursion, assuming you never ever pack your repository.

If you *do* pack it, the tree(s) needed to compare are likely already
inside the sliding packfile window. In that case, there are no extra
disk accesses.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
