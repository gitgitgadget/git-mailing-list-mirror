From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/5] push: update remote tags only with force
Date: Thu, 15 Nov 2012 08:50:56 -0800
Message-ID: <7vzk2i95e7.fsf@alter.siamese.dyndns.org>
References: <1352693288-7396-1-git-send-email-chris@rorvick.com>
 <7v4nktdwtp.fsf@alter.siamese.dyndns.org>
 <CAEUsAPYvrR6WsVWCvwoEWA21gzL6Sib0sTyx-c_2tH=8ni69yQ@mail.gmail.com>
 <CAEUsAPZtF-L5J_g1L5d44BKveoAnJ81PatX94fFS4FM=iW33KA@mail.gmail.com>
 <7v390ccoak.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9DAwaLw2bTqj5x_zxRcFqn7s=nmGi=Jc_SD38vFoszBZg@mail.gmail.com>
 <7vmwykay4n.fsf@alter.siamese.dyndns.org>
 <7v8va3afrt.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9DK9AWBe_cf6=-v0pyD9xdhSoYPsKmRnUOwjuAm=hewfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Rorvick <chris@rorvick.com>, git <git@vger.kernel.org>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 17:51:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ2ep-0000ui-LD
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 17:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1768429Ab2KOQvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 11:51:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60575 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768379Ab2KOQu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 11:50:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8BF8A045;
	Thu, 15 Nov 2012 11:50:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UoSs6aE6DAFT+mK32IPkJuC+Fbs=; b=nNWa6U
	0u8B6fcCzV/VWx2JxAuOcHYAwKWMNk4nh+Wf2lZNUuIkf0yM4humv5rGR3lReXxk
	FQGzJwdLzbPjgI6EX3u58Z0NbxVT6guFNHRQ7eflnt4H0jxRH8wSiReesU5r+Bcd
	gxoxf+y0mQXO3BmZS+fHhrRP4uSqiu/rjTj5E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rAC9fhwhl3xBNjqF8f+AtvAVOyOZhApn
	fRPKRPi9agiM414N1ClSbhP4a8qcYuZMpUlECa2fgY4zjNZavas0vk9MFYBe6K2b
	9IZq83zpIGKJzGHlWRpsldmdNYdbU36JONZTQzEj9Q0SCuGTeIPJeRPWUoa8dwlI
	t74Lyo27JBM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4770A044;
	Thu, 15 Nov 2012 11:50:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10882A041; Thu, 15 Nov 2012
 11:50:57 -0500 (EST)
In-Reply-To: <CAB9Jk9DK9AWBe_cf6=-v0pyD9xdhSoYPsKmRnUOwjuAm=hewfA@mail.gmail.com> (Angelo
 Borsotti's message of "Thu, 15 Nov 2012 08:48:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1101686-2F44-11E2-B469-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209830>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

>> I am *not* convinced that the "refs/tags/ is the only special
>> hierarchy whose contents should not move" is a bad limitation we
>> should avoid, but if it indeed is a bad limitation, the above is one
>> possible way to think about avoiding it.
>
> What other hierarchy besides branches and tags is there? Do you have
> in mind some other that should not move?

People use their own hierarchies for various purposes that are not
pre-defined by git-core, e.g. refs/changes/, refs/pull/, etc.
Depending on the semantics the projects want out of these
hierarchies, some of them may well be considered "create-only".
