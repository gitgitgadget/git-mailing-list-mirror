From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Bisect limited to Merge Commits
Date: Wed, 27 Apr 2016 23:44:23 -0700
Message-ID: <CA+P7+xq-g3JPxKROa9Ne0EGiSgSqHKgqVG3eoW9Q-dP0yPOrVA@mail.gmail.com>
References: <20160427204551.GB4613@virgo.localdomain> <xmqq8tzy93ed.fsf@gitster.mtv.corp.google.com>
 <57213041.5070506@kdbg.org> <20160428061929.GA11322@virgo.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Hagen Paul Pfeifer <hagen@jauu.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 08:44:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avfgu-0002KV-8G
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 08:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbcD1Goo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 02:44:44 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34991 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbcD1Gon (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 02:44:43 -0400
Received: by mail-ob0-f179.google.com with SMTP id n10so30249378obb.2
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 23:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KdpVsm9s0ygekRYLl3GdpRaH/8BC4GrrGaYpgMavxd8=;
        b=MZ6MQYzLDUZKH0wyItbHkaI2+V3Yo86wHDFtfh6vL9e+CkpeGADWiWkf7ZtohQPwuF
         1ulev+m3dG67q0WieoOrcoAO6swjjSgQw7q1iX/5ozscUe6O+yMwd6qk0e2rLNiDj7Q1
         EwrHFm0I14BnlX6O1ImHrDNy78urm7GQsBTkM9WK7ZZKf/wmSCK3N1gf/ZQwNUQYWlNv
         UNsaXk2xTP41eCNRxIIRUa2mLOyQLh+9dotk7DNCSeNaMRIrxN3PlDtdhvM3WquAsh3/
         kQC1lewkC49u7ueukySLAe6MkzQCla4d/b/SQAW1tjqmkPivLKLBTLee4XAcbD0bIOTn
         d4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KdpVsm9s0ygekRYLl3GdpRaH/8BC4GrrGaYpgMavxd8=;
        b=bNLTIUwYEg3bFOIEPwslDQIdAl6/+zhA/KiP5279dkVwMHRlE4vtSJ4kxz6ZSHhXWn
         KTpbLM8vYfvy2qQ6dRTW3Gfea198eBHqLkDbmrBlhrX06GCtF4e5skay0s5Rwgb3HGsd
         XseDK4EqKZiSVMCjXTByekr2LgWng/Mj/3aJupKDXVI3ehdcN93kqqoNMuFT5zYsX01P
         J/sW8y0hQZuH1OemkDtHLdGPhV+EpWwOXhxmiQyNlMcQDa8e1y6NjggIeXDVEUDWDBVV
         +gx7t2GbasREzC3cYwQhjCxbWmwy474l1y5wPWjmTxUxINnPBwgFxZSeBXpdgPpuQume
         pRRw==
X-Gm-Message-State: AOPr4FXRB7+G/k+AuXtdLDGGYLh9tcsbc6N6PzxiykEMZZosa/oNOfsPAC3u+6UHKcX7jpsOGRcMFi3ixvIUUA==
X-Received: by 10.60.74.97 with SMTP id s1mr5547751oev.24.1461825882735; Wed,
 27 Apr 2016 23:44:42 -0700 (PDT)
Received: by 10.182.117.132 with HTTP; Wed, 27 Apr 2016 23:44:23 -0700 (PDT)
In-Reply-To: <20160428061929.GA11322@virgo.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292852>

On Wed, Apr 27, 2016 at 11:19 PM, Hagen Paul Pfeifer <hagen@jauu.net> wrote:
> * Johannes Sixt | 2016-04-27 23:33:53 [+0200]:
>
> Hey Junio, hey Hannes,
>
>> git bisect start
>> git rev-list --first-parent --boundary origin..origin/pu |
>>   sed -ne s/-//p | xargs git bisect good
>> git bisect bad origin/pu
>>
>>and it starts bisecting among the 50-something first-parent commits between
>>origin and origin/pu.
>
> just for clarification: contributors rebase their work before pushing it on
> master. The integrator simple merges --no-ff the individual branches. Just a
> regular workflow, nothing special - except that many contributor commits will
> not build. ;(
>
> The idea is just to skip the contributor commits during bisect and focus on
> the merge commits (the ones with more than one ancestors) because they are
> likely build and testable.
>
> One possible approach is probably to sort out all non-merge commits before
> bisecting and bisect only on a this set of commits. The advantage is that the
> first bad commit is the merge commit introduced the regression. Mmmh, any
> comments?
>

I suspect doing something akin to the idea of "bisect --first-parent"
would work for this use case and be more flexible in general. Your
idea is pretty much what i think bisect --first-parent would do,
except that it would also work for non-merge commits which happen to
be in the "mainline" history.

Thanks,
Jake
