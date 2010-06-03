From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH GSoC 1/3] gitweb: Create Gitweb::Config module
Date: Thu, 3 Jun 2010 20:43:13 +0200
Message-ID: <201006032043.14071.jnareb@gmail.com>
References: <1275573356-21466-1-git-send-email-pavan.sss1991@gmail.com> <201006031755.29814.jnareb@gmail.com> <AANLkTimoA95U0vivTzrc0XZ8i6q-SfCFA6RgMWK67OWl@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 20:43:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKFNy-0007Kf-2n
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 20:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941Ab0FCSnR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jun 2010 14:43:17 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:54354 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755645Ab0FCSnQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 14:43:16 -0400
Received: by fg-out-1718.google.com with SMTP id d23so573642fga.1
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 11:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ByXHXaOx8H42r8Y+1gANWcWpezjltuJw8iPL2y0vobQ=;
        b=lBP/nyQ1KNvX38xjvQN6lch4OjoSGmobZfDQoWtt+d6+MOLo7FS3OrtUHAQ8iW3xZW
         stTT5A1Dmc/YvlWhNZBCZ8dwzBWAW8C3F4PNON8iAaSDP4OV6t/jHkSB+42bhBG+s+9I
         rfFOyjCmEcn9Ob3j+71sKL8IH6bxANm9xLKdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=XLZ87ttDHp/PevLKDTdYEHC63GpJA6hEOQAL5pvcy1rmZp/e7t7+WVBV5jTs28YRSx
         WDJK45aqu8HyPjvi9f8+afhUCKa6Ny46+0L+wIG58nv3BYOZwKHdSHYTX0/v58y3tN9J
         VYR7IBHKRxo8TU6Z5RmhdLBipiZilhGOt4R/Q=
Received: by 10.87.42.2 with SMTP id u2mr16324001fgj.79.1275590594940;
        Thu, 03 Jun 2010 11:43:14 -0700 (PDT)
Received: from [192.168.1.15] (abvx149.neoplus.adsl.tpnet.pl [83.8.221.149])
        by mx.google.com with ESMTPS id d13sm488754fka.32.2010.06.03.11.43.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Jun 2010 11:43:14 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTimoA95U0vivTzrc0XZ8i6q-SfCFA6RgMWK67OWl@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148352>

Pavan Kumar Sunkara wrote:
> 2010/6/3 Jakub Narebski <jnareb@gmail.com>:
>> On Tue, 3 Jun 2010, Petr Baudis wrote:

>>>> +
>>>> +use Gitweb::Config;
>>>>
>>>> =A0BEGIN {
>>>> =A0 =A0 CGI->compile() if $ENV{'MOD_PERL'};
>>>> =A0}
>>>>
>>>> -our $version =3D "++GIT_VERSION++";
>>>> +$version =3D "++GIT_VERSION++";
>>
>> This change is not necessary.
>>
>> =A0our $version =3D "++GIT_VERSION++";
>>
>> would keep working even if '$version' is declared in other module an=
d
>> exported by this module (is imported into current scope).
>=20
> Ok. Will change it.

[...]
>> I would say
>>
>> =A0 =A0 =A0 =A0our $GIT =3D "++GIT_BINDIR++/git";
>=20
> But, I think when we start reading the code, it would seem that 'our
> $GIT' implies that it is a variable created locally rather than an
> exported variable from Gitweb::Config module.

=46rom `perldoc -f our`:

  An "our" declares the listed variables to be valid globals within the
  enclosing block, file, or "eval".  That is, it has the same scoping
  rules as a "my" declaration, but does not create a local variable.

  [...] The package in which the variable is entered is determined at
  the point of the declaration, [...]


So if the variable already exists in given scope, for example if the
variable was imported from other package, the 'our' declaration would
be a no-op.

>=20
> Even though it increases the patch size, I don't think it will be muc=
h
> of a concern when it comes to good redability of code.
>=20
> Jakub: Can you reply, what you think about this argument ?

But I agree that first, 'our $var' seems to imply that it is _new_
variable declared in current scope, and second if we make a typo in
variable name it wouldn't be detected as different from exported
variable: 'our' will create new variable.

So I agree that removing 'our' is a good idea, especially together
with putting all variables that should be there in Gitweb::Config
together with comments, even if they are configured during build
process.

Perhaps those declarations in Gitweb::Config should have in-line
comment that they are defined in gitweb.cgi / gitweb.perl?

--=20
Jakub Narebski
Poland
