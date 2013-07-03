From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD] Making "git push [--force/--delete]" safer?
Date: Wed, 03 Jul 2013 12:50:20 -0700
Message-ID: <7vr4ffe83n.fsf@alter.siamese.dyndns.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
	<CALKQrgenpqKUxOZ+p79NsaQD9M2-q4h93ZqN0oencVo-QZF=zg@mail.gmail.com>
	<CALKQrgdovWTd50LVDnNR+BhurWgSCKkhr88wCo01VZF3sd5PNg@mail.gmail.com>
	<7vli5ogh8r.fsf@alter.siamese.dyndns.org>
	<CALKQrge_REZKfds0T-owJOn2BvfLmHpk7yQeSog=yvofE_zKJQ@mail.gmail.com>
	<CAF5DW8++sc2VYmdJEjbD_ue_wtDFj21vcyFzNWU0M+rAm2X0sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 21:50:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuT4N-0002kj-7g
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 21:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933081Ab3GCTuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 15:50:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58409 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932690Ab3GCTuW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 15:50:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DC732DB74;
	Wed,  3 Jul 2013 19:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AwDhkBr6SOyKQpPnZYmizeQMTkE=; b=qk4L9T
	+CiPTPClZTxnnvyU49NoQHZIM4qXvR7+q6K1H+HZLDVK+9o5Y7YJ63aTnjUb820M
	ByBdH9zsYx5F8H6L7hkLhSoGL8YuZMmQFW8fKneAn/IKDvmzpD0/nRO4TI2i0NpQ
	G0cPuS3pW1l/7GebPZrxw6GN5EijHHB0kXV2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YRcnoO8puNtg5InPhbR3KyVNP7BpOZuF
	lFFYTtNS4Z7lbJFtZmdBuKrF5DagDqMJimuAvkkLT/PGGbRK2scNEHOxlzOGZemT
	xkUqK+n8golUKaMjXSmq4pplZhXoX58Q0zkcapFgVo3DloHja0ZMnYszyk3zidQU
	cOBLKd1Z1KQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 636072DB73;
	Wed,  3 Jul 2013 19:50:22 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D17892DB72;
	Wed,  3 Jul 2013 19:50:21 +0000 (UTC)
In-Reply-To: <CAF5DW8++sc2VYmdJEjbD_ue_wtDFj21vcyFzNWU0M+rAm2X0sQ@mail.gmail.com>
	(Jonathan del Strother's message of "Wed, 3 Jul 2013 11:06:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBC74680-E419-11E2-9312-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229515>

Jonathan del Strother <maillist@steelskies.com> writes:

> I'm struggling to think of instances where I wouldn't want this
> CAS-like behaviour.  Wouldn't it be better to make it the default when
> pushing, and allowing the current behaviour with "git push
> --blind-force" or something?

Not until we run this in the wild for a while and the mechanism
proves to be useful without being too cumbersome to some population.

Then at a major version bump, we can start talking about enabling it
by default, allowing people to selectively disable it.
