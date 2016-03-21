From: Junio C Hamano <gitster@pobox.com>
Subject: Re: When does git check for branch-X being uptodate with origin/branch-X?
Date: Mon, 21 Mar 2016 13:47:58 -0700
Message-ID: <xmqqk2kvlfr5.fsf@gitster.mtv.corp.google.com>
References: <CA+39Oz4izkhtxbUH8cQoD5-DLKAtv9KnC9OkG_ZhFw6Ysg0+gw@mail.gmail.com>
	<20160321202810.GD32071@sigill.intra.peff.net>
	<CA+39Oz4Atuv3N0QNj8o1SYgHzMUyES1QHUsWh-MdNiNr-xPM_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git list <git@vger.kernel.org>
To: Thomas Adam <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 21:48:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai6kC-0006jU-74
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 21:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685AbcCUUsD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 16:48:03 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752348AbcCUUsB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 16:48:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E47F44DC67;
	Mon, 21 Mar 2016 16:47:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wNN5ymzcs4g+9Us4Gju5hSDJcKQ=; b=pu4lc4
	A2lmc59Wm2hFnbipDqh82enxXRF5O/C3Dd1lncE3VZpT0dnTDtQKGb49IDDu+1rC
	L+iHhx8Hc/OM4eTFsswkNvxDm2EvFEcufEEMidntXoKF/1hwtk2/8TC/yx9Hs/qX
	TBNMAnhQ//P/Y2ZGHG3HVc5V6wqgWOZNQjQG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bf3kuYdJgzk+Bd3DskAAjjiEZJrwPIZN
	jTCAkLQJMWY1kvdJiI2nvDhhDXJW2RHIIJMeFt2nSNwBC3tqKevPGi2UQ5im98pD
	JPMVF1mTb7H4Zmt9ZSFLMufHKgD/iETcSt/3tGvk48ZkVZJ9zgQuyNOvMAO0vGAs
	CtatM2wrPUs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DBFB44DC65;
	Mon, 21 Mar 2016 16:47:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5731C4DC64;
	Mon, 21 Mar 2016 16:47:59 -0400 (EDT)
In-Reply-To: <CA+39Oz4Atuv3N0QNj8o1SYgHzMUyES1QHUsWh-MdNiNr-xPM_w@mail.gmail.com>
	(Thomas Adam's message of "Mon, 21 Mar 2016 20:43:17 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3263EF5C-EFA6-11E5-86B1-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289458>

Thomas Adam <thomas.adam22@gmail.com> writes:

> On 21 March 2016 at 20:28, Jeff King <peff@peff.net> wrote:
>> We never contact other repositories unless explicitly asked to by
>> fetch, pull, push, etc. If you want to have the most up-to-date value
>> without merging, you can just "git fetch" to update the tracking
>> branches.
>
> Thanks.  I understand how to use git-fetch, it's more a case of
> whether even printing that message is useful?  I appreciate it can
> only go on the cached value, but it is still misleading to print that
> in the case where the cache might not be up to date.

The real value of that message is "you haven't done anything on top
of what you last fetched from there", so "you are up-to-date" may
indeed be confusing, but I do not think of a better phrasing (other
than spelling out "last fetched from there" part explicitly, which
is quite a mouthful).
