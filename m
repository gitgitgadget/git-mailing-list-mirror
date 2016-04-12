From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 2/6] test-parse-options: print quiet as integer
Date: Tue, 12 Apr 2016 16:11:45 -0700
Message-ID: <xmqqd1puo21a.fsf@gitster.mtv.corp.google.com>
References: <01020153faf9fc14-e6ad18fa-c892-4601-bab7-e2cc4cd9e100-000000@eu-west-1.amazonses.com>
	<01020153faf9fcbb-adadd774-db3a-43ce-b908-d08ac1312b31-000000@eu-west-1.amazonses.com>
	<xmqq60vmpl5c.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPPSY+k9qc8hZ685o9_U3UktbgK-e00zrG2+7GehG-47dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 01:11:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq7TN-0006PB-78
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 01:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030402AbcDLXLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 19:11:49 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54210 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932523AbcDLXLs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 19:11:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5E96E55D49;
	Tue, 12 Apr 2016 19:11:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qzEN3w7HO0rMSqhYJ+ztmFfPYUw=; b=g3iHNl
	jnK1GjkGkBUA2rWkeTGS5vTJkx5izPa1aUOAI8jRmhT8rGcnjQIx8RLf0KlPL3jT
	VomMphuGtcSMMhL2FxOnpY0MFmxm7GdTDD/ooeQa2FmsjhoCzMUTNc0X3v+/w4ia
	Iv3F76BUDWMjGq4l4wkXT6qSRZX6PbBUBlHpg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T5h/Y2xOroLl85ll1lYQ2kxAe/OuAFux
	IqQT/BRYb2yrHn4RrTFA45IW7n96iBysjgXws5LusdX99WhM16XTsBMKcmp+zCqk
	F92FxkPblm+9uBhjA1xWq2Bjmt4Bw4lJPrfqyF9iUggYBwi4A92VCO53bAWzZcew
	boHAc6ZyIQw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 54C3A55D47;
	Tue, 12 Apr 2016 19:11:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CFF5B55D46;
	Tue, 12 Apr 2016 19:11:46 -0400 (EDT)
In-Reply-To: <CAFZEwPPSY+k9qc8hZ685o9_U3UktbgK-e00zrG2+7GehG-47dQ@mail.gmail.com>
	(Pranit Bauva's message of "Wed, 13 Apr 2016 03:46:28 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EDDDD2AC-0103-11E6-AE2B-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291319>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> On Wed, Apr 13, 2016 at 3:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Pranit Bauva <pranit.bauva@gmail.com> writes:
>>
>>> Current implementation of parse-options.c treats OPT__QUIET() as integer
>>> and not boolean and thus it is more appropriate to print it as integer
>>> to avoid confusion.
>>
>> There is no "confusion" factor involved, as we do not use native
>> "boolean" type in our C code.  IIUC, the reason why we want to do
>> this is because we may want to see how it would affect the value of
>> the underlying variable to give multiple --quiet options from the
>> command line, which is a policy issue (i.e. we want to allow
>> commands to react to multiple quiet options differently), not an
>> implementation one (i.e. "current implementation happens to use
>> integer").
>>
>>         We would want to see how multiple --quiet options affect the
>>         value of the underlying variable (we may want "--quiet --quiet"
>>         to still be 1, or we may want to see the value incremented
>>         to 2).  Show the value as integer to allow us to inspect it.
>>
>> perhaps?
>
> This commit message does look a lot better. I will re-roll this.

You need to pick which one you want inside the (parentheses),
though.  After reading 3/6 I am guessing that that you wanted the
latter.

> Should I just send an update of this patch or the whole series?

The latter, for a series this small.

Thanks.
