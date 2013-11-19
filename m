From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/86] replace prefixcmp() with has_prefix()
Date: Tue, 19 Nov 2013 13:42:29 -0800
Message-ID: <xmqq8uwk83wa.fsf@gitster.dls.corp.google.com>
References: <xmqq7gcdgvmf.fsf@gitster.dls.corp.google.com>
	<20131113.074703.1555957018827670255.chriscool@tuxfamily.org>
	<20131113071747.GA31251@sigill.intra.peff.net>
	<20131117.095200.299497690980619465.chriscool@tuxfamily.org>
	<CAP8UFD0HjJha7gF7h_S3Hb5ZSqOW0nfHW=G=P6gu0LZaN=hfRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Jeff King <peff@peff.net>, Andreas Ericsson <ae@op5.se>,
	git <git@vger.kernel.org>, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Max Horn <max@quendi.de>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 19 22:42:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vit4A-0003VV-5i
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 22:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267Ab3KSVme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 16:42:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59843 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812Ab3KSVmd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 16:42:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B10D0533A8;
	Tue, 19 Nov 2013 16:42:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9MlAtvOB8CxeC1ZQHxdzC9aIy+c=; b=B1L1Fr
	IGpT4Ia17K8VHhk/j3fliBG+OmYCcKDMGURitfA198rI+5xIudA64HZNFURNFbj6
	PEIttN5sm96Jd+Nr4ImysL38kTvHBaxNUhNaqQTxApZx5+g+9dAWaLfsO7id5vEX
	gyO8yOQnNzg8OKz+P4TsBfoRA84ZT+l50LqEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T0rW70tD15y8ty17SfvxP8frSju+mdDz
	HmYNR9icEikCDYffbZSP0pwYXQ2UptBGR+zB+trto+/kyHc+nJwp0b1GbbjT6h0w
	L/Auyod/iUptsw1qMZxmXs/WOiRUQNe6J8AWPA6SPuUX87sSOADE39nUVE6TzTyN
	gxg+iYOzhac=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B285533A7;
	Tue, 19 Nov 2013 16:42:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBA69533A6;
	Tue, 19 Nov 2013 16:42:31 -0500 (EST)
In-Reply-To: <CAP8UFD0HjJha7gF7h_S3Hb5ZSqOW0nfHW=G=P6gu0LZaN=hfRQ@mail.gmail.com>
	(Christian Couder's message of "Mon, 18 Nov 2013 11:42:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7E9E2FD8-5163-11E3-A36F-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238051>

Christian Couder <christian.couder@gmail.com> writes:

> There is also a new version of my 86 patch long series to replace
> prefixcmp() with starts_with() that I am ready to send, but I hesitate
> to spam the whole list :-)
> I can put it somewhere like GitHub where people can see everything and
> perhaps send only a few patches to the list, including the first and
> the last.
> @Junio, how would you like me to proceed?

Let's hold this off for now. The other half of this series is
already in 'next' and I do not want to bother with the "revert,
rebranch and remerge" dance this close to the 1.8.5 final.
