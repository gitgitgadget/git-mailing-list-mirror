From: Michael G Schwern <schwern@pobox.com>
Subject: Re: Fix git-svn for SVN 1.7
Date: Mon, 30 Jul 2012 18:04:16 -0700
Message-ID: <50172F10.2030402@pobox.com>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <20120730203844.GA23892@dcvr.yhbt.net> <5016F832.7030604@pobox.com>
 <20120730221548.GA388@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, jrnieder@gmail.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jul 31 03:04:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sw0sq-0003cw-Cd
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 03:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433Ab2GaBET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 21:04:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34152 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752176Ab2GaBES (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 21:04:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A38B84AA;
	Mon, 30 Jul 2012 21:04:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=cCAjv6mRofc6
	tqJCQuZ94IYdbHw=; b=r4FgBXXBotYBG4qBom4d3IbBdNuRYphHAOOlhhLbFlkf
	4QBjBTPqY8HDEMxj2xn/9mJlSyTahYX4Y1ef/GBki8iKEDq1ngUxjUGHiolZldKe
	3S+tbF4bntnZEVOtzx8eZW4/cnA+uk06JbmsUQptJSDW4q5t/s4NhUafJAUcwlM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=T+6h6w
	QQZlhRcpeoOOJG1rC8aQfB9+oi/FXyLbY7sd0taDyk5GOacEvBkjvz0ZQe9zZ68S
	PChGaatXTVI6Z8Reh0XlBITZEwQRse0ADc0APouKgM8FzaSfM2qAfAQ4VYcfYMAR
	qUHk0kBFKHkr9W8BeKuDVIkjeNoD3Bpx1FR2U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBBBE84A6;
	Mon, 30 Jul 2012 21:04:17 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C955849C; Mon, 30 Jul
 2012 21:04:16 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120730221548.GA388@dcvr.yhbt.net>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: A71CBFC2-DAAB-11E1-B3F1-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202623>

On 2012.7.30 3:15 PM, Eric Wong wrote:
>> Right now, canonicalization is a bug generator.  Paths and URLs have to be in
>> the same form when they're compared.  This requires meticulous care on the
>> part of the coder and reviewer to check every comparison.  It scatters the
>> logic for proper comparison all over the code.  Redundant logic scattered
>> around the code is a Bad Thing.  It makes it more likely a coder will forget
>> the logic, or get it wrong, and a human reviewer must be far more vigilant.
> 
> <snip>  I agree completely with canonicalization.

Sorry, I'm not sure what you're agreeing with.


>> The only downside is when chasing down a bug related to canonicalization one
>> might have to realize that eq is overloaded.
> 
> Having to realize eq is overloaded is a huge downside to me.

Presumably you'd be reviewing the change which implements the overloaded
objects, so you'd know about it.  And it would be documented.

I've listed a bunch of concrete positives for using comparison overloaded
URI/path objects vs how it's currently being done.  How about you voice some
of the downsides in concrete terms?  Or an alternative that solves the current
problems?


-- 
Ahh email, my old friend.  Do you know that revenge is a dish that is best
served cold?  And it is very cold on the Internet!
