From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff-tree does not use alternate objects for submodules
Date: Mon, 14 May 2012 09:49:28 -0700
Message-ID: <7v7gweiu7b.fsf@alter.siamese.dyndns.org>
References: <CAGHpTBLfbMU1WevW6XnY_N2BnfwPZ0_6jJDf45rCkVjWGwA9xg@mail.gmail.com>
 <7v1umuznuj.fsf@alter.siamese.dyndns.org>
 <20120509215815.GC74366@book.hvoigt.net>
 <7v1umtq9pm.fsf@alter.siamese.dyndns.org>
 <7vwr4lotjl.fsf@alter.siamese.dyndns.org>
 <20120513172301.GA58961@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Orgad and Raizel Shaneh <orgads@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon May 14 18:49:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STySm-0004a0-Ra
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 18:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754383Ab2ENQtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 12:49:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40480 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752586Ab2ENQta (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 12:49:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 485639742;
	Mon, 14 May 2012 12:49:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PPlOjRcOhA6T6HPItrcc4Y6+U9Q=; b=VA1Qrg
	HHi71UboE8G2IfrXRVRaEozTejd3er9D+YMEFREHsHXTOYTVE/RbrnkZfbfC12bw
	n1pN1EJWB1VQsKDi5jPLa8cRXn8uRK19aNDjlN/XQ5jSheHeA3Qv9/1bshE05UuL
	G+kv/Jcn/6WRANyBMYULXJTlvpSw5aZuE8JOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nKpQbWs4cbD5/VE6cDunjVm2IGdQuAAP
	0TPwO0slvB5OPY7lzSHv0W4u31eyibR0h0B4jP6g894VSudK4IJH9RP5vwweZ1cj
	F5DOh1ZqFuA5i34AtQD3X3rd7pnKiymHOPZAKZ3pEUiluPfvwTbdw0SfMLELZQQ3
	KglAk5U20Eg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FADC9741;
	Mon, 14 May 2012 12:49:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBA129740; Mon, 14 May 2012
 12:49:29 -0400 (EDT)
In-Reply-To: <20120513172301.GA58961@book.hvoigt.net> (Heiko Voigt's message
 of "Sun, 13 May 2012 19:23:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C609A430-9DE4-11E1-894B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197785>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> Here is the simplest approach I could think of (not sure if its maybe
> too simple). On first sight it seems to work (even if I exchange the
> absolute path in alternates with a relative one.

Conceptually looks very sound and trivially correct as long as the
objets_directory.buf is always absolute path (I didn't check, and I do not
offhand know if read_info_alternates() was designed to work when called
with a relative path in relative_base).
