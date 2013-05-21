From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v8 0/3] Begin replacing OpenSSL with CommonCrypto
Date: Tue, 21 May 2013 15:39:15 -0700
Message-ID: <CAJDDKr61R0aPFWT=vNz3nSvR-1azTG3Zox=wAO7rB_iCvxhdZg@mail.gmail.com>
References: <1368959016-23146-1-git-send-email-sunshine@sunshineco.com>
	<7vfvxhs1pz.fsf@alter.siamese.dyndns.org>
	<519BC8B0.5050100@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed May 22 00:39:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UevDH-0001i6-2W
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 00:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292Ab3EUWjS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 May 2013 18:39:18 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35939 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116Ab3EUWjQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 May 2013 18:39:16 -0400
Received: by mail-pd0-f181.google.com with SMTP id p11so1072525pdj.40
        for <git@vger.kernel.org>; Tue, 21 May 2013 15:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=zHm8VB7PqKVhjpHerYq69IHNeVMUSX2mWWdWtnd10Qs=;
        b=0aRLUCk1f8NGggVpp766N8+qW3zqjyZL05YInRYtip+wWB885VkC8fXRlDlzDBYhJ8
         8j7sZSyy1rwDhwIPQ/grMWfpMWS2wRqlxPpciFh6BbFvt4NGQMX2wHudFMTty6VHf7MX
         WUVEPjwvLygrMIxhMJg7aD/V90FOTG/VuKpl9Fgpo6nypPyFgHMNhhGWmTthqm78s3DA
         OXytmov8Kbjl0+TMYmg+/E/8j6F14qNfnkqbROceer3BsvVHs9TvgApJj3Oaut6Gk93t
         W3/LrxQ9OMy8zNjd7iFVJb/63crS+7IfN9JaTUYl1LCwMB63fdA7nehrEvYvAa98UwDZ
         pMjg==
X-Received: by 10.66.233.9 with SMTP id ts9mr5506638pac.15.1369175955601; Tue,
 21 May 2013 15:39:15 -0700 (PDT)
Received: by 10.70.55.106 with HTTP; Tue, 21 May 2013 15:39:15 -0700 (PDT)
In-Reply-To: <519BC8B0.5050100@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225089>

On Tue, May 21, 2013 at 12:19 PM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
> On 2013-05-21 00.52, Junio C Hamano wrote:
>> Thanks, will replace da/darwin with this round.
> (May be late response, not sure if this is the right email thread.
> I eventually managed to compile under 10.6, what we have on pu)
>
> One minor nit, or 2:
> imap-send.c: In function =E2=80=98cram=E2=80=99:
> imap-send.c:913: warning: statement with no effect
>
> This fixes it:
>
> diff --git a/imap-send.c b/imap-send.c
> index 8ea180f..11577c9 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -35,7 +35,7 @@ typedef void *SSL;
> #define HMAC_Init(hmac, key, len, algo) CCHmacInit(hmac, algo, key, l=
en)
> #define HMAC_Update CCHmacUpdate
> #define HMAC_Final(hmac, hash, ptr) CCHmacFinal(hmac, hash)
> -#define HMAC_CTX_cleanup
> +#define HMAC_CTX_cleanup(c)
> #define EVP_md5() kCCHmacAlgMD5
> #else
> #include <openssl/evp.h>

Thanks.  This change compiles fine on Mountain Lion (10.8) as well.
--
David
