From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] doc/http-backend: give some lighttpd config examples
Date: Thu, 11 Apr 2013 20:27:41 +0200
Message-ID: <5167009D.1050906@gmail.com>
References: <20130411033022.GA14462@sigill.intra.peff.net> <20130411033613.GB14551@sigill.intra.peff.net> <5166E935.2080206@gmail.com> <20130411170233.GB1255@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Magnus Therning <magnus@therning.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 11 20:27:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQMDu-0001rl-0f
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 20:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926Ab3DKS1q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Apr 2013 14:27:46 -0400
Received: from mail-ee0-f52.google.com ([74.125.83.52]:60817 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab3DKS1p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 14:27:45 -0400
Received: by mail-ee0-f52.google.com with SMTP id d17so889497eek.11
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 11:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=gSTs1VeA3T087RyddjxtTOE/SpaMLVUciATX1l1LEWA=;
        b=BtaTaH5lG0/ZLZSH6ybX+JWZPtRclIa3sYuhBNxv1TzYk2A0CvaziOYCbPHWWjnROh
         xg8eIwIp/LM8m1YglHe2ReTIk6ZzxJ0nn9UYgRYQSo71IcqUsqBmvlDZrUx3w9WWUd5x
         yL1/ntaZqL6K3a0QRASpQDTo5eAKkxKM08Pa2oabRAvG3fVcTvFD1KxyeIZHerTZhcda
         0Q9DA/dAowYVeXuHPctTZN5tQ9ywdbTd4kjYw+08A0/Cz++JKcB+uMSyZXlhLaDwelG4
         aH4E7SzwTgo52mo46iqPZNcvAvFZvQ+CQpHsxJkPBUOmn+5QnXl64Ri9/PaxCLj3gVtq
         iU0Q==
X-Received: by 10.15.101.200 with SMTP id bp48mr19203519eeb.38.1365704864068;
        Thu, 11 Apr 2013 11:27:44 -0700 (PDT)
Received: from [192.168.1.14] (ewi48.neoplus.adsl.tpnet.pl. [83.20.232.48])
        by mx.google.com with ESMTPS id a2sm5532086eem.11.2013.04.11.11.27.42
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 11:27:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130411170233.GB1255@sigill.intra.peff.net>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220906>

W dniu 11.04.2013 19:02, Jeff King napisa=C5=82:
> On Thu, Apr 11, 2013 at 06:47:49PM +0200, Jakub Nar=C4=99bski wrote:
>> W dniu 11.04.2013 05:36, Jeff King napisa=C5=82:
>>
>>> +Note that unlike the similar setup with Apache, we can easily matc=
h the
>>> +query string for receive-pack, catching the initial request from t=
he
>>> +client. This means that the server administrator does not have to =
worry
>>> +about configuring `http.receivepack` for the repositories (the def=
ault
>>> +value, which enables it only in the case of authentication, is
>>> +sufficient).
>>
>> Perhaps it would be worth including for Apache2 beside basic setup t=
hat
>> requires http.receivepack set to true, also one like for LigHTTPd, i=
=2Ee.
>>
>>   RewriteCond %{QUERY_STRING} =3Dservice=3Dgit-receive-pack [OR]
>>   RewriteCond %{REQUEST_URI} /git-receive-pack$
>>   RewriteRule (.*) $1 [E=3DAUTHREQUIRED:yes]
[...]
>> And perhaps also adding it as test...
>=20
> That was the "I am not clever nor interested in Apache enough to figu=
re
> out how to do this..." part that I wrote. I have no clue if the above
> works, but I'd be happy if you wanted to test it out and submit it as=
 a
> patch on top (I think it could even replace my 1/2, as making it just
> work is a much better solution than having to explain the extra step =
in
> the documentation).

I don't know if short description of `http.receivepack`, suitable for
a reference documentation, tells a new user how to configure web server
for pushes.


With `http.receivepack` unset git (git-http-backed?) will refuse
unauthenthicated pushes but allow authenthicated ones (though it doesn'=
t
handle authorization).  This makes it easy to configure web server for
fetches (read-only) access via smart HTTP (and you can make it
bulletproof by refusing pushes at all with `http.receivepack` false,
isn't it?).

But in this case (`http.receivepack` unset - the default) web server
must be configured to request authorization for both steps of push:
requesting references (for coming up with what
repositories have in common), i.e.

  GET ...?service=3Dgit-receive-pack

and actual sending of data and updating refs...

  POST .../git-receive-pack

though only second part is actually writing.


With `http.receivepack` set to true git (git-http-backend?) allows
anonymous pushes, and it is responsibility of web server configuration
to deny unauthorized pushes... but it is sufficient to do it only for
writes i.e.

  POST .../git-receive-pack


[Now to translate it to manpage or users-manual contents...]

P.S. Do I understand it correctly that `http.receivepack` is
three-state: true (allow all), unset (allow authenthicated) and false
(deny all)?

P.P.S. It would be better to accept both patches; I don't know when
I would be able to test Apache config; I remember that I had problems
with it...
--=20
Jakub Nar=C4=99bski
