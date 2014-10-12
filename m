From: Ben Aveling <bena.001@optusnet.com.au>
Subject: Re: [RFC/PATCH] fsck: do not canonicalize modes in trees we are checking
Date: Mon, 13 Oct 2014 09:37:27 +1100
Message-ID: <543B02A7.9040807@optusnet.com.au>
References: <20140923154751.GA19319@peff.net> <20140923162343.GA20379@debian> <20140923163008.GA21591@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>,
	Edward Thomson <ethomson@edwardthomson.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 01:05:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdSCt-0006D3-UI
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 01:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575AbaJLXFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2014 19:05:40 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:34757 "EHLO
	mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751506AbaJLXFj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Oct 2014 19:05:39 -0400
X-Greylist: delayed 1684 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Oct 2014 19:05:39 EDT
Received: from [192.168.1.100] (pa49-195-44-98.pa.nsw.optusnet.com.au [49.195.44.98])
	(Authenticated sender: bena.001@optusnet.com.au)
	by mail106.syd.optusnet.com.au (Postfix) with ESMTPSA id 1DB8F3C2967;
	Mon, 13 Oct 2014 09:37:31 +1100 (EST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140923163008.GA21591@peff.net>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.1 cv=BdjhjNd2 c=1 sm=1 tr=0
	a=8DvjPrTg2KIHJ2weNsdFBQ==:117 a=8DvjPrTg2KIHJ2weNsdFBQ==:17
	a=PO7r1zJSAAAA:8 a=tcnv99F1KMcA:10 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8
	a=JqXAnbiMQ7oRlYX--_sA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi,

A question about fsck - is there a reason it doesn't have an option to 
delete bad objects?

Regards, Ben

On 24/09/2014 02:30, Jeff King wrote:
> [-cc Kirill, as his address seem out-of-date]
>
> On Tue, Sep 23, 2014 at 04:23:43PM +0000, Edward Thomson wrote:
>
>> On Tue, Sep 23, 2014 at 11:47:51AM -0400, Jeff King wrote:
>>> As far as I can tell, fsck's mode-checking has been totally broken
>>> basically forever. Which makes me a little nervous to fix it. :)
>>> linux.git does have some bogus modes, but they are 100664, which is
>>> specifically ignored here unless "fsck --strict" is in effect.
>> I'm in favor of checking the mode in fsck, at least when --strict.
>> But I would suggest we be lax (by default) about other likely-to-exist
>> but strictly invalid modes to prevent peoples previously workable
>> repositories from being now broken.
>>
>> I have, for example, encountered 100775 in the wild, and would argue that
>> like 100644, it should probably not fail unless we are in --strict mode.
> Yeah, I'd agree with that. The big question is: what breakage have we
> seen in the wild? :)
>
> I think treating 100775 the same as 100664 makes sense (want to do a
> patch?). Do we know of any others? I guess we can collect them as time
> goes on and reports come in. That's not the nicest thing for people with
> such repos, but then again, their repos _are_ broken (and it's only
> really a showstopper if they are trying to push to somebody with
> receive.fsckObjects turned on).
>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
