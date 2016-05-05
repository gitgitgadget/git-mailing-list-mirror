From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 80/83] run-command: make dup_devnull() non static
Date: Thu, 5 May 2016 11:50:29 +0200
Message-ID: <CAP8UFD2f1L3YKNBA4zP1bmGe8BQitxZp-aDsGP5UTDv06LbLBg@mail.gmail.com>
References: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org>
	<alpine.DEB.2.20.1604251704300.2896@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 05 11:50:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayFvi-0007NF-1O
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 11:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756583AbcEEJud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 05:50:33 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38574 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756401AbcEEJub (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 05:50:31 -0400
Received: by mail-wm0-f53.google.com with SMTP id g17so18483458wme.1
        for <git@vger.kernel.org>; Thu, 05 May 2016 02:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=YXYS0ALWzq7+J1Y+0JbzZmQbDfg2ECNzFDlD/LyKPZo=;
        b=0EhDUUnvVPBJ+hnkholoaFNZJqJQoVuenQ6QIUGFo05WZ/er0P1P2jyDoZu4X9GS3x
         3tkmKDgl6jpJLpsTRQy7CDM5ce2I136q0jy7AQwqUIQ7/mLezslxZjsVlRWcR0bj/JOO
         5IKuuo/s1ztgGlrzG7hsCN9wCZt/5/Nj6HgBq8pFPjSVCPLjYGRAXVu3vbKCFklHg5U0
         2MYCOHk3kIVIaKHHfe9DmgWJbaJopr6KaVKdY4KBRqipxrvRie0hDcyvL2bhBBSiqkjv
         5g0WGR+c/X9P8liqLIo/v61lZ52Wu4W/Uhb4277yO43x/BXWr3Ge9v8lm0feoWT0rDF0
         bUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=YXYS0ALWzq7+J1Y+0JbzZmQbDfg2ECNzFDlD/LyKPZo=;
        b=Zp8d5sy13/S7V+FRinn4LsQrR51B9pzpk/01ypoc4xSBl3YCIaGRO5W41IMW20iBwn
         XueW3AFfu88rGvFU6lnYIEGIqxC7YFscUC9J64NR5mUiB2fiZhfAZz1SFnCzEKeCP99S
         aEse3AP+RMFKEzmysbrRWAOTu4xz3dslUkhZb8MDxtBih3Ifw5y3/L9kAFaVnD3OeHbQ
         /hMx+wXvEAkMnIZqJjBEVCtMECEDbyr63f2A19HKHAPH/2TFsmFVYnMIJ6qRNvgHmnZr
         gVKE6Z0GPwb1NZWOxHrFPaNn/6tLvQlGyICGtb9WvEqKC36/QvXppWSpE3nMPST5vgxm
         m1hQ==
X-Gm-Message-State: AOPr4FV3uHCz0DazkPlQOVgDgszhoYBbsyTEvhtbEAzGlhKJWfF0XcHjgrHdHmJGXGL8RFfFMGzpNiIbdl0zJg==
X-Received: by 10.28.169.11 with SMTP id s11mr2529295wme.62.1462441829905;
 Thu, 05 May 2016 02:50:29 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Thu, 5 May 2016 02:50:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1604251704300.2896@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293634>

On Mon, Apr 25, 2016 at 5:05 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Chris,
>
> On Sun, 24 Apr 2016, Christian Couder wrote:
>
>> diff --git a/run-command.c b/run-command.c
>> index 8c7115a..29d2bda 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -85,7 +85,7 @@ static inline void close_pair(int fd[2])
>>  }
>>
>>  #ifndef GIT_WINDOWS_NATIVE
>> -static inline void dup_devnull(int to)
>> +void dup_devnull(int to)
>>  {
>
> The #ifndef GIT_WINDOWS_NATIVE rings very, very loud alarm bells.

Yeah, but I must say that I don't know what I should do about this.
Do you have a suggestion? Should I try to implement the same function
for Windows?
