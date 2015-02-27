From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature request: excluding files/paths from "git grep"
Date: Fri, 27 Feb 2015 11:17:50 -0800
Message-ID: <xmqq4mq7jh9d.fsf@gitster.dls.corp.google.com>
References: <54EDBEC2.8090107@peralex.com>
	<CACsJy8AM=W4f6u_7YpvmfiBwrJjqfJMJoq6CQYfKOh+qD6rF3Q@mail.gmail.com>
	<20150225143116.GA13567@peff.net>
	<xmqqk2z5on72.fsf@gitster.dls.corp.google.com>
	<20150225185128.GA16569@peff.net>
	<xmqqbnkholx9.fsf@gitster.dls.corp.google.com>
	<20150225191108.GA17467@peff.net>
	<54EF0089.6070605@drmicha.warpmail.net>
	<xmqqr3tcl78o.fsf@gitster.dls.corp.google.com>
	<54F08989.2050504@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Noel Grandin <noel@peralex.com>, git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 27 20:18:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRQQ8-0002TB-Uc
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 20:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754836AbbB0TRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 14:17:53 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64369 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753105AbbB0TRw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2015 14:17:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD4093AEE2;
	Fri, 27 Feb 2015 14:17:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1uOKJAIV50hyloVdK60W5VESGkQ=; b=OM+mBf
	co2QRyIw0S3yXmjKVFNXxRP4Y51bbom8FSFwAmokO+/AYj2nGMxUXihGuGTEz88T
	a9r2bBXaXRMu+mUOiFMEmUTW52VJDuvLBbBWLUzNoINFfcWbKJrKB+h/uoF/YdRa
	Nkt/yBdF5dpA3/uL3nCuc5ChhxCrf8SbCZtf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y6NzDW4mxGCL2V058QgmvA46Vr42yYRQ
	68WexSJ39Qul4LJRHNM9gat+bkJo9NKaAro6yLepu37ks7C+N4QQYb6UaP/tSS5D
	LEEIOx1cMrcCj9ED3fmP0eClLcTxembFe+MP6oVJXS1GebPUTP9cBbcCr911Bfz4
	5Gec7pNLKHM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C59833AEE1;
	Fri, 27 Feb 2015 14:17:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 444F23AEDF;
	Fri, 27 Feb 2015 14:17:51 -0500 (EST)
In-Reply-To: <54F08989.2050504@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Fri, 27 Feb 2015 16:13:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 52B09148-BEB5-11E4-B78A-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264506>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 26.02.2015 21:59:
>
>> So that does not sound to me a summary of the discussion at all.
>
> Well, your conditional
>
>> I do not recall its conclusion, but it it were "Yes, that is what it
>> means", then it might be reasonable to:
>> 
>>  - have "git grep" ignore paths marked with -diff by default
>>    (perhaps "-a" option to disable, just like GNU)
>> 
>>  - have "git grep" pay attention to diff.textconv and search in the
>>    result of textconv filter.
>
> and Jeff's "Yes" on that condition certainly read like that to me: Make
> "git grep" react to "diff", "-diff" attributes in the same way as "git
> diff".

Ah, OK, I missed that flow of thought.

I read the conclusion as "_if_ using "diff" attributes is enough for
this purpose, then there is no code to be written ... but 'grep' and
'diff' may want to be different."

Once we know if they do *not* want to be different, I agree that it
may make things more consistent to turn --textconv on for binary
files when running grep.
