From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: test for regression introduced in
 v1.7.2-rc0~103^2~2
Date: Sun, 15 Aug 2010 02:08:10 -0700
Message-ID: <7v39uggs5h.fsf@alter.siamese.dyndns.org>
References: <7vzkwqi10w.fsf@alter.siamese.dyndns.org>
 <1281748247-8180-1-git-send-email-avarab@gmail.com>
 <AANLkTi=Na_K=9oXM7iyeKodWXyXuSy-0UL792igTEjEe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 15 17:29:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Okf9c-0000th-Qi
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 17:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756674Ab0HOP3i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 11:29:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59475 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754941Ab0HOP3g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 11:29:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B732CDCE6;
	Sun, 15 Aug 2010 05:08:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=rwP6dVcOaOw97W+WxuCW/XVh8
	4M=; b=RAg35vMkSRVbSPOVh7YcK7+lwq+NCjzDZegfOAtJduga9U6vXSaj78G++
	iBHB+b2uLlPJkGEevH8H0++S+elagRIxBkBC6IiVNE7x0kBK5S00ucafDzeLidep
	aeDOs8Ifmx8IA8dxKiVl51c+EcKR7jBgQWx4csIaYSwINjX8wI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=MmvIeqVnBwNXQu5Sk77
	nGpXmOeZPZYCdmNfpmuhJIfzvWTqnHwaQ8N+5LDqEX2lmPHZfOcI2wG9kW3PDZKq
	1xKCBCUYkEu30XDpMl62vKwDLunh3VqW7XJKZixoVoyFoHxj9Q/3plXmnX/NDaHO
	x3GbVQh80Uyws54Di0283oUE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 10A99CDCE5;
	Sun, 15 Aug 2010 05:08:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 543D5CDCE4; Sun, 15 Aug
 2010 05:08:12 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A3047B48-A84C-11DF-A43E-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153600>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sat, Aug 14, 2010 at 01:10, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 <avarab@gmail.com> wrote:
>> Add a regression test for the git log -M --follow --name-only bug
>> introduced in v1.7.2-rc0~103^2~2
>
> AKA "we didn't have any tests for log's --name-only *at all*".

But this is not related to --name-only at all; anything that is "diff"
related, e.g. -p, --stat, --name-status, will share the same issue.

> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 95ac3f8..ff624f4 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -441,5 +441,14 @@ test_expect_success 'log.decorate configuration'=
 '
> =20
>  '
> =20
> +test_expect_success 'Regression test for v1.7.2-rc0~103^2~2' '

This is uninformative and ugly at the same time.

 - Can't we describe the nature of the situation where the old bug
   triggers concisely?  Perhaps 'show added path under "--follow -M"?'

 - All others begin with lowercase.

> +	# Needs an unrelated root commit
> +	test_commit README &&

This is not a "root" commit, is it?

> +	>Foo.bar &&
> +	git add Foo.bar &&
> +	git commit --allow-empty-message </dev/null &&

Does emptiness of the message matter?

> +	git log -M --follow --name-only Foo.bar
> +'
> +
>  test_done
