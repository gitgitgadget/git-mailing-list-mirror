From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: Feature request: git bisect merge to usable base
Date: Mon, 4 Jan 2016 14:20:50 -0800
Message-ID: <CALCETrV_JAEbuU3v+V352_8PVyaB1noGQAfJG+HVVanVpUbRZw@mail.gmail.com>
References: <CALCETrUgsawpwkkjO_BpPHyOaH7NsJNU-4mF97a6NAxCMB5aUA@mail.gmail.com>
 <xmqqsi2jem15.fsf@gitster.mtv.corp.google.com> <CALCETrUO2Gx9vRqkGLaGWLsuMs98k5d3PKEPfx3RZf4+fpko4Q@mail.gmail.com>
 <xmqqa8olnl1r.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andy Lutomirski <luto@kernel.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 23:21:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGDV5-0001gz-AA
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 23:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbcADWVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 17:21:12 -0500
Received: from mail-oi0-f54.google.com ([209.85.218.54]:35214 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbcADWVK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 17:21:10 -0500
Received: by mail-oi0-f54.google.com with SMTP id l9so236009574oia.2
        for <git@vger.kernel.org>; Mon, 04 Jan 2016 14:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HwDQ8WLgsAVteucG4OFsdDdm1So+7Rag1toYsgHFWHw=;
        b=euni5PUjWwzGJqyQ/o0P80cy9cVKgdHm0iVRNgQHj7oXGVP+NhL0R+IS/FqJrIQv8S
         uP5oQRrfI2YuRqCpLWRhdmHP92KCEQA7yoLR4Jt6Bcc8zXOP7P5tH4WmlQ9tyaqyIp+B
         NbPGSWxNyUG/AUiWnLw9iI3Lz7brBNYDzHw44xgFLMLduR9ygzpVKtiAo4R9LRjOpu/z
         8WjMLPTkxhvDw9hEdu3xQmnHqEsLbuOVfK5LfYpx9yxKqCLtTLc00MriRiB//eWRGXL1
         89JysT63txdjngtch3YfHe5L1JGK+GofPhT3X6psR+fPcwSNlTKeOoAnqFam4kkDdmaN
         zu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=HwDQ8WLgsAVteucG4OFsdDdm1So+7Rag1toYsgHFWHw=;
        b=EoE4Hm37wHomHq/g1O5MJcfyeyDIbP83fCI6+D1oIoR+DYXh0cAfXtK+fzYLcSTBSu
         00C7Nx9Zi5CbQyRH5zhgux+jBhDZOQCVb4eGWZtIkucaKLK+7eqIpkrGNCV6+h0BEk0L
         IkejExYWzD1CHTcBswHhL/F1y8SrNllaMTwqRZQK/hMx3VmpKlZU3wUf6TS7T68kBKgB
         ltAAk0pNZQPSmwjX3nrf0giB+C8QhiybIJewSnTg6GyIrzksIjvdS7eDDdlYwHWp8Ak1
         EAqfZDAvA9fDl0aYNJ4iTUbA1x5CRPvZB3FyQCK5LSRjJIlmACjEzjsVhQt4kSAjAyke
         YVlw==
X-Gm-Message-State: ALoCoQmTWPf45jQTT0/L1Bw2tyctUnmztB9BQzICbwB6cf7iLUkCvE+VSmyx0o3Owd4vjxIsP27BqjM9h6CVLUq1ec7fWxLJ+A==
X-Received: by 10.202.87.194 with SMTP id l185mr59213136oib.52.1451946069709;
 Mon, 04 Jan 2016 14:21:09 -0800 (PST)
Received: by 10.202.102.231 with HTTP; Mon, 4 Jan 2016 14:20:50 -0800 (PST)
In-Reply-To: <xmqqa8olnl1r.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283330>

On Mon, Jan 4, 2016 at 12:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Andy Lutomirski <luto@amacapital.net> writes:
>
>> git bisect run is great, but it's not so great when the test process
>> is "sudo make modules_install && sudo make install && reboot", then
>> boot new kernel, then run emacs, then see if it worked...  There
>> doesn't appear to be a 'git bisect run' option to pause and wait for
>> an explicit user request to continue, unfortunately.
>
> That is expected to be part of your run script, as that is a custom
> and specialized need your bisection has.
>
> It still will not work when the test procedure involves rebooting,
> but "git bisect" does not require you to install and reboot the same
> machine you are running the bisection on, i.e. the test process
> could be "build && scp there && ssh there reboot && see if comes up"
> ;-)
>

All I'm going for is simplicity.  I was bisecting on my laptop, and I
couldn't reproduce on a VM, so I wasn't going to use 'git bisect run',
because git bisect run doesn't support my use case.

Anyway, the idea of merging test commits up to some lowest common
denominator seems generally useful to me, and the idea of specifying a
'prepare the checked-out tree' (as you suggested, where 'git merge
--no-commit whatever' would be specified) would also be handy, and
both of these are useful even in cases where git bisect run isn't
being used.

--Andy
