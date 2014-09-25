From: Junio C Hamano <gitster@pobox.com>
Subject: Re: project wide: git config entry for [diff] renames=true
Date: Thu, 25 Sep 2014 11:43:27 -0700
Message-ID: <xmqq61gbbkxc.fsf@gitster.dls.corp.google.com>
References: <Pine.LNX.4.44L0.1409241106100.1580-100000@iolanthe.rowland.org>
	<1411591401-5874-1-git-send-email-sojka@merica.cz>
	<1411591401-5874-4-git-send-email-sojka@merica.cz>
	<20140925150353.GA15325@kroah.com>
	<1411660111.4026.24.camel@joe-AO725> <20140925180005.GA11755@peff.net>
	<1411668391.3460.2.camel@joe-AO725>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Sojka <sojka@merica.cz>, linux-usb@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Bryan Wu <cooloney@gmail.com>, Felipe Balbi <balbi@ti.com>,
	Linux LED Subsystem <linux-leds@vger.kernel.org>,
	linux-kernel@vger.kernel.org, michal.vokac@comap.cz,
	git <git@vger.kernel.org>
To: Joe Perches <joe@perches.com>
X-From: linux-leds-owner@vger.kernel.org Thu Sep 25 20:43:33 2014
Return-path: <linux-leds-owner@vger.kernel.org>
Envelope-to: gll-linux-leds@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-leds-owner@vger.kernel.org>)
	id 1XXE0r-000102-8s
	for gll-linux-leds@plane.gmane.org; Thu, 25 Sep 2014 20:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbaIYSnc (ORCPT <rfc822;gll-linux-leds@m.gmane.org>);
	Thu, 25 Sep 2014 14:43:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64496 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752317AbaIYSna (ORCPT <rfc822;linux-leds@vger.kernel.org>);
	Thu, 25 Sep 2014 14:43:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 746003BF99;
	Thu, 25 Sep 2014 14:43:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ezpe11bc5yBx2OlzWQMyFOuzyGY=; b=q42xO0
	Zt1TNCQ9GbRK8IIQpkWuEgHS2YEu1oh3bYpd4KiOmkyFdUuZOhfIb4aaY7zfMy08
	ZvfOxK3/sNgqfnY+cgjoO28jWcp3YvzMLwZzmZNl55ezR+HJ5trWU2zSAULendRi
	V9vbINXWIS1BXhMDOr4Y39sm2m2Bk8vcAJvLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=veiBmq75pEupTUQNdp6QH/vYDCWLdXKh
	/SLjjRfmZtZXBMr0ogFinqlaf36JZs5V3CamhmPaSE8cpj3Bh6g52Nmz0a//JTL9
	MlUPJSrY7ke2FvfRBhdIUTFdl0QzWNydpVBqQRX+qMcPb9LeVmiK5C9hIQlioLav
	FTw4NJOeARw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5C6EF3BF98;
	Thu, 25 Sep 2014 14:43:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C17AA3BF97;
	Thu, 25 Sep 2014 14:43:28 -0400 (EDT)
In-Reply-To: <1411668391.3460.2.camel@joe-AO725> (Joe Perches's message of
	"Thu, 25 Sep 2014 11:06:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D752EABE-44E3-11E4-98C7-D931C4D60FE0-77302942!pb-smtp0.pobox.com
Sender: linux-leds-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-leds.vger.kernel.org>
X-Mailing-List: linux-leds@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257491>

Joe Perches <joe@perches.com> writes:

> On Thu, 2014-09-25 at 14:00 -0400, Jeff King wrote:
> ...
>> diff.renames is probably safe, but any config-sharing mechanism would
>> have to deal with either whitelisting, or providing some mechanism for
>> the puller to review changes before blindly following them.
>
> Another mechanism might be to add a repository
> top level .gitconfig and add whatever to that.

That could be smaller half of an implementation detail of one of the
two possibilities Jeff mentioned i.e. "mechanism for the puller to
review changes before blindly following".  It gives the transfer
part.  You still need a new mechanism to make that file that is
tracked in the repository to be used as part of your configuration
variable set after letting the puller to review and approve.

A puller who blindly trust the project could use the "include"
mechanism from your .git/config to include a file with a well-known
name that is tracked by the project _without_ review or approval.  I
doubt we would recommend that in an open source setting, though.
