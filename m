From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [RFC] Looking at multiple ancestors in merge
Date: Wed, 24 Aug 2005 21:39:17 -0700
Message-ID: <430D4B75.6060102@gmail.com>
References: <Pine.LNX.4.63.0508242249030.23242@iabervon.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 25 06:40:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E89WP-0006fl-JC
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 06:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbVHYEjU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 00:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbVHYEjU
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 00:39:20 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:18894 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964790AbVHYEjT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2005 00:39:19 -0400
Received: by rproxy.gmail.com with SMTP id r35so259534rna
        for <git@vger.kernel.org>; Wed, 24 Aug 2005 21:39:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ai5I/rkrEPtyZyaH0ZO7UOPpdb7lPPa9guC9bUr2AhQlmuo2Mq/Fkq2DqfyKE2pPittxTe9gqrw62u8R4zrEG7HCMpmAjcmXr6PecJYIxCh3QHPenEzhuPrWlZSBovWyaPWJd1YzxdJ5W7A8zfqmYyfKkPEESM67cj5muu1ln5M=
Received: by 10.38.161.36 with SMTP id j36mr809451rne;
        Wed, 24 Aug 2005 21:39:16 -0700 (PDT)
Received: from ?12.145.154.227? ( [12.145.154.227])
        by mx.gmail.com with ESMTP id 58sm1244610rnc.2005.08.24.21.39.16;
        Wed, 24 Aug 2005 21:39:16 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0508242249030.23242@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7743>

Daniel Barkalow wrote:
> I'm starting to work on letting the merging process see multiple
> ancestors, and I think it's messy enough that I should actually discuss
> it.
> 
> Review of the issue:
> 
> It is possible to lost reverts in cases when merging two commits with
> multiple ancestors, in the following pattern: (letters representing blobs
> at some filename, children to the right)
> 
> a-b-b-a-?
>  \ X   /
>   a-b-b
> 
[Lots of stuff deleted]

There seems to be a lot of effort being put into auto-magically choosing
the "right" merge in the presence of multiple possible merge bases.
Unfortunately, most (all?) of the proposals are attempting to divine
intent, and so, are guaranteed to be 100% wrong at least some of the time.

Wouldn't it be better, instead, to detect that current merge being
attempted is ambiguous and require the user to specify the correct merge
base? The alternative is a tool that appears to work all of the time but
does the wrong thing some of the time.
