Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A05A20189
	for <e@80x24.org>; Wed, 22 Jun 2016 19:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbcFVTR2 (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 15:17:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55692 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751286AbcFVTR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 15:17:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A32626B42;
	Wed, 22 Jun 2016 15:17:26 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ffZZ6dJ78YQFcg6hMnyF9NwgXi0=; b=DL4AxO
	U9GfRB29jdbK6RHhBx+6iCCLVtn31HDEXjI/EDEsKdLh1l/Are0dl1By/97VbXIX
	aSvdsNOI7BkVuqyMN4kt6zIC3xbMRhizpwQD1zzhkrO8NFZOR3lP0Jeuc2AAdJO9
	6y7j4IlcVt4uY3I51WZkQgBIUiQMRq4dLZZnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mKwe38q6ATezIqGVv6Hv3cngLHKTC/G0
	Hu1Hbi6NIjK31jwxWZSVLaMsAqOyFJDPZI+R0DaJ54bw1NqPHms+z4yD/vsLrl4j
	vuf6sUPFXq6Dn6KbZ7TC2AeTLVTm91hRwTSHvICB+staKM75e5ZnwBsjuEhro/4H
	WIRNZF2LG+8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4081E26B41;
	Wed, 22 Jun 2016 15:17:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B7FF826B40;
	Wed, 22 Jun 2016 15:17:25 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Charles Bailey <charles@hashpling.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] grep: fix grepping for "intent to add" files
References: <20160621211412.28752-1-charles@hashpling.org>
	<20160621211412.28752-2-charles@hashpling.org>
	<xmqqinx2nonl.fsf@gitster.mtv.corp.google.com>
	<CACsJy8C9Dh_Owr3UFJnCtvXserG4V-e1ws8ZY52ME1yr+fefOw@mail.gmail.com>
	<xmqqlh1xm7c5.fsf@gitster.mtv.corp.google.com>
	<CACsJy8Acb+Hx1R66hcHQ7gNQ6TmKoUzC7Ar2PpSPkQeKM1EY8w@mail.gmail.com>
Date:	Wed, 22 Jun 2016 12:17:23 -0700
In-Reply-To: <CACsJy8Acb+Hx1R66hcHQ7gNQ6TmKoUzC7Ar2PpSPkQeKM1EY8w@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 22 Jun 2016 20:32:42 +0200")
Message-ID: <xmqq8txxm3ss.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F420C016-38AD-11E6-B405-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>>> If cached is false and ce_ita() is true and either CE_VALID or
>>> CE_SKIP_WORKTREE is set, we would continue to grep an _empty_ SHA-1.
>>> But I think we should grep_file() instead, at least for CE_VALID.
>>
>> Yes, that is the breakage I noticed in the patch under discussion
>> and that I wanted to fix in the "I wonder if a better change would
>> be..." version.
>
> Heh.. I did guess that. Since neither solution is complete, I'm in
> favor of Charles's and assume that i-t-a forces to ignore CE_SKIP and
> CE_SKIP_WORKTREE. I could wait for people to come back complaining,
> then we know there are real users in very obscure cases and will fix
> it then.

I said something that can be misunderstood.  I meant "I wonder if ..."
version is correct.  Charles's has the bugs you mentioned and I
wanted to fix them by sending the "I wonder if..." version out.

But you seem to have misread my statement as "A bug is in my version
and I want to fix that bug in my version".  That is not what I
meant.
