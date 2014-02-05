From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Bug] branch.*.merge interpreted too strictly by tracking logic
Date: Wed, 05 Feb 2014 13:05:04 -0800
Message-ID: <xmqqbnyl2run.fsf@gitster.dls.corp.google.com>
References: <xmqqa9e67atv.fsf@gitster.dls.corp.google.com>
	<20140205205030.GA16394@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 05 22:05:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB9f6-0000IK-AL
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 22:05:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755849AbaBEVFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 16:05:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38767 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756490AbaBEVFO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 16:05:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31C1769DA9;
	Wed,  5 Feb 2014 16:05:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fBisaaE8C65AVmM+C5mUYiJKfj4=; b=aCyzGj
	l1vz4y4DxzlM6gToF5YXHUpmMCQ38TM5ujcUlh5NQHeDso2NJWfoQr6f19KgfEG2
	293aZGcYAXRKIxvCtkA8zVtdTLeonSvNBZaEM6+8cTg2RJKOhqh606ez9JXmhH4m
	rUyiVGTssHqgnpuj0qbsi9BKtLG8eG/SX3KxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AxwSDnl/IBj8rc7OFbTkHVXCHyfOAVye
	xfNG4HdVheMNRypyw46n/HlDC4Mpum7xvuLM142sdz9O85zA2cVUKKXzmQbDXIS6
	8BoQneXhYVsMPca5x5oMVUHs+cyY0he4Rp/IMwbfLQubEiC+AQmconJLMbhxrMGR
	pGpeNn92eCI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCA3969DA6;
	Wed,  5 Feb 2014 16:05:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C09A69D9F;
	Wed,  5 Feb 2014 16:05:07 -0500 (EST)
In-Reply-To: <20140205205030.GA16394@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 5 Feb 2014 15:50:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 30F4C96C-8EA9-11E3-9065-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241663>

Jeff King <peff@peff.net> writes:

> Is it legal to put an unqualified ref there? A wise man once said[1]:
>
>   > Actually, it is broken in a lot of places. for-each-ref relies on
>   > the same code as "git status", "git checkout", etc, which will all
>   > fail to display tracking info. I believe the same code is also used
>   > for updating tracking branches on push. So I'm not sure if it was
>   > ever intended to be a valid setting.
>
>   It wasn't.  Some places may accept them gracefully by either being
>   extra nice or by accident.
>
> I don't recall us ever doing anything after that. I don't have a problem
> with making it work, of course, but I am not sure if it is really a bug.

Once people get used to us being extra nice in some places, other
less nice places start looking more and more like bugs. It is an
unfortunate fact of life, but fixing them up is a good thing for
users.  As long as we can make those less nice places nicer
uniformly without bending backwards or introducing unnecessary
ambiguities, that is, and I think this one can be done without
such downsides.
