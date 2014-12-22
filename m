From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/18] Offer a function to demote fsck errors to warnings
Date: Mon, 22 Dec 2014 15:15:53 -0800
Message-ID: <xmqqlhlz6zti.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<2a0c4cd4c5d3aaceff8a6ffa49d2f3597d26086d.1418055173.git.johannes.schindelin@gmx.de>
	<xmqqoarbidv7.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222232270.21312@s15462909.onlinehome-server.info>
	<xmqqfvc78hwq.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222330080.21312@s15462909.onlinehome-server.info>
	<xmqqy4pz71g7.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222348040.21312@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 23 00:16:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3CCm-0002EU-AY
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 00:16:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473AbaLVXP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 18:15:56 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55653 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753363AbaLVXPz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 18:15:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 07A5A295F2;
	Mon, 22 Dec 2014 18:15:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IY3WgKc6/LCl4iTWChm+oWQ9yJY=; b=Wc+Re9
	Su/7O/TKlJ9xE/WpFPFgyzkEvve1VveC3mcsmDrXABcF3pW1293IFWIflB0FiMQw
	XB6BGnYkmmS7fxzO5t4WTBBDqUl71L9p99ZNPfJ0zPWfNhM4XYKFt5N2Fm/nODzb
	tRcttB4+wao9YEkZfauxTM3D0zjqDgpLSiQiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yI+Ggou7uc0AQWYNFzKRGWRUFX6lVNQk
	S0Xi7/4e6nL2m6411QVE7186F+xnIhVvQfvO1U5AvYgrvRpAKK0yGH7DxILrdyv9
	9zH79F+fgQPvr1GOoyicpEbppSy0XxLOfXL7mhoWr+Wqf79qRt4oc4AkUDMQL8hI
	dZ3K5GIQsR0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F1DDE295F1;
	Mon, 22 Dec 2014 18:15:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6C236295F0;
	Mon, 22 Dec 2014 18:15:54 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1412222348040.21312@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Mon, 22 Dec 2014 23:55:16 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7A667FEA-8A30-11E4-B819-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261697>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> For example, try to spot the error here:
>
> 	...
> 	F(ALMOST_HAPPY, INFO) \
> 	F(CANNOT_RECOVER, ERROR) \
> 	F(COFFEE_IS_EMPTY, WARN) \
> 	F(JUST_BEING_CHATTY, INFO) \
> 	F(LIFE_IS_GOOD, INFO) \
> 	F(MISSING_SOMETHING_VITAL, FATAL_ERROR) \
> 	F(NEED_TO_SLEEP, WARN) \
> 	F(SOMETHING_WENT_WRONG, ERROR) \
> 	...

But that is not what is being suggested at all.  I already said that
FIRST_SOMETHING is fine as a measure to initialize, didn't I?

I am only saying that if you have a place to store customized level,
you should initialize that part with default levels and always look
it up from that place at runtime.  It is perfectly fine for the
initialization step to take advantage of the ordering and
FIRST_SOMETHING constants.
