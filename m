From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3] submodule deinit: require '--all' instead of '.' for
 all submodules
Date: Wed, 4 May 2016 14:57:59 -0700
Message-ID: <CAGZ79kbUJjqYbY3hC1W0Aw=gR49i4Q0BjY+qM9aiWG5ME89Ruw@mail.gmail.com>
References: <1462321992-15153-1-git-send-email-sbeller@google.com>
	<1462324785-26389-1-git-send-email-sbeller@google.com>
	<xmqqlh3pft91.fsf@gitster.mtv.corp.google.com>
	<xmqqshxxeboj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 23:58:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay4o4-0003YQ-F5
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 23:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983AbcEDV6D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 17:58:03 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:36408 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754955AbcEDV6A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 17:58:00 -0400
Received: by mail-io0-f179.google.com with SMTP id u185so78250398iod.3
        for <git@vger.kernel.org>; Wed, 04 May 2016 14:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=r4l+DBXwASkqOYHXMZQBX75rF81PwEgjmzWyylpWewg=;
        b=HISt1NJ0eWmIHYwm783BFtdZxRpotpyTJvKepcb/EmRaej8gSj28fftzZ5vlW9MNx+
         KJICJdfa/bB4J0TmrkKddlUhIYs9wA/wHg3r822skIybRJ8PJSm9jk9XW1e80FTLcvri
         2eymHDrapc2ulnpfDl+GQjXsn3EgshJqAnN7ZCYqFTPldiKlauIojk9SfC4mfT+GiS1l
         R3MWolN0uRxMNVrLc6WCPG04WrFmChnW7Jbm8KuLpV/fvCo2UvM7rvKwSMO6vUM7swlJ
         F0ZiyKuMHlHJGObCiFpOe6ON87ObNowJbwlNqHctdScTG1MKrkIipPPMk6eCSAuLMZcG
         CeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=r4l+DBXwASkqOYHXMZQBX75rF81PwEgjmzWyylpWewg=;
        b=AguBQ/dvi0RCgey3LeCHWV4cBS3r+0P9TmBtArk2Ss9DSjp0sBrkjK9FcnnwLUeY5W
         9Q0zjYNbe4A0r/LaulgWQrmKf50v4Fw4z/KGorsFmEKG8SklL38X3+4m2qDOCA7YBpD1
         /k2oC5DsdsFHG2eqV1WHh8RhP/7lAnaRSkoaT7qM6w2+1jsiWkkE+U4wmjiIVaxdr1U6
         ILs+bR6HJeCRN0u+UkeM5V50/0HgAtysJ1jAli59btNVktFiSb4awWpeIZiPxCnIesOD
         Bj3sDpqHTBChocHbQopODrVnQvLSw635rKnb58Vu4ZY7MzqdMyerN4hzqv2CzqfrpYOw
         1YAw==
X-Gm-Message-State: AOPr4FX5IZVq28AGhr+ikuL2gbfuOxvLOiJa1QhrG4tpClvAn1m3i/f39gBRbe/o1EYB08anKYjLkUMK2zzU4Cr0
X-Received: by 10.107.161.68 with SMTP id k65mr14970017ioe.110.1462399079227;
 Wed, 04 May 2016 14:57:59 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 4 May 2016 14:57:59 -0700 (PDT)
In-Reply-To: <xmqqshxxeboj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293605>

On Wed, May 4, 2016 at 2:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> +    if test -n "$deinit_all" && test "$#" -ne 0
>>> +    then
>>> +            die "$(eval_gettext "usage: $dashless [--quiet] deinit [-f|--force] (--all | [--] <path>...)")"
>>
>> I doubt that "usage:" wants to go thru l10n.
>>
>> I suspect that it is more friendly to the user to say that in prose,
>> i.e.e.g. "--all and pathspec cannot be given at the same time", than
>> forcing them to grok the (alternative|possibilities).
>>
>>> +    fi
>>> +    if test $# = 0 && test -z "$deinit_all"
>>>      then
>>> -            die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
>>> +            die "$(eval_gettext "Use '--all' if you really want to deinitialize all submodules")"
>>>      fi
>>
>> This is good.
>
> By the way, while it is a very good idea to die upon
>
>         $ git submodule deinit --all no-only-this-one
>
> it may not be too bad if we demoted the output to "info" with clean
> no-op exit when the user said
>
>         $ git submodule deinit
>
> IOW, the latter part _might_ be better if it were
>
>         if test $# = 0 && test -z "$deinit_all"
>         then
>                 echo >&2 "info: not deinitializing anything."
>                 echo >&2 "info: Use --all to deinitialize all submodules."
>                 exit 0
>         fi
>
> given that this is really about preventing mistakes from doing mass
> destruction.

Demote to a new class in a class of its own?

* grep -r "info:" gives no match for user facing code, so it's a
prefix you made up now.
* I assume we want to translate it?
* This would not respect the --quiet option?
* returning 0 as in "everyting is fine", while nothing is fine.
   There are two cases:
     - Either the user knows what they are doing (See Per complaining
about this)
       A very deliberate "I want it all gone or error out if you
cannot remove it all"
     - The user has no idea what they are doing. Exiting non zero
doesn't do any harm.

Maybe:

> -             die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
> +            usage()

instead?
