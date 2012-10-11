From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/12] Wildmatch v4
Date: Wed, 10 Oct 2012 21:33:16 -0700
Message-ID: <7v1uh5aar7.fsf@alter.siamese.dyndns.org>
References: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
 <7vd30panxo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 06:33:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMASh-0003Ls-7Q
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 06:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762Ab2JKEdU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Oct 2012 00:33:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40889 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689Ab2JKEdT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2012 00:33:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCE3F9F8A;
	Thu, 11 Oct 2012 00:33:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2BuEL9IVuNfJ
	czI6Yxm0JPh/qfg=; b=JtDJpRJpyEF6HP38CF1+WimgJOtKLak77LmWw4mImcIn
	bdI28kMxkN7U/jcV04PiAqFw6aRhLe1aQZ7KccZlaOze6x0F0R3HaKpYEV6WVPcb
	sqOD5NYTL7IagK6KKDM/6DQafouC6prfWz5HHWqlGaz8fDF/j2LmQ/3uDBhN17I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LPPRHB
	PPGkXPgqnYyw2OJ7s0xmTz007eJei/FaFav2vJrh3KaazctyzE9p9bMuRbkou9o9
	sIWZkcf/Zk2Pn7+jxSg2Ym8bsmSYtc02Gh7P/dvL+JxCn7Qg1lN65coFUGHuoFUr
	ZtAxslUVp8XbtN/rec1gdjERdZS5Vn5SXreVg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA53A9F89;
	Thu, 11 Oct 2012 00:33:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DCA49F88; Thu, 11 Oct 2012
 00:33:17 -0400 (EDT)
In-Reply-To: <7vd30panxo.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 10 Oct 2012 16:48:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7914BE4-135C-11E2-A333-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207462>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Really small updates. I did not want to resend it this soon but this
>> may fix the compile errors for Junio.

t3070 seems to break TAP,

    *** prove ***
    t3070-wildmatch.sh .. Failed 1/151 subtests=20

    Test Summary Report
    -------------------
    t3070-wildmatch.sh (Wstat: 0 Tests: 150 Failed: 0)
      Parse errors: Tests out of sequence.  Found (76) but expected (75=
)
                    Tests out of sequence.  Found (77) but expected (76=
)
                    Tests out of sequence.  Found (78) but expected (77=
)
                    Tests out of sequence.  Found (79) but expected (78=
)
                    Tests out of sequence.  Found (80) but expected (79=
)
    Displayed the first 5 of 77 TAP syntax errors.

This probably is due to this part of the output:

    ok 72 - wildmatch 1 1 [ab] [\[:]ab]
    ok 73 - wildmatch 1 1 ?a?b \??\?b
    ok 74 - wildmatch 1 1 abc ^G^Hok 75 - wildmatch 0 0 foo=20
    ok 76 - wildmatch 1 0 foo/bar/baz/to **/t[o]
    ok 77 - wildmatch 1 1 a1B [[:alpha:]][[:digit:]][[:upper:]]
