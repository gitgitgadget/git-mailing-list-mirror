From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Bug] git-log prints wrong unixtime with --date=format:%s
Date: Wed, 18 May 2016 09:21:34 -0700
Message-ID: <xmqqvb2bs5f5.fsf@gitster.mtv.corp.google.com>
References: <87vb2d37ea.fsf@web.de> <8760ucoaus.fsf@web.de>
	<20160518004008.GA20007@sigill.intra.peff.net>
	<20160518005824.GA7120@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Heerdegen <michael_heerdegen@web.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 18 18:21:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b34EB-0000b6-Ti
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 18:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbcERQVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 12:21:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61805 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751736AbcERQVi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 12:21:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 57BA61AE3F;
	Wed, 18 May 2016 12:21:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bpPnEG+23iOTaDSILhcHCXGDl+Q=; b=IekIzP
	Kpy9vV/wR9i2BZWbBG15FAZ1+9oR12HmxC4zu0sQfTBZU23UoWu1gfoQksEqP/le
	qGkp3eu7/m31UhGh3PwFHU2koydKKwfTth77bKIrB/iNJrY/Ue1r9zzPgHbtO2Gj
	tRLGV4H/+6tJntqnxhMrUOQs6lMXlYkfd+pEE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bKFCoNYen0RIxnaYTD7B8geNc3eakSK2
	srpXbycImfM9T3qtQi5y0AV6pkykfvUfB0+Y7QcebucRC4f4HXOhztb1oFlIAJdT
	JZnC1vSn0KGx7Sfd84VVD/B8qbRtunXfpJBY2nhOE1O+6a2Ppyc97WC7gyvN1uAs
	sqeW+QL+hRo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FBFB1AE3E;
	Wed, 18 May 2016 12:21:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BE73B1AE3D;
	Wed, 18 May 2016 12:21:36 -0400 (EDT)
In-Reply-To: <20160518005824.GA7120@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 17 May 2016 20:58:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 97FE5B54-1D14-11E6-A1F9-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294969>

Jeff King <peff@peff.net> writes:

> I tried a few obvious things, but couldn't make anything work. Setting
> "timezone" manually seems to do nothing. It's supposed to be set by
> putting the right thing in $TZ and then calling tzset(). So I tried
> munging $TZ to something like "+0200". It did have _some_ effect, but I

Wouldn't that be more like "UTC+0200"?

In any case, I do not think anybody wants to do tzset() on each and
every commit while running "git log".  Can we declare "format:<strftime>"
will always use the local timezone, or something?
