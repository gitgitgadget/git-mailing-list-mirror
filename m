From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there a way to find out which commit "git rebase --skip"
 skipped?
Date: Thu, 16 Aug 2012 08:43:42 -0700
Message-ID: <7va9xu3kr5.fsf@alter.siamese.dyndns.org>
References: <CAE5ih78tYrX0F3AZ3vrE2p=_h24njhU_rTGEqbBHfJGkGuHmpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu Aug 16 17:43:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T22Ei-0002CL-0g
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 17:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757471Ab2HPPnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 11:43:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33687 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752731Ab2HPPnp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 11:43:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6929398E4;
	Thu, 16 Aug 2012 11:43:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OcBEqdh5RZbG40wUdS5O54kWP1A=; b=o9h8tg
	Pr76otiH9oIAr9nxbyoJJNKIbBh5jq7CUVEoRStr+g0UfaxmYZoHMbZQoBEJrIH/
	gQK7Tnvjbeyfxt5+dvrFHM5lwzAgSceMQZmRK0qAlENFqIvs23gAMkc0IlOITPgN
	JUZlk5hC/dCzvx4sLxzBqnFHOuLXplY/MqlnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hYe1UHc17BQJM8+f1nHtGCH63Wunzwwg
	8eY7cIk62SqmoD8KPZracHq5F4n2JNA266WqcBa7ex/4JS63H0O5Nsx4GC0zEXLp
	ZQ9G+0F/6EeY0c57Ns3BsxTs/xDhod0AvKQ2ZwfyTwhJaZPGukr9IlML3IrU72s8
	jAszlACN3NE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55DE898E3;
	Thu, 16 Aug 2012 11:43:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5ACF98E2; Thu, 16 Aug 2012
 11:43:43 -0400 (EDT)
In-Reply-To: <CAE5ih78tYrX0F3AZ3vrE2p=_h24njhU_rTGEqbBHfJGkGuHmpw@mail.gmail.com> (Luke
 Diamand's message of "Thu, 16 Aug 2012 07:59:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 28DA4286-E7B9-11E1-8AE4-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> If I do "git rebase --skip", is there a way to find out the commit SHA
> that was skipped (other than just parsing the output of the command) ?

There currently isn't, and I do not think it is doable in general
when the command ever gives control back to the user to futz with
the history, expecting the user only to fix up the conflict and make
a single commit (in which case you would want to say "that old
commit was replayed as this commit with different patch id) or say
"rebase --skip" (in which case you could record "that old commit was
manually skipped), but the user can do other things like resetting
the head to lose commits that have been rebased already, adding new
commits manually before continuing, etc., all of which will be done
outside of your control.
