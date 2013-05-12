From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-bzr: Do not use unportable sed "\+"
Date: Sat, 11 May 2013 20:14:24 -0700
Message-ID: <7vsj1svqi7.fsf@alter.siamese.dyndns.org>
References: <201305111525.53130.tboegi@web.de>
	<7vwqr5wdqm.fsf@alter.siamese.dyndns.org>
	<7vobchwbax.fsf@alter.siamese.dyndns.org> <518EA351.8000603@web.de>
	<7v8v3lwa5p.fsf@alter.siamese.dyndns.org> <518EAB7C.3010508@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: felipe.contreras@gmail.com, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun May 12 05:14:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbMkF-0000wm-3d
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 05:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548Ab3ELDO1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 May 2013 23:14:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58577 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754273Ab3ELDO0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 May 2013 23:14:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C65412E50;
	Sun, 12 May 2013 03:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LaCV9XCugHFp
	K2hAhLFpTVa3JY0=; b=ITWv+Sv7lkNJCuen4oCH/Nqfv6t4TuvcNUAbESoQNcRE
	Ha+TFlbQ6Ra79bJkZWAxN8R8O2DcsbdkAmnVztjcf732VRgSnkNBuK10tEmuGX8J
	9Da5+tZNn1XbFaw1srdIYEfW+El4y/KZ5/eF3WwjolCCAkhH00XvYdMHyX6ZOOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=S5UytC
	XB/6z11YrTEz9groA8yjhFfWEydPmLDAyTqBgwAIIRgbULrRvw7oOVUi/V1yIseG
	L77rPj+i+pyTTVUgtf246thiqTADc9XIgyv8+oYa3IflhDFkHD2sXqd+K8At/z+D
	i1nY3/dw/RG/taUH2aPrHCluUZcn4TG0K6uDs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E90D12E4E;
	Sun, 12 May 2013 03:14:26 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C05C912E4D;
	Sun, 12 May 2013 03:14:25 +0000 (UTC)
In-Reply-To: <518EAB7C.3010508@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sat, 11 May 2013 22:35:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0CE762B2-BAB2-11E2-8919-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224025>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 11.05.13 22:09, Junio C Hamano wrote:
>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>>=20
>>> I did,
>>> the interesting thing is that the test passes with and without your=
 patch.
>>> (After enabling  GIT_TEST_LONG and GIT_TEST_HTTPD in both cases)
>>=20
>> Strange.  Do you see differences between the produced packed-refs
>> file?
>
> The original version seems to look like this:
> :1 666527db455708922859283c673094002092910b
> :2 1e2acf73c6db881cfb1d56d67662e3d9260be2cf
> [snip]
>
> The "fixed POSIX version" follows that style:
> 666527db455708922859283c673094002092910b refs/tags/blablablablablabla=
blablablablablablablablablablablablablablablablablablablablablablablabl=
a-1
> 1e2acf73c6db881cfb1d56d67662e3d9260be2cf refs/tags/blablablablablabla=
blablablablablablablablablablablablablablablablablablablablablablablabl=
a-2
> [snip]

That means whatever the test that comes after that set-up step to
populate the packed-refs file does not need the packed-refs file.

In fact, the test only sees if "clone" succeeds, without checking
what refs are present in the resulting repository.  The original
repository lacks these 50000 tags due to the non-portable sed
construct (it has a corrupt packed-refs file) and it may or may not
have other refs, but because cloning an empty repository does not
error out these days, the test just passes.

Sloppy.
