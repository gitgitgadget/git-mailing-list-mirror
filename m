From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] status: really ignore config with --porcelain
Date: Fri, 28 Jun 2013 13:15:09 -0700
Message-ID: <7vzjuam1pu.fsf@alter.siamese.dyndns.org>
References: <1372077912-18625-2-git-send-email-artagnon@gmail.com>
	<vpqhagnwraj.fsf@anie.imag.fr>
	<CALkWK0=F_i95S+53eZmOAJtA+jG=jvi5-sDc3BgW3rNQo=n3Ng@mail.gmail.com>
	<vpqhagnv9xq.fsf@anie.imag.fr>
	<7vk3ljbh5r.fsf@alter.siamese.dyndns.org>
	<vpq7ghjtpv1.fsf@anie.imag.fr>
	<7vk3lj9xwn.fsf@alter.siamese.dyndns.org>
	<20130628014011.GA620@sigill.intra.peff.net>
	<7v61wyrikr.fsf@alter.siamese.dyndns.org>
	<7vhagip25l.fsf@alter.siamese.dyndns.org>
	<20130628193104.GA12625@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 28 22:15:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Usf4i-0007g3-PD
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 22:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778Ab3F1UPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 16:15:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64819 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752728Ab3F1UPM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 16:15:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E19722CBF1;
	Fri, 28 Jun 2013 20:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ilQPV4Hb3Z1HBxB7rDboxPiV7vs=; b=YVE74L
	yopf7+MhOeqeEJ/J7iz9MxigE/19iTZ7Tewufx5OLAZ4e86Wy6Pd9WZHWuV3W3CJ
	99TLOxk6fw+lpYrzZxkl0maOy1G6OPC7kyBRiHUOrpj7eYuoCRxH//I2noZyOysa
	CAHdPUp6tBzt276nerTvqgw589nZ5p2YgGyek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r4sxvuTVPbRdD13+NO2SI8fJBu2iXKN8
	2U09k8cnd9G4/30xm3qcESMR7Du7KeJAueoSZwgWq0OrR7sWJZsbJa040UTRKsCd
	W7gx0vrubvf4VyFESYPSsg6s29hH+JAahxMWYlzYJPE5apfibEnaT1J4FidGu0uE
	hUvl8wHxlwg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4ED22CBF0;
	Fri, 28 Jun 2013 20:15:11 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 456932CBEF;
	Fri, 28 Jun 2013 20:15:11 +0000 (UTC)
In-Reply-To: <20130628193104.GA12625@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 28 Jun 2013 15:31:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6F7A99BA-E02F-11E2-9257-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229231>

Jeff King <peff@peff.net> writes:

> Hmm. I would have thought --no-short would just set it to LONG. That is,
> we are no longer NONE at that point, as the user has told us something
> on the command line. So we are whatever --no-short is, which is LONG.
>
> But I guess that would wreck
>
>   git status --no-short -z
>
> which currently defaults to porcelain. Which, to be honest, seems a
> little crazy to me, but I guess there is no reason to break it.
>
> I am just trying to prevent the future maintenance confusion where a
> reader of the code says "Huh? What is the difference between NONE and
> UNSPECIFIED?"

Yeah, I share your sentiment, but I did not think of a better way to
do this without unnecessarily changing behaviour.
