From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 78/83] Move libified code from builtin/apply.c to apply.{c,h}
Date: Fri, 6 May 2016 22:18:54 +0200
Message-ID: <CAP8UFD0ktQyk3SHFbq=fjK8++UArNmy+3p3CCgHaDBT5WRwU6Q@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-79-git-send-email-chriscool@tuxfamily.org>
	<CACsJy8Cb20L=y_=J6S5=rngvH1n0aWvtf5eJrXP-df0aoiJyrQ@mail.gmail.com>
	<CAP8UFD3o_u48rRHP7ZOWnVH7X0O5wwM-Gk-VpH5PP_kFx19ZpQ@mail.gmail.com>
	<CACsJy8AtEv9HHOJUDVKmO=qLkWctvS2zoGdo03jtQwyy2kKzRQ@mail.gmail.com>
	<CAP8UFD0Ku_q56JMvyh9UncJ2D+QsOcB4Svyr5ZWj+KqAaHORMw@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Fri May 06 22:19:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aymDF-0001vI-GN
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 22:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758812AbcEFUS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 16:18:57 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36765 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758793AbcEFUS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 16:18:56 -0400
Received: by mail-wm0-f47.google.com with SMTP id n129so70639597wmn.1
        for <git@vger.kernel.org>; Fri, 06 May 2016 13:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=by408/UJ98+a/98PJUbhrOWcfiR/loG9AHnXTPdm8E0=;
        b=0+RoQE+P7Kyj+Lbqe5TmswINO8W0VNqFcnVuHvzmN3CP7QQvnkUVqUe5vEDVuwx86w
         gUhQAzHUOUrATcO0i6erBKnslHjvWpr9GNqWpTPb4etiT3yEenNF9tJTc7JTCcV+RrfW
         tQTlhwGcTakSGdo16VTlmvoD4y2XRogczBBm449L/k8B2lWfeBUMZMAuEFGlKjCBPpMb
         hRKcR0Nm1oa2zAz3AErxqxy/GuMj04ht7GRzt10z0IzKsR1ac9urDINbZCiGTn8EKZck
         39bK2EDcy/PfnM+tuLxkqAcw9WQOV9Szj5opS1bGHtoO5rjowC8jPla7vTXI8hELy9dU
         uZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=by408/UJ98+a/98PJUbhrOWcfiR/loG9AHnXTPdm8E0=;
        b=chJ8vyft1IiVaLOtvwofrzrCgbDJFlWkP0pNrkLnI0E8Bac7vaCnR7tA7IzERdz2lW
         3jx5sQP3zHOUC4hd51NyNfO0IcObBpXKGXUQ4Gg4CHFzUowC2B3fOvoNGVzAJj+78kY2
         HjSEwSQpqbRfmbSzF6C6Dlu5OjxG+bFYbYWEJiNPpz03BIMqANMjI+nn2pDfF6LrfwUW
         d6NAKQd42wSU3t3uTLwhk99JQPR35SA5VAvwc9yjIdIGyG63U26Tc5cJEPXEQKhDn9lc
         8qrwvQn+7pVw2CwrcNA9vhV1KtTHBWfvw3zB5H4aLp9djn20X4IXYELq32c7D45yd2hS
         SfNQ==
X-Gm-Message-State: AOPr4FVT159ci8bBAoO9BUeLjZKTWxj7QxNEm+GYByH5NLAWzrk9Q5Cea91Q1J6uPVDGjs2SC8/ZH4OetLrOnw==
X-Received: by 10.28.158.79 with SMTP id h76mr10775267wme.79.1462565934833;
 Fri, 06 May 2016 13:18:54 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Fri, 6 May 2016 13:18:54 -0700 (PDT)
In-Reply-To: <CAP8UFD0Ku_q56JMvyh9UncJ2D+QsOcB4Svyr5ZWj+KqAaHORMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293857>

On Thu, May 5, 2016 at 10:50 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Wed, May 4, 2016 at 1:32 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Wed, May 4, 2016 at 5:39 PM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>>
>>> Right now I get:
>>>
>>>> git log --summary -M -C -B -1 20f1d27
>>> commit 20f1d274609f5dde2eaaa279e7ee79fd5ef9c849
>>> Author: Christian Couder <chriscool@tuxfamily.org>
>>> Date:   Fri Apr 22 20:55:46 2016 +0200
>>>
>>>     Move libified code from builtin/apply.c to apply.{c,h}
>>>
>>>     Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>>>
>>>  copy builtin/apply.c => apply.c (96%)
>>>  rewrite builtin/apply.c (96%)
>>
>> Ah.. I forgot about -B to break rename pairs! This looks good. I
>> really need to go back to diff rename hints series, so we can annotate
>> this commit and don't have to use -B every time.
>>
>>> And using format-patch:
>>>
>>>> git format-patch -M -C -B -1  -o ../../patches/test-libify-apply-use-in-am/ 20f1d27
>>> ../../patches/test-libify-apply-use-in-am/0001-Move-libified-code-from-builtin-apply.c-to-apply.-c-.patch
>>>> wc ../../patches/test-libify-apply-use-in-am/0001-Move-libified-code-from-builtin-apply.c-to-apply.-c-.patch
>>>   5264  23426 147133

By the way does someone know how such a patch can be applied?

I get the following:

> git reset --keep 20f1d27~
> git am ../../patches/test-libify-apply-use-in-am/0001-Move-libified-code-from-builtin-apply.c-to-apply.-c-.patch
Applying: Move libified code from builtin/apply.c to apply.{c,h}
error: apply.c: already exists in index
Patch failed at 0001 Move libified code from builtin/apply.c to apply.{c,h}
The copy of the patch that failed is found in:
   /home/christian/git/git/.git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

With git apply I get:

> git am --abort
> git apply -v ../../patches/test-libify-apply-use-in-am/0001-Move-libified-code-from-builtin-apply.c-to-apply.-c-.patch
Checking patch builtin/apply.c => apply.c...
error: apply.c: already exists in working directory
Checking patch apply.h...
Checking patch builtin/apply.c...
