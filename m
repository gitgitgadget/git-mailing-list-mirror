From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] contrib: add a credential helper for Mac OS X's keychain
Date: Wed, 14 Sep 2011 09:31:42 -0400
Message-ID: <CAG+J_Dw-vf7FtyT-vPpj-LHBo0rCBJi39bHh=8vWjc52QBMM2A@mail.gmail.com>
References: <1315683874-95583-1-git-send-email-jaysoffian@gmail.com>
	<CAEBDL5UprYM0=SgNQrsY8_aCGf+pxKc1NP0AFjJy8igzt3vDZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <junio@kernel.org>,
	Jeff King <peff@peff.net>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Wed Sep 14 15:31:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3pZ6-0001aM-N4
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 15:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932742Ab1INNbn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Sep 2011 09:31:43 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61769 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932735Ab1INNbn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2011 09:31:43 -0400
Received: by gwb15 with SMTP id 15so1541829gwb.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 06:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=p/WBvvm/CfIH0NsQVhhKpVXYG5Pur2Lmit9QAaLLNOU=;
        b=mgqnQZa/Kw6KOzOdgaKlUhGowQ9UHeWFcC6fsEOB/cW7AcPf1BV9y0mFCZRCV/q0XK
         kYPpqnKW0bEh0w9PtE3VVeMG/XT+UdcuRrbBXajArC7nsSr7Zz0nksUHAkn/L/NTngct
         m0kKi0vOJoHOJEZb0qZd+uLjxSgewBL6BUG5k=
Received: by 10.236.190.200 with SMTP id e48mr40910763yhn.59.1316007102498;
 Wed, 14 Sep 2011 06:31:42 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Wed, 14 Sep 2011 06:31:42 -0700 (PDT)
In-Reply-To: <CAEBDL5UprYM0=SgNQrsY8_aCGf+pxKc1NP0AFjJy8igzt3vDZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181359>

On Wed, Sep 14, 2011 at 4:01 AM, John Szakmeister <john@szakmeister.net=
> wrote:
>> +def add_internet_password(protocol, hostname, username, password):
>> + =C2=A0 =C2=A0# We do this over a pipe so that we can provide the p=
assword more
>> + =C2=A0 =C2=A0# securely than as an argument which would show up in=
 ps output.
>> + =C2=A0 =C2=A0# Unfortunately this is possibly less robust since th=
e security man
>> + =C2=A0 =C2=A0# page does not document how to quote arguments. Empr=
ically it seems
>> + =C2=A0 =C2=A0# that using the double-quote, escaping \ and " works=
 properly.
>
> I'm not sure this comment is correct... it looks like you're passing
> the password on the command line...
>
>> + =C2=A0 =C2=A0username =3D username.replace('\\', '\\\\').replace('=
"', '\\"')
>> + =C2=A0 =C2=A0password =3D password.replace('\\', '\\\\').replace('=
"', '\\"')
>> + =C2=A0 =C2=A0command =3D ' '.join([
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0'add-internet-password', '-U',
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0'-r', protocol,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0'-s', hostname,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0'-a "%s"' % username,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0'-w "%s"' % password,
>
> ...right here. :-(

Nope, you snipped out too much context. That command is turned into a
string and then sent to /usr/bin/security on its stdin. It is
absolutely not passed on the command-line.

j.
