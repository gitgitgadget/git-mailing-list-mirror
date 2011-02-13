From: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
Subject: Re: [PATCH] Don't optimize code in debug build
Date: Sun, 13 Feb 2011 17:26:51 +0100
Message-ID: <AANLkTinECgZwFZ0157O-qvYUW1GpJgbsHDekR1WM6gPm@mail.gmail.com>
References: <AANLkTinw7DJ3hP7ACcScHTYy-Dvizq-OxefP6e0dEBbR@mail.gmail.com>
	<201102131036.51311.j6t@kdbg.org>
	<AANLkTim6OHU8N7t5RQnt6S7x7ez48RSwp=b82McAC4Oq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 13 17:27:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Poemv-0000dr-5Z
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 17:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678Ab1BMQ0y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Feb 2011 11:26:54 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57063 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604Ab1BMQ0x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Feb 2011 11:26:53 -0500
Received: by vws16 with SMTP id 16so2585108vws.19
        for <git@vger.kernel.org>; Sun, 13 Feb 2011 08:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=t8TlGyRB4ayNAbuxI/Z333EntuqDWH8zmswdD/NiGBw=;
        b=FZHUt19f4AeLctUsa1YXZhiHqCb01N5hqcNoBRxJ0deg+UyKzaNGWhXTRFRbjTm3Cx
         RZ8TrX6euLYnvHnWVjVpayDqxz6Y6XPf6gfrYUagUq/1UQK6VTwmwj92v6CxnjCbFhVK
         d7ZXpYzQqkjoHqGeHnoUYwwewuz5uKIl8nBfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=XUBd+2qa39Um/asJuK6cs8ksNX2657oZvkXPMYJCQL7PIzizBiKKlNFqN+RovAYMhE
         QBgY66td3P4iuKn3fXG3mWuabnhafVhzUeLRBuIgrhopDrpp0r6teGaWF5eOfRGIQzLK
         VwLj8uI2EWhlpA2ZLrPv/MaldQK9Jr9iQEbG8=
Received: by 10.220.189.205 with SMTP id df13mr2416521vcb.211.1297614412069;
 Sun, 13 Feb 2011 08:26:52 -0800 (PST)
Received: by 10.220.195.132 with HTTP; Sun, 13 Feb 2011 08:26:51 -0800 (PST)
In-Reply-To: <AANLkTim6OHU8N7t5RQnt6S7x7ez48RSwp=b82McAC4Oq@mail.gmail.com>
X-Google-Sender-Auth: mg0nMSeVyvGP4nNlbKErEBQS5cE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166671>

(forgot about the list when replying)

> On Sun, Feb 13, 2011 at 10:36 AM, Johannes Sixt <j6t@kdbg.org> wrote:
>> On Sonntag, 13. Februar 2011, Piotr Krukowiecki wrote:
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -262,7 +262,10 @@ endif
>>>
>>> =A0# CFLAGS and LDFLAGS are for the users to override from the comm=
and line.
>>>
>>> -CFLAGS =3D -g -O2 -Wall
>>> +CFLAGS =3D -g -Wall
>>> +ifndef DEBUG
>>> +CFLAGS +=3D -O2
>>> +endif
>>> =A0LDFLAGS =3D
>>> =A0ALL_CFLAGS =3D $(CPPFLAGS) $(CFLAGS)
>>> =A0ALL_LDFLAGS =3D $(LDFLAGS)
>>
>> Instead of this, you can just write
>>
>> =A0CFLAGS =3D -g -Wall
>>
>> in your config.mak. Is anything wrong with that?

Several things: I need to know I should remove -O2, I need to keep in
sync with other default options, current default is less useful, it
requires me to do extra steps.
DEBUG is kind of standard - Makefile already uses it in Windows
specific part. I suppose we want to keep consistent.

--=20
Piotrek
