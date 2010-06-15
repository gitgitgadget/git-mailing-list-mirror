From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] common_prefix: be more careful about pathspec bounds
Date: Tue, 15 Jun 2010 15:12:29 -0700
Message-ID: <7vaaqwgd2q.fsf@alter.siamese.dyndns.org>
References: <825550ec93610c2d3c7dae7550729d96fc6cebbc.1276194169.git.trast@student.ethz.ch> <7v8w6g8hfx.fsf@alter.siamese.dyndns.org> <7v4oh48elm.fsf@alter.siamese.dyndns.org> <201006152004.01507.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jun 16 00:12:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOeNC-0005oR-HP
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 00:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791Ab0FOWMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 18:12:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39443 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470Ab0FOWMk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 18:12:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BB1E6BCEAC;
	Tue, 15 Jun 2010 18:12:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C+hY1pijZj00vmU9QySOBDIWFAE=; b=eKBlKN
	IxkC40IpD2u8DC/t2Y5rHLQl3PQw6g40Rs4SxoNI69Wvx9dosq/bLhRZfzVZ8Kcz
	jEDmI0BGWzlWVLdehR0+YKffa90UgINO38KPiHMW/ZGIJr3uGHgoJwjuVT90MpBc
	iODtvpeOKeqUfgdR3QldYi6kCMyFv8y1xgwkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=akJGk5q45Gx+x5PH4alWg464mGYMK9PG
	pitcYuaaP8PudceYiEUmHM+nJeILy+2ENjInwAgPST4R7cMl/tuSU1jBZJ5Orixv
	+hHwbADO0qnweTCh7Dp7wi1BlG2Byw2BiYav0CpcMZDuY8LiN3l/GsqDPYrccxk7
	C/nETm7xlak=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 85DB7BCEA6;
	Tue, 15 Jun 2010 18:12:35 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACE1EBCEA5; Tue, 15 Jun
 2010 18:12:31 -0400 (EDT)
In-Reply-To: <201006152004.01507.trast@student.ethz.ch> (Thomas Rast's
 message of "Tue\, 15 Jun 2010 20\:04\:01 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1A0D244E-78CB-11DF-BC2B-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149230>

Thomas Rast <trast@student.ethz.ch> writes:
> I really didn't like the two-interleaved-loops version in your last
> mail, but this one is way more readable than even the original.
>
> (Why did you wrap the for loop? It's only 76 chars.)

Because I was writing it in my MUA ;-)

>
> Maybe you could add a comment like
>
>> 	slash = strrchr(path, '/');
>> 	if (!slash)
>> 		return 0;
> 	/* The first 'prefix' characters of 'path' always include the
> 	   trailing slash of the prefix directory */
>> 	prefix = slash - path + 1;
>
> to clean up any doubts about the correctness of the matching.

Perhaps..
