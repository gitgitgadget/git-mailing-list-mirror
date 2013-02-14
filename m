From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2013, #05; Tue, 12)
Date: Thu, 14 Feb 2013 15:54:51 +1100
Message-ID: <CAH5451mMG-U8qETAy_6pRJLbtOjtAPhbapVA9RLbrrS2yy7rCw@mail.gmail.com>
References: <7v621xdql8.fsf@alter.siamese.dyndns.org> <CAH5451nPKq8DKwo+Bkxh08N-wqrYCY4BihbvaE14z5iGVA1iZw@mail.gmail.com>
 <7vsj51caqb.fsf@alter.siamese.dyndns.org> <CAH5451mmXg=xvb-gW0qNvp7f8M5Jk5_ZS+UHAzMaGhJ677zWmw@mail.gmail.com>
 <7vpq04b5e2.fsf@alter.siamese.dyndns.org> <CAH5451kogwuzOs+BrHksDSdECbHrmW8DwTve0_kKq+-PTx+4bw@mail.gmail.com>
 <7vtxpf341w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 05:55:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5qrE-0006qR-LK
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 05:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359Ab3BNEzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 23:55:14 -0500
Received: from mail-ve0-f171.google.com ([209.85.128.171]:39271 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449Ab3BNEzM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 23:55:12 -0500
Received: by mail-ve0-f171.google.com with SMTP id b10so1793536vea.30
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 20:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=RfG3AGdnEeilLDgGKgCtx+lBQ8+azosExEgtNVidCzk=;
        b=szpbWI/TGwLKoRvIqdf0sx5Nj9AtFydYHNY2x4rcBcup7x1pB7nMheu16U56InBQ+2
         uFVOHvLY09s935H0CYUZ+0BjDUC7UBg2/z58h0SE4urpGPot6UiL4E477xphduCRKiXn
         A15c+Z8pQg0SGnYjuRWk9+VNn7xoDizmgvUqUgXLT/DkGufbNznTg/RpQgCPNbf3Iego
         f9AGezwGI+SDC7vFct7zhL0DfBt6JUmxYEMcR08kA+x35y0deIe3G6nQJBqEwcMY9g32
         N75Hb9HJZaC3eaEvHcbW5O9zrhBUkxE21SAEu1u57xSGiXYem2+Ck7LLAKQSPmAhszsS
         WXVw==
X-Received: by 10.52.16.102 with SMTP id f6mr28320578vdd.12.1360817711914;
 Wed, 13 Feb 2013 20:55:11 -0800 (PST)
Received: by 10.220.107.82 with HTTP; Wed, 13 Feb 2013 20:54:51 -0800 (PST)
In-Reply-To: <7vtxpf341w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216298>

On 14 February 2013 15:36, Junio C Hamano <gitster@pobox.com> wrote:
>> That is, currently git add defaults to not staging file deletions, and
>> we provide command line flags to include them. The consensus in the
>> thread is that it is better to stage them by default; it seems
>> reasonable to me that if we stage deletions by default we should
>> provide flags to _not_ stage them. If that was the entirety of the
>> change, would your position from that thread, "if we need this
>> optional, then it is not worth doing this", still hold?
>
> If that is the change we are going to make, and if you can guarantee
> that nobody who is used to the historical behaviour will complain,
> then I am fine with it, but I think the latter part of the condition
> will not hold.

Does the impossibility of asserting that no-one will complain put this
in the 'too hard' bucket?

>> Some people would be adversely affected by this change, but any
>> objections I can come up with are not game stoppers.
>> - It is possible newcomers might stumble at deleted files being staged
>> for commit by a command called 'add',...
>
> New people are fair game; we haven't trained them with the
> "inconsistent" behaviour, and the default being different from
> historical behaviour will not affect them adversely.
>
>> - For people who rely heavily on file deletions remaining out of the
>> index, providing a flag allows them to keep their workflow.
>
> Allowing to do the things they used to be able to do is a bare
> minimum.  You are still forcing them to do things differently.

The implication here is that a relatively small number of people will
be inconvenienced by needing to specify extra flags/set up an alias.
Compare this to the many for whom the expected behaviour is now
default, and we have a net win.

>> Finally, making this change makes sense from a consistency point of
>> view.
>
> That is a given. Otherwise we wouldn't be even discussing this.

Obviously I agree. I was actually bringing up a point about patch mode
and it got incorporated into the bigger picture; patch mode includes
deletions by default and I don't even know if you can turn that
behaviour off. So, when we talk about git add -u and git add -A, we
should also mention git add -p.

Regards,

Andrew Ardill
