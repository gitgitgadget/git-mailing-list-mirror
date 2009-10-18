From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Generalized "string function" syntax
Date: Sat, 17 Oct 2009 21:18:14 -0700
Message-ID: <7v63ad5o8p.fsf@alter.siamese.dyndns.org>
References: <1255681702-5215-1-git-send-email-gitster@pobox.com>
 <4ADA3153.7070606@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Oct 18 06:22:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzNHx-0002mS-8u
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 06:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbZJRESR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Oct 2009 00:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbZJRESR
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 00:18:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47388 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbZJRESQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Oct 2009 00:18:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 972C95D4B9;
	Sun, 18 Oct 2009 00:18:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=RUdqoYqbbc584XKlck49CKSM2
	DY=; b=HsJsr/v9Hp3hN3KknuJCnwATCyFEyxlv2tIylm8fTlBsq3eR1kwiwKnf6
	fHOtNG+izWvcxC6z5Nyh3CRekBsK49LTmQ4ZW5s4Y+jJ6vi0amcPcKa9XDFb5SfW
	3tbgUNo3wH4ia09NuMNnud0cejruiypGYDc5sl0BH/VHAJUloc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=TBV+3N1k073OA4PIfJl
	ByMYtUnk7l663TgYwdRtXSq0DOeu+MwOoSpynWVd1MdgMqj/TYlJhDan6wzI8/uN
	OIz5eaLbhHnrBpN+huTIPCfEMSZ3C4JwS2iUy9TmPjqXKaF/ExO143gEfBi4HwEF
	T1MJFXX/49RdBZ1/uhoeBUWA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7118E5D4B7;
	Sun, 18 Oct 2009 00:18:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0F985D4B6; Sun, 18 Oct
 2009 00:18:15 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 437F46FE-BB9D-11DE-B2B4-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130584>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Junio C Hamano schrieb:
>> I mentioned an idea to enhance the pretty=3Dformat language with a
>> string function syntax that people can extend by adding new function=
s
>> in one of the "What's cooking" messages earlier.  The general syntax
>> would be like
>>=20
>> %[function(args...)any string here%]
>>=20
>> where "any string here" part would have the usual pretty=3Dformat
>> strings. E.g.  git show -s --format=3D'%{w(72,8,4)%s%+b%]' should gi=
ve
>> you a line wrapped commit log message if w(width,in1,in2) is such a
>> function.
>
> I pondered line wrapping with format strings briefly a long time ago,=
 and
> I always considered it to be more similar to a colour, i.e. a state t=
hat
> one can change and that is applied to all following text until the ne=
xt
> state change.  (Except that it's always reset at the end of the forma=
t
> string.)  The example above would then turn into '%w(72,8,4)%s%+b'.

As a syntax to express "wrapping" behaviour alone, I think this is much
simpler and more superiour.  I guess with this if you want to wrap
something to 72 columns and then wrap something else to 66 columns, you
would write '%w(72,8,4)something%w(66,8,4)something else', right?

I used %] only for two reasons.

 - Without an explicit "here it ends", I couldn't come up with a good w=
ay
   to express '%[w(72,8,4)something%]something else'.  IOW, how I can s=
ay
   "wrap something to 72 columns and then place something else without =
any
   wrapping"?
  =20
 - When we need to support more than one string function like this, it =
is
   unclear what '%f()one string%g()another one' in your syntax means.
   Does it mean '%[f()one string%]%[g()another one%]' (i.e. concatenate
   the result of applying string function f to 'one string' and the res=
ult
   of applying string function g to 'another one')?  Or does it mean
   '%[f()one string%[g()another one%]%]' (apply 'f' to concatenation of
   'one string' and the result of applying 'g' to 'another one')?
