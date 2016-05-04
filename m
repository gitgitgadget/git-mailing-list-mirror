From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 78/83] Move libified code from builtin/apply.c to apply.{c,h}
Date: Wed, 4 May 2016 12:39:07 +0200
Message-ID: <CAP8UFD3o_u48rRHP7ZOWnVH7X0O5wwM-Gk-VpH5PP_kFx19ZpQ@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-79-git-send-email-chriscool@tuxfamily.org>
	<CACsJy8Cb20L=y_=J6S5=rngvH1n0aWvtf5eJrXP-df0aoiJyrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 12:39:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axuD5-0001Ct-Dc
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 12:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757671AbcEDKjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 06:39:10 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38072 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757663AbcEDKjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 06:39:09 -0400
Received: by mail-wm0-f48.google.com with SMTP id g17so85940626wme.1
        for <git@vger.kernel.org>; Wed, 04 May 2016 03:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=xl3HqQSz+MpgBTUn/lzwvIpcjQFJ4JhQOgrIDyNPGOM=;
        b=K/1D4kPQmFr8i7FcOeDtgAlRRfsjpmZ4dSAP/wWjUzQEX2oe4Jf/15VzAm+D0A6Lsy
         A3cb+HtW+uKD1/QsFDd75ZnVrtgfokc5sa3D5Zc+HCe6EjmUcRIiXXBbzQvoSFsdPyRG
         5liH3WYQi3eRY6AJ+3EJgwzn2hLI+Cp2RqjF9tfg7JRQe4c5yoJAsWx3+ZaOvvNsbPMF
         7UqEWSKuGFQ6nVFO4YgODP7dwDEp3Q2Jic3h8CAYklKvpY/7FAUkS+zUHDJEFVtaPHDd
         ScWBtyl+ywIO+W5Lm41WssrTaX6gMzyZj8glgpA8FFPucWm1qUB+fmFUQOdoUnZV0FiE
         qGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=xl3HqQSz+MpgBTUn/lzwvIpcjQFJ4JhQOgrIDyNPGOM=;
        b=haq5+nXvmscky4yM+X5czFbeSCmwcByrpC2gUcsmYnULJaeBFE9/GncfH0ScGhH7XJ
         iG+AHqT4Jy6AjfShwTilBv9cfnxajcJUGpl0wDyFmx1FfwBsg8BEfRnqWyaCXh+EVYqd
         vVm5Wjs0HqNZZGjOVHJpJH0R35pxIu8XuFO9yg/m2oxpPX8kcPKhttXHzVqB1LzbWtLN
         Oei1AS8ZxYqcSj4cPB9yDK0GyVcL2pKpnRoovUn6eJujMcQX+Zg/KRMCV3mkOrGW5v/k
         c3MRavUJoNm6Q3TmCuhpsjpgmqMSRqLAh3AZz4jiuKisXSsZkPHAnNveUCVHFFB5etE7
         khBQ==
X-Gm-Message-State: AOPr4FXpZ9Gg4JPMv4dw1XZlZO/F9N2Zf59bfoybpdY5hIg3jb7qzA5FupzkVEgWpDmQ3rBLGXlvxvpONHQ1fg==
X-Received: by 10.28.129.22 with SMTP id c22mr31238120wmd.89.1462358347739;
 Wed, 04 May 2016 03:39:07 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Wed, 4 May 2016 03:39:07 -0700 (PDT)
In-Reply-To: <CACsJy8Cb20L=y_=J6S5=rngvH1n0aWvtf5eJrXP-df0aoiJyrQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293530>

On Mon, Apr 25, 2016 at 3:46 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Apr 24, 2016 at 8:34 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  apply.c         | 4678 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  apply.h         |   19 +
>>  builtin/apply.c | 4677 ------------------------------------------------------
>>  3 files changed, 4695 insertions(+), 4679 deletions(-)
>
> Maybe if you can rearrange functions in the right order in
> builtin/apply.c first and move everything in one patch (i.e. apply.c
> is created here), rename detection kicks in realizes apply.c is a
> rename of (old) builtin/apply.c and only shows the diff of (new)
> builtin/apply.c which is about 90 lines... I haven't tested if this is
> true though.

Right now I get:

> git log --summary -M -C -B -1 20f1d27
commit 20f1d274609f5dde2eaaa279e7ee79fd5ef9c849
Author: Christian Couder <chriscool@tuxfamily.org>
Date:   Fri Apr 22 20:55:46 2016 +0200

    Move libified code from builtin/apply.c to apply.{c,h}

    Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

 copy builtin/apply.c => apply.c (96%)
 rewrite builtin/apply.c (96%)

And using format-patch:

> git format-patch -M -C -B -1  -o ../../patches/test-libify-apply-use-in-am/ 20f1d27
../../patches/test-libify-apply-use-in-am/0001-Move-libified-code-from-builtin-apply.c-to-apply.-c-.patch
> wc ../../patches/test-libify-apply-use-in-am/0001-Move-libified-code-from-builtin-apply.c-to-apply.-c-.patch
  5264  23426 147133
../../patches/test-libify-apply-use-in-am/0001-Move-libified-code-from-builtin-apply.c-to-apply.-c-.patch

The previous patch was:

> wc ../../patches/libify-apply-use-in-am25/0078-Move-libified-code-from-builtin-apply.c-to-apply.-c-.patch
  9436  41887 254435
../../patches/libify-apply-use-in-am25/0078-Move-libified-code-from-builtin-apply.c-to-apply.-c-.patch

So it is better, though not really as small as I would like.

I am also not so sure that moving everything in one patch would make
things much smaller.
By the way at one point I have to create apply.h from some of the
content of builtin/apply.c (like the struct apply_state) and I don't
know if you are talking about that too.

If you want you can try using the latest version of the series:

https://github.com/chriscool/git/commits/libify-apply-use-in-am39

Right now I think I will just use -M -C -B with format-patch for v2.

Thanks,
Christian.
