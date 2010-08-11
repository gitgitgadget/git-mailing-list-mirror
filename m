From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2] git-am: Ignore whitespace before patches
Date: Wed, 11 Aug 2010 22:55:14 +0000
Message-ID: <AANLkTind7ZtTS+Fi-tOSE7ExgD1ubhpLuxYJgWYms2aE@mail.gmail.com>
References: <1273944188-9472-1-git-send-email-avarab@gmail.com>
	<1281556645-23361-1-git-send-email-avarab@gmail.com>
	<AANLkTin2DM-q7acST-x_Oz7jU-hODy8se6sngGxTDi_9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 00:55:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjKCh-0003l5-4V
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 00:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708Ab0HKWzR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 18:55:17 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47711 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab0HKWzR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 18:55:17 -0400
Received: by fxm13 with SMTP id 13so496250fxm.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 15:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=S64OzwcOo0H4ww5xVjcszoeC+Q04SRxrWhUbzwiydGE=;
        b=YwMwnMWfCWHCglqeyWF0uWTL4Ek+Z4MuBdXktOpvQ9DMvmXZbWBHKIOYFzrdn4LbZr
         Ls0knLgG7iTxwuv9zeDpSr5t+xUa6JC6uIz0jPxv0W78wf8TlxV6tz1Kzq0c38QLtbZf
         O7eyNgvxGN/lG3VOkueP7f/GEAESYXdWYY52Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bBuitqikZeCW1Hg4wK8T2oFwEDL2AI6SwV8EHhd46pe9sUjukMORRtNBn1qufcm0dv
         Kbm6xlDSm7WYuOrNtNo87/x0xF/EaUjb7dVGU8owSKh0J0I3I8TQY7+unjQQW/wkvR7n
         M24XBA8PYhV1Xw9vXvpfpvpZWOAiGuuE7OUXo=
Received: by 10.223.123.145 with SMTP id p17mr20828044far.90.1281567314071; 
	Wed, 11 Aug 2010 15:55:14 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Wed, 11 Aug 2010 15:55:14 -0700 (PDT)
In-Reply-To: <AANLkTin2DM-q7acST-x_Oz7jU-hODy8se6sngGxTDi_9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153309>

On Wed, Aug 11, 2010 at 22:50, Jon Seymour <jon.seymour@gmail.com> wrot=
e:
> On Thu, Aug 12, 2010 at 5:57 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
> <avarab@gmail.com> wrote:
>> Change git-am to ignore whitespace (as defined by sh's read) at the
>> beginning of patches.
>>
>> This makes git-am work with patches downloaded from the GMail web
>> interface, here's an example from a raw Gmail attachment produced wi=
th
>> `hexdump -C':
>>
>> =C2=A0 =C2=A020 20 20 20 20 20 20 20 =C2=A020 20 20 20 20 20 20 20 =C2=
=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
>> =C2=A0 =C2=A020 20 20 20 20 20 20 20 =C2=A020 20 20 20 20 20 20 0a =C2=
=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .|
>> =C2=A0 =C2=A052 65 74 75 72 6e 2d 50 =C2=A061 74 68 3a 20 3c 61 76 =C2=
=A0|Return-Path: <av|
>>
>> Having to tell GMail users that they must manually edit their patche=
s
>> before git-am will accept them (as this article does:
>> http://evag.evn.am/git/git-and-gmail) isn't optimal.
>
> This is a good point. Current behaviour discourages testing of patche=
s
> as delivered by e-mail since the GMail user is more likely to overloo=
k
> actual whitespace errors in a patch because they come to expect this
> usual failure.

Just to clarify, git-am doesn't print a whitespace error on GMail
patches currently, the detection just fails:

    $ git am ~/Desktop/mail.txt
    Patch format detection failed.

But with my patch:

    $ git am ~/Desktop/mail.txt
    Applying: git-am: Ignore whitespace before patches
