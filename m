From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: 'error: invalid key: pager.show_ref' on 'git show_ref'
Date: Fri, 06 Feb 2015 14:27:31 -0800
Message-ID: <xmqqk2zud6b0.fsf@gitster.dls.corp.google.com>
References: <20150206124528.GA18859@inner.h.apk.li>
	<20150206193313.GA4220@peff.net>
	<xmqq386ihk5w.fsf@gitster.dls.corp.google.com>
	<20150206203716.GA10857@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andreas Krey <a.krey@gmx.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 06 23:27:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJrND-0002Me-OD
	for gcvg-git-2@plane.gmane.org; Fri, 06 Feb 2015 23:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbbBFW1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2015 17:27:34 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53141 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751115AbbBFW1d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2015 17:27:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 083FD36D2C;
	Fri,  6 Feb 2015 17:27:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kFaqpVJW3HihyfTHNNPZcBPcyFE=; b=lGoEcy
	WTS+9jbw8onvrcOWCaGVHT1SZRYZxBxaE6GWqXmikU4BnuoUVOse6T5y9vpsVzZM
	le5LEYtsLlgDiBoCCG5ubRqPAmKLXrctgPsDFQNITI2GPyKu2ZKWHYHIMR511zJS
	g+Srxu/ljNa6NwO+ankQWHLzwdeJvTgZoPe+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZxFGaU/wZiybSdIlBzct2AVA/3YH9F5D
	SaGFP+v7p2yv6r5kwbCEvf0m2tfKUwC9xrMEQoKic4F4vtPwSHhk0/7N1y6UUnO8
	ibDPhlXI6nT/O1nFqKiSd2oFFPZjzPz1zg/rm36AfTmKOMFeeSPU4U8ZsHYOFx6u
	V93b79xavSo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F26B136D2A;
	Fri,  6 Feb 2015 17:27:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 777A836D29;
	Fri,  6 Feb 2015 17:27:32 -0500 (EST)
In-Reply-To: <20150206203716.GA10857@peff.net> (Jeff King's message of "Fri, 6
	Feb 2015 15:37:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 57B3E30A-AE4F-11E4-B9C9-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263432>

Jeff King <peff@peff.net> writes:

> A list of enum-like values where we are OK confining the names to the
> alnums is OK to use as an unbounded set of key values. Just like we have
> color.branch.*, we just pick a name within that syntax for any new
> values we add (and that is not even a burden; alnum names are what we
> would have picked anyway).

I would say that color.branch.<slot> names are very different from
subcommand names.  The latter is exposed to the end users who do not
have to know that they can be used and must be usable as config
keys.

color.branch.<slot> names were invented _only_ to be used to
interact with the config, and nowhere else.  Of course you can just
pick a name within that "syntax for configuration variables" and be
happy with it, because the users are very aware that they are using
that name to name a configuration variable.

The names of the subcommands are very different in that they are not
just for accessing configuration variables---if the user does not
have pager.<cmd>, the user will not use it as configuration keys
anywhere in the system.
