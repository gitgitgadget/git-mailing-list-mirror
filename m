From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 78/83] Move libified code from builtin/apply.c to apply.{c,h}
Date: Wed, 4 May 2016 18:32:43 +0700
Message-ID: <CACsJy8AtEv9HHOJUDVKmO=qLkWctvS2zoGdo03jtQwyy2kKzRQ@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
 <1461504863-15946-79-git-send-email-chriscool@tuxfamily.org>
 <CACsJy8Cb20L=y_=J6S5=rngvH1n0aWvtf5eJrXP-df0aoiJyrQ@mail.gmail.com> <CAP8UFD3o_u48rRHP7ZOWnVH7X0O5wwM-Gk-VpH5PP_kFx19ZpQ@mail.gmail.com>
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
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 13:33:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axv3P-0007qq-J9
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 13:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbcEDLdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 07:33:15 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33422 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbcEDLdP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 07:33:15 -0400
Received: by mail-lf0-f50.google.com with SMTP id y84so56285244lfc.0
        for <git@vger.kernel.org>; Wed, 04 May 2016 04:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aUqoOT7+VucCCkKT0QgKhgoxqbwcu0IOmFZnuLJGJL0=;
        b=xmea9HDHRWpBOgGtqKjNPTMdaThNAOv9C7MrY7bE+Qk8EmrsevIwcLzOCNEVwbIpZ9
         vY+jHLZnmE8I5SVpgolaAQC77ns4bJf9oBawQxJUc607IBg4MNApFTQfxoxuZdSwZ/OO
         SJ1IP7PZle5i7LQ6MKsi7IGpxwirWl+9gt0jdlheVzZcWiezIGiUTnt8bGQSs4lKl+nS
         nR6WHQqP6Hk+8YgoM/DANQC5p+YW8DW92FVN9mLbhv1ZQbTQDPdchrX4a4C6NPvTgtK5
         PScivmjyK9poqDpJUNw+ktl5M2lXcNFPqDaj9ToHhWro7gKE6IbqaUb3pdSdFlCKk8dG
         SsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aUqoOT7+VucCCkKT0QgKhgoxqbwcu0IOmFZnuLJGJL0=;
        b=cf3n/3vjuQeOaJUA7y+yZ53/aXWFy2oMGmREcOkHnjbp8Rhwkj3UlCSeEnBSdLH72k
         wW2mPbszPtPM5WqOSnlNLAIjbTJnU273lU53Obverwydt8wcdYcdHuflXeEJV5P7CLcx
         zijt543BF8EIiULH9zY6eiF+ErT44fhRG8a/g+04OJyXr8mVH+/127uk2ihOC4Dlj54T
         iAB4AexUf2OFOK9ShgvIjl3m7ltyg60PhwAnpxj3qdz6MJ0q5Wu63eYehiLDd2fYRH91
         0p37Ly3tzglruONt+oEzl5ybHjR9uFZXKeHAOuy3m8ZhGszK4zu15HfX51hPcEmww6C7
         wIfg==
X-Gm-Message-State: AOPr4FWtynTwghVOwty6GZwXeY0S5fKlAGXVx8ve8iUREu6N/Hbb/1ssH+0VRo0xALiT+2RyGg+kUMDeR/XKng==
X-Received: by 10.112.54.132 with SMTP id j4mr3911631lbp.3.1462361593352; Wed,
 04 May 2016 04:33:13 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Wed, 4 May 2016 04:32:43 -0700 (PDT)
In-Reply-To: <CAP8UFD3o_u48rRHP7ZOWnVH7X0O5wwM-Gk-VpH5PP_kFx19ZpQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293537>

On Wed, May 4, 2016 at 5:39 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Mon, Apr 25, 2016 at 3:46 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sun, Apr 24, 2016 at 8:34 PM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>>> ---
>>>  apply.c         | 4678 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>>  apply.h         |   19 +
>>>  builtin/apply.c | 4677 ------------------------------------------------------
>>>  3 files changed, 4695 insertions(+), 4679 deletions(-)
>>
>> Maybe if you can rearrange functions in the right order in
>> builtin/apply.c first and move everything in one patch (i.e. apply.c
>> is created here), rename detection kicks in realizes apply.c is a
>> rename of (old) builtin/apply.c and only shows the diff of (new)
>> builtin/apply.c which is about 90 lines... I haven't tested if this is
>> true though.
>
> Right now I get:
>
>> git log --summary -M -C -B -1 20f1d27
> commit 20f1d274609f5dde2eaaa279e7ee79fd5ef9c849
> Author: Christian Couder <chriscool@tuxfamily.org>
> Date:   Fri Apr 22 20:55:46 2016 +0200
>
>     Move libified code from builtin/apply.c to apply.{c,h}
>
>     Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>
>  copy builtin/apply.c => apply.c (96%)
>  rewrite builtin/apply.c (96%)

Ah.. I forgot about -B to break rename pairs! This looks good. I
really need to go back to diff rename hints series, so we can annotate
this commit and don't have to use -B every time.

> And using format-patch:
>
>> git format-patch -M -C -B -1  -o ../../patches/test-libify-apply-use-in-am/ 20f1d27
> ../../patches/test-libify-apply-use-in-am/0001-Move-libified-code-from-builtin-apply.c-to-apply.-c-.patch
>> wc ../../patches/test-libify-apply-use-in-am/0001-Move-libified-code-from-builtin-apply.c-to-apply.-c-.patch
>   5264  23426 147133

It's a lot of lines, but if you look at diff stat, it's 244 insertions
and 4906 deletions. I _think_ deletions are something reviewers don't
have to pay much attention to (trusting that git moves code
correctly), so only 244 lines to review are really nice. But I may be
wrong.
-- 
Duy
