From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-status: Show empty directories
Date: Mon, 11 Jun 2012 08:08:48 -0700
Message-ID: <7vtxyh998f.fsf@alter.siamese.dyndns.org>
References: <1339270806-65013-1-git-send-email-muhtasib@gmail.com>
 <20120609221315.Horde.fN5FP3wdC4BP065b3FviijA@webmail.minatec.grenoble-inp.fr> <CAA3EhHJ9WnisF21iFfsjQKYFSY0t0jFvNV3aBjx0eGFPm8aoGg@mail.gmail.com> <877gvgrxw7.fsf@thomas.inf.ethz.ch> <20120609234717.Horde.I9rYUXwdC4BP08RlFRO2w_A@webmail.minatec.grenoble-inp.fr> <87haujr15p.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <konglu@minatec.inpg.fr>, Leila <muhtasib@gmail.com>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jun 11 17:08:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se6Ei-00048s-9z
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 17:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755346Ab2FKPIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 11:08:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38726 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754941Ab2FKPIv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 11:08:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9ED3C8A69;
	Mon, 11 Jun 2012 11:08:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jz46+/alWAytub2HmctIjOZVH5M=; b=uw6B+Z
	wL17T0Num/2pO6NEjAKSka+kgRfJZysindOWsrvW1yao/Zf2N8Gh+OiMwkkH+qz3
	2lvfWLurEAWHhayHP862l4pgp/dPB8am0cAXGKkqnvyAS0esDvfFSMIgizk/qFVL
	/WLTGzo7G2kJqAsEYr7O9n+gjYrRqr1a+TadM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E2rGc2hZMPH4y3ZfBIitAzlxyBVG/X8r
	jBR1r/of/5ghTQFsDl+QJydkif9gBscKCeQ85NdW5JkkzETLDCcA7fdZlH3/wZI7
	BndkfN5oKfruzNezVAv9YJwr+iOGIcdp45N1FeqLW3Oxck5Bk/Ywah/HAXfhgzsd
	L5OA7uinqiY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95C498A68;
	Mon, 11 Jun 2012 11:08:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C3E38A67; Mon, 11 Jun 2012
 11:08:50 -0400 (EDT)
In-Reply-To: <87haujr15p.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Sun, 10 Jun 2012 11:01:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59B0CB0C-B3D7-11E1-850F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199658>

Thomas Rast <trast@student.ethz.ch> writes:

>>> It's not required, there's plenty of precedent, even one case within
>>> wt-status.c, of '} else'.  Try running
>>>
>>>   git grep '} else$'
>>
>> It's not because "there's plenty of precedent" that we should not try
>> to improve the format of the code. That's why there're coding style
>> rules so that we can keep the improvements consistent.
>
> Yeah, and the rules (Documentation/CodingGuidelines) say
>
>  - We avoid using braces unnecessarily.  I.e.
>
> 	if (bla) {
> 		x = 1;
> 	}
>
>    is frowned upon.  A gray area is when the statement extends
>    over a few lines, and/or you have a lengthy comment atop of
>    it.  Also, like in the Linux kernel, if there is a long list
>    of "else if" statements, it can make sense to add braces to
>    single line blocks.
>
> I'm not the one who wrote them, but I'm taking the last sentence to mean
> that you should not put the braces unless the omission will break the
> vertical alignment of the 'else if' chain.

The guidelines are not black-and-white, but the spirit is to suggest
avoiding unnecessary braces around single statement blocks while
allowing exception when consistency across if/else if/... cascade
makes the result easier to read.

> BTW, there are plenty of cases in git where it is better to stick to the
> existing style of the file instead of the CodingGuidelines, unless you
> are willing to clean up the file first (and nobody else works on it).

Yes.
