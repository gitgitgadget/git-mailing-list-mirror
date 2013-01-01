From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] test: Add target test-lint-shell-syntax
Date: Tue, 01 Jan 2013 14:07:45 -0800
Message-ID: <7v7gnw8slq.fsf@alter.siamese.dyndns.org>
References: <201301012240.10722.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 01 23:09:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqA1a-0005jg-6s
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 23:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476Ab3AAWHt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jan 2013 17:07:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61310 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752448Ab3AAWHr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jan 2013 17:07:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68EE4A22F;
	Tue,  1 Jan 2013 17:07:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nH436VY87Gfp
	3lErqf7qf54OsnM=; b=gP6DXo+T1gXQSOu0Aw/bA+X8mopj+9JyNQuLugMpA4Vj
	u/utSdGaecDNvRuGREHDW/pltudclr8fV2GReYcM57f8JIcBFpRvNx5sdZLzFlpR
	AuP6jJxwRnwWLuvg4N4/c0TTBewnZ8YR5H/0w/afqfgQXKQJqmpvIDzRjlHm2gg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vzX6vJ
	b7zBHYuS8Dsie9qwFlNavOff7N+b+HhWqQJLQRVbgG/8YUgrwvQvJ9sRI4CKDW2c
	3vVUQRIZajhmsqitAwiSSWbsNWLu3bDJFOTNkvwgbVcaHLbUNlTvAQsClMkx/hpH
	Cf7mHA6qrt8GE9z7rmgkTOblvapi9gKKI3ohc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B49FA22E;
	Tue,  1 Jan 2013 17:07:47 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE588A22D; Tue,  1 Jan 2013
 17:07:46 -0500 (EST)
In-Reply-To: <201301012240.10722.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?= message of "Tue, 1 Jan 2013 22:40:08
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC93B1BC-545F-11E2-A3F9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212457>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Add the perl script "check-non-portable-shell.pl" to detect non-porta=
ble
> shell syntax
> Many systems use gnu tools which accept an extended syntax in shell s=
cripts,
> which is not portable on all systems and causes the test suite to fai=
l.
>
> To prevent contributors using e.g. Linux to add non-portable test cod=
e,
> "check-non-portable-shell.pl" is run as part of
> "make test" or "make in the t/ directory.
>
> "echo -n" is an example of a statement working on Linux,
> but not on e.g. Mac OS X.
>
> Beside "echo -n" we check for
> "sed -i",
> arrays in shell scripts (declare statement),
> "which" (use type instead),
> or "=3D=3D" (bash style of =3D)
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>

What it checks looks like a good start, but the indentation of it
(and the log message) seems very screwed up.

I also have to wonder what's the false positive rate of this.  When
you are preparing a new test, you would ideally want a mode that
checks only parts that you just added, without seeing noises from
existing violations and false positives from the part you did not
touch.  Otherwise, it will be too cumbersome to run for developers,
and the check mechanism will end up used by nobody.

> +####################################################################=
##
> +# Test t0000..t9999.sh for non portable shell scripts               =
 #
> +# Examples are "echo -n" or "sed -i"                                =
 #
> +# This script can be called with one or more filenames as parameters=
 #
> +#
> +####################################################################=
##

Just a style thing (style requests are not optional, though ;-), but
these box comments are moderately annoying to read and extremely
annoying to modify.  Writing it like this:

> +#
> +# Test t0000..t9999.sh for non portable shell scripts
> +# Examples are "echo -n" or "sed -i"
> +# This script can be called with one or more filenames as parameters
> +#

should be sufficiently loud.
