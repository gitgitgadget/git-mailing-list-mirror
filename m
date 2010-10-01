From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 02/15] t4017 (diff-retval): replace manual exit code
 check with test_expect_code
Date: Fri, 01 Oct 2010 09:20:03 -0700
Message-ID: <7vd3rtholo.fsf@alter.siamese.dyndns.org>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
 <1285542879-16381-3-git-send-email-newren@gmail.com>
 <7vd3rwo22t.fsf@alter.siamese.dyndns.org>
 <AANLkTiksEBVUyJnrUETxManHa+ZMCT6+V3C83K75KW2A@mail.gmail.com>
 <20101001102315.GA6816@burratino>
 <AANLkTinqVTqxiHL5tEv+-SS6YURGUoWaPxCgpccZgjEq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 18:20:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1iLP-0007ko-0Y
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 18:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395Ab0JAQUQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Oct 2010 12:20:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345Ab0JAQUP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Oct 2010 12:20:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6ABF1DA5AD;
	Fri,  1 Oct 2010 12:20:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=83z/Zrk/IIaN
	p6zVyEWmuDdTCts=; b=Yjcu/hzjZFUPr4UTZ9lZWHAcn31Zj6E3QshzkXMwQHUU
	goJqXSxX7CO6/Z5MsMbyi/cSmKnkrBEftuWAbtcxF9Tm2FfRzabUhXWzGpml941a
	7v0qU8TFBDkFM7td4yUUAjOz0RBxG0moHRGrCFiL7qU6f6j290dHTjrWalOOXgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=msvGQ5
	DFU9IiungK2FL3qOoPLhTKDqU/moOchuSl15OFmo2JlsgWvOljnzpPCi8lVzsO71
	8tioD8dExlRjsU25NXtDKNfnGbcD4Vi0YaLeqk9PL+/mSpS9p4+aeWxvgQa6dEwu
	YThIodKOScFO5TejIRpyC2e/8to1IvlFlktv4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2673EDA5AC;
	Fri,  1 Oct 2010 12:20:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30D7EDA5AA; Fri,  1 Oct
 2010 12:20:05 -0400 (EDT)
In-Reply-To: <AANLkTinqVTqxiHL5tEv+-SS6YURGUoWaPxCgpccZgjEq@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri\, 1 Oct
 2010 10\:38\:32 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C3083286-CD77-11DF-9A82-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157760>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Oct 1, 2010 at 10:23, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
>
>>  test_expect_success 'git diff --quiet HEAD^^ HEAD^' '
>> -       test_must_fail git diff --quiet HEAD^^ HEAD^
>> +       check_exit_status 1 git diff --quiet HEAD^^ HEAD^
>>  '
>
> In most uses of check_exit_status you're using it is the very last
> command within a test_expect_success. Isn't it redundant to using jus=
t
> "test_expect_code $code ..." there?

Doesn't

	test_expect_code 1 'phoney' '
        	foo && bar && (exit 1)
	'

incorrectly succeed if "foo" or "bar" happened to fail with exit status=
 1?

> So IMO the best thing to do would be to re-appropriate
> "test_expect_code" so that it runs inside a test (i.e. does what your
> check_exit_status does), and not at the top-level.

I like it.  It should have been done the way you suggest from the
beginning.  It is unfortunate that we didn't think of wrappers like
test_must_fail and friends when we originally did test_expect_code, but=
 it
is never too late to correct that mistake.
