From: Michael Horowitz <michael.horowitz@ieee.org>
Subject: Re: [PATCH] git-p4 submit: prevent 'Jobs' section from being removed
 from p4 change log
Date: Sat, 26 Feb 2011 11:20:10 -0500
Message-ID: <AANLkTimuOn0AD8nB1kXBA60y9bgmB1FfciJSbBJeAQd-@mail.gmail.com>
References: <AANLkTimdd_AdVyDGKyLUoOABuRjJ5QmpC3DnMQYRRcNm@mail.gmail.com>
	<7vk4gn8cwm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 26 17:20:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtMsU-0004vD-UB
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 17:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471Ab1BZQUM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Feb 2011 11:20:12 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:50726 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab1BZQUL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Feb 2011 11:20:11 -0500
Received: by qyg14 with SMTP id 14so2273910qyg.19
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 08:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7ESCSYuedJ5ZuXF8Ef2qFCuSMsTMevGpq1Y1lPe4Hb0=;
        b=s7LR8DIVCBtkuytVIzSo35MBNcB4XdV5BcUuapNR5AIB9voNaehXga2d+I67Dx4oP2
         yNoOisx8SzqmpFTWrByHulhSvLLukLB1IeBnX5dNoGNXaZgO6FOr9ZE/hTXTi2646jS+
         B50NVxwGjt3t3GiAzF6tHUYWS49JAA0eGR9fU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=V/g0FGQx6bJhPCD1An0B/d1HmvQA0DcR2+4YjYNfGHcUifr3+UCD/5rGTC1ePEkxOT
         sm5As0603NRh9fEwhYIFhtsxsAwnSZfSESI5LQ+YeyRIgqYouXQOXULI8FoDNoPgRBs3
         BguE0IiWFBueAOXFYcv+UF/Z2+JTFX5JodMA4=
Received: by 10.229.184.13 with SMTP id ci13mr2804472qcb.134.1298737210228;
 Sat, 26 Feb 2011 08:20:10 -0800 (PST)
Received: by 10.229.84.2 with HTTP; Sat, 26 Feb 2011 08:20:10 -0800 (PST)
In-Reply-To: <7vk4gn8cwm.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: l7VIb9WTQQ_7xyo84Uw-d5xFAUQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167985>

On Sat, Feb 26, 2011 at 2:37 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Michael Horowitz <michael.horowitz@ieee.org> writes:
>
>> In an attempt to overwrite the 'Description:' section of the p4 chan=
ge
>> log to include the git commit messages, it also overwrote the 'Jobs:=
'
>> section. =A0This fix restores the 'Job:' section.
>>
>> Signed-off-by: Michael Horowitz <michael.horowitz@ieee.org>
>> ---
>> =A0contrib/fast-import/git-p4 | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
>> index a92beb6..8b00fd8 100755
>> --- a/contrib/fast-import/git-p4
>> +++ b/contrib/fast-import/git-p4
>> @@ -570,7 +570,7 @@ class P4Submit(Command):
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 if inDescriptionSection:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if line.startswith("Files:"):
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if line.startswith("Files:") or lin=
e.startswith("Jobs:"):
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 inDescriptionSection =3D Fal=
se
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue
>
> This is not a new issue with the code, but it makes me wonder if the
> output you are reading from guaranteed to have these lines in the sam=
e
> order. =A0Otherwise the next bug report and/or patch would add anothe=
r
> similar looking line.startswith("SomethingElse:") to this statement, =
and
> we wouldn't know when to stop, would we?
>
> Will queue anyway, though. =A0Thanks.
>
>

Yes, you are correct, it could be written in a more robust way.
Ideally, with a proper spec, the parser can be written to handle all
the cases.  Unfortunately, I am not familiar enough to do much more
than fix the immediate issue I am having.  I only know enough Python
to make this simple change, and it seems to work in my tests.

Thanks,

Mike
