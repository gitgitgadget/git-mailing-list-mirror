From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] merge: warn --no-commit merge when no new commit is created
Date: Wed, 27 Apr 2016 09:02:20 -0700
Message-ID: <xmqq37q7avlf.fsf@gitster.mtv.corp.google.com>
References: <874mb0kkkk.fsf@gmail.com>
	<alpine.DEB.2.20.1604180825170.2967@virtualbox>
	<CAH5451kW3t1Y7oW=uHv85jzHwsnQcDK2jdLisauNF-x1LRwqLA@mail.gmail.com>
	<87a8krpehl.fsf@gmail.com>
	<CAH5451mDYhavx_OLfXe6cC2WguCsFWEBBBBOCPyX3E6ZJw27+w@mail.gmail.com>
	<xmqqy48a6fht.fsf@gitster.mtv.corp.google.com>
	<xmqqtwiy6end.fsf@gitster.mtv.corp.google.com>
	<xmqqd1pcdpb8.fsf_-_@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1604270846430.2896@virtualbox>
	<xmqqinz3axvc.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1604271732570.2896@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Christoph Paulik <cpaulik@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:02:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avRv2-0000ym-Uo
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbcD0QCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:02:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56062 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751798AbcD0QCY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 12:02:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D765F155FC;
	Wed, 27 Apr 2016 12:02:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z7pAzU1zjWm88T/NfqeHif5y+yg=; b=ri4JGH
	fhwD3LOGRBan3ueaheCKcMZ+Yuz84T5ti93F4cEJcIheP3FYpVLdexQNXxTsywRs
	NwO5ioepUEexdcZzTJin7P0Xb5T8RCKoHbKP3iFG5HEVih7ZrW5FnfUj9xTse0xG
	Y+kScVFaYiNRSKXE3MtxQEVDACbuuNZ86zi8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ff78fU+QJfj/9maPD+FQfh1QIBcH3jgI
	h0hVCcpIwft2sShXGwPinCme6NwFG4t2sBT49W0UybkfbzP7TksJsoWTQMJRokDU
	WAwcUTjK4WE5iT4TMyMOYzOt6fmIto6FYOMr1MvtgBUl010/27McaFdNqBcrpm7r
	Zumq7bnzLNM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD937155FB;
	Wed, 27 Apr 2016 12:02:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 32496155FA;
	Wed, 27 Apr 2016 12:02:22 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1604271732570.2896@virtualbox> (Johannes
	Schindelin's message of "Wed, 27 Apr 2016 17:37:04 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6D237C68-0C91-11E6-8D06-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292737>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > Maybe something like `disallow_no_commit`?
>> 
>> That would be the best name once we start dying in there.  It might
>> be still better, even while we merely warn but let it pass, than the
>> double negative.  Or it may not.  I dunno.
>
> Actually, I should admit that I was really puzzled by the name at first. I
> thought that some commits were impossible, but the function said that no
> commit was impossible. So I thought: but what if a commit references
> itself as parent, would that not be impossible? But actually, once SHA-1
> collision attacks become feasible, I guess it would not be impossible.
> Making for an excellent attack vector, say, on repository hosting sites
> (which would now be stuck in infinite loops due to a violation of the
> temporal prime directive).
>
> So yeah, this was my thought process when I read no_commit_impossible.

We both know that the original name was terrible now.  It was meant
to mean "it is impossible to honor --no-commit option", nothing
more, and left the door open for deciding what should happen when
that condition holds (either "warn but succeed the merge anyway" or
"die to refuse"), but it is clear that the name did not convey that
successfully.
