From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] bundle: rewrite builtin to use parse-options
Date: Thu, 8 Dec 2011 22:17:39 +0530
Message-ID: <CALkWK0mmjKSzSbxq2i7=JvcB4LTro-MYDCwQLUUwqcf8qS0zPA@mail.gmail.com>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323349817-15737-4-git-send-email-artagnon@gmail.com> <20111208163946.GB2394@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 17:48:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYh8j-0005I3-C4
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 17:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161Ab1LHQsE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Dec 2011 11:48:04 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:37382 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137Ab1LHQsB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Dec 2011 11:48:01 -0500
Received: by qcqz2 with SMTP id z2so1451716qcq.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 08:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=bxfGrn2u25OVBxXDZZEgmkus2G7hpkT8G/pN+3i8Ltc=;
        b=AwHvlkJTyNrvv2j7ztBKXIexCUOnlK1HpLSLuhmdBDJCpwNxdY2zSqBeEWXM5Zic7J
         4hmEg3H8Vw6oVFUtegyqZvxE8QpJL1X5XtkKvjahaHXiG+B5i1i27mBG1jzUIyrsg+Ln
         o/jKq79x1pEjjFroYDo/ywLI6MeRzeArPTGyk=
Received: by 10.229.67.142 with SMTP id r14mr982850qci.240.1323362880343; Thu,
 08 Dec 2011 08:48:00 -0800 (PST)
Received: by 10.229.165.194 with HTTP; Thu, 8 Dec 2011 08:47:39 -0800 (PST)
In-Reply-To: <20111208163946.GB2394@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186572>

Hi,

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
>> - =C2=A0 =C2=A0 if (argc < 3)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usage(builtin_bundle_usa=
ge);
>> -
>> - =C2=A0 =C2=A0 cmd =3D argv[1];
>> - =C2=A0 =C2=A0 bundle_file =3D argv[2];
>> - =C2=A0 =C2=A0 argc -=3D 2;
>> - =C2=A0 =C2=A0 argv +=3D 2;
>> + =C2=A0 =C2=A0 argc =3D parse_options(argc, argv, NULL,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 options, builtin_bundle_usage,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN);
>
> Doesn't this make the usage completely confusing? =C2=A0Before, if I =
wanted
> to create bundle named "verify", I could write
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git bundle create verify
>
> Afterwards, not only does that not work, but if I make a typo and
> write
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git bundle ceate verify
>
> then it will act like "git bundle verify ceate".

No it won't -- it'll just print out the usage because "verify" and
"create" are mutually exclusive options.  Sure, you can't create a
bundle named "verify", but that's the compromise you'll have to make
if you don't want to type out "--" with each option, no?

> I am starting to suspect the first half of patch 1/2 was not such a
> great idea, either. :) =C2=A0Do you have other examples of how it wou=
ld be
> used?

Hehe, my lack of foresight is disturbing as usual.  I'm not yet sure
it'll be useful.

-- Ram
