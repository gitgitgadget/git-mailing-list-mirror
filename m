From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/7] t0027: Add tests for get_stream_filter()
Date: Mon, 08 Feb 2016 09:59:38 -0800
Message-ID: <xmqq60xz9j79.fsf@gitster.mtv.corp.google.com>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
	<1454688800-20714-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Mon Feb 08 19:03:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSq9N-0005Kp-9F
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 19:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbcBHSC5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2016 13:02:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61204 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932468AbcBHR7k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2016 12:59:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 09DD241C5A;
	Mon,  8 Feb 2016 12:59:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=h12d/RfozEG6
	U5UF1XFaiW4pyhI=; b=c8wE9hrfcmxuEFgZycgU7xMyB978UG9Yz6WMePge+ayQ
	uZKfidhcFOmh5uBMmhOONnalarbN8iW3RA65nsjKV6VzyzxQeetm2gvFs3yc+lVX
	V/nPapwZtPqepGLcssWFuLhKuccWr9rs/GZyzqlbOLKWnV7kE5JOAyOcrg8yarg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cK2twa
	9RT70y8wexY5/zVL84DMMq8IWR9Rc++tgTzies33jDCFaQPygQVNOIfYMcXBJPjB
	t0EzANuHBMa0NCalGPUxmSpP/Fk4Yi3VbchkS7h9eSJ3UyJzes/epEJxxFHXZ9oJ
	79UKRPHcGuz6qAYVp/ONtMXRiAztfZ3R0jCW8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 004A341C59;
	Mon,  8 Feb 2016 12:59:40 -0500 (EST)
Received: from pobox.com (unknown [104.133.3.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 67C2841C58;
	Mon,  8 Feb 2016 12:59:39 -0500 (EST)
In-Reply-To: <1454688800-20714-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Fri, 5 Feb 2016 17:13:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B90385DE-CE8D-11E5-8465-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285786>

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
> Subject: Re: [PATCH v3 1/7] t0027: Add tests for get_stream_filter()

s/: Add/: add/ (no need to resend this)

> When a filter is configured, a different code-path is used in convert=
=2Ec
> and entry.c via get_stream_filter(), but there are no test cases yet.
>
> Add tests for the filter API by configuring the ident filter.
> The result of the SHA1 conversion is not checked, this is already
> done in other TC.
>
> Add a parameter to checkout_files() in t0027.
> While changing the signature, add another parameter for the eol=3D at=
tribute.
> This is currently unused, tests for e.g.
> "* text=3Dauto eol=3Dlf" will be added in a separate commit.
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> Changes since v2:
> 1/7 t0027 uses ident instead of i (the empty "" is still there)

Thanks, much easier to understand with that spelled out.

And making "" a noop makes sense given the way this helper is called
(i.e. it is fed "$ident" and "$attr" quoted in dq, and they could
become empty string--it is not worth doing ${ident:+"$ident"} there).
