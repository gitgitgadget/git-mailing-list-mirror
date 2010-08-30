From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3?] Add global and system-wide gitattributes
Date: Mon, 30 Aug 2010 01:04:10 -0700
Message-ID: <7vzkw4edc5.fsf@alter.siamese.dyndns.org>
References: <vpqy6bqr3ep.fsf@bauges.imag.fr>
 <1283020870-24888-1-git-send-email-Matthieu.Moy@imag.fr>
 <87fwxxhfpp.fsf_-_@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Petr Onderka <gsvick@gmail.com>,
	"Junio C. Hamano" <gitster@pobox.com>
To: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 10:04:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpzLx-0005Ea-Ls
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 10:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338Ab0H3IEY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 04:04:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37502 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528Ab0H3IEW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 04:04:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 49FA1D1AD3;
	Mon, 30 Aug 2010 04:04:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=z211+4OoPa8rFKSeVswdWvgsN
	G0=; b=P2MAxp5jlehR5uXp+u2D/ckO0SjA4hK5joPgX0al43E/PUl01DxSOGXc7
	FXRpo0JcpNLaOWjkvH/tKsxsK6E2lenqoSkN4yu+xIf51x26+65mbb40ttQqO5Km
	8VNonExkIJ29jmPkvF+V+tPxXT7a+crNkzKFxFT4heeqRv6lxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Q35Of33+QpNUtYNxvhY
	ldmFEV/QsNVlZ7V8HN6LmsQpsA4HveP1e4s4LZWF1T9GwPth5LDo+M7Kx2so/L+w
	AiUFKAOkOvtTcl9qomAqmSBlBLQF1ULdTx27vWTYwV50TDgdV+yUf+pZvuNyX4ef
	FpvC9nZXPgJOJ7Pk6xDnlPYs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EE553D1ACC;
	Mon, 30 Aug 2010 04:04:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8239D1ACA; Mon, 30 Aug
 2010 04:04:11 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3020E112-B40D-11DF-A404-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154775>

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com> writes:

> Thanks, Matthieu!
>
> Petr's original patch doesn't apply cleanly due to a bogus context li=
ne
> after a recent change in Makefile. For convenience, below is the upda=
ted
> patch including Matthieu's changes applicable to current master.
>
> And FWIW (I didn't try to build the documentation, though):
>
> Tested-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>

Thanks, but this seems to break t8005 for whatever reason.

> diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
> index 53bd7fc..7fe3b49 100755
> --- a/t/t0003-attributes.sh
> +++ b/t/t0003-attributes.sh
> @@ -15,6 +15,7 @@ attr_check () {
> =20
>  }
> =20
> +HOME=3D$(pwd)

I see a few tests here and there that uses the test-trash directory as
HOME; perhaps we should have done that in test-lib.sh to make our life
easier?
