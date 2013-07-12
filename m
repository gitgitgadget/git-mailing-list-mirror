From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] t4203: test mailmap functionality directly rather than indirectly
Date: Thu, 11 Jul 2013 23:25:35 -0700
Message-ID: <7vr4f4nvkw.fsf@alter.siamese.dyndns.org>
References: <1373554528-15775-1-git-send-email-sunshine@sunshineco.com>
	<1373554528-15775-4-git-send-email-sunshine@sunshineco.com>
	<7vhag0rk3u.fsf@alter.siamese.dyndns.org>
	<CAPig+cS7rxFzY8Q3gfTtJkggp-K62SVqsjCotbM3Bkm47L44gg@mail.gmail.com>
	<20130712005517.GA8482@google.com>
	<7v7ggwpbut.fsf@alter.siamese.dyndns.org>
	<CAPig+cSfqONOFmmXX=s+HWKnLr5eG27jU9xgE7Dki0sycPPz1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 08:25:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxWnW-0003TZ-SF
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 08:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869Ab3GLGZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 02:25:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35558 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616Ab3GLGZi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 02:25:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B5F32B93E;
	Fri, 12 Jul 2013 06:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z0qeooAC/DkKEZ43vKo9PqoyhtY=; b=OvokZl
	0exehcQ86ld1/iNX/lKaXQrA6sRlK0694q2ByHsMqVIiOQc2kLVSgzSKVm+ULiVy
	xMoTcC2ytNxE4p8Q+8SNiG1Dh8E9yFJm1bgcTeht/UDLcujoXKlVkjLWcZZXS5CD
	muIgM1d1b7E8bmNUJf8+7Aw0FgrGePRjGVdf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jckjy5duiReuWpST8xNCGVaWiVcBr7aE
	PlC/IcJ6Pabfruuudrhp5bQZ1tqzK8fgbSiMhElNzM2pTk6rIks06RBiqBAqrLwj
	ZfvYfbSgnI97UF7IQKu4gzhfsVbWc3/w0rG7Mk9TvLeOO4ViMSfrTvfFzTrztWpl
	QpEGMEQcgEA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F0482B93D;
	Fri, 12 Jul 2013 06:25:38 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6035B2B93A;
	Fri, 12 Jul 2013 06:25:37 +0000 (UTC)
In-Reply-To: <CAPig+cSfqONOFmmXX=s+HWKnLr5eG27jU9xgE7Dki0sycPPz1g@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 12 Jul 2013 02:05:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DDB66B16-EABB-11E2-BE63-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230174>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Jul 12, 2013 at 1:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>>> My current thinking is "no" --- the patch has as a justification "Now
>>> we can test these aspects of .mailmap handling directly with a
>>> low-level tool instead of using the tool most people will use, so do
>>> so", which sounds an awful lot like "Reduce test coverage of commonly
>>> used tools, because we can".
>>
>> Yes, that was exactly my reaction that prompted my response.
>
> Does any of my follow-up commentary result in a different
> reaction?

Not really.  While I _do_ think direct testing has merits, I think
that should be done by adding direct tests, not by removing the
tests that are meant to protect higher level _users_ of the
underlying mechanism from breakages.  After all, their breakages may
not come from new breakages of the lower level mechanism (i.e. the
mailmap.c code) but the way these higher level code makes calls into
the mechanism, and direct test of the lower level mechanism will not
protect them from the latter kind of breakages.
