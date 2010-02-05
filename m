From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-grep: option parsing conflicts with prefix-dash searches
Date: Fri, 05 Feb 2010 15:34:51 -0800
Message-ID: <7v7hqrs1d0.fsf@alter.siamese.dyndns.org>
References: <alpine.LSU.2.01.1002052351060.30204@obet.zrqbmnf.qr>
 <alpine.LSU.2.01.1002060009430.30204@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Sat Feb 06 00:35:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdXhY-0005P6-Uk
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 00:35:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933487Ab0BEXe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 18:34:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37115 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933355Ab0BEXe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 18:34:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E9BA097994;
	Fri,  5 Feb 2010 18:34:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ec/MTj+sxZ5Hlhix7+Zf5DnFrrk=; b=ZQs+il
	RaQps/KlerBxVpApBY+UeAx95wBgymHf+K3oxoggvUG84aDjXH/wj/nmx2r/PpoM
	hny/eZ6X2/jxDQYyxqOwTMo8b7azm3uu/nxEt8Rvyo/FiKj3T+1Vgb7zC8rGQFF4
	694vh6cTCAGraZiG5cXOr+9Bg1KVQWsxtxDcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wZeqJRjoGiLGBmqLQF0KIbiwvA8mI0IP
	USb1o7NSxYd8ITJfkDU8Bz5bIzdpx6HQD38duVUjJ/Ixo6cN2LHN2kvqv/Z+gfDo
	X3slPvD+nEfQWz8j8FQwgtuF4XTUKqLendQ3+yLs+2MrqosVwlgg74oVZXDAnVcz
	dUIQZlbylyE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C881497992;
	Fri,  5 Feb 2010 18:34:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 386BE9798A; Fri,  5 Feb
 2010 18:34:53 -0500 (EST)
In-Reply-To: <alpine.LSU.2.01.1002060009430.30204@obet.zrqbmnf.qr> (Jan
 Engelhardt's message of "Sat\, 6 Feb 2010 00\:17\:49 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 10FBE7E6-12AF-11DF-985F-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139122>

Jan Engelhardt <jengelh@medozas.de> writes:

> On Saturday 2010-02-06 00:09, Jan Engelhardt wrote:
>
>>What works is (3).
>>
>>(3)	$ git grep -- -- '->cnt' net/ipv4/netfilter/
>
> No, I spoke too soon. This command will search for --, not ->cnt.
> So git cannot search for patterns starting with a dash at all,
> as I see it. This is getting fun..
>
>>As I said, it's a mess. And I know not whether any code can convince
>>the "but we need to watch compatibility"-sayers, because this would
>>definitely be a flag change.

I guess our mails crossed.  You don't have to worry about "flag change",
as I don't think there is any change necessary.

You just need to learn:

 (1) "-e" can come before a string to tell git: "this might look like
     an option to you but it isn't; it is what I am looking for"; and

 (2) Everything that follows "--" are pathspecs, not revs nor options.

And all is well.
