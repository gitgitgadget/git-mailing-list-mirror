From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 01/11] ref-filter: use string_list_split over strbuf_split
Date: Wed, 17 Feb 2016 14:19:39 -0800
Message-ID: <xmqq1t8bhtdw.fsf@gitster.mtv.corp.google.com>
References: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
	<1455732379-22479-2-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRTtXPjvCL3a-2Y+sKBPY1fKNO39VYnzFQ7Ed3dJn+w8w@mail.gmail.com>
	<20160217221430.GA24899@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 17 23:19:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWARm-0003dI-Dq
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 23:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965583AbcBQWTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 17:19:42 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60329 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965470AbcBQWTm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 17:19:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 31DBB43935;
	Wed, 17 Feb 2016 17:19:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yJXogrPXNgfmx6TVy09+XOAvsek=; b=RhYu+i
	FCFtPL334uNf12okDLXGkE8rJG1pRPwi3K7DyhpYi3udiUUh/c/TF5m4GIwNiRJB
	JI7qz3kdviB5MHuSOuWvrX17Qt15LfUyO0QvnkJKveO0eVoPGBG5oXLkWskZNexh
	cdK2/Meo173qnwuubN9PjO/CbL1fNQRsJ699s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TAtI2m3jRqDbSLQ+oOnnNC3MT+ORklwC
	sYOp9rnL2oQeD4NpwwG33HXV7wrY1LQcYUl00FBYZx/OXXunjwQgesELgxH2zrBU
	MUQHkww/AiPzsdwXes1U60Jzbgat+ZF+08Un9pbIFlH9VxQ+DVaTHFVxpgTKsDH3
	pGo471ppw0o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2718343934;
	Wed, 17 Feb 2016 17:19:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8F8D543932;
	Wed, 17 Feb 2016 17:19:40 -0500 (EST)
In-Reply-To: <20160217221430.GA24899@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 17 Feb 2016 17:14:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 89BFBC82-D5C4-11E5-A382-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286560>

Jeff King <peff@peff.net> writes:

> On Wed, Feb 17, 2016 at 05:11:50PM -0500, Eric Sunshine wrote:
>
>> On Wed, Feb 17, 2016 at 1:06 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> > From: Jeff King <peff@peff.net>
>> >
>> > We don't do any post-processing on the resulting strbufs, so it is
>> > simpler to just use string_list_split, which takes care of removing
>> > the delimiter for us.
>> >
>> > Written-by: Jeff King <peff@peff.net>
>> 
>> Perhaps Peff can give his sign-off...
>
> Ah, right. I usually sign-off when sending to the list, so the version
> he pulled from GitHub didn't have it.
>
> Definitely:
>
>   Signed-off-by: Jeff King <peff@peff.net>
>
> And I don't think "Written-by" was doing much here, anyway; I am already
> the author by the From header at the top. :)

;-).

So, is everybody happy with this round?

With another series on top for the "conditional" stuff, I guess we
are ready to do the formatting for "git branch --list", which would
be a big step forward.

Thanks.
