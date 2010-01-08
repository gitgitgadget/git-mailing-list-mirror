From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] mingw: disable Python
Date: Fri, 8 Jan 2010 14:55:49 +0100
Message-ID: <40aa078e1001080555w1656032dr7d5cc3ca52fffe7f@mail.gmail.com>
References: <40aa078e1001071400j21900ed1n415394491d469b8c@mail.gmail.com>
	 <1262902037-4420-1-git-send-email-kusmabite@gmail.com>
	 <4B46E7D6.3080702@viscovery.net>
	 <alpine.DEB.1.00.1001081135180.4272@intel-tinevez-2-302>
	 <40aa078e1001080249t16b0ee01i5ceb8e7ad2426e70@mail.gmail.com>
	 <7vpr5kpvmh.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, msysgit@googlegroups.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 14:55:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTFJk-0000m8-I9
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 14:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435Ab0AHNzx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jan 2010 08:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753096Ab0AHNzx
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 08:55:53 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:64124 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871Ab0AHNzw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 08:55:52 -0500
Received: by ewy19 with SMTP id 19so11953164ewy.21
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 05:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ViBdiczban7dTbuZ5JXSNWw4CKNJyTfX40KKSots/q0=;
        b=gwblGM3b0nN3N3tskwebTcSRRXnANWQcL8NTAYSQcaeI39pNYBJ+GRJ1PfY8ZElxtt
         aD+5XQx/kONMI0Y5GeXyMlT99VdKjlf1ynRncoLcjSiRNwt4XH3u4uKCznVmgYjeFF7o
         yW+nh6f0RnOGfoMkwx9HPg6oPvFMEYPNvYr7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=kTRhRDQ7RbI7BSi5uaT/dcFOE08Kcj8CUbbeNnGsuBsMf8hLI9LdHJ0/3C5BXoL4Od
         xAM+k7u9DRP5DuEWExjgs3ZjoAnUsAAzD31pdbCW4lkWOgEC0dsBxTBcwLRecWlc2cc4
         coGvwL/LIG5ZAlfMjy+FNxze6JVTLgs5YwONI=
Received: by 10.216.89.139 with SMTP id c11mr2523024wef.198.1262958949577; 
	Fri, 08 Jan 2010 05:55:49 -0800 (PST)
In-Reply-To: <7vpr5kpvmh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136438>

On Fri, Jan 8, 2010 at 2:35 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Erik Faye-Lund <kusmabite@googlemail.com> writes:
>
>>> On Fri, 8 Jan 2010, Johannes Sixt wrote:
>>>
>>>> Erik Faye-Lund schrieb:
>>>> > Python is not commonly installed on Windows machines, so
>>>> > we should disable it there by default.
>>>> >
>>>> > --- a/Makefile
>>>> > +++ b/Makefile
>>>> > @@ -1027,6 +1027,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>>>> > + =A0 NO_PYTHON =3D YesPlease
>>>>
>>>> I'm worried that with this solution it is impossible to re-enable =
Python
>>>> in config.mak (how do you undefine a Makefile variable?);
>>
>>> How about
>>>
>>> =A0 =A0 =A0 =A0NO_PYTHON=3D
>>>
>>> in config.mak?
>>
>> That doesn't work for me, at least not out of the box. NO_PYTHON is
>> still defined, it's just defined to an empty string.
>
> I think Dscho is right. =A0"ifdef FOO" yields (and should yield) fals=
e if
> FOO is set to empty.
>

In that case I guess I messed up my test. I'll retest.

Yes, I messed up. "NO_PYTHON=3D" works like a charm.

So, no repost :)

--=20
Erik "kusma" Faye-Lund
