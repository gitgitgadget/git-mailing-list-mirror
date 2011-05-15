From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problems with Git's "perl" userdiff driver
Date: Sun, 15 May 2011 13:02:10 -0700
Message-ID: <7vk4drpwal.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=OXznTspN-CJjM0YXfqARxL=J+Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 15 22:02:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLhWD-0007Hv-NT
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 22:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637Ab1EOUCV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2011 16:02:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab1EOUCU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2011 16:02:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A61804E14;
	Sun, 15 May 2011 16:04:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=sIX2gxQqmA/d
	KwWb3w7SMWrPz+w=; b=avL3Ryv7y9xpW1OEGpuESJ6y8hk6A0ToTGgs5/tpRYOz
	DTgF/oZaxxHNVxI3AfKRz4zpHJQU7ZWkkkJs1rOvu7V3NeUFKKuc7TulViMX/mKX
	UgUasAdpUzHXDwtxNcWhX7f1AAA2Gi+a9SNV7kZVbrL1ztGCsRZSuv3yp8fYGnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=h+dy/O
	Ywp1ZR3ekkcIA5zA9oNPLlNoiECrvXIvatQCBFKWbtv1/MDlXK/UDyPwghimbTDV
	CZSunGNLM12WTlO1+itR5bA+S0wePibO6SHZIB8Z03Za2poIavuXpb55S6K5U6GL
	1BXTUFawHA+L+M1tLeYDPcJzdda+HoQUv0MEU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 722F64E13;
	Sun, 15 May 2011 16:04:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 43E3A4E11; Sun, 15 May 2011
 16:04:18 -0400 (EDT)
In-Reply-To: <BANLkTi=OXznTspN-CJjM0YXfqARxL=J+Ow@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 15 May
 2011 20:14:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 868C482E-7F2E-11E0-86BD-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173655>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Dec 29, 2010 at 06:22, Junio C Hamano <gitster@pobox.com> wro=
te:

Heh; without in-reply-to or references, this is useless, isn't it?

> [better late than never]
>
>> * jn/perl-funcname (2010-12-27) 2 commits
>>  - userdiff/perl: catch BEGIN/END/... and POD as headers
>>  - diff: funcname and word patterns for perl

=46or others, the above are these two:

 a25e473 (userdiff/perl: catch BEGIN/END/... and POD as headers, 2010-1=
2-27)
 71a5d4b (diff: funcname and word patterns for perl, 2010-12-26)

> The POD rule doesn't work properly. I suspect it has to be:
>
>     "^=3Dhead[0-9] .*",
>
> Instead of the current:
>
>     "^=3Dhead[0-9] ",
>
> Since e.g.:
>
>     =3Dhead1 WHATEVER
>
> Will just be shown as:
>
>     =3Dhead1
>
> In the diff context.
>
> And actually it applies very badly to POD in general, since the "sub"
> rule will be tried first, so e.g. in Perldoc we'll often end up
> finding some "sub" example halfway up the file, instead of the =3Dhea=
d1*
> or =3Ditem* section a few lines up.
>
> And it looks like the regex only catches:
>
>     sub foo {
>     }
>
> Not:
>
>     sub foo
>     {
>     }
