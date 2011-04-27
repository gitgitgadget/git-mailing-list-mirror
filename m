From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] Refactor --dirstat parsing; deprecate --cumulative
 and --dirstat-by-file
Date: Wed, 27 Apr 2011 14:01:53 -0700
Message-ID: <7v62pz76im.fsf@alter.siamese.dyndns.org>
References: <BANLkTim9U4cOnV+5=Mp-2g_M6+JOiM5e7A@mail.gmail.com>
 <1303776102-9085-4-git-send-email-johan@herland.net>
 <7vy62xezqy.fsf@alter.siamese.dyndns.org>
 <201104270402.10658.johan@herland.net>
 <7vaafb76zb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Apr 27 23:02:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFBsD-0006on-47
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 23:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756794Ab1D0VCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 17:02:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53273 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227Ab1D0VCG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 17:02:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3F971469B;
	Wed, 27 Apr 2011 17:04:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZwutBHhRKQIeZY72ZBpqdZjc9Q4=; b=Xi/PLC
	RjGjjsVu56nWsqcFVfxVWuZwEuCAyvFPe0JxH0nG/xNXnIJ3B5NvzLTNfu/ajkEn
	HAFp7VdrxS0rmHoOYqKtgQvbfqS/gBp0pRZBfTuHryaxbhG7hqJbSkXSqzbIJQuF
	IQD16DAbohFhg4ZLIPq3+I/A/BpwJbaMxVSck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FjK6ZK0oomANWVeAFU5U13XRMyL+iWf8
	q+E1WhXRBsJhmC5BufVEkNVkgHvESMiEEo3BcKJQj82v9O3oRsF3DPfAGHN7PVu5
	7md2z/Cax/F5qiI6KAytxsPh0kmXh7zwOdxiX+W7BI1VSFNYGisavgqYz/Z9hhuW
	HgDfyARw1UY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DA969469A;
	Wed, 27 Apr 2011 17:04:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AFCBA4699; Wed, 27 Apr 2011
 17:03:58 -0400 (EDT)
In-Reply-To: <7vaafb76zb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 27 Apr 2011 13:51:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E1399586-7111-11E0-8251-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172273>

Junio C Hamano <gitster@pobox.com> writes:

> Johan Herland <johan@herland.net> writes:
>
>>> Even better, probably they can be left to diff_opt_parse() without
>>> calling this function, as you are deprecating them and do not have to
>>> allow them to take the opt1,opt2,... form of parameter.
>>
>> I understand, but politely disagree: Patch 6/6 complicates the logic
>> that DIFF_OPT_SET()/CLR() various bits in the diff options. I'd rather
>> keep that logic in one place, than duplicate it into diff_opt_parse().
>
> I've given a brief look at the v3.  Looks better than the previous one;
> not using double is especailly a big and good thing.

Also, I had to rename the new test to t4047 to avoid crashing with an
existing test when merged to 'pu'.
