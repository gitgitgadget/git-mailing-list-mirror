From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/20] remote-bzr: split marks file
Date: Sun, 28 Apr 2013 11:47:19 -0700
Message-ID: <7v1u9usdag.fsf@alter.siamese.dyndns.org>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
	<1366938488-25425-13-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s2dzV428+_ZENg_Z5n=rnvqz1ZNAxnjsqCtLSJK-9PZZg@mail.gmail.com>
	<7v4nesvncw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 28 20:47:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWWdO-0001Ad-2L
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 20:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756270Ab3D1SrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 14:47:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37746 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756154Ab3D1SrX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 14:47:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2ABE1A7C5;
	Sun, 28 Apr 2013 18:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sLBP1swzU+GrPYXYXLL4Ty0yr7k=; b=k67PBd
	QFd6nzGNG8qhK2wKKKfeO9592lROAuKYyVfo9OoDVwhNxXl26HBcq3lvUcpdGbJN
	WjOXOi/uCPSlaavq/V1wDi02THBeNkUqKIVi8oj4XO84vIs71ADsBDsb9C1B8Tqv
	KD/JpXo/ToJ0gh1Lw4BR1MbumBYAJL4BG+lK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dIYQnbUCX4coclXFdmEPMrImvMs6nN5X
	HcL/afeR9fQTYSiWcg6IrYmKsIDO1OSXMw5cseFvBKuvkIfwYSfNhJsHj4Q9l5rA
	vN96LNlFZn36BxQPX9+OZj9G3f/8Qm1hVaz0DMwCLyAGBoEnsXwdLKORZH8rkiFg
	RI3DAUmoYog=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E96A11A7C4;
	Sun, 28 Apr 2013 18:47:21 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CFF41A7C1;
	Sun, 28 Apr 2013 18:47:21 +0000 (UTC)
In-Reply-To: <7v4nesvncw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 26 Apr 2013 17:17:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F362798-B034-11E2-AB63-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222740>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> And in case anybody is thinking that remote-bzr is really a too fast
>> moving target; even if this managed to land in 'master', it's likely
>> that people were not able to push at all, and in fact, many were not
>> even able to clone in 1.8.2. So, hardly could be considered a
>> regression. Nevertheless, I caught it in time.
>
> You didn't.  I am already way too deep into today's 1.8.3-rc0
> integration cycle and I won't waste a couple of hours work just to
> revert this.

Oh, I was lucky ;-) I mistook this with the other 9-patch bzr
clean-up series that I applied to 'master' for -rc0.

Pushing out a tagged-tip takes a lot longer than the normal tip
because a lot more than what people see have to happen on my end.

Reverting a single patch is simple, but we do not want to do that on
top of "Git 1.8.3-rc0" commit and move the unpublished tag to point
at the revert.

Which means pretty much everything needs to be redone (one example
among many is that the tagname will propagate to the htmldocs and
manpages repositories, so their unpublished histories need to be
rewound).

But I didn't have to do that in the end ;-)
