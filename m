From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/8] push: update remote tags only with force
Date: Mon, 21 Jan 2013 22:44:37 -0800
Message-ID: <7v1uddd8dm.fsf@alter.siamese.dyndns.org>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
 <DBF53EC2-A669-4B77-B88E-BFCDF43C862E@quendi.de>
 <7vsj61xez2.fsf@alter.siamese.dyndns.org>
 <7vobgpxeel.fsf@alter.siamese.dyndns.org>
 <CAEUsAPb0Zg0x78e+12NqXA4PRBkOUO89KTgxtwxujS1KOx9NYg@mail.gmail.com>
 <7vehhkuwg5.fsf@alter.siamese.dyndns.org>
 <CAEUsAPYAL6TD_nzu-YumRK_b-kFy7mNz1VivmSxGeuFYVxVL4g@mail.gmail.com>
 <20130118010638.GA29453@sigill.intra.peff.net>
 <CAEUsAPZr+bNNA-pqrQbBGvku4T3h58Ub66mK2zLeHqghEKw5Aw@mail.gmail.com>
 <20130121234002.GE17156@sigill.intra.peff.net>
 <CAEUsAPYaK3PP67fc89-J3a83wzYcmu7HRyh7y1Kctg6d166LEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Max Horn <max@quendi.de>,
	git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 07:45:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxXbR-0008JF-Ul
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 07:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346Ab3AVGok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 01:44:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46720 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942Ab3AVGok (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 01:44:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 938996F67;
	Tue, 22 Jan 2013 01:44:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VOycwNTz41zAxRcUmHE/qL3KdmI=; b=wA1Jjp
	Z3Jo9W5S5MbEO00t/C1po9MwTaWAFPk8e6OghgjydHMxdktUkPQm7JtVdCXl72oq
	EJAciYgtsrS9fdOQuvmGjzO+7iqw4VwGk1DNVSKmnNkSZd3b54ypv+nM51SHU9/u
	vNo2VZmVFr/BDxLl0iAFCDeNeji+gWWZKxULM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hji1W/UH4ZGZvWhOsIzn41XCF5LwCksR
	CiR8fE4bJAkY6xISHa9FAtlQ3gkRf4mgfBpt+Uxlc8Mk0AsJrrTUVwVQUXawiBvj
	V4NSgsPdGHX9KVdBPtYnXEUAp60waN0ZdOj2bakIz5gJdgDovULtKj6Z0J8httPL
	rPUfKOXw7fU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85AC66F66;
	Tue, 22 Jan 2013 01:44:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F027D6F65; Tue, 22 Jan 2013
 01:44:38 -0500 (EST)
In-Reply-To: <CAEUsAPYaK3PP67fc89-J3a83wzYcmu7HRyh7y1Kctg6d166LEQ@mail.gmail.com> (Chris
 Rorvick's message of "Mon, 21 Jan 2013 22:59:22 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31866A9A-645F-11E2-ACD7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214205>

Chris Rorvick <chris@rorvick.com> writes:

> I agree with everything above.  I just don't understand why reverting
> the "already exists" behavior for non-commit-ish objects was a
> prerequisite to fixing this.

Because it is a regression.  People who did not force such a push
did not get "already exists", but with your patch they do.

By reverting the wrong message so that we get the old wrong message
instead, people will only have to deal with an already known
breakage; a known devil is better than an unknown new devil (or an
unknown angel).

When a change that brings in a regression and an improvement at the
same time, it does not matter what the improvement is; we fix the
regression first as soon as safely possible and we then attempt to
resurrect and polish the improvement.
