From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] documentation: add git transport security notice
Date: Mon, 24 Jun 2013 15:35:19 -0700
Message-ID: <7vtxkn5e8o.fsf@alter.siamese.dyndns.org>
References: <1372069414-12601-1-git-send-email-frase@frase.id.au>
	<7vppvbbhoi.fsf@alter.siamese.dyndns.org>
	<20130624215733.GU2457@bacardi.hollandpark.frase.id.au>
	<20130624222703.GA32270@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fraser Tweedale <frase@frase.id.au>, git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 00:35:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrFM7-0000jE-EH
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 00:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101Ab3FXWfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 18:35:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41535 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990Ab3FXWfW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 18:35:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEB012BC03;
	Mon, 24 Jun 2013 22:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/JwNpEjUuD92XxU50Tiz+KPRtJk=; b=P2b4/v
	aZlpeqa1rnXY8RnVGZiAEAtCUxhkSLmCaew4FhW9QmBK+IoV3oGPz62MSEF3twx2
	5oZU7Ges0nzrqVD0S/VNi7TNgGEumJbzQkbiIwhmfynR/XgN9VqOEzCzeadWi5oX
	0uBs6392BVAB4d7Y+MYlFqSQfmV/4XKhw9AJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V31rt6nPWeDif8Q7tnsvpgnj1xEgzIRZ
	RPG1oYrN3+1b00ZndY/NrjnyN/mT82J5VBSnqIbzX3V7YMQVzmkbus1d77Q4Cjvm
	OXkPahtLYLnKRTOtjMqpH3IpvKCu8Z53N4RArNuByIy6oIKeYIr96cGv5nAKHLVd
	2/kx0XDGtLU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A45632BC02;
	Mon, 24 Jun 2013 22:35:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 155052BBFF;
	Mon, 24 Jun 2013 22:35:20 +0000 (UTC)
In-Reply-To: <20130624222703.GA32270@paksenarrion.iveqy.com> (Fredrik
	Gustafsson's message of "Tue, 25 Jun 2013 00:27:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A75A942-DD1E-11E2-9B37-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228915>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> On Tue, Jun 25, 2013 at 07:57:35AM +1000, Fraser Tweedale wrote:
>>  The git transport is insecure and should be used with caution on
>>  unsecured networks.
>
> I don't understand this. How is git:// insecure?
>
> It's protocol with no authentication, because it's a protocol used for
> public sharing.
>
> The only point of encrypt git:// would be to verify that the recieved
> data has not been altered along the way. However you can always trust
> that the end result is an valid copy of the remote.
>
> To me that means that it's as secure as a non-authentication protocoll
> needs to be.

If your DNS is poisoned, or your router is compromised to allow your
traffic diverted, you may be fetching from somewhere you did not
intend to.  As I explained in a separate message, that does not
necessarily result in your repository corrupting, but the result,
even though it may be "git fsck" clean at the bit level, needs
additional validation measure, such as signed tags, to be safely
used to base your further work on top.

> How would an "evil network" be able to do any harm to a git transport
> over git://?

Yes, strictly speaking, it may not be "transport being insecure",
but the effect on the aggregated whole is the same.
