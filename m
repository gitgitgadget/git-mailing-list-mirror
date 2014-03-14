From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC GSoC idea: new "git config" features
Date: Fri, 14 Mar 2014 14:00:56 -0700
Message-ID: <xmqq61ngh4vr.fsf@gitster.dls.corp.google.com>
References: <53108650.2020708@alum.mit.edu>
	<xmqqwqgft3bj.fsf@gitster.dls.corp.google.com>
	<53112794.2070007@alum.mit.edu>
	<20140301075247.GF20397@sigill.intra.peff.net>
	<vpq38j2tc6f.fsf@anie.imag.fr>
	<20140314044326.GE31906@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 22:01:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOZE0-0006Qh-PL
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 22:01:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755808AbaCNVBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 17:01:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48082 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753570AbaCNVA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 17:00:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 756B1753ED;
	Fri, 14 Mar 2014 17:00:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tfY522l81ZmnC8TvBP3Q+VPNrJg=; b=DuloXC
	nhm6nyvUUnqVsa8sG3P20pU7AgeIA/zsFcVnS8EHi+8w6+FtnZZgoPQGso5nukWu
	47zhJx6cfdTaCS/T6g0NDNytfr2t3W/An4rYeDlYkdo0Mc7ipodUypAIYleJGjnb
	lkpAW3btYPJvnqUJbryZ6MPbu/2kPBbS+LtmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B+qFdq7g03mDLMKdVN2pdnnwUpBdCAHU
	XB/gQKnZjZ1kwN2tn3WMJZFthraC+WSPyKVP6XdgtQ5M+ZDk0tolc7E6vXUjIoLs
	tZsvvKXufTLfT6AjcW0NQT7PlqNzgOxhO/lUJVqNWnOpypz3OMTIv+a8rfsVeRME
	qOz/WijHZ38=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CF41753EC;
	Fri, 14 Mar 2014 17:00:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1FC5753EA;
	Fri, 14 Mar 2014 17:00:57 -0400 (EDT)
In-Reply-To: <20140314044326.GE31906@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 14 Mar 2014 00:43:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BD703E2E-ABBB-11E3-872E-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244111>

Jeff King <peff@peff.net> writes:

> On Sat, Mar 01, 2014 at 12:01:44PM +0100, Matthieu Moy wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > If we had the keys in-memory, we could reverse this: config code asks
>> > for keys it cares about, and we can do an optimized lookup (binary
>> > search, hash, etc).
>> 
>> I'm actually dreaming of a system where a configuration variable could
>> be "declared" in Git's source code, with associated type (list/single
>> value, boolean/string/path/...), default value and documentation (and
>> then Documentation/config.txt could become a generated file). One could
>> imagine a lot of possibilities like
>
> Yes, I think something like that would be very nice. ...
> ...
>> Migrating the whole code to such system would take time, but creating
>> the system and applying it to a few examples might be feasible as a GSoC
>> project.
>
> Agreed, as long as we have enough examples to feel confident that the
> infrastructure is sufficient.

I agree that it would give us a lot of enhancement opportunities if
we had a central catalog of what the supported configuration
variables are and what semantics (e.g. type, multi-value-ness, etc.)
they have.

One thing we need to be careful about is that we still must support
random configuration items that git-core does not care about at all
but scripts (and future versions of git-core) read off of, though.
