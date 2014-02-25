From: Junio C Hamano <gitster@pobox.com>
Subject: Re: `git stash pop` UX Problem
Date: Tue, 25 Feb 2014 14:23:04 -0800
Message-ID: <xmqqvbw24yt3.fsf@gitster.dls.corp.google.com>
References: <530B0395.5030407@booking.com>
	<CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
	<530C953F.9050805@booking.com> <vpqlhwz5o58.fsf@anie.imag.fr>
	<530CA4C9.60601@booking.com> <vpqeh2r43kx.fsf@anie.imag.fr>
	<85mwhe52zp.fsf@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Leake <stephen_leake@stephe-leake.org>
X-From: git-owner@vger.kernel.org Tue Feb 25 23:23:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIQPC-00087K-CO
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 23:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732AbaBYWXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 17:23:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61259 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072AbaBYWXH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Feb 2014 17:23:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34CF96F308;
	Tue, 25 Feb 2014 17:23:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=MiLgXC0/wDCobFNSOort+n9yhdk=; b=C/zTtBBmE9jPo2GgSEsm
	AQ8nwgxjiRwhKVJfvKD78ILuourqhTN/dFV+o+qx3F1I6PV7r/NC+7UZZ91Ao1Sh
	PHWrs+FTVdD0Zn64Qze+yLavYEV6D9ciL7p6tpp3/hpNOOsceN9kbA/1ig9kVu5o
	o846d6acWgWca7CytotE3iE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ROEJtZC8bl4+neTHfE4V9O2tVTg7uaq4m1Tb4To867NBYx
	wQCGD/a3xVWNg/qXRmF4BtYVhUjMYD278Hm65v1Uq4moGyKLto3oaOND0i7pEb5D
	PDR2QYp5axECUEdDXPV94R9ZUQ5A7EReAzJOsbQA8ynCnnsviI5X8fe7CE9IU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22B8D6F307;
	Tue, 25 Feb 2014 17:23:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 218F76F306;
	Tue, 25 Feb 2014 17:23:06 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 66038F7C-9E6B-11E3-AF78-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242689>

Stephen Leake <stephen_leake@stephe-leake.org> writes:

>> Dropping the stash on a "git add" operation would be really, really
>> weird...
>
> Why? That is when the merge conflicts are resolved, which is what
> logically indicates that the stash is no longer needed,...

Not necessarily.  Imagine a case where you used stash to quickly
save away a tangled mess that was not ready for a logically single
commit and now you are in the process of creating the first commit
by applying it piece-by-piece to create multiple resulting ones.
After you commit the result, you would still want to keep the parts
of that stashed change you did not include in the first commit so
that you can go back, no?

You may run "git add", but that does not say anything about what you
are going to use the rest of the stash for.  Not even "git commit"
may be a good enough sign.
