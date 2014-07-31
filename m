From: Junio C Hamano <gitster@pobox.com>
Subject: Re: stash-p broken?
Date: Thu, 31 Jul 2014 09:49:41 -0700
Message-ID: <xmqqbns5xyl6.fsf@gitster.dls.corp.google.com>
References: <CAJWZfo6j2E2qu1n6JTmtPw109tAjnEfWBvKxwGfTrKSF6MZ2Uw@mail.gmail.com>
	<CAJWZfo741u8KqZax4ReTEg8hy1BKWR2_PofxAQtE4wU=ikRsPw@mail.gmail.com>
	<20140729025940.GA8640@vauxhall.crustytoothpaste.net>
	<20140729092301.GA13134@peff.net>
	<xmqq61ig3xsp.fsf@gitster.dls.corp.google.com>
	<20140729174357.GA20042@peff.net>
	<xmqqwqaw2fe3.fsf@gitster.dls.corp.google.com>
	<20140731002321.GD22297@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Migdol <michael-spam@migdol.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 31 18:49:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCtYF-0000i0-AJ
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 18:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbaGaQtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 12:49:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59227 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064AbaGaQty (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 12:49:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 010E12DCF8;
	Thu, 31 Jul 2014 12:49:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=479zMRyaQgH/Dd4yjQI02NXDRa0=; b=GUImnT
	rJNVymArbBCTsqdXNL4449unvfuB0v8zI71C7dCve/L+AKZXeKw/xwcWjDakV5ma
	32VW3ptYUunjZADEaJS75zQYAnF0X52AeLqF1iXbTDj9gen9pHG9X7Mqb+vMKUVV
	Aan3TRwwhKpa8wFPe3byYqkGTnFCD3iiCcvLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pQ/AV2K2VIKWUn64EAtM5KK9m29qNdGn
	3J8+Lj0e/yBKH708jlV2276OGPJKEnpGj9upO/Aq9DAlZYlXaJh2WGe8rwCZpiHp
	rAYU1LuXBbnEXa57/bjsN3pnQJN/wR5Lfs1NpWsVicMvzuxNYmD/iJFHUpbVm2m+
	CxwFP8JEg58=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EBE4D2DCF7;
	Thu, 31 Jul 2014 12:49:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E8C402DCEA;
	Thu, 31 Jul 2014 12:49:42 -0400 (EDT)
In-Reply-To: <20140731002321.GD22297@peff.net> (Jeff King's message of "Wed,
	30 Jul 2014 20:23:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ABA12F94-18D2-11E4-9373-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254590>

Jeff King <peff@peff.net> writes:

> Hmph. To be honest, I am starting to wonder if implying "--first-parent"
> is a more sensible option for "stash list". It matches "stash show", at
> least, and it is not unreasonable to simply present the changes in the
> working tree by default, and ignore the index. People who are more
> clueful can pick apart the commits using "git log" themselves.

Yup, I tend to agree.

After thinking about this a lot, I really wish that we did not have
"stash apply" and "stash pop", but just "stash save" and a single
"stash restore" that either checks out the original branch (if its
head have not moved) or detaches the HEAD at the original commit
(otherwise), and then restores the state of the index and the
working tree (with or without untracked) and nothing else, but the
details are too long to fit in this topic ;-)
