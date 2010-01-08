From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] mingw: disable Python
Date: Fri, 8 Jan 2010 11:49:22 +0100
Message-ID: <40aa078e1001080249t16b0ee01i5ceb8e7ad2426e70@mail.gmail.com>
References: <40aa078e1001071400j21900ed1n415394491d469b8c@mail.gmail.com>
	 <1262902037-4420-1-git-send-email-kusmabite@gmail.com>
	 <4B46E7D6.3080702@viscovery.net>
	 <alpine.DEB.1.00.1001081135180.4272@intel-tinevez-2-302>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, msysgit@googlegroups.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 08 11:49:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTCPJ-0003rj-3t
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 11:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038Ab0AHKtY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jan 2010 05:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489Ab0AHKtY
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 05:49:24 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:44021 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab0AHKtX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 05:49:23 -0500
Received: by ewy19 with SMTP id 19so11779896ewy.21
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 02:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CsyPKqHLjqpj8TjCYqSbXqrYh5oEuwgpP20GfT7HUCQ=;
        b=PTp/2hIMMFBQuHO2lErulncHTF67cYTgcbpTc/7H/EFWsmQiYKcHh5T01OpiL0vRp2
         DUUpi+UCnYmFenG0tz1jY4PovUR55pVfp9gwKsgCeXE2havsIodmfnF9M5GdofI+sshP
         Rnl7gieBCqSpjVe5arnZ9A0j45GUDtmLyMjIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=CfJl5slNhmeLxC842UnMXQJS/l6K4WnJbyeCEM2qKJv4o0/aO6/xMqumZ/XljNqZY6
         QPQXwvDeF5RSMCnbXyVm9jDCHYfriWBkJb0dmKWbfMAkz6LppUfTGfB34wK7C4w2chNG
         rLtaWsKMkWCuNXdQEUQPPPomuUaQuNT4hYYfc=
Received: by 10.216.86.129 with SMTP id w1mr1313693wee.145.1262947762209; Fri, 
	08 Jan 2010 02:49:22 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1001081135180.4272@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136423>

On Fri, Jan 8, 2010 at 9:07 AM, Johannes Sixt <j.sixt@viscovery.net> wr=
ote:
> Wouldn't it be superior to set
>
> =A0 =A0 =A0 =A0PYTHON_PATH =3D

Yes, I think it would. I've tested it (I've got Python 2.6 installed
in c:\Python26\, so with your fix I can re-enable it by setting
"PYTHON_PATH=3D/c/Python26/python.exe" in config.mak.

On Fri, Jan 8, 2010 at 11:35 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 8 Jan 2010, Johannes Sixt wrote:
>
>> Erik Faye-Lund schrieb:
>> > Python is not commonly installed on Windows machines, so
>> > we should disable it there by default.
>> >
>> > --- a/Makefile
>> > +++ b/Makefile
>> > @@ -1027,6 +1027,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>> > + =A0 NO_PYTHON =3D YesPlease
>>
>> I'm worried that with this solution it is impossible to re-enable Py=
thon
>> in config.mak (how do you undefine a Makefile variable?);

> How about
>
> =A0 =A0 =A0 =A0NO_PYTHON=3D
>
> in config.mak?
>

That doesn't work for me, at least not out of the box. NO_PYTHON is
still defined, it's just defined to an empty string. I guess we could
change to Makefile to accept empty NO_PYTHON as enabled, but since
Hannes' suggestion works fine, I think I'll stick with it, even if
it's a little inconsistent with the other stuff in the MinGW-section
of Makefile.

I'll resend a bit later.

--=20
Erik "kusma" Faye-Lund
