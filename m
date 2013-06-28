From: John Szakmeister <john@szakmeister.net>
Subject: Re: Bug on OS X...
Date: Fri, 28 Jun 2013 16:38:02 -0400
Message-ID: <CAEBDL5UmYXXTds9vYumXY9hYBwJLsJq3CN6FRZm6c8SkjPxazQ@mail.gmail.com>
References: <CAEBDL5VeE7dyo_A7904SBNSvf834xdGyyuk=vE44wXoRVJ-nkg@mail.gmail.com>
	<9DD46E0F-FA9C-4C60-A1CE-03EAAD823967@quendi.de>
	<CAEBDL5V3eAJGs-CTVZd8wVxKV3b+Gbk26E1rFaKjk-xBhSu31Q@mail.gmail.com>
	<7vwqpep3ab.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Max Horn <max@quendi.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 22:38:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsfR8-0002GH-Sc
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 22:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636Ab3F1UiG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jun 2013 16:38:06 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:44743 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975Ab3F1UiE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jun 2013 16:38:04 -0400
Received: by mail-we0-f173.google.com with SMTP id x54so1585777wes.4
        for <git@vger.kernel.org>; Fri, 28 Jun 2013 13:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jwdA3MoVM1YcaMtwN5bQt0WMrh8F97MHZjGHebsiuKs=;
        b=bsP5597Wi4OBxAyN/w9ymKafN5i+Wb/28FXGirnILCHX05ErZlCCINLH87ZporAp5E
         mXOSUeroWOtALWglEbP6ywJ8CDgMrXRZ/OKIzFKWRMG/+YmyAYkwoVfFwiIJV8HhTw6/
         62IH4aCIeSQAVVcsigdZRdRL+Vqd5HNz00wl6DTMtnUvHHS/JxaVzyOLt80nvCCb+AcV
         +CKxENGxhEk27GFFHgTOCJFZg0FNRxx34yzBNPConzX9Si57lorzBSLP9X1nGNu/SDaw
         OzRkD1sCCErHdPgxlQaR6S7Xf2i6+gfhtA8asbpo0UMp4OCSBSWkGUGOMXM02A0wkuiw
         r63A==
X-Received: by 10.194.170.168 with SMTP id an8mr10905745wjc.72.1372451882477;
 Fri, 28 Jun 2013 13:38:02 -0700 (PDT)
Received: by 10.180.144.37 with HTTP; Fri, 28 Jun 2013 13:38:02 -0700 (PDT)
In-Reply-To: <7vwqpep3ab.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: y1MjEpYrNLTTk8cqjRKPv2rpjk8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229235>

On Fri, Jun 28, 2013 at 1:13 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> John Szakmeister <john@szakmeister.net> writes:
>
>> On Fri, Jun 28, 2013 at 8:44 AM, Max Horn <max@quendi.de> wrote:
>> [snip]
>
>>> I am unable to reproduce this on Mac OS X 10.7.5 with git 1.8.3.1
>>> nor with current git maint. Command run inside /tmp, which is on
>>> a normal HFS+ volume (using the default settings, i.e. the FS is
>>> case insensitive).
>>>
>>> $ git --version
>>> git version 1.8.3.1.42.ge2652c0
>>> $ git clone --depth 1 git://nbd.name/packages.git
>>> Cloning into 'packages'...
>>> remote: Counting objects: 4711, done.
>>> remote: Compressing objects: 100% (3998/3998), done.
>>> remote: Total 4711 (delta 157), reused 3326 (delta 94)
>>> Receiving objects: 100% (4711/4711), 3.85 MiB | 0 bytes/s, done.
>>> Resolving deltas: 100% (157/157), done.
>>
>> OK, so I finally tracked it down.  Commit
>> 6035d6aad8ca11954c0d7821f6f3e7c047039c8f fixes it:
>>
>>     commit 6035d6aad8ca11954c0d7821f6f3e7c047039c8f
>>     Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
>>     Date:   Sun May 26 08:16:15 2013 +0700
>>
>>         fetch-pack: prepare updated shallow file before fetching the=
 pack
>> ...
>> It looks like I was hitting the race condition.  It's fixed on maste=
r,
>> so I assume it will be in 1.8.3.2.
>
> Hmmmph, I do not think the cited change is about any "race".
>
> If it were that we spawn index-pack and write updated shallow
> information at the same time, and depending on the timings,
> index-pack may not read the updated one and fail, then it would have
> been a "race", but that is not the above change is about.  If you
> saw the issue on MacOS, you would have seen the same breakage, as
> long as you started from the same repository status, on other
> platforms, and reliably.

Hmmm, that's what the message seemed to say to me (that it was racy).

> An early part of nd/clone-connectivity-shortcut topic contains the
> said commit, and I do not mind merging it to the maintenance track,
> but I suspect that there is something else going on on your OS X
> box, if you saw differences between platforms.
>
> Perhaps on your OS X box you have {transfer,fetch}.fsckobjects set
> to true while on others it is set to false, or something?

Good suggestion!  I have a gitconfig that I propagate to many of the
machines I use, but I had not updated the Linux machine I was testing
with.  Turning on transfer.fsckObjects did indeed cause the issue to
appear on Linux as well.

-John
