From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there interest in a n-sect tool?
Date: Wed, 20 Jan 2016 14:05:22 -0800
Message-ID: <xmqqd1sv52l9.fsf@gitster.mtv.corp.google.com>
References: <20160118075653.GA13911@glandium.org>
	<xmqq1t9fe0qw.fsf@gitster.mtv.corp.google.com>
	<20160118085835.GA15642@glandium.org>
	<xmqqziw2b4wi.fsf@gitster.mtv.corp.google.com>
	<20160119045719.GA11680@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jan 20 23:05:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM0si-0005rj-Nw
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 23:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935320AbcATWFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 17:05:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54533 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S935142AbcATWF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 17:05:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 080653CAAF;
	Wed, 20 Jan 2016 17:05:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z2dMyhuKXdYnyI7erxKaI3tBDe0=; b=BZ1wwR
	NFcPwkbz27xg/vQFrEnZgSJANMZ60PzaAun5enN+8WdlTUueaXd7xy1jSo2zEhuW
	s7zUkqNfs+UPaqs8eimTN+zYoaqABIsMjFAeO56usoUy1UBV8FTlwj4XwedMlpTV
	G/Ld8pqnehWUPDuqhRjy0S4sV5taY5EJVDiSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eWZg+Ifs+zj/y16YMiZYuWu6H8jNaATl
	6omUu3iNZpTLmoXt565AVdcCZCFoGD9sQagIaqYLDEwD+ref2aWemy5vP59rENpG
	A/5hoZlulacZdbFrOW2256vn5Kx4Hg5Uk5YqAUETBRqpLoGmaRiQbiS7EtUOTIQZ
	pT9otZDMZ+s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DE9CF3CAAE;
	Wed, 20 Jan 2016 17:05:24 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 090C63CAA8;
	Wed, 20 Jan 2016 17:05:23 -0500 (EST)
In-Reply-To: <20160119045719.GA11680@glandium.org> (Mike Hommey's message of
	"Tue, 19 Jan 2016 13:57:19 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E7A3AD5E-BFC1-11E5-BE31-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284475>

Mike Hommey <mh@glandium.org> writes:

> On Mon, Jan 18, 2016 at 07:54:21PM -0800, Junio C Hamano wrote:
>
>> Hmm, sorry.  For the two-trait example I gave (that can be extended
>> to N-trait), I can sort of see how the UI might look and I can say
>> it might be useful [*1*], but not with this, and especially that you
>> do not necessarily know all the traits whose transition points you
>> might be interested in a-priori--all of that makes the problem
>> definition fuzzy to me, and I cannot imagine what kind of user
>> interaction you would be envisioning to solve what kind of problem,
>> so I cannot even say it is a good idea or a bad idea.
>
> How about something like this:
>
> $ git bisect start
> $ git bisect state black A
> $ git bisect state white Z
>
> Git then gives you commit M to test, between A and Z. Now, you test M,
> and the result is that it's neither black or white, but gray, so you
> would do:
>
> $ git bisect state gray

Is it assumed throughout the bisect session that the only boundary
black touches is with gray (or some other color) and the only
boundaries gray touches are either with black or with white,
i.e. there is no path that goes from black to gray back to black and
then to white?  That is the parallel to the requirement a
bog-standard bisection has (i.e. "one side is all black, once you
cross the boundary to white, remainder is all white").

I just cannot see a realistic use case where that assumption holds
and still you do not know a-priori how many colors there are.

If that assmption holds, what you wrote would be a usable interface
and I suspect an implementable one.
