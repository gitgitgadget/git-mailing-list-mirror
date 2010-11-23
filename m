From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [RFC PATCH 5/6] msvc: opendir: handle paths ending with a slash
Date: Tue, 23 Nov 2010 18:47:51 +0100
Message-ID: <AANLkTi=Yg2Dz7DgtixWBbvbUn_rrdJcgqMYiBqHFwosb@mail.gmail.com>
References: <1290533444-3404-1-git-send-email-kusmabite@gmail.com>
 <1290533444-3404-6-git-send-email-kusmabite@gmail.com> <20101123174351.GD12113@burratino>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 18:48:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKwyY-0005Jl-HZ
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 18:48:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755827Ab0KWRsN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 12:48:13 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48120 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755218Ab0KWRsN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 12:48:13 -0500
Received: by fxm13 with SMTP id 13so4106707fxm.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 09:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=bdTF/9QjGSn3DPrjCIl/Wdli3pOhBgym3I0rjpLIYgE=;
        b=YH0FMTs325lPJuirUwMlEIqUsVwDG5FG8ry6V3EBupjOQ+TYncfvAd3FwfVEw6henA
         V/U3wdfQg9C6Zc3W9f7go8Z13p186VXKSAsT1BfojWWbz1NKxmVqMnTO1CgRlacTvLM/
         QJU2w9QgdBjR4V6iAEOsxh5ZkSHboorqOHp8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=JTs+cND274pTIRSm4+AyXXOQroPhUEolZHqOtrPQT5R5oeOAlqfCNsXEe4qByVkuQx
         aueRPHH9VgLDlQDYgsVvXbMlPNhHVkWw/jSa2oIYd0knDv7mQ5wf0FJcRM90LpPYA24i
         hWAvL2ARY4PDPILk8fvbxxIIQM/m6XjKHxTj4=
Received: by 10.223.71.198 with SMTP id i6mr6049039faj.140.1290534491792; Tue,
 23 Nov 2010 09:48:11 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Tue, 23 Nov 2010 09:47:51 -0800 (PST)
In-Reply-To: <20101123174351.GD12113@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161997>

On Tue, Nov 23, 2010 at 6:43 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Erik Faye-Lund wrote:
>
>> --- a/compat/msvc.c
>> +++ b/compat/msvc.c
>> @@ -23,6 +23,8 @@ DIR *opendir(const char *name)
>>
>> =A0 =A0 =A0 /* check that the pattern won't be too long for FindFirs=
tFileA */
>> =A0 =A0 =A0 len =3D strlen(name);
>> + =A0 =A0 if (is_dir_sep(name[len - 1]))
>> + =A0 =A0 =A0 =A0 =A0 =A0 len--;
>
> I assume len can't be 0?
>

Nope, in that case GetFileAttributesA would have errore out.
