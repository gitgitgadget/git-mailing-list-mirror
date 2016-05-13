From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Empty config sections are neither deleted nor reused
Date: Fri, 13 May 2016 09:47:41 -0700
Message-ID: <xmqqeg95aor6.fsf@gitster.mtv.corp.google.com>
References: <87r3d6knwo.fsf@bernoul.li>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jonas Bernoulli <jonas@bernoul.li>
X-From: git-owner@vger.kernel.org Fri May 13 18:47:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1GFh-0004WM-TH
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 18:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbcEMQrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 12:47:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62205 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752131AbcEMQrp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 12:47:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 100C4198BB;
	Fri, 13 May 2016 12:47:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=00MlP8UD4qVtfqgHUefK8N4aCX8=; b=NawEuK
	vCgJcLeSKQsqgs1EAA/fK4PttIEKFa8UE3s6Mafpl43nYftGqEm2Z0EY2T+gmDpD
	z9fICo/6qKRcU5Zx2LD5c50jJAZz6VUcSXqlwpAtHJOrM0vgCYY6OWMyIMW9Fii1
	Um67qHWgA6idAnxHtJFdsB9kO5HjEH3U1gdUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ecETyysWTD76zOIX0mXrF0W7RwWeyFiK
	8vugUHsjSW3+I95iHbXRe1ENL1Y1o2hphUobKOODcXn8WoCC85WAhHeqv0cAsQ8+
	NJPutHonuCghUhtp3B3cG828MI5PP4s5JrY+2EY5tieOcQD6Pc/7Vv1NcJ7VN7Ru
	EJbLwSBREt8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0436E198B9;
	Fri, 13 May 2016 12:47:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 704FA198B8;
	Fri, 13 May 2016 12:47:43 -0400 (EDT)
In-Reply-To: <87r3d6knwo.fsf@bernoul.li> (Jonas Bernoulli's message of "Fri,
	13 May 2016 16:55:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 69BDDD84-192A-11E6-A5FF-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294544>

Jonas Bernoulli <jonas@bernoul.li> writes:

> The only possible combination which doesn't make sense is to not remove
> an empty section and to also not reuse an empty section - unfortunately
> that's what Git currently does.

It is not that simple.

The configuration sections can have comments and they are preserved
even when they become empty.  Adding something unrelated will still
make it appear the stale comment applies to it.

If you are interested, start here:

http://thread.gmane.org/gmane.comp.version-control.git/219505/focus=219524
