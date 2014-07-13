From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4 v6] cache-tree: subdirectory tests
Date: Sun, 13 Jul 2014 09:42:23 -0700
Message-ID: <xmqqsim51a8g.fsf@gitster.dls.corp.google.com>
References: <1405038686-1138-1-git-send-email-dturner@twitter.com>
	<1405038686-1138-3-git-send-email-dturner@twitter.com>
	<CAPig+cQVjy5eBtGLsX3uaTEsHyvyjhqCMFaLDn9Upueis-z1eQ@mail.gmail.com>
	<xmqqbnsv6hmc.fsf@gitster.dls.corp.google.com>
	<xmqq7g3j6gzr.fsf@gitster.dls.corp.google.com>
	<1405118791.3775.26.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, David Turner <dturner@twitter.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 18:42:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6MrJ-0006lr-Lq
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 18:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172AbaGMQmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 12:42:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58099 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754073AbaGMQmg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 12:42:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9B32225938;
	Sun, 13 Jul 2014 12:42:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dgSd8ZXAQtnEE31zL0o62q/w42o=; b=e0mHhZ
	Bdm8PcyGxIPQN8yu2dGH+xWOeI9e8GZB6PXhDIAuhNpXy8B8psU7gbwq2hQzULD7
	5kCLlW3Blxg2/kWakx2E0fN1W5C9kXcShScNdJqnQUAkmKxTLUlPwSdeiWjXCUIU
	nhj1tCOz/NwAfIMUgs/TDVBu9Yz3UtoJjDyj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KKZO6SyoOvw9lBPyz0eQI0/55BtkOAcq
	v4QIhHwfBOP9qsq5zM1KBd8tkFrvUCPC5fkarRUnbaeDfjhB/z0y7CY76MkLh2dJ
	XolYFRHNI0P/YAK7dkernR7KoCguV5i8JXM1CNd2/Ea0LzmXu8JRsHfZhi4NRiEa
	SvF7RuQb+5o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9180B25937;
	Sun, 13 Jul 2014 12:42:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2E93525931;
	Sun, 13 Jul 2014 12:42:08 -0400 (EDT)
In-Reply-To: <1405118791.3775.26.camel@stross> (David Turner's message of
	"Fri, 11 Jul 2014 15:46:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A1235602-0AAC-11E4-8296-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253448>

David Turner <dturner@twopensource.com> writes:

> On Fri, 2014-07-11 at 08:40 -0700, Junio C Hamano wrote:
>
>> In the ideal world, I think whoever tries to compare two cache-trees
>> (i.e. test-dump-cache-tree) should *not* care, because we are merely
>> trying to show what the correct tree object name for the node would
>> be, but this is only for testing, so the best way forward would be
>> to:
>> 
>>  - Stop using DRY_RUN in test-dump-cache-tree.c;
>> 
>>  - Stop the code to support DRY_RUN from cache-tree.c (nobody but
>>    the test uses it); and
>> 
>>  - Drop the "-e '#(ref)/d'" from the above.
>> 
>> I would think.
>
> Do you mean that I should do this in this patch set, or that it's a good
> idea for the future?

I have no strong preference either way.  Removing DRY_RUN may
simplify things in the code that gets used in the real life (as
opposed to the code that is only used during the tests), so I do not
mind it if it was done before the series as a preparation step.

> Also, if we don't use DRY_RUN, won't test-dump-cache-tree add trees to
> the actual ODB, which would be odd for a test program?

I do not see it as odd at all; after all, nobody in the real-life
uses dry-run and as you can see its use is broken, or at least is
inconsistent with the rest of the system.
