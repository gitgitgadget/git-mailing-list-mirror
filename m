From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Wed, 07 May 2014 13:28:46 -0700
Message-ID: <xmqqvbth8ha9.fsf@gitster.dls.corp.google.com>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
	<536a83097302f_76ff7a52ec6c@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 22:28:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi8SV-0004kV-T0
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 22:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbaEGU2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 16:28:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51973 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866AbaEGU2v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 16:28:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1A44516CCB;
	Wed,  7 May 2014 16:28:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+Foqt/02uK0+dtCMYoT3fLT2b5o=; b=hLrBWr
	yW8xdpAvPzpbV1qqUSpZSuEJ9u1f7NucVRzbOJhzsEDdR59ChA369feSl7eMPf6h
	o5Wnprrpm6uVbWxCWOpLDbFahgeun2jBAW/mcfDupf6PCe94oGc4RCQHCVmSGIHN
	eColdvCAQWpmKEmgJGvSHqmjnv41o9UIUd2qI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uIIiz6msb2Hu0Zlnaj5ofy4Mp/wSNTZg
	91y5Pn+vT8BbUxlkdv3uWxl2De689i8F3SZG5qawqAtRQNNz33bBuoil+fTZvDZZ
	nlGKHPtLL5q6uxWqi20SZ1jyKTALejqsjpcv1SS6aj1fTkE/aM/O3BrK1tf8HKdU
	lxcCB1q1JMc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 105F216CCA;
	Wed,  7 May 2014 16:28:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6D2B016CC5;
	Wed,  7 May 2014 16:28:48 -0400 (EDT)
In-Reply-To: <536a83097302f_76ff7a52ec6c@nysa.notmuch> (Felipe Contreras's
	message of "Wed, 07 May 2014 14:01:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 31D817AC-D626-11E3-8022-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248359>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > Here's a bunch of tests more, and a fixes for Mercurial v3.0.
>> 
>> I think the discussion with John Keeping hints that we shouldn't be
>> rushing fc/remote-helpers-hg-bzr-graduation
>
> Really? Based on what reasoning? I have proven his reasoning to be
> basically wrong.

Perhaps s/proven/convinced myself only/; you didn't prove it to me
and I doubt you proved it to John.

>> For example, I see
>> 
>> 	from mercurial import changegroup
>>         if check_version(3, 0):
>>         	cg = changegroup.getbundle(...)
>> 	else:
>>         	cg = repo.getbundle(...)
>> 
>> and offhand it was unclear if the unconditional import was a
>> mistake.
>
> Of course it wasn't a mistake.

I doubt about the "Of course" part.  The first reaction after seeing
that the new "changegroup" is used only inside check_version(3,0)
and nowhere else was to wonder if that import is necessary (or even
safe) for the pre-v3.0 versions.
