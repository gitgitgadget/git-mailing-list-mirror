From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-web--browse: invoke kfmclient directly
Date: Mon, 19 Sep 2011 13:42:23 -0700
Message-ID: <7v62ko9scw.fsf@alter.siamese.dyndns.org>
References: <20110918032933.GA17977@sigill.intra.peff.net>
 <1316341224-4359-1-git-send-email-judge.packham@gmail.com>
 <20110918183846.GA31176@sigill.intra.peff.net>
 <7vvcso9zzi.fsf@alter.siamese.dyndns.org>
 <20110919182049.GA26115@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org,
	chriscool@tuxfamily.org, jepler@unpythonic.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 19 22:42:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5kff-0003Gu-AH
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 22:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756209Ab1ISUm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 16:42:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49414 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754635Ab1ISUm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 16:42:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD1EB58E8;
	Mon, 19 Sep 2011 16:42:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pVTR4KJwbCBDxEWqTrlXwICuehk=; b=hwNJU8
	QybRTeJXuXZRlQl+UPEClQSCQD+zZ7/Pg5OhBby6z2I0IxWadkqBCBdlzWYD23SF
	kfByDRRbvRfQlteqS2BMBID8G3W4NK2EE5YQTvHSse1POyiubn0wszkYrgxPcoWS
	gcRmyYRNREwMIcgx2xWmthLoJinklGCOhNGqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FKzzVBKmHijopzhVFbbk4LSD2F+Nu3kY
	j8M9nwYr6Six7r+Y2zf1YzYyR5Ip2ABibYMUUaWDrcmQEvr4G3UbXl4zawM5dPLT
	uONVrQ8PaiNEYfagQTU+fw9cTVbj678/95la7n089KxPiu4qY6hYZsGbkYhpCT4B
	eo+gQw3gwUc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D410C58E7;
	Mon, 19 Sep 2011 16:42:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62DA158E6; Mon, 19 Sep 2011
 16:42:25 -0400 (EDT)
In-Reply-To: <20110919182049.GA26115@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 19 Sep 2011 14:20:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E1D02BE4-E2FF-11E0-B2C6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181704>

Jeff King <peff@peff.net> writes:

> On Mon, Sep 19, 2011 at 10:57:37AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Hmm. Actually, the one for custom browser commands might need it,
>> > because that one is expected to be a shell snippet. I suspect the
>> > simplest thing is to do something like:
>> >
>> >   eval "$browser_cmd \"\$@\""
>> 
>> Yeah, I agree, and the dq around $browser_cmd is kind of important, too,
>> for that to work and be readable.
>
> Oops, good catch. Probably the most readable version would be:
>
>   eval "\"$browser_cmd\"" '"$@"'

Actually I didn't mean that double dq.

In fact, if browser_cmd is meant to be split as a shell snippet, I do not
think you want the string seen by eval to have dq around the expanded
version of $browser_cmd.  And I tend to prefer feeding a single string to
eval, so the version in your message I quoted originally looks good to me.

Unless I am missing something here...?
