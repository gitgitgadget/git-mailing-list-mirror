From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSOC] Microproject "Move ~/.git-credential-cache to ~/.config/git"
Date: Mon, 14 Mar 2016 08:42:42 -0700
Message-ID: <xmqqshztawwd.fsf@gitster.mtv.corp.google.com>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 16:42:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afUdv-0000Lx-Bt
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 16:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934506AbcCNPmq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2016 11:42:46 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64876 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933015AbcCNPmp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Mar 2016 11:42:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 90D614A47A;
	Mon, 14 Mar 2016 11:42:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+WnWEgqwws1J
	wWbCpSZF2F2c8vw=; b=stYdtDd26MDk4VQsCiDDAsdpkiTAaOM+m0ESLCrnn8Ht
	2R9Eo3d41r5A81J+zEiHedssm3C8N+pMwHw5bS/ZytGu282J2D3P0298srDTnQjv
	S3tZkWQJt3OPsDzX/e+n6v9A1N4K/PICyZpSW08uIC2GngCSZWcihw4hSxMiW9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CdUfDZ
	BKS61/JzC4+PyzcSHHH6sYmEyzKTUTfHvQyWF2iqLAtbOvSqB09BTK2NWhVSeBCL
	QRpFiDHm+d3NHUbqRcKJKUG8HgGT24hNnocMlUnW99yKtxliKFehB0DReo8umYEL
	SZyJfoq5z7g5bo30F3W2XWOXwZzLNgpf77FRc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 88CB84A479;
	Mon, 14 Mar 2016 11:42:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 02E3C4A477;
	Mon, 14 Mar 2016 11:42:43 -0400 (EDT)
In-Reply-To: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
	(=?utf-8?B?IuaDoOi9tue+pCIncw==?= message of "Mon, 14 Mar 2016 22:47:53
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 64B42CFC-E9FB-11E5-BAA9-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288784>

=E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.com> writes:

> I'm still confused about following:
>
> 1. should `~/.git-credential-cache` been moved to
> `~/.cache/git/credential`(as the descreption of the micropject says)
> or `~/.config/git/credential`(as the title of the microproject says)?

The latter, I'd think, as you noticed in 2. the former does not make
much sense.

> 2. If `~/.cache/git/credential` is the desired target, there seems
> nothing to do with `XDG_CONFIG_HOME`.

Yes, I think the intent of the problem specification is "if it is
found in the XDG_CONFIG_HOME use $XDG_CONFIG_HOME/.config/git/* a
the location to place it; by the way if the user does not have
anything to explicitly say she wants to use a specific location for
XDG_CONFIG_HOME, it defaults to "~/.config, hence the Git specific
location becomes ~/.config/git/*".

> 3. Does "without breaking compatibility with the old behavior." mean
> that I should still try to connect to the unix socket placed at the
> old place? If yes, which order is prefered?

Let me be vague and oblique on purpose ;-)

We used to have only ~/.gitconfig as the per-user location, and at
some point in the history we added XDG_CONFIG_HOME support.  Study
how that was done (hint: "git log" and "git blame" may be useful
tools for this purpose), and imitate it.
