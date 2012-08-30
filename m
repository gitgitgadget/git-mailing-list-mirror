From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/3] Improve branch UI for setting upstream information
Date: Thu, 30 Aug 2012 13:12:48 -0700
Message-ID: <7vipc0qgu7.fsf@alter.siamese.dyndns.org>
References: <1346347393-8425-1-git-send-email-cmn@elego.de>
 <7v1uios2ma.fsf@alter.siamese.dyndns.org> <87fw745hsb.fsf@centaur.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: carlos@cmartin.tk (Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto)
X-From: git-owner@vger.kernel.org Thu Aug 30 22:13:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7B6o-0003N0-Ab
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 22:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842Ab2H3UMw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Aug 2012 16:12:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50263 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751121Ab2H3UMv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Aug 2012 16:12:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE84D94EF;
	Thu, 30 Aug 2012 16:12:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Mhnet052whPx
	uY1QxiRHraz07aM=; b=tK+gSrzfC9ofV9COJN9PZ7SukdawSwTAJa7YF9xMGX2S
	eh2Cf1p8CGvBjVNg+gxfraHDG7WlcjvR4FkvW7hiw11vvfstyt72lnqxIX63a17B
	5unRMjT+DuZ6z+cFyceRWjqxGS1hVAWy9mu/cU2mlc42X8bY3ZCtOFJYnHj51t0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Ij32Rg
	zHVZeWezU84/RCIJhm8ZH0amg4tA+5o0UPCfcveJvzhSwRD/E0/rESJ0zNf7+Q8t
	gm8QuuGl8/7uAc9PGASCbfiskR5DqWoh0pP7vtFvrPfHITKLNZ7LA0vDNkDdloRN
	iNO9w6bIy+J3PxSX4sRCnhE7UP/tlDV07BPCA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC8A294EE;
	Thu, 30 Aug 2012 16:12:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19E6C94EC; Thu, 30 Aug 2012
 16:12:50 -0400 (EDT)
In-Reply-To: <87fw745hsb.fsf@centaur.cmartin.tk> ("Carlos =?utf-8?Q?Mart?=
 =?utf-8?Q?=C3=ADn?= Nieto"'s message of "Thu, 30 Aug 2012 20:57:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1293ECD0-F2DF-11E1-916D-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204564>

carlos@cmartin.tk (Carlos Mart=C3=ADn Nieto) writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>>
>>> As a result of making --unset-upstream fail if the given branch
>>> doesn't exist, I discovered a copy-paste error in on the the tests =
in
>>> the patch after it, so I'm resending the whole thing.
>>>
>>> The changes from the last reroll are the tightening of the situatio=
ns
>>> where git will show an error message (not it's just if the branch i=
s
>>> new and exists as remote-tracking) which I already sent as a reply =
in
>>> the other thread; and making --unset-upstream error out on bad inpu=
t,
>>> which I already mentioned above.
>>
>> Thanks.
>>
>> In addition to "--unset-upstream must fail on i-dont-exist branch"
>> in [2/3], I am wondering if we would want to also make sure the
>> command fails when the upstream information is not set for the
>> branch, i.e. something like the following on top.
>>
>> What do you think?
>>
>>  t/t3200-branch.sh | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git i/t/t3200-branch.sh w/t/t3200-branch.sh
>> index 1018e8b..a0aaedd 100755
>> --- i/t/t3200-branch.sh
>> +++ w/t/t3200-branch.sh
>> @@ -393,7 +393,9 @@ test_expect_success 'test --unset-upstream on HE=
AD' \
>>       git branch --set-upstream-to my14 &&
>>       git branch --unset-upstream &&
>>       test_must_fail git config branch.master.remote &&
>> -     test_must_fail git config branch.master.merge'
>> +     test_must_fail git config branch.master.merge &&
>> +     test_must_fail git branch --unset-upstream
>> +'
>
> Yeah, this looks good, makes sure that it will still behave correctly
> even if the code path for these two situations diverges.

Alright; will squash.

Thanks.
