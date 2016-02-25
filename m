From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Rebase performance
Date: Thu, 25 Feb 2016 16:42:28 +0700
Message-ID: <CACsJy8AUbLhfkeanQa101mygt1u_SxgbVAGc=USC79n9iR4R3w@mail.gmail.com>
References: <CAP8UFD0p1kvk2B0kkc-M9dm+H-Bmam=OrE99VwQx=KCETFEjcw@mail.gmail.com>
 <CACsJy8DZOv2Z2hiUmRKHr_GCjsyVz9kQEE8a1F=h6Ku0Dr9g_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 10:43:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYsRu-0008Iv-4P
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 10:43:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759867AbcBYJnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 04:43:01 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:32791 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbcBYJm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 04:42:59 -0500
Received: by mail-lf0-f50.google.com with SMTP id m1so29547519lfg.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 01:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FDETWqGUhaJjU0B/iwQ00C0Qysqct0hseXmwjp2znAw=;
        b=BJAuHeEhZlA95/AxrKNeK9mRpEx9gZqI72q69efTpnWFu39j4yiL/KfTdrNyte8isr
         mue8l/AgSi30MtWWPeIkBHMq6O4QOdlcLpxTlPSzAbMQ3R+3EIiYAtIl2wOAILcKHIeY
         lf74Knj4FguOU9MwPdEbDdOLMSGz/xzweelrKldthmoZpM88gG2oUrOFzYatUWej/wzJ
         PqR19tIUhN0oQDkz/xjPrG/LzsZ+VwQs0AGEAipD5fLG6/Tff+jpF5Odrs4vxe85KnR2
         IE5tuekYXCVvCjDR/L0v052/w1uY/UOSOjkt49nDHD0Brm6GLhsh1ckesFHsYjdIxjGt
         mm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=FDETWqGUhaJjU0B/iwQ00C0Qysqct0hseXmwjp2znAw=;
        b=ANsQ3mOsA+oWuF/oXY71kih6I4F+uCfLLRn8Pzd3TeT5eJnPqUjWmXJtfjlf8JuqNE
         u/hw+2Q5V4tpC65mQqFo1uoYTaCzsSRYmuOA16z3NuNrpS14nnQwuMiz9fyZc73OMV/n
         hm1RORFdi1UYkXi/6/tPJ1YBXBd8QS+0PNNIEncL+wTnJhpajyn29dPZEwrjPQ1WMh4h
         aJTakvBkFkeJUHVDHIxo3iF+FS1dusbkFqbXeCf1B6xwGWek9HKnXEQB/ynY/si2nMsq
         2nUyF5N77EFh2AbGKep6WfmYpqrAy/kVJEvgmdErG8aHbz9bveIL4cRitF49jgjde7Sj
         BnmA==
X-Gm-Message-State: AG10YOQaP/g2RAqZqfdNZuzC07Jfjqp1Tv9ptw8LWmI3FXqpI8XPECOGCFAsdhoRgpYFEquIJgkyk+hJcywtdA==
X-Received: by 10.25.159.68 with SMTP id i65mr16083799lfe.94.1456393377934;
 Thu, 25 Feb 2016 01:42:57 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 25 Feb 2016 01:42:28 -0800 (PST)
In-Reply-To: <CACsJy8DZOv2Z2hiUmRKHr_GCjsyVz9kQEE8a1F=h6Ku0Dr9g_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287357>

On Thu, Feb 25, 2016 at 7:50 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Feb 25, 2016 at 5:09 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Another possibility would be to libify the "git apply" functionality
>> and then to use the libified "git apply" in run_apply() instead of
>> launching a separate "git apply" process. One benefit from this is
>> that we could probably get rid of the read_cache_from() call at the
>> end of run_apply() and this would likely further speed up things. Also
>> avoiding to launch separate processes might be a win especially on
>> Windows.
>
> The amount of global variables in apply.c is just scary. Libification
> will need some cleanup first (i'm not against it though). Out of
> curiosity, how long does it take to do "git update-index <one modified
> path>" on this repo? That would cover read_cache_from() and
> write_cache(). While you're measuring, maybe sprinkle some
> trace_performance() in apply.c:apply_patch() to get an idea where time
> is most spent in?

I did some experiment. The calls from am are basically

for i in $PATCHES; do git apply --cached $i; git commit; done

and we can approximate the libification version of that with

git apply --cached $PATCHES

(I hacked git-apply to do write-tree after each patch, close enough to
git-commit).

I tried it on my shallow-deepen series, 26 patches. The "for; do
git-apply;done" command took 0m0.482s (real's time), taskset does not
affect much for me, while the "libification" took just  0m0.105s.
That's a very impressive number to aim for, and git.git is a small
repo.
-- 
Duy
