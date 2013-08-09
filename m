From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git should not use a default user.email config value
Date: Fri, 09 Aug 2013 16:06:16 -0700
Message-ID: <7v38qi4g7r.fsf@alter.siamese.dyndns.org>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
	<20130809194214.GV14690@google.com>
	<20130809223758.GB7160@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 10 01:06:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7vlT-00030v-Mx
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 01:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031528Ab3HIXG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 19:06:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36576 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031468Ab3HIXGT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 19:06:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C125432D3E;
	Fri,  9 Aug 2013 23:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1FlLOhWSFBR97CQlq/bihKZFb1w=; b=dpuBW1
	ZZWxdGEsUN3E84zL77BAwHrG9QIQimIbuZYX0Q5MvSKeqF0u380JKn8eZ87LqFZd
	02luHtnl83kWnBLiVeVsrDhXat/WHMsj7rrocQU0s9nqAyBULTJNsdVeDig5gzpl
	jVuzGirJUGuYMjZCPS3Le3eVo5/7DEe0h+Vyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VjdOtGym4HFFDvXpdomIN/9W4i/KAmvK
	nXqpdJq7gVA6uGygFdRfgvop4+QM+Z5me38tysKv/JcyYVY6snEfJvJeMevMoWCU
	iO5ru0b659PKusp/PhTralTHnb6eTxh4vo/1a490hstyf0q79s5mLGBi9hjHQqBm
	ppr1i+89V9k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF5BE32D3D;
	Fri,  9 Aug 2013 23:06:18 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05F9B32D3C;
	Fri,  9 Aug 2013 23:06:17 +0000 (UTC)
In-Reply-To: <20130809223758.GB7160@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 9 Aug 2013 18:37:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4C48D170-0148-11E3-8993-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232051>

Jeff King <peff@peff.net> writes:

> Yeah, there are basically three levels of ident:
>
>   1. The user told us explicitly (e.g., $EMAIL, user.email). Trust it.
>
>   2. We guessed and it looks reasonable (e.g., hostname is FQDN). Warn
>      but use it.
>
>   3. It looks obviously bogus (e.g., we do not have a domain name).
>      Reject it.
>
> We can move some cases from (2) down to (3), like ...

Judging from Thorsten's earlier response, I am afraid no amount of
autodetection would help the users of that site.  If we were to do
something, /etc/gitconfig as you outlined below would be the way to
go, even though it makes me feel dirty.

> Another option could to add an option to control the strictness. We
> usually have a chicken-and-egg problem here with individual installs
> (i.e., any person who could set "user.trustHostname = false" could just
> as easily have set "user.email"). But in an institutional setting, the
> admin could set such a config in /etc/gitconfig for everybody. Or for a
> system like Debian, the packager could include the option, knowing that
> any reasonably configured system should have /etc/mailname set up (which
> is not something we can necessarily count on for other operating
> systems).
>
> -Peff
