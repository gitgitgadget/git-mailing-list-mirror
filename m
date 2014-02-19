From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Tue, 18 Feb 2014 16:10:41 -0800
Message-ID: <xmqq4n3warni.fsf@gitster.dls.corp.google.com>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
	<87r470ssuc.fsf@fencepost.gnu.org>
	<CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
	<87ioscsoow.fsf@fencepost.gnu.org> <20140218155842.GA7855@google.com>
	<xmqqzjlocf28.fsf@gitster.dls.corp.google.com>
	<CACsJy8AEXP45K+r3gGVTWbn4uuPLeHOkf-an20rj77QSfG1-ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, David Kastrup <dak@gnu.org>,
	Christian Jaeger <chrjae@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 01:10:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFukT-0005S5-H7
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 01:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbaBSAKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 19:10:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35003 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643AbaBSAKo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 19:10:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CC346E919;
	Tue, 18 Feb 2014 19:10:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ri3GCJSG+f8RG0f2fQ8Ch8up61U=; b=n6oXPV
	fyhjp0jHLNEf/6kRkPy6UkNTNosnhOt/crvSMTKzD8A4dM67oqXreYzzt2V8FTIQ
	UTCrboGFlscfHTJKKafDkCroWeb6G8h7rb/Hsx/ov7YGSEqVK8FNiCqPEEWgvFRk
	xI2q/aQoxpc+g1E/fBKoDK75qWzmR4EVb+u30=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bh4rZskQ4TdOFo9KAWTC8TlibUOx3+e3
	adl5UaY91zRhq4gLfMZlJ1038+acahajUJsnn8+qxeQEnt/MeMLfg12FlcpKuSrg
	d/1wXAMqfxBj+KzO4EYo+LM9iy52hSK65cUdxVytl3jYDcieG1FfyMj+tiECILlx
	MqQgfT4fb4k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0006D6E917;
	Tue, 18 Feb 2014 19:10:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 389F36E914;
	Tue, 18 Feb 2014 19:10:43 -0500 (EST)
In-Reply-To: <CACsJy8AEXP45K+r3gGVTWbn4uuPLeHOkf-an20rj77QSfG1-ew@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 19 Feb 2014 05:46:10 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 45DA3AF0-98FA-11E3-A297-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242377>

Duy Nguyen <pclouds@gmail.com> writes:

> Lower depth than default (50) does not sound "aggressive" to me, at
> least from disk space utilization. I agree it should be configurable
> though.

Do you mean you want to keep "--aggressive" to mean "too aggressive
in resulting size, to the point that it is not useful to anybody"?

Shallow and wide will give us, with a large window, the most
aggressively efficient packfiles that are useful, and we would
rather want to fix it to be usable, I would think.
