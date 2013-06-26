From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] remote: Add warnings about mixin --mirror and other remotes
Date: Wed, 26 Jun 2013 16:42:36 -0700
Message-ID: <7vhagkv3pv.fsf@alter.siamese.dyndns.org>
References: <1371809051-29988-1-git-send-email-dennis@kaarsemaker.net>
	<1371809051-29988-2-git-send-email-dennis@kaarsemaker.net>
	<7v8v23mhjy.fsf@alter.siamese.dyndns.org>
	<1371994516.24315.8.camel@localhost>
	<7vvc54ed53.fsf@alter.siamese.dyndns.org>
	<1372023811.24315.15.camel@localhost>
	<7vmwqge9u9.fsf@alter.siamese.dyndns.org>
	<1372281006.3602.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Thu Jun 27 01:42:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrzMK-0002rS-HB
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 01:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab3FZXmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 19:42:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44437 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753313Ab3FZXmj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 19:42:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E793E2C7EB;
	Wed, 26 Jun 2013 23:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FogH9gyxOi5zP1vmhzKAWw3wSwU=; b=x7c6g3
	DyXckU5R4OHh9DeciF2W6COnhIpH1MNKCYgwK4L0U/u3lAjopTYDA4Tr/LdsTvKC
	zav4YZXw5H7QBEoEQiBSvCAREdmHco/jnoy1Mv0FHlPpw6es6osJnKXvG8ycXVwG
	WGJiBGYETJAUbl5YIq/4WgBlgf8ThwBnZy0i4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u8XS+P0iRbCVXNI8HAqElBbt3tI2Hznm
	elV+BHBWtmBn1Zg22NAsxCXoi9JUZ7LkdDgdqMuFmb8hMVRtjuRKNk1hjEH54NQ8
	MsTGpbCSCZ1V6RYoFlqLiFpOqypUqOjY5FhZo7nz3Ql6XGvzWN9GX60TOGhw2uS8
	W0REEddntgc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDE3A2C7EA;
	Wed, 26 Jun 2013 23:42:38 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 517542C7E9;
	Wed, 26 Jun 2013 23:42:38 +0000 (UTC)
In-Reply-To: <1372281006.3602.2.camel@localhost> (Dennis Kaarsemaker's message
	of "Wed, 26 Jun 2013 23:10:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 15AC0160-DEBA-11E2-9135-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229072>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> Apart from the exactly matching refspecs, does git in any other way
> treat this as a special case?

Sorry, I do not quite understand, especially the "exactly matching"
part, which as far as I know is not special (in other words, I am
not sure what kind of "special casing" you are discussing).

>> In any case, I've been assuming in this discussion "allow" is to
>> silently accept, and overlaps are "warned" but not "rejected".  So
>> if you meant by 'outlaw' to die and refuse to run, that is not what
>> I meant.
>
> Well, 1/3 is a warning on add, 3/3 is a warning and refusing to prune.

By "refusing to prune" do you mean "error out with die()"?

I was trying to make sure your "outlaw" was not something else
(e.g. "die without not pruning anything that are not even
overlapping"), which is probably too strong.

I think what your patch did was "keep them around not pruned because
we do not know where they came from" (I just checked $gmane/228589
again); that is in line with "warned but not rejected", so I think
we are OK.
