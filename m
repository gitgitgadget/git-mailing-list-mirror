From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Make 'git request-pull' more strict about matching local/remote branches
Date: Wed, 22 Jan 2014 14:27:03 -0800
Message-ID: <xmqqsisfwt3c.fsf@gitster.dls.corp.google.com>
References: <alpine.LFD.2.11.1401221243090.18459@i7.linux-foundation.org>
	<xmqqwqhrwtoy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tejun Heo <tj@kernel.org>, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 22 23:27:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W66GT-00062d-Rx
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 23:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756033AbaAVW1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 17:27:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60562 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752213AbaAVW1L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 17:27:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A16CE65BC3;
	Wed, 22 Jan 2014 17:27:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yj218n6rh/w2pi8MwbZDbqM3Hrs=; b=yBb0Mc
	mcm1ugbdxb9e57Wyc1BFAyXaiI0HyhJfyEiwgKoXdA4TIAizN7Hg1myu8EibS4co
	viBzJvVk/6qy0Uq7b0TUua1NCPwh4T4jDGZXdkEAkEoOX1iUk4js0DVGFQ953GkZ
	tHwyZhNjSMstle81VwdfipMQqOr+3m1dLv2xg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TxsDJYE6snDxU4o/2xQcY7YCidWQtoLi
	oPySV0hQuTSUyaMHsm/IH0umJjA30ObhY4J7UaChaeDWtyu664Ef7+5WcLNhChL4
	KBaVSmeAHpn2SEUDfYDsuZCgojecF992jU54fTzunVTrAwTXHVF5xEWPwORdOiXo
	jiUi3jRbU+I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CB0E65BC2;
	Wed, 22 Jan 2014 17:27:08 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A626565BC1;
	Wed, 22 Jan 2014 17:27:07 -0500 (EST)
In-Reply-To: <xmqqwqhrwtoy.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 22 Jan 2014 14:14:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 53F11D1C-83B4-11E3-B251-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240869>

Junio C Hamano <gitster@pobox.com> writes:

> ... there is no 'for-linus' branch locally, so there is no way for
> him to say
>
>         git request-pull initial origin for-linus
>
> unless he creates it locally first.

In real life on the kernel list, for-linus may have to be a signed
tag, and pushed out 1-to-1 name mapping, so in that sense, "unless
he creates it locally first" may not be a problem.

I'd throw this into "No, this is not the only way to do so and there
are workarounds available if we suddenly tightened the rule and
broke those who relied on this behaviour. But this is not a less
good way compared to the alternative of creating the same-named ref
first, so we _are_ breaking people deliberately---is that worth the
safety for always-push-one-to-one people?" category.

I'd throw the other one (i.e. 5150.5) into "that is crazy enough
that a short apology in the Release Notes is sufficient before
breaking those who relied on that behaviour" category, on the other
hand ;-).
