From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD] Expanded Pretty Format Placeholders Proposal
Date: Fri, 18 Mar 2011 00:18:03 -0700
Message-ID: <7vipvgzyl0.fsf@alter.siamese.dyndns.org>
References: <1299804441.6220.1.camel@walleee>
 <1300395454.2004.9.camel@walleee> <7vvczh1lco.fsf@alter.siamese.dyndns.org>
 <1300399206.2004.22.camel@walleee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 08:18:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0Twx-00057Y-F1
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 08:18:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756291Ab1CRHSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 03:18:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57905 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756229Ab1CRHSN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 03:18:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D855B23DF;
	Fri, 18 Mar 2011 03:19:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3J+ag3s/sDgYy//v//bNcxqzltg=; b=VD1S3h
	/230NffCMWc8TEO0dDyx5ADGFgeHkfaHtsotNn8kudfZSCzwn2DhxWc6xEgtXXn+
	go6OH+Csx6E/DkqXeDDug/2975ISJPwotW93zCRTlVT9R2mskniEMR/V8cJnl+7O
	JX8xloHRPh+gTU1pSu5autSsKTSPodBcnPMD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WBhKtgjrYPoJsgR68lesi3HL5Xh8hz+F
	TqFdSdHbbYCee+Kntopytbxejub/O3fwHTtX2AoYkykJxQLF4pgVPRDnNCnHENK1
	vA9xnzGahLrWZLfJJKpZBATzu/uPI3BuWS+JqpGuY0dxONm01yIIcoHk4i0RrL+M
	Nkp4+CA6sCE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B679923DE;
	Fri, 18 Mar 2011 03:19:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DA36123DD; Fri, 18 Mar 2011
 03:19:38 -0400 (EDT)
In-Reply-To: <1300399206.2004.22.camel@walleee> (Will Palmer's message of
 "Thu, 17 Mar 2011 22:00:06 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 178F4A42-5130-11E0-A8FF-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169293>

Will Palmer <wmpalmer@gmail.com> writes:

>> I somehow had an impression that you will be using "" to quote strings to
>> protect leading or trailing whitespaces, and if you were to support double
>> quotes anyway, \" and \\ become a very natural thing to do (so does your
>> "close parenthesis inside dq").
>
> I do have double-quoted strings implemented, but in trying to break the
> big-ugly-POC patch down into more-manageable changes, I questioned the
> need for it when %x20 or the "magic" space-if-nonempty might do just as
> well for most cases, so I took it out of the initial patch.

True enough; %x20 is probably acceptable and %xXX is what we already have
anyway.  Besides, values in the configuration file needs to use dq when
they have whitespaces in them, and it would make it trickier to read if
the language used in value (i.e. the one you are designing when used as
part of alias) overused dq and bs.

I wasn't objecting to %-quoting.  I just wanted to make sure that the
reason you favored it over dq was sane and well thought out.

Thanks.
