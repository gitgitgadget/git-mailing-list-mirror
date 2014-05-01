From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add extra logic required to detect endianness on Solaris
Date: Thu, 01 May 2014 12:22:08 -0700
Message-ID: <xmqq1twdcnj3.fsf@gitster.dls.corp.google.com>
References: <1398930197-12851-1-git-send-email-cbailey32@bloomberg.net>
	<xmqqa9b1coml.fsf@gitster.dls.corp.google.com>
	<xmqq61lpcnpd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Charles Bailey <cbailey32@bloomberg.net>
X-From: git-owner@vger.kernel.org Thu May 01 21:22:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfwYj-0002Fo-1I
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 21:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbaEATWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 15:22:13 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53461 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbaEATWN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 15:22:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8D2C310550;
	Thu,  1 May 2014 15:22:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+LHORt6CeM/F9HPhA/1pA14x2OE=; b=oSkU75
	KvL3DEnUpQEriMN89i48HIMCWLsNH8pBZdhENMEQjoYiZyGobYMYTjFCtK+oaBOM
	h+UPN674RiP34N+pYgRwdaZLhMvqpM+vu3pVTCmTZBqV4+F91tolCT52gSUeqxkU
	Sv6S8TZaoqv9GtWkiqsMi0Ki5RWzPeBY9gs5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HufUXSPPUslKOIJBXIQVLAUnOumKBM2S
	LtZvhjXMbacLtKVEpboBzkAs5ssUSeQ/G7sJAfC35IxURDpKFFbgsVjuiPPhV+nX
	csnbjiq5Z1oDulHFxcPc5tVwIoHK0oJTWaTdiU5GfeQaBGLPMCSxgybbyawV3ony
	EZ6GDLPI9nk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 839001054D;
	Thu,  1 May 2014 15:22:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 24EC510546;
	Thu,  1 May 2014 15:22:10 -0400 (EDT)
In-Reply-To: <xmqq61lpcnpd.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 01 May 2014 12:18:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E43227F0-D165-11E3-B1A9-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247828>

Junio C Hamano <gitster@pobox.com> writes:

> Just a thought.
>
> I am wondering if you may want to go the other way around.  That is,
> instead of using "we have byte-order, big and little and the way to
> determine endianness is to see byte-order matches which of the
> latter two", use "there may be either big or little but not both
> defined, and that is how you learn the byte-order".
>
> And make these two macros match what Solaris happens to use.
>
> I am not sure which variant I like better myself, though.
> ...

The "how-about-this" patch in the pregvious message forgets the
default case where byte-order, little and big are defined with
leading double underscore, which must also be handled, if we want to
take this aproach.
