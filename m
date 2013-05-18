From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] remote-helpers: tests: use python directly
Date: Fri, 17 May 2013 19:12:49 -0700
Message-ID: <7vwqqxujby.fsf@alter.siamese.dyndns.org>
References: <1368825008-2815-1-git-send-email-felipe.contreras@gmail.com>
	<1368825008-2815-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Torsten =?utf-8?Q?B?= =?utf-8?Q?=C3=B6gershausen?= 
	<tboegi@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 18 04:12:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdWdl-0001cG-1m
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 04:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755016Ab3ERCMx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 May 2013 22:12:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64231 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368Ab3ERCMw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 May 2013 22:12:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1018108D4;
	Sat, 18 May 2013 02:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=S/SsKshe+LEEanDZtmkNOXIZc
	Hw=; b=gAzQaI2AXGNOEjHPhkHcdAWVLlYOnQqxFnVX0CLpzShyOkcnj0+MWSelV
	j8H84nutJxYsfwgQPkJW4bj5MvlpU++IsJE+o9a6m2pc7tIw+VqbGDHy9b9cLccl
	nbp/k5QcIPKEC8BJFcaN9cUAoMt6kamjHVuNtMz2MNe6CzYY+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=fYbhk7y3C4jCWfOJ2Y7
	fwsXzZzPfkYrMTRccJXvM23oFPA3eYrmaWkwLVpZhZwbM2WIbt2EK/6qE/AKvwOI
	7H6YGxfNoh9PYS0OD6nAexMwnG9pr3bXw/fguNgKI4vXiKVrYvn3eGFdhXgEEz+E
	EdNSemy6x7QKD2q63xF2M6qM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3606108D1;
	Sat, 18 May 2013 02:12:51 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DDFEE108CD;
	Sat, 18 May 2013 02:12:50 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 71107B04-BF60-11E2-8069-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224751>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

> These remote helpers use 'env python', not PYTHON_PATH, so that's whe=
re
> we should check for the extensions. Otherwise, if 'python' is not
> PYTHON_PATH (e.g. /usr/bin/python: Makefile's default), there will be=
 a
> mismatch between the python libraries actually accessible to the remo=
te
> helpers.

What I am reading here is that what the "helper" uses and what the
"test" checks to see if it can use the "helper" were different; and
this patch fixes that misalignment by testing what the "helper"
actually uses.

So it is a right thing to do in that sense.

I however am having this nagging feeling that I may be missing
something subtle here.  Comments from others are very much welcome.

Will queue but the result will be on tomorrow's pushout.

Thanks.

> Suggested by: Torsten B=C3=B6gershausen <tboegi@web.de>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/test-bzr.sh       | 2 +-
>  contrib/remote-helpers/test-hg-bidi.sh   | 2 +-
>  contrib/remote-helpers/test-hg-hg-git.sh | 4 ++--
>  contrib/remote-helpers/test-hg.sh        | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-help=
ers/test-bzr.sh
> index 5dfa070..2c89caa 100755
> --- a/contrib/remote-helpers/test-bzr.sh
> +++ b/contrib/remote-helpers/test-bzr.sh
> @@ -12,7 +12,7 @@ if ! test_have_prereq PYTHON; then
>  	test_done
>  fi
> =20
> -if ! "$PYTHON_PATH" -c 'import bzrlib'; then
> +if ! python -c 'import bzrlib'; then
>  	skip_all=3D'skipping remote-bzr tests; bzr not available'
>  	test_done
>  fi
> diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-=
helpers/test-hg-bidi.sh
> index f569697..2c693d0 100755
> --- a/contrib/remote-helpers/test-hg-bidi.sh
> +++ b/contrib/remote-helpers/test-hg-bidi.sh
> @@ -15,7 +15,7 @@ if ! test_have_prereq PYTHON; then
>  	test_done
>  fi
> =20
> -if ! "$PYTHON_PATH" -c 'import mercurial'; then
> +if ! python -c 'import mercurial'; then
>  	skip_all=3D'skipping remote-hg tests; mercurial not available'
>  	test_done
>  fi
> diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remot=
e-helpers/test-hg-hg-git.sh
> index 8440341..fbad2b9 100755
> --- a/contrib/remote-helpers/test-hg-hg-git.sh
> +++ b/contrib/remote-helpers/test-hg-hg-git.sh
> @@ -15,12 +15,12 @@ if ! test_have_prereq PYTHON; then
>  	test_done
>  fi
> =20
> -if ! "$PYTHON_PATH" -c 'import mercurial'; then
> +if ! python -c 'import mercurial'; then
>  	skip_all=3D'skipping remote-hg tests; mercurial not available'
>  	test_done
>  fi
> =20
> -if ! "$PYTHON_PATH" -c 'import hggit'; then
> +if ! python -c 'import hggit'; then
>  	skip_all=3D'skipping remote-hg tests; hg-git not available'
>  	test_done
>  fi
> diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpe=
rs/test-hg.sh
> index 8de2aa7..ce03fa3 100755
> --- a/contrib/remote-helpers/test-hg.sh
> +++ b/contrib/remote-helpers/test-hg.sh
> @@ -15,7 +15,7 @@ if ! test_have_prereq PYTHON; then
>  	test_done
>  fi
> =20
> -if ! "$PYTHON_PATH" -c 'import mercurial'; then
> +if ! python -c 'import mercurial'; then
>  	skip_all=3D'skipping remote-hg tests; mercurial not available'
>  	test_done
>  fi
