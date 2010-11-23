From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 5/6] msvc: opendir: handle paths ending with a slash
Date: Tue, 23 Nov 2010 21:16:44 +0100
Message-ID: <4CEC212C.9060605@lsrfire.ath.cx>
References: <1290537509-360-1-git-send-email-kusmabite@gmail.com> <1290537509-360-6-git-send-email-kusmabite@gmail.com> <4CEC1677.6000207@lsrfire.ath.cx> <AANLkTimkPMCAmpobetAvWjcGDt+G_wMdX+cXaf9-Z_v9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	gitster@pobox.com, jrnieder@gmail.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Nov 23 21:16:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKzIN-0000ZT-Cw
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 21:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399Ab0KWUQt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 15:16:49 -0500
Received: from india601.server4you.de ([85.25.151.105]:41056 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab0KWUQt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 15:16:49 -0500
Received: from [10.0.1.100] (p4FFD8C84.dip.t-dialin.net [79.253.140.132])
	by india601.server4you.de (Postfix) with ESMTPSA id 2C4862F8037;
	Tue, 23 Nov 2010 21:16:47 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <AANLkTimkPMCAmpobetAvWjcGDt+G_wMdX+cXaf9-Z_v9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162022>

Am 23.11.2010 20:48, schrieb Erik Faye-Lund:
> On Tue, Nov 23, 2010 at 8:31 PM, Ren=E9 Scharfe
> <rene.scharfe@lsrfire.ath.cx> wrote:
>> Am 23.11.2010 19:38, schrieb Erik Faye-Lund:
>>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>>> ---
>>>  compat/msvc.c |    2 ++
>>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/compat/msvc.c b/compat/msvc.c
>>> index 199eb22..fdbfb70 100644
>>> --- a/compat/msvc.c
>>> +++ b/compat/msvc.c
>>> @@ -23,6 +23,8 @@ DIR *opendir(const char *name)
>>>
>>>       /* check that the pattern won't be too long for FindFirstFile=
A */
>>>       len =3D strlen(name);
>>> +     if (is_dir_sep(name[len - 1]))
>>
>> Perhaps extend this thus, and handle multiple slashes?
>>
>>        while (len > 0 && is_dir_sep(name[len - 1]))
>>
>>> +             len--;
>>>       if (len + 2 >=3D MAX_PATH) {
>>>               errno =3D ENAMETOOLONG;
>>>               return NULL;
>=20
> Sure, it could be done. But the reason why I didn't do that myself wa=
s
> that I got a bit worried about this being a slippery slope towards
> full path-normalization. FindFirstFileA() does handle non-normalized
> paths, as long as they are below MAX_PATH in length.
>=20
> I just didn't want to add a slash if there was already one there,
> which is something different than trying to fix the input-path.
>=20
> In other words, I'm not entirely sure if fixing up such a case is a
> task that belongs to opendir.

Okay; based on the subject of the patch I had assumed that opendir()
wasn't working at all on paths with trailing slashes.

Ren=E9
