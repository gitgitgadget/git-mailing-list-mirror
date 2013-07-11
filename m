From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Corrections to the mailmap file
Date: Thu, 11 Jul 2013 10:33:15 -0700
Message-ID: <7vzjttq9wk.fsf@alter.siamese.dyndns.org>
References: <1372946659-10332-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 19:33:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxKkN-0005kI-K5
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 19:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134Ab3GKRdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 13:33:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53470 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477Ab3GKRdV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 13:33:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03E562FD94;
	Thu, 11 Jul 2013 17:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JVV+qCW/3EBSMPOqaiydqX9MvgY=; b=gZv3ZI
	bOPFBonMs0F2GVwVaQXgc/teFZ1CT4TQPNs6l1vLw1J4XjISwZXUsrcLZjMaA6Vv
	G4k19cOgYRWXVAbKvSyRbRLvKK2Lh6NVHm3LWZfA8BFSJ3GOfE053LOqtOyLoUkv
	m0/t/s7iAexGoCAd29GRW80fhbXX/w7Qju8NY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YQ4rxydBXWGm2Y3RsWyBFW6y3XI9C8zD
	UA2ltvPNxN3AA7XVUkMBw9fo7Eu2syxmpqDTRwT8VVrjTrJt6I5w4loEW5XDOI4c
	av+N5GNdRW6B/MdPhHxjx/YRUDZD7xdzezXCIxXlqrbxZ3gtaWevq8890yOl8IIQ
	qHyWfQiHcSI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECAFD2FD93;
	Thu, 11 Jul 2013 17:33:17 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 494612FD8E;
	Thu, 11 Jul 2013 17:33:17 +0000 (UTC)
In-Reply-To: <1372946659-10332-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Thu, 4 Jul 2013 16:04:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F8DCCEBA-EA4F-11E2-8C79-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230120>

Stefan Beller <stefanbeller@googlemail.com> writes:
>
> I noticed many duplicates in email addresses but having the same name by
> running:
>
>     # Finding out duplicates by comparing names:
>     git shortlog -sne |awk '{ NF--; $1=""; print }' |sort |uniq -d
>
> Most of these entries are most probably the same person, but we cannot be 
> sure, as there might be different persons having the same name, then they
> are only distinguished by the mail address.
>
> However I suspect most of these to be the same person, having changed 
> mail addresses.
>
> Here comes an initial batch of corrections to the mailmap file, which
> maps people with email addresses of different capitalization onto
> the same entity.
> (Example Name@MIT.EDU is the same as Name@mit.edu)
>
> I intend to contact each of the persons individually and ask whether 
> just their mail address changed, or if they are indeed different persons.

Has anything happen to this topic sice you posted?

I think:

 - .(none) is obviously bad, and we can fix without waiting for
   responses as long as we know the replacement address is the
   address from the list we usually see on the list (3).

 - Domain part is defined to be case insensitive (e.g. @mit.edu vs
   @MIT.EDU), so both forms are equally valid.  The owner of the
   address may have preferences (1 and 4), though.

   For this, we could just declare we downcase the domain part.

 - The local-part, even though RFC 2821 says "local-part of a
   mailbox MUST BE treated as case sensitive", is often case
   insensitive, and User.Name@domain and user.name@domain often name
   the same mailbox.  The owner of the address may have preferences
   (5 and 6), though.

   For this, we could just declare we Camel.Case the local part,
   after making sure Camel.Case@domain has been used by the owner of
   the address on this list.

So where does that leave us?

We can apply without waiting:

  1: downcase domain
  3: .(none) and we know paulus@samba.org
  4: downcase domain
  5: We recently saw Dshco calls himself <Johannes.Schindelin@domain>.
  6: The latest one from Nov 2009 uses <Toby.Allsopp@domain>.

The only possibly iffy one is Alex Riesen, but <raa.lkml@domain>
seems to be the one he uses here, so I think 2. is also fine.
