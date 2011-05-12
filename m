From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 20/48] i18n: git-submodule die + eval_gettext messages
Date: Thu, 12 May 2011 15:48:22 +0200
Message-ID: <BANLkTik98wsBvoHNtausLBw0F1FqdDhAuQ@mail.gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
	<1304857280-14773-21-git-send-email-avarab@gmail.com>
	<4DCB9592.2090503@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 12 15:48:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKWFh-0007C4-0o
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 15:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757333Ab1ELNsY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 May 2011 09:48:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50653 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757075Ab1ELNsX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2011 09:48:23 -0400
Received: by fxm17 with SMTP id 17so1091813fxm.19
        for <git@vger.kernel.org>; Thu, 12 May 2011 06:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OtYlm0h8Ncf1R11xrFHxmko+mze8d2YyYcpFyzkW3xA=;
        b=WBM6FbcGsUlw/471o40DAGwB6ZRLpgB59wIRTbdmzRjkKgP3FlOVGftTZpB4Zmop92
         bZ/Yex1cdLOO08Tt1AvcOCkDSvmCqt3EjX8rkyQxvGGYu8AkeY3oSUnJQodjaJ2KaMJw
         Ubpyfxu5je6tlvMOmnIskUz6MjOX4zY+nhIEs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MBc+tQfQ7Ntd8IVMISRPDcfGKHHhNxah++U22uc3AdWj/fYk+NvzXMH1daiHtVoFi/
         yfrVCT0iL9ZlRbADMaeztVTcRCnuyEesEd5lNZmBW/RrtaWmbN8A27kT3vjO8BGwXZY3
         /CzGm8gTGDcVmFpwA1CO2HhNDQyvkDICJUwWg=
Received: by 10.223.127.210 with SMTP id h18mr288363fas.67.1305208102619; Thu,
 12 May 2011 06:48:22 -0700 (PDT)
Received: by 10.223.105.9 with HTTP; Thu, 12 May 2011 06:48:22 -0700 (PDT)
In-Reply-To: <4DCB9592.2090503@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173469>

On Thu, May 12, 2011 at 10:08, Johannes Sixt <j.sixt@viscovery.net> wro=
te:
> Am 5/8/2011 14:20, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 say "Submodule '$name' (=
$url) registered for path '$path'"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 say "$(eval_gettext "Sub=
module '\$name' (\$url) registered for path '\$path'")"
>
> On Windows, we have a problem with messages like this (and many other=
s)
> that reference $path. eval_gettext has to export 'path', but on Windo=
ws
> environment variables are case-insensitive. In the substitution, this
> happens to pick the value of 'PATH' rather than of 'path'... Can you =
do
> something about this?
>
> Of course, the problem is not limited to 'path' at all, but it is a
> prominent example discovered by the test suite.

I didn't know Windows had that limitation. We can easily work around
it by just renaming $path to something else (e.g. $filepath).

Since we do:

    export PATH $(git sh-i18n--envsubst --variables "$1");

I assume this problem only occurs with variables that match
/^path$/i. Or are there other problems on Windows?

I don't have a Windows machine, and I'm not about to buy a license. So
getting the output of the failing test suite would be very useful if
this happens for variables other than $path.

If it's only $path I'll just change it to something else and include
that change in v2 of the series.
