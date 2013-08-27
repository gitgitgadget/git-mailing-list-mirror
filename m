From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] core.precomposeunicode is true by default
Date: Tue, 27 Aug 2013 09:27:49 -0700
Message-ID: <xmqqhaebdrp6.fsf@gitster.dls.corp.google.com>
References: <201307270321.32398.tboegi@web.de>
	<7vmwp5z3iu.fsf@alter.siamese.dyndns.org> <521CAD88.4080609@web.de>
	<xmqqvc2rfau9.fsf@gitster.dls.corp.google.com>
	<521CC07B.4000504@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Aug 27 18:27:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEM7Z-0004DI-Eg
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 18:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257Ab3H0Q1x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Aug 2013 12:27:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56379 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751998Ab3H0Q1x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Aug 2013 12:27:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4712B3C2D9;
	Tue, 27 Aug 2013 16:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=e0rmgbbWVZtn
	r3bL0UaB7kPFNbA=; b=jioVpFwSr9Tz/usMdvYTh3EUE9+fGqqJ6cF9lBJZvH+0
	iFUePfzOOTW3ztyXGlHQdY3XK0NQMw6p8PZrbXitPv5L1mDvXhJMijSrEGWV8jw4
	hHuvQLDXAaSJQBp2tWznAuqVAzz+1LrQQW8GeJ2QwnW7NvxPX2GFluOTFbCrLQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=trUpRp
	PG+as8dno45GBdY++c3qkXjVqRtiawVD1PLOhyfwC8KvraWj4a4eUPda8biY78iD
	2YuLU7UXkx0yHe3RiiVaTnlrH0AFjcaFzfLa8GW6Xx1lu1db3bJplf13fKcU/9Xw
	I92mnDbTG59P3/KCWnKOfOqA0SljGEFo5DeJg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ABF23C2D6;
	Tue, 27 Aug 2013 16:27:52 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64B093C2D0;
	Tue, 27 Aug 2013 16:27:51 +0000 (UTC)
In-Reply-To: <521CC07B.4000504@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Tue, 27 Aug 2013 17:06:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9E44CCCC-0F35-11E3-BE25-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233110>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>>> 2)
>>> When we access a repo from Windows/Linux using SAMBA,
>> You mean s/repo/repository that resides on HFS+/?
> Sorry being unclear here, trying being clearer with an example:
> I have a /data/Docs on my linux box, which is handled by git
>
> I export /data/Docs via SAMBA, and use the Finder under Mac OS to hav=
e it
> mounted on my Mac OS X box:
> //tb@Linux/Docs on /Volumes/Docs (smbfs, nodev, nosuid, mounted by tb=
)
>>> readdir() will return decomposed.
>>> When the repo is created by nonMacOS, core.precomposeunicode is und=
efined.
>>> The precomposition is off, but should be on,=20
>>> precomposed_unicode =3D -1, but should be =3D 1
>> I do not think UTF-8-MAC is widely available; even if you flip the
>> bit on, would it help much?
> In the above example
> /data/Docs/.git/config was created by Linux, so it does not have
> core.precomposeunicode set, neither false nor true.
> The Linux box does not have  UTF-8-MAC under iconv,
> but will ignore core.precomposeunicode anyway (since the code is not =
compiled here)
>
> The Mac OS machine sees it under /Volumes/Docs/.git/config
> And here we want the precomposition, even if core.precomposeunicode
> is not present in the config.

It almost makes me wonder if you want not a per-repository but a
per-machine configuration, i.e. "Whichever repository I am
accessing, either on a local filesystem or shared over the network,
readdir() on my box reports wrong paths, and I need correction."

That, or "if it hurts, don't do the remote mount then."
