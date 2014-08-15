From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Git on Mac OS X 10.4.10
Date: Fri, 15 Aug 2014 05:39:20 -0400
Message-ID: <CAPig+cSGs-MzG=nG7ONRvcMhnrJx4vUri2d5nHovQiQ9w+ckDQ@mail.gmail.com>
References: <53ECA7DB.7060407@jump-ing.de>
	<53ECCA14.40900@web.de>
	<53ED0257.3070505@jump-ing.de>
	<xmqqppg21wyk.fsf@gitster.dls.corp.google.com>
	<273241271546c07e692ae93774993f5@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Markus Hitter <mah@jump-ing.de>, Git List <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 11:39:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIDyo-0003uy-86
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 11:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838AbaHOJjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2014 05:39:22 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:41059 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbaHOJjV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 05:39:21 -0400
Received: by mail-yk0-f175.google.com with SMTP id q200so1897148ykb.34
        for <git@vger.kernel.org>; Fri, 15 Aug 2014 02:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=HV8UDD1sEpj8ifHCsH6Xclh3gKCThrHPYNba9PxzxlI=;
        b=NbAGGd68IxcG5Bpndp5vFTZEYUPt+SPUoExkt/YNHP0i9lbR/dCHdCXYbgBMIJZH5K
         BhGHYJA7mMdxkEPTTuFpYcxGoXySdldiW9vx3ABUfBiv4+y8q8mcSsZdhUa8XI/sHHJR
         6bCR2+F9Glrc6Hg/74Gt+WNcmG8+QfOhNPnCmLUn4th3f/jItkn2AEjPaSRRgLHx4A0o
         n4Cc/vPtlrxq5Lz3jS/6a2GlSKZJU4rEgK2OrQhUmhgEPqdZizcN0y3AuKgycPE0n334
         j218TzAaAeuS8Rc+VDiwHYWeQNucmHwiHSYHxzYOJMGjnD/O698VmgU611ODpHrLCpM6
         m5YQ==
X-Received: by 10.236.103.135 with SMTP id f7mr25529739yhg.102.1408095560229;
 Fri, 15 Aug 2014 02:39:20 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Fri, 15 Aug 2014 02:39:20 -0700 (PDT)
In-Reply-To: <273241271546c07e692ae93774993f5@74d39fa044aa309eaea14b9f57fe79c>
X-Google-Sender-Auth: nTc2Z4zHro-ShlgU3uFnZvUQlPI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255283>

On Fri, Aug 15, 2014 at 3:46 AM, Kyle J. McKay <mackyle@gmail.com> wrote:
> On Aug 14, 2014, at 16:18, Junio C Hamano wrote:
>
>> Markus Hitter <mah@jump-ing.de> writes:
>>
>>>> The  <CommonCrypto/CommonHMAC.h> is in Mac OS X 10.6 .. 10.9,
>>>> but not in 10.4 (I don't know about 10.5).
>
> That header is new with 10.5
>
>> Is this about platform dependency, or what the end user happens to
>> choose to install (in other words, is there an add-on users of 10.4
>> can choose to add, which allows them to use that header)?
>
> Nope, it's a platform dependency.  Not available prior to 10.5.
>
> The below patch does the right thing.  Conveniently there's already
> a test for 10.4 and earlier so only a single line need be added.

I tested with Mac OS X 10.5 (and 10.9) to verify that there is no
regression. Works fine.

> --Kyle
>
> ---- 8< ----
> Subject: [PATCH] config.mak.uname: set NO_APPLE_COMMON_CRYPTO on older systems
>
> Older MacOS systems prior to 10.5 do not have the CommonCrypto
> support Git uses so set NO_APPLE_COMMON_CRYPTO on those systems.
>
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> ---
>  config.mak.uname | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index 7846bd76..f8e12c96 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -88,6 +88,7 @@ ifeq ($(uname_S),Darwin)
>         NEEDS_LIBICONV = YesPlease
>         ifeq ($(shell expr "$(uname_R)" : '[15678]\.'),2)
>                 OLD_ICONV = UnfortunatelyYes
> +               NO_APPLE_COMMON_CRYPTO = YesPlease
>         endif
>         ifeq ($(shell expr "$(uname_R)" : '[15]\.'),2)
>                 NO_STRLCPY = YesPlease
> --
> 1.8.5
