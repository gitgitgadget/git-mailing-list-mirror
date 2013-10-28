From: Ben Walton <bdwalton@gmail.com>
Subject: Re: [PATCH] Avoid difference in tr semantics between System V and BSD
Date: Mon, 28 Oct 2013 21:04:57 +0000
Message-ID: <CAP30j179XPZqTGiZuvyZEL94Q14ocas+r8mP_R4gLetWwikkwA@mail.gmail.com>
References: <CAP30j17OCrYjsVK+W_TR-g99YmzY3d9TnYfwHXK7+6vPrVjDaQ@mail.gmail.com>
	<1382951633-6456-1-git-send-email-bdwalton@gmail.com>
	<526EA7C8.2020607@kdbg.org>
	<20131028182718.GA4242@google.com>
	<xmqqk3gxfc20.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	git <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 28 22:05:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vatzk-0002O0-GM
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 22:05:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756753Ab3J1VE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 17:04:59 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:45989 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756324Ab3J1VE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 17:04:58 -0400
Received: by mail-qa0-f49.google.com with SMTP id i13so2441141qae.15
        for <git@vger.kernel.org>; Mon, 28 Oct 2013 14:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KBNKwCQ/Mq07R7Zohj1AVnXYRpvYcEQDx2FL8+C71s8=;
        b=Tvtvyn/V6POnWCbs/gmQHSqLeN5YR2MzfFRc5ZPebySodtIJN/Foty7qPI78Kf4fkL
         uoMwTZBRPKwm/Xf88+otwGMm2K4dDVijd/5Yg/Trz+fw/QMWCrj9+xfgwmbG2iK38voM
         /iEeiUoi0rzdjCDOTymoPA9pjKl4muiFn1r7UXdBWgYmbEQCifgTam7vUPxr4ZY76C7h
         u26uKsqGXsAyFzxouiw0uvapWmdvObvUZtdO8FZtCPiaWhdQl/N/2q62GHVu/uTwRCMQ
         XgK4nNEV366xowpkGkoW0U2Tt6fd1bV7XjbcRqH8RSAiK2rJU6v7Uor9Th9rEdn9Td0G
         wDcw==
X-Received: by 10.49.1.230 with SMTP id 6mr32497996qep.48.1382994297972; Mon,
 28 Oct 2013 14:04:57 -0700 (PDT)
Received: by 10.224.189.12 with HTTP; Mon, 28 Oct 2013 14:04:57 -0700 (PDT)
In-Reply-To: <xmqqk3gxfc20.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236861>

I'm happy to defer to your judgement on this - If you'd like the tests
wrapped, I'll do so.

Thanks
-Ben

On Mon, Oct 28, 2013 at 7:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Johannes Sixt wrote:
>>
>>> In other tests, we check for prerequisite PERL, i.e., we are prepared
>>> that perl is not available. Shouldn't we do that here, too?
>>
>> I think the tests assume there's a perl present even when the PERL
>> prereq isn't present already.  E.g.:
>>
>>       nul_to_q () {
>>               "$PERL_PATH" -pe 'y/\000/Q/'
>>       }
>>
>> So in practice the PERL prereq just means "NO_PERL wasn't set", or
>> in other words, "commands that use perl work".  Maybe something
>> like the following would help?
>>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>>
>> diff --git i/t/README w/t/README
>> index 2167125..54cd064 100644
>> --- i/t/README
>> +++ w/t/README
>> @@ -629,11 +629,20 @@ See the prereq argument to the test_* functions in the "Test harness
>>  library" section above and the "test_have_prereq" function for how to
>>  use these, and "test_set_prereq" for how to define your own.
>>
>> - - PERL & PYTHON
>> + - PYTHON
>>
>> -   Git wasn't compiled with NO_PERL=YesPlease or
>> -   NO_PYTHON=YesPlease. Wrap any tests that need Perl or Python in
>> -   these.
>> +   Git wasn't compiled with NO_PYTHON=YesPlease. Wrap any tests that
>> +   need Python with this.
>> +
>> + - PERL
>> +
>> +   Git wasn't compiled with NO_PERL=YesPlease.
>> +
>> +   Even without the PERL prerequisite, tests can assume there is a
>> +   usable perl interpreter at $PERL_PATH, though it need not be
>> +   particularly modern.
>> +
>> +   Wrap tests for commands implemented in Perl with this.
>
> Sounds like a sensible thing to address, but I first parsed it as
>
>     Wrap (tests for (commands implemented in Perl)) with this.
>
> while I think the readers are expected to parse it as
>
>    Wrap ((tests for commands) implemented in Perl) with this.
>



-- 
---------------------------------------------------------------------------------------------------------------------------
Take the risk of thinking for yourself.  Much more happiness,
truth, beauty and wisdom will come to you that way.

-Christopher Hitchens
---------------------------------------------------------------------------------------------------------------------------
