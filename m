From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv14 0/7] Expose submodule parallelism to the user
Date: Tue, 23 Feb 2016 15:44:04 -0800
Message-ID: <xmqq4mczngaj.fsf@gitster.mtv.corp.google.com>
References: <1455905833-7449-1-git-send-email-sbeller@google.com>
	<xmqqtwl4bedt.fsf@gitster.mtv.corp.google.com>
	<xmqq8u2bngsi.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZucTS8ESLOEAJ2rJPrBEtQWHOow-a5G11vm4GOKEARqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 00:44:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYMcm-0005JZ-TL
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 00:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbcBWXoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 18:44:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64369 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751948AbcBWXoI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 18:44:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 282E548A44;
	Tue, 23 Feb 2016 18:44:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g/lb1mMzEyMDGRoNq6t5QPBBpX8=; b=OBhLzc
	xh0wHs3RG+WKjvtXzGKOvFl9fqVrEUfUyfZorfg/s5eR8sr/nnSLyWe11xlFpCDQ
	3zE22qKAIcCG5lQL5VphOc30GF8IpiUrPapmj4kJhxPb+56KvwwBpxRijoNjfFg8
	Z+Fd1TYQvqrYrkMndOghWUPQB7CLbYGRXQduA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z2EuKrm9QYLhv5dbO5vrAaBukzea+xEj
	ZJtjNWoLtW/vGzuhdwr/DMty1GtTw5wC+vl5XX80Auc2xjzXapzX7Cypx81IZ5Qt
	pD9bN3FLtKKkiIVcsrix7p9AkutQ5iAqrntLvvR0/W6UfVXstINtHZRohonHfpwH
	WmLST7d5hvY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1EFD448A42;
	Tue, 23 Feb 2016 18:44:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6A30848A3C;
	Tue, 23 Feb 2016 18:44:05 -0500 (EST)
In-Reply-To: <CAGZ79kZucTS8ESLOEAJ2rJPrBEtQWHOow-a5G11vm4GOKEARqg@mail.gmail.com>
	(Stefan Beller's message of "Tue, 23 Feb 2016 15:42:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5328B940-DA87-11E5-8445-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287145>

Stefan Beller <sbeller@google.com> writes:

> On Tue, Feb 23, 2016 at 3:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Looks good.  I didn't notice these unnecessary blank lines while
>>> reading the previous rounds, and it is good to see them go.
>>>
>>> Let's wait for a few days and merge them to 'next'.  David's ref
>>> backend topic textually depends on this, and we'd better give it a
>>> solid foundation to build on soon.
>>
>> So... it seems that you and Jonathan had a few rounds of back and
>> forth on 5/7 that didn't sound like it saw a satisfactory end.  Will
>> we see a reroll to address the issues raised?
>
> Yes, I was about to send one out, but then I wanted to fix the last
> of Jonathans small nits, which resulted in some heavy refactoring.
>
> I'll reroll, but I suspect it won't make it out today in time for integration.

Ah, that's OK, I've already pushed today's out.  Take time to read
it over one more time, perhaps?

Thanks.
