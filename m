From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/10] t4209: factor out helper function test_log_icase()
Date: Mon, 24 Mar 2014 15:09:50 -0700
Message-ID: <xmqqsiq7nt8x.fsf@gitster.dls.corp.google.com>
References: <1395508560-19893-1-git-send-email-l.s.r@web.de>
	<1395508560-19893-4-git-send-email-l.s.r@web.de>
	<xmqqa9cfqwwp.fsf@gitster.dls.corp.google.com>
	<20140324211006.GA13728@sigill.intra.peff.net>
	<5330A76E.7060907@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 23:10:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSD4B-0005Kx-8s
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 23:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbaCXWJx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2014 18:09:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41352 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105AbaCXWJx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 18:09:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2EF27624C;
	Mon, 24 Mar 2014 18:09:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=l7Rdjor4f6YR
	E2lplldRO+ExzUM=; b=HZbrRjksNzcW63HVGjU2vxRlHvc9306r9amylOFmK0Hr
	EZ9AhNiSpzQuE+ttTiALNfafbi3q5I4mWAq2yDc5VpTzWeslRYoOn1MHWOdqWjXH
	Sr+pPqyGw6I6zpO0zHda4cE764ETGTd45E20wSTjE/eZarqKvKE0AS0+M6RoGnM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=D5VZyn
	/oAvP4oqsWhWwbVDES95gYBhe4yV7MLAoiTZDBjFYknoUfv7nbD20+ONqP+iRqYB
	37GulvJgQ+LWBKGjpza88xpV6eVQXjU7IUOqFrHRS+lc9bbVBLRAeQimHjD2w90V
	BgbjZ3IraLCuWO/PhkUcnkQe0DREDrGbx0ZZA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AE227624B;
	Mon, 24 Mar 2014 18:09:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7D6B76249;
	Mon, 24 Mar 2014 18:09:51 -0400 (EDT)
In-Reply-To: <5330A76E.7060907@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Mon, 24
	Mar 2014 22:45:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 05ADE820-B3A1-11E3-B3B1-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244891>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 24.03.2014 22:10, schrieb Jeff King:
>> On Mon, Mar 24, 2014 at 11:22:30AM -0700, Junio C Hamano wrote:
>>
>>>> +test_log_icase() {
>>>> +	test_log $@ --regexp-ignore-case
>>>> +	test_log $@ -i
>>>
>>> &&-cascade broken?  Will squash in an obvious fix.
>>
>> I don't think so. This is happening outside of test_expect_success,
>> which is run by test_log. So adding a && means that if the first tes=
t
>> fails, we do not bother to run the second one at all, which is not w=
hat
>> we want.
>
> Right; this function runs two independent tests and && is left out
> intentionally.

Ahh, sorry and thanks.
