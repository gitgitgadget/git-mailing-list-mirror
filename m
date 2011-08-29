From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add a remote helper to interact with mediawiki
 (fetch & push)
Date: Sun, 28 Aug 2011 23:05:24 -0700
Message-ID: <7v4o1092hn.fsf@alter.siamese.dyndns.org>
References: <1314378689-8997-1-git-send-email-Matthieu.Moy@imag.fr>
 <1314378689-8997-2-git-send-email-Matthieu.Moy@imag.fr>
 <7v4o14dppz.fsf@alter.siamese.dyndns.org>
 <CAGdFq_iYRkfnTbYAgmX1g4uOxWb_ZYxr+TNinVfWRV-zXrnzAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Sylvain =?utf-8?Q?Boulm=C3=A9?= <sylvain.boulme@imag.fr>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 08:05:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxuyS-0005wf-6M
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 08:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764Ab1H2GF2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Aug 2011 02:05:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61742 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738Ab1H2GF1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2011 02:05:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B10E0204A;
	Mon, 29 Aug 2011 02:05:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bVkzORd3O+pa
	NX1Gt7hBB0zc5YE=; b=m/2TmVhM9yZ+yEVISTD4zIhyGR8H6ulg3mwRFUVx3w7R
	TJ9pi4nbBHSFElwXhg93W5pEfOiePdr/dPHYGpBGnNttJZYZbnba4PK8z8Zvbk3x
	OREC5qyXCRSLv0op4OTFGnyNbeRaRhJAet9m+f04jWyjNVu6egeZnC4F26di1dI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=axdlqN
	Sdws0jSW2D45DTyPfAuYH4BMNmKJmV8ZnhLX0eNH9h5OrDYdij+rGyel3lwiqZAM
	V9R11wghuFAxjyX/ye6z9ngk1QnDoiwuy16Wz9IASIcbZWA/WDr7Yy12Q73MLhN2
	OpK1Ay7Uyr5fe0OiLlFJhZJSjBIZRnC6Gs1lA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7BFA2049;
	Mon, 29 Aug 2011 02:05:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA5B62048; Mon, 29 Aug 2011
 02:05:25 -0400 (EDT)
In-Reply-To: <CAGdFq_iYRkfnTbYAgmX1g4uOxWb_ZYxr+TNinVfWRV-zXrnzAg@mail.gmail.com> (Sverre
 Rabbelier's message of "Mon, 29 Aug 2011 07:42:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E38F5E3E-D204-11E0-B92B-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180298>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> 2011/8/26 Junio C Hamano <gitster@pobox.com>:
>> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>>> In short, the changes since v3 are:
>>>
>>> * Adapt to newer Git, which seem to require a "done" command at the
>>> =C2=A0 end of the fast-import stream. I don't understand why this i=
s
>>> =C2=A0 needed, since fast-import is called without the --done flag =
by
>>> =C2=A0 remote-helpers, but if I don't do this, "git fetch" doesn't
>>> =C2=A0 terminate and keeps waiting ...
>>
>> Hmmmm, is this a regression in fast-import? Can this be bisected if =
so?
>
> We agreed that making this change is the best way to go forward, sinc=
e
> there's so few (read: none) remote-helpers yet, the fix is trivial,
> and it solves a design mistake while the api is not yet set in stone.

Does this exchange suggest that at least we would need an update to
documentation around "done", as Matthieu's "why is 'done' needed even
though I am not calling with --done?" sounds like a very fair question.
