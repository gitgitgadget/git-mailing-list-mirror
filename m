From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] rev-list --min-parents,--max-parents: doc and test
 and completion
Date: Mon, 21 Mar 2011 07:54:09 -0700
Message-ID: <7vbp14ttgu.fsf@alter.siamese.dyndns.org>
References: <cover.1300459016.git.git@drmicha.warpmail.net>
 <182c5ece22835559a9762e242adb701547cf6575.1300459017.git.git@drmicha.warpmail.net> <20110318194802.GB27825@sigill.intra.peff.net> <4D871401.6020900@drmicha.warpmail.net> <20110321105431.GB16334@sigill.intra.peff.net> <4D873F56.1060803@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 15:54:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1gV0-0001Lm-8u
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 15:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498Ab1CUOyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 10:54:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42901 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464Ab1CUOyV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 10:54:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B428448C1;
	Mon, 21 Mar 2011 10:55:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g6fI8q1Dkbi6RsMXmiCgVmGXS0g=; b=lE/t4F
	mGUbTptWqFDKf4SGP1qYpsSmrlPqFtIPU0qBaQQYgY1oSKZ0dotoERpjN/dT4Igh
	NWApmYRB1t5UF0XEnqhT5ED/MmJFrPhqg+rHbSzhk/VFEZG27tGcz2lJ6cP8JMKx
	yq+Fz/J0vok6PKHSu6R6ItbDOyekmehiI01J8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mKwjuXUyIOWXTl4vGM3drh/Y5kBgRU6L
	Qdg7B8O8uXGPoF64k50NfbQ79LcUD4ePc2Ib1yLhy/YrBpd0jTkub9oxI6SRD7Jy
	36SYhVEGOs3RnfYQX/DNCdltiUL6Gcfe9FX/9FNDDpcXLKUuTQV9O/xT748bqhvy
	GuWqxSxzt0Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7FE4948BF;
	Mon, 21 Mar 2011 10:55:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3C9EA48BD; Mon, 21 Mar 2011
 10:55:48 -0400 (EDT)
In-Reply-To: <4D873F56.1060803@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon, 21 Mar 2011 13:06:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51A619AC-53CB-11E0-83D1-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169598>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Jeff King venit, vidit, dixit 21.03.2011 11:54:
>> On Mon, Mar 21, 2011 at 10:01:53AM +0100, Michael J Gruber wrote:
>> 
> In my community it is very common, which may partly be due to the fact
> that there is a strong proportion of non-native speakers. It took it for
> granted that it's a standard expression.

Perhaps in math circles or something?

>> I really think "Show only commits which have at least (or at most,
>> respectively) that many commits" says the same thing, but is way more
>> accessible.
>
> Sounds good, I'm happy with that. Resend or squash on apply?

The "... A resp. B" composition did made me go "huh?", even though I
managed to guess what you meant; I agree Jeff's rewrite is much more
approacheable.

The code part of the patch needs a bit of touch-up anyway, so let's do a
v2.

It is not like you will have a million copies of "struct rev_info", while
you will be reading from and comparing with the field for each commit
during the traversal, so I'd rather see these max/min stored in the usual
"int", not squashed into bitfields.  Also initialize max to the magic
token that means "unlimited" in init_revisions() without swapping the
meaning of comparison.  One initialization assignment you can omit there
is not worth the resulting confusion.

>>>> That way it is obvious that "--merges" cancels a previous --min-parents
>>>> on the command line (maybe the text should be "this is an alias for..."
>>>> to make it clear that doing it is exactly the same).
>>>
>>> Yes, that is helpful. I have doubts about "alias" for. Without wanting
>>> to sound elitist or something, I have the impression that we start
>>> catering for users who understand "equivalent" more reliably than "alias".
>> 
>> I just wanted to make sure people didn't think "equivalent" meant "has a
>> similar effect to" as opposed to "is exactly as if you did". But reading
>> it again, I think "equivalent" is fine, and I see you picked it up in
>> the latest series.
>
> I may be wrong about what is common in this case, too. For me, "alias"
> is foremost a technical term, and I would guess that many non-native
> speaker know "alias" either in the technical sense or not at all, but
> not so much in the common English sense. But either way is fine.

We would want to make sure the reader understands that saying --no-merges
is _exactly the same_ (your words above) as saying --max-parents=1, so why
not spell that out, i.e. "This is exactly the same as `--max-parents=1`"?

Thanks.
