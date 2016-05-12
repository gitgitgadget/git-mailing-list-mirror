From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/33] Yet more preparation for reference backends
Date: Thu, 12 May 2016 09:10:34 -0700
Message-ID: <xmqqfutngsud.fsf@gitster.mtv.corp.google.com>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
	<1462824758.24478.37.camel@twopensource.com>
	<xmqqinynt01r.fsf@gitster.mtv.corp.google.com>
	<5731062B.6080909@alum.mit.edu>
	<xmqq37pqubup.fsf@gitster.mtv.corp.google.com>
	<20160512075555.GC10922@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	David Turner <dturner@twopensource.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 12 18:10:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0tCK-0001b0-NH
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 18:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbcELQKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 12:10:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53027 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751857AbcELQKi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 12:10:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 40FDA18B15;
	Thu, 12 May 2016 12:10:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iA83nabfTLtCL7N1jTudZYrnIH4=; b=mxIS2L
	rPO7izclAHjXdSDWmhQzzT+iSx9l/XIvwGApUFA88vfGRKeb1BFrHfy7/YenlUJn
	sPXdGwS7usT1YQ2HS7QuKgXcfrh1SCmEtABtDh5DdG0DFJknueG2YoJIdI+XcdKq
	1p721IPZaNgEnRk6Yk2+wwVEYU47OmC/NQ1oA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mmh306t2F9kq9dS/I2tEpHZAojP/Z0O0
	yGed2BUjCqw2hCN+4Er2mYYgM48hY2n7UZ1qTn9K703TXj9XyDDc3nA+4v7sZGYq
	WjBo5YPataE7n1EUGURZUEZYUGUbYjesUGth712aR9Jo0smgudf8oFP9RCr07lbw
	v9t/OIoLaaE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 38D8218B14;
	Thu, 12 May 2016 12:10:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89C2218B13;
	Thu, 12 May 2016 12:10:36 -0400 (EDT)
In-Reply-To: <20160512075555.GC10922@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 12 May 2016 03:55:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 10094ACC-185C-11E6-849B-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294415>

Jeff King <peff@peff.net> writes:

> My trick for checking the before/after of a patch is:
>
>   1. Compile git without the patch.
>
>   2. Apply the patch, then run the test (via ./t1234-*, which does not
>      want to re-build git), confirm that it fails.
>
>   3. Re-compile and re-run the test, confirming that it passes.
>
> That also works well with "rebase -i" where you stop at the patch before
> to compile.
>
> I like it because it's simple and doesn't affect git's view (so you
> can't accidentally commit the in-work-tree revert, for example). But
> since there's nothing telling you what state the compiled git is in, it
> can be easy to get confused.

True.  It also would not work well with debuggers, but it is usually
rare to need a debugger to verify the claim of a "fix" patch, so I
think the above is easier to use in practice.

Thanks.
