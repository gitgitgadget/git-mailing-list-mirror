From: Junio C Hamano <gitster@pobox.com>
Subject: Re: propagating repo corruption across clone
Date: Wed, 27 Mar 2013 12:13:38 -0700
Message-ID: <7v7gksmza5.fsf@alter.siamese.dyndns.org>
References: <CAOx6V3YtM-e8-S41v1KnC+uSymYwZw8QBwiCJRYw0MYJXRjj-w@mail.gmail.com>
 <20130325145644.GA16576@sigill.intra.peff.net>
 <CACsJy8A0eOWEJ2aqPSLof_CodJM6BadFxQHy5Vb0kAwwTSTS3w@mail.gmail.com>
 <20130325155600.GA18216@sigill.intra.peff.net>
 <CAOx6V3a6vGJvJ4HEmAXdTRKKCzRJS23OYd_em1b3aQLzPNEtQA@mail.gmail.com>
 <20130325200752.GB3902@sigill.intra.peff.net>
 <CAOx6V3ZWB1ZpmXcaBeSaPOvHqmAMF3U1rTXuwinFGmEZQwFGYQ@mail.gmail.com>
 <20130326165553.GA7282@sigill.intra.peff.net>
 <1364340037755-7580771.post@n2.nabble.com>
 <7vr4j1qzao.fsf@alter.siamese.dyndns.org>
 <1364410309241-7580845.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rich Fromm <richard_fromm@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 20:14:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKvnW-0000Ph-RL
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 20:14:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090Ab3C0TNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 15:13:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39147 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754022Ab3C0TNl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 15:13:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06F0F9C9F;
	Wed, 27 Mar 2013 15:13:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/PEk49bWdKr1wFvqG/P4zawBtTo=; b=lHVpgK
	Nh99umm2Ef9BtQkA9wD61vALB3v3vkN255fuDA3wJWusmabtnDV3UHBrsVjOD1FY
	0TBCCKBE4Db5MpBs25fAe3w1YoBlXO5CLg4/qpnfDW9CPT25Cf4EnG7l6O9FhVNX
	HfiLHjN8Tbp2dNgqIx7aPXYlCrYHZALgOZtUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wNWUM0HQwjTWLPDhgHu1uUY5tVK5lY2B
	YcepLy5WZF7TSyL2kKG6ZLi17sFnWNvwp398OLrMhPzstZWN2ZEydMuvqD22Iwrl
	dzTTYSl/G6+XBQCN6tdLeth63BAnNNGo3ERTt13xhIccK7cGlKmcowWHV7FTA0FT
	7fbfbIHYyEY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFCE29C9D;
	Wed, 27 Mar 2013 15:13:40 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 546FA9C9C; Wed, 27 Mar 2013
 15:13:40 -0400 (EDT)
In-Reply-To: <1364410309241-7580845.post@n2.nabble.com> (Rich Fromm's message
 of "Wed, 27 Mar 2013 11:51:49 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6F17262A-9712-11E2-978E-B1692E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219307>

Rich Fromm <richard_fromm@yahoo.com> writes:

> Apologies if my questions are considered slightly off topic -- I'm not
> positive if this is supposed to be a list for developers, and not users.

The list is both for users and developers.

> However, I think there may be room for some additional clarity in the docs. 
> The --local option in git-config(1) says "When the repository to clone from
> is on a local machine, this flag bypasses the normal "git aware" transport
> mechanism".  But there's no mention of the consequences of this transport
> bypass.

Yeah, I would not mind a patch to update the documentation for
"clone --local" and rsync transport to say something about
byte-for-byte copying of broken repository.

Thanks.
