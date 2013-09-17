From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Tue, 17 Sep 2013 14:46:46 -0700
Message-ID: <xmqqsix3w27t.fsf@gitster.dls.corp.google.com>
References: <523094F0.9000509@gmail.com> <20130911182921.GE4326@google.com>
	<CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
	<20130911214116.GA12235@sigill.intra.peff.net>
	<CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
	<20130912101419.GY2582@serenity.lan>
	<xmqq61u6qcez.fsf@gitster.dls.corp.google.com>
	<20130912182057.GB32069@sigill.intra.peff.net>
	<CAHGBnuPzzokV7YMrx0gAL1VACcmaLwFoaB3n6bX8Y-UDHs7S8A@mail.gmail.com>
	<20130912202246.GF32069@sigill.intra.peff.net>
	<xmqqr4ctokat.fsf@gitster.dls.corp.google.com>
	<CAHGBnuOQ-y1beD_X_jiH+FrhPvLOVJqT0J=Wk988Q4NeCs1-9Q@mail.gmail.com>
	<xmqqppsckcsd.fsf@gitster.dls.corp.google.com>
	<CAHGBnuMNDJhAqNfgVRHRE-7R=UZbd+fMExYeKDWWCFjyQJYYTQ@mail.gmail.com>
	<xmqqppscij8a.fsf@gitster.dls.corp.google.com>
	<CAHGBnuM=QqLxPNNZmoL1jG+oAm2y6o=AuBtkH+FRwZ_8ahGC+w@mail.gmail.com>
	<xmqqli30idfx.fsf@gitster.dls.corp.google.com>
	<CAHGBnuOfYoosgWQdfF+L3=YCqO-MYEx-TpNzBAD-Zt0kqeR_Hw@mail.gmail.com>
	<xmqqhadj1kyo.fsf@gitster.dls.corp.google.com>
	<CAHGBnuMgE1zO4=MnJJXcDLJSD2Vsjptk1x2Bc6CpF9GSxmFp8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 23:46:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM36l-0006UK-B8
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 23:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490Ab3IQVqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 17:46:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38548 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753271Ab3IQVqu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 17:46:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAD1242B5E;
	Tue, 17 Sep 2013 21:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5Cboz+NtC7Kxb0RBMUTZtLlqelQ=; b=vUKDwS
	ABD2CAa+SusJkvlVBnY/5zyD+mKdk0H0ZwqgWbS9qyKykfyJFVKVChHAJ/dczbKT
	aDsd9H3UYJHLZDiEItn+DUnNj36i4kBkhCMS2sxGn+L9MUv6DSjmcTS+L/xAEjyJ
	a/f5M8qyNA4/u+iMvbwiRu6dlkrmrbpToRY+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AEdcebBVlAdWRUP2Ug/ZIeCHibay+nvV
	5K2zlHtpK0dzbT1OCAjMg43XKT221bwr1sO1MhcVlMgiDzKtdtxomY+/o7wiCBNo
	UCzX7u8O+8/W+si5cTWoUTnEIGPrdWvT6oqtNlhfGZzxI5tGb8iBNyQt7rZDOzap
	t48hBqUKs18=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD66F42B5B;
	Tue, 17 Sep 2013 21:46:49 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B23342B55;
	Tue, 17 Sep 2013 21:46:49 +0000 (UTC)
In-Reply-To: <CAHGBnuMgE1zO4=MnJJXcDLJSD2Vsjptk1x2Bc6CpF9GSxmFp8w@mail.gmail.com>
	(Sebastian Schuberth's message of "Tue, 17 Sep 2013 21:16:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A7E6AAB2-1FE2-11E3-8CE9-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234933>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On Tue, Sep 17, 2013 at 6:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Keeping the ugliness to deal with the platform issue (i.e. broken
>> string.h) in one place (e.g. compat/mingw) is far more preferrable
>> than having a similar ugliness in git-compat-util.h for people on
>> all other platforms to see, no?
>
> I don't think people on other platforms seeing the ugliness is really
> an issue. After all, the file is called git-*compat*-util.h;

Well, judging from the way Linus reacted to the patch, I'd have to
disagree.  After all, that argument leads to the position that
nothing is needed in compat/, no?

> Also, your solution does not really keep the ugliness in
> one place,...

One ugliness (lack of sane strcasecmp definition whose address can
be taken) specific to mingw is worked around in compat/mingw.h, and
another ugliness that some people may use compilers without include_next
may need help from another configuration in the Makefile to tell it
where the platform string.h resides.  I am not sure why you see it
as a problem.

> I do insist to avoid GCC-ism in C files,...

To that I tend to agree.  Unconditionally killing inlining for any
mingw compilation in compat/mingw.h may be the simplest (albeit it
may be less than optimal) solution.
