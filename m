From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 21/22] mingw32: add uname()
Date: Sun, 9 Nov 2014 15:36:25 +0700
Message-ID: <CACsJy8CRzngC5U3VY9Bi1uRmdRfEWQWOCokRLLWNKRNUjyJrrw@mail.gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
 <1415439595-469-1-git-send-email-pclouds@gmail.com> <1415439595-469-22-git-send-email-pclouds@gmail.com>
 <CAPig+cS2FzL6kXTvoG6cTX1yUjmGUkEm5mAHNxmtU5-=ngcoFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 09:37:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnNzZ-0000Vm-UZ
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 09:37:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbaKIIg5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Nov 2014 03:36:57 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:45737 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbaKIIg4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Nov 2014 03:36:56 -0500
Received: by mail-ig0-f179.google.com with SMTP id r10so7604325igi.12
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 00:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=U7MOJwWmCl5bz7jfIxEhwKj6weixRGu2Xh+JNg0Wllc=;
        b=zty7z5sz9IhyuB524sQrZT5DYTIdkhfpc8OYMsfrdWyIEh5RgoKTeMznkRuq+VmiE4
         A3Mg8KYELv2bD9jviavKvFYNAOS2GXPetyfqAdHCSggwrkpSRwUM3dC5X+NQrz95fNq8
         23jrRUkc76MgFoeOEPC3NTANNrB5yUqhddROs9mHDK+/46x2NsJJk4qd4m9ng1SlcJN8
         560y7M/wueNAhAvMKdyVCYV/1WLvCJF+yb6R7gY72Ggi6kO5jZEh7Bouy6wGe0t8P+rw
         Cot4jQdlN4zTWQIsyKT+vxXxtf3tpsSBSBLJGl9S7qo2rMpezHsfT5ak1CZdEVdJSy1O
         BRDQ==
X-Received: by 10.50.143.73 with SMTP id sc9mr16933649igb.27.1415522215783;
 Sun, 09 Nov 2014 00:36:55 -0800 (PST)
Received: by 10.107.176.8 with HTTP; Sun, 9 Nov 2014 00:36:25 -0800 (PST)
In-Reply-To: <CAPig+cS2FzL6kXTvoG6cTX1yUjmGUkEm5mAHNxmtU5-=ngcoFg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 9, 2014 at 10:32 AM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> On Sat, Nov 8, 2014 at 4:39 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> diff --git a/compat/mingw.c b/compat/mingw.c
>> index c5c37e5..b817678 100644
>> --- a/compat/mingw.c
>> +++ b/compat/mingw.c
>> @@ -2128,3 +2128,14 @@ void mingw_startup()
>>         /* initialize Unicode console */
>>         winansi_init();
>>  }
>> +
>> +int uname(struct utsname *buf)
>> +{
>> +       DWORD v =3D GetVersion();
>> +       memset(buf, 0, sizeof(*buf));
>> +       sprintf(buf->sysname, "Windows");
>
> strcpy() maybe?

It was originally strcpy, then I wanted to get fancy and show Win3.1,
Win95... but it got complicated (couldn't just do it based on the last
bit of 'v'). Will revert.
--=20
Duy
