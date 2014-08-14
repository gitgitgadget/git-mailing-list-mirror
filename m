From: Markus Hitter <mah@jump-ing.de>
Subject: Re: Git on Mac OS X 10.4.10
Date: Thu, 14 Aug 2014 20:39:19 +0200
Message-ID: <53ED0257.3070505@jump-ing.de>
References: <53ECA7DB.7060407@jump-ing.de> <53ECCA14.40900@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 20:39:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHzvp-0002OL-1d
	for gcvg-git-2@plane.gmane.org; Thu, 14 Aug 2014 20:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596AbaHNSjV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2014 14:39:21 -0400
Received: from ud03.udmedia.de ([194.117.254.43]:52944 "EHLO
	mail.ud03.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384AbaHNSjU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2014 14:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=mail.ud03.udmedia.de; h=
	message-id:date:from:mime-version:to:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=beta; bh=
	qXj3flrcbTZSw+3PfuJgIHEE5G9/B0Kc26k437UIqOM=; b=d/uhg4DXx13bbXuD
	gjEryzw7Hvj+5U1Gjtq42qE408Nr1waoWGlXBfUC4F2rnxFT9BxkyqdqO22HUev5
	CK3JnjgsDEFiJByFm41a4KxodPHIDOYkzZjrhwYHG7770lOZNKh2aWjsxM/QYIDt
	L9dpEcV6tDVWqI1Bko3gplXP+JQ=
Received: (qmail 31148 invoked from network); 14 Aug 2014 20:39:19 +0200
Received: from unknown (HELO ?10.0.0.102?) (ud03?291p1@134.3.201.241)
  by mail.ud03.udmedia.de with ESMTPSA (DHE-RSA-AES128-SHA encrypted, authenticated); 14 Aug 2014 20:39:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <53ECCA14.40900@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255270>

Am 14.08.2014 um 16:39 schrieb Torsten B=C3=B6gershausen:
> On 08/14/2014 02:13 PM, Markus Hitter wrote:
>> Issue 2: I need this simple patch ...
>>
>> --- compat/apple-common-crypto.h.org    2014-07-30 23:19:53.00000000=
0
>> +0200
>> +++ compat/apple-common-crypto.h    2014-08-14 12:57:37.000000000 +0=
200
>> @@ -2,7 +2,7 @@
>>   #define OPENSSL_NO_MD5
>>   #define HEADER_HMAC_H
>>   #define HEADER_SHA_H
>> -#include <CommonCrypto/CommonHMAC.h>
>> +//#include <CommonCrypto/CommonHMAC.h>
>>   #define HMAC_CTX CCHmacContext
>>   #define HMAC_Init(hmac, key, len, algo) CCHmacInit(hmac, algo, key=
,
>> len)
>>   #define HMAC_Update CCHmacUpdate
> The  <CommonCrypto/CommonHMAC.h> is in Mac OS X 10.6 .. 10.9,
> but not in 10.4 (I don't know about 10.5).
> You can try to tweak the "makefiles",  search for NO_APPLE_COMMON_CRY=
PTO,
> and set NO_APPLE_COMMON_CRYPTO, but only  for Darwin 10.3 (or below)

Thanks. This:

export NO_APPLE_COMMON_CRYPTO=3Dyes
make configure
CFLAGS=3D-O2 ./configure --without-tcltk --prefix=3D/usr/global
make all

compiles fine on 10.4.10. Would a configure patch checking for the
existence of CommonHMAC.h and, if not found, defining this variable, be
acceptable? Googling around, it's a bit unclear to me on how to
contribute something to Git.


Markus

--=20
- - - - - - - - - - - - - - - - - - -
Dipl. Ing. (FH) Markus Hitter
http://www.jump-ing.de/
