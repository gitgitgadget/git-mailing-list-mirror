From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Big repo not shrinking on repack or gc?
Date: Wed, 14 Jan 2015 09:24:35 -0800
Message-ID: <xmqqmw5lb7ho.fsf@gitster.dls.corp.google.com>
References: <20150114115130.GA5677@inner.h.apk.li>
	<20150114124936.GC30383@peff.net>
	<20150114143946.GE13247@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 18:24:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBRgQ-00024q-Rv
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 18:24:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871AbbANRYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 12:24:38 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52975 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752101AbbANRYh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 12:24:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C9A32B808;
	Wed, 14 Jan 2015 12:24:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2ReQaSntsjIG4x+pGcymIx1YPCI=; b=a7ZF0D
	wDAwIZ5jlZkmIRMnd+cU2Q9RPTRVzLq8kRSRIxhxCFkx9rolEojYDxdpNNw2kPRB
	dJVrKS4Ub42nyYL68UsqFD7IxRJcX6Htsl1DFBKR/v2roaNc77msY99zxEbgBVKf
	uOM3SXXdgLqjtquj/tnsmbA//DVIhLYOU6uEE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l6u25WRsyMcJKgRJW7fOkvEHhfZi4P1q
	Nk1/f5v6o0KL3UBxdb3f055V9ZsGm4WCyxTYvX96GApZn9kAg5P0rS9YPFtDa4K5
	4wcn5MESnxIK4XcIKgoQGyPsETKQBOvdyqTNA4VpI3KLLJdldaau6qlEWpZaqE1w
	RpN2AciiXSI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 20D982B806;
	Wed, 14 Jan 2015 12:24:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8823E2B804;
	Wed, 14 Jan 2015 12:24:36 -0500 (EST)
In-Reply-To: <20150114143946.GE13247@inner.h.apk.li> (Andreas Krey's message
	of "Wed, 14 Jan 2015 15:39:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 36803BA6-9C12-11E4-8746-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262393>

Andreas Krey <a.krey@gmx.de> writes:

> On Wed, 14 Jan 2015 07:49:36 +0000, Jeff King wrote:
> ...
>> You don't need the "-f" here. Just "git repack -ad" should be enough
>> (and the "-f" probably makes it _way_ slower).
>
> Indeed, factor four.
>
> However, my expectation is that a repack -ad will remove all the
> old pack files, as what is in there is either referenced and put
> into the new pack, or dropped => there should be a single pack file
> afterwards.
>
> This is not the case. :-( (Done only with 1.8.2 due to
> lack of compilers for this box.)

Guess in the dark: "ls -l .git/objects/pack"
Do you see any .keep files?
