Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44EA71FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 20:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbcFUUWJ (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 16:22:09 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:33024 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbcFUUWH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 16:22:07 -0400
Received: by mail-io0-f171.google.com with SMTP id t74so26800356ioi.0
        for <git@vger.kernel.org>; Tue, 21 Jun 2016 13:21:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Kto/TTnvUoqgnh9taRU3+Zr/kOtWSDbGSJ8kUcinggI=;
        b=U3LPHtQFjR3+xrKfA5HCRFx++U8w9oKJwQ4AfD6LR1n3bRysarDN2GnF3fX8A1Mwtg
         MRHKXBJMWp+I3scPNwRF39+DmXCBHIYs6uEG06/4oUyGQuOJcd4Nw8AH4UqkRQipukYQ
         wvd1G9aSzhtYGN3vPUZW+60VzPEhU8nJ5E7V4lLMNFgdQYB8vA3tZO6GYySgatmt+JB2
         PxNUPP+8Cd6eg8kzMabTtoZljmNjs0M6qiIo/kQDcJbeLuBiEnyF/N9SKlIpz3sKn4+3
         tS6XpOs27K5q/fUSWQJgWt+YPID7hfC70qqfnLw3dhEsKT/30S8fiCU1ruxas+SFJAld
         GoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Kto/TTnvUoqgnh9taRU3+Zr/kOtWSDbGSJ8kUcinggI=;
        b=b7+N50TkaBGDRmizXF3T8w0uVD6TRGSHlRs5YubT4JytJDyCOPyIHAIk1h/2aF59Wc
         jzBMAr+aqSehAsOkr4qhPEpjtukkMXHWkXZRmpvZrTyxYJwypZiAP5i2EM6yCdISuZyh
         bC6RH2OgWsdqLm92WZeSttqawpbxzIJLUOUDc5uDaYZKch1HNhX0hQ1ObHWfWkcWOu8h
         u6kJbyb+LvzdeYVKDYHV79nxp5rsDnVeIsqJRyHoFEKdWIktcVw303+uT+xolD+EX7QW
         tTYOS7fm5syfGtKjkSzUo3fuQWu84wgP8HB0qxRBz0GbEKj6Vkt/LKwFgvKuQ/Bk2ZTR
         ZXDg==
X-Gm-Message-State: ALyK8tKhy0VWI8xB+zGITycRx+Nupq3KqBXGJBkvRkLBGkKNNE1MH2deBdG4orw5Pow9O1LGDx0UV+nkvfqEdIqI
X-Received: by 10.107.186.196 with SMTP id k187mr35532142iof.173.1466540058335;
 Tue, 21 Jun 2016 13:14:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Tue, 21 Jun 2016 13:14:17 -0700 (PDT)
In-Reply-To: <20160621193824.GA22183@sigill.intra.peff.net>
References: <1466443278-21591-1-git-send-email-sbeller@google.com>
 <xmqqh9cmpcze.fsf@gitster.mtv.corp.google.com> <20160621193824.GA22183@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 21 Jun 2016 13:14:17 -0700
Message-ID: <CAGZ79kZ4nVeJ6qi9LED-HOxYeP6Scg9j7+nYa4yJYyFxFT-WEA@mail.gmail.com>
Subject: Re: [PATCH] t5614: don't use subshells
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 21, 2016 at 12:38 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 21, 2016 at 12:18:29PM -0700, Junio C Hamano wrote:
>
>> Stefan Beller <sbeller@google.com> writes:
>>
>> >  Unlike the prior patch we would not want this patch to fall through
>> >  to origin/maint fast, but allow cooking?
>>
>> I do not see anything that makes this treated differently from the
>> other fix.  The only difference in behaviour is that "lines" file is
>> now created at the root level of the trash repository's working tree
>> instead of tested clones', and I do not think any test depends on
>> the number of untracked paths in the trash working tree or tries to
>> make sure a file called "lines" is not in there.
>
> I think it is only that the other patch is actually fixing something,
> whereas this is cleanup. So the cost/benefit equation is different. I
> agree neither is high-risk and a test cleanup is generally OK for maint
> (the other is a serious-ish regression IMHO).

I agree on the cost/benefit equation being different. I considered this patch
a "normal risk" thing, which by our standards is not going through to maint
directly, but is cooked at various heat levels before.

>
>> Having said that, I wonder if we want further reduction of the
>> repetition.  Each test except "setup" in this script does an
>> identical thing with very small set of parameters:
>>
>>     - make sure super_clone will be removed when done.
>>     - clone file://$pwd/. to super_clone but with different set of options.
>>     - check the commits in super_clone and super_clone/sub.
>>
>> So, the above would ideally become something like
>>
>> do_test 3 3 --recurse-submodules
>>
>> where the helper would look like
>>
>> do_test () {
>>       cnt_super=$1 cnt_sub=$2 &&
>>         shift 2 &&
>>         test_when_finished "rm -fr super_clone" &&
>>         git clone "$@" "file://$pwd/." super_clone &&
>>         git -C super_clone log --oneline >lines &&
>>         test_line_count = $cnt_super lines &&
>>         git -C super_clone/sub log --oneline >lines &&
>>         test_line_count = $cnt_sub lines
>> }
>>
>> Would it rob too much flexibility from future tests to be added to
>> this script if we did it that way?
>
> I think that's an improvement, too. Even if we add further tests, they
> don't have to follow the same format. I would give the function a better
> name than "do_test" though. :P

I thought about implementing this, but I was unsure how much flexibility it
is robbing, as we don't know in which direction we're going to extend the
tests if at all. (Are we testing more options or do we want to inject more
commands like "git submodule update --keep-configured-depth" ?
That kept me away from doing the super short do_test)

Thanks,
Stefan


>
> -Peff
