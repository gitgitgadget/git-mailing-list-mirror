From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] merge-recursive: test rename threshold option
Date: Sun, 21 Feb 2016 15:15:26 -0800
Message-ID: <xmqq37slac4x.fsf@gitster.mtv.corp.google.com>
References: <1456067358-19781-1-git-send-email-felipegassis@gmail.com>
	<1456067358-19781-4-git-send-email-felipegassis@gmail.com>
	<CAPig+cTpngfi6EF+MbD-fQ1nM_9TTeVZJ_fBviD5=4Q9uN-8aA@mail.gmail.com>
	<CALMa68qhCBJ5MnT7i6UT989OKKzzOF_bTqo38thSPMwq0mbj6g@mail.gmail.com>
	<CAPig+cQ5h4hjOwO6-xXii6QQP0J8B_bHYUwWniR6HdQN2dB_1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis <felipeg.assis@gmail.com>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis 
	<felipegassis@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 00:15:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXdE4-0006Bz-3P
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 00:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358AbcBUXPa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 18:15:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55381 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752190AbcBUXP3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Feb 2016 18:15:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 867564527B;
	Sun, 21 Feb 2016 18:15:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LQoAHyxhQTcA
	fnOTGME2z5Dizd0=; b=AMB4jFwvAZfDiTPJY6h4TasSJNbW+8EHOMarnR4FY+jQ
	gpKhRh1mKoAhA9VmS6RcBbwiCd6GS2GbJMyGDgv1QdTqHIHUVESK59g3hYyRQRs1
	FOQ0jejnJJf/J4/LDwEIZoSmeMa7g5KckpHxNRd+c0pLY0C20pLe1HJc9jJsyT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XbVm95
	jYt1aMPJOElFEbnxpPBNWa14ssdttzG87KyHyPahBUadVeFWKXdKtK+rYvZZxIh+
	VWJFQg8KRqFYgDenRfA1xR9b2FmGAYC4G1UIOAO4ZjCIF6KJAZcvs2FbsuQ6pTKs
	N1HyYK+Dl1uXs6ilO0BBsvXWMPa6d2oxB2wW8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7E9614527A;
	Sun, 21 Feb 2016 18:15:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F10FE45279;
	Sun, 21 Feb 2016 18:15:27 -0500 (EST)
In-Reply-To: <CAPig+cQ5h4hjOwO6-xXii6QQP0J8B_bHYUwWniR6HdQN2dB_1A@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 21 Feb 2016 15:45:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FE9B6C5C-D8F0-11E5-8A27-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286839>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Feb 21, 2016 at 1:55 PM, Felipe Gon=C3=A7alves Assis
> <felipeg.assis@gmail.com> wrote:
>> On 21 February 2016 at 14:52, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
>>> On Sun, Feb 21, 2016 at 10:09 AM, Felipe Gon=C3=A7alves Assis
>>> <felipeg.assis@gmail.com> wrote:
>>>> +test_expect_success 'rename threshold is truncated' '
>>>> +       git read-tree --reset -u HEAD &&
>>>> +       test_must_fail git merge-recursive --rename-threshold=3D20=
0% HEAD^ -- HEAD master &&
>>>> +       check_find_renames_100
>>>> +'
>>>
>>> Is this truncation documented behavior or is it just a detail of th=
e
>>> current implementation. (Genuine question; I haven't checked the
>>> documentation or source.) If just an implementation detail, then it
>>> might not be desirable to formalize it via a test.
>>
>> Not documented. I will remove this. If you prefer to have it
>> documented and the test added back later, I can do that.
>
> Looking at the code itself and its history, this seems to be a
> deliberate decision, so the test may be appropriate, however, I defer
> to Junio's judgment.

This is just us not caring enough about illogical input by crazy
users who ignore the fact that the rename scores are supposed to be
between 0 and max.

We could have added code to reject out-of-range values when we added
support for input with '%', but we instead just made sure we clip
the result within the range (probably because it was easier).

I personally do not think it would break too many people if we
changed the parser to error out, but at the same time, I do not
think it is worth the code churn to do so, and it probably is not
worth to document the clipping either.


[Footnote]

*1* With the original "give us an integer, and we'll take it as a
ratio of that number out of the next power of ten", there was no
need to worry about out-of-range values.
