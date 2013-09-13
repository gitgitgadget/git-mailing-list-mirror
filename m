From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Fri, 13 Sep 2013 13:01:41 -0700
Message-ID: <xmqqppscij8a.fsf@gitster.dls.corp.google.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 22:01:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKZYr-0006eq-AZ
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 22:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102Ab3IMUBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 16:01:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63290 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754173Ab3IMUBo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 16:01:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A84341634;
	Fri, 13 Sep 2013 20:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g1cTVrGWYq/r7WotZh9SorOBV5Y=; b=n+xuEI
	l32cege4nWq0TIM9Xhg//Zg5nbxCDvlAftrd3Vl9FW4hjgdGitQxqj2jHqUmnj9C
	a8DK/IGPVIHDZXpqcvSp0wSm8U5VYonjIWxrXTknNkOrAd4fjP2U1hWPE2Jzo4m2
	A+0PkLUTj802DYpGK0OVg//P3TurHEBHbK79A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fyCtNhIjPQ+Kuhgm5472+lhwX8xkiLAH
	/ADbKY4vPZ1XNoD3RQiYET657kGNtapl9waZ9k/87IK+6m1k2vuqD0Zbzwf+61ug
	zI1GZr4Wx7CWgrn8/PM+04eMx11OKIsXiq2Ar/9Zb+NHWWs1oUD4nhsF4m3n7H0I
	tM6rLsl+thE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BA8141633;
	Fri, 13 Sep 2013 20:01:44 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D6D541632;
	Fri, 13 Sep 2013 20:01:43 +0000 (UTC)
In-Reply-To: <CAHGBnuMNDJhAqNfgVRHRE-7R=UZbd+fMExYeKDWWCFjyQJYYTQ@mail.gmail.com>
	(Sebastian Schuberth's message of "Fri, 13 Sep 2013 21:53:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4FC7F574-1CAF-11E3-B9BD-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234767>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> I don't like the idea of introducing a compat/mingw/string.h because
> of two reasons: You would have to add a conditional to include that
> string.h instead of the system one anyway,

With -Icompat/mingw passed to the compiler, which is a bog-standard
technique we already use to supply headers the system forgot to
supply or override buggy headers the system is shipped with, you do
not have to change any "#include <string.h>".

Am I mistaken?
