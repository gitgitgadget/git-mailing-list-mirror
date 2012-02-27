From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] parse-options: allow positivation of options
 starting, with no-
Date: Mon, 27 Feb 2012 12:48:12 -0800
Message-ID: <7vzkc457g3.fsf@alter.siamese.dyndns.org>
References: <4F49317A.3080809@lsrfire.ath.cx>
 <4F49332E.7070003@lsrfire.ath.cx> <7vy5rpcgrk.fsf@alter.siamese.dyndns.org>
 <87d390smpa.fsf@thomas.inf.ethz.ch> <7v8vjob3ff.fsf@alter.siamese.dyndns.org>
 <4F4BC3B3.7080000@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Geoffrey Irving <irving@naml.us>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Feb 27 21:48:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S27UZ-0005JR-PE
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 21:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789Ab2B0UsP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 15:48:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52622 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754015Ab2B0UsO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2012 15:48:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 527E965DD;
	Mon, 27 Feb 2012 15:48:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=13wRDHFVkuON
	3QquKKyLTxo6NFw=; b=iYlS9NhS3jN8rOYlyjdGunAKS+ClByHgWS9YUONaDEeL
	JycReO8rVpjaL+4KOnV5p8DYmQLwIMXmE6qxZKE4xljagGJoD2s3hdo5Fv6LvdVz
	oT4gcvH6/R1AXOOHBIIFr0dL6UuMrjoJ5YW7HUzyei7JSjGbNZgvO/O136aTUoo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fC19FE
	rOWmPJLzpTGK0Gpb/YfFJPq7meWdJkSOni81/Ppeqg+BBv8ie8nCllMmWhx9Ppqb
	/7ktJkV/YMghxFU2sVwlAragZM3iVU+BzKTW1cE0mlqVluhtG/frfObfwz3c5FHU
	xpWtJq+f20AA8nwRDKoBGi3jJ1n2hBtQAZzS8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4934965DC;
	Mon, 27 Feb 2012 15:48:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6DEB65DB; Mon, 27 Feb 2012
 15:48:13 -0500 (EST)
In-Reply-To: <4F4BC3B3.7080000@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Mon, 27 Feb 2012 18:56:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E01E5CE-6184-11E1-AF54-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191668>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> The patch does not forbid adding "no-" to an option that already star=
ts
> with "no-".  This stricter rule would be easy to add, but since that =
is
> currently the only way to negate such options, it would break backwar=
ds
> compatibility and thus should be added in a separate patch, if at all=
=2E
>
> With the patch, the following guidelines are followed:
>
> 	- "no-" means no, for both developers and users.
> 	- The user doesn't have to to say "no-no-".
>
> The results feels simpler to me.

Sounds fair.

I agree that the backward compatibility of --no-no-foo is a potential
problem, if any of the actions controlled by "--no-foo" option defaults=
 to
the behaviour when "--no-foo" is given.  Among the existing 13 that you
listed, I do not think there is any that tempts any existing user to as=
k
for negation with "--no-no-foo" form, so I think we should be Ok.
