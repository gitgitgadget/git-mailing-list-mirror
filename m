From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 02/10] replace: add --graft option
Date: Fri, 11 Jul 2014 07:22:32 -0700
Message-ID: <xmqqmwcg561j.fsf@gitster.dls.corp.google.com>
References: <20140707063342.3708.83493.chriscool@tuxfamily.org>
	<20140707063540.3708.51047.chriscool@tuxfamily.org>
	<xmqqsima7f3r.fsf@gitster.dls.corp.google.com>
	<CAP8UFD2X7j2TGEQfX3h8CfiZypJ5tVPqaZ2bNE0k1-jbeJj=Zw@mail.gmail.com>
	<xmqqr41t88dz.fsf@gitster.dls.corp.google.com>
	<xmqqegxt86ba.fsf@gitster.dls.corp.google.com>
	<CAP8UFD0_m5aFVcBQr3d9pXR=9rLjAVPGrj=UsBYFcnTQFwNKGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 16:22:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5bio-0000aF-1L
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 16:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060AbaGKOWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 10:22:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62857 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753509AbaGKOWk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 10:22:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 136B525E16;
	Fri, 11 Jul 2014 10:22:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GdK0OpurhOuEqy4AS4f56OwARhA=; b=NVonq8
	NfKKBAvNq00iQq1WNdqN/9tktMbEGkZ96ckxzIn70bSiWOSp7PBhh6Cpnof4O+hy
	JteLCjIkc7Zh8/LTrA+GNrMuMXM/yd3NL3e++L0FWgh3nQ/yOC9z4qTKzXTZd6MK
	ShxqHAS9Q6AWm2WvEhcNHrdacEt8AmW60zbQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dQEwr4ZihcxZTAkpEdBVO4T/HpH52jdb
	oCQYYlkI1gujNDq+Ux+mV/sLYj4dHU9YPasEBYH47PuP7pw7Ji/fL/2HwyAvilQp
	FGBEh6Db/GzHp/ptx9voCfjmtRnSBb+ce22u9xqBbM88hevxk8mlqNUOZeP3M5ql
	PA7yWGJ+4SA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0659525E15;
	Fri, 11 Jul 2014 10:22:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 72ECB25E0B;
	Fri, 11 Jul 2014 10:22:18 -0400 (EDT)
In-Reply-To: <CAP8UFD0_m5aFVcBQr3d9pXR=9rLjAVPGrj=UsBYFcnTQFwNKGA@mail.gmail.com>
	(Christian Couder's message of "Fri, 11 Jul 2014 10:59:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C3B03E94-0906-11E4-9AA7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253277>

Christian Couder <christian.couder@gmail.com> writes:

> On Thu, Jul 10, 2014 at 7:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>> "Making sure A's parent is B" would be an
>>> idempotent operation, no?  Why not just make sure A's parent is
>>> already B and report "Your wish has been granted" to the user?
>
> ... and here you say we should report "your wish has been granted"...

Normal way for "git replace" to report that is to exit with status 0
and without any noise, I would think.

>>> Why would it be simpler for the user to get an error, inspect the
>>> situation and realize that his wish has been granted after all?
>
> ... but for me reporting to the user "your wish has been granted" and
> warning (or errorring out) saying "the new commit would be the same as
> the old one" are nearly the same thing.
>
> So I wonder what exactly you are not happy with.

See above.
