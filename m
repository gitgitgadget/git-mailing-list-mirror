From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Date parsing
Date: Tue, 10 Jun 2008 19:51:19 +0200
Message-ID: <bd6139dc0806101051t5af7d14an57970f305b09173b@mail.gmail.com>
References: <bd6139dc0806100758xb41d08dh18e3051088b707e5@mail.gmail.com>
	 <Zx2uvEYSssjj9E0HrmUL8wYASyWX9L9w8LkR-gGRAmnD9isjoEeyKg@cipher.nrlssc.navy.mil>
	 <bd6139dc0806100831y7a00a0f4sbc8dee9df7a8c16a@mail.gmail.com>
	 <alpine.LFD.1.10.0806100942500.3101@woody.linux-foundation.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Brandon Casey" <casey@nrlssc.navy.mil>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 10 19:52:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6810-0005U1-5A
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 19:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbYFJRvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 13:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbYFJRvV
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 13:51:21 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:51073 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbYFJRvU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 13:51:20 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2688994wfd.4
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 10:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=HHZXEkvYmrWwl1/HgOQtEEFiGG/I4mjbsrzS1BSE9iE=;
        b=neQVplDT4XBkcP5vnLb6+EZPJ92BRRglBqgTStcWLgiM4TdJbOjyW4JVpdq8IrwL59
         JyDsGClej8mcgD6ok7sdXsYG9HsfoUGvemunf0d9jwDEJy1D9rq+Ozu3v0HuQLTgDKZt
         zyhNBxbXq80NeUVy1P1q+6jwMFB8JlX9cFxyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=Lp0Vlx1X0oKTbGNw7IyCNio4uTHFFCGVm3bofXjIT/lnxU1QEnlEL8x9TwfXdax3DR
         1DU5zW6238YFYl8Baqa1legbmMBHo4b/kqIPtP8Vo4BAhpFPiAYzhPW8sH7YQL8glBM6
         2qUdxXCLUoB+MNZ7uu5S9Lw0u8tloZoqwepHE=
Received: by 10.142.153.8 with SMTP id a8mr2168043wfe.316.1213120279479;
        Tue, 10 Jun 2008 10:51:19 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Tue, 10 Jun 2008 10:51:19 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0806100942500.3101@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84532>

On Tue, Jun 10, 2008 at 6:55 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, 10 Jun 2008, Sverre Rabbelier wrote:
>> On Tue, Jun 10, 2008 at 5:10 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>> > Take a look at match_multi_number in date.c
>> > European ordering is preferred when the separator is '.'
>>
>> Ok, then I'll use . in the future, that's nice :).
>
> Well, there are safer ways to give the date.
>
> If you do it in strict rfc822 format, you'll never have any confusion
> what-so-ever. The "approxidate()" thing tries to parse any random input,
> but it *is* meant to be excessively liberal.
>
> IOW, you can literally say "at tea-time two weeks ago" and get a date, and
> it will even work. But you can also say "my 3rd child was born in
> December", and it will also give you a date. The date will not make
> _sense_, but it will give you one (it will decide that what you meant
> is "Dec 3rd").

Ok, so it'll eat anything it can make a date of, that makes sense I
guess, considering what you refer to below.

> So if you want to be precise and safe, you should be precise. I'd
> personally suggest using yyyy-mm-dd, which is the ISO date format,
> although if that fails approxidate will still try the admittedly
> crazy yyyy-dd-mm.
>
> And always set the timezone explicitly if you really care. Again, we try
> out best if you don't explicitly say which timezone to use, but if you
> don't want any guessing - even _informed_ guessing - you really should
> state things explicitly.

I overlooked the fact that in Januari there is no DST, so that my
local timezone would indeed be +1, so it handled it as desired.

>> I think that it should bail out when it encounters "20-01-2008"
>> instead of automagically going for european notation. Even more
>> helpfull would be to inform the user that "20.01.2008" is the proper
>> notation.
>
> See above. git approxidate() tries the exact reverse: it's extremely
> willing to turn absolutely any line noise into a date.
>
> Which is really nice when you do
>
>        git log @{last.week}..
>
> but if you actually want to state an exact date it really means that the
> onus is on _you_ to be exact, and use a well-defined standard format.

Thank you, this explained why it works the way it does very well. I'll
go with ISO notation in the future :).

-- 
Cheers,

Sverre Rabbelier
