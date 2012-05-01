From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb-lib.sh: Set up PATH to use perl from /usr/bin
Date: Tue, 01 May 2012 09:44:57 -0700
Message-ID: <7vwr4vam0m.fsf@alter.siamese.dyndns.org>
References: <201205011323.45190.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jnareb@gmail.com, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue May 01 18:45:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPGCN-0008Ku-B8
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 18:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228Ab2EAQpD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 12:45:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63090 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932170Ab2EAQpA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2012 12:45:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87AE37754;
	Tue,  1 May 2012 12:44:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xgIR9XVOyEgz
	uE0lEszLAQLQjMw=; b=uxbj/vAjgukCk+G9EJ7hbKHY1AVnDBB3IAkN3PQerilt
	hjMdLmVbekI7yzzfFE9XHbQvd86C+jSNTbRzsYXa4U0fg8nlAzjIWR2d64i84xRC
	QsAlHtCZILuAGBnC3GGobJ/R3+QYzG1yHcl8kPwtv0YMzAI2IRzl5TA13VzosoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BjD5Tb
	1E/w/bzhgF8+8qMl5Qddr48b9CGRu7umh9koktgrjaB6Yww3RtPpE35sQT0XQIu6
	bwRgMxOD4bEbczpiF3iu89KsPVMVLlL8YRhldVrWKsuuCBYRO2lM4D1O7NyuHak/
	aSB8XNH30Ukyl81axwtLdEXUGhCwdzQ5X0oJk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F4297753;
	Tue,  1 May 2012 12:44:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14F0C7752; Tue,  1 May 2012
 12:44:58 -0400 (EDT)
In-Reply-To: <201205011323.45190.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?= message of "Tue, 1 May 2012 13:23:44
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD49D8B2-93AC-11E1-84A2-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196692>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> When there are different version of perl installed on the machine,
> the $PATH may point out a different version of perl than /usr/bin.
> One example is to have /opt/local/bin/perl before /usr/bin/perl.
> ...
> diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
> index 21d11d6..a016142 100644
> --- a/t/gitweb-lib.sh
> +++ b/t/gitweb-lib.sh
> @@ -113,4 +113,7 @@ perl -MCGI -MCGI::Util -MCGI::Carp -e 0 >/dev/nul=
l 2>&1 || {
>  	test_done
>  }
> =20
> +PATH=3D/usr/bin/:$PATH
> +export PATH
> +
>  gitweb_init

This is wrong.

What makes you think /usr/bin always has saner version of tools than th=
ose
in the directories that the user explicitly listed earlier on her $PATH=
?

If anything it should be honoring $PERL_PATH that is set in the Makefil=
e.
