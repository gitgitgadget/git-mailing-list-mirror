From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Wishlist] could git tell which password it is asking when
 asking a password.
Date: Fri, 01 Jul 2011 10:50:40 -0700
Message-ID: <7vwrg1opov.fsf@alter.siamese.dyndns.org>
References: <877h82nlua.dlv@debian.org>
 <7v62nmos0k.fsf@alter.siamese.dyndns.org>
 <7v1uy9q5v1.fsf@alter.siamese.dyndns.org>
 <BANLkTi=aAinh=0jxb5MoqVOdUB7zxoy2XdSqk+pdsewLXU62ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?R=C3=A9mi?= Vanicat <vanicat@debian.org>,
	git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 01 19:50:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qchre-0003pR-SQ
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jul 2011 19:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757403Ab1GARuo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jul 2011 13:50:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48954 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756486Ab1GARuo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jul 2011 13:50:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 617945110;
	Fri,  1 Jul 2011 13:52:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dWo+lUw1Tz8f
	+MW0OzAu8Xi5ktQ=; b=SyfFQn+0VgyEj6WGWr0nWlQnhZ0l21tKsRjr2/z9kDdf
	7gMKClgUQL2QegZZjV+7nC71AUCk4EcNBGnowy28Vh411xoC6x8i87Szly7G54et
	5HlcitHWS/r9OuZlFotx6s8ciX/Xgb0+cGb9C1q8SBVwmfb/I8rgxJM5S54i7hI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Sas98h
	CUd4L41fb6JYQbxNrDkMaYLCjIjwN2+WY7ymfgutYnwr9mNQLgEAp6nwtaGl2YLn
	lbz1iM7cGkUqP8xo6ywtnQGv5k/HMgE7WsD17s0rvxEIxY2khu1ntmq4bHQ9DyMT
	Dv0hRo7W9/ygo+9Zj9U8ymSKtMj2zKxouLZcc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 593E0510F;
	Fri,  1 Jul 2011 13:52:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A51E650FA; Fri,  1 Jul 2011
 13:52:56 -0400 (EDT)
In-Reply-To: <BANLkTi=aAinh=0jxb5MoqVOdUB7zxoy2XdSqk+pdsewLXU62ZA@mail.gmail.com> (Shawn
 Pearce's message of "Fri, 1 Jul 2011 10:18:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F3BAF3FE-A40A-11E0-AAA5-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176527>

Shawn Pearce <spearce@spearce.org> writes:

> On Fri, Jul 1, 2011 at 10:16, Junio C Hamano <gitster@pobox.com> wrot=
e:
>> Junio C Hamano <gitster@pobox.com> writes:
>> diff --git a/http.c b/http.c
>> index b2ae8de..44948a7 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -209,8 +209,11 @@ static void init_curl_http_auth(CURL *result)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (user_name) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct strbuf=
 up =3D STRBUF_INIT;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!user_pass)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 user_pass =3D xstrdup(git_getpass("Password: "));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!user_pass) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 strbuf_addf(&up, "Password for %s: ", user_name);
>
> The user_name by itself may not be sufficient. I may also need the UR=
L
> to correctly answer the question. I don't always use the same passwor=
d
> on every website. :-)
>
> As a human sure, I know what URL I asked Git to poke for me.

I was wondering about that when I gave that quick patch.  And "as a hum=
an"
may not necessarily apply when you are letting submodule fetch to recur=
se.
