From: Junio C Hamano <gitster@pobox.com>
Subject: Re: stash-p broken?
Date: Tue, 29 Jul 2014 12:27:07 -0700
Message-ID: <xmqqlhrc2cfo.fsf@gitster.dls.corp.google.com>
References: <CAJWZfo6j2E2qu1n6JTmtPw109tAjnEfWBvKxwGfTrKSF6MZ2Uw@mail.gmail.com>
	<CAJWZfo741u8KqZax4ReTEg8hy1BKWR2_PofxAQtE4wU=ikRsPw@mail.gmail.com>
	<20140729025940.GA8640@vauxhall.crustytoothpaste.net>
	<20140729092301.GA13134@peff.net>
	<xmqq61ig3xsp.fsf@gitster.dls.corp.google.com>
	<20140729174357.GA20042@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Migdol <michael-spam@migdol.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 29 21:27:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCD3P-0006E6-Qz
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 21:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbaG2T1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 15:27:16 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57032 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397AbaG2T1P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 15:27:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D35162CCBC;
	Tue, 29 Jul 2014 15:27:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tUyU7Kdr/VrHeq3BJ8ue5ZXWgAY=; b=e/6J+7
	ndKzJoiffVJnz9j6LufETb6K1r5iszG9zUI04O2Gx6hdv+PPo10tEgmYsVvfcehE
	yog5VN+ytV9urnPpwx3VUUxURZcgKaU77VuxL7gW3ktQ2Ceb9nKUsyyJONjVkXtV
	83/eMXl/bskAb+iBJW0E6HZASFMGuHGtwDfGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jBxBTaIGK+QolWJ6g2XKxyiBdFWlDTDl
	TUk5zFFG8vuqcsfpF+mCuy0+Ob72B4BoCse/+52BFP+/UYMb8g2X6rNjRsNgvJ0L
	U/S4X+byq2MR+KBVmGU0hqtCWuzeWFhYPqNrtaI+lK/NcipLaQctRjn9ifzd/PWI
	E7DNXC/74Os=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C98202CCBB;
	Tue, 29 Jul 2014 15:27:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8A4BD2CCB1;
	Tue, 29 Jul 2014 15:27:08 -0400 (EDT)
In-Reply-To: <20140729174357.GA20042@peff.net> (Jeff King's message of "Tue,
	29 Jul 2014 13:43:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 54D40F92-1756-11E4-805F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254461>

Jeff King <peff@peff.net> writes:

> I think that is my point, though. The user is _not_ aware that the
> commit in question is a merge. They stashed some stuff, and now they
> want to see the result. I'd like to show them a vanilla commit if the
> index is irrelevant, and otherwise show them something more interesting.

I actually think "git stash list" users should be made very aware
that they are looking at merge commits, and also what two states
each of these merge commits represents.  "git stash --help" says
that "list" takes any random option that you can give to "git log",
and at that point you need to be very well aware what you are
telling "log" to show and how.

It probably *was* a UI mistake to make "list" just delegate to "log"
and it was a graver UI mistake that it was documented as such;
otherwise we could have limited option set "git stash list" would
take, which can be totally independent from what "git log" takes,
and we could just have said "git stash list -p" is a way to view
each entry with patch in a reasonable representation.  But that
ideal world no longer exists X-<.
