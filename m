From: =?utf-8?B?0KDQvtC80LDQvSDQlNC+0L3Rh9C10L3QutC+?= 
	<dpb@corrigendum.ru>
Subject: Re: [PATCH v2 2/2] send-email: handle adjacent RFC 2047-encoded words
 properly
Date: Sun, 07 Dec 2014 21:17:00 +0300
Message-ID: <op.xqifqmyznngjn5@freezie>
References: <1417894583-2352-1-git-send-email-dpb@corrigendum.ru>
 <1417894583-2352-2-git-send-email-dpb@corrigendum.ru>
 <20141207091859.GA21311@peff.net> <op.xqh5hrafnngjn5@freezie>
 <316EF32F3157400882911A84EA0CFC61@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	=?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjar?= =?utf-8?Q?mason?= 
	<avarab@gmail.com>, "Jay Soffian" <jaysoffian@gmail.com>,
	"Thomas Rast" <tr@thomasrast.ch>
To: "Jeff King" <peff@peff.net>, "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Dec 07 19:17:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxgOO-0006v0-V7
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 19:17:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155AbaLGSRJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Dec 2014 13:17:09 -0500
Received: from forward10l.mail.yandex.net ([84.201.143.143]:53706 "EHLO
	forward10l.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752754AbaLGSRG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 7 Dec 2014 13:17:06 -0500
Received: from smtp18.mail.yandex.net (smtp18.mail.yandex.net [95.108.252.18])
	by forward10l.mail.yandex.net (Yandex) with ESMTP id 26470BA0FCD;
	Sun,  7 Dec 2014 21:17:02 +0300 (MSK)
Received: from smtp18.mail.yandex.net (localhost [127.0.0.1])
	by smtp18.mail.yandex.net (Yandex) with ESMTP id 23F6918A00E9;
	Sun,  7 Dec 2014 21:17:01 +0300 (MSK)
Received: from 109-184-135-154.dynamic.mts-nn.ru (109-184-135-154.dynamic.mts-nn.ru [109.184.135.154])
	by smtp18.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id fB4ILj4s5Y-H0HKTwos;
	Sun,  7 Dec 2014 21:17:00 +0300
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: bebb4f41-249a-46b4-8729-f2091ed4e9bc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=corrigendum.ru; s=mail;
	t=1417976220; bh=OFqiN1hH0Cv4XQEwe+FGP9GiYYbTWI9pvvXU9o3HgYA=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:
	 Content-Transfer-Encoding:From:Message-ID:In-Reply-To:User-Agent;
	b=LUqSEPcKm6WgYqNKrroVflfy1F5R85nSIpcp6BkxXGJ1fuLEwHskyYFFen7+G35vS
	 KePGGHoBjibh92WspQ5tviF6YRxbVhCFUxG7Y74X9HG36gnMGTsSLuNKXqb/eGmyNf
	 jffT5E591LdDObUWVkIOWhjVIywu3AQKAd7GdJjg=
Authentication-Results: smtp18.mail.yandex.net; dkim=pass header.i=@corrigendum.ru
In-Reply-To: <316EF32F3157400882911A84EA0CFC61@PhilipOakley>
User-Agent: Opera Mail/12.17 (Win64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260995>

Philip Oakley <philipoakley@iee.org> =D0=BF=D0=B8=D1=81=D0=B0=D0=BB =D0=
=B2 =D1=81=D0=B2=D0=BE=D1=91=D0=BC =D0=BF=D0=B8=D1=81=D1=8C=D0=BC=D0=B5=
 Sun, 07 Dec 2014 =20
20:48:05 +0300:

> From: "=D0=A0=D0=BE=D0=BC=D0=B0=D0=BD =D0=94=D0=BE=D0=BD=D1=87=D0=B5=D0=
=BD=D0=BA=D0=BE" <dpb@corrigendum.ru>
>> Jeff King <peff@peff.net> =D0=BF=D0=B8=D1=81=D0=B0=D0=BB =D0=B2 =D1=81=
=D0=B2=D0=BE=D1=91=D0=BC =D0=BF=D0=B8=D1=81=D1=8C=D0=BC=D0=B5 Sun, 07 D=
ec 2014 =20
>> 12:18:59  +0300:
>>
>>> On Sat, Dec 06, 2014 at 10:36:23PM +0300, =D0=A0=D0=BE=D0=BC=D0=B0=D0=
=BD =D0=94=D0=BE=D0=BD=D1=87=D0=B5=D0=BD=D0=BA=D0=BE wrote:
>>> One final note on this bit of code: if there are multiple encoded =20
>>> words,
>>> we grab the $charset from the final encoded word, and never report =
the
>>> earlier charsets. Technically they do not all have to be the same
>>> (rfc2047 even has an example where they are not). I think we can =20
>>> dismiss
>>> this, though, as:
>>>
>>>   1. It was like this before your patches (we might have seen multi=
ple
>>>      non-adjacent encoded words; you're just handling adjacent ones=
),
>>>      and nobody has complained.
>>>
>>>   2. Using two separate encodings in the same header is sufficientl=
y
>>>      ridiculous that I can live with us not handling it properly.
>>
>> Yeah, that bugs me as well. But I think handling multiple encodings =
=20
>> would  require substantial reworking of the code, so I chickened out=
 =20
>> (with the  same excuses :-)).
>
> Would that be worth a terse comment in the documentation change part =
of =20
> the patch?
> "Multiple  (RFC2047) encodings are not supported.",
> or would that be bike shed noise.

I didn't change any documentation... and in either case, they weren't =20
supported in the first place, so I don't think it's anything I need to =
=20
mention.
