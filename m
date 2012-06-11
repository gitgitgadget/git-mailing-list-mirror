From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] update-index: allow overwriting existing submodule index
 entries
Date: Mon, 11 Jun 2012 08:03:29 -0700
Message-ID: <7v3961ao1q.fsf@alter.siamese.dyndns.org>
References: <CAOkDyE9q1n=oLoEXXxurDjNM0B2+cZ9eoeGE57F9hEQUjK0hZg@mail.gmail.com>
 <20120609142658.GB16268@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Spiers <git@adamspiers.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 17:03:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se69a-0001bA-IX
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 17:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755397Ab2FKPDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 11:03:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35182 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754871Ab2FKPDd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 11:03:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1094188CD;
	Mon, 11 Jun 2012 11:03:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VQe/G1S82AO5LX2e6kgdE/4B880=; b=O99mac
	LnAC5GWLBwQZFnCfNTIoOHp7U5CW/cdTpRk5zoexkz3dsM5JG3PPXSfuuhxYBvQS
	+Efcxf2/Y8OrJWdYfTwvzLjHD8zG+vOzLB982jLrYgaAnfG7t+ZqqRG2zBjUYQSb
	Y5pjFO//WNDthFvErmH1I7wRLr/7Xmzn+ds3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FeHgzkEZ0pIYW0i6oLYMKPL18CypEK//
	95yxD5KP3amgSBcRlRcwJOjvmSWlwLQc5bP2c6ohCIytkdD7RwLPNAJoBeq8mTLp
	mity9WWMOl02PCslUs5f/Jz+vhIhk89Dv1NILV9ql/GNrwJ4iArppCZkQfJhxOoM
	OhjqHoB1Y/Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0668188CC;
	Mon, 11 Jun 2012 11:03:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9088C88CB; Mon, 11 Jun 2012
 11:03:32 -0400 (EDT)
In-Reply-To: <20120609142658.GB16268@book.hvoigt.net> (Heiko Voigt's message
 of "Sat, 9 Jun 2012 16:27:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9C64A866-B3D6-11E1-9A0B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199656>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> In commit e01105 Linus introduced gitlinks to update-index. He explains
> that he thinks it is not the right thing to replace a gitlink with
> something else.
>
> That commit is from the very first beginnings of submodule support.
> Since then we have gotten a lot closer to being able to remove a
> submodule without losing its history. This check prevents such a use
> case, so I think this assumption has changed.

Yeah, I think we should remove it if only to make it consistent with
"add" (if anything, the Porcelain level "add" should be the one that
is more strict and the plumbing level should be able to let you
shoot in the foot, not the other way around), but we need to make
sure "closer to" becomes reality.  Can we remove and the resurrect
automatically when checking out a branch with a submodule when you
are on a branch with a directory and vice versa?
