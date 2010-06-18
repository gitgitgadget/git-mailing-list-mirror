From: =?ISO-8859-1?Q?T=F6r=F6k_Edwin?= <edwintorok@gmail.com>
Subject: Re: [PATCH] Fix 'git clean' failure on NFS.
Date: Fri, 18 Jun 2010 16:50:05 +0300
Message-ID: <4C1B798D.5020305@gmail.com>
References: <loom.20100618T122039-876@post.gmane.org>	<1276859235-13534-1-git-send-email-edwintorok@gmail.com>	<AANLkTimm1XMmDORpnezYHSNPrKFup2H5ODQLrgJivDwg@mail.gmail.com>	<4C1B6E13.1030309@gmail.com> <AANLkTinEGpB567-v8TXFv5ghXfjY9ZtkOMYcGOhzePj3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	git <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Jun 18 15:50:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPbxf-0007wa-BB
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 15:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932991Ab0FRNuN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jun 2010 09:50:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38701 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932416Ab0FRNuL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 09:50:11 -0400
Received: by fxm10 with SMTP id 10so624075fxm.19
        for <git@vger.kernel.org>; Fri, 18 Jun 2010 06:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        bh=vLpM/tMd5kpnS2yVgL9pwfWHQRz1dyOY+XgCVBOXjaY=;
        b=IY0auRyTccbMXbN/1zpWS8Ar6jli5tzE4dGhSLMXLsgx02Ni+YeMwBVCx620viHTFb
         HrQrUsmTLmV3p3VmgiO/cxMqmj/TyiW8Z8ibacsRqXS4QBT6kpZCM6U+DM2uW5kHyymR
         +m+Z0o+Jvd3cTR4uPZCOACE7DmtLqEwD3dJEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:openpgp:content-type
         :content-transfer-encoding;
        b=vMVIZ9t19RnbLuUBUnAs3PKGt7xdPAgDahWT+ntIwLqNz4cQYGAcIWd1k61FHhiFKP
         O17/7aI4oJPL2x9wyPseGYL+mAMNDDlWfZY9MBlu5m9Dw1B/+uUPXPB7ktPt6QltzUnu
         QkMTN1dvu39yDomvLPRNt9qj6fich0uFcUKYg=
Received: by 10.223.26.154 with SMTP id e26mr895577fac.57.1276869009800;
        Fri, 18 Jun 2010 06:50:09 -0700 (PDT)
Received: from debian ([79.114.67.113])
        by mx.google.com with ESMTPS id o19sm17405171fal.23.2010.06.18.06.50.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jun 2010 06:50:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by debian (Postfix) with ESMTP id 914D412171E;
	Fri, 18 Jun 2010 16:50:06 +0300 (EEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100515 Icedove/3.0.4
In-Reply-To: <AANLkTinEGpB567-v8TXFv5ghXfjY9ZtkOMYcGOhzePj3@mail.gmail.com>
X-Enigmail-Version: 1.0.1
OpenPGP: id=5379965D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149347>

On 2010-06-18 16:26, Erik Faye-Lund wrote:
> 2010/6/18 T=F6r=F6k Edwin <edwintorok@gmail.com>:
>> On 06/18/2010 03:29 PM, Erik Faye-Lund wrote:
>>> 2010/6/18 T=F6r=F6k Edwin <edwintorok@gmail.com>:
>>>> readdir() used to do a single pass, which is not always enough.
>>>> If you unlink some files/rmdir some subdirs then there might be so=
me
>>>> files you haven't seen yet *before* the readdir cursor (files get =
rearranged
>>>> in the directory, etc.).
>>>>
>>>> The fix is to do an additional readdir() pass if we unlinked/rmdir=
ed something.
>>>> This is easily accomplished by using rewinddir.
>>>>
>>>
>>> Won't this break on Windows? mingw_readdir() doesn't seem to have a
>>> maching mingw_rewinddir() in compat/mingw.c/h....
>>>
>>
>> rewinddir() is used in ClamAV too, and it builds natively on win32.
>> I think we have some compat function that map rewinddir to the Win32
>> API, somebody will probably have to do that for git too.
>>
>=20
> There's a rewinddir function in msvcrt.dll. However, we're not using
> msvcrt.dll's opendir() implementation for performance reasons, so thi=
s
> patch would require a rewinddir implementation as a preparation path,
> no? If such a patch could be extracted from ClamAV (and ClamAV is
> license compatible with git

ClamAV is GPLv2 only. git is the same AFAICT, so it should be fine.

>), would you mind including such a patch
> for the next round?

Will try to do that later today.

>=20
>> Another possibility is to do closedir/opendir again on mingw.
>=20
> Yes. Yet another possibility is to enable the
> NO_MINGW_REPLACE_READDIR-switch, but this has negative performance
> effects...
>=20

I'd rather not do that.

Best regards,
--Edwin
