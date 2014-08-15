From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Understanding behavior of git blame -M
Date: Fri, 15 Aug 2014 10:07:34 -0700
Message-ID: <xmqq7g291y21.fsf@gitster.dls.corp.google.com>
References: <71BF70CE41AEE741896AF3A5450D86F11F28C762@DEFTHW99EH3MSX.ww902.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Sokolov\, Konstantin \(ext\)" <konstantin.sokolov.ext@siemens.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 19:07:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIKyj-00033V-Iz
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 19:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbaHORHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2014 13:07:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57004 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132AbaHORHo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 13:07:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9B3C630101;
	Fri, 15 Aug 2014 13:07:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YshC4/rwB730KMYWPG+UsuXP1Lg=; b=mOQnMC
	rvEjtPqM0RZXMr3hlCcrF9eq304WXJ9gfD9PNnRiOL3mqvyAPnpkMdJTM6xtswG9
	Wur59waXGDDRCEnx9jVq4uJbeINuCQiVWDzG2YPdcwQWjxKvM9iWLeI/HwWK2S2t
	TCxyjoypIK3J00A8BW56eQvkVEEmUM7rWo6LQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YM6PPks7DtGi2UbwL77d/LXGsgyUV32q
	FLMiJQXnjLF8G8N76v3EpvyJt1XVxB5oomuH2o0JkwLmca3BMho6bc7Z2xb7LXWU
	l+2DS01vQwV93NoXRM40fUTsHlGHCT3GVSvwhbLzwZEUbHs4lShgLEWv/49pHIXo
	sKUZXnE25fo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8B12130100;
	Fri, 15 Aug 2014 13:07:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 56487300F4;
	Fri, 15 Aug 2014 13:07:36 -0400 (EDT)
In-Reply-To: <71BF70CE41AEE741896AF3A5450D86F11F28C762@DEFTHW99EH3MSX.ww902.siemens.net>
	(Konstantin Sokolov's message of "Fri, 15 Aug 2014 13:40:09 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A79FA894-249E-11E4-9834-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255295>

"Sokolov, Konstantin (ext)" <konstantin.sokolov.ext@siemens.com>
writes:

>>git blame -s -n -f -w -M20 file.txt
> ^2cd9f7f 1 1) AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
> ^2cd9f7f 3 2) CCCCCCCCCCCCCCCCCCCCCCCC2222222222222222222222222
> ^2cd9f7f 4 3) DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
> d4bbd97e 4 4) BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
> ^2cd9f7f 5 5) EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
> ^2cd9f7f 6 6) GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
> ^2cd9f7f 7 7) FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
>
> I wonder, why line B is not recognized as moved. According to the
> documentation, I would expect git blame to report that it
> originates from line 2 in revision 2cd9f7f. Can anybody explain
> the behavior?

Interesting.  Would it make a difference if you move B further away
from lines A and C?
