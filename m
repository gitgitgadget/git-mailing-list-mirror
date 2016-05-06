From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: stop sanitizing config options
Date: Fri, 06 May 2016 12:56:36 -0700
Message-ID: <xmqqmvo32c5n.fsf@gitster.mtv.corp.google.com>
References: <cover.1461837783.git.johannes.schindelin@gmx.de>
	<cover.1462342213.git.johannes.schindelin@gmx.de>
	<20160504062618.GA9849@sigill.intra.peff.net>
	<20160504074559.GA3077@sigill.intra.peff.net>
	<20160504080047.GA2436@sigill.intra.peff.net>
	<CAGZ79kaUiVLuXvpLPKuZZ55zbQXA3Wt7WP3a_65gBW2Cj-gMoQ@mail.gmail.com>
	<20160505012219.GA15090@sigill.intra.peff.net>
	<xmqq60uscufw.fsf@gitster.mtv.corp.google.com>
	<20160505201416.GD9162@sigill.intra.peff.net>
	<xmqqtwic6pxs.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZ4wOQrZETB4UVVRO6oecF-qqjzb9hP6-JenNxFNfjiLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 06 21:56:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aylrf-0000kf-Vu
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 21:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758533AbcEFT4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 15:56:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62020 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758275AbcEFT4j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 15:56:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8634118689;
	Fri,  6 May 2016 15:56:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7nx9VLt2Fnj6GqGJVwHr/OJheak=; b=EHVE4b
	EV1arpaCD0Ch+iFKUnaJrf4NeS8mGv55c8BJF1gAkFqgPYUY607aJ+UPDdv7Bg77
	eHPrv3D9ZNBBjt1fYfOsADFA3DytLyWkaBxy1vt4tjWvQ9Qjqh7vx7hHq8QI8eyv
	KjKBpKt+uI3KQQHhf0RZA7kE7djdlximRSXHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m/iPCzlafmr/9dqCWz7bpplt6VR/toJY
	wZcGyH9ZRgdpuoULGL2nfSPUGhwvVrLFnVxxg2hVhb8IyXXJ8mO4KVymZUQb3Lvc
	6JQEUzKDVxuW5poYvr0+gVjWY/e5tZQQQgNNW36dMuwVZAY6pBjj2WCdCxY4oPzP
	Smucyf2hduI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C7FD18688;
	Fri,  6 May 2016 15:56:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3D4E18687;
	Fri,  6 May 2016 15:56:37 -0400 (EDT)
In-Reply-To: <CAGZ79kZ4wOQrZETB4UVVRO6oecF-qqjzb9hP6-JenNxFNfjiLw@mail.gmail.com>
	(Stefan Beller's message of "Thu, 5 May 2016 17:23:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A4B8DF3A-13C4-11E6-8EC5-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293853>

Stefan Beller <sbeller@google.com> writes:

>> Hmph, Stefan, do you want to keep this (if you want to resurrect the
>> function in some future, for example)?
>
> IMHO it is easier to revert or rewrite than to carry unused code?
> Unused code is not tested and untested code is broken code.
> And relying on broken code in the future will guarantee bugs.
> (Sure new code may also have bugs, but I just think that bugs
> in newly written code can be fixed easier)
>
> I would prefer to get rid of it, i.e. taking that patch.

OK.
