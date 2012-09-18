From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/4] make poll available for other platforms lacking
 it
Date: Mon, 17 Sep 2012 23:54:40 -0700
Message-ID: <7vehlzq0r3.fsf@alter.siamese.dyndns.org>
References: <004b01cd9519$ba991cd0$2fcb5670$@schmitz-digital.de>
 <7vmx0oqner.fsf@alter.siamese.dyndns.org>
 <000101cd9566$df8b8d00$9ea2a700$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Tue Sep 18 08:54:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDrhs-0007IE-S7
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 08:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357Ab2IRGyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 02:54:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64409 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752110Ab2IRGyn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 02:54:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A32942F9;
	Tue, 18 Sep 2012 02:54:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IzlqkWZbbAZjz7VvaVHjLAA8W2M=; b=ESSJJd
	m1Jv2XmKDp6c4BzKbsSsaiIWyldji/DZt8ppIpdk0b/Z+zEEFmpeuEhKJWlJc2/f
	hKP2/bpE+vnZsH/avlsat0TGzgmkDgKwJoUTaRprMMpsfgBJyf2HO9JFis/SyCpl
	Dzln7dtTorZ2FjaLgNWwbLS8BYFt/3TjkjGJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jBmWiaph2CcbKsFMJ9ep3GoBLSrTGmkg
	+vuR2bNB5M77B8tm+DQoJuDlpTO+DnAg/wO+fOdMMEVsMU8lo19t9qIdfYBaW3dn
	my0s9EGBudYN4OdqlxyzK3lDGZYbIA3Qbbf22F4BuXCmAEecsClUDuEudu09KYnf
	BqSLiJblIwE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECE2642F8;
	Tue, 18 Sep 2012 02:54:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4EE4D42F7; Tue, 18 Sep 2012
 02:54:42 -0400 (EDT)
In-Reply-To: <000101cd9566$df8b8d00$9ea2a700$@schmitz-digital.de> (Joachim
 Schmitz's message of "Tue, 18 Sep 2012 08:28:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9156426-015D-11E2-BF9E-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205800>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

>> > @@ -1605,6 +1610,11 @@ ifdef NO_GETTEXT
>> >  	BASIC_CFLAGS += -DNO_GETTEXT
>> >  	USE_GETTEXT_SCHEME ?= fallthrough
>> >  endif
>> > +ifdef NO_POLL
>> > +	NO_SYS_POLL_H = YesPlease
>> > +	COMPAT_CFLAGS += -DNO_POLL -Icompat/poll
>> > +	COMPAT_OBJS += compat/poll/poll.o
>> > +endif
>> 
>> I think my guesses above are correct, so will queue with the trivial
>> and obvious fixup.
>
> Well I was unde the impression that is <sys/poll.h> isn't
> available, there might be a <poll.h> and it that isn't available
> either we use compat/.../poll.[ch]. But rethinking your changed
> does makes perfect sense.

Heh, my comment was not about names between NO_POLL_H vs NO_POLL.
With the way you wrote the code, the symbols defined for Windows and
MINGW must match what controls the hunk around ll.1610, so what
makes perfect sense to you is indeed your code ;-)

> OK, so I guess I'm ready for the 'final touch', my NonStop
> specific changes, will post them shortly...
