From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: [PATCH] attr: support quoting pathname patterns in C style
Date: Sat, 06 Nov 2010 09:28:34 +0100
Message-ID: <4CD511B2.3080200@syntevo.com>
References: <AANLkTinNctmWpshBeSTzZRm6+EJ=Cjdpoaj4Aon+52_b@mail.gmail.com> <1288878944-14066-1-git-send-email-pclouds@gmail.com> <7vvd4bu2pl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 06 09:31:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEeBD-0000oC-Id
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 09:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525Ab0KFI2n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Nov 2010 04:28:43 -0400
Received: from syntevo.com ([85.214.39.145]:45583 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752826Ab0KFI2m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Nov 2010 04:28:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTPSA id 11F2160812F
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b2 Thunderbird/3.1.6
In-Reply-To: <7vvd4bu2pl.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160834>

>>  Obvious regression: patterns that begin with double quote will
>>  now work differently.
>=20
> I'm really hesitant to pursue this route and break people's existing
> setups

If existing setups are an issue, there could be a config-property
"core.gitAttributesQuoting" to enable quoting which will only be set fo=
r
newly created repositories. Personally, I don't think this effort is
necessary. Probably there is not even a single .gitattributes with a
leading quotation mark. And if there is, it's easy to fix.

In any case, I think future git repositories and users will be grateful
for quoting support: after I noticed problems with a tool-generated(!)
=2Egitattributes files, it took me 5 minutes to try: \-quoting, "-quoti=
ng
and octal-quoting, but more than 1 hour of googling, looking at git
sources and finally writing an email to this list :)

Marc.


On 05.11.2010 17:58, Junio C Hamano wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>=20
>> Full pattern must be quoted. So 'pat"t"ern attr' will give exactly
>> 'pat"t"ern', not 'pattern'. Also clarify that leading whitespaces ar=
e
>> not part of the pattern and document comment syntax.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  Obvious regression: patterns that begin with double quote will
>>  now work differently.
>=20
> I'm really hesitant to pursue this route and break people's existing
> setups, especially if the only benefit this patch tries to achieve is=
 to
> allow somebody to say:
>=20
>     "Program Files/*.txt" ...some attr...
>=20
> It is not worth the effort, risk and headache, especially because peo=
ple
> with such paths are probably already using
>=20
>     Program?Files/*.txt	...some attr..
>=20
> to match them.
>=20
>=20
