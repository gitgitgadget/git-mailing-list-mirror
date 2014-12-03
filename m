From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/14] lockfile: introduce flag for locks outside .git
Date: Wed, 03 Dec 2014 15:38:03 -0800
Message-ID: <xmqqmw74uwx0.fsf@gitster.dls.corp.google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
	<20141117233525.GC4336@google.com>
	<CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
	<20141118004841.GE4336@google.com>
	<CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
	<20141203050217.GJ6527@google.com> <20141203051911.GP6527@google.com>
	<xmqqvblsuy2e.fsf@gitster.dls.corp.google.com>
	<xmqqr3wguxhv.fsf@gitster.dls.corp.google.com>
	<20141203232951.GJ6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 00:38:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwJUs-0007OY-0z
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 00:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641AbaLCXiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 18:38:09 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63226 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752492AbaLCXiH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 18:38:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5048E237D4;
	Wed,  3 Dec 2014 18:38:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rFcQiEhZ+4qHWTmEPPmdGdnLe7E=; b=IFSpLO
	v6XB8OAhppEms+kYeCR1zXwz35Njd5fVzshqAaNqDo5JSKI/RVFuGejnkskjv0ye
	+pCun9LOEmmtiqGdNeEJ0s0DeGTHc1i9Y8c3Qfk+t/TQjM1M+VpT7JbtucPucRZ4
	Qa0Wy7dQeuqINWOkfoL+EE4mnj7VYY2OTOhik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A9FDX9AJIlWowstlKqTUHa9dgOJQThH+
	CsO943MmKm7E3nKdaLhF31+7A/FPoY/Iubw8NUGnd8vEBVEvApUD8erhqJ8WDkML
	zqXI2ZdLWfCYPxmnoQal4kLtitbeb4/kbIFd2RveSrvXI2i/rUmlXQmrmndERSTO
	1CKFz2dIMXY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 46115237D3;
	Wed,  3 Dec 2014 18:38:05 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BAD5B237D1;
	Wed,  3 Dec 2014 18:38:04 -0500 (EST)
In-Reply-To: <20141203232951.GJ6527@google.com> (Jonathan Nieder's message of
	"Wed, 3 Dec 2014 15:29:51 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6D7C4F52-7B45-11E4-A475-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260712>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> The 14-patch series may have been internally consistent and its
>> individual patches, when each of them was taken alone by itself, may
>> have made sense, but it appears that the aggregated whole these
>> separate topics took their root from is inconsistent with itself
>> in minor ways like this here and there X-<.
>
> I don't follow.  It's normal for an API change to affect code that
> uses the API --- what inconsistency are you talking about here?

I was under the impression that the purpose of the series was to
propose an API update to be used together with the remainder of the
system, not just "update code in master, breaking unstated set of
topics and leaving them behind without updating them for now".

Such a series is perfectly fine as a feeler to see if people are
happy with the updated API that it does not completely cover the
topics in flight, but I wouldn't have had to waste time trying to
figure out what you are doing differently to cause other topics in
flight to break if such a feeler series were labeled clearly as
RFC/PATCH, and/or "these other topics need to be adjusted to this
new API when this series settles", or somesuch.
