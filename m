From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Rebase performance
Date: Fri, 26 Feb 2016 19:15:12 +0100
Message-ID: <CAP8UFD0_+8cQvBHvrEe16DEa6F-4KZtJGKNqiRn_fMgfQqX_cg@mail.gmail.com>
References: <CAP8UFD0p1kvk2B0kkc-M9dm+H-Bmam=OrE99VwQx=KCETFEjcw@mail.gmail.com>
	<CACsJy8DZOv2Z2hiUmRKHr_GCjsyVz9kQEE8a1F=h6Ku0Dr9g_w@mail.gmail.com>
	<CACsJy8AUbLhfkeanQa101mygt1u_SxgbVAGc=USC79n9iR4R3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 19:15:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZMvC-00047W-4w
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 19:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787AbcBZSPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 13:15:15 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33044 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531AbcBZSPO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 13:15:14 -0500
Received: by mail-lf0-f54.google.com with SMTP id m1so58586554lfg.0
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 10:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=trvgIUDivWbuM6TF028mNKxOjBBD0+YffFDjE7J+Skk=;
        b=Sl+6NnFLnFARGiK/XjBpsZUgzn9gdhZhNJZis8q+bhVk+hfq7/x03Cp9MR3ZwtfpRz
         cOJiWomGCSkbieqsgt5TKM+zNWEQ0F19O9Hol+MKCI8kEQSQO7uaF/RHGUVqkvRXh+tn
         yQJ6Pprbgt7z1g0TwWlxfe1XWdsnzuPrOTxln9Z/mc1xULumpEQUoo0sv6UUwgNxisiD
         G62FWEfSQ8f7nmnwpW6Pz0mcKFxDGt7DvctoMB7CdI8jsE1DnWisdNESsS88jlq6LHTf
         5Ig1IfbFfoJktd0Oi1ZsmMczc7DY9mBiMO13iLaRMkKHIfXjokFEOmRPKuF549uDoy0Y
         ZZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=trvgIUDivWbuM6TF028mNKxOjBBD0+YffFDjE7J+Skk=;
        b=kKiGhBHZ6jUfdHmV/TWQewAOzWC5c8f30MHWZn/AlCQiXrkQ5ZSYXMrEMnifYJRB+u
         Lc3U6F1ZLHJ0MRANFmkMUtRcIBOPsLV2HkM7jDX7iTGp1FkoC4RY2+kxpKdV0gV+z0kI
         m4Zh5ip5BfLjIGQNZ5ZjZ2qHeqjKGagfKVVUSf4Q0oJrsFDK3KaV4ITxPZ+iMS21zD6r
         NBFPimo+mc1DOX8Pgayqk1IvISjzIsFx5oN4W6i58aWUC36t8K/9Z5+nOPXps9sKlmoV
         pFPsdE9CPY6/bK527pQqNHRVuB5NFFiqVdWT1Ne1Le2XzmBLLJZpxJLZ6MMaHajDJMAz
         G3hg==
X-Gm-Message-State: AD7BkJKw95RNuWrMsvFWVXEWmBFWR08PThUo+T67o4O+tKFLCg644sS18JYQa9mKrbtYL8CYeSvr6Aqtj6uiDg==
X-Received: by 10.25.163.199 with SMTP id m190mr1143513lfe.7.1456510512593;
 Fri, 26 Feb 2016 10:15:12 -0800 (PST)
Received: by 10.25.152.199 with HTTP; Fri, 26 Feb 2016 10:15:12 -0800 (PST)
In-Reply-To: <CACsJy8AUbLhfkeanQa101mygt1u_SxgbVAGc=USC79n9iR4R3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287601>

On Thu, Feb 25, 2016 at 10:42 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Feb 25, 2016 at 7:50 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Thu, Feb 25, 2016 at 5:09 AM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>> Another possibility would be to libify the "git apply" functionality
>>> and then to use the libified "git apply" in run_apply() instead of
>>> launching a separate "git apply" process. One benefit from this is
>>> that we could probably get rid of the read_cache_from() call at the
>>> end of run_apply() and this would likely further speed up things. Also
>>> avoiding to launch separate processes might be a win especially on
>>> Windows.
>>
>> The amount of global variables in apply.c is just scary. Libification
>> will need some cleanup first (i'm not against it though). Out of
>> curiosity, how long does it take to do "git update-index <one modified
>> path>" on this repo? That would cover read_cache_from() and
>> write_cache().

Sure I get:

$ time git update-index <README

real    0m0.079s
user    0m0.057s
sys     0m0.022s

>> While you're measuring, maybe sprinkle some
>> trace_performance() in apply.c:apply_patch() to get an idea where time
>> is most spent in?

Each call to read_cache() takes around 0.07 seconds and each call to
check_patch_list() takes around 0.045 seconds, the rest of
apply_patch() is not significant.

> I did some experiment.

Thanks for those experiments. They are very interesting!

> The calls from am are basically
>
> for i in $PATCHES; do git apply --cached $i; git commit; done
>
> and we can approximate the libification version of that with
>
> git apply --cached $PATCHES
>
> (I hacked git-apply to do write-tree after each patch, close enough to
> git-commit).
>
> I tried it on my shallow-deepen series, 26 patches. The "for; do
> git-apply;done" command took 0m0.482s (real's time), taskset does not
> affect much for me, while the "libification" took just  0m0.105s.
> That's a very impressive number to aim for, and git.git is a small
> repo.

Yeah, from my tests it also looks like there is a lot that could be
gained from the libification.

Thanks,
Christian.
