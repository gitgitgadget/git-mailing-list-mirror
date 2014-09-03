From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] Teach revert/cherry-pick the --no-verify option
Date: Wed, 03 Sep 2014 12:21:55 -0700
Message-ID: <xmqqk35ky0fg.fsf@gitster.dls.corp.google.com>
References: <1409753034-9459-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Lars Gullik =?utf-8?Q?Bj=C3=B8nnes?= <larsbj@gullik.org>,
	Neil Horman <nhorman@tuxdriver.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Sep 03 21:22:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPG83-00045i-If
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 21:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755614AbaICTV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 15:21:58 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60740 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755571AbaICTV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 15:21:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 38E1037EFC;
	Wed,  3 Sep 2014 15:21:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wcH521Acnjo01wewLF9nFMZvf4w=; b=oLlE0z
	p+EgrTS2yqzuaGa8ZkovyxWn/cUxc35qzEq0g4scgq3+IEfNunRVAUQcsZkCgc6y
	5Dh0TlYdJEblOEvLAge1SElfYmipbk8FWQoQi8IsdTgdhk00Js6OuPRfwHM03wpw
	HF2fFiOUdMErAYeSnM4dZoECe41MhVFA7E6uo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EFz805F1dYHCFUUNgieEpOYv/eKP+2lU
	KvY/CxFLpvtdPdBEQYAr0NJ0Sj4VfdQiTg32DeLoBTBgsi29g8vnwL7W6GuxGyqN
	caklraM3yU1jaQiidF2OHj47dmz1XMBEVvQNoew1bhspjsuEK4yZnl2KMxGSLldo
	f/mrmbwD/dM=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2CC6737EFB;
	Wed,  3 Sep 2014 15:21:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9131937EF8;
	Wed,  3 Sep 2014 15:21:56 -0400 (EDT)
In-Reply-To: <1409753034-9459-1-git-send-email-johan@herland.net> (Johan
	Herland's message of "Wed, 3 Sep 2014 16:03:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 91CA55E0-339F-11E4-88F7-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256404>

Johan Herland <johan@herland.net> writes:

> A colleague of mine noticed that cherry-pick does not accept the
> --no-verify option to skip running the pre-commit/commit-msg hooks.
>
> Here's a first attempt at adding --no-verify to the revert/cherry-pick.

Back when cherry-pick was a single commit operation, lack of the
option did not matter very much, but it probably makes sense to
allow telling the command that the entire series of commits is
expected to be full of ones that do not verify.  In the same vain,
we already support --allow-empty and --allow-empty-message, so in
that sense this change probably is an improvement.
