From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] CodingGuidelines: describe naming rules for configuration variables
Date: Sun, 01 Feb 2015 14:34:38 -0800
Message-ID: <xmqqwq418dmp.fsf@gitster.dls.corp.google.com>
References: <xmqqiofskmfd.fsf@gitster.dls.corp.google.com>
	<1422484393-4414-1-git-send-email-gitster@pobox.com>
	<1422484393-4414-4-git-send-email-gitster@pobox.com>
	<54CDB5C6.3020702@alum.mit.edu>
	<xmqq1tm99yhx.fsf@gitster.dls.corp.google.com>
	<20150201215729.GA19692@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 01 23:34:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YI36T-0003Tv-Gd
	for gcvg-git-2@plane.gmane.org; Sun, 01 Feb 2015 23:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbbBAWem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2015 17:34:42 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752284AbbBAWel (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2015 17:34:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 838C0333B7;
	Sun,  1 Feb 2015 17:34:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9XMVX1lv3JeveGfVHvD2HrSLErc=; b=k5zSje
	1/rsN1mF5Ai1hvZIu8rEYWW+nuRG5dyyF5W6LCvjncc3Ujhv8xUrOW1Une+HOVAs
	1/NeLnurkyR0U/c321VxjbjfNph1ERQtyE3PfILuATdk/2CK98ASkPPVoBQtC5zj
	pWNiplaJssrmwwlTjYIluhQuaSDmZB4vtTxbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hpVVeKoLpIvK7pQQ2hs0II/E0ELWgz/4
	4ymGK3zxChMqpd0RVbkofCJutWpkOW2X4z4+/VG5oJ0037wt+E7mOBqsVvYHABqZ
	Uh2VMFrSl4W/W4D7jscBEG40S5zDnZgyuFfP0zC/wi6lAtrzs0WmOEz9o2t1OYqb
	ggZHRfz9kRc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 79B03333B5;
	Sun,  1 Feb 2015 17:34:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E1A1E333B4;
	Sun,  1 Feb 2015 17:34:39 -0500 (EST)
In-Reply-To: <20150201215729.GA19692@peff.net> (Jeff King's message of "Sun, 1
	Feb 2015 16:57:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 82689186-AA62-11E4-AC83-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263242>

Jeff King <peff@peff.net> writes:

> From the user's perspective, I don't see how the implied relationships
> are significantly different. In type 1, they are placed inside a single
> value and in type 2, they are not. Both are a form of grouping.
>
> Moreover, I am not even sure that the syntax is an important element in
> communicating semantic relationships.

I think we are in agreement and I do not see how you can draw
different conclusions.  The above argument refutes the point Michael
made a big deal out of, which was that "these are individual and
independent bools in the implementation detail of the code, expose
that as such to the end users."  I do not buy that point, i.e. it is
not a good argument to favor style 2 over style 1, which was the
primary thing I wanted to illustrate in the message you are
responding to.

>   1. I'm a user who has set my preferred core.whitespace in my
>      ~/.gitconfig. A particular project I am working on uses an
>      alternate tabwidth. How do I set that in the repo config without
>      repeating my defaults?

Isn't it cumulative?  At least it should be (but I wouldn't be too
surprised if the recent config reader caching broke it).

>   2. I'm writing a hook whose behavior depends on the whitespace
>      settings. How do I ask git whether blank-at-eol is enabled?

If that becomes an issue, "git config" would have to learn about
them, just like it knows about how to do --color depending on the
tty-ness of the output.

>   3. I'm a user who wants to set whitespace config. I prefer using "git
>      config" to editing the file manually. How do I turn off
>      blank-at-eol without disrupting my existing settings?

See above 1.

>> I see Peff cites "pager.<cmd>", but I think it was something that we
>> would rather shouldn't have done, similar to "alias.<cmd>".  They
>> are bad precedents we shouldn't encourage new things to mimic.
>> 
>> But that is not from "one-variable-with-list-is-better" (it is not
>> better for these "independent" ones) but is purely from the syntax
>> point of view.
>
> Yeah, I'd agree that the problem there is orthogonal to the type 1/2
> thing above. I don't think it has been a big deal in practice, just
> because people with good taste do not name their commands with uppercase
> anyway.
>
> I'd be happy to transition to pager.*.enabled, etc, if we care.

I have no strong opinion.  It was primarily meant to illustrate why
pager.<cmd> and alias.<cmd> were bad precedents that should not be
used to support design of future things.
