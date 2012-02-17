From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] config-include fixes
Date: Thu, 16 Feb 2012 18:50:40 -0800
Message-ID: <7vty2quq9r.fsf@alter.siamese.dyndns.org>
References: <7v4nuuea7r.fsf@alter.siamese.dyndns.org>
 <20120214214729.GA24711@sigill.intra.peff.net>
 <7vmx8l5aw3.fsf@alter.siamese.dyndns.org>
 <20120214220953.GC24802@sigill.intra.peff.net>
 <20120216080102.GA11793@sigill.intra.peff.net>
 <7v1upuzgfr.fsf@alter.siamese.dyndns.org>
 <20120217001438.GD4756@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 17 03:50:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyDuJ-00055E-Q1
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 03:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198Ab2BQCun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 21:50:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41359 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929Ab2BQCum (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 21:50:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59AA87742;
	Thu, 16 Feb 2012 21:50:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=4mEyvrnaJ3sJHTPzcqYCdRSnUc8=; b=UKLmX7IkNjyZn622RyR7
	HnOFSCHVCKpbhHttvFZuXiNG4zZegEmMaaJCFD/5x2wpYKbhAJMTlJ1df1FT43W9
	0pzVt1FTk14uL6wRKGEoFBTah12LAUONoN9Rwi45bHTSj/l5INBc9sJymLVoNZdt
	YC3eic47HlCb8V7Ecjm8/jY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ZsdLxoBo9EdscAsMiKnHk/mjkj4Eu52+dGr/tXj5b/RRCe
	AcZZ3dwajWeZSBFsgeiFJPvIzlpvZFEosLb8hWIhHO3kz2/EKWYWy21Dcf9tyHD5
	ixoejis3ULqJBSpYc62YaPlbDNR0B2PajLOHjii+tNyXrnk91uEGJSo7SyTEk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 505177740;
	Thu, 16 Feb 2012 21:50:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6D86773F; Thu, 16 Feb 2012
 21:50:41 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E4D0CE8-5912-11E1-B871-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190932>

Jeff King <peff@peff.net> writes:

> On Thu, Feb 16, 2012 at 12:11:52PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > I prepared this on top of what you have queued in jk/config-include.
>> > However, all of the cleanup is semantically independent of the topic
>> > (though there are a few minor textual conflicts). If I were re-rolling,
>> > I would put it all at the front, then squash patch 8 into my prior
>> > "implement config includes" patch.
>> 
>> Sorry for being late in answering the "revert or build on top" question; I
>> was mostly offline yesterday afternoon.
>
> No problem. I did it as build-on-top because it's much easier to squash
> and reorder the commits later than it is to pick a re-roll apart into
> multiple commits.
>
> Which way did you want me to go with it?

I'll push out the re-roll that follows your outline above in 'pu'; I think
I got all the conflict resolved correctly, but please eyeball the result.

>> Looking at the rebased result, it strikes me that with_options version
>> 
>>     Furthermore, by providing a more "advanced" interface, we
>>     now have a a natural place to add new options for callers
>>     like git-config, which care about tweaking the specifics of
>>     config lookup, without disturbing the large number of
>>     "simple" users (i.e., every other part of git).
>> 
>> perhaps wants to get a pointer to struct config_lookup_options, instead of
>> us having to add a new parameter to all callsites every time a new need
>> is discovered.
>
> I considered that, but I noticed that the only callers who are really
> going to care about the _with_options version will be in
> builtin/config.c, and they all care about every option.

Ok.

Thanks.
