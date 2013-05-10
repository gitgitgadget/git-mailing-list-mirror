From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] fast-export: add new --refspec option
Date: Thu, 09 May 2013 17:21:42 -0700
Message-ID: <7vobcj65wp.fsf@alter.siamese.dyndns.org>
References: <1368063095-22861-1-git-send-email-felipe.contreras@gmail.com>
	<1368063095-22861-3-git-send-email-felipe.contreras@gmail.com>
	<7vvc6r7pii.fsf@alter.siamese.dyndns.org>
	<CAMP44s2yoBFZU+LzHWT30ijbQ2rknmV1ZoB9qDDYvvme2chB7g@mail.gmail.com>
	<7v38tv7n5y.fsf@alter.siamese.dyndns.org>
	<CAMP44s1d_9iT7nqtu3gTy=kX-Kapnf0AUZJ-Z-MpLkBuWxBgSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 02:21:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uab5t-0004QD-1x
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 02:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756530Ab3EJAVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 20:21:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55054 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756477Ab3EJAVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 20:21:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68084134A1;
	Fri, 10 May 2013 00:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JGi81ofcR27RqzUtsywo2qhkIKY=; b=GJJM5I
	2w2eSrTZ0zlPP0odvEGc6G6Sw+MruZIrkU+lE8idxXw11ysWDsrEokX8Vkpemy2h
	S2GOQnLHQZ2Fbo7M7pykHztq5Vt54sKonlC82S2eMagLzTlXdMZUJmMlS9NtbQwx
	W2/2HDJOtA1mfhR1xHuBdSrDkuk/vgRaqvrmM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pwyHOj5Gw2judHMO+428Use2azXpZkss
	NqrahyQJFaMlNPXuZANm7F2tDMxtMlbwaVSb+xt6PY59XbTydrZYlqGvVlTc90zp
	C0bDhTsKIxmpbVqmejScuThkK1DmQta4MdrFis5/2bmGoGmtJ7ayGbWthyQWwofO
	+Prob+k7nPI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F19A1349F;
	Fri, 10 May 2013 00:21:44 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA9811349E;
	Fri, 10 May 2013 00:21:43 +0000 (UTC)
In-Reply-To: <CAMP44s1d_9iT7nqtu3gTy=kX-Kapnf0AUZJ-Z-MpLkBuWxBgSw@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 9 May 2013 18:32:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97E8A58A-B907-11E2-B7E7-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223807>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, May 9, 2013 at 6:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Simple.  You treat everything as refspecs and form revision ranges
>> out of them.  Note that that is exactly the reason why "git push"
>> can take "master" as a short-hand for "master:master" [*1*].
> ...
>> So I would imagine you would be spelling that as:
>>
>>     git fast-export master:new-master --not next refs/tags/*
>>
>> or something, no?
>
> rev-list doesn't accept 'refs/tags/*'.

I think you misunderstood.  That is meant to illustrate what your
end users feed "fast-export". "fast-export" in turn expands that
into a revision range, which needs to happen anyway when it strips
:new-master from the positive end of the range to make the range
into

	master ^next ^refs/tags/v1.0 ^refs/tags/v1.1 ...
