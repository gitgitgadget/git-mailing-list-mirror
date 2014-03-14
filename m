From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] general style: replaces memcmp() with proper starts_with()
Date: Fri, 14 Mar 2014 09:56:49 -0700
Message-ID: <xmqqeh24hg6m.fsf@gitster.dls.corp.google.com>
References: <1394635434-44979-1-git-send-email-quintus.public@gmail.com>
	<20140312175624.GA7982@sigill.intra.peff.net>
	<xmqqiorjky0a.fsf@gitster.dls.corp.google.com>
	<20140312194943.GA2912@sigill.intra.peff.net>
	<xmqq61njkwnw.fsf@gitster.dls.corp.google.com>
	<20140312211415.GA10305@sigill.intra.peff.net>
	<20140312220640.GA14802@sigill.intra.peff.net>
	<xmqqd2hrjb4d.fsf@gitster.dls.corp.google.com>
	<CALs4jVHTBH3wTAQsv8+jb15Do1_oy0pcThsDL8ssE7fgrx5NxA@mail.gmail.com>
	<20140314045758.GA32748@sigill.intra.peff.net>
	<CALs4jVHcPFjf-12mXvvSxctNJZgLD=P3=57u6_FYePDOB7txQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Quint Guvernator <quintus.public@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 17:57:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOVPw-0007wu-FG
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 17:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755195AbaCNQ5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 12:57:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40947 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754977AbaCNQ5C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 12:57:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA4A0756E6;
	Fri, 14 Mar 2014 12:57:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SDK7xADTduEHfmG/Ii5VQonwNuo=; b=kv0Q8D
	LbvwFOXyHYOhkewYOnjqMfPWS+DuW/yVlZlNoBPi1J9S7ggYpssIruPWKNNq7+xw
	1WMeavvIyo29w7Zwv+FabxXfWw7Nmhmul1FTwVJ/SM7XxKHliaKqTICOjzd0uo8E
	u9AV6B5VNK9eohTX/fQHfC5wiq5+odZGdt9fo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XM/jgjgYKZR1lM5nam4Y8o8pse9QkgFe
	i5iZRA1QzJYfI6v6UNKQm7NJJN0DVxuDpqXwkAvQubUdRvq73klqHbHNcVjnYnVR
	NL1lDfJ/dwu7RGYthhi2ogFxoDHXfo5Oxorz5ne6QjIf5iFWoBbQ+OYnccoQfq8O
	mZgoB9TE/U8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5B4A756E5;
	Fri, 14 Mar 2014 12:57:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 999A6756BC;
	Fri, 14 Mar 2014 12:56:51 -0400 (EDT)
In-Reply-To: <CALs4jVHcPFjf-12mXvvSxctNJZgLD=P3=57u6_FYePDOB7txQQ@mail.gmail.com>
	(Quint Guvernator's message of "Fri, 14 Mar 2014 10:51:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A3B8F218-AB99-11E3-B801-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244096>

Quint Guvernator <quintus.public@gmail.com> writes:

> I'll be re-reading this thread and working on this patch over the
> weekend to try to identify the more straightforward hunks I could
> submit in a patch.

Thanks.
