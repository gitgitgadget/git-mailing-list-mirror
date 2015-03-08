From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git: treat "-C <treat>" as a no-op when <path> is empty
Date: Sat, 07 Mar 2015 23:14:54 -0800
Message-ID: <xmqqvbict0y9.fsf@gitster.dls.corp.google.com>
References: <1425640688-26513-1-git-send-email-karthik.188@gmail.com>
	<CAPig+cTkC1Y1sWJLpG0iUHju3GOMnvOT-nsAU51GykeV2QB+vA@mail.gmail.com>
	<54FAD7D7.4030008@gmail.com>
	<CAPig+cRDkoH-zmYhk9ag+Yiwg1h452hOpS2fx2H5xmu5KUNqiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: karthik nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 08:15:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUVQc-0005Cn-Ge
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 08:15:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbbCHHPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 03:15:04 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60113 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750904AbbCHHPD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 03:15:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 63F80370E9;
	Sun,  8 Mar 2015 03:14:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bk/BqZB5rn1ELN02V7PRD5IG+nA=; b=WyF+vw
	rqSVgiqVkYUNPp6o1rBF7RqzQaQjV6NICzHNw3cz2Z8xuaAnohSc/lWMwSq0Wf+6
	MVZrcJmfZrEeu9teiNsiZfHqhlWdq36FJIaX4+mPwjQ8QO8a2dR6gJtqwBTKZoBb
	2XId8xr+eofG6+cTmFnlb5jPSAGrFDjVMS9WY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nyfpe7LPq0uUznMg1U12KIdPSSXeSmL3
	FXAPT6sjWxgQ8htlQw594x7ChraA7Tx45v1GVIhCHZ7I7yO8PhiMXLqwFmVxecap
	odZdDObcyD+Jrx5Hi9cnZrqKgf5fCnHjfuB6KKnXJetoXz5dkE9ImwjScZ5S0XUD
	rm9IRjGf3fE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C0A1370E7;
	Sun,  8 Mar 2015 03:14:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C606C370E5;
	Sun,  8 Mar 2015 03:14:55 -0400 (EDT)
In-Reply-To: <CAPig+cRDkoH-zmYhk9ag+Yiwg1h452hOpS2fx2H5xmu5KUNqiQ@mail.gmail.com>
	(Eric Sunshine's message of "Sat, 7 Mar 2015 23:38:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D292F1C2-C562-11E4-8891-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265034>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sat, Mar 7, 2015 at 5:49 AM, karthik nayak <karthik.188@gmail.com> wrote:
>
>> Also "*(*argv)[1]" seems more readable to me, maybe more of a perspective?
>
> I also had considered suggesting (*argv)[1][0] as more readable, but
> it is primarily personal taste, and I didn't want to bike-shed the
> issue.

I didn't mention that in earlier review rounds for the same reason,
but I saw Andreas Schwab also independently made the same comment,
so that makes three of us.

That does not change the fact that this is merely a matter of
preference; I wouldn't even call this one a "taste" (use of which
implies that there are judgement involved, as in "good taste" and
"bad taste").

But because it is "preference", the only time we can discuss is when
a new code is submitted and is under review.  Once it is in the
tree, it is not really worth extra patch noise to go and change.

As everybody knows, POINTER[0] and *POINTER are equivalent.  We have
quite a few places where we say "let's treat passing an empty string
the same as not passing an argument at all" with

	if (!POINTER || !*POINTER)
        	; /* no-op */
	else {
        	/* do something with POINTER */
                fn(POINTER);
	}

and we could say !POINTER[0] instead of !*POINTER, interchangeably.

We tend to prefer (again, I do not think this is particularly a
"taste" thing) *POINTER over POINTER[0] when POINTER is just a
single variable in the above pattern we often see in our code.

But when POINTER is an expression like (*argv)[1], where you unwrap
the operators according to their precedences, it often is easier to
read if you do not have to flip your eyes left and right too often.

You first look at "argv", then notice the prefix "*" (you have to
move your eyes to the left here) and know argv points at a location
that holds a pointer.  Then you notice the suffix [1] (now to the
right) and know that pointer points at an array and the expression
is talking about in its second element.

Now, you want to say that second element is actually a pointer to a
string and want to talk about the beginning of that string.  If you
express it as "*(*argv)[1]", it forces the reader to go back to the
left end once more.  If you write it as "(*argv)[1][0]", the reader
can keep going to the right, starting from the last thing the reader
read and understood (which is the "[1]" at the right end).

At least, that is how I analyze _my_ preference---the latter feels
easier on my eyes.

But as I said this is a mere preference thing.
