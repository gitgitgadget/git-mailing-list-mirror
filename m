From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Mini bug report origin/pu: t1512 failed on Mac OS X (commit 
 957d74062c1f0e ?)
Date: Wed, 11 Jul 2012 16:05:21 -0700
Message-ID: <7vipdtdhla.fsf@alter.siamese.dyndns.org>
References: <4FFDDD5E.3080309@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jul 12 01:05:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp5yM-0004hZ-2v
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 01:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758420Ab2GKXFY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jul 2012 19:05:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57734 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754060Ab2GKXFX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jul 2012 19:05:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21235605E;
	Wed, 11 Jul 2012 19:05:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4L1N/DtVdoT+
	PKu1KslwXJ4mIPI=; b=aNs5akPjP6n/YPxKSCE9YqeOseUP29w3O0svs/r+poSl
	alBys1LZqhXUdCDN+0SRF04PwjVC5fiVpytnx5FG1lFfXgckS0E1/d5aRYe3YDLz
	+uUDgYMQjEXFzjPgYNg3DFrTDOH0RKSKgCRHrG21aF97J+GQpX9FyCdpDyI3GD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Qr2Kus
	ZHsy5pcm+oRpam2SOj498F8tf9V3Qd81ePB/fmeagF5l/OldvJYbzExiyPYF8Bt6
	VxN+lEzKxUT1phD0/3p7fh3dp5RpZks4nm1MiOxeRF6UUrIkkZljBbJqH9KOOBFs
	uQYXWYAIFD+905OeDw3nGvfAwjC88kaFLJmEo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16ABD605D;
	Wed, 11 Jul 2012 19:05:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8753A605C; Wed, 11 Jul 2012
 19:05:22 -0400 (EDT)
In-Reply-To: <4FFDDD5E.3080309@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Wed, 11 Jul 2012 22:09:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E47793DC-CBAC-11E1-8E2E-C3672E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201345>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> The following tweak will make t1512 work on my Mac OS box:
>
>
> --- a/t/t1512-rev-parse-disambiguation.sh
> +++ b/t/t1512-rev-parse-disambiguation.sh
> @@ -257,7 +257,7 @@ test_expect_success 'rev-parse --disambiguate' '
>         # commits created by commit-tree in earlier tests do not shar=
e
>         # the prefix.
>         git rev-parse --disambiguate=3D000000000 >actual &&
> -       test "$(wc -l <actual)" =3D 16 &&
> +       test "$(wc -l <actual)" -eq  16 &&

I think the other tests in t/ prefer to unquote it so that we would
ignore spaces around "wc -l" output, i.e.

	test $(wc -l <actual) =3D 16

Thanks for a report.
