From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH/RFC] core.precomposeunicode is true by default
Date: Sun, 28 Jul 2013 00:53:01 +0200
Message-ID: <51F44F4D.7030106@web.de>
References: <201307270321.32398.tboegi@web.de> <CACsJy8AT--3Lus-3F4-8EHL_3--a-98RkJxaMMALaSjgV+D3WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 28 00:53:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3DMh-0000dZ-AL
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jul 2013 00:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812Ab3G0WxG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Jul 2013 18:53:06 -0400
Received: from mout.web.de ([212.227.15.4]:57815 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752805Ab3G0WxF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jul 2013 18:53:05 -0400
Received: from [10.11.191.224] ([65.118.153.130]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0MbyIM-1UkzRw3rV8-00JK9W for <git@vger.kernel.org>;
 Sun, 28 Jul 2013 00:53:03 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <CACsJy8AT--3Lus-3F4-8EHL_3--a-98RkJxaMMALaSjgV+D3WQ@mail.gmail.com>
X-Provags-ID: V03:K0:gO0kx2frTht5gyLBvTtiNTo/du6eFPIhDbrBqexi6DPIhurjtrj
 BtSAcBp5stR8DmOIQCCjHHFeaBIWQ0wM0XbbxsJ9u8rV3JPdNIhkKRAcAkQUWXWR6tkVGY/
 DaS4agcL9tembaUfZb/nU8lxw63+Yt2gOrW4OPq38jTVI4G+pJrZ4pw2fy1wJWbCzli5/dz
 ZZz56Kvh9nS9TC6K/Tr3g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231254>

On 2013-07-27 17.23, Duy Nguyen wrote:
> On Sat, Jul 27, 2013 at 8:21 AM, Torsten B=C3=B6gershausen <tboegi@we=
b.de> wrote:
>> When core.precomposeunicode was introduced, it was set to false
>> by default, to be compatible with older versions of Git.
>>
>> Whenever UTF-8 file names are used in a mixed environment,
>> the Mac OS users need to find out that this configuration exist
>> and set it to true manually.
>>
>> There is no measurable performance impact between false and true.
>> A smoother workflow can be achieved for new Git users,
>> so change the default to true:
>>
>> - Remove the auto-sensing
>> - Rename the internal variable into precompose_unicode,
>>   and set it to 1 meaning true.
>> - Adjust and clean up test cases
>>
>> The configuration core.precomposeunicode is still supported.
>=20
> Does this have any effects on non-utf8 users? I'm on utf-8, so this i=
s
> not really my concern, that is unless it changes something on LANG=3D=
C..
>=20
Not sure if I fully understand the question.

Mac OS will always use UTF-8, and we can choose between
precomposesd and decomposed.

Windows ("Git for Windows" =3D=3D msysgit) uses UTF-8 (precomposed)
Git under cygwin 1.7 uses UTF-8, precomposed.
Git under cygwin 1.5 or git compiled under mingw does not use
UTF-8, but a Windows code page"

Linux may use UTF-8 or ISO-8859 or whatever you configure.

This change affects only Mac OS,=20
(should this be stated better in the commit MSG?)

And if somebody wants to change a repo between Linux, Windows
and/or Mac OS, everybody should use UTF-8 (precomposed) for filenames,
directories and branches.
(or stick to ASCII)
Does this answer the question?
/Torsten


=20
