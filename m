From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2/RFC] gitweb: Prepare for splitting gitweb
Date: Wed, 14 Jul 2010 23:21:24 +0200
Message-ID: <201007142321.26034.jnareb@gmail.com>
References: <1278496676-26575-1-git-send-email-jnareb@gmail.com> <201007141125.01863.jnareb@gmail.com> <AANLkTikDtlHwtk4j0E5vYViFVWtsV_yA5e90z-6nZb8_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 23:21:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ9Oj-0000Hi-P9
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 23:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757562Ab0GNVVk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 17:21:40 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50559 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756624Ab0GNVVj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 17:21:39 -0400
Received: by bwz1 with SMTP id 1so218694bwz.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 14:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=9uNE8xgm8QFq5FXPF8y108h1jpBHOyYyVmWBEY8sIG4=;
        b=ZebgqINQVwlpX/QOoLnTLIQ0yLWyhqtkBRdEpsZ6lQpe+6kzxhRPHH9X21/Z1AiRrU
         reaZnh/fHkuzrAKCfx5xz+YDVh/cHzfn9VvE0c2es4BczSnkIjCYwsXjMF/84VKg6kuo
         cmTgK8sTFz1P3x8iLn7alYEFDpnB6A5dTTqWM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Xm8tFIEUy6hGMNgTj2KU2xKext2PboqOXPybLCVO5aB1dZLybcBBHeoxofIDfCxohi
         nwF12VJC04WJuIlcnh9WjkihShTziRvo7bjWL0UJpv/qogLU9WiB8RRGbhc18Awhi0tv
         P8GSaM2X0d7aED6dWkAQrscVx/xOpEs2OVS0g=
Received: by 10.204.46.129 with SMTP id j1mr8154338bkf.144.1279142497093;
        Wed, 14 Jul 2010 14:21:37 -0700 (PDT)
Received: from [192.168.1.13] (abvm223.neoplus.adsl.tpnet.pl [83.8.210.223])
        by mx.google.com with ESMTPS id s34sm2127656bkk.13.2010.07.14.14.21.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Jul 2010 14:21:34 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTikDtlHwtk4j0E5vYViFVWtsV_yA5e90z-6nZb8_@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151036>

On Wed, 14 Jul 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Wed, Jul 14, 2010 at 09:24, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>> On Wed, 14 Jul 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>> On Tue, Jul 13, 2010 at 22:24, Jakub Narebski <jnareb@gmail.com> wr=
ote:
>>>
>>>> I wrote simple script that tests result of __DIR__ and $FindBin::B=
in.
>>>> For cgi-bin / mod_cgi it was:
>>>>
>>>> =C2=A0__DIR__ =C2=A0 =C2=A0 =C2=A0 =3D /var/www/cgi-bin/gitweb (sy=
mlink to /home/local/gitweb)
>>>> =C2=A0$FindBin::Bin =3D /home/local/gitweb
>>>>
>>>> For mod_perl (ModPerl::Registry handler) it was
>>>>
>>>> =C2=A0__DIR__ =C2=A0 =C2=A0 =C2=A0 =3D /var/www/perl/gitweb (symli=
nk to /home/local/gitweb)
>>>> =C2=A0$FindBin::Bin =3D /
>>>>
>>>> As you can see it's useless. =C2=A0I have't checked the FastCGI ca=
se...
>>>
>>> Thanks for spending time researching what was an offhand ignorant "=
hey
>>> wasn't .." comment. Also, sorry :)
>>
>> Nothing to it. =C2=A0I wanted to check if there really is a problem =
with
>> FindBin on mod_perl, as I was not sure with description in "Known Is=
sues"
>> section in FindBin manpage.
>>
>> Note that using 'FindBin->again();' after 'use FindBin;' fixes this
>> issue. =C2=A0So perhaps it would be beter to use FindBin than borrow=
 code
>> for __DIR__ from Dir::Self.
>=20
> That should work, though note that FindBin->again requires at least
> perl 5.8.3. This should work on older versions (if Gitweb cares):
>=20
>     if ($] <=3D 5.008003) {
>         delete $INC{'FindBin.pm'};
>         require FindBin;
>     } else {
>         FindBin->again;
>     }
>=20
> See https://rt.cpan.org/Public/Bug/Display.html?id=3D57988 and
> http://search.cpan.org/diff?from=3DModule-Install-0.98&to=3DModule-In=
stall-0.99
> for reference.

Thanks for research.

I don't think gitweb cares, as it requires Perl with sane Unicode suppo=
rt,
which means at least Perl 5.8.0 (for Encode module), but I think it rea=
lly
means at least 5.8.3

--=20
Jakub Narebski
Poland
