From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] attr: support quoting pathname patterns in C style
Date: Fri, 05 Nov 2010 09:58:46 -0700
Message-ID: <7vvd4bu2pl.fsf@alter.siamese.dyndns.org>
References: <AANLkTinNctmWpshBeSTzZRm6+EJ=Cjdpoaj4Aon+52_b@mail.gmail.com>
 <1288878944-14066-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Marc Strapetz <marc.strapetz@syntevo.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 05 17:59:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEPdA-0000s8-Oj
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 17:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202Ab0KEQ67 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Nov 2010 12:58:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62947 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160Ab0KEQ65 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Nov 2010 12:58:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2C9FF2E92;
	Fri,  5 Nov 2010 12:58:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uf0BIgZ6LqIL
	qj8QH2mAjsZrrt0=; b=MDjsH+AjFwr/xwXTTLtUffas2DRlMYCvdRRuyAFrp3mT
	fd6ykxL3HDTm+XHLxv5o1aRB+Q2x5zCiiJqLav7abf+8OgvV8QPBZN5lkL8wt6io
	2BI7ubPiwkK9rbLP+K6RlG4yIB2/REeiMXrQhCTnrUoCexDI883pEHgEUm19UtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=l9I/Ak
	MvEinNHuSnpjU4kor7/tsq/M7CgfpvO7ARzcf5I2L5XgyBQZxmHzLO2mZxblNRuz
	IOxbcynIOqRIxYSFM/ZpsDV1lrQVjU7b+HKLfld+eYEtKdiIVPEoOGMFbJcBJDzQ
	U3S43LqOeeezzEt8gNhgg9Br0cLDZFHvRd6jU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E66552E8D;
	Fri,  5 Nov 2010 12:58:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 998012E8C; Fri,  5 Nov 2010
 12:58:50 -0400 (EDT)
In-Reply-To: <1288878944-14066-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Thu\,  4 Nov
 2010 20\:55\:44 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F929B5DC-E8FD-11DF-96B3-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160819>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Full pattern must be quoted. So 'pat"t"ern attr' will give exactly
> 'pat"t"ern', not 'pattern'. Also clarify that leading whitespaces are
> not part of the pattern and document comment syntax.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Obvious regression: patterns that begin with double quote will
>  now work differently.

I'm really hesitant to pursue this route and break people's existing
setups, especially if the only benefit this patch tries to achieve is t=
o
allow somebody to say:

    "Program Files/*.txt" ...some attr...

It is not worth the effort, risk and headache, especially because peopl=
e
with such paths are probably already using

    Program?Files/*.txt	...some attr..

to match them.
