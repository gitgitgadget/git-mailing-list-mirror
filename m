From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda conditions
Date: Wed, 04 Sep 2013 10:38:03 -0700
Message-ID: <xmqq1u54o5c4.fsf@gitster.dls.corp.google.com>
References: <1378103439-3225-4-git-send-email-felipe.contreras@gmail.com>
	<20130903071256.GD3608@sigill.intra.peff.net>
	<20130903075107.GA25540@goldbirke>
	<20130903080358.GA30158@sigill.intra.peff.net>
	<CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
	<20130903111006.GJ29840@goldbirke>
	<CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
	<20130903150855.GK29840@goldbirke> <20130903170419.GA29921@google.com>
	<xmqqli3co7ov.fsf@gitster.dls.corp.google.com>
	<20130904171356.GD2582@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Sep 04 19:38:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHH20-0003gg-Ak
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 19:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763093Ab3IDRiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 13:38:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48121 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756540Ab3IDRiG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 13:38:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 011113E1AF;
	Wed,  4 Sep 2013 17:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DCjdXoFjrUboh+wGWsfaitX+RGo=; b=Oe17rj
	/V+wDUGGfMQ+JBknHwuVBkoFHIcLBMZ48C1I0LkcOJqpH96OXzou/Q/QeHfO0kfz
	66CDLl8/Y5cZohBu9wr3T5bWCwdcYKMkUncWJxZAIJtt27QjW7DTlV4m6nK81mJr
	gpiKFmpPszLja/s5GNaWgDFYVDFBOWqWwARAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jy/F5qHL+rL5D3v1mEgdS7/3c4lh78mO
	BV/DS/+vCiq19jDv5hMWNxbbnJY26m514mQrhhdJ/ti9njKcKKiJoBfmOrUkHmfM
	PdbevPnH1sOoUCYc0SNo9HvsdpTLoiLAiY6TQKlkRmfB9s1+XwHKkIIXXXzorXjT
	CZQVf8ARUks=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E457F3E1AE;
	Wed,  4 Sep 2013 17:38:05 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 259B63E1AA;
	Wed,  4 Sep 2013 17:38:05 +0000 (UTC)
In-Reply-To: <20130904171356.GD2582@serenity.lan> (John Keeping's message of
	"Wed, 4 Sep 2013 18:13:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C136B8C2-1588-11E3-BA8F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233852>

John Keeping <john@keeping.me.uk> writes:

> On Wed, Sep 04, 2013 at 09:47:12AM -0700, Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>> 
>> > test_cmp_rev follows the same order of arguments a "diff -u" and
>> > produces the same output as plain "git diff".  It's perfectly readable
>> > and normal.
>> 
>> This is way off tangent, but I am somewhat sympathetic to Felipe's
>> "compare actual with expect", with reservations.
>
> This isn't an argument either way, but note that JUnit (and NUnit and
> PHPUnit) all have assertEquals methods that take the arguments in the
> order "expect, actual".  I've always assumed that Git's test framework
> was imitating that,...

No.  See 82ebb0b6 (add test_cmp function for test scripts,
2008-03-12).  The "test_cmp" was a replacement for "diff -u", and
the same order we fed "diff -u", i.e. expect then actual, was
carried over.
