From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Repacking a repository uses up all available disk space
Date: Mon, 13 Jun 2016 07:24:51 +0700
Message-ID: <CACsJy8Awd2oCm0puh=bnKu9snOZr85+kVRe0D5DUhP6NhmiwcQ@mail.gmail.com>
References: <20160612212514.GA4584@gmail.com> <20160612213804.GA5428@sigill.intra.peff.net>
 <20160612215436.GB4584@gmail.com> <20160612221309.GC5428@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 13 02:25:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCFh2-0000Km-Dz
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 02:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932968AbcFMAZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2016 20:25:22 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:33761 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932783AbcFMAZW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 20:25:22 -0400
Received: by mail-io0-f174.google.com with SMTP id d2so20316083iof.0
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 17:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AiU2cmEweDcHfsiWUTd6RCb9YOr/2xx2dE1M77ZFHc0=;
        b=NEf9idKv+lVnkAiOW+c9OlxGNVk/+mBoueypJ92LkDmSdgkwtmF/H2vardYOHoR5W3
         eatP9KXFCm5sBLsObeLQ5ss3Ow6qavU99nbkBDCHFxUvK3wAxA5ENCtyYLx0vybi7Kp2
         utE8OJz1W0NwTUi3An6FCmB9xPXWZa87Fjxx0+YEjsQ0/wuZNtALZ5us5vnlgp9EBsUb
         LnuwZyEEAxcNVuI6+7H34logaDkls8Kk7tNDJe/ZQRr0O6YbROr5UpMi81EXt248bFf/
         N9kKNAI+I4JlEey/jc0oCX2t1F6h0OxiX5cxO3WTfw4a8+VjdqGuPrpzndAlnDdGXgvI
         +FNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AiU2cmEweDcHfsiWUTd6RCb9YOr/2xx2dE1M77ZFHc0=;
        b=Xr+u4ANhn3BIDEulGwAV9wowjLp/9Rq/Cooo4C8iNEF1EQef1Mujjf1ueHWVNRLnle
         sohxPunu+c2ug9Rdd3JX8ed7ZxEaiMFJu7v6ai0D5McG86gEDg7xkz0bHX/xSG3IqfJj
         RDCwqhea7lOyAqTBxhEDgvchRrGrSyTwKpQxrRBk2ENU6eXTbJ4vrkgg/NVCBpuT2nrk
         3e7FEY/HJ01myLSqrb3rkoE/DKbSJrhHtemPfdVC14zNtMqpVZbffqDq8lXmCYX5MV8G
         coydcAVbq+w2vri4QYMfDEL7GL9TsCElLfODRyGYIJd7IcvqEi+Zk3aX1cpneO0UM8UA
         WPYQ==
X-Gm-Message-State: ALyK8tKltTM2KI5X0OjdbtkpiTfqOjdx/NNnf8Z33jPcELm3vRuN47z805hFdYVjLKdnBIXxbp04HMHYJusLmA==
X-Received: by 10.107.159.84 with SMTP id i81mr18172327ioe.29.1465777521010;
 Sun, 12 Jun 2016 17:25:21 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Sun, 12 Jun 2016 17:24:51 -0700 (PDT)
In-Reply-To: <20160612221309.GC5428@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297146>

On Mon, Jun 13, 2016 at 5:13 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Jun 12, 2016 at 05:54:36PM -0400, Konstantin Ryabitsev wrote:
>
>> >   git gc --prune=now
>>
>> You are correct, this solves the problem, however I'm curious. The usual
>> maintenance for these repositories is a regular run of:
>>
>> - git fsck --full
>> - git repack -Adl -b --pack-kept-objects
>> - git pack-refs --all
>> - git prune
>>
>> The reason it's split into repack + prune instead of just gc is because
>> we use alternates to save on disk space and try not to prune repos that
>> are used as alternates by other repos in order to avoid potential
>> corruption.

Isn't this what extensions.preciousObjects is for? It looks like prune
just refuses to run in precious objects mode though, and repack is
skipped by gc, but if that repack command works, maybe we should do
something like that in git-gc?

BTW Jeff, I think we need more documentation for
extensions.preciousObjects. It's only documented in technical/ which
is practically invisible to all users. Maybe
include::repository-version.txt in config.txt, or somewhere close to
alternates?

> [2] It's unclear to me if you're passing any options to git-prune, but
>     you may want to pass "--expire" with a short grace period. Without
>     any options it prunes every unreachable thing, which can lead to
>     races if the repository is actively being used.
>
>     At GitHub we actually have a patch to `repack` that keeps all
>     objects, reachable or not, in the pack, and use it for all of our
>     automated maintenance. Since we don't drop objects at all, we can't
>     ever have such a race. Aside from some pathological cases, it wastes
>     much less space than you'd expect. We turn the flag off for special
>     cases (e.g., somebody has rewound history and wants to expunge a
>     sensitive object).
>
>     I'm happy to share the "keep everything" patch if you're interested.

Ah ok, I guess this is why we just skip repack. I guess '-Adl -b
--pack-kept-objects' is not enough then.
-- 
Duy
