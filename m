From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/12] refs: implement simple transactions for the packed-refs file
Date: Thu, 20 Jun 2013 11:36:36 -0700
Message-ID: <7vip18vdcb.fsf@alter.siamese.dyndns.org>
References: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
	<1371628293-28824-5-git-send-email-mhagger@alum.mit.edu>
	<7vfvwdzz6k.fsf@alter.siamese.dyndns.org>
	<51C2B41F.2050708@alum.mit.edu>
	<7vd2rgwvvd.fsf@alter.siamese.dyndns.org>
	<51C342B7.5050002@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 20 20:36:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upjiv-0004wA-1m
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 20:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087Ab3FTSgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 14:36:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55972 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758155Ab3FTSgj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 14:36:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E89E29D47;
	Thu, 20 Jun 2013 18:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vEt+1hCVlp3Qwz5jGidZqQ4Lipw=; b=FIevOl
	ffpzQdJ9HSJIkWXXCeBzVt7D81c5kcXt1pI1x8ScSfXjHeBSnVIVa5zvICYYAKmq
	tr4L8DrPIej/rRdTtiOmuJXVJZlLa2dgrpVCtuzkRBgASewQXcCrPMF4Ek7cJznw
	uVQDYyCwZrrxL5Y/0IiRx9Gw3MMJtR8hejLGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xjJX2KEYIzlEoZn/124XYR6gNxuKupl+
	Bh2eLydnawzwI87lDmEiW7aEgVSNiXiVjHPwExmV4FsdaWoSAYIAgqVdlIlKKOPN
	nea+gw7vvtqgcjW6J+oSn9XRA/zB3p14pZxiqr0MLDkFInIop0MpQlPUMFhLpBzt
	dEwykigSGRE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7169029D46;
	Thu, 20 Jun 2013 18:36:38 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E487429D42;
	Thu, 20 Jun 2013 18:36:37 +0000 (UTC)
In-Reply-To: <51C342B7.5050002@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 20 Jun 2013 19:58:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 578BA978-D9D8-11E2-9B62-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228520>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 06/20/2013 07:11 PM, Junio C Hamano wrote:
>
>> Perhaps I am missing something from the previous discussions, but I
>> am having trouble understanding the "main packed ref cache" part of
>> the above.  "main" as opposed to...?
>
> "main" as opposed to "submodule".

I see.

> No, the scenario would be that a git process wants to change a reference
> in a submodule directly, as opposed to starting another git process
> within the submodule, as I believe is done now.  Maybe it's too
> far-fetched even to consider...

Perhaps.  But the "singleton lock because we only handle main packed
ref cache" does not prevent us from doing so later, so I think v3 is
OK.

Thanks.
