From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/2] Add support for sending additional HTTP headers
Date: Wed, 04 May 2016 00:36:00 -0700
Message-ID: <xmqq7ffajmvz.fsf@gitster.mtv.corp.google.com>
References: <cover.1461837783.git.johannes.schindelin@gmx.de>
	<cover.1462342213.git.johannes.schindelin@gmx.de>
	<20160504062618.GA9849@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 04 09:36:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axrLu-00057V-Hx
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 09:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757229AbcEDHgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 03:36:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752421AbcEDHgF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 03:36:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2828111602;
	Wed,  4 May 2016 03:36:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oiY+Lz1pgVdSxlZid/T3CJ/0PP4=; b=GLjmLF
	JcVZpiRhTUPrIsU7gEnH1/nXDRJ+C80iE3Q35A4V/BrzJXJcgMe/JbymJcjZRV19
	D0GqsB3/ojs5bUmTUvYiWT2Hsl0bYuOXXhbaDc8oBxiELw4+sWSToD3HZd5PLf4e
	D1n1EAqqxetplnxoJ6gZtql3KGjwr+/hga0mg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v48TKof6uoLENwseRb2wwMi+2G0tn0zO
	HfBXhb++BWYr0MLL8O77idTrsGMomYcgjgyeBzhl726GPsNqVEuGEmK2O5r5LtZl
	P1S1yEn9kV25Z8Ge3Lwv+h2YQVM6Ft2HpAvm0Pho22I8nq11a6zGSEJiE1t7l3zT
	WB+14JJmv2c=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 21BC011601;
	Wed,  4 May 2016 03:36:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 92664115FE;
	Wed,  4 May 2016 03:36:02 -0400 (EDT)
In-Reply-To: <20160504062618.GA9849@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 4 May 2016 02:26:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DA5F33E2-11CA-11E6-A82D-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293505>

Jeff King <peff@peff.net> writes:

>>   submodule: pass on http.extraheader config settings
>
> IMHO this should come on top of jk/submodule-config-sanitize-fix (I was
> surprised at first that your test worked at all, but that is because it
> is using "clone", which is the one code path that works).

Yes.

> But I think we are waiting on going one of two paths:
>
>   1. drop sanitizing entirely
>
>   2. fix sanitizing and add more variables to it
>
> If we go the route of (2), then we'd want my fix topic and this patch.
> And if not, then we don't need any of it (just a patch dropping the
> filtering, which AFAIK nobody has written yet).

Doubly yes.  That is why I didn't pick up 2/2 in the previous round
and also jk/submodule-config-sanitize-fix is not in 'next' for the
same reason.

I agree with you that we have not yet reached concensus on which one
of the two we would want to take.  I was sort of surprised to see
2/2 sent again, after seeing that Dscho sounded strongly in favor of
not filtering the passed configuration variables, which would make
the patch unnecessary.
