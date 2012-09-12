From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/6] string_list: add two new functions for splitting
 strings
Date: Wed, 12 Sep 2012 10:55:25 -0700
Message-ID: <7vtxv3ceia.fsf@alter.siamese.dyndns.org>
References: <1347311926-5207-1-git-send-email-mhagger@alum.mit.edu>
 <1347311926-5207-3-git-send-email-mhagger@alum.mit.edu>
 <7v8vchld82.fsf@alter.siamese.dyndns.org> <50508A44.1020008@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 12 19:55:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBrA2-00013P-I1
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 19:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760744Ab2ILRza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 13:55:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37223 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754114Ab2ILRz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 13:55:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3358C8E7B;
	Wed, 12 Sep 2012 13:55:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YK8tVASwUFQPMfJkexqX6y/IQr8=; b=aTPXHp
	0qgkOP3I34P752rki3D5l23oQht3YUhMW1HhidVVGJqEueRNvdLrDnyTAGjEVrjU
	ndk5ce5XyV8S2VcYyp+EvOTb0Yj4BGAXZqsMAPd1bl6n/9nBUkOa8IYkkyjuJmK0
	DpcRQ/mm6Z7krFJP2ddNwGx4+7MTWUYIhjsaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ki0ReKr4zGUFSpui4t8/xUHfDednmTRx
	zaJe+6pfkL15QICOWjkhQZx73IsracVbQlfch7A/QeFRbr/VVTms53QU7uqD3xyr
	FaNCU9co4ZWeY6GA97EKBJr2GYveUjf5SRQX6MfxoVbNK7bFIuOONYKcD6vj1xZh
	GAEYahnat3s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21FD88E7A;
	Wed, 12 Sep 2012 13:55:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E2708E79; Wed, 12 Sep 2012
 13:55:28 -0400 (EDT)
In-Reply-To: <50508A44.1020008@alum.mit.edu> (Michael Haggerty's message of
 "Wed, 12 Sep 2012 15:12:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0989E21A-FD03-11E1-9EFD-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205315>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 09/11/2012 12:33 AM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 
>>> +`string_list_split`, `string_list_split_in_place`::
>>> +
>>> +	Split a string into substrings on a delimiter character and
>>> +	append the substrings to a `string_list`.  If `maxsplit` is
>>> +	non-negative, then split at most `maxsplit` times.  Return the
>>> +	number of substrings appended to the list.
>> 
>> 
>> I recall that we favor
>> 
>> `A`::
>> `B`::
>> 
>> 	Description for A and B
>> 
>> for some reason but do not remember exactly why.
>
> Will change.  Thanks.

Thanks.  It comes from this one:

commit bf474e2402e51843e8230c064da6ccfdf3a8ff54
Author: Markus Heidelberg <markus.heidelberg@web.de>
Date:   Fri Jan 16 22:42:33 2009 +0100

    Documentation: let asciidoc align related options
    
    Command line options can share the same paragraph of description, if
    they are related or synonymous. In these cases they should be
    written among each other, so that asciidoc can format them itself.
    
    Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
